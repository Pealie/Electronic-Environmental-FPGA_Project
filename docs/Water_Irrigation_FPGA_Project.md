**FPGA-Based Irrigation System for Soft Fruit Farms**

**Introduction**

<p align="center">
  <img src="media/image1.jpeg" alt="Cherry trees under polytunnels" width="60%">
</p>

([[EM007 - FPGA-based Irrigation System for Soft Fruit Farms -
InnovateFPGA]{.underline}](http://www.innovatefpga.com/cgi-bin/innovate/teams.pl?Id=EM007))

**Image:** *Rows of blossoming cherry trees under protective polytunnels
on a Scottish soft fruit farm. Efficient irrigation is crucial in such
environments to prevent water waste and crop disease.*

Soft fruit farming requires a delicate balance of water: too little can
stress the crops, while too much encourages fungal growth and root rot.
Traditional irrigation methods (such as fixed schedules or manual
watering) often lead to significant water wastage and inconsistent soil
moisture. This not only wastes a precious resource but can harm crop
yield and quality. There is a pressing need for smarter irrigation
solutions that deliver water **only** when and where it is needed.

To address this challenge, Team Thomson has developed an **FPGA-based
automatic irrigation system** for soft fruit farms in Scotland. The
project's goal is to optimize water usage by sensing soil moisture in
real-time and activating irrigation **on-demand**, rather than on a
timer. By tailoring water delivery to the actual needs of the plants,
the system aims to reduce water waste, improve crop consistency, and
minimize conditions that foster plant diseases. Moreover, using a
low-power Field Programmable Gate Array (FPGA) as the controller
provides a flexible and cost-effective platform that can be adapted to
different farm sizes and conditions. This article presents a detailed
overview of the system's design, implementation, and the expected
benefits in terms of performance and sustainability.

**Motivation and Background**

Water is a critical resource in agriculture, and efficient water
management is especially important in regions where water scarcity is
emerging as a concern. Even in relatively rainy climates like Scotland,
improper irrigation can lead to problems: oversaturated soils in fruit
farms promote fungus and mould that spoil the produce, while excess
runoff can leach nutrients and cause environmental harm. On the other
hand, under-watering or inflexible irrigation schedules can stress
plants, slowing their growth and reducing yield. Soft fruits such as
cherries, berries, and currants are particularly sensitive to moisture
levels, and farmers must constantly juggle these factors to achieve
optimal growth.

Conventional irrigation systems (e.g. simple timers or manual control)
do not account for daily variations in weather and soil condition. For
example, a timed system might operate during a rainstorm, or fail to
respond quickly during unexpected hot, dry spells. This lack of
responsiveness leads to water being used when it's not needed and not
used when it *is* needed. Studies have shown that precision irrigation
methods can dramatically improve efficiency -- modern smart irrigation
systems can cut water consumption by up to 50% compared to traditional
methods. This not only conserves water but also reduces energy usage (by
running pumps less) and labour for farm workers. These factors motivated
the development of an automated irrigation solution that continuously
adapts to the crop's needs.

Another motivation is the push for sustainable agriculture and climate
resilience. Agriculture globally is under pressure to reduce its
environmental footprint. By avoiding overwatering, farmers can prevent
problems like soil nutrient runoff and erosion, and also avoid the
emission of greenhouse gases from waterlogged soil. Optimizing
irrigation is thus a key step toward more sustainable farming practices,
aligning with global efforts to conserve resources and protect the
environment.

**System Architecture and Design Overview**

The **FPGA-based irrigation system** is built around the Intel **Cyclone
V SoC FPGA** on the Terasic DE10-Nano development kit. This platform was
chosen for its low power consumption, flexibility, and the integration
of a Hard Processor System (HPS) -- a dual-core ARM Cortex-A9 processor
-- alongside the reconfigurable FPGA fabric. The design takes advantage
of both aspects of this System-on-Chip: the FPGA fabric interfaces with
sensors and controls the pump in real time, while the HPS (running
embedded Linux) can handle higher-level tasks like network
communication. Figure 1 below illustrates the high-level architecture of
the system.

**Sensor and Analog Front-End:** At the heart of the system is a
**capacitive soil moisture sensor** that is inserted into the soil near
the crop roots. As the soil moisture changes, the sensor's output
voltage changes correspondingly (low voltage when soil is dry, higher
when moist or saturated). This analog signal is conditioned and
amplified by an Analog Devices CN0398 evaluation shield, which is an
Arduino-compatible sensor board for smart agriculture. The CN0398 shield
includes an on-board **Analog-to-Digital Converter (ADC)** (the
AD7124-8, a high-precision analog front-end) that continuously converts
the moisture sensor's analog voltage into a digital reading. The shield
can also accommodate additional sensing capabilities (such as measuring
soil **pH** and temperature), though the primary focus in this project
is soil moisture.

**FPGA Controller:** The digital moisture data from the ADC is fed into
the FPGA on the DE10-Nano through standard SPI communication lines on
the Arduino header. The FPGA is programmed with custom logic (written in
Hardware Description Language, e.g. VHDL/Verilog) that implements a
simple control algorithm: when the soil moisture reading falls below a
defined threshold (indicating dry soil), the FPGA asserts a control
signal to activate irrigation. This control signal drives a relay (or
transistor) that switches on a water pump supplying the drip irrigation
lines for that field. Once the soil sensor detects that moisture has
reached the desired level (surpassing a higher threshold), the FPGA
logic deactivates the pump via the relay. In essence, the FPGA acts as a
dedicated real-time controller that turns the water **on** and **off**
based on sensor feedback. The moisture threshold values (for "dry" vs
"sufficiently wet") are configurable and may be adjusted based on the
crop's needs or seasonal conditions. For initial calibration, farmers or
developers can gather sensor data to determine what raw moisture
readings correspond to dry, optimal, and saturated soil for their
specific soil type; these values inform the threshold settings in the
FPGA logic. By using two threshold levels (a lower trigger to start
watering and an upper limit to stop watering), hysteresis is introduced,
which prevents the pump from rapidly toggling on and off around a single
threshold value.

**Additional Sensors and Expansion:** The architecture is designed to be
modular. The DE10-Nano board supports add-on sensor expansion through
its General-Purpose IO (GPIO) pins and interfaces. In this project, a
Terasic *RFS sensor expansion board* is used to attach the moisture
sensor and shield to the FPGA board. This expansion board makes it easy
to connect multiple sensors if needed. The system can be extended by
stacking multiple Analog Devices CN0398 shields or similar sensor
modules, each addressing a different sensor (for example, multiple
moisture sensors across different locations in a field, or moisture plus
pH sensors). The FPGA has ample I/O and logic resources to handle
multiple input channels and control multiple outputs (pumps or valves)
in parallel. In comparison to using discrete microcontrollers for each
sensor, a single FPGA can coordinate many sensors and actuators
simultaneously with precise timing, which is ideal for managing
irrigation in larger farms or multiple fields.

**Cloud Connectivity (IoT Integration):** A notable feature of the
design is the planned integration with cloud services for monitoring and
control. The on-board ARM processor (HPS) running Linux can connect to
the internet via a Wi-Fi module (such as an Analog Devices Wi-Fi shield)
or an Ethernet link. The project envisions using Microsoft Azure IoT
Central as a platform for aggregating sensor data and remote management.
By sending soil moisture readings and pump status to an Azure IoT hub,
farmers could monitor their fields in real-time from anywhere and gain
insights through cloud analytics. Conversely, cloud connectivity would
allow remote configuration of the FPGA's parameters (for instance,
adjusting moisture thresholds or scheduling watering times for specific
conditions) without needing physical access to the device. Azure IoT
Central provides ready-made templates for such applications, reducing
the need for building a cloud application from scratch. In this design,
the FPGA handles the time-critical control locally (so irrigation will
not be dependent on an internet connection), while the HPS can
asynchronously upload data and check for updates or commands when
connectivity is available. This edge-cloud synergy ensures reliability
(the crops are watered even if the network is down) and provides
advanced capabilities when online. Additionally, cloud connectivity
enables features like alerting: for example, if a sensor fails or a pump
does not respond, the system could send an alert via the cloud to notify
the farmer for maintenance.

**Power Supply Considerations:** The entire setup is designed with low
power consumption in mind, leveraging the Cyclone V FPGA's efficiency.
It can run off-grid if necessary -- for instance, powered by a suitably
sized solar panel and battery. This is particularly useful for farms
where mains power infrastructure is not readily available in all fields.
A solar-powered FPGA controller makes the installation cheaper and more
sustainable, and further reduces the carbon footprint by using renewable
energy. The ability to operate on solar power complements the system's
goal of sustainability, ensuring even remote or off-grid farms can adopt
the technology without extensive infrastructure.

**Implementation and Prototype Development**

Developing the FPGA-based irrigation system involved both hardware
assembly and FPGA logic design, followed by testing in a controlled
environment. The prototype was built on a bench using the Terasic
DE10-Nano kit, the CN0398 moisture sensor shield, the RFS expansion
board, and a small water pump with a relay module.

On the **hardware side**, assembly was straightforward: the CN0398
Arduino shield plugs into the DE10-Nano's Arduino-compatible headers,
establishing the SPI connection between the ADC and the Cyclone V FPGA.
The capacitive moisture probe is connected to the CN0398 shield's input.
A relay switch (controlled via one of the FPGA's digital output pins)
was wired to the DE10-Nano's GPIO to control the pump. In the bench
prototype, an LED was also used in place of the pump at first, to
visually verify when the FPGA would activate the "pump" signal. The team
also integrated a simple temperature sensor and considered a rain
detector as possible extensions, although these were not the primary
focus for the initial prototype.

For the **FPGA logic**, the design was described in VHDL and synthesized
using Intel **Quartus Prime** design software. Quartus Prime was
instrumental in compiling the design and ensuring that timing
requirements were met for the sensor interface. The FPGA logic includes
an SPI interface core to communicate with the ADC on the CN0398 shield,
a small state machine to read the moisture value periodically, and a
comparator module that checks the moisture reading against the
predefined thresholds. When the moisture falls below the "dry"
threshold, the state machine sets a pump activation flag, which is
mapped to the physical output pin driving the relay. When moisture rises
above the "wet" threshold, the flag is cleared and the pump is turned
off. This hysteresis loop prevents rapid switching and ensures the soil
is watered to an optimal level before stopping.

During development, the team made extensive use of simulation and
verification tools. They used ModelSim (via the Quartus Prime integrated
edition) to simulate the VHDL logic, feeding it test input waveforms
that mimicked sensor readings over time. This allowed verification that
the relay control would behave correctly -- for example, that noise or
minor fluctuations around the threshold would not cause unintended
toggling. The simulation helped fine-tune the threshold values and
timing (e.g. how frequently the sensor is read, and how long the pump
stays on once activated). **Hardware-in-the-loop testing** was then
performed by downloading the design to the DE10-Nano and observing the
system's response with a real sensor in varying conditions (simulated by
wetting or drying the sensor). The outputs from the FPGA were monitored
with an oscilloscope and logic analyzer to ensure signal integrity.
Minor adjustments were made to debounce the sensor readings and to
calibrate the ADC conversion scale to actual moisture percentages.

The embedded ARM processor was configured with a lightweight Linux
distribution (using the DE10-Nano's provided Linux image). A Python
script was developed to run on the HPS, which periodically reads the
moisture value from the FPGA (through a memory-mapped register interface
or via the SPI bus) and sends the data to the Azure IoT Central service.
This script also listens for any incoming configuration commands. The
team leveraged Azure's dashboard to visualize soil moisture trends over
time and set up basic alerts (for example, an alert if moisture stays
below the threshold for an unusually long time, indicating perhaps that
the water source is empty or the pump failed).

One challenge addressed during implementation was **noise and signal
stability**. Real-world soil moisture sensors can have noisy readings
due to temperature changes, soil heterogeneity, or electrical
interference. To handle this, the FPGA logic includes a simple filtering
mechanism: it averages a few consecutive readings or implements a short
delay before turning off the pump to ensure the soil is adequately wet,
as a form of debouncing. Additionally, the analog front-end on the
CN0398 shield provides some hardware filtering and calibration
capability -- the team calibrated the ADC such that the digital readings
correspond to known moisture levels (by testing the sensor in dry air vs
fully submerged in water to get the range).

By the end of the prototyping phase, the FPGA-based controller was
successfully operating the pump relay based on sensor input, and data
was being logged to the cloud. The system was then ready for deployment
in a small test plot on an actual soft fruit farm to evaluate its
performance in the field.

**Performance, Scalability, and Expected Results**

From a performance standpoint, the FPGA-based irrigation controller
meets the expectations of responsiveness and stability. The pump
activation is instantaneous when the dry threshold is crossed -- far
faster than a human could react, and adequately fast for irrigation
needs (in the order of milliseconds). The control loop is also
**reliable** due to its simplicity; running on dedicated hardware logic,
it is not subject to crashes or slowdowns as a more complex software
system might be. This reliability is crucial for agricultural
deployments where downtime could mean crop damage. The long-term
stability of the system is anticipated to be high, as FPGAs can run for
years in embedded applications with minimal maintenance.

A key advantage of using an FPGA is the **scalability** of the design.
The project is initially tailored for a single field or zone, but the
design can be expanded to handle multiple zones or even multiple farms.
The Cyclone V FPGA has plenty of capacity to replicate the moisture
sensing and control logic for several independent sensors/pumps. This
means one FPGA board could potentially manage irrigation for multiple
fields, each with its own moisture threshold settings suitable for
different crops or soil types. In practice, the number of sensors and
pumps an FPGA can control is limited only by the I/O available and the
complexity one is willing to implement. If a single board were not
enough, the system can also scale **horizontally**: additional DE10-Nano
kits could be deployed across a large farm, each covering a section, and
these units could communicate over a farm network or via the cloud to
coordinate irrigation schedules and share data.

The system's design takes into account that different fields or crop
varieties may have different watering requirements. For example, one
field might contain raspberries which prefer consistently moist soil,
while another has cherries which are more drought-tolerant. The FPGA
controller can be programmed with different threshold pairs for each
field's sensor. This flexibility maximizes crop yield and quality
because each crop can be given the optimal amount of water. It also
minimizes waste, since no area gets more water than it needs. Over time,
farmers can compare the **crop yield per unit area** before and after
implementing this FPGA-controlled irrigation. One expected metric is an
**increase in yield** (or at least maintaining yield with less water)
due to more consistent watering. Another metric is a **decrease in water
usage** (litres per season per field) compared to previous traditional
irrigation practice. These performance metrics will validate the
effectiveness of the system.

To evaluate success, baseline data such as historical water consumption
and crop yield can be used. If, for instance, a farm used to consume a
certain volume of water and lose a percentage of crop to rot due to
overwatering, those numbers should improve. The expectation is that
water use will drop significantly (in line with earlier predictions of
up to 30--50% savings) and yield or quality of the fruit will improve
thanks to reduced water stress and less disease pressure. The system
also reduces labour -- farmers or farm workers spend less time manually
checking soil or adjusting irrigation, freeing them to focus on other
tasks.

In terms of **maintenance and reliability**, the inclusion of cloud
monitoring means issues can be detected proactively. For example, if a
moisture sensor malfunctions (perhaps giving a constant reading or no
reading), the cloud dashboard would show an anomaly and an alert can be
generated. Similarly, the system could use the cloud connection to warn
if a pump has been running longer than expected without raising moisture
(which might indicate a leak or empty water reservoir). This allows
timely maintenance, ensuring the system continues to perform as expected
in the long run. As the project moves from prototype toward a deployed
solution, these considerations of reliability, ease of maintenance, and
user-friendly monitoring become as important as the core functionality
of watering plants.

**Sustainability Impact and Benefits**

One of the driving motivations behind this project was to enhance the
sustainability of agricultural irrigation. The anticipated **resource
savings** and environmental benefits from the FPGA-based irrigation
system are substantial:

- **Water Conservation:** By only irrigating when necessary and
  precisely as much as needed, the system prevents overwatering and
  saves vast amounts of water over time. This is valuable not just for
  the farm's operating cost, but also for regional water resources. In
  water-scarce areas or during drought periods, such savings can make
  the difference in preserving crops. Over many seasons, the cumulative
  water saved by smart irrigation could be enormous, directly boosting
  the farm's sustainability. Additionally, as more sensor nodes are
  added across a farm, the irrigation can be tuned on a micro-climate
  level, fully optimizing water use across different soil patches or
  crop varieties. This granular approach ensures that every drop of
  water is used effectively to grow crops, and none is wasted due to
  arbitrary scheduling.

- **Energy and Cost Savings:** Running pumps only when required
  translates to lower energy consumption. Pumps are often one of the
  larger consumers of electricity on a farm; by halving or significantly
  reducing pump active time, the system cuts down on the farm's energy
  bills and carbon footprint. In cases where the system is
  solar-powered, the irrigation becomes even more sustainable, using
  renewable energy for operation. Less pumping not only means energy
  savings but also reduces wear-and-tear on the pumping equipment,
  potentially lowering maintenance costs. Furthermore, water utilities
  expenses drop when less water is drawn. These cost savings make the
  farming operation more economically sustainable and can offset the
  investment in the technology within a few seasons.

- **Labour Efficiency:** Automation of irrigation means farmers and farm
  workers spend far less time manually inspecting fields and turning
  pumps on or off. This saved labour can be redirected to other
  important tasks on the farm, improving overall productivity. It also
  reduces the risk of human error (for instance, forgetting to turn off
  a pump can be costly in water and crop damage). By entrusting routine
  irrigation to the automated system, farming becomes less
  labour-intensive and more technologically managed, which is
  increasingly important as farms strive to do more with fewer available
  workers.

- **Improved Crop Health and Yield:** Optimal watering directly
  correlates with healthier plants. Crops that receive neither too
  little nor too much water tend to have stronger root systems and are
  less prone to stress. In soft fruit farming, correct moisture levels
  can reduce the incidence of conditions like fruit splitting or fungal
  infections (e.g. gray mould on strawberries or cherries). Because the
  system avoids wetting the plants unnecessarily (especially if drip
  irrigation is used in tandem), foliage stays drier which also curtails
  fungal disease spread. Overwatering is known to be a constant strain
  on the soil and plants; it can cause root hypoxia (lack of oxygen) and
  promote disease. By eliminating overwatering, the system helps ensure
  that plant diseases are minimized, leading to less crop loss. Over a
  full season, this could mean a higher percentage of marketable fruit.
  In the long term, the consistency provided by automated irrigation may
  also improve the uniformity and quality of the produce, since each
  plant is getting an optimal environment.

- **Soil Health and Erosion Prevention:** One of the often overlooked
  benefits of controlled irrigation is the protection of soil health.
  When water is applied in just the right amount, it largely stays
  within the root zone and gets taken up by the plants. Excess water, on
  the other hand, can percolate downward or run off, carrying away
  topsoil and nutrients. By preventing habitual overwatering, the FPGA
  system helps prevent **soil erosion**. Preserving topsoil is critical
  for sustainable farming because it maintains the land's fertility for
  future seasons. Soil erosion is a serious long-term threat; once
  fertile topsoil is lost, it's hard to regain, and productivity drops.
  The system's approach of small, needed doses of water ensures the soil
  structure remains intact and nutrients are not washed out.
  Additionally, better moisture management means the soil retains its
  organic matter. Overwatering can lead to the release of soil organic
  carbon (as runoff or as greenhouse gases from anaerobic decomposition
  in waterlogged conditions). By avoiding these conditions, the system
  helps keep carbon sequestered in the ground, which is beneficial for
  the climate. In essence, the irrigation controller contributes to
  maintaining a healthy soil ecosystem, which is the foundation of
  sustainable agriculture.

- **Reduced Risk of Flooding and Pollution:** In regions where heavy
  rainfall might coincide with irrigation, smart control can mitigate
  flooding risk on fields. If the soil is kept at optimal moisture, it
  has more capacity to absorb rainwater without immediately generating
  runoff. Healthy, well-structured soil (improved by not overwatering)
  acts like a sponge, reducing the likelihood of flash flooding on the
  farm. This also means fewer nutrients and agricultural inputs running
  off into local waterways. By preventing waterlogging, the system
  indirectly reduces the emission of greenhouse gases such as methane
  (which can be produced in oxygen-deprived, waterlogged soils) and
  nitrous oxide (from denitrification processes in over-saturated soil).
  All these factors contribute to a lower environmental impact for the
  farm. In the bigger picture, widespread adoption of such optimized
  irrigation could improve watershed health, as farmers collectively
  make **"more crop per drop"** and reduce the strain on local water
  sources.

In summary, the FPGA-based irrigation system not only benefits the
individual farm by saving water, energy, and labour while improving
yields, but it also promotes broader environmental sustainability. It
encourages an **optimum biogeochemical cycle** on the farm -- water,
soil nutrients, and plant growth remain in harmonious balance, which is
a key principle of sustainable agriculture. The farm becomes more
resilient to climate variability (since it uses water efficiently during
droughts and avoids exacerbating problems during wet periods), thereby
securing farmers' livelihoods in the long run.

**Conclusion and Future Outlook**

Implementing an Intel FPGA-based smart irrigation system as described in
this project can significantly modernize agricultural water management.
By automating and optimizing the irrigation process, the system ensures
that water is used judiciously, reducing wastage and likely increasing
crop yields. This is a tangible benefit for traditional farming
operations and also holds promise for innovative farming models like
**vertical farming** or greenhouse operations, where precise control of
inputs is crucial. In arid regions of the world where water resources
are extremely scarce, such technology could be a game-changer, enabling
successful cultivation with minimal water.

Beyond the immediate farm-level advantages, the project carries a vision
for **open innovation** in sustainable agriculture. The FPGA logic and
system design developed by Team Thomson is intended to be made available
as open-source intellectual property (IP). This means other developers,
researchers, or organizations can reuse and adapt the design for their
own irrigation solutions at little to no cost. The accessibility of the
design could spur wider adoption, especially by service providers or
NGOs working in rural development. Low-income or remote farming
communities could benefit from a ready-made, low-cost solution to
improve their water usage efficiency.

Looking ahead, one can imagine deploying this kind of system in regions
currently lacking reliable internet or power infrastructure. With
upcoming technologies like SpaceX's Starlink satellite internet and
innovative projects for extending connectivity (such as aerial fibre
project by Meta), even remote farms will likely have access to cloud
services in the near future. When that happens, the cloud-integration
aspect of this FPGA irrigation system will become even more powerful --
allowing farmers everywhere to monitor and control irrigation through
the internet. This aligns the solution with the broader trend of
Internet of Things (IoT) in agriculture, often termed 'smart farming' or
'precision agriculture.' By contributing a design to this movement, the
project plays a small but vital role in helping farms adapt to climate
change and resource constraints.

In conclusion, the FPGA-based irrigation system for soft fruit farms
exemplifies how modern electronics and computing can intersect with
agriculture to yield sustainable outcomes. The project demonstrates that
by using a flexible FPGA controller, one can create a robust, responsive
irrigation system tailored to the crops' needs. The result is a win-win:
healthier crops and higher yields for the farmer, and conservation of
water and soil for the environment. As the design matures and
potentially scales up, it could be deployed across various types of
farms and geographies, making agriculture smarter and more sustainable.
This initiative underscores the importance of innovation in securing our
food systems against the challenges of the 21st century, proving that
technology like FPGAs can indeed help sow the seeds of a greener future.

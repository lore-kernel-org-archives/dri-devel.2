Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E547AC98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA3710E182;
	Fri, 25 Sep 2026 15:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A76AFH0E";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C258B10E182
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJqhEK77IuUpqfk9akUoj7f9f6I9Z7944Pda+Amc8RrHnsj2VB4YGTfYMkEWqRVgUmgey/gJvvU72DnjHSEzckaVN1d+aEofgspg7gbjPZv965PPU6OdXNO0OhEyhZTj8T2zW9Vm4UJUmbgVTFZydqEuG8YDHAigId85274m0BKv4zpVbJNWFPe+1ZsMJRY6XguAuAeMNwvFgTaINPXxoxDBT1min0Tzx2c+7nwNtHg/N4teOBanr2JZ/4zfCQ6uwSpTrTzXhz4/7O4bZbLVP9uU7hc/Dv8YzM0d8eWjcBuB6Ej/3OvTF+MchHyH0iBmQkzjT9SC/XUD9eo1ForCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5duvXJCpdkzgeg0m7NZbBlKXP+NQJKZrCGj9bvrYkfg=;
 b=Fi4xsJ7zqaQf7U984f10xRvVHPz27ohV3IrEIXbZ1IItfCE7s1jTsYujHhNModE1w2JOR7LOtY6gd/bVUXpTFqFnzz/77HWT3gHWOlwmqn2wKdMfJHCA0E/mlAw8/ACrHCTy/4iFmB7TGCys0kW16ZJtbbUd4/2wNV8kmbUmhZ+AfGvKugOxuwGuGc2y9uzEmi+1+mQZpvGmC/AqrT6NI//k3Z2bONT1vDct3WlP2U2d6qulxtZLAAk4r2YMj9WlpzKqU5BgI25jZc2eLh7aFvBwLpeGFjnHGsqMcavZ1WFwQ6B6tvp6iCIRvuYnlROh+YoU+hA5sNZ4t3IzTSPfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5duvXJCpdkzgeg0m7NZbBlKXP+NQJKZrCGj9bvrYkfg=;
 b=A76AFH0EWlqgafJo8z+sbnJ+clWLAuA5oEhbUichq9lMzpA6xvsHUSxK96BCO3QO580XrmgF1cStd58M4TG94oalqQTk7qD2RXfHphVOOGiwCO6akh4pex5rxw/nGieyt+YmdUEw72/OLKlHsuSsKoqTeWWTqKNkkR7YbXpbDkI=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 15:57:06 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::5c) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 15:57:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 15:57:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 10:57:04 -0500
Received: from xsjssw-mmedia4.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Fri, 25 Sep 2026 10:57:04 -0500
From: Vishal Sagar <vishal.sagar@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Chen-Yu Tsai <wens@csie.org>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, Anatoliy Klymenko
 <anatoliy.klymenko@amd.com>, <varunkumar.allagadapa@amd.com>, Michal Simek
 <michal.simek@amd.com>
Subject: [RFC] drm: Aggregating FPGA display pipelines into a single DRM device
Date: Fri, 25 Sep 2026 08:56:58 -0700
Message-ID: <20260925155658.3108388-1-vishal.sagar@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 16051186-4993-412f-20dd-08df1b1da60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|30052699003|13003099007|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: HGbKbLUme2Z8w9aqGb0DWWP7y/wLLhErnAFmfaWjrdMXWhRxPIVdf2GuJ/6DjofPxXfhyRa+/iFnLEuzjKx5+Z4nHiraBPGYQI7aQQOn/ks0BIA7FQttJGlkZXSob0cYh1vAcI1tPsJLRHR7ieBnPSNqw+wB4Tu54hIxwTd4patijcr8T309oyfovsX5nAIgv1WPH1Oc/WbwQLbdYDk0cMacHbKAM8aeT0I+ZY8CxBhlgKMn+PSF4GPkUYmr+07JimErNKW2dAox/jZFraBdYvsv9w75TuZ5Ee2OPEf+dSaQnRq0q4z24202Jo42JLN/irJpvY4T46vfFkQayHJw0jDQnyV8+SuktWmZTUWMa7061x7nKv70Qwa8lBlgz0MrG5fEH5rmO9N5qVQYmI4Ewb1xaVnX3fEQw6/IUl4fBu4uk0Zl5/Y2nRs4qhpe16WvHam3z2m3WzQEWJn/yTf2oQdLs5VaeK1qSe7I0rTMHlAUrZe8dUw3Ju6P6r6wLMml/OtAl0n1wnDESubHVEiJ/JtrexeomgyL/EE9lofRXw8wOJ2uVgC5XeDAtz2GHPvAAdHL49tsJT4Lg3TE99yOGAMO+vD8WLaN9OZjdOnUHYJ0fTypSvBoNRgiTY7MC0tphbMLpNibN+78umhqTYW3ZsM6iZ9CLBFv1Hi4mB8NjSzPNUPVh3+U8awwyh6oswQONvIydhOeX6tXtAqj8cfOhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(30052699003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULbZrllcbZeJguSvwTmcBh1/mud9C52QBx240QCxy8MV1kYtGfUDx4MaeK9Ke8C8aOqpHyCJXQwJsOZVQNtOu84iFREUjZbqIcCdYPsj5scfzb3C3ODuLVOW5uP3AENkInVZgR7hgndoPaoLvvN/yDlbAHZcHvrjEezIu++GaZNEXRrlgZf4Boo/P6SEwVK47xTXNQyKWKEo+gdtu4aSE/1mDPnWELc1pxnow6OwiulJfoalp84A3LvRG1aiI6hbCc5FZFW/73RGlz/+cKirBH0ia/z87wyTEizTBtbNrtaDViWhnfevbZOlBH/nCfmtVaaCHbLt/x9CaWGpEMhFgOorCOuvEhK2GhXGY1j7PEhfr9Ka5qyGdTtC5aWkfZCkxn2s7guCqZNAhFeSrvzcarMx8NMqPwkEKbMfOWu/v1fi1z+C0xTO0H3MnoQ6fVAr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:57:06.3163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16051186-4993-412f-20dd-08df1b1da60a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi all,

A display pipeline in a field-programmable gate array (FPGA) is built
from individual intellectual property (IP) cores.  The designer chooses
the blocks and their connections, so the pipeline can differ from one
bitstream to another.  Each block can have its own device tree node and
driver, while several blocks need to operate as one Direct Rendering
Manager (DRM) device.

We propose a parent device tree node to group the blocks that make up a
display subsystem.  A driver for that node would use the component
framework to assemble them into one DRM device.  This RFC asks whether
that is a suitable representation for upstream, and whether the driver
support could be shared beyond FPGA-based systems.


1. Hardware blocks and interfaces
=================================

The examples use the following blocks.  AXI4S means AXI4-Stream, the
streaming interface. Native video carries pixels alongside
active-video and sync signals, with a video clock.  These are
different interfaces, so the chosen transmitter configuration matters.

  VMIX      Video Mixer.  Blends video layers into an AXI4S output.
            https://docs.amd.com/r/en-US/pg243-v-mix
  FBRD      Video Frame Buffer Read.  Uses direct memory access (DMA)
            to read frames from memory and produce AXI4S video.
            https://docs.amd.com/r/en-US/pg278-v-frmbuf
  TPG       Video Test Pattern Generator.  Produces AXI4S test video.
            https://docs.amd.com/r/en-US/pg103-v-tpg
  A2N       AXI4S to Native Video converter.  Documented as AXI4-Stream
            to Video Out (PG044); combines stream pixels with timing.
            https://docs.amd.com/r/en-US/pg044_v_axis_vid_out
  VTC       Video Timing Controller.  Supplies the output video timing.
            https://docs.amd.com/r/en-US/pg016_v_tc
  CLK       Clocking Wizard.  Generates clocks for the illustrated
            video path (PG065).
            https://docs.amd.com/r/en-US/pg065-clk-wiz
  DPTX      DisplayPort Transmitter Subsystem.
            https://docs.amd.com/r/en-US/pg199-displayport-tx-subsystem
  HDMITX    High-Definition Multimedia Interface (HDMI) Transmitter
            Subsystem.  PG235 covers HDMI 1.4/2.0.
            https://docs.amd.com/r/en-US/pg235-v-hdmi-tx-ss
  SWITCH    AXI4-Stream Switch.  Routes streams between interfaces;
            documented in the AXI4-Stream Infrastructure IP Suite
            product guide (PG085).
            https://docs.amd.com/r/en-US/pg085-axi4stream-infrastructure

These blocks can be instantiated separately.  The design determines
which are present and how they connect.  The aggregation question is
not specific to these IP cores or to one FPGA vendor.


2. Example pipelines
====================

VMIX, FBRD and TPG produce AXI4S video.  Transmitters can be configured
for AXI4S or native-video input.  The native paths illustrated here use
an A2N converter, timing from VTC and a clock from Clocking Wizard.
VTC supplies timing to the converter; it does not carry the video data.
Clock sources depend on the design and transmitter requirements.

The examples below distinguish these interfaces.  They illustrate
possible arrangements, not configurations supported by every IP version.
Reset and control connections are omitted.  A CRTC represents a timed
scanout pipeline, which may be implemented by several of these blocks.

(a) One scanout pipeline with a native-video transmitter input.

                       VTC
                        | timing
                        v
    FBRD --AXI4S--> [   A2N   ] --native--> DPTX --> display
                        ^
                        | video clock
                       CLK

    CLK also supplies the VTC video clock.  Clocking for the native
    transmitter interface must match the configured video mode.

(b) Multiple layers blended by a mixer, with AXI4S throughout.
    The HDMI transmitter is configured for AXI4S input.

    FBRD_0 ----> +------+
    FBRD_1 ----> | VMIX | --AXI4S--> HDMITX --> display
    TPG    ----> +------+
       AXI4S

(c) Two outputs intended to form one DRM device with two CRTCs.
    One output uses native video; the other uses AXI4S directly.

                           VTC
                            | timing
                            v
    FBRD_0 --> VMIX_0 --> [ A2N ] --native--> DPTX --> display 0
                            ^
                            | video clock
                           CLK

    FBRD_1 --> VMIX_1 --------AXI4S---------> HDMITX --> display 1

    All links before A2N are AXI4S.  CLK also clocks VTC as in (a).
    These outputs need not have a video-data link between them.

(d) Separate AXI4S sources feeding separate stream inputs on a
    DisplayPort transmitter configured for multi-stream transport.

    TPG  --AXI4S--> +------------------+
                   | DPTX stream 0/1  | --> display 0, display 1
    FBRD --AXI4S--> +------------------+

(e) An AXI4S Switch selects routes to two AXI4S-input transmitters.
    Routing can change at runtime if configured for register control.

    FBRD_0 --> +------+
    FBRD_1 --> | VMIX | --> +--------+ --> DPTX   --> display 0
    TPG    --> +------+     | SWITCH |
    FBRD_2 ---------------> +--------+ --> HDMITX --> display 1

    All links into and out of SWITCH carry AXI4S video.  It selects
    stream routes; it does not blend pixels as the mixer does.

The available planes, CRTCs and outputs differ between these designs.
The common requirement is to assemble the selected blocks into a DRM
device without assuming one fixed pipeline topology.


3. Describing which devices belong together
===========================================

The device tree graph describes connections between blocks.  A display
driver can walk those connections, but it still needs rules for where
its device starts and ends.  A link to an output bridge, for example,
does not mean that bridge must become a component-framework member.

Choosing one source as the master works for some pipelines.  With two
sources feeding a common transmitter, following only downstream links
from one source does not discover the other.  A broader traversal can
find both, but still needs to decide which blocks to include.  Separate
outputs, as in (c), may have no video link between them at all.

The proposal is to describe that grouping explicitly rather than make
it depend on which source the driver starts from.  The graph would
continue to describe the video connections, including bridge chains.
The grouping would identify the display subsystem to assemble.


4. The proposal
===============

A device tree node that groups the pipeline's IP nodes as its children:

    display-pipeline {
        compatible = "display-pipeline";
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        fbrd0: dma@a0010000 {
            compatible = "...,v-frmbuf-rd";
            reg = <0x0 0xa0010000 0x0 0x10000>;
            clocks = <&misc_clk 0>;

            port {
                fbrd0_out: endpoint {
                    remote-endpoint = <&vmix_in0>;
                };
            };
        };

        vmix0: video-mixer@a0020000 {
            compatible = "...,v-mix";
            reg = <0x0 0xa0020000 0x0 0x10000>;
            clocks = <&misc_clk 1>;

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                    reg = <0>;

                    vmix_in0: endpoint {
                        remote-endpoint = <&fbrd0_out>;
                    };
                };

                port@1 {
                    reg = <1>;

                    vmix_out: endpoint {
                        remote-endpoint = <&dptx_in>;
                    };
                };
            };
        };

        dptx0: display@a0100000 {
            compatible = "...,dp-tx-subsystem";
            reg = <0x0 0xa0100000 0x0 0x40000>;

            port {
                dptx_in: endpoint {
                    remote-endpoint = <&vmix_out>;
                };
            };
        };
    };

This is a structural sketch, not a complete binding example. The
compatible strings are placeholders, and per-IP properties are omitted.
The transmitter here uses AXI4S input, so there is no native-video
converter or external video timing controller in this example.

The parent would describe the display subsystem without a register
interface of its own.  Each child would follow its IP binding.

On probe, the aggregate driver would populate the children with
of_platform_populate(), build a match list for the supported display
components, then call component_master_add_with_match(). Its bind
callback would allocate the drm_device, call component_bind_all() and
register the assembled device, with corresponding cleanup on unbind.

Not every child needs to become a component-framework member. Clock
and reset providers would retain their normal interfaces, as would
output bridges used through the DRM bridge framework.  The match list
would distinguish those devices from the components being bound.

The graph endpoints would still describe connections. Aggregation
would not replace the individual drivers or the frameworks they use.


5. The hardware boundary
========================

The intended grouping comes from the FPGA design, not from the order in
which Linux probes the devices.  A designer can place the display blocks
in a hierarchy that represents the display subsystem.  The device tree
generation flow can preserve that boundary along with the individual
IP nodes.

Design hierarchy alone may not be sufficient grounds for a new device
tree node.  The question is whether this particular grouping describes
a meaningful hardware subsystem, and whether children or phandles are
the better way to represent it.


6. Alternatives considered
==========================

- A grouping node with phandles to the components.  This preserves
  their placement under existing buses and can be generated from the
  hardware design just as child nodes can.  Child nodes express the
  hierarchy directly and provide address scoping through ranges, but
  phandles remain an option where reparenting would be inappropriate.

- Discover components through the graph without a grouping node.
  This works when a driver has known entry points and traversal rules.
  The question is how to define those rules across different designs,
  including disconnected outputs intended to share one DRM device.

- Use the auxiliary bus or device links.  The auxiliary bus supports
  splitting a device into functions; device links and fw_devlink manage
  dependencies.  Neither by itself defines the display grouping, though
  dependency handling would still be needed alongside aggregation.

- Reuse FPGA region semantics.  The fpga-region.yaml binding under
  Documentation/devicetree/bindings/fpga/ supports child devices and
  address translation.  A region describes a fabric programming
  boundary, however, and may contain several display pipelines and
  unrelated devices.  That boundary need not match a display subsystem.


7. Precedent
============

Allwinner's display engine provides a relevant comparison.  The binding
under Documentation/devicetree/bindings/display/, named
allwinner,sun4i-a10-display-engine.yaml, states:

    The display engine pipeline (and its entry point, since it can be
    either directly the backend or the frontend) is represented as an
    extra node.

That node has no register interface of its own.  Its allwinner,pipelines
property references frontend or mixer entry points, not every member of
an explicit component list.  It also uses phandles rather than placing
the components beneath the node.

This is precedent for a separate display-subsystem node, but not for the
exact parent-child arrangement proposed here.  The choice between
children and phandles is one of the points on which feedback is needed.


8. A common approach for FPGA and SoC display drivers
=====================================================

It would be useful to make this approach available to system-on-chip
(SoC) display drivers as well.  Although their hardware blocks are fixed
in silicon, those blocks can also have separate drivers that need to be
assembled into one DRM device.  The component framework already supports
this kind of assembly; the aim is to build on it, not replace it.

A common helper could handle component matching, bind/unbind sequencing
and aggregate-device lifetime.  Hardware-specific drivers would still
provide the planes, display controllers and output handling.  Existing
DRM bridge drivers and clock providers would keep their normal roles.

Such a helper should not require an FPGA-specific device tree layout.
SoC drivers should be able to retain their existing bindings and supply
their component matches.  Feedback would help establish which parts are
worth sharing and which should remain in the individual display driver.


9. Questions
============

1. Is a grouping node acceptable when it represents a display-subsystem
   boundary in the FPGA design but has no registers of its own?

2. Does the upstream community prefer child nodes or phandle references
   for this grouping, particularly when components have existing bus
   parents?

3. Would the upstream community prefer a separate display binding, or
   an approach based on FPGA regions where the boundaries coincide?

4. What node name and compatible would best describe the hardware
   subsystem without tying the binding to Linux driver organisation?

5. Is matching child compatibles a suitable way to identify aggregate
   components, or is another membership mechanism preferred?

6. Would a common aggregation helper for FPGA and SoC display drivers
   be useful?  Which responsibilities should it share beyond the
   existing component framework, while retaining hardware-specific
   bindings and driver behaviour?

Feedback on these points would help shape an upstream implementation.

Thanks,
Vishal Sagar

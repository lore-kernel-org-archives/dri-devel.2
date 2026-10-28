Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECF606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ANjga2rs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E7F10E5BB;
	Wed, 28 Oct 2026 10:18:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0DB10E5BB
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 10:18:37 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EAC0AB07;
 Wed, 28 Oct 2026 11:16:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793182583;
 bh=Jx3G4z0tE37Rt7w9cZg1TVUcSJUcHX/hWXfZzDV3b28=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ANjga2rsQRGfocUNCYbMy5sxWaghn1/a1dTUY6H9uh2LKH6GPKrVp3FrIv4SGAgra
 ZYkXn46xOSLE9t5MlfIJ1+CshfU5kDuihKXFovXq3X506UNm2fn4GATky9qVNirAZo
 H9tYKNWXCVmD0x/VZTN+uBfZi5QwfGSIxoILLeps=
Message-ID: <170f1abb-68d4-4b62-bcb8-841b909bc0b4@ideasonboard.com>
Date: Wed, 28 Oct 2026 12:18:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm: Aggregating FPGA display pipelines into a single DRM
 device
To: Vishal Sagar <vishal.sagar@amd.com>, dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wens@csie.org>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 varunkumar.allagadapa@amd.com, Michal Simek <michal.simek@amd.com>
References: <20260925155658.3108388-1-vishal.sagar@amd.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260925155658.3108388-1-vishal.sagar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 25/09/2026 18:56, Vishal Sagar wrote:
> Hi all,
> 
> A display pipeline in a field-programmable gate array (FPGA) is built
> from individual intellectual property (IP) cores.  The designer chooses
> the blocks and their connections, so the pipeline can differ from one
> bitstream to another.  Each block can have its own device tree node and
> driver, while several blocks need to operate as one Direct Rendering
> Manager (DRM) device.
> 
> We propose a parent device tree node to group the blocks that make up a
> display subsystem.  A driver for that node would use the component
> framework to assemble them into one DRM device.  This RFC asks whether
> that is a suitable representation for upstream, and whether the driver
> support could be shared beyond FPGA-based systems.
> 
> 
> 1. Hardware blocks and interfaces
> =================================
> 
> The examples use the following blocks.  AXI4S means AXI4-Stream, the
> streaming interface. Native video carries pixels alongside
> active-video and sync signals, with a video clock.  These are
> different interfaces, so the chosen transmitter configuration matters.
> 
>    VMIX      Video Mixer.  Blends video layers into an AXI4S output.
>              https://docs.amd.com/r/en-US/pg243-v-mix
>    FBRD      Video Frame Buffer Read.  Uses direct memory access (DMA)
>              to read frames from memory and produce AXI4S video.
>              https://docs.amd.com/r/en-US/pg278-v-frmbuf
>    TPG       Video Test Pattern Generator.  Produces AXI4S test video.
>              https://docs.amd.com/r/en-US/pg103-v-tpg
>    A2N       AXI4S to Native Video converter.  Documented as AXI4-Stream
>              to Video Out (PG044); combines stream pixels with timing.
>              https://docs.amd.com/r/en-US/pg044_v_axis_vid_out
>    VTC       Video Timing Controller.  Supplies the output video timing.
>              https://docs.amd.com/r/en-US/pg016_v_tc
>    CLK       Clocking Wizard.  Generates clocks for the illustrated
>              video path (PG065).
>              https://docs.amd.com/r/en-US/pg065-clk-wiz
>    DPTX      DisplayPort Transmitter Subsystem.
>              https://docs.amd.com/r/en-US/pg199-displayport-tx-subsystem
>    HDMITX    High-Definition Multimedia Interface (HDMI) Transmitter
>              Subsystem.  PG235 covers HDMI 1.4/2.0.
>              https://docs.amd.com/r/en-US/pg235-v-hdmi-tx-ss
>    SWITCH    AXI4-Stream Switch.  Routes streams between interfaces;
>              documented in the AXI4-Stream Infrastructure IP Suite
>              product guide (PG085).
>              https://docs.amd.com/r/en-US/pg085-axi4stream-infrastructure
> 
> These blocks can be instantiated separately.  The design determines
> which are present and how they connect.  The aggregation question is
> not specific to these IP cores or to one FPGA vendor.
> 
> 
> 2. Example pipelines
> ====================
> 
> VMIX, FBRD and TPG produce AXI4S video.  Transmitters can be configured
> for AXI4S or native-video input.  The native paths illustrated here use
> an A2N converter, timing from VTC and a clock from Clocking Wizard.
> VTC supplies timing to the converter; it does not carry the video data.
> Clock sources depend on the design and transmitter requirements.
> 
> The examples below distinguish these interfaces.  They illustrate
> possible arrangements, not configurations supported by every IP version.
> Reset and control connections are omitted.  A CRTC represents a timed
> scanout pipeline, which may be implemented by several of these blocks.
> 
> (a) One scanout pipeline with a native-video transmitter input.
> 
>                         VTC
>                          | timing
>                          v
>      FBRD --AXI4S--> [   A2N   ] --native--> DPTX --> display
>                          ^
>                          | video clock
>                         CLK
> 
>      CLK also supplies the VTC video clock.  Clocking for the native
>      transmitter interface must match the configured video mode.
> 
> (b) Multiple layers blended by a mixer, with AXI4S throughout.
>      The HDMI transmitter is configured for AXI4S input.
> 
>      FBRD_0 ----> +------+
>      FBRD_1 ----> | VMIX | --AXI4S--> HDMITX --> display
>      TPG    ----> +------+
>         AXI4S
> 
> (c) Two outputs intended to form one DRM device with two CRTCs.
>      One output uses native video; the other uses AXI4S directly.
> 
>                             VTC
>                              | timing
>                              v
>      FBRD_0 --> VMIX_0 --> [ A2N ] --native--> DPTX --> display 0
>                              ^
>                              | video clock
>                             CLK
> 
>      FBRD_1 --> VMIX_1 --------AXI4S---------> HDMITX --> display 1
> 
>      All links before A2N are AXI4S.  CLK also clocks VTC as in (a).
>      These outputs need not have a video-data link between them.
> 
> (d) Separate AXI4S sources feeding separate stream inputs on a
>      DisplayPort transmitter configured for multi-stream transport.
> 
>      TPG  --AXI4S--> +------------------+
>                     | DPTX stream 0/1  | --> display 0, display 1
>      FBRD --AXI4S--> +------------------+
> 
> (e) An AXI4S Switch selects routes to two AXI4S-input transmitters.
>      Routing can change at runtime if configured for register control.
> 
>      FBRD_0 --> +------+
>      FBRD_1 --> | VMIX | --> +--------+ --> DPTX   --> display 0
>      TPG    --> +------+     | SWITCH |
>      FBRD_2 ---------------> +--------+ --> HDMITX --> display 1
> 
>      All links into and out of SWITCH carry AXI4S video.  It selects
>      stream routes; it does not blend pixels as the mixer does.
> 
> The available planes, CRTCs and outputs differ between these designs.
> The common requirement is to assemble the selected blocks into a DRM
> device without assuming one fixed pipeline topology.
> 
> 
> 3. Describing which devices belong together
> ===========================================
> 
> The device tree graph describes connections between blocks.  A display
> driver can walk those connections, but it still needs rules for where
> its device starts and ends.  A link to an output bridge, for example,
> does not mean that bridge must become a component-framework member.
> 
> Choosing one source as the master works for some pipelines.  With two
> sources feeding a common transmitter, following only downstream links
> from one source does not discover the other.  A broader traversal can
> find both, but still needs to decide which blocks to include.  Separate
> outputs, as in (c), may have no video link between them at all.
> 
> The proposal is to describe that grouping explicitly rather than make
> it depend on which source the driver starts from.  The graph would
> continue to describe the video connections, including bridge chains.
> The grouping would identify the display subsystem to assemble.
> 
> 
> 4. The proposal
> ===============
> 
> A device tree node that groups the pipeline's IP nodes as its children:
> 
>      display-pipeline {
>          compatible = "display-pipeline";
>          #address-cells = <2>;
>          #size-cells = <2>;
>          ranges;
> 
>          fbrd0: dma@a0010000 {
>              compatible = "...,v-frmbuf-rd";
>              reg = <0x0 0xa0010000 0x0 0x10000>;
>              clocks = <&misc_clk 0>;
> 
>              port {
>                  fbrd0_out: endpoint {
>                      remote-endpoint = <&vmix_in0>;
>                  };
>              };
>          };
> 
>          vmix0: video-mixer@a0020000 {
>              compatible = "...,v-mix";
>              reg = <0x0 0xa0020000 0x0 0x10000>;
>              clocks = <&misc_clk 1>;
> 
>              ports {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> 
>                  port@0 {
>                      reg = <0>;
> 
>                      vmix_in0: endpoint {
>                          remote-endpoint = <&fbrd0_out>;
>                      };
>                  };
> 
>                  port@1 {
>                      reg = <1>;
> 
>                      vmix_out: endpoint {
>                          remote-endpoint = <&dptx_in>;
>                      };
>                  };
>              };
>          };
> 
>          dptx0: display@a0100000 {
>              compatible = "...,dp-tx-subsystem";
>              reg = <0x0 0xa0100000 0x0 0x40000>;
> 
>              port {
>                  dptx_in: endpoint {
>                      remote-endpoint = <&vmix_out>;
>                  };
>              };
>          };
>      };
> 
> This is a structural sketch, not a complete binding example. The
> compatible strings are placeholders, and per-IP properties are omitted.
> The transmitter here uses AXI4S input, so there is no native-video
> converter or external video timing controller in this example.
> 
> The parent would describe the display subsystem without a register
> interface of its own.  Each child would follow its IP binding.
> 
> On probe, the aggregate driver would populate the children with
> of_platform_populate(), build a match list for the supported display
> components, then call component_master_add_with_match(). Its bind
> callback would allocate the drm_device, call component_bind_all() and
> register the assembled device, with corresponding cleanup on unbind.
> 
> Not every child needs to become a component-framework member. Clock
> and reset providers would retain their normal interfaces, as would
> output bridges used through the DRM bridge framework.  The match list
> would distinguish those devices from the components being bound.
> 
> The graph endpoints would still describe connections. Aggregation
> would not replace the individual drivers or the frameworks they use.
> 
> 
> 5. The hardware boundary
> ========================
> 
> The intended grouping comes from the FPGA design, not from the order in
> which Linux probes the devices.  A designer can place the display blocks
> in a hierarchy that represents the display subsystem.  The device tree
> generation flow can preserve that boundary along with the individual
> IP nodes.
> 
> Design hierarchy alone may not be sufficient grounds for a new device
> tree node.  The question is whether this particular grouping describes
> a meaningful hardware subsystem, and whether children or phandles are
> the better way to represent it.
> 
> 
> 6. Alternatives considered
> ==========================
> 
> - A grouping node with phandles to the components.  This preserves
>    their placement under existing buses and can be generated from the
>    hardware design just as child nodes can.  Child nodes express the
>    hierarchy directly and provide address scoping through ranges, but
>    phandles remain an option where reparenting would be inappropriate.
> 
> - Discover components through the graph without a grouping node.
>    This works when a driver has known entry points and traversal rules.
>    The question is how to define those rules across different designs,
>    including disconnected outputs intended to share one DRM device.
> 
> - Use the auxiliary bus or device links.  The auxiliary bus supports
>    splitting a device into functions; device links and fw_devlink manage
>    dependencies.  Neither by itself defines the display grouping, though
>    dependency handling would still be needed alongside aggregation.
> 
> - Reuse FPGA region semantics.  The fpga-region.yaml binding under
>    Documentation/devicetree/bindings/fpga/ supports child devices and
>    address translation.  A region describes a fabric programming
>    boundary, however, and may contain several display pipelines and
>    unrelated devices.  That boundary need not match a display subsystem.
> 
> 
> 7. Precedent
> ============
> 
> Allwinner's display engine provides a relevant comparison.  The binding
> under Documentation/devicetree/bindings/display/, named
> allwinner,sun4i-a10-display-engine.yaml, states:
> 
>      The display engine pipeline (and its entry point, since it can be
>      either directly the backend or the frontend) is represented as an
>      extra node.
> 
> That node has no register interface of its own.  Its allwinner,pipelines
> property references frontend or mixer entry points, not every member of
> an explicit component list.  It also uses phandles rather than placing
> the components beneath the node.
> 
> This is precedent for a separate display-subsystem node, but not for the
> exact parent-child arrangement proposed here.  The choice between
> children and phandles is one of the points on which feedback is needed.
> 
> 
> 8. A common approach for FPGA and SoC display drivers
> =====================================================
> 
> It would be useful to make this approach available to system-on-chip
> (SoC) display drivers as well.  Although their hardware blocks are fixed
> in silicon, those blocks can also have separate drivers that need to be
> assembled into one DRM device.  The component framework already supports
> this kind of assembly; the aim is to build on it, not replace it.
> 
> A common helper could handle component matching, bind/unbind sequencing
> and aggregate-device lifetime.  Hardware-specific drivers would still
> provide the planes, display controllers and output handling.  Existing
> DRM bridge drivers and clock providers would keep their normal roles.
> 
> Such a helper should not require an FPGA-specific device tree layout.
> SoC drivers should be able to retain their existing bindings and supply
> their component matches.  Feedback would help establish which parts are
> worth sharing and which should remain in the individual display driver.
> 
> 
> 9. Questions
> ============
> 
> 1. Is a grouping node acceptable when it represents a display-subsystem
>     boundary in the FPGA design but has no registers of its own?
> 
> 2. Does the upstream community prefer child nodes or phandle references
>     for this grouping, particularly when components have existing bus
>     parents?
> 
> 3. Would the upstream community prefer a separate display binding, or
>     an approach based on FPGA regions where the boundaries coincide?
> 
> 4. What node name and compatible would best describe the hardware
>     subsystem without tying the binding to Linux driver organisation?
> 
> 5. Is matching child compatibles a suitable way to identify aggregate
>     components, or is another membership mechanism preferred?
> 
> 6. Would a common aggregation helper for FPGA and SoC display drivers
>     be useful?  Which responsibilities should it share beyond the
>     existing component framework, while retaining hardware-specific
>     bindings and driver behaviour?
> 
> Feedback on these points would help shape an upstream implementation.
If the only purpose for the parent node is to group the child nodes 
together, I think it's maybe better to do it without the parent node. 
The DT media graph already connects all the nodes, so just finding a 
single node in the pipeline via compatible allows you to find the rest, 
thus creating the group at runtime.

Although "finding a single node" can be difficult too, if the user uses 
his own IPs.

However, there is at least one thing the above doesn't solve: say, we 
have two independent pipelines. Should they be considered as a single 
"display subsystem" with two pipelines (thus, on Linux side, under a 
single DRM device), or separate display subsystems, thus two DRM devices.

There could be a xlnx property to help define the above, or perhaps the 
aliases node could be used to define the order and number of display 
subsystems. These would also help solving the problem of finding a 
display pipeline when using custom IPs.

Another question is that some of the IPs can also exist on the V4L2 side 
(I guess in theory all of them could be used on V4L2 side, but in 
practice that's perhaps rare). This is the old, unsolved, problem.

  Tomi


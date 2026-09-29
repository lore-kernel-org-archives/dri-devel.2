Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55147CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CE210E907;
	Tue, 29 Sep 2026 12:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fwQcUmkQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C109310E907
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:32:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E56DA60136;
 Tue, 29 Sep 2026 12:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7301F00893;
 Tue, 29 Sep 2026 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790685174;
 bh=vTpzg8RRxKoA+TKiLKSjG5HP2O0uz0Gkl61WuACwax0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fwQcUmkQiki08QscpSuAdZ4a7j26pEO9dDhDLKFP531zgR+w0+75YWrWEiuIZN5bt
 anbzApiUGa76tUt09r3iDkbFkcDvh4xZgLXMPRm1GDE8PsMG4YWGkVqYJIJUZpvcJ7
 4znhge3ByfgIim+mtNdNMjOypCFgcr+x7K/FX8HZWFF7iE+vL+NETK29fPPkaQyG04
 b35tzDNMacmZkVDX3PglzVdLrECy/6sVzFHn4GUWLxWbSY1sppZ2W2bG3DZcO7Ge8t
 ixpw5YJt1Qxmx9XOJgj5DmTCBe1I4IjRNeduVdURJVzpvyP6AUkodXjpKGBIy0sbx7
 n4o87RdefdK0g==
Date: Tue, 29 Sep 2026 14:32:51 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Vishal Sagar <vishal.sagar@amd.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wens@csie.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 varunkumar.allagadapa@amd.com, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC] drm: Aggregating FPGA display pipelines into a single DRM
 device
Message-ID: <aruvDLcazpFfdsSN@houat>
References: <20260925155658.3108388-1-vishal.sagar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="jvlio5hzlh35o647"
Content-Disposition: inline
In-Reply-To: <20260925155658.3108388-1-vishal.sagar@amd.com>
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


--jvlio5hzlh35o647
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] drm: Aggregating FPGA display pipelines into a single DRM
 device
MIME-Version: 1.0

Hi,

On Fri, Sep 25, 2026 at 08:56:58AM -0700, Vishal Sagar wrote:
> A display pipeline in a field-programmable gate array (FPGA) is built
> from individual intellectual property (IP) cores.  The designer chooses
> the blocks and their connections, so the pipeline can differ from one
> bitstream to another.  Each block can have its own device tree node and
> driver, while several blocks need to operate as one Direct Rendering
> Manager (DRM) device.
>=20
> We propose a parent device tree node to group the blocks that make up a
> display subsystem.  A driver for that node would use the component
> framework to assemble them into one DRM device.  This RFC asks whether
> that is a suitable representation for upstream, and whether the driver
> support could be shared beyond FPGA-based systems.
>=20
>=20
> 1. Hardware blocks and interfaces
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The examples use the following blocks.  AXI4S means AXI4-Stream, the
> streaming interface. Native video carries pixels alongside
> active-video and sync signals, with a video clock.  These are
> different interfaces, so the chosen transmitter configuration matters.
>=20
>   VMIX      Video Mixer.  Blends video layers into an AXI4S output.
>             https://docs.amd.com/r/en-US/pg243-v-mix
>   FBRD      Video Frame Buffer Read.  Uses direct memory access (DMA)
>             to read frames from memory and produce AXI4S video.
>             https://docs.amd.com/r/en-US/pg278-v-frmbuf
>   TPG       Video Test Pattern Generator.  Produces AXI4S test video.
>             https://docs.amd.com/r/en-US/pg103-v-tpg
>   A2N       AXI4S to Native Video converter.  Documented as AXI4-Stream
>             to Video Out (PG044); combines stream pixels with timing.
>             https://docs.amd.com/r/en-US/pg044_v_axis_vid_out
>   VTC       Video Timing Controller.  Supplies the output video timing.
>             https://docs.amd.com/r/en-US/pg016_v_tc
>   CLK       Clocking Wizard.  Generates clocks for the illustrated
>             video path (PG065).
>             https://docs.amd.com/r/en-US/pg065-clk-wiz
>   DPTX      DisplayPort Transmitter Subsystem.
>             https://docs.amd.com/r/en-US/pg199-displayport-tx-subsystem
>   HDMITX    High-Definition Multimedia Interface (HDMI) Transmitter
>             Subsystem.  PG235 covers HDMI 1.4/2.0.
>             https://docs.amd.com/r/en-US/pg235-v-hdmi-tx-ss
>   SWITCH    AXI4-Stream Switch.  Routes streams between interfaces;
>             documented in the AXI4-Stream Infrastructure IP Suite
>             product guide (PG085).
>             https://docs.amd.com/r/en-US/pg085-axi4stream-infrastructure
>=20
> These blocks can be instantiated separately.  The design determines
> which are present and how they connect.  The aggregation question is
> not specific to these IP cores or to one FPGA vendor.
>=20
>=20
> 2. Example pipelines
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> VMIX, FBRD and TPG produce AXI4S video.  Transmitters can be configured
> for AXI4S or native-video input.  The native paths illustrated here use
> an A2N converter, timing from VTC and a clock from Clocking Wizard.
> VTC supplies timing to the converter; it does not carry the video data.
> Clock sources depend on the design and transmitter requirements.
>=20
> The examples below distinguish these interfaces.  They illustrate
> possible arrangements, not configurations supported by every IP version.
> Reset and control connections are omitted.  A CRTC represents a timed
> scanout pipeline, which may be implemented by several of these blocks.
>=20
> (a) One scanout pipeline with a native-video transmitter input.
>=20
>                        VTC
>                         | timing
>                         v
>     FBRD --AXI4S--> [   A2N   ] --native--> DPTX --> display
>                         ^
>                         | video clock
>                        CLK
>=20
>     CLK also supplies the VTC video clock.  Clocking for the native
>     transmitter interface must match the configured video mode.
>=20
> (b) Multiple layers blended by a mixer, with AXI4S throughout.
>     The HDMI transmitter is configured for AXI4S input.
>=20
>     FBRD_0 ----> +------+
>     FBRD_1 ----> | VMIX | --AXI4S--> HDMITX --> display
>     TPG    ----> +------+
>        AXI4S
>=20
> (c) Two outputs intended to form one DRM device with two CRTCs.
>     One output uses native video; the other uses AXI4S directly.
>=20
>                            VTC
>                             | timing
>                             v
>     FBRD_0 --> VMIX_0 --> [ A2N ] --native--> DPTX --> display 0
>                             ^
>                             | video clock
>                            CLK
>=20
>     FBRD_1 --> VMIX_1 --------AXI4S---------> HDMITX --> display 1
>=20
>     All links before A2N are AXI4S.  CLK also clocks VTC as in (a).
>     These outputs need not have a video-data link between them.
>=20
> (d) Separate AXI4S sources feeding separate stream inputs on a
>     DisplayPort transmitter configured for multi-stream transport.
>=20
>     TPG  --AXI4S--> +------------------+
>                    | DPTX stream 0/1  | --> display 0, display 1
>     FBRD --AXI4S--> +------------------+
>=20
> (e) An AXI4S Switch selects routes to two AXI4S-input transmitters.
>     Routing can change at runtime if configured for register control.
>=20
>     FBRD_0 --> +------+
>     FBRD_1 --> | VMIX | --> +--------+ --> DPTX   --> display 0
>     TPG    --> +------+     | SWITCH |
>     FBRD_2 ---------------> +--------+ --> HDMITX --> display 1
>=20
>     All links into and out of SWITCH carry AXI4S video.  It selects
>     stream routes; it does not blend pixels as the mixer does.
>=20
> The available planes, CRTCs and outputs differ between these designs.
> The common requirement is to assemble the selected blocks into a DRM
> device without assuming one fixed pipeline topology.
>=20
>=20
> 3. Describing which devices belong together
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The device tree graph describes connections between blocks.  A display
> driver can walk those connections, but it still needs rules for where
> its device starts and ends.  A link to an output bridge, for example,
> does not mean that bridge must become a component-framework member.
>=20
> Choosing one source as the master works for some pipelines.  With two
> sources feeding a common transmitter, following only downstream links
> from one source does not discover the other.  A broader traversal can
> find both, but still needs to decide which blocks to include.  Separate
> outputs, as in (c), may have no video link between them at all.
>=20
> The proposal is to describe that grouping explicitly rather than make
> it depend on which source the driver starts from.  The graph would
> continue to describe the video connections, including bridge chains.
> The grouping would identify the display subsystem to assemble.
>=20
>=20
> 4. The proposal
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> A device tree node that groups the pipeline's IP nodes as its children:
>=20
>     display-pipeline {
>         compatible =3D "display-pipeline";
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>         ranges;
>=20
>         fbrd0: dma@a0010000 {
>             compatible =3D "...,v-frmbuf-rd";
>             reg =3D <0x0 0xa0010000 0x0 0x10000>;
>             clocks =3D <&misc_clk 0>;
>=20
>             port {
>                 fbrd0_out: endpoint {
>                     remote-endpoint =3D <&vmix_in0>;
>                 };
>             };
>         };
>=20
>         vmix0: video-mixer@a0020000 {
>             compatible =3D "...,v-mix";
>             reg =3D <0x0 0xa0020000 0x0 0x10000>;
>             clocks =3D <&misc_clk 1>;
>=20
>             ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>=20
>                 port@0 {
>                     reg =3D <0>;
>=20
>                     vmix_in0: endpoint {
>                         remote-endpoint =3D <&fbrd0_out>;
>                     };
>                 };
>=20
>                 port@1 {
>                     reg =3D <1>;
>=20
>                     vmix_out: endpoint {
>                         remote-endpoint =3D <&dptx_in>;
>                     };
>                 };
>             };
>         };
>=20
>         dptx0: display@a0100000 {
>             compatible =3D "...,dp-tx-subsystem";
>             reg =3D <0x0 0xa0100000 0x0 0x40000>;
>=20
>             port {
>                 dptx_in: endpoint {
>                     remote-endpoint =3D <&vmix_out>;
>                 };
>             };
>         };
>     };
>=20
> This is a structural sketch, not a complete binding example. The
> compatible strings are placeholders, and per-IP properties are omitted.
> The transmitter here uses AXI4S input, so there is no native-video
> converter or external video timing controller in this example.
>=20
> The parent would describe the display subsystem without a register
> interface of its own.  Each child would follow its IP binding.
>=20
> On probe, the aggregate driver would populate the children with
> of_platform_populate(), build a match list for the supported display
> components, then call component_master_add_with_match(). Its bind
> callback would allocate the drm_device, call component_bind_all() and
> register the assembled device, with corresponding cleanup on unbind.
>=20
> Not every child needs to become a component-framework member. Clock
> and reset providers would retain their normal interfaces, as would
> output bridges used through the DRM bridge framework.  The match list
> would distinguish those devices from the components being bound.
>=20
> The graph endpoints would still describe connections. Aggregation
> would not replace the individual drivers or the frameworks they use.
>=20
>=20
> 5. The hardware boundary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The intended grouping comes from the FPGA design, not from the order in
> which Linux probes the devices.  A designer can place the display blocks
> in a hierarchy that represents the display subsystem.  The device tree
> generation flow can preserve that boundary along with the individual
> IP nodes.
>=20
> Design hierarchy alone may not be sufficient grounds for a new device
> tree node.  The question is whether this particular grouping describes
> a meaningful hardware subsystem, and whether children or phandles are
> the better way to represent it.
>=20
>=20
> 6. Alternatives considered
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> - A grouping node with phandles to the components.  This preserves
>   their placement under existing buses and can be generated from the
>   hardware design just as child nodes can.  Child nodes express the
>   hierarchy directly and provide address scoping through ranges, but
>   phandles remain an option where reparenting would be inappropriate.
>=20
> - Discover components through the graph without a grouping node.
>   This works when a driver has known entry points and traversal rules.
>   The question is how to define those rules across different designs,
>   including disconnected outputs intended to share one DRM device.
>=20
> - Use the auxiliary bus or device links.  The auxiliary bus supports
>   splitting a device into functions; device links and fw_devlink manage
>   dependencies.  Neither by itself defines the display grouping, though
>   dependency handling would still be needed alongside aggregation.
>=20
> - Reuse FPGA region semantics.  The fpga-region.yaml binding under
>   Documentation/devicetree/bindings/fpga/ supports child devices and
>   address translation.  A region describes a fabric programming
>   boundary, however, and may contain several display pipelines and
>   unrelated devices.  That boundary need not match a display subsystem.
>=20
>=20
> 7. Precedent
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Allwinner's display engine provides a relevant comparison.  The binding
> under Documentation/devicetree/bindings/display/, named
> allwinner,sun4i-a10-display-engine.yaml, states:
>=20
>     The display engine pipeline (and its entry point, since it can be
>     either directly the backend or the frontend) is represented as an
>     extra node.
>=20
> That node has no register interface of its own.  Its allwinner,pipelines
> property references frontend or mixer entry points, not every member of
> an explicit component list.  It also uses phandles rather than placing
> the components beneath the node.
>=20
> This is precedent for a separate display-subsystem node, but not for the
> exact parent-child arrangement proposed here.  The choice between
> children and phandles is one of the points on which feedback is needed.

I don't think we should use Allwinner as a precedent for this.
Allwinner's use case was that we needed a device created with a handle
to the video pipeline to back the main DRM device. This was about 10y
ago, and looking back we could have done about the same work by
registering a device at module init and searching the DT for enabled
compatibles.

I'd suggest you to go that route if you have any driver you can plumb it
into, like an FPGA manager or something.

Maxime

--jvlio5hzlh35o647
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaruv8gAKCRAnX84Zoj2+
dkKtAYDjNJEWLi8UrrlbZuVFaR3LD2wx4yDSbScXYc3FUH2BHyZgy0VVPHTPSlOE
WDMrLLEBfRzGmRt2xTAO2nGscwERE4x4LtGS15ip/AZzyEHJTJXWpnj2w2s3WniP
q+t9gzLWQw==
=PbVt
-----END PGP SIGNATURE-----

--jvlio5hzlh35o647--

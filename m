Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCC606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIR/jHlR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8151510E432;
	Thu, 26 Nov 2026 22:00:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEBF10E432
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 22:00:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9CE39601F6;
 Thu, 26 Nov 2026 22:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167741F00893;
 Thu, 26 Nov 2026 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795730423;
 bh=7c7/oytUm/cTA9mvt2dZkojdQh//AqC3WyEoCbnB0JA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SIR/jHlReC/pQgdPSDammzaAJpgLf7Q/QkY3zzhbV8Yw7EsfRq4MFshU2i5A/BFlT
 z7pWcmD97ZBj0iIkgbWQwItx67vdPv5hwifdh4giJ4q82NWz8BDsJpRzfqHrz0j8SK
 ZpWJu4DLC/AOMagP8tyOMkc+TAQlh2ZG43W7YCRYVbenYMGlpJTNuu0ysr7DdfYFzy
 7LhRD1QZkgyQO6h1s2pjguSP10cOGrUxNbOmOdWkfeyDOM30wMn6BIn26KeXt5aDqC
 /IggTJlhfNn5GYjlvzmQs5T73vq4VrK8dpBH2/9p4ztJ3RobEgai7U95wfzbUiaeve
 jZuJJ2/IAhlcg==
Message-ID: <sashiko-outbox-236290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] arm64: dts: allwinner: h616: Add display pipeline
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261126214433.3562326-11-jernej.skrabec@gmail.com>
References: <20261126214433.3562326-1-jernej.skrabec@gmail.com>
 <20261126214433.3562326-11-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 22:00:22 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] arm64: dts: allwinner: h616: tcon_top graph overflows
  sun4i_drv_probe() kfifo
--

commit 01e1e3e0b1574bffa9c9d00380c059ba10691ddb
Author: Jernej Skrabec <jernej.skrabec@gmail.com>

arm64: dts: allwinner: h616: Add display pipeline

This commit adds the devicetree nodes for the Allwinner H616 display
engine 3.3 pipeline, including two mixers, TCON TOP, four TCONs, and HDMI.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> index 93c3b8279241f..d7ed84d3c1217 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
[ ... ]
> @@ -978,6 +1065,339 @@ ohci3: usb@5311400 {
[ ... ]
> +		tcon_top: tcon-top@6510000 {
> +			compatible =3D "allwinner,sun50i-h616-tcon-top";
> +			reg =3D <0x06510000 0x1000>;
> +			clocks =3D <&ccu CLK_BUS_TCON_TOP>,
> +				 <&ccu CLK_TCON_TV0>,
> +				 <&ccu CLK_TVE0>,
> +				 <&ccu CLK_TCON_TV1>;
> +			clock-names =3D "bus",
> +				      "tcon-tv0",
> +				      "tve0",
> +				      "tcon-tv1";
> +			clock-output-names =3D "tcon-top-tv0",
> +					     "tcon-top-tv1";
> +			resets =3D <&ccu RST_BUS_TCON_TOP>;
> +			#clock-cells =3D <1>;
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				tcon_top_mixer0_in: port@0 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <0>;
> +
> +					tcon_top_mixer0_in_mixer0: endpoint@0 {
> +						reg =3D <0>;
> +						remote-endpoint =3D <&mixer0_out_tcon_top_mixer0>;
> +					};
> +				};
> +
> +				tcon_top_mixer0_out: port@1 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <1>;
> +
> +					tcon_top_mixer0_out_tcon_lcd0: endpoint@0 {
> +						reg =3D <0>;
> +						remote-endpoint =3D <&tcon_lcd0_in_tcon_top_mixer0>;
> +					};
> +
> +					tcon_top_mixer0_out_tcon_lcd1: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&tcon_lcd1_in_tcon_top_mixer0>;
> +					};
> +
> +					tcon_top_mixer0_out_tcon_tv0: endpoint@2 {
> +						reg =3D <2>;
> +						remote-endpoint =3D <&tcon_tv0_in_tcon_top_mixer0>;
> +					};
> +
> +					tcon_top_mixer0_out_tcon_tv1: endpoint@3 {
> +						reg =3D <3>;
> +						remote-endpoint =3D <&tcon_tv1_in_tcon_top_mixer0>;
> +					};
> +				};
> +
> +				tcon_top_mixer1_in: port@2 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <2>;
> +
> +					tcon_top_mixer1_in_mixer1: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&mixer1_out_tcon_top_mixer1>;
> +					};
> +				};
> +
> +				tcon_top_mixer1_out: port@3 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <3>;
> +
> +					tcon_top_mixer1_out_tcon_lcd0: endpoint@0 {
> +						reg =3D <0>;
> +						remote-endpoint =3D <&tcon_lcd0_in_tcon_top_mixer1>;
> +					};
> +
> +					tcon_top_mixer1_out_tcon_lcd1: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&tcon_lcd1_in_tcon_top_mixer1>;
> +					};
> +
> +					tcon_top_mixer1_out_tcon_tv0: endpoint@2 {
> +						reg =3D <2>;
> +						remote-endpoint =3D <&tcon_tv0_in_tcon_top_mixer1>;
> +					};
> +
> +					tcon_top_mixer1_out_tcon_tv1: endpoint@3 {
> +						reg =3D <3>;
> +						remote-endpoint =3D <&tcon_tv1_in_tcon_top_mixer1>;
> +					};
> +				};
> +
> +				tcon_top_hdmi_in: port@4 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <4>;
> +
> +					tcon_top_hdmi_in_tcon_tv0: endpoint@0 {
> +						reg =3D <0>;
> +						remote-endpoint =3D <&tcon_tv0_out_tcon_top>;
> +					};
> +
> +					tcon_top_hdmi_in_tcon_tv1: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&tcon_tv1_out_tcon_top>;
> +					};
> +				};
> +
> +				tcon_top_hdmi_out: port@5 {
> +					reg =3D <5>;
> +
> +					tcon_top_hdmi_out_hdmi: endpoint {
> +						remote-endpoint =3D <&hdmi_in_tcon_top>;
> +					};
> +				};
> +			};
> +		};

[Severity: Medium]
Does this tcon_top graph overflow the 16-entry endpoint_list FIFO in
sun4i_drv_probe() and leak device_node references?

When sun4i_drv_probe() traverses mixer0 and mixer1, both push tcon_top
into list.fifo.  tcon_top has 9 connected output endpoints across port@1
(4), port@3 (4), and port@5 (1), and sun4i_drv_traverse_endpoints() queues
every remote node regardless of whether the target device is disabled:

drivers/gpu/drm/sun4i/sun4i_drv.c:
struct endpoint_list {
	DECLARE_KFIFO(fifo, struct device_node *, 16);
};

drivers/gpu/drm/sun4i/sun4i_drv.c:sun4i_drv_traverse_endpoints() {
    ...
	for_each_available_child_of_node(port, ep) {
		remote =3D of_graph_get_remote_port_parent(ep);
    ...
		kfifo_put(&list->fifo, remote);
	}
}

Popping the first tcon_top entry pushes 9 remote nodes while the second
tcon_top entry is still queued (10 entries in list.fifo).  Popping the
second tcon_top entry then attempts to push 9 more remote nodes (18 in
total), so the final two kfifo_put() calls for tcon_tv1 and hdmi fail on a
full 16-entry FIFO, dropping the queue insertions and leaking the two
remote device_node references from of_graph_get_remote_port_parent().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126214433.3562=
326-1-jernej.skrabec@gmail.com?part=3D10

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB866FEA82E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D80910E80E;
	Wed, 25 Mar 2026 08:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Sl6z+LVf";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407E810E80E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774425848; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EgJc1itclomWbWoYY1L0OXodJvSl3a1QmTBciFyHoo53RSblmuzqjezxGM3ARt34orpOu1t8h1NUM51T6pu639Te5wEhsJ+/78IKnSZ+FspgYAoHBppJJYzBY9EzBg0N+wQ904fE5IJhMu6iyd9sR1eRy5ksKwaQaI7RhGmjDG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774425848;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=045P43LH4bNvn5f+Wj8qPpIAq39tX2DOOtWxfqbqqi4=; 
 b=UMYXmhZFE8dvtG54X+chFjKgsOiilppx6SVhpLEWoRvSVndcUzaOC82upwF500bi67FboElP+JoJSlg7G0p8a9Yz2GxcGb7cYhfJ3FVNtfT86FxYcCyPShFDeY0pKEYWNWrHqE/Gbz29ovEBO/IRLrMSsllWD1kArypBdm58dOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774425847; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=045P43LH4bNvn5f+Wj8qPpIAq39tX2DOOtWxfqbqqi4=;
 b=Sl6z+LVf4xDcYVH/a1jR9lE/BTcZh/OoV71DF1S4GAgqSxXkwDYhpb2ZybFVGIE7
 Hc50FGhvDt/TJPOsZv7dhOhsfYf+Wbp5lPlfCn42tkY2mRs3ezuex+5ci1hQaB/uOBC
 Ah5RS9ptrfwqvP2/rQugPjOfNRKQzduPClQNe+KEins/36S8XH5db3rjSG/sd8qKbY8
 QZQWcRkctSSY8cKd0WT8rAxZ4SqOwunhcRuBmfu5/6Rp9ZpLufvZmAywygwzSM4IxSI
 JCNRQ1+L6xUX7NoM7Msgfr5PEnHx3mNQ8YW9YxmG8i8AMN3TYmYVRTYrTtT17WRT/or
 4ugIoE/5jw==
Received: by mx.zohomail.com with SMTPS id 1774425845845509.8994376356012;
 Wed, 25 Mar 2026 01:04:05 -0700 (PDT)
Message-ID: <93c1d325461cc0ffad890d64870de680506338c4.camel@icenowy.me>
Subject: Re: [PATCH v2 0/5] powervr: MT8173 GPU support
From: Icenowy Zheng <uwu@icenowy.me>
To: Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Frank Binns
 <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 25 Mar 2026 16:03:57 +0800
In-Reply-To: <20260325071951.544031-1-wenst@chromium.org>
References: <20260325071951.544031-1-wenst@chromium.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-03-25=E4=B8=89=E7=9A=84 15:19 +0800=EF=BC=8CChen-Yu Tsai=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi everyone,
>=20
> This is v2 of my MT8173 PowerVR GPU support series.
>=20
> Changes since v1:
> - Adapted to changed DT bindings
> - Dropped driver change
> - Use same power domain for "a" and "b" GPU power domains
>=20
> This update was requested by Icenowy.
>=20
>=20
> This series enables the PowerVR GPU found in the MT8173 SoC, found in
> some Chromebooks.
>=20
> This version is different from the initial powervr driver submission
> [1]
> in that it splits out the GPU glue layer support out of the powervr
> driver and into a separate clock and power domain driver. The glue
> code
> is otherwise the same, and also the same as found in the ChromeOS
> kernels, with some extra comments and macro names added where
> possible.
>=20
> Patch 1 adds a binding for the glue layer, called mfgtop. The glue
> layer
> contains clock and power controls for the GPU.
>=20
> Patch 2 adds a driver for the glue layer.
>=20
> Patch 3 adds an entry for the MT8173 GPU and 6XT series to the
> PowerVR
> binding.
>=20
> Patch 4 adds an entry for the PowerVR 6XT series GPU to the driver.
>=20
> Patch 5 corrects the clock for the GPU (called MFG) power domain.
>=20
> Patch 6 adds device nodes for the GPU and glue layer to the MT8173
> dtsi
> file.
>=20
> Patch 2 and 6 depend on patch 1 to build. I suppose some common
> immutable tree would be needed from the MediaTek maintainers.
>=20
> The kernel driver successfully probes the hardware and loads the
> "rogue_4.40.2.51_v1.fw" firmware provided by Imagination Technologies
> [2].
> Userspace was tested with Mesa 24.0.8 from Debian Trixie rebuilt with
> the powervr vulkan driver enabled. `vulkaninfo` gives some
> information
> about the GPU (attached at the end), but running the `triangle`
> example
> from the Sascha Willems demos [3] with -DUSE_D2D_WSI=3DON as
> recommended [4]
> failed with:
>=20
> =C2=A0=C2=A0=C2=A0 Can't find a display and a display mode!

I think when using D2D the demos want width and height to be explicitly
specified, otherwise it seems to hardcode 1280x720.

If you're using an elm, could you try to add `-w 1920 -h 1080` or for
hana `-w 1366 -h 768` ?

Thanks
Icenowy

>=20
> Same program worked correctly on a BeaglePlay and displayed a color
> gradient triangle. Not sure what went wrong here.
>=20
> Anyway, please have a look and test.
>=20
>=20
> Thanks
> ChenYu
>=20
> [1]
> https://lore.kernel.org/dri-devel/20220815165156.118212-2-sarah.walker@im=
gtec.com/
> [2]
> https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powervr
> [3] https://github.com/SaschaWillems/Vulkan
> [4]
> https://lore.kernel.org/dri-devel/f2b2671e-5acc-4dec-9c2e-3c9cd2e1f19e@im=
gtec.com/
>=20
> Chen-Yu Tsai (5):
> =C2=A0 dt-bindings: clock: mediatek: Add mt8173 mfgtop
> =C2=A0 clk: mediatek: Add mt8173-mfgtop driver
> =C2=A0 dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173 GPU
> =C2=A0 arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power domain clock
> =C2=A0 arm64: dts: mediatek: mt8173: Add GPU device nodes
>=20
> =C2=A0.../clock/mediatek,mt8173-mfgtop.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 70 +++++
> =C2=A0.../bindings/gpu/img,powervr-rogue.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/arm64/boot/dts/mediatek/mt8173.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 33 ++-
> =C2=A0drivers/clk/mediatek/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 9 +
> =C2=A0drivers/clk/mediatek/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0drivers/clk/mediatek/clk-mt8173-mfgtop.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 243
> ++++++++++++++++++
> =C2=A0include/dt-bindings/clock/mt8173-clk.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A07 files changed, 363 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644
> Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
> =C2=A0create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E1BC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C8510E058;
	Sat,  8 Aug 2026 20:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cE3SLerB";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA2510E058
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786220392; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nQD+fGqxB6UkDIh6ab8llSRtZtAVdtmjXM55X4ftMoqQV0GLZJCSWlhUNX6ngEyMXI7AmhJJLZW2nwP4sJKkYsn4UcOU+zuKgzKUWGr7XypA/uq+lcwUmoKYbV0L4HSjTsGaUZLnOnuFLVydVQQC25s2SDvzFog7AAmsnZ/c38s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786220392;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dTyEmAFMXg2QOXmlZRaJiP5I5NyDAILJNF6EwnDocl8=; 
 b=CE/G2sMo9Mw9AKCz4lFbfyR9wVUahgjz1b0uCkNXEnB6JByCLVOJp5sQgGViBzusDJJf3I6TDNQjtPOAa7lIWThGkSnhIFgjlaHWW3KFKXlgyeB8PBs+hwQT4Tjx5WhEI9Eb422NQ6N+wft3ZjX0PeoYtFOyNUtuwieIFV2Xa6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786220391; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=dTyEmAFMXg2QOXmlZRaJiP5I5NyDAILJNF6EwnDocl8=;
 b=cE3SLerBAaQutJ7S37S5guKr19nYqY+YMpqOXCgt069b/O0KhnZYMHocj/VbZ0pi
 NlT3B4uUFl26JqZKRKL370SK/gjkCYtADtPFm3UpqjShqjaQaaQ3JOx0FwcXzJ9bMkE
 QvXJ6u/3NNnm7FJ1BpzX96szDMbhcQtXH3NeNAdg=
Received: by mx.zohomail.com with SMTPS id 1786220389882229.9479842488364;
 Sat, 8 Aug 2026 13:19:49 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 8F47B180679; Sat, 08 Aug 2026 22:19:42 +0200 (CEST)
Date: Sat, 8 Aug 2026 22:19:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v11 00/21] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
Message-ID: <aneNCDU12OzG99UX@venus>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260808094138.7205-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hivxea73q5gk46gz"
Content-Disposition: inline
In-Reply-To: <20260808094138.7205-1-royalnet026@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.208.17
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


--hivxea73q5gk46gz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 00/21] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
MIME-Version: 1.0

Hi,

On Sat, Aug 08, 2026 at 11:41:32AM +0200, Igor Paunovic wrote:
> The Tested-by tag is at the bottom.  Short version: v11 works here on
> an Orange Pi 5 Plus over USB-C DP AltMode.  It needs your usbdp v13
> series underneath to probe at all, and above 2560x1440@144 it needs a
> VOP2 ACLK change that has nothing to do with your patches.
>=20
> One caveat first, so that the next paragraph is not misread: dp0 is
> disabled in the mainline RK3588 DTS, so none of this is reachable on
> an untouched tree.  I enable it with a local board DT patch.
>=20
> With dp0 enabled but without usbdp v13, dw-dp never finishes probing.
> It stops at "failed to get follow-up bridge" (dw-dp.c), because
> mainline phy-rockchip-usbdp has no drm_aux_bridge_register() at all;
> that call arrives with usbdp v13 patch 16/35 ("phy: rockchip: usbdp:
> Register DP aux bridge"). The component bind then never completes, so
> both HDMI outputs stay dark as well - the symptom is much wider than
> the cause, which cost me a boot to work out.

Correct, that's why I mentioned the explicit dependency in earlier
versions. But without the usbdp series you should not have DP0
connected to the USBDP in the first place, because the USBDP DT
binding does not yet have 'ports' described in its binding.

> Hardware: Samsung Odyssey G70B behind a USB-C to HDMI 2.1 protocol
> converter.  DPCD extended revision 1.4, the link trains at HBR2 x4,
> VSC SDP colorimetry is supported.  The converter ships a malformed
> EDID, so a boot script feeds a corrected one through the debugfs
> edid_override and kicks fusb302 once; without that the 4K modes are
> dropped and AUX stays dead.  Both are adapter problems, not driver
> ones.
>=20
> What I saw:
>=20
>   - DP-1 comes up connected, the EDID reads through the converter,
>     the link trains, and KWin drives the output.
>   - At the stock VOP2 ACLK rate, modes up to 2560x1440@144 are clean.
>     I left the machine at 2560x1440@143.99 for more than eight hours
>     with no DRM or VOP2 errors.
>   - 3840x2160@120 comes up, but the picture is unusable until the
>     VOP2 ACLK is raised.  With it raised the picture is correct
>     immediately.
>=20
> That last point is a platform issue rather than a dw-dp one, so I have
> sent it as its own thread to dri-devel and linux-rockchip with you on
> Cc: "drm/rockchip: vop2: ACLK_VOP pinned at 500 MHz starves DP 4K120
> on RK3588".
>=20
> Two small things I noticed while I was in there:
>=20
> Kconfig: ROCKCHIP_DW_DP selects nothing, and DRM_DW_DP does not select
> DRM_BRIDGE_CONNECTOR either, while ROCKCHIP_ANALOGIX_DP,
> ROCKCHIP_CDN_DP, ROCKCHIP_DW_HDMI_QP, ROCKCHIP_LVDS and ROCKCHIP_RGB
> all do.  Since dw_dp-rockchip.c calls drm_bridge_connector_init(), a
> configuration with only ROCKCHIP_DW_DP enabled fails to link.  This
> predates your series; I am happy to send the one-liner if you agree it
> is worth fixing.

Makes sense to handle this independently.

> sound-dai-cells: the dt-bindings patch in this series ("dt-bindings:
> display: rockchip: dw-dp: Fix sound DAI cells") notes that the
> mainline rk3588 DTS still sets 0 and will be fixed up separately.  Is
> that DTS patch already queued somewhere?  I would rather not duplicate
> it.

You can see it in the Collabora rockchip-devel branch; I did not yet
send it because it needs the DT binding patch. See the discussion
with Rob on the binding patch.=20

> DP audio: it does work here, but on my rockchip-devel based daily
> kernel, which carries the v9 generation of the audio patch - a
> simple-audio-card with cpu &spdif_tx2 and codec <&dp0 1>, picked up by
> PipeWire unaided, playing over the same cable as the video.  I have
> not retested audio on the v11 tree, so the tag below covers video
> only.

Great (barely anything audio related changed between those versions)
:)

> Tested on drm-misc-next of 2026-08-07 (dc2f9f7fed1a) with this series,
> usbdp v13, two local board DT patches (enable DP AltMode on the USB-C
> connector; pin DCLK_VOP2 to V0PLL), and a one-line local change to
> clk.c so that I could set clock rates from debugfs.
>=20
> Thanks for the series.
>=20
> Tested-by: Igor Paunovic <royalnet026@gmail.com>

Thanks. Hopefully the USB-C DP AltMode work makes it into 7.4 :)

Greetings,

-- Sebastian

--hivxea73q5gk46gz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmp3j1sACgkQ2O7X88g7
+ppntQ/9E94S+hS6IHgfueAiTitlAsEJW+1Wvoxat8JqDtfqDFq1EWK++yaHk9z1
xSKhCo5CMNXumO5yMRrtHpzNrW4+8aOAefc3e9V5hhoqvaXPpZrkU8AMfFWFm8zE
DG++XGGua7rwXFPXNbwnQHwreZnMG4ssDQoudECym8raNn9u7/usjw99TzopfLJQ
bHJf6kE+Su3VHXWVDlOryRAIFj+YyfzPspsBt97fUGOPRZZcfT9eDCkGbQt5Tf5O
jLvklZlvTXWOQS4PKrt32qApDHr4NYGTkloaM9bQIh/QkAP3lcLZ5U33fBen0ftv
Ku+KCOswZqdpcs9FbxAhS9ko2kRNrIuAiA7L6h9XActtP2J9StTxG4RMiMtgcbVN
f9Yd5eL438Dqav1Qym6DmL5IGsLT291+31IYGrt8Wnq3yLMaFHdVJPwZGXdTiLhd
3ylaEeabjZ2X9CAbZc6jcAvIWyfS5coAC8f1KEn+Kdf4So/He6mW5IR6deOYJ34s
PcKvNVyYTU6qBEED5tNNwhwO/9/YMBHHGgrfxcASGNroLkTMluQvT6R50lP/GYEi
oaL4BK8ZtjMlfUa/MexMSD/W3DvpI7P6kZZ0GUBGNxovWV7101Odq+XejVoDNzVs
kANFNXa6KS6Z7mrPGJDXbb5xm7pRCXQ3c5pohdKEMcOmLWXGJx4=
=492A
-----END PGP SIGNATURE-----

--hivxea73q5gk46gz--

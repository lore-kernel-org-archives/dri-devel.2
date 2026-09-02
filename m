Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86D7C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 23:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0313B10F36B;
	Wed,  2 Sep 2026 23:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TYJdpxXA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210D810F36B
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 23:06:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4750B600C8;
 Wed,  2 Sep 2026 23:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5C61F000E9;
 Wed,  2 Sep 2026 23:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788390364;
 bh=l5gYv3qCWnNgSqMrivbHCUl8Z6YxRtMrPzgEbPYBN84=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TYJdpxXA1gag9js5w+PzqqmHyFRjmHlZYyy8GmP03KkeggvsqzT2VL6Dtty2HA2Xv
 mUZCW7zs7+P7mU96oljvvcKfWrI8EUxdhlKzpimtrktKX+UACuRfNo+NwkzQISt2JY
 Zuk3ITVtxn71lkqrmzU/kuqd7CyN2rvSS9t6SslQQCYnAkWCg35tCiZ/YlDe43F0lQ
 h4C4x8eaxcaP74sxbJUlmlD2dtOTE66MJdGN3y/iOkHLxWeOTu4V8sT2jayMLtqNwo
 B6OMBQoOIiFIH1Wjwg51GYVw+0iFFidmBW6ydAYRq1bc69g0dEPMdnkSX2y7hpWEK7
 eMmQc1XXeIQ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] drm/rockchip: dw_hdmi_qp: Support 10-bit
 YUV422 output format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-12-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
 <20260903-dw-hdmi-qp-yuv-v4-12-fb45bf4147eb@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:06:03 +0000
Message-Id: <20260902230603.AF5C61F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying hardware state and global driver state during the atomic=
_check phase.
- [High] drm_atomic_get_bridge_state() error code masking breaks wait/wound=
 mutex backoff.
--

commit d0dd6a8692e00076c21b4fe6dcb51ded1a0bb7d0
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format

This commit adds support for the 10-bit YUV422 output format to the Rockchip
DW HDMI QP encoder. It also configures the HDMI PHY with 8 bpc when YUV422
is in use to keep its output clock aligned with the TMDS character rate.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..78473f9a0fce3 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -226,7 +227,14 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_=
encoder *encoder,
>  	}
> =20
>  	phy_cfg.hdmi.tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
> -	phy_cfg.hdmi.bpc =3D conn_state->hdmi.output_bpc;
> +	/*
> +	 * YUV422 always transmits two 12-bit components per clock cycle,
> +	 * regardless of the color depth, which from a rate perspective is
> +	 * equivalent to three 8-bit RGB components.  Force 8 bpc here to
> +	 * keep the PHY PLL output aligned with the TMDS character rate.
> +	 */
> +	phy_cfg.hdmi.bpc =3D (s->output_mode =3D=3D ROCKCHIP_OUT_MODE_YUV422 ?
> +				8 : conn_state->hdmi.output_bpc);
> =20
>  	ret =3D phy_configure(hdmi->phy, &phy_cfg);
>  	if (!ret) {

[Severity: High]
This isn't a bug introduced by this patch, but does calling phy_configure()
and modifying hdmi->tmds_char_rate inside atomic_check illegally commit
changes to global hardware tracking state?

In the DRM atomic KMS framework, atomic_check callbacks must be strictly
stateless and free of side-effects because they are frequently executed dur=
ing
test-only commits intended purely to validate configurations. By calling
phy_configure() here, the driver incorrectly modifies physical hardware
registers during a test phase, which can cause display glitches, sync loss,
or hardware lockups.

Additionally, upon success, the function updates the global state:

	if (!ret) {
		hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
		s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;

This permanently corrupts the driver's cached state. A subsequent real comm=
it
may skip hardware configuration entirely because hdmi->tmds_char_rate match=
es
the requested rate, leaving the device out of sync and breaking display
output. This fundamentally breaks compositors that rely on test-only commit=
s.


There is also another pre-existing issue earlier in the same function:

dw_hdmi_qp_rockchip_encoder_atomic_check() {
	...
	ingest_fmt =3D dw_hdmi_qp_rockchip_get_vop_format(encoder, conn_state);
	if (ingest_fmt < 0)
		return -EINVAL;
	...
}

[Severity: High]
This is a pre-existing issue, but does swallowing the error code here break
the wait/wound mutex backoff mechanism?

dw_hdmi_qp_rockchip_get_vop_format() calls drm_atomic_get_bridge_state(),
which uses wait/wound mutexes to lock bridge states and can return -EDEADLK
if the lock is contended. Returning -EDEADLK signals the DRM core to back
off, drop all locks, and retry the commit.

By checking if (ingest_fmt < 0) and returning a hardcoded -EINVAL, the
-EDEADLK error is swallowed. This breaks the DRM atomic commit WW mutex
backoff mechanism, causing valid userspace commits to fail spuriously with
-EINVAL under lock contention when multiple threads or processes attempt
atomic commits concurrently.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-dw-hdmi-qp=
-yuv-v4-0-fb45bf4147eb@collabora.com?part=3D12

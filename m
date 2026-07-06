Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53795C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E0A10EA9E;
	Mon,  6 Jul 2026 19:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CA5ly8zC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1404A10EA9E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 19:43:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D481740F1C;
 Mon,  6 Jul 2026 19:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D871F000E9;
 Mon,  6 Jul 2026 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783367018;
 bh=LpYBDzzTpttvxZ5Prf6UTUzPZ6dzUGSbel8XI7kLx+c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CA5ly8zCxElI0S9SwfsRdKOPley0dGdAR4UN/USh7CXrLnT7DufZzWgpPo4f3VBwT
 oEoXXCQhH0IkSuVMGO3+zLxy37q6dTyt1SxU8ta6wGhmQKk6tsOpWucJiww8fvwWn8
 q7nBJnQDRLGC3XxVcyxPC1i/k8x0XgunsaUK7WFFOZ2HmnQ/ro3qdMZu328lsbPI9d
 DW22fhWhkAyExxKGm+qO+PV2ysz+ehLCLgme+UOEfjYXTPDURMBBGLdDX+R2eGSISY
 ejY4Chzb6siLy+GfhGG1P+kS15rCgAmvXIBreSeuK2l6FNPUDfPV33CZd6FZ+xavAk
 q/B6AzlWL/FGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] drm/rockchip: dw_hdmi_qp: Support 10-bit
 YUV422 output format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-dw-hdmi-qp-yuv-v2-11-b91beb33dedf@collabora.com>
References: <20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com>
 <20260706-dw-hdmi-qp-yuv-v2-11-b91beb33dedf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 19:43:37 +0000
Message-Id: <20260706194338.68D871F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `atomic_check` callback incorrectly modifies driver private ha=
rdware state (`hdmi->tmds_char_rate`) and invokes PHY configuration functio=
ns (`phy_configure`), violating the stateless nature of atomic checks.
--

commit 6a5a6d9518ed6863c0bd7d0093aee570c295458a
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format

This commit adds support for 10-bit YUV 4:2:2 output to the DW HDMI QP
encoder by configuring the PHY with 8 bpc when YUV 4:2:2 is in use. This
keeps the output clock aligned with the TMDS character rate.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..78473f9a0fce3 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -215,6 +215,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_e=
ncoder *encoder,
>  		s->output_mode =3D ROCKCHIP_OUT_MODE_AAAA;
>  		break;
>  	case MEDIA_BUS_FMT_UYVY8_1X16:
> +	case MEDIA_BUS_FMT_UYVY10_1X20:
>  		s->output_mode =3D ROCKCHIP_OUT_MODE_YUV422;
>  		break;
>  	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
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
>  		hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;

[Severity: High]
This isn't a bug introduced by this patch, but does this violate the DRM
atomic API contract?

Modifying physical PHY hardware state and persistent driver state
(hdmi->tmds_char_rate) during the stateless atomic check phase could cause
problems if userspace issues a test-only atomic commit.

If a compositor issues DRM_MODE_ATOMIC_TEST_ONLY, phy_configure() will prog=
ram
the PHY hardware and hdmi->tmds_char_rate will be mutated. When the test-on=
ly
commit is discarded, the PHY is left in an unexpected state.

A subsequent real commit might then hit the fast-path check earlier in this
function:

    if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
        s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
        s->bus_format =3D=3D ingest_fmt)
            return 0;

and skip PHY configuration entirely, leaving the hardware incorrectly
configured.

Could this lead to hardware misconfiguration, visual glitches, or black
screens?

>  		s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;
>  		s->output_bpc =3D conn_state->hdmi.output_bpc;
>  		s->bus_format =3D ingest_fmt;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-dw-hdmi-qp=
-yuv-v2-0-b91beb33dedf@collabora.com?part=3D11

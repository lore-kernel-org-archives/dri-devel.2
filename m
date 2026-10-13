Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85F1CC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158BD10E173;
	Tue, 13 Oct 2026 23:04:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2819510FA2D
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:04:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E96C041330;
 Tue, 13 Oct 2026 23:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E3E1F000FF;
 Tue, 13 Oct 2026 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791932647;
 bh=XcrHCguC6sgAHfwM3zk2+fPmspvT64Oze4rNPv6wWVE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZtPE9HtG14tbOQCUF1r2zsrXO5q6AyYvrOcft3x+aID1pK6yZcS6TzdC+A8Jgu8g6
 VftXVmr149Gtlj/qB1zEvYp9idKf8u98hGo/kFA3fl6d41q7yhiF3xIMwbq5HpFJ7r
 HaSBwe+2mrtBM1pNZHJuycFTD2BSEkTT5DHzwfKY8DCmviiRpmBE/1gQfiSlPFzIHV
 A54Spbt7AwxGNLJVEwqHWPec0CO7Aw4LJUyrlgjLW5hGU0fLVJV0Yrq3durSHr59eU
 kp+FjfEMmB1mLqsVMbeiDc6Efv/TdJinzpcaQpOhZ1QWlWIm79DcU/QUto/SaBtzb/
 LaTdvSF+IAfHw==
Message-ID: <sashiko-outbox-170620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/15] drm/rockchip: dw_hdmi_qp: Do not mask error
 code in atomic_check()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-12-6fab0fe43a9b@collabora.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-12-6fab0fe43a9b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:04:06 +0000
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
- [High] drm/rockchip: dw_hdmi_qp: state corruption in atomic_check()
--

commit af42e0a2c16e4fdcedcd0540fb2c150fc25ebb0c
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Do not mask error code in atomic_check()

This commit changes dw_hdmi_qp_rockchip_encoder_atomic_check() to
propagate the error code returned by dw_hdmi_qp_rockchip_get_vop_format()
instead of masking it with -EINVAL. This ensures that -EDEADLK can be
propagated up to the DRM core to trigger the ww_mutex backoff mechanism.

Link: https://lore.kernel.org/all/20260902230603.AF5C61F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index f2a1ea8dfefa5..db1933d75ced5 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -203,7 +203,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_e=
ncoder *encoder,
> =20
>  	ingest_fmt =3D dw_hdmi_qp_rockchip_get_vop_format(encoder, conn_state);
>  	if (ingest_fmt < 0)
> -		return -EINVAL;
> +		return ingest_fmt;
> =20
>  	if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
>  	    s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&

[Severity: High]
Does this function improperly mutate hardware state during the
validation-only atomic_check phase?

The DRM atomic framework uses atomic_check for configuration validation,
which executes during TEST_ONLY commits that are never applied to hardware.

However, further down in dw_hdmi_qp_rockchip_encoder_atomic_check(), the
code calls phy_configure() and updates global driver state:

	ret =3D phy_configure(hdmi->phy, &phy_cfg);
	if (!ret) {
		hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
		s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;
		s->output_bpc =3D conn_state->hdmi.output_bpc;
		s->bus_format =3D ingest_fmt;
	} else {

If userspace issues a TEST_ONLY commit with a new mode, the hardware PHY
state and driver tracking (hdmi->tmds_char_rate) are modified to reflect the
test configuration.=20

If the commit is then aborted, the hardware state and driver tracking become
out of sync.

Could this cause a subsequent valid commit to break display output by
incorrectly skipping the necessary configuration due to the fast-path
check shown in the diff above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-dw-hdmi-qp=
-yuv-v5-0-6fab0fe43a9b@collabora.com?part=3D12

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F2C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE0010E698;
	Mon, 20 Jul 2026 06:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QY8+K08b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C1410E698
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0A2042B19;
 Mon, 20 Jul 2026 06:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BAC1F000E9;
 Mon, 20 Jul 2026 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528848;
 bh=q1oDEcMVI65Rk7a1GVyUvqpjHSuPXlEigBs5pTApcYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QY8+K08b3zuK3foYWo5IWV0hiK+vUD5Dwm2jfxdD4YcGxwuH22A96nkcawJA7Qbvo
 o3EK8bGHX0Vp99q2FH9+OBBzMhgCT3AcguvFZmra4EfobdJ9YRxsXRz9ytQawdQm6W
 IwTewI3pTuYilgWAlS7UR0mI1s+dpgf1OaWc20XjqJs//Iz80XrR9tNUMQyzsVE2OB
 SaxYpLcUDRFssCJwIz3cQHBHB0hmc3At0ZZ6lcGbkUYld7rgn60GKXBNAOiKIUxRgY
 JZzwWTHrWdpRfNLnq93wVK898Bb27M1/tD892/kBmeO85YKRKCRC4sAOV7hudUL6oJ
 dhD+7tZDH42RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] drm/msm/dp: split link setup from source params
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-6-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-6-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:27:28 +0000
Message-Id: <20260720062728.89BAC1F000E9@smtp.kernel.org>
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
- [Medium] msm_dp_ctrl_config_ctrl_streams() performs an incomplete Read-Mo=
dify-Write (RMW) on REG_DP_CONFIGURATION_CTRL without clearing stream-speci=
fic bitfields, leading to potential hardware state corruption.
--

--- Patch [6]: [PATCH v8 06/15] drm/msm/dp: split link setup from source pa=
rams ---
commit ea5efedb46078b56862c196153fb89423c8cb660
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: split link setup from source params

msm_dp_ctrl_configure_source_params() should only handle stream-related
configuration. Move the link setup out of it so MST can program link and
stream settings separately.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index ac24c958852b8..711579de899d8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -482,10 +482,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct ms=
m_dp_ctrl_private *ctrl,
> =20
>  static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_priva=
te *ctrl)
>  {
> -	msm_dp_ctrl_lane_mapping(ctrl);
> -	msm_dp_setup_peripheral_flush(ctrl);
> -
> -	msm_dp_ctrl_config_ctrl_link(ctrl);
>  	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);

[Severity: Medium]
By splitting the link setup from the stream setup here, are we exposing an
incomplete read-modify-write in msm_dp_ctrl_config_ctrl_streams()?

When MST programs the link and stream settings separately,
msm_dp_ctrl_config_ctrl_streams() will be called independently. Looking at
msm_dp_ctrl_config_ctrl_streams():

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_config_ctrl_streams() {
    ...
    config =3D msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);

    if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
        config |=3D DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */

    tbd =3D msm_dp_link_get_test_bits_depth(ctrl->link,
                                          msm_dp_panel->msm_dp_mode.bpp);

    config |=3D tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
    ...
}

Since this function reads the register and bitwise-ORs the new values
without clearing the existing stream-specific bitfields (like the BPC or
YUV bits), won't this cause bit accumulation and hardware state corruption
across multiple streams if the link isn't reset in between?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D6

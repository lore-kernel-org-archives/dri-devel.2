Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0574CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A4A10EA02;
	Wed, 30 Sep 2026 12:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e+EVQvjN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318FF10EA02
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:59:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5541C602A8;
 Wed, 30 Sep 2026 12:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB16A1F00893;
 Wed, 30 Sep 2026 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790773183;
 bh=u8MfOCK9GEaHzpm/Nnj1foHMSAs7Yt/Gx1z1YfWV/AU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e+EVQvjN2IYCdXmtZTBx/+FTEQK3Np2GjFyjFJB4jcy5GcFapyHwrPRuWYHOaGYVo
 8WJM1aDibGyAWaYF7jxSJkR2kX+XPl8BNTbXeBqgHshGy+lf7QKPCUM9CD0zqCVkw/
 FdPtmQVG8RptK7rS6S6g3HUWmzc98UUpP+VEb3+0xt/dqsS0TxtKCcRNY3b5G60za6
 Qw8KkTjJjCvj2XPMWxjbmGp2bmgnTu1zv0pG2Yj/shHs6GSjIPp1GamjE4FyCmzyrQ
 x/BqswSLeBet7oVC0SS03I+qnTcRZTvWoIeW6hXsLP8uyxtOuwiXQU0oAapQ6i7WNE
 DrVkEvF8pYrWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] drm/msm/dp: Unwind resources when enabling a
 stream fails
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-msm-dp-hdr10-v1-5-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-5-dbbf8b2b42bc@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 12:59:42 +0000
Message-Id: <20260930125942.EB16A1F00893@smtp.kernel.org>
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
- [Medium] drm/msm/dp: missing clear of DPCD training pattern on retrain fa=
ilure
--

commit 9215bc6b24d793ba7f4c076d150d2b4195e8af3e
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Unwind resources when enabling a stream fails

This patch adds tracking for DP stream power references and link startup=20
to properly unwind resources on failure. It consolidates the rollback=20
path and propagates error codes from PHY initialization, power-on, and=20
stream retraining.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -2583,8 +2595,11 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ct=
rl *msm_dp_ctrl,
>  		}
>  	}
> =20
> -	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
> -		msm_dp_ctrl_link_retrain(ctrl, panel);
> +	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl)) {
> +		ret =3D msm_dp_ctrl_link_retrain(ctrl, panel);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	/* stop txing train pattern to end link training */
>  	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);

[Severity: Medium]
Does this early return skip clearing the training pattern on the DP sink?

When msm_dp_ctrl_link_retrain() fails and returns an error, the function=20
now returns early and bypasses the required call to=20
msm_dp_ctrl_clear_training_pattern().=20

This leaves the DP sink in an incomplete link training state because the=20
DPCD DP_TRAINING_PATTERN_SET register is not explicitly reset to=20
DP_TRAINING_PATTERN_DISABLE.=20

Could this cause the sink to malfunction, remain blank, or become=20
unresponsive on subsequent link initialization attempts? Should the hardwar=
e=20
training state be cleared before propagating the error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-msm-dp-hdr=
10-v1-0-dbbf8b2b42bc@radxa.com?part=3D5

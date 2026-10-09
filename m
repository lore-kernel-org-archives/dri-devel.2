Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7612CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FDD10FE43;
	Fri,  9 Oct 2026 03:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lY8nalWr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FBA10FE43
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:34:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2674D60DB0;
 Fri,  9 Oct 2026 03:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2DA1F000FF;
 Fri,  9 Oct 2026 03:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791516849;
 bh=/bDLIWmosHc7HMVZ5vK7Hifmrc/1cNgzcETy2OmyHQ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lY8nalWrmbbnwdP3Cc32d/F8XY7jY7kqtm7/vsgqpMfXW4dFQI6hWMwaJcuElMFlS
 nXu8SqSYou/Idmd6QTXG53MHDMRFK5GFmT3Hr7bwFRwdbXuuEacUytxRzDDBvNV487
 NfGdZyuoByBTzXki8v7/PZ6iT4/6M8+LnztzlvvVAatcKUATIKNZ7zs15/UKn0gk6f
 KTGF2eqE9qG1nxMEOJMq1eslenGPRuhNVtciqTo//0gSRg481dObLOmG8atxwZbFim
 HRRcH8L0Eb0y+rtAbl7WBl4nThymwZ48vLANlVNwKCUiL7RKIgfIlz2jUCF8/fo+J/
 lYg8LAcaEPxVA==
Message-ID: <sashiko-outbox-164772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/20] drm/msm/dp: Disable PSR for YUV420 streams
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-16-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-16-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:34:09 +0000
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
- [Medium] drm/msm: endianness bug on DP_PSR_EN_CFG write using u32 pointer
--

commit d1403cc5c58c4528368941f08f1ea1ec332d1a49
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Disable PSR for YUV420 streams

This commit disables self-refresh for YUV420 streams because their
colorimetry VSC packets cannot share the automatic PSR packet generator.
It computes eligibility after common atomic checks and restores PSR
configuration accordingly.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 783cafb223748..82ef8e4055431 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -1923,15 +1923,20 @@ void msm_dp_ctrl_config_psr(struct msm_dp_ctrl *m=
sm_dp_ctrl,
[ ... ]
> -	cfg =3D DP_PSR_ENABLE;
> +	cfg =3D enable ? DP_PSR_ENABLE : 0;
>  	drm_dp_dpcd_write(ctrl->aux, DP_PSR_EN_CFG, &cfg, 1);

[Severity: Medium]
Could this silently write 0 and fail to enable PSR on big-endian platforms?

The variable cfg is defined as a u32 at the beginning of
msm_dp_ctrl_config_psr(). When its address is passed to drm_dp_dpcd_write()
with a size of 1 byte, little-endian systems will correctly read the least
significant byte containing the enable bit.=20

However, on big-endian systems, taking the address of a u32 and reading 1
byte will read the most significant byte instead (which is 0x00).

Would using a u8 variable or drm_dp_dpcd_writeb() avoid this structural
mismatch and ensure the correct byte is written regardless of architecture
endianness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D16

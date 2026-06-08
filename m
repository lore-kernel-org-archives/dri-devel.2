Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B847CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FAA10F726;
	Mon,  8 Jun 2026 16:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nm9aOlTc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B745810F726
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:40:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DE44434CE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501561F00893;
 Mon,  8 Jun 2026 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936847;
 bh=+JQbRCaOTBq6QuBxTqDyTZIjtKySF7L3AtlNtRcWB6I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nm9aOlTcrAwjNvgwjyktRwozXsBaqQIqDOo5MFIjvfiezE82Lq4jHpWN90uhIX4/2
 HZcw0oCzBmoPgaqAKk/W1gXaM3prtBcKc1N1aiL+v3LlQT9z8kD5StQrHkq8jxHWWt
 C74d+W2pFIW8B43puJm1D8hUSGpFqhIcnF8YjVL2ojHDftpZvHcKPveWsmfRp3tjjj
 mMfIgY1zz4q5HtKRbriYIJnBE4vlhYlJsJ+l56T4/7Jffw5BArNgPihoe9eLRd/QQW
 hqWD+qpR8grcMlc+HAoip+1UmUcV5qX+DPHs4WF3CH57LFG6RakpJToR2t3pGmBGCP
 atA1e6M2vurbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 33/78] drm/bridge: dw-dp: Switch to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-33-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-33-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:40:46 +0000
Message-Id: <20260608164047.501561F00893@smtp.kernel.org>
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
- [High] Missing completion reinitialization in AUX transfer exposes driver=
 to spurious immediate returns
--

commit a0eb2a01158c71ba22ad17e3ef567be4fe4e603f
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: dw-dp: Switch to atomic_create_state

The commit replaces the deprecated atomic_reset callback and its helper
with atomic_create_state and its corresponding helper in the Synopsys
DW DP driver.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 21541be094c47..98437dc33d4db 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

This isn't a bug introduced by this patch, but I noticed a pre-existing
issue while reviewing this file:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_transfer() {
    ...
	if (msg->size > 0)
		value =3D FIELD_PREP(AUX_LEN_REQ, msg->size - 1);
	else
		value =3D FIELD_PREP(I2C_ADDR_ONLY, 1);
	value |=3D FIELD_PREP(AUX_CMD_TYPE, msg->request);
	value |=3D FIELD_PREP(AUX_ADDR, msg->address);
	regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

	status =3D wait_for_completion_timeout(&dp->complete, timeout);
    ...
}

[Severity: High]
Does this code need a call to reinit_completion() on dp->complete before
triggering the hardware transfer with regmap_write()?

If a previous transfer times out (leaving the completion count at 0) and
the interrupt handler fires later, complete() will increment the completion
counter to 1.

The very next call to dw_dp_aux_transfer() would consume this leftover
completion and immediately return success without actually waiting for the
new transaction to finish.

Could this cause the driver to read an incomplete hardware status or stale
data, leading to unpredictable AUX failures and display initialization erro=
rs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D33

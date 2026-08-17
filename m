Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7146DC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C4410E307;
	Mon, 17 Aug 2026 03:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tz2sexB1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF1610E307
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 03:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0487A60120;
 Mon, 17 Aug 2026 03:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3381F000E9;
 Mon, 17 Aug 2026 03:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786936894;
 bh=EdtyiNPZiUJ5ujHexjdE42vQ1xBqABkT2HU5ycqXE1A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tz2sexB1CGqZ7qLyOi5NlcZfoJYkcBPwVlEvKOs2sB+d6XJIt6c5lwM6tvdX2EmKM
 68i5/OtDa+mhfOh1Mdq9JzCmiubcvawSsa0pYZKup3IqbRLvracWKruR+AeGoIMb5o
 PX6DxZh5rRUauzPchrgW/i2fR8oOkBizADX8wfDfG7q8wsFqX3kKpOgt549VnCuivn
 4LoEL1dBYG4lcmc2XqYdlvoZtSMP2rWIzew6gIl4xz7oIBU8W2PBj402EyauAzDu3u
 ZSKiOxt0YN+cdpymfGtiaK6Mv87UC1ct/t8xjhgvdxG55kvWm7lIGBLD8JR7Yd8VBE
 Tdfxv7c6mtprQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eDP link
To: rh_king@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817031640.2097973-1-rh_king@163.com>
References: <20260817031640.2097973-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 03:21:33 +0000
Message-Id: <20260817032134.4D3381F000E9@smtp.kernel.org>
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
- [High] The function `dpcd_set_link_settings()` returns an uninitialized `=
status` variable on its success path.
--

--- Patch [1]: [PATCH] drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eDP l=
ink ---
commit ea92b689001bf0ca86b430f7c8b3fa5b47810b12
Author: Kean Ren <rh_king@163.com>

drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eDP link

This commit fixes PSR AUX WARNs on unhealthy eDP links by returning early
from dpcd_set_link_settings() on the first DPCD write failure, and by
short-circuiting edp_setup_psr() when the link is inactive.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_traini=
ng.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> index 04eedec8a230c..501d2556e06c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> @@ -1097,6 +1097,7 @@ enum dc_status dpcd_set_link_settings(
>  {
>  	uint8_t rate;
>  	enum dc_status status;
> +	enum dc_status result;

[Severity: High]
Since the assignments in this function were changed from status to result,
is status left uninitialized?

If all DPCD writes succeed, the function completes by returning status at t=
he
end of the function:

dpcd_set_link_settings() {
    ...
    return status;
}

Does this cause dpcd_set_link_settings() to return random stack memory on t=
he
success path, potentially causing callers to interpret a success as an error
and fail the display initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817031640.2097=
973-1-rh_king@163.com?part=3D1

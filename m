Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91436CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F181210FE4B;
	Fri,  9 Oct 2026 03:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LYhF0b/s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D7510FE4B
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:44:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1CAC60DB1;
 Fri,  9 Oct 2026 03:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7081F000FF;
 Fri,  9 Oct 2026 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791517468;
 bh=ic10yKCOaGvIjB1QnKoIJRXGkmtrTZldaiDdjxVQR5E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LYhF0b/sBrOZ23ybZmMPD3LQJ8cNcUq5hNBk+u0NOSliz0JZc7XS7QOJu1y65GlRg
 nUFctMCH7ioPmREzwcYsvFtuQlquHDHlmuMTh/gyKyqNSjEe+1XDVXTnBQMp6v8psz
 +XDU+eYxAJ5Deu/xvooCNQSc8w6db0+L501bS7iVjZbsq6wWmYzQrje3Ub9avaspZ7
 MOAZ4Z6YAkIqeRZ+9s3h0mg3lAsZsn+O7YjjMmlsIt6QnkqqsEO31Pybu8khhfY2Zr
 UOA3W3EHmUXp8Mxlo1q+HM7GHM4yb/CfAP9jmQ1YhMeId6ONEaBAozCG8TXT8rnCFL
 kEhtzGrtJ/2GA==
Message-ID: <sashiko-outbox-164787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/20] drm/msm/dp: Serialize video test state changes
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-19-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-19-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:44:27 +0000
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
- [Medium] drm/msm/dp: missing plugged_lock in msm_dp_panel_get_mode_bpp() =
leaves TOCTOU race
--

commit 016f17497dc5f474b86e152324fba4d9409781b6
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Serialize video test state changes

This commit serializes video test state access by routing it through the
display and using plugged_lock for HPD and debugfs updates. This prevents
race conditions during mode programming.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 34e1c48cdd794..c51d033598a5b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -689,8 +699,10 @@ static int msm_dp_display_set_mode(struct msm_dp *ms=
m_dp_display,
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	if (msm_dp_display_check_video_test(msm_dp_display))
> -		bpp =3D msm_dp_display_get_test_bpp(msm_dp_display);
> +	guard(mutex)(&dp->plugged_lock);
> +
> +	if (dp->panel->video_test)
> +		bpp =3D msm_dp_link_bit_depth_to_bpp(dp->link->test_video.test_bit_dep=
th);

[Severity: Medium]
The commit message notes that reading the test flag and requested depth
separately allows values to change mid-read, and this function was safely
updated to hold plugged_lock.

However, does this patch miss the similar reads in msm_dp_panel_get_mode_bp=
p()
in drivers/gpu/drm/msm/dp/dp_panel.c?=20

That function is called during DRM mode validation and still reads these
fields sequentially without holding plugged_lock:

drivers/gpu/drm/msm/dp/dp_panel.c:msm_dp_panel_get_mode_bpp() {
    ...
    if (msm_dp_panel->video_test)
        bpp =3D msm_dp_link_bit_depth_to_bpp(
                panel->link->test_video.test_bit_depth);
    ...
}

If HPD or debugfs updates these values concurrently, could this function
observe a torn state where the test flag is true but the bit depth has not
yet been updated, causing it to incorrectly accept or reject a mode based
on inconsistent parameters?

>  	else
>  		bpp =3D state->bpp;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D19

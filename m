Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF24606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIDulSOK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDE11122BE;
	Fri, 27 Nov 2026 07:35:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F311123E9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AA49454B8;
 Fri, 27 Nov 2026 07:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8151F00898;
 Fri, 27 Nov 2026 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795764929;
 bh=gzlsOM3j+CyftA+oag0y/h90CkyJtN0Wnr9LmkhdeVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YIDulSOKR/VuPyccJLD3TDxEvFXseotmlMG/o+UNjeCjPvGhZZ91YJN8bfydM/RWl
 KTMCu3yLQlG6kc95rcv/GkRvOuk6xXbkbVitl1vWhB0lJ78Wbm9a4lXLKTEbKw985w
 D9h02jG9+4tt3usfPlUhKgY7Y1TYKKdTWPMPaR+YnKyjJ0kr+P+uKRr2oECJnRqzvM
 0dGsKdFBUcrF1HhudcDje7XR15FKH9lqWjjDBYGJr3wU6N/u9a3u+grWCb3O6vehZw
 pLZArTLzwY7dHS8CKTPRAmOnDo/fPU59p8BEmewRgcQ9Cvddt7ZuIEWG/4fqbNQMG4
 PGBlb8Z5HKp2Q==
Message-ID: <sashiko-outbox-236812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: Skip IRQ_HPD handling when PHY is off
To: "naidu nama" <naidu.nama@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261127072055.2144407-1-naidu.nama@oss.qualcomm.com>
References: <20261127072055.2144407-1-naidu.nama@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:35:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/msm/dp: msm_dp_bridge_hpd_notify() skips unplug when PHY is
  off
- [Medium] drm/msm/dp: unlocked state check in
  msm_dp_bridge_hpd_notify() races
- [Low] drm/msm/dp: missing Fixes: trailer on HPD handling bug-fix
  commit
--

commit 1a57d42c93a148284843b0d84147167133e520b0
Author: naidu nama <naidu.nama@oss.qualcomm.com>

> drm/msm/dp: Skip IRQ_HPD handling when PHY is off
>
> When DP is plugged, IRQ_HPD is delivered when PHY is in uninitialized
> state, In this case avoid runtime-resuming the controller and
> attempting AUX access for an already-plugged, while the
> PHY is uninitialized state.
>
> Signed-off-by: naidu nama <naidu.nama@oss.qualcomm.com>

[Severity: Low]
This looks like a bug fix for the HPD rework.  Should this include a
Fixes: tag for 5043357e75ba ("drm/msm/dp: rework HPD handling") or
3ea2d1c3d154 ("drm/msm/dp: turn link_ready into plugged")?

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index c0c150e2c5758..79169c1f95a57 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1607,6 +1607,11 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *b=
ridge,
>  	struct msm_dp_display_private *dp =3D container_of(msm_dp_display, stru=
ct msm_dp_display_private, msm_dp_display);
>  	u32 hpd_link_status =3D 0;
> =20
> +	if (dp->plugged && !dp->phy_initialized) {
> +		drm_dbg_dp(dp->drm_dev, "skipping IRQ_HPD in an inactive state\n");
> +		return;
> +	}

[Severity: High]
Does this early return also drop unplug events when the display stream is
disabled?

When an external DP output is disabled while a sink is still connected,
msm_dp_display_unprepare() calls msm_dp_display_host_phy_exit(), leaving
dp->plugged set to true and dp->phy_initialized set to false.  If the cable
is unplugged in that state, msm_dp_bridge_hpd_notify() is called with
status =3D=3D connector_status_disconnected, but this check returns before
msm_dp_hpd_unplug_handle() can run (even though msm_dp_hpd_unplug_handle()
does no AUX transactions).  That leaves dp->plugged stuck at true, skips
audio and subconnector disconnect cleanup, and leaks the runtime PM
reference acquired at plug time.

Should this check be limited to IRQ_HPD (or moved into
msm_dp_irq_hpd_handle()) so disconnect notifications still run
msm_dp_hpd_unplug_handle()?

[Severity: Medium]
Can reading dp->plugged and dp->phy_initialized without dp->plugged_lock
race with concurrent unplug or stream teardown?

CPU0                                  CPU1
msm_dp_hpd_unplug_handle()
  mutex_lock(&dp->plugged_lock)
  msm_dp_display_host_phy_exit(dp)
    dp->phy_initialized =3D false
                                      msm_dp_bridge_hpd_notify()
                                        if (dp->plugged &&
                                            !dp->phy_initialized)
                                          return;  <-- drops HPD event
  ...
  dp->plugged =3D false
  mutex_unlock(&dp->plugged_lock)

msm_dp_hpd_unplug_handle() clears dp->phy_initialized under
dp->plugged_lock before performing audio and runtime PM teardown and
clearing dp->plugged.  Conversely, if msm_dp_display_unprepare() calls
msm_dp_display_host_phy_exit() right after msm_dp_bridge_hpd_notify()
passes this unlocked check, msm_dp_irq_hpd_handle() will still proceed with
AUX transactions while the PHY is uninitialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127072055.2144=
407-1-naidu.nama@oss.qualcomm.com?part=3D1

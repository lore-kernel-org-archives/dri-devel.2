Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA39C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F276810E7CA;
	Mon, 31 Aug 2026 10:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FEdAvla4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287D010E7CA
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:16:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CBF360212;
 Mon, 31 Aug 2026 10:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A871F000E9;
 Mon, 31 Aug 2026 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788171358;
 bh=sAVmy7Smr4hbhYp8PIzTHP45X6rLtU+G7xQ+XJswdFk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FEdAvla4Wdqy150Xc9xf9aL2s4XbMRYj0MoWnlTOMnDoa90hg/+ulXQcQCZNAzJuI
 Z806oLDd8Nllec4oxtFF+wBUyGV422fjkB7u41fzkunYiRU65EPHQm4TvvV7rQud0Q
 67Zq58TaLXrx1AMLL1k+E46pC9Bu5khfgZS1+1H3zQyQi5zLbO3O32IsPszu7NCXEz
 xJeE+zhuwUvDJRG2SvWWZ8haBv6RelXxyAk3k4TjIv923RZx4yYBbYEs4TIq3nT37n
 zZnB3MyQgkry72ZeGx6jujfUg9YG2jS5VHrMpDX5fA4je4tQAvZnZqnAAWlVJWnRfg
 UOxJoyxLuY5Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 29/29] drm/msm/dp: mark the SST connector
 disconnected when MST is enabled
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-29-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-29-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:15:58 +0000
Message-Id: <20260831101558.C6A871F000E9@smtp.kernel.org>
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
- [High] Acquiring `mode_config.mutex` in `msm_dp_display_mst_enable()` int=
roduces an AB-BA lock inversion with `plugged_lock`, leading to a hard dead=
lock.
--

commit 48ec7f7903ee88df5ef42da3519327d574e9dc29
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: mark the SST connector disconnected when MST is enabled

This commit sets the SST connector state to disconnected immediately after
MST is initialized. This is intended to prevent the detect path from
introducing a transient connected to disconnected state change that could
result in an unnecessary hotplug event.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index d2b2c7141db0f..d207ec3ca8bf2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -290,6 +290,10 @@ static void msm_dp_display_mst_enable(struct msm_dp_=
display_private *dp)
>  	}
> =20
>  	msm_dp->mst_active =3D true;
> +
> +	scoped_guard(mutex, &msm_dp->connector->dev->mode_config.mutex)
> +		msm_dp->connector->status =3D connector_status_disconnected;

[Severity: High]
Does acquiring mode_config.mutex here in msm_dp_display_mst_enable() introd=
uce
an AB-BA lock inversion with plugged_lock?

During a userspace probe (like xrandr), the DRM core holds mode_config.mutex
and calls down to the bridge detect function in
drivers/gpu/drm/msm/dp/dp_display.c, which establishes this lock ordering:

Thread 1 (probe):
drm_helper_probe_single_connector_modes() (acquires mode_config.mutex)
  -> drm_bridge_connector_detect()
    -> msm_dp_bridge_detect() (acquires plugged_lock)

However, on a hotplug event, the IRQ thread handles the plug event and calls
into the driver with plugged_lock held, before calling this function:

Thread 2 (hotplug):
drm_bridge_connector_handle_hpd() (unlocks mode_config.mutex)
  -> drm_bridge_connector_hpd_notify()
    -> msm_dp_bridge_hpd_notify()
      -> msm_dp_hpd_plug_handle() (acquires plugged_lock)
        -> msm_dp_display_mst_enable() (acquires mode_config.mutex here)

If a DP cable is physically plugged in while a background process or
desktop environment concurrently probes display connectors, can these threa=
ds
deadlock?

> +
>  	msm_dp_mst_display_set_mgr_state(msm_dp, true);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D29

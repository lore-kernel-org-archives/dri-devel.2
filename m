Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7177BCA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C169210ECD8;
	Tue, 29 Sep 2026 04:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j/h4tO67";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 929A210E538
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:54:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1806060515;
 Tue, 29 Sep 2026 04:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51801F00893;
 Tue, 29 Sep 2026 04:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657669;
 bh=doOQ+W7YJLydmhEZehbQsuwfK0ln6RepArfRhGQLNeM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j/h4tO67tn8+PSyTo7RovJ3YjHh238HvgD61XVY0ZaRoZcVxj0kReMvUwdpT6SOBx
 Wix1rsMlUnv+fpyzHpM5djMxLPqY6lXJY3l8uJXfYIqeq47jD/MzH5iN05g8uLaIbT
 wfazdggGL6qP+G3boYg3OXa0rBXaYDeg2VWLRMsxxIAL17OkRUEeEev04uow3RVs2G
 6AhObCU3LqC7tHQkrsurya0Thcnjf6xro5jbsNB9yfOHYe3nljbiKNe5vYguVR75s9
 JaezRojKtmV6nA8TPsKlukd4QU+gTtBbucbYL/TQ0xVXWc20DfemK3vs7v328e3Jb4
 it4+2cNH0UAyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 32/35] drm/msm/dp: mark the SST connector
 disconnected when MST is enabled
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-32-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-32-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:54:29 +0000
Message-Id: <20260929045429.A51801F00893@smtp.kernel.org>
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
- [High] drm/msm: AB-BA deadlock between mode_config.mutex and plugged_lock
--

commit 44822203f1a87c392f32673917903210fbaa2c96
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: mark the SST connector disconnected when MST is enabled

This patch updates the SST connector state to disconnected immediately
after MST is initialized. This prevents the polling logic from observing
a transient connected-to-disconnected transition and generating an
unnecessary hotplug event.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 0e8181932c27d..327777f5c95e6 100644
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
Does this introduce an AB-BA deadlock between mode_config.mutex and
plugged_lock?

When a DP MST monitor is hotplugged, the hotplug handler acquires
plugged_lock first and eventually calls down to msm_dp_display_mst_enable(),
which acquires mode_config.mutex here:

msm_dp_hpd_plug_handle()
  guard(mutex)(&dp->plugged_lock);
  ...
  msm_dp_display_process_hpd_high(dp);
    msm_dp_display_mst_enable()
      scoped_guard(mutex, &msm_dp->connector->dev->mode_config.mutex)

However, concurrently, the DRM subsystem probes display modes and holds
mode_config.mutex prior to calling the connector's detect callback. The
detect callback then attempts to acquire plugged_lock:

drm_helper_probe_single_connector_modes()
  ... (holds mode_config.mutex)
  msm_dp_bridge_detect()
    guard(mutex)(&priv->plugged_lock);

Can this lock inversion deadlock the system when DP MST monitors are
plugged in?

> +
>  	msm_dp_mst_display_set_mgr_state(msm_dp, true);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D32

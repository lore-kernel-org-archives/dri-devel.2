Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0CECA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1782810ECD3;
	Tue, 29 Sep 2026 04:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ncMy1CsZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FFD10ECD3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:51:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E56D60515;
 Tue, 29 Sep 2026 04:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA9D1F000FF;
 Tue, 29 Sep 2026 04:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657496;
 bh=zs/3Tryyeomj1fm+fD9e1V/cQ/NCPO4y5lWgpBxNpeI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ncMy1CsZI544WWZ+aNMqJUUcxgxZbItnAjM++hg3PPHcLFrZhPFNVl8RIknrCxOed
 ebrrhd0+GllnIZSG5xWMi35MXO0f0fcCkrT0AXjbxej/OIYR1D9U/hwBdwx29aJUQU
 7ZIqEMzNYpTpODj1cQMOjH6mAyN0GaYCUI7XZVNIGQlDBmJ+ROPhGf1OO8ZIjcpGHP
 D5WfOXzD7fmpbO+qxDiFgRCd9YDMTPaWThxgOtojogKwqxbC1st9sgTZZPj1tI7Kgi
 s/GGUnisIYc5tqYw4jfo5BKvJZFuqYqPDDJX/XNTx/A+49ztEKzWnd1AOXAUgFkxrb
 m3KKLmAxu13DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 25/35] drm/bridge_connector: suppress hotplug for
 IRQ_HPD without status changes
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-25-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-25-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:51:35 +0000
Message-Id: <20260929045136.0AA9D1F000FF@smtp.kernel.org>
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
- [Medium] drm: missing hotplug event due to TOCTOU race in HPD handler
--

commit c7445c99ee548cba258205accae2588f4d6fc9bb
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/bridge_connector: suppress hotplug for IRQ_HPD without status changes

This commit suppresses hotplug events for DP IRQ_HPD notifications if there
are no connection status changes. It checks the actual connector status
after handling the notification using the bridge detect callback. Hotplug
events are only sent if the connection state transitions, preventing
unnecessary reprobes.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -159,15 +159,28 @@ static void drm_bridge_connector_handle_hpd(struct =
drm_bridge_connector *drm_bri
[ ... ]
>  	mutex_lock(&dev->mode_config.mutex);
> -	connector->status =3D status;
> +	old_status =3D connector->status;
>  	mutex_unlock(&dev->mode_config.mutex);
> =20
>  	drm_bridge_connector_hpd_notify(connector, status, event);
> =20
> -	drm_kms_helper_connector_hotplug_event(connector);
> +	mutex_lock(&dev->mode_config.mutex);
> +	new_status =3D detect ? detect->funcs->detect(detect, connector) : stat=
us;
> +	connector->status =3D new_status;
> +	changed =3D new_status !=3D old_status;

[Severity: Medium]
Could this logic cause a missing hotplug event due to a race condition?

If old_status =3D A is read, the lock is dropped. During the execution of
drm_bridge_connector_hpd_notify(), a concurrent ioctl (like
DRM_IOCTL_MODE_GETCONNECTOR) might acquire the lock, probe the hardware,
update connector->status to B, and return state B to userspace.

If the hardware then changes back to A before this HPD handler reacquires
the lock, the detect call could return A. The new_status becomes A, and the
code calculates changed =3D (A !=3D A), which is false, suppressing the hot=
plug
event.

In this scenario, userspace tracks state B, but the kernel tracks state A,
and userspace never receives the hotplug event to notify it of the
transition back to A.

Should old_status be read within the second critical section just before
calling the detect function, so that we compare against the most recent
state?

> +	mutex_unlock(&dev->mode_config.mutex);
> +
> +	if (changed || level_hpd)
> +		drm_kms_helper_connector_hotplug_event(connector);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D25

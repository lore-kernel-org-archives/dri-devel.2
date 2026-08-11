Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37060C5B575
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8220210EAB6;
	Tue, 11 Aug 2026 07:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="khD8uNOg";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D3910E291
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 06:43:06 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-52d58d7aad6so664331cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 23:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786430585; cv=none;
 d=google.com; s=arc-20260327;
 b=DZ5DXFSUJGB+bvtFY74LXLY0b7aXjoKM331u8FO8anJNpEwgUOYObr1txFhRJ6jX+E
 lcbL7SM+IESxV0DYp6JDxDePy6XZXP4yb20nDGo9FDnXE+Twr7zXm2Lo0M7FOFEcEISV
 6KQlI3VQL7zFz8OcWrr3523f+S8M9Pf0w35pWh8r9L13EcDFhvGx/aTDQSIc8jBvHs66
 0Rk5d2vpWBFVeywECVqpU5eL8Q+tje60vxKvyKygPvY4fI+K7y5x5y6sbPe3nrR24eq6
 lfHo/dPeOvjlb3bdNqIW86MoRNsGeo8dNEpMG1MLS6Mj/H2jqw/NXBpijoDEvWozHKxO
 z4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CRgBsOr9tUnMXIdBw/25ujn1g858nS9XaW0F3ZHuDRE=;
 fh=2KhL3eVl44mWZxTUs4fuCdafA1yfdgPjy6XVV17TNtA=;
 b=IVokybOAWaQU+gLfLTrSUG+Gh9oajXCbjQ+A2UEpELnBGPlI0/WOzHd8qVFnyERhcp
 aSwY5O5uwXymEhLtdcaFK/6vOzJEU/TZ+EqEhmau7xdO84m0+kpT3429HBl/G92T+H0R
 kx6QLM8sR+mdSt6c8AzhQ4iapgNughuE73XcihSvvi7F9IhDOubJ9y2zjgb+LYwdrTtY
 9tD/2na2smr2+kMtoa1N77ECxt4/3haTDZKi2829Z45uwTepBCQElmm2OmhmqL5x0v4z
 MavMKnnnDZbjJ1F6PDww9fRLpm0JsUDgZtBLGy2uVOE93fHdJ3ApqTbR8D5XJheuXmwc
 mZhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786430585; x=1787035385; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CRgBsOr9tUnMXIdBw/25ujn1g858nS9XaW0F3ZHuDRE=;
 b=khD8uNOgccaGlXkuFpZfGU46T8ExFSevUIN+7w0yqMcDm8YA9fsEhaA7OgTDQXL6oH
 KlACyd8zplfpqcrt+VptQWAhe/Pgod1bpLiSwUD4UxrrbG6rYYBeZOH/GV4KtBLlC3xz
 1ytOATvjeDsJpHr7eknWzVHWGwliyXRx1UdDhxHFczmb5najvlUV6Jhesew1M2MvrJeC
 bUsRGWg7JLLIfgox2TImVXjhAV6VWyPxU1Sdoc9WEXiKWrVZ6bI9CHdVd1CZRU1MbcTJ
 8bmBD4sbmks/hWy/6AY2CLrjURmTqKP8fC13BEqCHg9yXHwSZtBFInDNFGPPn1GYuH/H
 rH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430585; x=1787035385;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CRgBsOr9tUnMXIdBw/25ujn1g858nS9XaW0F3ZHuDRE=;
 b=j/H/lX/0s6ijsKiXl9f/+92PDwErJ0GK+UGcgvdQXRhAk/ApWAhzJFkvecJi40nS4+
 Xgl8stluPCaup1tRC+EWMkHFpkIkXi/M/uvO2kH+txnJAvWaEk64ExXZRKSRSEC+KyJP
 2JwP0CIV1tbK39GmI2R6x6D2n5vPQIyRJsShRZSRUa8MRPwPUomrk67xJIN9EqttGel4
 bsCx3D2no9BvxxUwGB6+fAFP0EvlXzoRfaKeE7unJrR84WSyG3cgj4KcGyUlRplpA9yg
 1X/zy7AIr3KFM8SpnKC9mWtvTaSz9sxhru/b0NBVpEJeirKatP8ZeZ79XXQb+FVYl5qx
 pQvQ==
X-Gm-Message-State: AOJu0YzZNflxY7P2wC4f0Eu4skbWEn4O2BETUcgxCQmivwJD26Xiz6L7
 UqTkZXHBOD2JywCE+Dq8xMN48UeWr0ryfLSBoKSpCWCEb03dMVNoPc7KF7XRBpsX/fSO0lBN8PD
 2n8AtSwjaQBOTjS9q/sxerMfprrH0Roo=
X-Gm-Gg: AR+sD13zAMhkChRGbMM8Prk/NtRAtgiTr2Ce89xRjJwAiwSlnVv3dq3XzY7cPd+6PA0
 p0FaPu/mRD3Lh6DOIeLmdZx0WTF6qHzGCpapnSx6YbjCw3GtUiV5uOW685yaQHO/H7qslyMAYL+
 vniNCf+I2+GBdR+FQeoh7GpAC1W8TnO1OSNcNX15r3hcvtlYvmWb67JJWE7BToUmNItJkPhQjJX
 PhLTOxc8U9dhtM42qqFqtwJDfYceBLNmTYL2RTS9oHcoL7t4/u8EJbrXn+fc3djMTzBlullf5ej
 ruizLXVTpJDM2SJ5vRc8gP/MpT2+SP/vTWV8qkxclCenppGPa//3B1Uag/r+e2jb/QfF3KnaGYj
 lxdea0t7oQRL35eZ9Lt6Rye1hKNY=
X-Received: by 2002:a05:622a:10a:b0:527:6dc7:5c5b with SMTP id
 d75a77b69052e-52d585e2c25mr7849061cf.21.1786430585364; Mon, 10 Aug 2026
 23:43:05 -0700 (PDT)
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Tue, 11 Aug 2026 14:42:52 +0800
X-Gm-Features: AUfX_mzkYL5dm3KUIE_vQtokvdamN0RJ_PQA6MSpWuKrnyDtP4JTVnXIL_QOEwo
Message-ID: <CAA2SOT7-Em=-ZY=66MA8xacAOZE+AQAx-gANJeVbpDY35jmApg@mail.gmail.com>
Subject: [BUG] drm/vkms: WARNING in drm_crtc_wait_one_vblank due to vblank
 timeout
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

I am reporting a WARNING triggered by a syzkaller reproducer in the
DRM/VKMS path on Linux 7.2-rc3.

The warning is emitted from drm_crtc_wait_one_vblank() because waiting
for one vblank on CRTC 0 times out:

faux_driver vkms: [drm] ERROR [CRTC:45] flip_done timed out
faux_driver vkms: [drm] vblank wait timed out on crtc 0
WARNING: drivers/gpu/drm/drm_vblank.c:1329 at
drm_crtc_wait_one_vblank+0x2f3/0x560

This looks like a VKMS / DRM fb-helper / DRM vblank interaction issue.
The reproducer opens DRM devices, queries KMS resources and plane
resources, and then issues DRM_IOCTL_MODE_SETCRTC with the returned
CRTC/plane identifiers. After that, drm_fb_helper_damage_work() runs
from the events workqueue and waits for a vblank through
drm_client_modeset_wait_for_vblank(), but no vblank is observed before
the timeout. Since panic_on_warn is enabled, the warning is converted
into a kernel panic.

A similar vblank timeout warning in drm_crtc_wait_one_vblank() may
have been reported before, but I can still reproduce this issue on
Linux 7.2-rc3.

Reproducer:
syz reproducer: https://pastebin.com/raw/HeCMiVFR
console output: https://pastebin.com/raw/Y5CinzRS
kernel config: https://pastebin.com/raw/Lqbb3fQn

Kernel:
HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)

Crash log:

[ 78.750312][T10019] faux_driver vkms: [drm] ERROR [CRTC:45] flip_done timed out
[ 79.792561][ T793] faux_driver vkms: [drm] vblank wait timed out on crtc 0
[ 79.796488][ T793] WARNING: drivers/gpu/drm/drm_vblank.c:1329 at
drm_crtc_wait_one_vblank+0x2f3/0x560, CPU#1: kworker/1:2/793
[ 79.813855][ T793] Workqueue: events drm_fb_helper_damage_work
[ 79.849602][ T793] <TASK>
[ 79.855848][ T793] drm_client_modeset_wait_for_vblank+0xf1/0x130
[ 79.857114][ T793] drm_fb_helper_damage_work+0x2e1/0xae0
[ 79.860522][ T793] process_scheduled_works+0x5ed/0x1c90
[ 79.864431][ T793] worker_thread+0x5be/0xd20
[ 79.866835][ T793] kthread+0x404/0x530
[ 79.867639][ T793] ret_from_fork+0x7c5/0xde0
[ 79.872873][ T793] ret_from_fork_asm+0x1a/0x30
[ 79.873717][ T793] </TASK>
[ 79.874264][ T793] Kernel panic - not syncing: kernel: panic_on_warn set ...


Thanks

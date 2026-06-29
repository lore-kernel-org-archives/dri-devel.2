Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5E4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F59210E805;
	Mon, 29 Jun 2026 10:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="Scp36FMo";
	dkim-atps=neutral
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net
 [178.154.239.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238E310E805;
 Mon, 29 Jun 2026 10:33:25 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
 by forward103a.mail.yandex.net (postfix) with ESMTPS id BBC1E806C0;
 Mon, 29 Jun 2026 13:33:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id mWaU7PLg7Gk0-zr3sTh1k; 
 Mon, 29 Jun 2026 13:33:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1782729201; bh=bkbr8BQEH5XYv/QZbwbCjGjbwygqzEt5NhSM1N730sw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Scp36FMoYe+GiOzC5BrP3iXWVS3eqZdc2Wp7VLUWWWevEJSEuNth5Rv5kKFNfZoQ8
 6LRo0RsiQ/cmMmiG3I28tj3PwK9xXvpLXyctwZ9q80Co+CDvzkMAxouUdMEDZDbnc9
 4KKP7F2THNb8a84zDstVDFOZCvYuGQtWDGM/CfFg=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: sashiko-bot@kernel.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com,
 superm1@kernel.org, timur.kristof@gmail.com, ivan.lipski@amd.com,
 ray.wu@amd.com, aurabindo.pillai@amd.com, chen-yu.chen@amd.com,
 mripard@kernel.org, Dillon.Varone@amd.com, mwen@igalia.com,
 chiahsuan.chung@amd.com, kenneth.feng@amd.com,
 srinivasan.shanmugam@amd.com, tzimmermann@suse.de, Alvin.Lee2@amd.com,
 dmitry.baryshkov@oss.qualcomm.com, chaitanya.kumar.borah@intel.com,
 ekurzinger@gmail.com, pierre-eric.pelloux-prayer@amd.com,
 HaoPing.Liu@amd.com, Tony.Cheng@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, sashiko-reviews@lists.linux.dev,
 Evgenii Burenchev <evg28bur@yandex.ru>
Subject: Re: [PATCH v4 1/3] drm/amd/display: Fix dangling pointer in plane
 reset function
Date: Mon, 29 Jun 2026 13:32:36 +0300
Message-ID: <20260629103236.12380-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629092538.4D19B1F000E9@smtp.kernel.org>
References: <20260629092538.4D19B1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Mon, Jun 29, 2026 at 09:25:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Dangling pointer (Use-After-Free) vulnerability in vmwgfx component reset hooks on memory allocation failure.
> - [High] Missing NULL pointer checks in amdgpu duplicate_state hooks lead to NULL pointer dereference on allocation failure.

Thank you for the review.

> [Severity: High]
> This is a pre-existing issue, but returning here when plane->state is
> initially NULL means plane->state remains NULL. Later, when the DRM core
> attempts to duplicate the state, it calls the driver's duplicate hook.
>
> In amdgpu_dm_plane_drm_plane_duplicate_state(), there is no check if
> plane->state is NULL:
>
> amdgpu_dm_plane_drm_plane_duplicate_state() {
>     ...
>         dm_plane_state = kzalloc_obj(*dm_plane_state);
>         if (!dm_plane_state)
>                 return NULL;
>
>         __drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
>     ...
> }
>
> Will this cause a NULL pointer dereference in
> __drm_atomic_helper_plane_duplicate_state() since it will crash when trying
> to memcpy from a NULL plane->state?

The DRM core guarantees that duplicate_state() is never called on an object
with a NULL state. The state pointer is always valid when duplication is
requested, as DRM only calls this hook on objects that are already fully
initialized and have an active state.

Therefore, the scenario described above is not possible in practice.
This patch does not introduce any new NULL pointer risks.

> The same pattern appears in amdgpu_dm_connector_atomic_duplicate_state(),
> where to_dm_connector_state(connector->state) will resolve to an invalid
> pointer offset from NULL, causing kmemdup to panic:
>
> Could these duplicate_state hooks be updated to handle a NULL state?

As explained above, DRM core guarantees that duplicate_state is only called
with a valid state. Adding NULL checks in duplicate_state hooks would be
redundant and unnecessary.

> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed the exact same
> dangling pointer pattern this patch fixes also exists in the vmwgfx driver.
>
> In vmw_du_connector_reset(), if kzalloc_obj() fails, it returns without
> updating the state pointer, leaving a dangling pointer:
>
> The identical issue also occurs in vmw_du_crtc_reset() and
> vmw_du_plane_reset().
>
> Since unhandled use-after-free bugs in core DRM state structures can cause
> severe stability issues, do these vmwgfx component reset hooks need a similar
> fix to allocate the new state before freeing the old one?

This is a separate pre-existing issue in a different driver (vmwgfx).
While it does appear to suffer from the same dangling pointer pattern,
it is unrelated to this patch series and should be addressed in a
separate patch by the vmwgfx maintainers.

This patch series only addresses the dangling pointer issue in the
amdgpu_dm reset functions.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

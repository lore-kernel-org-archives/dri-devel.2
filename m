Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FBC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8042B10EE82;
	Thu, 27 Aug 2026 06:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gmx9k+JK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E1010EE82;
 Thu, 27 Aug 2026 06:37:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 477CB600D0;
 Thu, 27 Aug 2026 06:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9021C1F000E9;
 Thu, 27 Aug 2026 06:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787812632;
 bh=3t/8O7p80Bgef9WB5is8sUc5oGunm9qBTPW5T6zvm/g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gmx9k+JKqLKAda0qihX/jU4RFZqeRTbMje4lII6KNlHgAqika1UTwvgHW6ndcKfvA
 Hq+9V4d4vYlGCqhFBd7/rijFfBSDJbSW7oRJzqrKNz/sTPebYJWda4ydjtyfsqzpBj
 oX2d4xBZHnKwnOEzh1ryNCvilehOTu24hkZ8qEA+GhEe7J8R+GcGZqrAeufDXaHpu4
 +GuLpW3nNhHzpqWcbya8UtguAUtD6gWHUneZ+D9YcGxF+UUPXmbTznsPtsYUi5MMpT
 8r7y0JbwYxeJOXMj1F6xOWy5JT2Q++VtDQkC/poogjfa3IvJFbb02GdWZFK0C5u8Yt
 kG0tYEHEpvSbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: media-ci@linuxtv.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260827062142.4038272-3-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260827062142.4038272-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:37:11 +0000
Message-Id: <20260827063711.9021C1F000E9@smtp.kernel.org>
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
- [High] Prematurely dropping the dma_fence reference allows userspace to t=
rigger a kernel WARNING and memory leak via syncobj reset.
--

commit c721250695d79a85665bd6cb949b881db777982f
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

    drm/xe: Convert xe_user_fence to drm_user_fence
   =20
    Replace the open-coded user fence implementation in xe_sync.c with the
    new common drm_user_fence helper.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> index 37866768d64c2..e95f50338454c 100644
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c
[ ... ]
> @@ -282,24 +267,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *syn=
c, struct dma_fence *fence)
>  	} else if (sync->syncobj) {
>  		drm_syncobj_replace_fence(sync->syncobj, fence);
>  	} else if (sync->ufence) {
> -		int err;
> -
>  		drm_syncobj_add_point(sync->ufence_syncobj,
>  				      sync->ufence_chain_fence,
>  				      fence, sync->ufence_timeline_value);
>  		sync->ufence_chain_fence =3D NULL;
> =20
>  		fence =3D drm_syncobj_fence_get(sync->ufence_syncobj);
> -		user_fence_get(sync->ufence);
> -		err =3D dma_fence_add_callback(fence, &sync->ufence->cb,
> -					     user_fence_cb);
> -		if (err =3D=3D -ENOENT) {
> -			kick_ufence(sync->ufence, fence);
> -		} else if (err) {
> +		if (drm_user_fence_add_callback(&sync->ufence->base, fence))
>  			XE_WARN_ON("failed to add user fence");
> -			user_fence_put(sync->ufence);
> -			dma_fence_put(fence);
> -		}
> +		dma_fence_put(fence);
>  	}
>  }

[Severity: High]
Does this code prematurely drop the local fence reference?=20

In xe_sync_entry_signal(), we add the user fence callback using=20
drm_user_fence_add_callback(), but then immediately call dma_fence_put()=20
unconditionally.

If userspace submits a job with a user fence and then subsequently resets=20
the syncobj before the fence signals, the syncobj will drop its reference.=
=20
Since we already dropped our local reference here, could the fence be=20
destroyed while the callback is still pending?=20

This looks like it would trigger a kernel warning from the non-empty callba=
ck=20
list in dma_fence_release and permanently leak the user fence object since=
=20
the callback is never executed. The previous implementation appeared to avo=
id=20
this by holding the fence reference until the callback actually fired.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827062142.4038=
272-1-srinivasan.shanmugam@amd.com?part=3D2

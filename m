Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E1CC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F6C10E051;
	Thu, 13 Aug 2026 11:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iOL88Q13";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDF510F2DA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:09:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25F67419C8;
 Thu, 13 Aug 2026 11:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFD41F000E9;
 Thu, 13 Aug 2026 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786619366;
 bh=XEtzlmszLloMlFoorNwhAoh/ibLq/2v1NrINu+4eYm8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iOL88Q130bs3chmaxQh7RFovX93Mbd3exTEgvf/7gNbVv9IZmRG6G/vhjEnDWNUaB
 zzWehesmF4q/bvzSHiREOEp197kYNeYBKYAYxKqKCnbAZ+qFMz7GF/H64v7+eoe6k6
 BZcXByKtfiA7IgHzW5CGwhV42tMQ8088XkUDY6fdGZ9l9Ml9SQjb/nDuBbigaDuzjI
 TWEEhQh1g/pX2nKkWMhNdI95dJY0wl8y2PFAYPTY3SMAMnCn4nR/Y+q3K7zVAG4flG
 fNg5eTLrhwvw6ooWIk8OuH7v0K/6nTv9KxzIRnu7BqA9/psdA6LTYh98WZhJNZrGzL
 Ba9KTpSjsOmdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/17] drm/panthor: Make sure reset requests in the
 resume path are not lost
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-3-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-3-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:09:25 +0000
Message-Id: <20260813110925.DEFD41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect use of `smp_mb__after_atomic()` after `atomic_set()` fai=
ls to provide a guaranteed full memory barrier, potentially leading to a lo=
st reset due to Store-Load reordering.
- [Low] Missing word in the newly added inline comment makes it grammatical=
ly incomplete and confusing.
--

--- Patch [3]: [PATCH v3 03/17] drm/panthor: Make sure reset requests in th=
e resume path are not lost ---
commit df28c58d554a7a21bebf387cbb4ce59c9aa88cf4
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Make sure reset requests in the resume path are not lost

A reset might have been queued while we were resuming. Make sure it's
not lost by rescheduling it.

Closes: https://sashiko.dev/#/patchset/20260804-panthor-unplug-fixes-v1-0-a=
bbbd2d41b13@collabora.com?part=3D2

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 47dc7faf9728c..1a8f5ac24399a 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -569,7 +569,24 @@ int panthor_device_resume(struct device *dev)
>  	unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
>  			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
>  	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_ACTIVE);
> +
> +	/* The smp_mb__after_atomic() is here to make sure the pm.state update
> +	 * is flushed before we check the reset.pending bit, otherwise,
> +	 * according to Sashiko, there's a with the checks that exist in
                                          ^^^^^^
[Severity: Low]
This isn't a bug, but it looks like a word is missing here. Did you mean
"there's a race with the checks"?

> +	 * panthor_device_schedule_reset().
> +	 * Not sure how real this is, because the try_cmpxchg_release() in
> +	 * the mutex_unlock() path also acts as a barrier, but it's not a
> +	 * fast-path anyway, so better safe than sorry.
> +	 */
> +	smp_mb__after_atomic();

[Severity: High]
Does this actually provide the intended memory barrier?

Since atomic_set() is not a read-modify-write (RMW) operation,
smp_mb__after_atomic() doesn't guarantee a full memory barrier. On some
architectures, it is defined merely as a compiler barrier.

This means the CPU could reorder the subsequent load of ptdev->reset.pending
before the store to pm.state becomes globally visible (Store-Load reorderin=
g).

If this reordering happens concurrently with panthor_device_schedule_reset()
setting reset.pending =3D 1 and checking pm.state, could this regression le=
ad
to both threads failing to queue the reset work?

Also, can the try_cmpxchg_release() in the mutex_unlock() path prevent this?

Since release semantics only prevent prior operations from moving past the
release, they don't stop subsequent loads (like reading reset.pending) from
being hoisted before the release.

Should this use a full smp_mb() instead?

>  	mutex_unlock(&ptdev->pm.mmio_lock);
> +
> +	/* A reset might have been queued while we were resuming. Make sure
> +	 * it's not lost by rescheduling it.
> +	 */
> +	if (atomic_read(&ptdev->reset.pending))
> +		queue_work(ptdev->reset.wq, &ptdev->reset.work);
> +
>  	return 0;
> =20
>  err_suspend_devfreq:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D3

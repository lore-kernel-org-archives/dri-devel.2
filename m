Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fri68EWX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2267A10E94B;
	Thu, 26 Nov 2026 06:21:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BD710E2A5;
 Thu, 26 Nov 2026 06:20:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C183940341;
 Thu, 26 Nov 2026 06:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7181F000C4;
 Thu, 26 Nov 2026 06:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795674055;
 bh=rpRURselLG5GZ1IG/xCfqcLg8mW/cxrwNEUYwjuunCc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fri68EWXg1YmUIwjowQVxSdYeEtLIYEOn4XEz5LlWFs3V6Dse7q+TYWq0dPbxxY1k
 VUkhki4ViJZA3tlkilqDTLHxT4LnoSNo+ZiUKXmr0saM5/Sl22uReslc41q2kyrfZ+
 K5CqK9CKrQ15ZQAahF9HlEZRplRcP0Pauz/LX30isedimXJzkMvEdrAndAXorZUGKe
 mCrFwx4sZ5uKD/P1kDXGocs/6RWvZb245TppaGgr8dTmtjmZFXe9KgiTHxII46Jh7Z
 2rVF9A5uBYghdanosMH+aVPeIUTvLIur6azZ5/sajxoqTJE9Bv9od+JPZYI4x/Ve1F
 I4sfO5XT+Ax/Q==
Message-ID: <sashiko-outbox-234834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: hold frontbuffer ref across dirtyfb
 fence callback
To: =?utf-8?b?QmluIEx1byAoVW5pdmVyc2l0eSBvZiBFbGVjdHJvbmljIFNjaWVuY2Ug?=
 =?utf-8?b?YW5kIFRlY2hub2xvZ3kgb2YgQ2hpbmEp?= <luob87709@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261126060818.1654-1-luob87709@gmail.com>
References: <20261126060818.1654-1-luob87709@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:20:55 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915: atomic frontbuffer put in
  intel_user_framebuffer_fence_wake()
--

commit 6668699993fc94a934753276eb08e4a83ae0ca89
Author: luob87709@gmail.com <luob87709@gmail.com>

drm/i915/display: hold frontbuffer ref across dirtyfb fence callback

This commit takes a frontbuffer reference before registering the dirtyfb
dma_fence callback and drops it in intel_user_framebuffer_fence_wake()
after queuing the flush.

> diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i9=
15/display/intel_fb.c
> index 2c63aeefaea88..a0af4166c1d33 100644
> --- a/drivers/gpu/drm/i915/display/intel_fb.c
> +++ b/drivers/gpu/drm/i915/display/intel_fb.c
> @@ -2184,8 +2184,10 @@ static void intel_user_framebuffer_fence_wake(stru=
ct dma_fence *dma,
>  					      struct dma_fence_cb *data)
>  {
>  	struct frontbuffer_fence_cb *cb =3D container_of(data, typeof(*cb), bas=
e);
> +	struct intel_frontbuffer *front =3D cb->front;
> =20
> -	intel_frontbuffer_queue_flush(cb->front);
> +	intel_frontbuffer_queue_flush(front);
> +	intel_parent_frontbuffer_put(front->display, front);
>  	kfree(cb);
>  	dma_fence_put(dma);
>  }

[Severity: High]
Can intel_parent_frontbuffer_put() here drop the final reference to front
from atomic dma_fence signaling context?

intel_user_framebuffer_fence_wake() runs under fence->lock with interrupts
disabled.  If the framebuffer was destroyed before the fence signaled and
front->flush_work finishes on another CPU first,
intel_parent_frontbuffer_put() drops the last reference:

CPU0 (<hardirq>)                  CPU1 (kworker)
intel_user_framebuffer_fence_wake()
  intel_frontbuffer_queue_flush()
    intel_parent_frontbuffer_ref()
    schedule_work(&front->flush_work)
                                  intel_frontbuffer_flush_work()
                                    ...
                                    intel_parent_frontbuffer_put()
  intel_parent_frontbuffer_put()
    frontbuffer_release()  <-- final put in atomic context

On Xe, frontbuffer_release() calls drm_gem_object_put(front->obj) ->
xe_gem_object_free() -> ttm_bo_fini() -> ttm_bo_release() ->
xe_ttm_bo_destroy(), which acquires sleeping mutexes such as
xe->mem_access.vram_userfault.lock in atomic context.  On i915,
i915_gem_object_frontbuffer_put() and frontbuffer_release() ->
i915_ggtt_clear_scanout() acquire i915->frontbuffer_lock and obj->vma.lock
with plain spin_lock(), which can deadlock if the fence signals from an
interrupt that preempted a holder of either lock on the same CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126060818.1654=
-1-luob87709@gmail.com?part=3D1

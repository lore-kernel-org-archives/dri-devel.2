Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89F606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMntoK9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72CC10EA9F;
	Fri, 27 Nov 2026 13:55:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18E010EA92;
 Fri, 27 Nov 2026 13:55:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91824453E8;
 Fri, 27 Nov 2026 13:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EF91F00893;
 Fri, 27 Nov 2026 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795787726;
 bh=52LQ1oncZbwdcNkgHfUPpTGjkvUqFbJEKjcQVCwNDN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IMntoK9qu0Oo79tXZ0YHQ3ZOZ15W24H/7wwH/PPuoVkeu+mkKWhpsiTFJMnNIYWzj
 Xi/gXoYiAUC2r9zdbFzx42bm/DQzSwotBNwbWyaDV6QAHXp6YVc61VSwl+yyY+F3XV
 8lIELx6y3PpLpXNTfTb2Sd+N+v55ou576dVwZSax1vsW4639nMT9ZvCqWNRohjyU7J
 7M61uoF17aTM7Bw6E0f8j1xItymI7H85GTgdWuiO4uXNhxcUNNyVfRZXNqyeVKZ6qJ
 vQ4aked2M+1NEWipdQtYiLXLV1uBbZjz7gehkbhINgKVspDKq3zCga5Br2rROovzzS
 MnPLuHXJ8bCag==
Message-ID: <sashiko-outbox-237524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/display: hold frontbuffer ref across
 dirtyfb fence callback
To: =?utf-8?b?QmluIEx1byAoVW5pdmVyc2l0eSBvZiBFbGVjdHJvbmljIFNjaWVuY2Ug?=
 =?utf-8?b?YW5kIFRlY2hub2xvZ3kgb2YgQ2hpbmEp?= <luob87709@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261127133935.1461-1-luob87709@gmail.com>
References: <20261127133935.1461-1-luob87709@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:55:25 +0000
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
- [Low] drm/i915/display: dead intel_frontbuffer_queue_flush() and
  flush_work
--

commit ef90877ebdeba58596971006e74cdcc49524595d
Author: luob87709@gmail.com <luob87709@gmail.com>

drm/i915/display: hold frontbuffer ref across dirtyfb fence callback

This commit holds a frontbuffer reference across the dirtyfb dma_fence
callback and defers the frontbuffer flush and reference release to a work
item embedded in frontbuffer_fence_cb.

> diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i9=
15/display/intel_fb.c
> index 2c63aeefaea88..1ed9f8d7efd73 100644
> --- a/drivers/gpu/drm/i915/display/intel_fb.c
> +++ b/drivers/gpu/drm/i915/display/intel_fb.c
[ ... ]
> @@ -2177,16 +2178,26 @@ static int intel_user_framebuffer_create_handle(s=
truct drm_framebuffer *fb,
> =20
>  struct frontbuffer_fence_cb {
>  	struct dma_fence_cb base;
> +	struct work_struct work;
>  	struct intel_frontbuffer *front;
>  };
> =20
> +static void intel_user_framebuffer_fence_work(struct work_struct *work)
> +{
> +	struct frontbuffer_fence_cb *cb =3D container_of(work, typeof(*cb), wor=
k);
> +	struct intel_frontbuffer *front =3D cb->front;
> +
> +	intel_frontbuffer_flush(front, ORIGIN_DIRTYFB);
> +	intel_parent_frontbuffer_put(front->display, front);
> +	kfree(cb);
> +}
> +
>  static void intel_user_framebuffer_fence_wake(struct dma_fence *dma,
>  					      struct dma_fence_cb *data)
>  {
>  	struct frontbuffer_fence_cb *cb =3D container_of(data, typeof(*cb), bas=
e);
> =20
> -	intel_frontbuffer_queue_flush(cb->front);
> -	kfree(cb);
> +	schedule_work(&cb->work);
>  	dma_fence_put(dma);
>  }

[Severity: Low]
Does replacing intel_frontbuffer_queue_flush() here leave
intel_frontbuffer_queue_flush(), intel_frontbuffer_flush_work(), and
struct intel_frontbuffer's flush_work member unused?

intel_user_framebuffer_fence_wake() was the only caller of
intel_frontbuffer_queue_flush() in the tree, so those helpers in
intel_frontbuffer.c and flush_work in struct intel_frontbuffer are now
dead code (and intel_frontbuffer_queue_flush() still contains an atomic
intel_parent_frontbuffer_put() fallback if schedule_work() returns false).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127133935.1461=
-1-luob87709@gmail.com?part=3D1

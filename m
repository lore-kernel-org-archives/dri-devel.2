Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A56CC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66AB10E21B;
	Wed, 19 Aug 2026 12:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MS9e/lKk";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD1D10E21B
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:51:52 +0000 (UTC)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hQ6062SmNzKn6B;
 Wed, 19 Aug 2026 14:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1787143910; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky6HWeoz/Mt9DXWQr91Ff4u5nFsYPsGX1yjkb1Y3ouA=;
 b=MS9e/lKkeoXFVzqwQAJ6sf0NCw+9XiMcAmWNfWNEFptTIkTzoasSQ4Gpd7sun10niVbyX8
 bSRwlxL8dXcLlBjdBhkroU1H+7noDnGVj1RihK8Vs06+6eW/9NyOSjmxC8xeTXHz0SB1p7
 uFBjJUMqNi9UlI5vBQBpbKCeo1x5Pa5OuLQ/Ys8D205UTfM7y0jpnemy5DCybMiZ1K7Tk1
 WTPd4uRTzTQwYb8NGHOwGcdCIn8OLRfONsAQgw+WkxuQaCi8Q/s2ptoPT7bVtdHzy/K93J
 S9vCV88LwSuVPIHW0XLIw2s8kYIYkMKI12GybufXjI/R/JWJEx9UW1rOG3vGpw==
Message-ID: <5dd4248bccb446ef390e7149649632657db4aaae.camel@mailbox.org>
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
From: Philipp Stanner <phasta@mailbox.org>
To: phasta@kernel.org, Jiri Slaby <jirislaby@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Wed, 19 Aug 2026 14:51:47 +0200
In-Reply-To: <0b84716fa6bec4e38d811dc76926dd81e31e0c81.camel@mailbox.org>
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
 <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
 <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
 <9edeaa17aebc284f1f171b1dd4d9ffee4721b750.camel@mailbox.org>
 <4b5b6dda-43a4-4488-9dbd-b0f92fcead61@kernel.org>
 <0b84716fa6bec4e38d811dc76926dd81e31e0c81.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: e1df20147b8ae471097
X-MBO-RS-META: 7kqgj3t4eui8cip786p9bmrcdnfi1azw
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-08-19 at 14:33 +0200, Philipp Stanner wrote:


[=E2=80=A6]

>=20
> Regardless, looking at the code again, I would say that this might be a
> race, but I don't know enough about QXL to say for sure.
>=20
> dma_fence_init() is (of course) not ordered:
>=20
>=20
> static void
> __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops=
,
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t *lock, u64 c=
ontext, u64 seqno, unsigned long flags)
> {
> 	BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
>=20
> 	kref_init(&fence->refcount);
> 	/*
> 	 * While it is counter intuitive to protect a constant function pointer
> 	 * table by RCU it allows modules to wait for an RCU grace period
> 	 * before they unload, to make sure that nobody is executing their
> 	 * functions any more.
> 	 */
> 	RCU_INIT_POINTER(fence->ops, ops);
> 	INIT_LIST_HEAD(&fence->cb_list);
> 	fence->context =3D context;
> 	fence->seqno =3D seqno;
> 	fence->flags =3D flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);
>=20
> (Should this maybe be set_bit() btw?)
>=20
>=20
> The fact that QXL could run into qxl_release_free() with an
> uninitialized fence hints at the fact that this might race, so
> DMA_FENCE_FLAG_INITIALIZED_BIT could be set / read before kref_init()
> ran.
>=20
>=20
> Maybe one way to verify / debug that would be to move
> spin_unlock(&qdev->release_idr_lock) downwards so it also guards
> dma_fence_was_initialized(), and also lock the initialization of the
> fence (in qxl_release_fence_buffer_objects() ?) with said lock.
>=20
> If that's possible. Just brainstorming a bit for ways how to debug.
>=20
> QXL does a few tricky things with the release->base.ops pointer.
> qxl_release_alloc() sets it to NULL, and only
> qxl_release_fence_buffer_objects() then actually sets it. So this could
> be the race? Setting of the ops pointer got replaced by setting of the
> fence-flag.
>=20
>=20
> P.

Could you test something like this? (not even compile-tested, just an idea)


diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 87797bea91cb..df1aa48b2809 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1075,7 +1075,6 @@ __dma_fence_init(struct dma_fence *fence, const struc=
t dma_fence_ops *ops,
        INIT_LIST_HEAD(&fence->cb_list);
        fence->context =3D context;
        fence->seqno =3D seqno;
-       fence->flags =3D flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);
        if (lock) {
                fence->extern_lock =3D lock;
        } else {
@@ -1084,6 +1083,8 @@ __dma_fence_init(struct dma_fence *fence, const struc=
t dma_fence_ops *ops,
        }
        fence->error =3D 0;
=20
+       smp_mb();
+       fence->flags =3D flags | BIT(DMA_FENCE_FLAG_INITIALIZED_BIT);
        trace_dma_fence_init(fence);
 }
=20
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index b52ab692b22e..40ffdcafaac1 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -292,7 +292,12 @@ void dma_fence_describe(struct dma_fence *fence, struc=
t seq_file *seq);
  */
 static inline bool dma_fence_was_initialized(struct dma_fence *fence)
 {
-       return fence && test_bit(DMA_FENCE_FLAG_INITIALIZED_BIT, &fence->fl=
ags);
+       bool init;
+
+       init =3D fence && test_bit(DMA_FENCE_FLAG_INITIALIZED_BIT, &fence->=
flags);
+       smp_mb();
+
+       return init;
 }
=20
 /**

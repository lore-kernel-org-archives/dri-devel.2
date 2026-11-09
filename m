Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B5606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBy9Q0uQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA1710F3C2;
	Mon,  9 Nov 2026 14:24:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF5110F3BD;
 Mon,  9 Nov 2026 14:24:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBC3142A99;
 Mon,  9 Nov 2026 14:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E85C1F0089F;
 Mon,  9 Nov 2026 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234278;
 bh=vEtjykBn4MbKhX/Ba1zgM5WeS7HPcd4bmcpQAg5a5oY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GBy9Q0uQrU78tNzrOFfe3wHvK2wEMRkIIdfOg/6QkqLMwhBTSNGCi6alZ6p0M6K2U
 Ubblqw4rbEde9xPXnG2a1O5gpRDZkwCXo2ZgTBkTAaP6YZ2xIenKUnRUQcggDhMv1I
 KJtQpJwFmVbddKMGDT2RxPPKKVSa1hxLs+4GqvjT9HCYitgg9qVKoa9W8lnCCvl/Ik
 Nb/iGigk9IKL1mTA7FxZQpFYwlVJRnlSdeKFeh+t1eFQ9erQR+H2RiuNtalmihS9Z8
 6W3/tNRpehc6AyCrwRZLZJAHsWLyGiaqIONvSKQgJu7W8St5NRtr+KfemeLLL6ZSjI
 eDyO9cVVFEmaw==
Message-ID: <sashiko-outbox-205088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/20] drm/xe/eudebug: Introduce per device attention
 scan worker
To: "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109135549.4128280-19-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-19-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:24:38 +0000
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
- [Medium] drm/xe/eudebug: attention seqno race with discover_client()
  queue create
--

commit 9b3fd09a4bd67b0862bac3d3c0bc36809193f44f
Author: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

drm/xe/eudebug: Introduce per device attention scan worker

This commit introduces a periodic per-device delayed worker to scan for EU
debugging attention bits and send DRM_XE_EUDEBUG_EVENT_EU_ATTENTION events
when an attached debugger is present, or reset the GT if no debugger will
service the halted threads.

> diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eude=
bug.c
> index 4fab8304046b3..9b1f2f97b603b 100644
> --- a/drivers/gpu/drm/xe/xe_eudebug.c
> +++ b/drivers/gpu/drm/xe/xe_eudebug.c
[ ... ]
> @@ -2218,6 +2233,362 @@ static const struct file_operations fops =3D {
>  	.compat_ioctl	=3D compat_ptr_ioctl,
>  };
> =20
> +/*
> + * The uapi tells userspace the attention bitmask sits 8 byte aligned wi=
thin
> + * the event, so it may be scanned as u32 or u64 words. That holds today
> + * because the preceding members are u64, but a field added ahead of the
> + * array could quietly break it, so pin it down here. Only the offset can
> + * be: plain __u64 members are 4 byte aligned on i386.
> + */
> +static_assert(offsetof(struct drm_xe_eudebug_event_eu_attention, bitmask=
) %
> +	      sizeof(__u64) =3D=3D 0);
> +
> +static int send_attention_event(struct xe_eudebug *d, struct xe_exec_que=
ue *q,
> +				int lrc_idx, void *bitmap, unsigned int size,
> +				u64 seqno)
> +{
> +	struct drm_xe_eudebug_event_eu_attention *e;
> +	struct drm_xe_eudebug_event *event;
> +	const u32 sz =3D struct_size(e, bitmask, size);
> +	int h_queue, h_lrc;
> +	int ret;
> +
> +	if (lrc_idx < 0 || lrc_idx >=3D q->width)
> +		return -EINVAL;
> +
> +	h_queue =3D find_handle(d, XE_EUDEBUG_RES_TYPE_EXEC_QUEUE, q);
> +	if (h_queue < 0)
> +		return h_queue;
> +
> +	h_lrc =3D find_handle(d, XE_EUDEBUG_RES_TYPE_LRC, q->lrc[lrc_idx]);
> +	if (h_lrc < 0)
> +		return h_lrc;
> +
> +	mutex_lock(&d->lock);
> +	event =3D xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_EU_ATTENTION,
> +					 seqno, DRM_XE_EUDEBUG_EVENT_STATE_CHANGE,
> +					 sz);
> +
> +	e =3D cast_event(e, event);
> +	e->exec_queue_handle =3D h_queue;
> +	e->lrc_handle =3D h_lrc;
> +	e->bitmask_size =3D size;
> +
> +	memcpy(e->bitmask, bitmap, size);
> +	ret =3D xe_eudebug_queue_event(d, event);
> +	mutex_unlock(&d->lock);
> +
> +	return ret;
> +}
> +
> +static int relay_gt_attention(struct xe_eudebug *d, struct xe_exec_queue=
 *q,
> +			      struct xe_hw_engine *hwe, int lrc_idx)
> +{
> +	const u32 size =3D xe_gt_eu_attention_bitmap_size(q->gt);
> +	void *bitmask;
> +	u64 seqno;
> +	int ret;
> +
> +	/* If we fail at this time, assume we manage to send eventually */
> +	bitmask =3D kvzalloc(size, GFP_KERNEL);
> +	if (!bitmask)
> +		return 0;
> +
> +	/*
> +	 * Attention is state, so the event is stamped where that state is
> +	 * observed: as the bits are read. That is also before the handle
> +	 * lookups in send_attention_event(), so a handle still found there is
> +	 * destroyed with a later seqno. A round that ends up sending nothing
> +	 * leaves a gap in the numbering, which the uapi allows.
> +	 */
> +	seqno =3D atomic64_inc_return(&d->events.seqno);
> +
> +	ret =3D xe_gt_eu_attention_bitmap(q->gt, bitmask, size);

[Severity: Medium]
Can relay_gt_attention() send a DRM_XE_EUDEBUG_EVENT_EU_ATTENTION event
with a smaller seqno than the queue's DRM_XE_EUDEBUG_EVENT_CREATE event
when racing with discover_client()?

In xe_eudebug_attach(), add_debugger() publishes xef->eudebug.debugger
before discover_client() runs, and handle_gt_attention() looks up the
debugger via xe_eudebug_get_nolock() without holding xef->eudebug.ioctl_loc=
k:

CPU0 (attention_wq)               CPU1 (connect ioctl)
handle_gt_attention()             xe_eudebug_attach()
  d =3D xe_eudebug_get_nolock(...)    discover_client()
  relay_gt_attention()                ...
    seqno =3D atomic64_inc_return()       exec_queue_create_event()
      --> S1                              _xe_eudebug_add_handle(LRC)
    xe_gt_eu_attention_bitmap()           mutex_lock(&d->lock)
                                          __handle_insert(EXEC_QUEUE)
                                            --> seqno =3D S2 (S2 > S1)
                                          mutex_unlock(&d->lock)
    send_attention_event()
      find_handle(EXEC_QUEUE)
      find_handle(LRC)
      mutex_lock(&d->lock)
      xe_eudebug_queue_event(S1)
      mutex_unlock(&d->lock)
                                          send_exec_queue_event(S2)

The attention event for q is stamped with seqno S1 < S2 and can also be
queued into d->events.fifo ahead of the EXEC_QUEUE CREATE event because
exec_queue_create_event() drops d->lock between __handle_insert() and
send_exec_queue_event(), so userspace sees an attention event for handles
that have not been created yet.

Looking up h_queue and h_lrc before stamping seqno in relay_gt_attention()
(and re-checking that the handles still exist before queueing, or holding
xef->eudebug.ioctl_lock) would ensure discovery has already assigned the
CREATE seqno first.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135549.4128=
280-1-mika.kuoppala@linux.intel.com?part=3D18

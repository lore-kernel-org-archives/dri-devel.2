Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77195606D825
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1G5uTY9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB8610F3AA;
	Mon,  9 Nov 2026 14:22:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B34410F3AA;
 Mon,  9 Nov 2026 14:22:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EFB3C4565F;
 Mon,  9 Nov 2026 14:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48031F0089F;
 Mon,  9 Nov 2026 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234172;
 bh=GVEKEY+PUt198qHgzkPXtxe0aUspKL7ogvSDH+cH8i0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F1G5uTY9AWuZEZ7NGWCkmSpRcqYIB5b4ud++HEDe/mim/HocACgX4NAZjXXfD2NZj
 Oh2xQJdU5vTAL5yfvOKMTIuvtJKPO0jx+lAVPzPuzyE5BwochgexMqnFPu58yK2/Qv
 7LOHFgm/K/V4QXDljJK5OtojStvRmp4b6oRJ2c1l2nswrbMQ7bNGnO+JvGQsPVGLUX
 4ndSQEKDQrmAmMSsxyoP3q4RD/KmU0Tv3kjDcE9KTdK7hqWVHlNugF4sNYrT4fcc7A
 gxcvQ+3Ylc/RH/DkVtJY1LHDUqo16fM9jBMPSVcLCodHySFpppVdWP0t9C0BCYlpsF
 ZOWYHzb9uqbxg==
Message-ID: <sashiko-outbox-205083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/20] drm/xe/eudebug: Add ufence events with acks
To: "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109135549.4128280-13-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-13-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:22:52 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/xe/eudebug: use of destroyed eudebug.lock in
  xe_eudebug_detach()
- [Low] drm/xe/eudebug: TOCTOU race in xe_eudebug_ack_event_ioctl() on
  detach
--

commit b38d3ecda4b8b7ae85aedf3b0af41c39cf303abb
Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>

drm/xe/eudebug: Add ufence events with acks

This commit adds DRM_XE_EUDEBUG_EVENT_VM_BIND_UFENCE events and the
DRM_XE_EUDEBUG_IOCTL_ACK_EVENT ioctl so that a debugger can stall user
fence signalling on a VM bind with debug data until the event is
acknowledged.

> diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eude=
bug.c
> index c6d08b27042d2..934dc116120e6 100644
> --- a/drivers/gpu/drm/xe/xe_eudebug.c
> +++ b/drivers/gpu/drm/xe/xe_eudebug.c

[ ... ]

> @@ -1199,6 +1330,191 @@ static int vm_bind_op_event(struct xe_eudebug *d,
>  	return err;
>  }

[ ... ]

> +static int track_ufence(struct xe_eudebug *d,
> +			struct xe_user_fence *ufence,
> +			u64 bind_ref_seqno,
> +			bool *tracked)
> +{

[ ... ]

> +	/*
> +	 * The ack and the event asking for it go in under one lock, so the
> +	 * debugger cannot ack a fence it has not been told about. Once the
> +	 * lock is dropped the ack may already be gone, so it is not touched
> +	 * after that.
> +	 */
> +	mutex_lock(&d->lock);
> +	old =3D rb_find_add(&ack->rb_node, &d->acks.tree, ack_insert_cmp);
> +	if (old) {
> +		mutex_unlock(&d->lock);
> +		xe_sync_ufence_put(ufence);
> +		kfree(ack);
> +		return -EEXIST;
> +	}
> +
> +	*tracked =3D true;
> +
> +	event =3D xe_eudebug_prepare_event(d, DRM_XE_EUDEBUG_EVENT_VM_BIND_UFEN=
CE,
> +					 seqno, flags, sz);
> +
> +	e =3D cast_event(e, event);
> +	e->vm_bind_ref_seqno =3D bind_ref_seqno;
> +
> +	ret =3D xe_eudebug_queue_event(d, event);
> +	mutex_unlock(&d->lock);
> +
> +	return ret;
> +}

[ ... ]

> +bool xe_eudebug_ufence_track(struct xe_user_fence *ufence)
> +{
> +	struct xe_eudebug *d;
> +	u64 bind_ref_seqno;
> +	bool tracked =3D false;
> +	int ret;

[ ... ]

> +	if (xe_eudebug_is_detached(d)) {
> +		/* Nothing will ack this fence any more */
> +		ufence_drop_debugger(ufence);
> +		xe_eudebug_put(d);
> +		return false;
> +	}
> +
> +	ret =3D track_ufence(d, ufence, bind_ref_seqno, &tracked);
> +	if (ret) {
> +		/*
> +		 * If we failed before the ack made it into the tree, the
> +		 * disconnect below has nothing to release for this fence.
> +		 */
> +		if (!tracked)
> +			ufence_drop_debugger(ufence);
> +
> +		xe_eudebug_disconnect(d, ret);
> +	}
> +
> +	xe_eudebug_put(d);
> +
> +	return tracked;
> +}

[Severity: Medium]
Can xe_eudebug_ufence_track() lock a destroyed d->xe->eudebug.lock in
xe_eudebug_detach()?

As noted above kick_ufence_worker(), user_fence_worker() runs on
xe->ordered_wq, which xe_device_destroy() drains only after the drmm
actions registered in xe_device_probe() have already run.  One of those
actions is xe_eudebug_lock_fini(), which destroys xe->eudebug.lock:

drivers/gpu/drm/xe/xe_eudebug.c:xe_eudebug_lock_fini() {
	mutex_destroy(&to_xe_device(dev)->eudebug.lock);
}

A user fence holds a reference to struct xe_eudebug in
ufence->eudebug.debugger, but not a drm_device reference:

CPU0 (user_fence_worker)          CPU1
xe_eudebug_ufence_track()
  xe_eudebug_is_detached(d)
    -> false
                                  xe_eudebug_release()
                                    xe_eudebug_disconnect(d, 0)
                                    drm_dev_put(&d->xe->drm)
                                      ...
                                      xe_eudebug_lock_fini()
                                        mutex_destroy(&xe->eudebug.lock)
                                      xe_device_destroy()
                                        destroy_workqueue(xe->ordered_wq)
  track_ufence()
    xe_eudebug_queue_event()
      -> -ENOTCONN
  xe_eudebug_disconnect(d, ret)
    xe_eudebug_detach()
      mutex_lock(&d->xe->eudebug.lock)  <-- destroyed mutex

With lock debugging enabled, mutex_lock() warns on the destroyed mutex.
If track_ufence() checked __xe_eudebug_is_detached(d) under d->lock
before inserting ack into d->acks.tree, a racing detach would not need a
second xe_eudebug_disconnect() call.

[ ... ]

> @@ -1691,6 +2032,42 @@ static long xe_eudebug_read_event(struct xe_eudebu=
g *d,
>  	return ret;
>  }
> =20
> +static long
> +xe_eudebug_ack_event_ioctl(struct xe_eudebug *d,
> +			   const u64 arg)
> +{

[ ... ]

> +	if (XE_IOCTL_DBG(xe, xe_eudebug_is_detached(d)))
> +		return -ENOTCONN;
> +
> +	ack =3D remove_ack(d, user_arg.seqno);
> +	if (XE_IOCTL_DBG(xe, !ack))
> +		return -EINVAL;
> +
> +	handle_ack(d, ack, false);
> +
> +	return 0;
> +}

[Severity: Low]
Can xe_eudebug_ack_event_ioctl() return -EINVAL instead of -ENOTCONN when
racing with xe_eudebug_detach()?

xe_eudebug_is_detached() and remove_ack() take d->lock in separate
critical sections.  If xe_eudebug_detach() runs in between, it clears
d->target.xef and empties d->acks.tree under d->lock, so remove_ack()
finds nothing and the ioctl returns -EINVAL for a valid seqno instead of
the documented -ENOTCONN.  Checking __xe_eudebug_is_detached(d) inside
remove_ack() under d->lock would avoid the race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135549.4128=
280-1-mika.kuoppala@linux.intel.com?part=3D12

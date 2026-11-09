Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF1606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kV79JIP4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1560210E139;
	Mon,  9 Nov 2026 14:16:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300E910F370;
 Mon,  9 Nov 2026 14:16:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49AB9612EC;
 Mon,  9 Nov 2026 14:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF50D1F0089F;
 Mon,  9 Nov 2026 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794233800;
 bh=2dySGlzppjYJoCssJp9fks0a6blfgYXqnsnXAkwhXZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kV79JIP4DF4J+w2sIJa+bOP+N8rMJUSv+WcrdKbO4foTv2EKJqKoqcku7+Aqq99CV
 PFNC06eLCiSHeQm+7LK2H4I4f3BmYrqFU8yLZTPboZcumGPynFC3+1KAFrOHF6C0Wc
 ejxNihJHY0G5jyVcHGZBnoXx1dLG/9zRtjmtcr0AR1qBHgr22sPVMRfxVoi07XQZCS
 J+A0mWAhZt2n8wdXDIAb0WN/Hgp5XqyrNhQ5T72PXsiEH/JtbmNQ1J0dfPlosJNKFb
 CfD08P0KqvrLN41Zn2xVeWh1paGxr7lgQQ7aArW282oWfidEi17XWq75W+//PZK79X
 +Z3wQNijTguow==
Message-ID: <sashiko-outbox-205074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/20] drm/xe/eudebug: Introduce exec_queue events
To: "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109135549.4128280-9-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-9-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:16:39 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/xe/eudebug: discover_client() counts non-debuggable queues
  in eq_count
--

commit 926a26106604e590716ee8ab1001dab4ed5f0566
Author: Dominik Grzegorzek <dominik.grzegorzek@intel.com>

drm/xe/eudebug: Introduce exec_queue events

This commit adds eudebug resource creation and destruction events for
debuggable render and compute exec queues, both during live ioctls and
when discovering an existing client's resources.

> diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eude=
bug.c
> index e0ef34588d3d4..0f8b0452f9bae 100644
> --- a/drivers/gpu/drm/xe/xe_eudebug.c
> +++ b/drivers/gpu/drm/xe/xe_eudebug.c
[ ... ]
> +void xe_eudebug_exec_queue_create(struct xe_file *xef, struct xe_exec_qu=
eue *q)
> +{
> +	struct xe_eudebug *d;
> +	int err;
> +
> +	if (!xe_engine_supports_eudebug(q->class))
> +		return;
> +
> +	d =3D xe_eudebug_get(xef);
> +	if (!d)
> +		return;
> +
> +	err =3D exec_queue_create_event(d, xef, q);
> +	if (err)
> +		xe_eudebug_disconnect(d, err);
> +
> +	xe_eudebug_put(d);
> +}
> +
> +void xe_eudebug_exec_queue_destroy(struct xe_file *xef, struct xe_exec_q=
ueue *q)
> +{
> +	struct xe_eudebug *d;
> +	int err;
> +
> +	if (!xe_engine_supports_eudebug(q->class))
> +		return;
> +
> +	d =3D xe_eudebug_get(xef);
> +	if (!d)
> +		return;
> +
> +	err =3D exec_queue_destroy_event(d, xef, q);
> +	if (err)
> +		xe_eudebug_disconnect(d, err);
> +
> +	xe_eudebug_put(d);
> +}
> +
>  /*
>   * All the relevant ioctls that manipulate the xe_file resources eudebug
>   * cares about are gated behind down_read(&xef->eudebug.ioctl_lock). The
> @@ -807,9 +1069,10 @@ void xe_eudebug_vm_destroy(struct xe_file *xef, str=
uct xe_vm *vm)
>   */
>  static int discover_client(struct xe_eudebug *d, struct xe_file *xef)
>  {
> +	struct xe_exec_queue *q;
>  	struct xe_vm *vm;
>  	unsigned long i;
> -	unsigned int vm_count =3D 0;
> +	unsigned int vm_count =3D 0, eq_count =3D 0;
>  	int err =3D 0;
> =20
>  	lockdep_assert_held_write(&xef->eudebug.ioctl_lock);
> @@ -828,10 +1091,21 @@ static int discover_client(struct xe_eudebug *d, s=
truct xe_file *xef)
>  		vm_count++;
>  	}
> =20
> +	xa_for_each(&xef->exec_queue.xa, i, q) {
> +		if (!xe_engine_supports_eudebug(q->class))
> +			continue;
> +
> +		err =3D exec_queue_create_event(d, xef, q);
> +		if (err)
> +			goto out;
> +
> +		eq_count++;
> +	}
> +
>  out:
> -	if (vm_count)
> -		eu_dbg(d, "Discovery found %u vms",
> -		       vm_count);
> +	if (vm_count || eq_count)
> +		eu_dbg(d, "Discovery found %u vms, %u exec_queues",
> +		       vm_count, eq_count);

[Severity: Low]
Does discover_client() count non-debuggable render and compute queues in
eq_count?

exec_queue_create_event() returns 0 without emitting an event when
!xe_exec_queue_is_debuggable(q), so any render or compute queue created
without DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG still increments eq_count.
Checking xe_exec_queue_is_debuggable(q) in discover_client(), as well as
at the top of xe_eudebug_exec_queue_create() and
xe_eudebug_exec_queue_destroy(), would also avoid taking and dropping the
debugger reference for non-debuggable queues.  Finally, the kernel-doc for
struct drm_xe_eudebug_event_exec_queue in include/uapi/drm/xe_drm_eudebug.h
could mention that only queues with DRM_XE_EXEC_QUEUE_SET_PROPERTY_EUDEBUG
are reported, matching struct drm_xe_eudebug_event_vm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135549.4128=
280-1-mika.kuoppala@linux.intel.com?part=3D8

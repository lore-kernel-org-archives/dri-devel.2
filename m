Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqXOrlU1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B55112024;
	Thu, 29 Oct 2026 07:57:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1E0112024
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:57:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F9B260210
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0152B1F031E2;
 Thu, 29 Oct 2026 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260644;
 bh=7YKyq4lbqJYowJB7Yc1OYiheiWFS7JdtMX0hhnop5g8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SqXOrlU1PHjHYC/VL0xtXIkT7cuvfaQSEy30E+UMRZXIKmO3GRi9VV/6eq4SqqdpM
 XQR54ZeoZS+/bebP0kU4mAwr23HAqCKIoK+eWy0IH4Y8SQmpRd051/adnLuuKtqtZx
 FPtPIFZgk597Zq7JJ0LVbO7jMfxsyJ3WtVZoJrsI02Jtp5DEYD50VsleNVAo5gDDyF
 zsgILGLH35T009zkFXriuREXWEQxu/MOaOh9OoekyiZukTY7hsLxJwkoIQXaJfB8RP
 7u+nP54WEvlXuxidTPI8nhzmxImIyyj0+40VBXS3SAQKjzRxWBYAkXobAgEki6n6Yb
 dF3ch8Xp9RBBA==
Message-ID: <sashiko-outbox-188926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/34] drm/atomic: Fix private obj error handling
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-4-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-4-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:57:23 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/atomic: non-idempotent list_del() in drm_atomic_private_obj_=
fini()
--

commit 72c7eb0713fd45624f9e5b2b360640bc1c381470
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Fix private obj error handling

This commit fixes drm_atomic_private_obj_init() to remove the object from
privobj_list and clean up the modeset lock if atomic_create_state() fails. =
It
also adds a list_empty() check to drm_atomic_private_obj_fini() to avoid a
double list_del() when teardown runs after a failed initialization.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f4..8f9b17395b905 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c

[ ... ]

> @@ -1056,6 +1072,15 @@ EXPORT_SYMBOL(drm_atomic_private_obj_init);
>  void
>  drm_atomic_private_obj_fini(struct drm_private_obj *obj)
>  {
> +	/*
> +	 * Some callers ignore drm_atomic_private_obj_init() failures
> +	 * and unconditionally register a teardown action that calls
> +	 * this function. Make it idempotent so a failed init followed
> +	 * by fini does not cause a double list_del.
> +	 */
> +	if (list_empty(&obj->head))
> +		return;
> +
>  	list_del(&obj->head);

[Severity: Medium]
Should drm_atomic_private_obj_fini() in drivers/gpu/drm/drm_atomic.c use
list_del_init(&obj->head) instead of list_del(&obj->head) so that calling
drm_atomic_private_obj_fini() more than once is truly idempotent?

Because list_del(&obj->head) poisons obj->head.next with LIST_POISON1, a
second call to drm_atomic_private_obj_fini() after a successful
drm_atomic_private_obj_init() will see list_empty(&obj->head) evaluate to
false. It will then execute list_del(&obj->head) on the poisoned list node =
and
call obj->funcs->atomic_destroy_state(obj, obj->state) a second time on
already-freed state (as well as kfree(obj->name) in the subsequent commit
adding drm_private_obj names).

In drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c, this happens when
dpu_kms_hw_init() succeeds in dpu_kms_global_obj_init() ->
drm_atomic_private_obj_init() and then fails at a later initialization step:

dpu_kms_hw_init()
  error:
    _dpu_kms_hw_destroy(dpu_kms)
      dpu_kms_global_obj_fini(dpu_kms)
        drm_atomic_private_obj_fini(&dpu_kms->global_state)

When the error propagates back to msm_drm_init() in
drivers/gpu/drm/msm/msm_drv.c, teardown calls _dpu_kms_hw_destroy() a second
time:

msm_drm_init()
  msm_drm_uninit()
    msm_drm_kms_uninit()
      dpu_kms_destroy()
        _dpu_kms_hw_destroy(dpu_kms)
          dpu_kms_global_obj_fini(dpu_kms)
            drm_atomic_private_obj_fini(&dpu_kms->global_state)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D4

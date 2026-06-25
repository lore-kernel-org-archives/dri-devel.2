Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D6CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A0310E227;
	Thu, 25 Jun 2026 17:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WjgLf5Gc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63AD10E227
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 17:19:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D15960098;
 Thu, 25 Jun 2026 17:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B71F000E9;
 Thu, 25 Jun 2026 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782407950;
 bh=CyDnMY84rGueDLoQX4AePzhlwrAMNZTZBntBys0imTM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WjgLf5GcxYsVi2wqFzrZJ0SdMLYwZD7jpk3fs7+AUWorapf9troxY+2/OEFsta2cX
 fEg7e1duhUrCi/S5hV/tIutTERaJ1PAo7hMbRRZJ23ME8LSEXJUaOXCPxS1vhry72Y
 Q3+MgRT9v2AM9lZXAS3nOLXDkjZTkO4o9N5T43KHEMSJYSAnLqYMZcAi9tqO7NcTPM
 RHnerembGWS+brvx7VPCnWMkv5cOMac95xKJZA2ix0EBZ79ANQ1r7z/jpJJA1q0Va3
 5UgTsFOpUhzzWH9kRSJnlCU8DZQQnsAuzvkxT1VBLhKBAAammEiDrzu5exJ9AfeRkp
 Z/Wkh4f92e6iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: "Jason Macnak" <natsu@google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625170828.3335431-1-natsu@google.com>
References: <20260625170828.3335431-1-natsu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 17:19:10 +0000
Message-Id: <20260625171910.880B71F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Medium] Memory and reference leak of vbuf, vbuf->objs, and vbuf->data_bu=
f on error paths during command queuing.
--

commit 170d71262d2472089fb4a6a1649487aa23d08e9a
Author: Jason Macnak <natsu@google.com>

drm/virtio: Don't detach GEM from a non-created context
   =20
Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
Don't attach GEM to a non-created context in gem_object_open()")
to virtio_gpu_gem_object_close() to avoid trying to detach
a resource that was never attached due to a context
never being created when context_init is supported.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virti=
o/virtgpu_gem.c
> index 435d37d360340..66c3f6f74e9c6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_obj=
ect *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return;

[ ... ]

> +	if (vfpriv->context_created) {
> +		objs =3D virtio_gpu_array_alloc(1);
> +		if (!objs)
> +			return;
> +		virtio_gpu_array_add_obj(objs, obj);
> =20
> -	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> -					       objs);
> +		virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> +						       objs);

[Severity: Medium]
This is a pre-existing issue, but does this code leak the objs array and GEM
object references on error paths deeper in the command queuing stack?

When virtio_gpu_cmd_context_detach_resource() queues the command, it calls
into virtio_gpu_queue_ctrl_buffer(). If an error occurs further down, the
vbuf and vbuf->objs may not be cleaned up.

For example, in drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_queue_fenced=
_ctrl_buffer():

    if (!sgt) {
        if (fence && vbuf->objs)
            virtio_gpu_array_unlock_resv(vbuf->objs);
        return -ENOMEM;
    }

It returns -ENOMEM without calling free_vbuf() or releasing vbuf->objs.

Similarly, in drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_queue_ctrl_sgs=
():

    if (!drm_dev_enter(vgdev->ddev, &idx)) {
        if (fence && vbuf->objs)
            virtio_gpu_array_unlock_resv(vbuf->objs);
        free_vbuf(vgdev, vbuf);
        return -ENODEV;
    }

It frees the vbuf but fails to release vbuf->objs and its GEM references
(unlike the success path in virtio_gpu_dequeue_ctrl_func).

Since callers like virtio_gpu_cmd_context_detach_resource() ignore the retu=
rn
value, is there a mechanism to prevent these resources from leaking when
command queuing fails?

> +	}
>  	virtio_gpu_notify(vgdev);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625170828.3335=
431-1-natsu@google.com?part=3D1

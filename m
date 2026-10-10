Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF0FCA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2800310E071;
	Sat, 10 Oct 2026 17:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HEyZLX5W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CC710E071
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:36:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37354602CA;
 Sat, 10 Oct 2026 17:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6421F000FF;
 Sat, 10 Oct 2026 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791653767;
 bh=CjqYnBcl9z3q3qNdbv/AAn+8FfbwuC0UrtQ0tf+meJs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HEyZLX5Wu76SP9s/s8gkq6DrBZUDadWrVH4bJ2iI0BF+63ONPJMC8RjdiMKuYj3oq
 e7IdudPQmzr51RqnMKOcO0zbHyqAjBZY3aeDLn60cZlygwP7VtJVdA2kL4f9TZbZeF
 J6zbvAmJxDqaRZY9bqm8JC0RTw80GzoG00xirEsDh3InO1oKnwhnhsRi6Ww+IpuuXU
 nffUn4Y7Tb7I/2hjA1PITlufRKMYIbpbM+L32CXfruX7O86LnxKYZH19RX5v/u1Sam
 Y1fMwKyYxmoUZ5NN5gxjOrUQ3yI3pEm8PE7qoiZcuLunG7KiRW1tqtMJ9x0zDXPCcD
 vF5wFe6R4ozYw==
Message-ID: <sashiko-outbox-166779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/imagination: Switch the GPUVM to immediate mode
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-pvr-gpuvm-immediate-v1-1-5b298dfce4f8@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com>
 <20261011-pvr-gpuvm-immediate-v1-1-5b298dfce4f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:36:07 +0000
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
- [High] drm/imagination: memory leak of gpuvm_bo on pvr_vm_map error path
--

commit 191fc7b0dba1141708c7edc0b3aeac368ef8588f
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Switch the GPUVM to immediate mode

This commit switches the GPUVM to immediate mode so that each GEM's GPUVA l=
ist
is protected by its gpuva.lock. It introduces deferred operations such as
drm_gpuvm_bo_put_deferred() and cleanup via drm_gpuvm_bo_deferred_cleanup().

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
[ ... ]
> @@ -214,7 +214,7 @@ static int pvr_vm_bind_op_exec(struct pvr_vm_bind_op =
*bind_op)
> =20
>  static void pvr_vm_bind_op_fini(struct pvr_vm_bind_op *bind_op)
>  {
> -	drm_gpuvm_bo_put(bind_op->gpuvm_bo);
> +	drm_gpuvm_bo_put_deferred(bind_op->gpuvm_bo);
> =20
>  	kfree(bind_op->new_va);
>  	kfree(bind_op->prev_va);
[ ... ]
> @@ -758,7 +769,9 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_=
gem_object *pvr_obj,
> =20
>  err_cleanup:
>  	mutex_unlock(&vm_ctx->lock);
> +
>  	pvr_vm_bind_op_fini(&bind_op);
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> =20
>  	return err;
>  }

[Severity: High]
Does this code leak the gpuvm_bo and the referenced drm_gem_object on the
early error path of pvr_vm_map()?

If pvr_vm_bind_op_map_init() fails internally (for example, if memory is
exhausted when calling pvr_gem_object_get_pages_sgt()), it takes its own
error path:

pvr_vm_bind_op_map_init() {
        ...
err_bind_op_fini:
        pvr_vm_bind_op_fini(bind_op);

        return err;
}

This calls the newly modified pvr_vm_bind_op_fini(), which places the BO on=
to
the gpuvm_mgr bo_defer list via drm_gpuvm_bo_put_deferred().

However, back in pvr_vm_map(), the early return bypasses the newly added
cleanup call:

pvr_vm_map() {
        ...
        int err =3D pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
                                          pvr_obj_offset, device_addr,
                                          size);

        if (err)
                return err;
        ...
}

Because drm_gpuvm_bo_deferred_cleanup() is bypassed here, would this cause =
an
unbounded accumulation of leaked BOs on the bo_defer list? Can this be fixed
by ensuring the cleanup function is also called on this early return path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-pvr-gpuvm-=
immediate-v1-0-5b298dfce4f8@gmail.com?part=3D1

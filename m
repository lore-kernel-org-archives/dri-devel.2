Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAC2C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE3310F67C;
	Fri, 26 Jun 2026 15:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UHF8fXxH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957C810F684
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:11:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A84342E26;
 Fri, 26 Jun 2026 15:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E06C1F00A3A;
 Fri, 26 Jun 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486717;
 bh=NgWQr2gzNLUF60HGOtH1jcrNWZFkrqjSLgH2uYNV8K8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UHF8fXxH78D13DIW76P9ERBKb7D+0+d1FX+e6etgiY9EhhOtSuhuQfuKpRB251VdR
 P9kuSOTnE9n8GjPghbrNmCEb0yLBtdhasHbtstuGPMNUI+DmpX0TbZ4PwgUvHRlgNF
 AeUdiedQkJmBZJsv/X4UeyBh0V694X+4cZzRMEC7YsqLOEYC8T3KI4ooN1BZ46+Z+s
 FQIv9t8Vf6hz6pCfvxgN9u+B8sNoH7JndZH5bKzk7/r3mRGu1qY9hVhrZuoHGvOtvI
 MnICCHUwDR5oPymPoNTgQYBz7scKxrVOqF7KsW9MdpY2CwnEiKOq3HRl0C2YBmTRqY
 6YCFQpt810HIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object
 refcount leak on   ttm_base_object_init failure
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626150142.49732-1-vulab@iscas.ac.cn>
References: <20260626150142.49732-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:11:56 +0000
Message-Id: <20260626151157.2E06C1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Passing `&ushader->base` to `ttm_base_object_unref` causes a t=
ype mismatch that leads to a guaranteed NULL pointer dereference.
- [Critical] Calling `ttm_base_object_unref` in the error path drops the re=
source reference prematurely, leading to a use-after-free and double-free.
- [High] Calling `ttm_base_object_unref` on a failed initialization causes =
a double `idr_remove`, leading to IDR corruption.
--

commit 126458e87c7593f5bdf4d05a97e545b741bd41aa
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object refcount leak on tt=
m_base_object_init failure

ttm_base_object_init unconditionally acquires a base object reference via
  kref_init. When it fails, the error path in vmw_user_shader_alloc only
  calls vmw_resource_unreference but never calls ttm_base_object_unref to
  release the base object reference, causing a refcount leak.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmw=
gfx/vmwgfx_shader.c
> index eca4e3e97eb4e..d82ec43c8901a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> @@ -724,6 +724,7 @@ static int vmw_user_shader_alloc(struct vmw_private *=
dev_priv,
> =20
>  	if (unlikely(ret !=3D 0)) {
>  		vmw_resource_unreference(&tmp);
> +		ttm_base_object_unref(&ushader->base);

[Severity: Critical]
Does passing &ushader->base to ttm_base_object_unref() cause a type mismatc=
h=20
that leads to a null pointer dereference?

The function ttm_base_object_unref() expects a double pointer:

void ttm_base_object_unref(struct ttm_base_object **p_base)
{
	struct ttm_base_object *base =3D *p_base;

	*p_base =3D NULL;
...

By passing the single pointer &ushader->base, the function will interpret t=
he=20
first 8 bytes of the struct as a pointer. It reads the zeroed field, result=
ing=20
in base being null, and then dereferences it when calling kref_put().

[Severity: Critical]
Does calling ttm_base_object_unref() here lead to a use-after-free and
double-free later in the error path?

If ttm_base_object_unref() drops the last reference, it will call the=20
release callback vmw_user_shader_base_release() which frees the ushader=20
object. The execution then falls through to the out_err label:

out_err:
	vmw_resource_unreference(&res);

Because res was initialized as &ushader->shader.res, this will attempt to=20
use and unreference a field inside the already freed ushader object.

[Severity: High]
Can this unref call cause an issue due to a double idr_remove()?

If ttm_base_object_init() fails, its internal error path already calls=20
idr_remove(&tdev->idr, base->handle) to clean up. Because base->handle=20
remains populated, calling ttm_base_object_unref() here will invoke=20
ttm_release_base(), which executes idr_remove() a second time for the=20
same handle.

>  		goto out_err;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626150142.4973=
2-1-vulab@iscas.ac.cn?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE58EC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0552E10E054;
	Wed, 16 Sep 2026 18:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sfg/Mc0v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040F210E054
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:37:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C19B43E8A;
 Wed, 16 Sep 2026 18:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED331F000FF;
 Wed, 16 Sep 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789583844;
 bh=qI3rqaLfBVNb9p6MO4MyzX0bepaO0rF2eK9wsirJj7o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sfg/Mc0vrG0dKH1crcTEvisy2WuTcAt2OPYkpetnui58ZK7CvtA3s2Y1qs2bBe/+C
 Cf7nrh1OM4hz1U/+NrDCvpXtLwJxpLC+20RrYvxISKJq+JTNvwMtxYvCe5Ww3sK+0P
 bpYf4sk/5oWwxo/xtUsL3hN5m0p5yeLx+wloz6Aw7HwcmQfZzph84jt2i4aeCGaSqU
 ePTCQkhin7qoKNaqiPPzbYFcxCJOxtFs+pKXAaw1U+YyREtCrgmlbBWS5QQ1bc4AaC
 EarvEoKv7eiXoR1WtzKF0tu8x2AXQopyhncvn+mnq8D1jHSKTQ0M98EOQQXIncfh6S
 TpqVPUm4DHQjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: Fix bo reference leak in
 host1x_reloc_copy_from_user()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916182550.2091797-1-vulab@iscas.ac.cn>
References: <20260916182550.2091797-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:37:23 +0000
Message-Id: <20260916183724.5ED331F000FF@smtp.kernel.org>
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
- [High] drm/tegra: type confusion and memory corruption in host1x_reloc_co=
py_from_user
--

commit 6284447bfe9e49ad17b9df316519006595821f25
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/tegra: Fix bo reference leak in host1x_reloc_copy_from_user()

This commit fixes a reference leak on the command buffer object when the
subsequent lookup for the relocation target fails. It drops the reference
before returning the error.

> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 324480c87fb1f..1a70d37b8c1f3 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -159,8 +159,10 @@ static int host1x_reloc_copy_from_user(struct host1x=
_reloc *dest,
>  		return -ENOENT;
> =20
>  	dest->target.bo =3D tegra_gem_lookup(file, target);
> -	if (!dest->target.bo)
> +	if (!dest->target.bo) {
> +		drm_gem_object_put(dest->cmdbuf.bo);

[Severity: High]
Does this cause memory corruption due to a type mismatch?

Looking at host1x_reloc_copy_from_user(), dest->cmdbuf.bo is a struct
host1x_bo pointer. Passing it to drm_gem_object_put(), which expects a
struct drm_gem_object pointer, appears to lead to type confusion.

When tegra_gem_lookup(file, target) fails and this error path is taken,
drm_gem_object_put() will attempt to decrement the reference count by
treating the struct host1x_bo as a struct drm_gem_object. This is likely
to decrement the first member of struct host1x_bo, which is its ops vtable
pointer, instead of an actual kref.=20

Since this is reachable from userspace via the DRM_IOCTL_TEGRA_SUBMIT ioctl
by supplying a valid cmdbuf but an invalid target BO, could this corrupt
the vtable pointer and lead to crashes or potential control-flow hijacking
when the ops are later used?

>  		return -ENOENT;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916182550.2091=
797-1-vulab@iscas.ac.cn?part=3D1

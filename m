Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B004AC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C085610E4BE;
	Tue,  8 Sep 2026 20:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jG7OAJUK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C828810E4BE
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:15:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A37B64046C;
 Tue,  8 Sep 2026 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9411F00A3D;
 Tue,  8 Sep 2026 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788898504;
 bh=RlV6izqDzxDIh3ELVy5wP2a87W26fpfzl6ymDEuREuQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jG7OAJUKwV/2jqV8iwZcH9GvFjYw1+BDHzlqWPxWI422YCQne8onLhW+R4Kg8ZtRK
 4UxYA/6k0To3oOa+7u0vSsYCSi8Rn8BUtsBlE2ttQ5L25gOSW8BsQK6YuALp6ZVzyX
 EhstlAbVCJqRgcg9tuM1ykIaxmz4r1QoahApw7xVraCIf78RfSoZBlmH+l5sl9Nyyz
 tiJP0hAQlti3X/NVVch29Nl+ktfzIkXjJRvSTk8NnJWHQ2Dt6LBoFmhG9IXlZ49Dbi
 IDQTj6sg8w/ji1p8ioOs+JCHqx5S0yBTc8e8+/d2ONS36yGL5d7Al1Bdm/ng6i0D6l
 yKG66YygxHAtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: debugfs: avoid extra EOLs in
 amdgpu_gem_info"
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-amdgpu_debugfs-v1-1-3b659e744691@igalia.com>
References: <20260908-amdgpu_debugfs-v1-1-3b659e744691@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:15:03 +0000
Message-Id: <20260908201504.5C9411F00A3D@smtp.kernel.org>
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
- [High] NULL pointer dereference when printing imported BOs in debugfs.
--

commit be759dc89504ad9041bef159ec02b120e04cf61b
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"

This commit reverts an earlier change that removed newlines when no fences
were attached to a dma_resv struct. The original change caused multiple BOs
to be printed on the same line, reducing debugfs readability.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 5d9d137209b6f..1b6c32a177fb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1701,9 +1701,8 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *=
bo, struct seq_file *m)

[Severity: High]
This is a pre-existing issue, but can the access to dma_buf->file cause a
NULL pointer dereference?

In amdgpu_bo_print_info(), earlier in this function:

	dma_buf =3D READ_ONCE(bo->tbo.base.dma_buf);
	attachment =3D READ_ONCE(bo->tbo.base.import_attach);

	if (attachment)
		seq_printf(m, " imported from ino:%llu", file_inode(dma_buf->file)->i_ino=
);

If attachment is non-NULL, dma_buf is dereferenced via
file_inode(dma_buf->file)->i_ino.  However, bo->tbo.base.dma_buf can be NULL
for imported BOs in several scenarios:

- BOs imported via amdgpu_gem_prime_import() allocate a fresh GEM object
  via amdgpu_dma_buf_create_obj(), which does not populate obj->dma_buf
  and relies entirely on obj->import_attach.

- When userspace closes the GEM handle of a BO,
  drm_gem_object_handle_put_unlocked() calls
  drm_gem_object_exported_dma_buf_free(), explicitly setting
  obj->dma_buf =3D NULL, even though the BO itself may still be kept alive
  if it is mapped.

When debugfs iterates over these BOs, reading dma_buf->file dereferences a
NULL pointer.  Since this can be triggered by reading debugfs files like
amdgpu_vm_info, could this deterministically oops the system?

>  	if (dma_resv_trylock(bo->tbo.base.resv)) {
>  		dma_resv_describe(bo->tbo.base.resv, m);
>  		dma_resv_unlock(bo->tbo.base.resv);
> -	} else {
> -		seq_puts(m, "\n");
>  	}
> +	seq_puts(m, "\n");
> =20
>  	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-amdgpu_deb=
ugfs-v1-1-3b659e744691@igalia.com?part=3D1

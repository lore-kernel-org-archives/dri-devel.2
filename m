Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FA2C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D508B10E0C6;
	Sun, 13 Sep 2026 13:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CsziB+oH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C303F10E0C6
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:04:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A17E260E10;
 Sun, 13 Sep 2026 13:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392841F000FF;
 Sun, 13 Sep 2026 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789304698;
 bh=BTDGLo/tFp2qEImBl70MTVA6q2y9+dEH/9A/NQ/bDG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CsziB+oHTERTUEghml1dNOs7G+sB8nq0a3wChCqSZZp0kBfmRzstTfpGRdoXObsd8
 BiinQdnWRaFYChz1s6pDt5usnSyRtyuaO0hDUYYww9ufAtUOVrD3Ghj6DRKDy2VFlM
 uHenl+430Z/9442Vljv649Pu2QYRr+ll7YMADTPzuR6/TSonybvtovdLdSnQBmxOo3
 6QKwH9kjo/UDK7GpjeTR99aa1nrdsWQydjdmsCCd4TsFZ5OjaO6lzBl0004kggsFcP
 MUsn8k1xnv/q01OUj+li//m3FUnin/p407lUcxawgHC2rtL8duCqxYHI8h5eMmKsdk
 Cae6ZnDVdpNcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: host1x: skip trace payloads after mapping failure
To: "Slavin Liu" <bolin.liu@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913125128.109827-1-bolin.liu@seu.edu.cn>
References: <20260913125128.109827-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:04:57 +0000
Message-Id: <20260913130458.392841F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `trace_write_gather()`, the `offset` variable incorrectly accum=
ulates quadratically on each loop iteration, leading to an out-of-bounds re=
ad when tracing gathers larger than `TRACE_MAX_LENGTH`.
- [High] The patch fixes an ERR_PTR dereference for `host1x_bo_mmap()` in `=
trace_write_gather()`, but fails to fix identical vulnerabilities in three =
other call sites within the host1x subsystem.
--

commit 670e4c9b37822e7d842f4b22310017b4bf9a72f2
Author: Slavin Liu <bolin.liu@seu.edu.cn>

gpu: host1x: skip trace payloads after mapping failure

This patch updates the return check of host1x_bo_mmap() in trace_write_gath=
er()
to use IS_ERR_OR_NULL instead of a simple NULL check. It avoids dereferenci=
ng
an ERR_PTR mapping when the original buffer mapping fails. While reviewing =
this
fix, I noticed some pre-existing issues in the same function and in other
callers of host1x_bo_mmap().

> diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/c=
hannel_hw.c
> index d44b8de890be0..e00f257710bdd 100644
> --- a/drivers/gpu/host1x/hw/channel_hw.c
> +++ b/drivers/gpu/host1x/hw/channel_hw.c
> @@ -27,7 +27,7 @@ static void trace_write_gather(struct host1x_cdma *cdma=
, struct host1x_bo *bo,
>  	if (host1x_debug_trace_cmdbuf)
>  		mem =3D host1x_bo_mmap(bo);
> =20
> -	if (mem) {
> +	if (!IS_ERR_OR_NULL(mem)) {
>  		u32 i;
>  		/*
>  		 * Write in batches of 128 as there seems to be a limit

[Severity: High]
This is a pre-existing issue, but does the loop inside this block incorrect=
ly
accumulate the running loop index into the base offset?

In trace_write_gather():

		for (i =3D 0; i < words; i +=3D TRACE_MAX_LENGTH) {
			u32 num_words =3D min(words - i, TRACE_MAX_LENGTH);

			offset +=3D i * sizeof(u32);

Because i increases linearly on each iteration (0, 128, 256...), adding it
directly to offset in-place causes the offset to grow quadratically. If
words exceeds TRACE_MAX_LENGTH (128 words), could this overshoot the bounds
of the mapped buffer mem and lead to an out-of-bounds read in the ftrace
callback?

While this patch fixes the ERR_PTR dereference for host1x_bo_mmap() in
trace_write_gather(), it looks like there are similar pre-existing
vulnerabilities in three other call sites within the host1x subsystem.

In drivers/gpu/host1x/job.c:do_relocs():

		if (!cmdbuf_addr) {
			cmdbuf_addr =3D host1x_bo_mmap(cmdbuf);

			if (unlikely(!cmdbuf_addr)) {
				pr_err("Could not map cmdbuf for relocation\n");
				return -ENOMEM;
			}
		}

		target =3D cmdbuf_addr + reloc->cmdbuf.offset;

[Severity: High]
This is a pre-existing issue, but since host1x_bo_mmap() can return an ERR_=
PTR
on failure, will this NULL check allow an ERR_PTR to bypass the check and be
used as the base pointer for a relocation write?

In drivers/gpu/host1x/job.c:copy_gathers():

		/* Copy the gather */
		gather =3D host1x_bo_mmap(g->bo);
		memcpy(job->gather_copy_mapped + offset, gather + g->offset,
		       g->words * sizeof(u32));

[Severity: High]
This is a pre-existing issue, but could the lack of error checking here cau=
se
memcpy() to directly dereference an ERR_PTR if the mapping fails?

In drivers/gpu/host1x/hw/debug_hw.c:show_channel_gathers():

			if (job->gather_copy_mapped)
				mapped =3D (u32 *)job->gather_copy_mapped;
			else
				mapped =3D host1x_bo_mmap(g->bo);

			if (!mapped) {
				host1x_debug_output(o, "[could not mmap]\n");
				continue;
			}

[Severity: High]
This is a pre-existing issue, but might this NULL check fail to catch an
ERR_PTR, resulting in an out-of-bounds read when show_gather() dereferences
the mapped pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913125128.1098=
27-1-bolin.liu@seu.edu.cn?part=3D1

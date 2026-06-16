Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCA8CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A5710E988;
	Tue, 16 Jun 2026 09:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f/tOG3r3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8FD10E988
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:20:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9696C600AB;
 Tue, 16 Jun 2026 09:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB41F00A3A;
 Tue, 16 Jun 2026 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781601627;
 bh=zhpk8sU1l3pJuEnY2C7a0NvBzc+TPdjsOxUvTxhvYo8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f/tOG3r39fps5pxfGwQi58zewLSIKCD6tXBQk01lcHXs/hpMww/bSTZRVJWbnl6Jz
 KnP0n78IDjGLpXAuDJW0QHZle07O5sW+c7GeYr5I7dAzk9CpgwvnkCJO7PRhgOU+fx
 Y4CJbniNC3k5ojRVnXQ2vyZj4+NoRQwlH6SgYsIJBNnuZXaBSobqFYKYnqDSsoB7jC
 ZSDJLyqL2HSfSJ6CVTj/TgrFALZmA6caHDjVg0hmOt4sIkgZgbkT39ecYJstkvstG1
 UJ7rS8y2boV98jfQr86M3TB4rpsiudFCLn9w/e1ovHyIFzg4GKdsW9hjYOTnivQ9k3
 xAPRvR0aKjSaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Use last + 1 of vm range to check 2MB huge
 page alignment
To: "Gerhard Schwanzer" <geschw@pm.me>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616091050.110064-1-geschw@pm.me>
References: <20260616091050.110064-1-geschw@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 09:20:26 +0000
Message-Id: <20260616092027.29CB41F00A3A@smtp.kernel.org>
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
- [High] Incorrect boundary and alignment checks in `svm_range_split_head` =
cause missing GPU page table remaps for shattered huge pages, and unnecessa=
ry remaps for perfectly aligned ranges.
--

commit 91761d4de2f6b8a545a87df1ae810dd4280f1f59
Author: Gerhard Schwanzer <geschw@pm.me>

drm/amdkfd: Use last + 1 of vm range to check 2MB huge page alignment

This patch updates the split-remap logic to use the exclusive upper bound
when computing the last 2MB-aligned boundary of the original range. It also
modifies the split head check to compare the inclusive head->last directly
against the exclusive aligned boundary.

Link: https://lore.kernel.org/stable/IA1PR12MB85172F7FE9157C092EDA46A0E3112=
@IA1PR12MB8517.namprd12.prod.outlook.com/

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 72cfb4a6ab3e1..30693ed767942 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
[ ... ]
> @@ -1181,8 +1181,8 @@ svm_range_split_head(struct svm_range *prange, uint=
64_t new_start,
> =20
>  	list_add(&head->list, insert_list);
> =20
> -	if (huge_page_mapping && head->last + 1 > start_align &&
> -	    head->last + 1 < last_align_down && (!IS_ALIGNED(head->last, 512)))
> +	if (huge_page_mapping && head->last > start_align &&
> +	    head->last < last_align_down && (!IS_ALIGNED(head->last, 512)))
>  		list_add(&head->update_list, remap_list);

[Severity: High]
Does removing the + 1 offsets from head->last in these boundary checks
introduce unnecessary remaps for aligned ranges, while failing to fix the
shattered huge pages?

Because head->last is an inclusive page index, its aligned boundary values =
are
511, 1023, etc. If a split head perfectly aligns with a 2MB page (for examp=
le,
ending at 511), head->last is 511. The !IS_ALIGNED(511, 512) check is true.

Before this patch, head->last + 1 < last_align_down (512 < 512) evaluated to
false, safely preventing a remap. By removing the + 1, this evaluates 511 <=
 512
as true, causing perfectly aligned ranges to be unnecessarily remapped.

Additionally, if a split head shatters a 2MB page by ending exactly one page
into the next block (for example, ending at 512), !IS_ALIGNED(512, 512) is
false. This incorrectly skips adding the shattered range to the remap list,
leaving stale 2MB mappings in the hardware.

Should the code use the exclusive bound head->last + 1 for all of these
comparisons, including the IS_ALIGNED check?

>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616091050.1100=
64-1-geschw@pm.me?part=3D1

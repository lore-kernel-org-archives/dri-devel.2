Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F0CC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B310610F351;
	Thu, 24 Sep 2026 07:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IZXRMrcd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F27310F33A;
 Thu, 24 Sep 2026 07:09:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56F4B437D9;
 Thu, 24 Sep 2026 07:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB3D1F000FF;
 Thu, 24 Sep 2026 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790233789;
 bh=8cex8ehnI9/LG24G4BSpPe7A5cc6nDYEJ2W/KSAl3Vs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IZXRMrcdfni75a9c2J0bB9z3lWCKmMxjrFSlYc8glgrIduELjxOsYn+4hnetc11om
 qpovRln7+60iTVpI7LB1m6GaZEn1ezXo/MRkp4swCCvhTNeB7G57po7lByrhnI+Dtj
 gMr6SleDSSv4SmklXHMEnXyonAlxJDrEC9eR3RiGqwlhTRPstYRoge4CGEFwAXL/ti
 th4SNQPtnQxK/nFgPnhcW6xVKHb9A6tjHtwCudFnICOphj8kXnaWbOyOKlzlCV8yJx
 BHRPnNzC1LnwpA8D2tEr7L2g00Km+eb/8SD/O8LbuD1Al+aV7AqD5cBlB/aHGC/s+r
 Z8f5oES0a9HmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/11] mm/hmm: preparations for HMM to participate
 in migration
To: mpenttil@redhat.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924065313.899730-4-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <20260924065313.899730-4-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:09:48 +0000
Message-Id: <20260924070949.0FB3D1F000FF@smtp.kernel.org>
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
- [Low] mm: migrate: missing MIGRATE_VMA_SELECT_NONE under CONFIG_MIGRATION
--

commit b1bec522cfd1d7118c74e979fcadbaa2b246dc13
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: preparations for HMM to participate in migration

This commit prepares HMM for migration by retrieving the VMA during page
walks and ensuring the mmap_lock is held. It also renames some hmm_vma_walk
fields to prevent namespace collisions.

> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 78424b3824c29..01c5f62a56e99 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
[ ... ]
> @@ -150,7 +175,7 @@ static inline unsigned long migrate_pfn(unsigned long=
 pfn)
>  	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
>  }
> =20
> -enum migrate_vma_direction {
> +enum migrate_vma_info {
>  	MIGRATE_VMA_SELECT_SYSTEM =3D 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE =3D 1 << 1,
>  	MIGRATE_VMA_SELECT_DEVICE_COHERENT =3D 1 << 2,

[Severity: Low]
This is not a bug, but could we add MIGRATE_VMA_SELECT_NONE to this enum
under CONFIG_MIGRATION?

It looks like it is missing here, even though it is defined in the fallback
block when CONFIG_MIGRATION is disabled. This is strictly a compile-time na=
ming
and style issue and has no runtime effect. Note that I initially thought
MIGRATE_VMA_SELECT_COMPOUND was also missing, but I see it is correctly
defined in the tree.

[ ... ]
> @@ -192,6 +217,29 @@ struct migrate_vma {
>  	struct page		*fault_page;
>  };
> =20
> +// TODO: enable migration
> +static inline enum migrate_vma_info hmm_select_migrate(struct hmm_range =
*range)
> +{
> +	return 0;

[Severity: Low]
Does the missing MIGRATE_VMA_SELECT_NONE in the enum definition force this
code to use a literal 0 as a workaround instead of a named enum value?

Could we define MIGRATE_VMA_SELECT_NONE and use it here for better
consistency?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065313.8997=
30-1-mpenttil@redhat.com?part=3D3

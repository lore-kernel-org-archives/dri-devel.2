Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99121C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931F610F589;
	Thu, 13 Aug 2026 22:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O8o86Iav";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340F310F584;
 Thu, 13 Aug 2026 22:51:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B32541781;
 Thu, 13 Aug 2026 22:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C671F00A3A;
 Thu, 13 Aug 2026 22:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786661495;
 bh=oJsDCAYWqbgHTBUR1oNr/aekX7t13J8ViafDr85pnv4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O8o86IavNE5VGQOlPGgs5csqXNx+e+iGc0z9rd+TAgIQlm9boQHyXyVEVxl587Inz
 lJU2D+qHjMFPyl0VxrbEHuKKC6Ay8JrZnyLOahmXpTlgzBo3dRNMzhxDPVVxUKyghF
 JpTmvFZ6qe448bysVlSGCCTKjRUy5mFNzq6jgthUuexgVhdDoGSFBzZpTP4dmG7hKk
 0jKBq8xojefbR0XL6VtPe8O4OIjVD2eJg+bae6nW5jTX6LJEy3MOrSKSaaxl3WeTGf
 cmTCgRJVpcYaAwVvxHR+JwqQjVvPgh6i4WD8uhdx2jYK1PChmXQwMZ9+422X+bLAnQ
 c7NTH/RzgvmHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/69] vmlinux.lds.h: move BOUNDED_SECTION_* macros
 to reuse later
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260326185413.1205870-3-jim.cromie@gmail.com>
References: <20260326185413.1205870-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:51:35 +0000
Message-Id: <20260813225135.B6C671F00A3A@smtp.kernel.org>
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
- [Low] The newly created file `include/asm-generic/bounded_sections.lds.h`=
 is missing an SPDX license identifier.
--

--- Patch [2]: [PATCH v12 02/69] vmlinux.lds.h: move BOUNDED_SECTION_* macr=
os to reuse later ---
commit 66f82d3de735bc79fa17c5cd892641b6f5cecb8c
Author: Jim Cromie <jim.cromie@gmail.com>

vmlinux.lds.h: move BOUNDED_SECTION_* macros to reuse later

This commit moves the BOUNDED_SECTION_* macros into a newly created header
file, include/asm-generic/bounded_sections.lds.h, and includes it back into
vmlinux.lds.h. This change sets up the macros to be reused later.

> diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-gen=
eric/bounded_sections.lds.h
> new file mode 100644
> index 0000000000000..280a893bbe29f
> --- /dev/null
> +++ b/include/asm-generic/bounded_sections.lds.h
> @@ -0,0 +1,36 @@
> +#ifndef _ASM_GENERIC_BOUNDED_SECTIONS_H

[Severity: Low]
Should this newly created file include an SPDX license identifier at the to=
p?
Kernel policy generally requires new source files to have one.

> +#define _ASM_GENERIC_BOUNDED_SECTIONS_H
> +
> +#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260326185413.1205=
870-1-jim.cromie@gmail.com?part=3D2

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3DAC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 01:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1373A10E131;
	Tue, 30 Jun 2026 01:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VB8Equ1s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AEA510E12E
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 01:27:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40A2043A36;
 Tue, 30 Jun 2026 01:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038951F000E9;
 Tue, 30 Jun 2026 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782782867;
 bh=NzqpxuPm/PV3H3F66hY7OW8qG8SoLhhUpFwYcOtymww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VB8Equ1sqsJJBT+6i9M93XAwt5rdDm1JwOh5AOG0s7CLk9uiRc7ocTGNHcx3gX1bw
 M1xEYI4qSBV8n0aOKEX2y9Dgq+AZGxIr6c7PwqwRPzvwGnAmnsFBjV3LWCCXvifeYF
 xdEhaqPWyfcSD62pMrsi6XOv0P77EZm2mhEaOeitvbAQVLUWHxgaVNDZqCb+MLlYb1
 57NRSLFwRJPAzHy6cZCcZn6nOwS3yYYpGjnh78ZcgopHm3V41VjMmoHm3eGeHhJjcP
 xjzsxlWEBKFmNSuwhVxE6hvMfqw40g0s/EDwTVknF/Sb5jWRHvLOYGyqeSwm4lwOag
 Zx8fqLKBnOT/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: i915: use kzalloc_flex
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630011907.1453253-1-rosenp@gmail.com>
References: <20260630011907.1453253-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 01:27:46 +0000
Message-Id: <20260630012747.038951F000E9@smtp.kernel.org>
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
- [High] Flexible array conversion forces inefficient order-1 (8KB) allocat=
ions for page directories.
--

commit ed37e64eb293a3ef09353d34ef014044171cfe28
Author: Rosen Penev <rosenp@gmail.com>
drm: i915: use kzalloc_flex

This patch simplifies the allocation of i915_page_directory structures by
replacing a pointer with a flexible array member, consolidating two
allocations into one.

> diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/g=
t/intel_gtt.h
> index b54ee4f25af10..642b5c856a55a 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gtt.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
> @@ -186,7 +186,7 @@ struct i915_page_table {
>  struct i915_page_directory {
>  	struct i915_page_table pt;
>  	spinlock_t lock;
> -	void **entry;
> +	void *entry[];
>  };
> =20
>  #define __px_choose_expr(x, type, expr, other) \
> diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915=
/gt/intel_ppgtt.c
> index 72d8473a448b9..20cc59a005c97 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
> @@ -36,16 +36,10 @@ struct i915_page_directory *__alloc_pd(int count)
>  {
>  	struct i915_page_directory *pd;
> =20
> -	pd =3D kzalloc_obj(*pd, I915_GFP_ALLOW_FAIL);
> +	pd =3D kzalloc_flex(*pd, entry, count, I915_GFP_ALLOW_FAIL);

[Severity: High]
Does this flexible array conversion force inefficient order-1 (8KB)
allocations for page directories?

Consolidating the entry array into struct i915_page_directory pushes the
allocation size from exactly 4096 bytes (for the array) to 4128 bytes. The
base struct is roughly 32 bytes, plus 512 * 8 bytes for the flexible array.

On systems with 4KB pages (like x86), a 4128-byte request cannot be satisfi=
ed
by the kmalloc-4k cache and spills over to the kmalloc-8k cache. This requi=
res
an order-1 page allocation, wasting 4064 bytes per page directory and
significantly increasing the risk of allocation failures under memory
fragmentation compared to the previous order-0 allocation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630011907.1453=
253-1-rosenp@gmail.com?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9693CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4810C10E6DF;
	Tue, 13 Oct 2026 04:16:25 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1FD10E6F5
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:16:18 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-5339733feb9so24307681cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791864977; cv=none;
 d=google.com; s=arc-20260327;
 b=LSwA60lUeDbdWgi6IAIM5YHkJFjYz5zFlsDg2YFriyOaoSGq2Z2+9hSsZMfRcx/41k
 fHR012jI5Q6HzadZuGT1K6GHOBmT1ommi6KKguS+Qkl3QlJUW2G2XzBrbRxWuHyibvvQ
 owYUGclMtwDtHn+FAQG13CwrlyhoKrZonzNZsLTxSGKvET9VaML4sFfMNUxApjHo0WLk
 yelIaj8CUJqtTOYnf4YZv30C8VZ3ciglOyhXy2j+Q0UNjTLgLfoweITfjT24XBNKQfvh
 niSEDYDUwBouI5ItB4CqwqQZtkh+A3a/LO+xCrc5OoiBrlkuB7ypnPpPqpBeqih0g8oz
 3Ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s9nsO0UGothDGSbTzPgGoq1CEP4hbj1NtB+IcAtJLLI=;
 fh=jr0bxnIBwVasogniuQNwUUSobLi2AxxupSmv7DHyh+o=;
 b=NtMEpWp6bZ5eV5sRvqxZwiyAHkmWZUTq0ORhR23nJ9+x4Ug361XeBJXiKpJbW4Ep+2
 cU48xlnAAJwT4cnr9oA/6GYrGseGig6cU0RQiOJ99hyz0488gRTjRLZ16gLEvLoj1WPE
 a/UQcdK7oQh2Ckbay65UJdjjMIjJprqc/7BwratiCCzmZ/0uexzFY+MwyRsan9bzrDrh
 PCWyjFerqmQPARpdAdESLG1vAfv8pQ4dfS+0LoFJKzcjV0UA1v90X5KhHbb2czPX+PWC
 o3ToKdPccl3UwAezeBH4EiebaIkYNSs6hXsRnLz9FmuFWzokv5CD7BaATKG78oWWvmy5
 4Lyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791864977; x=1792469777; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s9nsO0UGothDGSbTzPgGoq1CEP4hbj1NtB+IcAtJLLI=;
 b=W5AV+oLo2zMFGrVFYuwOcst31SoFbb1H+VChhuX+WSzK8Bz/TVEUWR+WNs1wIrJ4uY
 ymg0RKDSAn//9B39S0KCpALpY+fAwoD0mCToXIuNfCLtXsN+M+0BXZRoPe0632TPAYb3
 qPXRcqOXb3ycwt/jgrSh0R4sRKqbARMDI5Z481N9ONsggrFb89KKZZLKdwNmMz4pl/rU
 Z812T1nYxnTu54IdnoBDvOX5tRFUc2kZzou1XGhwcId1CcFuRi5Wwh58e1yaI4mVVIZ4
 H5+UtYqa3qgMx9ZrBkBk+EE3HU4CGzHEEsZBqyvR5R8Len617tnHJONtjR69cQ5Awu/2
 Ogjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791864977; x=1792469777;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s9nsO0UGothDGSbTzPgGoq1CEP4hbj1NtB+IcAtJLLI=;
 b=Pu2Wb2aP6I9ivr6ZTXqYQPZw+XowtYN3ZL558ieIX1d1cDVdpklMw8XnDHd0X5X6mC
 mPPhwiKy80dS5PMNQgfMbIHIZSVEJz8YQHAcbHtfY6UIsba5fs0kjyN6p5CJxE0J/Gzk
 FAQF2uvGYyjzgmre4vuf3ZEV8V5ZWDf16wvCqDJoiYi3I0IQioqNLcXldoxdpSyxfJ+U
 gn4uq4njdOcmeM4K2c4u39GADBcVf73qkM8TRgZzAX1MUoxSGVon0pFgRjsP6IrB5jTQ
 ETE4V/4xFYL9rB+bNHhqEZTJwnPO+F+Yx8sNiJt/rG17qINUdhlNfx0wf/8wVWFs5LiN
 iN6w==
X-Forwarded-Encrypted: i=1;
 AKwUvByyeMdu+3lrqL6TGnXeK3nYQt1YAYOJKSc2wD8UMc6JUU8RUHFEVPrzfqrah+HYZ6IVOQV4k3r41YE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiM0qSY3TDZd4V9K1nRf/eM0qm2I5Wu3i9j9jpceKdlDU8id0t
 TkTs8CQJ95v0gTY7dKUEQL7ehyTdpcgaUly2g3aFKz+kBFL+bxZh6lxXTpUgyMP0UyenUwSK0Bz
 anDDqT3OmSmJVKp7yMLWH0SATkPm+jJ4=
X-Gm-Gg: AYBFou34LYeY8f5hEmiYetN0V+L/DiUVF6P5pz7XbAseBEw1Bc582iSaSBekvc+TQib
 5OPhQlcXeGbgAIXzmR20PGGjGDIxmCbK/Vm9ODIlVO3T03P3bR0gwqDziDQce9/C3XEiLQjFI3n
 2hOfj2zkoqwMA/6gaZRKEBt3zNhnaOd4TQRUQQ+6ztJxuisaEvELsNP80rqQiINh37ez4YYuc9v
 bx+mhIrR0yb4H1AjExyAuza1o9foC1P5eVzeKcre1WN5+QFqCqsirL4AY/V/rw1JmQU90hOfVhI
 jqlCV8THzdv2gqnQUvAEZVmliDZbmZZJ6Bt1trpfkX32KA4VlQ4G2SZ1roVfS3Bn+vhWn1OdDZD
 CIBjlPnyb7MRKdxqwHxuweFbeVp+q0XmGl23ZsNKu
X-Received: by 2002:a05:622a:4d89:b0:533:a8fe:e43b with SMTP id
 d75a77b69052e-5359fb65378mr173702381cf.38.1791864977501; Mon, 12 Oct 2026
 21:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260913084907.520877-2-david@davidgow.net>
In-Reply-To: <20260913084907.520877-2-david@davidgow.net>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 13 Oct 2026 14:16:05 +1000
X-Gm-Features: AclHuK_SP0l1zjHTbNHKw24D3i8q_PEVEt7AWawe0CGqkzoKBq90LKfm_nii028
Message-ID: <CAPM=9twi62M3zJJMGa4M8WybEXhX6VK7VGtGBjrBUX4YQRs9+A@mail.gmail.com>
Subject: Re: [PATCH v3] drm_buddy: fix power-of-2 rounding errs
To: David Gow <david@davidgow.net>
Cc: Jim Cromie <jim.cromie@gmail.com>, "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Auld <matthew.auld@intel.com>, 
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, 13 Sept 2026 at 18:49, David Gow <david@davidgow.net> wrote:
>
> The standard roundup_pow_of_two() and rounddown_pow_of_two() macros use
> unsigned long internally, which on 32-bit architectures (like arm32) is
> a 32-bit type.
>
> drm_test_buddy_alloc_exceeds_max_order() uses these on a u64 value,
> where they silently truncate the 10GB allocation, giving unexpected
> success in DRM-CI.  (see below the snip).
>
> Fix this by replacing the those macros with safe 64-bit power-of-two
> calculations using ilog2().

If we are going to do this, but fix it properly later, I'd rather we
add the 2 64-bit macros to the buddy allocator and use them,rather
than open-coding this, then knowing we did it later.
so add 64-bit rounddown/roundup macros earlier in this file with a
comment, then use them here.

Dave.
>
> Fixes: 0a1844bf0b532 ("drm/buddy: Improve contiguous memory allocation")
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: David Gow <david@davidgow.net>
> ---
>
> This is a straightforward rebase of patch 39 of v12 of this series:
> https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmail.com/
>
> The only changes are updating the buddy path (as it's no longer a part of
> DRM), and adding the Fixes tag.
>
> This is a fairly hacky solution: I've got a nicer series which adds clearer
> helpers and generally cleans up all of these macros on 32-bit systems, but
> it's much larger (and growing as more things need cleaning up), so I'd
> rather have this more urgent fix go in immediately, and save the cleanup
> for a less-urgent follow-up series:
> https://lore.kernel.org/all/20260830103321.2042968-1-david@davidgow.net/
>
> As noted in the original series, this is causing KUnit test failures on
> all 32-bit architectures:
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at drivers/gpu/tests/gpu_buddy_test.c:1429
> [09:01:26]     Expected err == -22, but
> [09:01:26]         err == 0 (0x0)
> [09:01:26] WARNING: drivers/gpu/buddy.c:508 at gpu_buddy_fini+0x244/0x2e0, CPU#0: kunit_try_catch/1595
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:508: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
> [09:01:26] WARNING: drivers/gpu/buddy.c:516 at gpu_buddy_fini+0x284/0x2e0, CPU#0: kunit_try_catch/1595
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:508: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
> [09:01:26] WARNING: drivers/gpu/buddy.c:516 at gpu_buddy_fini+0x284/0x2e0, CPU#0: kunit_try_catch/1595
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:519: gpu_buddy_assert(!mm->used_scoreboard[i])
> [09:01:26] [FAILED] gpu_test_buddy_alloc_exceeds_max_order
>
> Cheers,
> -- David
>
> ---
>  drivers/gpu/buddy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 26e7a48b55f3..964a5ae78f1b 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1188,7 +1188,7 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>         u64 modify_size;
>         int err;
>
> -       modify_size = rounddown_pow_of_two(size);
> +       modify_size = 1ULL << ilog2(size);
>         order = ilog2(modify_size) - ilog2(mm->chunk_size);
>         if (order == 0)
>                 return -ENOSPC;
> @@ -1435,7 +1435,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>
>         /* Roundup the size to power of 2 */
>         if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> -               size = roundup_pow_of_two(size);
> +               size = 1ULL << (ilog2(size - 1) + 1);
>                 min_block_size = size;
>                 /*
>                  * Normalize the requested size to min_block_size for regular allocations.
> --
> 2.55.0
>

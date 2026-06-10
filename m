Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8D0CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671BB10E794;
	Wed, 10 Jun 2026 08:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="rONbnDjl";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB28010E79C
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 08:06:53 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so9255431a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781078812; x=1781683612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tV8bVaCGg3y34HefJ73rptnGNh2U6CedJrnOiZid/gE=;
 b=rONbnDjlWhCUWVkBGCfXJ/v0I9qF6oTYPiXwzAfhBglbcmBX1v6q5d0htVnkvqcbg5
 1+AxjtAhAlPW6Lnv/xYOCJprJdYdRSLlhhi2hnqp4YgFj9CzHqEVIaGh045fAsy+RqHL
 MTatj8XovCKYmYQcShxbFkMbNtb7QbLGhP2o4tzwLHoNopU1m0CMtEl6kuCYGpunwjwp
 US1Wxri8z5ZhATpq8thaMV3m5/EkkVNNyACvJ/6FDV3IB/q2eXJs4ijpYj6OJlyLewvb
 Sj6Pg7UYkUZCYKW1GwF+wYYi0pZ5pE1RYR1KOK8rQqLfuDGiB0lMbtCUtO3wv40si2nK
 N+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781078812; x=1781683612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tV8bVaCGg3y34HefJ73rptnGNh2U6CedJrnOiZid/gE=;
 b=szu7CtIDQW7S+NZKH9nm7YbDTvXWX38yb/tZ6DkJDjcJ0SxqGgTDv0PuVSUjEzze3a
 moYUsYtYn8tNFbGXBCRdG9bUE0QLGFqd5m0eNRoIfdo4XyOgNwz7e+J64m7hR4yVI9hI
 yHCXOJ2pgFPP4mnv+YCxQOH4YJeiPooyIebgH7tJ0VYFX2hqIKJpnRcXHtMtnYrMAHxA
 2S0jgQCAm/6kROxFx9ZyjtC4YNzGKBh+crAvkE7070QTLnLq4MkWY1067bKg2DBeYxIL
 gwFWJSPuKxuqHiXmXxT87TVSBRp5+cKvrbqCQLdBgsApaBruWl4TWkzZ8aE0DhluedUe
 FGMg==
X-Gm-Message-State: AOJu0YxBaakD+yDsP41Vo5/Pj72TAIjFKUZvORezXHIqBXtnB2FpmIV3
 swW2zXNQT0CbKS6BuzCrHHrDkEh8Xxu3fhrX5lQoseINsnKprTM3kS00k5VF/Qow/UU=
X-Gm-Gg: Acq92OFRM/6T3ILbYBvZFN0p97L3ni3Oyhc9gLlBVMNbtxZaA/0zHRgaMk4mVopN/Iz
 0yFzFU66jYxOa4EgeTEaIz5lptQdKAbAtibgznYIIhImPqfQzqsodX8QNOtU/aw0OZgB1a/2Nl0
 ljkqCGiGo2wzzT/Bl9djlQQKV4Q8e/kqD9D60YWyYxvRNTqsPONIsXdR4vEfn5U8mLDXqpkY1X9
 xNGCxrDPi4E6Rantx5b7umh74bZ7eZiTLucyBXp/kp18qM2HRS0VSY2vQpG5v7WKJj63q3XcGgA
 DiZoRm+clwAQ7hSkC6ubAb3rf4xwqSrY1y4/vsunVLP66T1DqNwZoIFCeb6hJZhyJBqjHjQRHMN
 KB8zI8eDkC3gGByAPifmY9fYA3TKgWYYGJgs7DLc6bJGjyNiUlhAwuHOakDLoUCNjziSQx4iQ+o
 DltQgReMvzoD7Wj7/kq1FInwQbRvE2w4gHgtJ/yDxeyRII4VR5sM84Qno=
X-Received: by 2002:a05:6402:d0d:b0:676:988e:8eb6 with SMTP id
 4fb4d7f45d1cf-68fa5354446mr10490926a12.26.1781078812054; 
 Wed, 10 Jun 2026 01:06:52 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e6585154dsm9480292a12.15.2026.06.10.01.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 01:06:51 -0700 (PDT)
Message-ID: <9f827a2e-bb9a-4356-96d1-6b10d100695b@ursulin.net>
Date: Wed, 10 Jun 2026 09:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gem: Fix phys BO pread/pwrite with offset
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, stable@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 10/06/2026 07:03, Joonas Lahtinen wrote:
> sg_page() returns struct page pointer not (void *) so the scaling
> of pread/pwrite is wrong for phys BO and wrong parts of BO would be
> accessed if non-zero offset is used.
> 
> Last impacted platform with overlay or cursor planes using phys
> mapping was Gen3/945G/Lakeport.
> 
> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: c6790dc22312 ("drm/i915: Wean off drm_pci_alloc/drm_pci_free")
> Cc: <stable@vger.kernel.org> # v4.5+
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_phys.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> index e375afbf458e..d53129eb5603 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> @@ -18,6 +18,17 @@
>   #include "i915_gem_tiling.h"
>   #include "i915_scatterlist.h"
>   
> +/* Abuse scatterlist to store pointer instead of struct page. */
> +static inline void __set_phys_vaddr(struct scatterlist *sg, void *vaddr)
> +{
> +	sg_assign_page(sg, (struct page *)vaddr);
> +}
> +
> +static inline void *__get_phys_vaddr(struct scatterlist *sg)
> +{
> +	return (void *)sg_page(sg);
> +}
> +
>   static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
>   {
>   	struct address_space *mapping = obj->base.filp->f_mapping;
> @@ -58,7 +69,7 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
>   	sg->offset = 0;
>   	sg->length = obj->base.size;
>   
> -	sg_assign_page(sg, (struct page *)vaddr);
> +	__set_phys_vaddr(sg, vaddr);
>   	sg_dma_address(sg) = dma;
>   	sg_dma_len(sg) = obj->base.size;
>   
> @@ -99,7 +110,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
>   			       struct sg_table *pages)
>   {
>   	dma_addr_t dma = sg_dma_address(pages->sgl);
> -	void *vaddr = sg_page(pages->sgl);
> +	void *vaddr = __get_phys_vaddr(pages->sgl);
>   
>   	__i915_gem_object_release_shmem(obj, pages, false);
>   
> @@ -139,7 +150,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
>   int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
>   				const struct drm_i915_gem_pwrite *args)
>   {
> -	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
> +	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
>   	char __user *user_data = u64_to_user_ptr(args->data_ptr);
>   	struct drm_i915_private *i915 = to_i915(obj->base.dev);
>   	int err;
> @@ -170,7 +181,7 @@ int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
>   int i915_gem_object_pread_phys(struct drm_i915_gem_object *obj,
>   			       const struct drm_i915_gem_pread *args)
>   {
> -	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
> +	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
>   	char __user *user_data = u64_to_user_ptr(args->data_ptr);
>   	int err;
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13B3CA6004
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 03:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE7010E7C7;
	Sat, 10 Oct 2026 03:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObnZ8otk";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26F710E21D
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 03:59:12 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so158971a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 20:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791604752; x=1792209552; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C2sBX9RzAUijwlycitpdPIp/C+J3gojjvyNQwGnJMzc=;
 b=ObnZ8otkq2GwFSt6w7l2V11CMtX1Vw6EwC6WCVGZngv8bYTzj3erF7WwzEWvRkNKzm
 XwS34rvY5Wpgmmo9QqLwgXEUr1qxnby7ZatdhFlgeoIn39tNyMARu8RuA0iqLb2frNqx
 pXL+Y/df/DrvgsC+jvAkb5k+aIDWqy9wmyqKm9a7Emhm+Xpe4GIsygvDCgidEQ8TkNHY
 1gxodycCv/CAQah5oKjbDZxSq+QJMBf4Qe5qH1KU9xEPUUyj2f7EGkO9mMByV2edsUbc
 IGqCgRFCyzwAlFXcda/L1wS5hrCcpj101jISNdrXByQ//8L/9WdjtehyGtn1wGQ9X5WZ
 QTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791604752; x=1792209552;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C2sBX9RzAUijwlycitpdPIp/C+J3gojjvyNQwGnJMzc=;
 b=FPqoZataB+ba52oipF1JHoDQc5IssgHf1tbOvL1GlJpF0hD3PUq7rZHl1JhiHYHoFr
 w7ubVDTInJ3e8GZ3AUzznY9J1Zh2ZAPqdRzctvLdKauzmAyVXlDW6ki/lGH5ShmCql/i
 TtseBe3fhqqEkakkBOY5KFKWCydd33liSPqPj/i7CUYyaYiXAP/MweMUoV5gp2xcY8Y3
 rr4U41/VT2OBSgtp61LeeSRBA07EVuCUJcVCZe43hO5Z4pqAGgJzTXz3o43+1MqNebD8
 YeWyWxOfBS3xvFoPI2BDgzJIPL3QGQ37v8OZJMl1zoDXh4/z16yJSD7sICVzDu85YBSK
 UeUw==
X-Forwarded-Encrypted: i=1;
 AKwUvByV8jsUAhCb4urcUaN5FqShgMym7EuODla6DYDuX1gQHpH6YX7uamVZ9x+8lkmp3RM0QNxvdckGQ/A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtjdga613Fjb8/YxfG+bzUsOAW8ZPywXuujgC9yJYnsMhmpHVa
 jtWq7FagVKJQCBC1dKZEXPNozbjZpfe/B/MdsXnZ+UU1dmp0l6kiLi2X
X-Gm-Gg: AYBFou3sAQmtiZHN3dCB9HQPVbk3miXbVaUCG8l7+5Y4FRkjDuMI/ZSMGqxyjpm/+ZC
 i3/AXOoZ0jQGYTDmgeaj34VEIkM2uuqj8fDHvpPontKdvsE8A9prPcuEOf2UR4hKWOK/0QU9Wez
 3T8daRQnI854WigeUh64syS5OCOC03W0JnjKg5Nkkei2VmdcdeNLJxx4aZcZu8DwiM/2ij2n14R
 WJrz6i6tfGbbe3aKc+Ac4Cpafce3fczjNFoqmscsjO5RutTp2Chlg9nq74My3CkYn9UdEL+a5X3
 yjv2qAJpoqhJGOEN3djK6kT5nB44+uxd24kq7kuP33XYpxieVj29HC3+vKMrN4uWfWTI5hwoJzk
 LetTS2NABlArBneq60ExOrlhv1VXKiTTVBjjsLNRQyVJrhd7J4ZWf6jpZ+GwFgFRLw36czNEOqX
 IVuq+TqBjn7lgTwbudvedbx1nVM8j9Q20I9q4N2vIrA2YowVIElnMVVetpFDPyeS8BAuuUWs446
 OUasR/NTG1UTJCbY0Sr2ua6f1+sndNDXw==
X-Received: by 2002:a17:90b:134c:b0:3a0:cbe2:9e0c with SMTP id
 98e67ed59e1d1-3ab3b0285d5mr2844887a91.63.1791604752082; 
 Fri, 09 Oct 2026 20:59:12 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab338676besm3793206a91.1.2026.10.09.20.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 20:59:11 -0700 (PDT)
Date: Sat, 10 Oct 2026 12:59:09 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Xiaolin Zhang <xiaolin.zhang@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhiw@nvidia.com
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
Message-ID: <asm4DV84UitLCbve@dell-wzy>
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004212403.208681-1-oss.patchbox@gmail.com>
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

On Sun, Oct 04, 2026 at 05:22:39PM -0400, Yuho Choi wrote:
> intel_gvt_dma_map_guest_page() unmaps and frees the cache entry of a
> gfn when it is requested with a different size, and maps the page again.
> The entry is still referenced: shadow GTT entries and dma-bufs keep
> using its DMA address after the page is unpinned and the DMA mapping is
> torn down.

I don't think this is *real*, as code would simply destroy entry in
that case, and there won't be on-the-fly dma operation on that, as
guest mem setup is totally before execlist submission, if guest driver
changed mapping by ignoring gvt emulated execlist status, that's just bad...

> When the new mapping gets the same DMA address, their later
> intel_gvt_dma_unmap_guest_page() calls also drop the references of the
> new entry.
> 
> Keep the existing entry instead. A 2M mapping covers a 4K request for
> its first page, so take a reference on it. If the entry is smaller than
> the request, fail and let the caller split the 2M entry into 4K pages,
> as it already does when a 2M mapping cannot be set up.
>

So this change would always force 2M to split into 4K? why?

> Fixes: 7366aeb77cd8 ("drm/i915/gvt: fix incorrect cache entry for guest page mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 defconfig + DRM_I915_GVT_KVMGT, W=1, sparse).
> 
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index ec62db5cc3675..9a3e305253469 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1626,19 +1626,15 @@ int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
>  		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
>  		if (ret)
>  			goto err_unmap;
> -	} else if (entry->size != size) {
> -		/* the same gfn with different size: unmap and re-map */
> -		gvt_dma_unmap_page(vgpu, gfn, entry->dma_addr, entry->size);
> -		__gvt_cache_remove_entry(vgpu, entry);
> -
> -		ret = gvt_dma_map_page(vgpu, gfn, dma_addr, size);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
> -		if (ret)
> -			goto err_unmap;
> +	} else if (entry->size < size) {
> +		/*
> +		 * The smaller mapping may still be in use, so don't replace
> +		 * it. Fail and let the caller map the range in smaller pages.
> +		 */
> +		ret = -EBUSY;
> +		goto err_unlock;
>  	} else {
> +		/* A mapping of the same or a larger size covers the request */
>  		kref_get(&entry->ref);
>  		*dma_addr = entry->dma_addr;
>  	}
> 
> base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
> -- 
> 2.43.0

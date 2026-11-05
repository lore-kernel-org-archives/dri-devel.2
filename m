Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48587606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuYpFVUv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B307610F252;
	Thu,  5 Nov 2026 08:38:50 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2708B10F252
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:38:44 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1049937a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793867924; x=1794472724; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0uDYlxqiv0mSLq/hIWs5/UPyDpAbAUOWaGdtWRXlapg=;
 b=tuYpFVUvKgLktSqBiwEfPYSGvKYzFqEonioz5EWW1kNmIRbByNuYVobKYqdGlWhMx0
 JaegITB0gSJMun7CURDrUt2nu3s0idoRAG6dtf75HYLFv7nrsiepaLkAX9MnDJcRY5VW
 +Skl9tQxJVOrtNjhTTvp1jfRuGkB5M1XcsSxtQDEbr5LVu2hrUaVwmIbH6j2EeZ1Rtn8
 LTfnTG9O2pIZavwhrHmWJkjq6G3JuVFZCNBLEzKBWY2HMpV9UlSwRAVK0YbcEBikd1Pf
 Uq8/XmiRBSvMgQp0Z91sUo/b5hlNHvFkXg4SSL5yS6Y3HQHeZmWNKKVtH1FEXidDoTPb
 KDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793867924; x=1794472724;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0uDYlxqiv0mSLq/hIWs5/UPyDpAbAUOWaGdtWRXlapg=;
 b=nvJfYGmflkmWFQHbmYldnt5LNL2XKOQBWtvVHfYUslYG2tD71km6qC+wHV+olhhqfq
 qUbuioO08gUeHARxQXf8H3QVeb9WL+ZFoH9PlHvBQBHCO6/8cr7NxgoDKYKDvaN39Fnx
 g2I98VobybUpBhqZlA2xLBvi0QlYfFrGR8PFWgUsldZjbnPFxLOxPxQlkbuaupYiNEMF
 mJYGeFCLyXM8SQGftx/eB2wEzmQs8RbFCLD0B7o/2wqp1M14s3mAJN4TTbcu99VUwH9y
 78cxYFiBIY2Y1ea7nZI3tPiujRD9+Im8dDcUOAjom3TGpwnDvOMhCYxJmMmoASurp5SS
 od/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKXdDphkxx+ibLD79rwy5dc9HCNArOrUvfLkkqO4okxXbvzwR7tCsFQ0E/fon/BvgyIRkViar17i0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+LGNIkZ/jZX6VZ6uFmsQRvmXX6gKw9RnKLMJZHgdreTGiRD5Mh
 VmKbG3LbwHEVhm+5500/2WfvUg7rOrI/3ykP1XYUxR92ALh/k1xXXgfL
X-Gm-Gg: AYBFou1TCNaY1O9T05vEKKsEXrA8j6QxXQur38MmrD3ecWtLeDdLcKgVkyWmvRrKKJ8
 HapOZyLQmBSZeoGLOf1uPXGaOSMz36a5wuouka6Z6s5JDZJv/cgklMie3R6GvU/3FupQv2IAiug
 hjc0/VQgjfZijcbgGH+uYToZfmIHk0MGb2NnTru8P2hxIEcKg+br1pDQp/ObxRIGMBAU2am1wTG
 5eGeaAUxyYk9erivDpzDxscFrnSxDNG/Yq1NVFzfhM2q1XyCjNlKlEz/D2vtDU9ypOxR/0+WiXX
 zm/POeAQEl2U0J43oLVUNIDY1b34hbk/x/ccH++hkXV/gzEvZ6EZpbIq24eWzNCB5y1DRR+GjaB
 5nf+cuQl4zk7slMLkzJvpGO/kMaVmevRibLaSdsl5RPQUFOg+eWTpgNpptqY9tbHeENYlyQBhFS
 N0wRGjHVL9vCYDrSFn3dD6advPeMwqopgzLMoznrK2UfBgNaqg9kcJuCupTHtFK0hIo2AtlPQZ4
 9KLm1BOlyc7vpqnfQaS1MRLFezojPaPDPnaYE3t1ggTYnlcA6a6OvpstlL5eGcBXl+3OynWFRdy
 /bK7Fu4dvZMJhUfuCX2/mg4ALjg73S9HmA==
X-Received: by 2002:a17:90b:4c52:b0:3ab:1481:69e5 with SMTP id
 98e67ed59e1d1-3ae897ccbfdmr15940958a91.11.1793867923599; 
 Thu, 05 Nov 2026 00:38:43 -0800 (PST)
Received: from localhost ([2400:2650:24e0:bf00:cc77:213f:afc3:65e2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31d2b5esm2812294a91.15.2026.11.05.00.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:38:43 -0800 (PST)
Date: Thu, 5 Nov 2026 17:38:41 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: zhi.wang.linux@gmail.com, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Release GGTT MM if scratch page setup fails
Message-ID: <auxAkaQM1Rri52K9@dell-wzy>
References: <20261103065407.1070225-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103065407.1070225-1-vulab@iscas.ac.cn>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 06:54:07AM +0000, Wentao Liang wrote:
> intel_vgpu_init_gtt() creates the GGTT MM before allocating the scratch
> page table tree. If scratch page allocation or DMA mapping fails,
> create_scratch_page_tree() releases its own pages, but the GGTT MM and
> its virtual GGTT and host GGTT buffers remain allocated. The caller
> skips intel_vgpu_clean_gtt() when intel_vgpu_init_gtt() fails.
> 
> Drop the GGTT MM reference and clear its pointer before returning the
> scratch page initialization error.
>
> Fixes: 3b6411c2c205 ("drm/i915/gvt: implement scratch page table tree for shadow PPGTT")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 5056a5887b31..17d61548ec05 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -2403,6 +2403,7 @@ static int create_scratch_page_tree(struct intel_vgpu *vgpu)
>  int intel_vgpu_init_gtt(struct intel_vgpu *vgpu)
>  {
>  	struct intel_vgpu_gtt *gtt = &vgpu->gtt;
> +	int ret;
>  
>  	INIT_RADIX_TREE(&gtt->spt_tree, GFP_KERNEL);
>  
> @@ -2420,7 +2421,13 @@ int intel_vgpu_init_gtt(struct intel_vgpu *vgpu)
>  
>  	INIT_LIST_HEAD(&gtt->ggtt_mm->ggtt_mm.partial_pte_list);
>  
> -	return create_scratch_page_tree(vgpu);
> +	ret = create_scratch_page_tree(vgpu);
> +	if (ret) {
> +		intel_vgpu_destroy_mm(gtt->ggtt_mm);
> +		gtt->ggtt_mm = NULL;
> +	}

Better to just call intel_vgpu_destroy_ggtt_mm(vgpu) which is more
aligned as for ggtt mm handling.

The issue you identified with AI tool might make sense, but pls learn
how to work with kernel community first.

> +
> +	return ret;
>  }
>  
>  void intel_vgpu_destroy_all_ppgtt_mm(struct intel_vgpu *vgpu)
> -- 
> 2.34.1

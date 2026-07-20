Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85ECC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA51910E229;
	Mon, 20 Jul 2026 23:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SnYBUIlS";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2160410E22A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 23:48:06 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso6726551a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784591285; x=1785196085; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RYffH9r38rfAx+3tJsm8+T/9x0KXlih2xMhQUO2e5ek=;
 b=SnYBUIlShw5Vjn+YPyxKfFIv2UI9ircVpyWylQCZZR+WwP1uASy3grMFDTFQvV1IBU
 KEthQx1Z+SauLigD4k2xrJ5GxRLjCk5jtCUA7UQI8Mww3hDQ5smhbrpQdDCVZdUfURbD
 cx3uLQrt1DONfIPa+tCyUuQnYK/8qonBuPqfhk9xiF2AtNPpc6jV532tiMN5vXm8csOt
 jqDnARa+jBDE3/C0d3V6FI6UKi/FrTDWBuDNDjQzM76Iwb43IQtwIaGRYXsF6qGPgfH3
 vQr0KMhYBPIMu1LTeZGbLF/cSiL8151f9KE+edYz33zqOKxsvFB6B3mSMhdy5urWJtPR
 ntbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784591285; x=1785196085;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RYffH9r38rfAx+3tJsm8+T/9x0KXlih2xMhQUO2e5ek=;
 b=gcmuOWZ7tcrQrTAiddBz5JF+YI6Vm0W9eQ89RPoMIFSS1l9+pRDcPR37O8f2slAuG4
 8dqa99o1AyivejehL/h9e0VfKtGBNm/jAAItWl5xMNUROK7sGBKDhqtmLDd9ttiutiWr
 npbtjf5Pph2q4BQxjDIg/nYsaxenlvgCJhkjPmPRGIHlE/Aydjur6KWHocm1uc6LlatO
 Mfoj+rIDErcS7rpNlb9sPGl5Bee13hU3YsWFw0jW/tQ845ravwIB4hzNZ1K19Lfi7thA
 qqUTw1vvZCSAS5FCda5AImrdly+BgksYRexySpl7Iz3PfQj0HKTMa2ddjPamxfNCVKnp
 wsbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSoX0Yz8XTw3Gj5BfcWYz5zTjPsucdJY1VSD9tfUsweMjj6VA6MRtY7fAN3Tzc5wVtYJ5h3Mgh6v8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2/XbsRZ2o1jgqeZ8Py7pG44O3vbgd1oA0JgQJ4bzo0Dd6bXAn
 lVpa2qCObiANXGXZVL30JftlqGrREm0COQinTVkofVm0scFWmr/0jgFI
X-Gm-Gg: AR+sD10xhT94tlBWGvBjLJU41j/0bQ+SNkBP9Puc6DadHBg6tX7wTwuueo0VVRkf7ou
 LM2F6Ej/jkLB1ZODgn4aJL7qDyRJlxKL8M0dSXOkvzv+MPxM+aWumVGgmeL2b+P4n7IxqdMwvE3
 HtrtG9wBqvM5/vAjwEFI6Wu2nEW3Wd5lxDPKpvZdhtKiimUU0EPtsdxxBHXyF0Q2TPiOJMYFeqS
 RUBKsOp+E54UIye4xH+fWKNzMjityd7plu7juMn3O5Vl2UYBQEW1PODQxkc+vp4pcpKQAKXDhP8
 VpiwbK+XJ0oE0grMDyUo1tRr/cHxxO7D3Y26pQ5dErVbayrDyITFyJdxoY0kh5MfUkn4Brl9Aic
 Ddbg/v8wRi13p1W4xPWKRJ0ogmmTJeO6oLdcFrQKInNkhHitvCqV7NwJfj7eSzMknBeTIOniKaC
 2/n7OEsc5EzINe5/BpKJ+XpZ/TcMJNFXWOqR5VciBBYk+t
X-Received: by 2002:a17:90b:2c84:b0:381:3b5d:30f4 with SMTP id
 98e67ed59e1d1-38e4b422c19mr16574158a91.1.1784591285491; 
 Mon, 20 Jul 2026 16:48:05 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e9232c4ccsm439122a91.7.2026.07.20.16.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:48:05 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:48:02 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH] drm/gpusvm: Zero HMM PFNs before scanning ranges
Message-ID: <al6zslgo1Hm-l6oP@skinsburskii>
References: <178406967042.1113483.2116704310277917086.stgit@skinsburskii>
 <al5u+iJi1h6FhKsu@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5u+iJi1h6FhKsu@gsse-cloud1.jf.intel.com>
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

On Mon, Jul 20, 2026 at 11:54:50AM -0700, Matthew Brost wrote:
> On Tue, Jul 14, 2026 at 03:54:32PM -0700, Stanislav Kinsburskii wrote:
> > drm_gpusvm_scan_mm() asks HMM to report the current CPU page-table
> > state without faulting missing entries by leaving default_flags set to
> > zero. The HMM PFN array is still caller-owned input/output state, and
> > the framework may preserve input bits while filling entries. It is not
> > safe for the caller to hand HMM an uninitialized array and then treat
> > entries without HMM_PFN_VALID as an authoritative unpopulated result.
> > 
> > Use kvcalloc() for the temporary PFN array so entries that are not
> > reported as valid start from the documented zero state. This prevents
> > random stack or heap contents from being interpreted as HMM PFN flags or
> > PFN values during the scan.
> > 
> > Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gpusvm.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 1a8bb83bd28d..c8f489d7ff7e 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -859,7 +859,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
> 
> Two other cases in gpusvm would need to be fixed as well:
> 
> - drm_gpusvm_get_pages
> - drm_gpusvm_range_evict
> 

No, these two are fine, as the faulting is done with HMM_PFN_REQ_FAULT,
which either populates all the PFNs or fails.

The only case where PFNs must be zeroed is when the caller wants to
collect the mapped PFNs. In this case, the missing PFNs are simply
ignored by the HMM framework.

Thanks,
Stanislav

> The offending patch is likely the one that added sticky bits to HMM:
> `git format-patch -1 285e871884ff3` for above two cases.
> 
> While I think zeroing here would be the safest approach, it does not appear
> to be a problem in practice because the sticky bits are only used by
> `hmm_dma_map_pfn()` and `hmm_dma_unmap_pfn()`.
> 
> Also, there are several non-gpusvm cases in the kernel that do not zero
> the PFN array either. So I'd say we should either fix the entire kernel
> in one pass, document that pfns must initialized to a known state, or
> leave this code alone.
> 
> Matt
> 
> >  	const struct dev_pagemap *other = NULL;
> >  	int err, i;
> >  
> > -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> > +	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
> >  	if (!pfns)
> >  		return DRM_GPUSVM_SCAN_UNPOPULATED;
> >  
> > 
> > 

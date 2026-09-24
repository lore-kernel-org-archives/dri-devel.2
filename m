Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC3CC98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7E810F625;
	Thu, 24 Sep 2026 14:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ysz5xlv3";
	dkim-atps=neutral
Received: from mail-pj2-f27.google.com (mail-pj2-f27.google.com
 [74.125.227.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E0810F626
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:54:30 +0000 (UTC)
Received: by mail-pj2-f27.google.com with SMTP id
 d9443c01a7336-2d6ff23d81cso651985ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790261670; x=1790866470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mo3TPVdoCkIHw8PshUsF9i8x4gaS6XMSbTsYHmyLH0k=;
 b=Ysz5xlv3QonxbE7tB8RnVzHP1M4/Em6qZGJzxgqXdJfb8VSs3z5Vt6dxQ6q6Q7pSfQ
 o0Uyd/EPwbHpQKP7IS2yd9fvO9gnY9bCxwpMioqreGeF2ri9HUv/LlXryLRWs/QTzBy0
 Yseh3uKI7P0SUWl+/FzamKwmjgzXwWZ1+1cuki7FuNZoyhm3/Y/H5Yq8hQBXAbNrUryE
 Iri+BWuviIpHz0nRtLIKVKr2RAVH4qjWqlECRocARn925HmMpsMEcN9c/lr5j/JcE/4i
 DiyXP3nwYNEgj9BDdNYmZL2mYdNpLxbZ+gsUXy5PHl4vbcSs/EAgStxU2EDsd9/6+imo
 kdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261670; x=1790866470;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mo3TPVdoCkIHw8PshUsF9i8x4gaS6XMSbTsYHmyLH0k=;
 b=nIOwiRFH9OEN+yVHg64hYEow2A+OEaSVmmTZuGKcy6x8HbuHrCNhkd9cwGESBInNC2
 v5l346fIaQ0DejnILjuwSQ7DP+hLAeaSqsH8WvHkXsUr6l+4W/KSD53jwClKV+hCEXE7
 YTGU0NGTDUgPGi1en888+0Iv4Q13yAcpQCrHOOhyPj7cvoXpGJK+oluzcUQ1n61oa65Q
 WUeDEwnPda8DH4j9EfJf5QKoCf9vnAcLQ3Xm3rPNSvybeTrU/XixKXfHcEJKwMdB5C7b
 ULRcDULog8Scz0Ca9SWhaxPk3ZIgmyXSP3jk8HebvaszTHcgIiOyoIg9BvWNT1Q44pAP
 CKZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0ClX86KbT+XR5ODEktQM/nRkxTvWD1dwW21A17Tls7MMTfB7v3AHmXftAXMZamQoOzaH0ufNkpRA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4g+9PCG7MEl97vfw3l+0N5BQ8cjpy38PfaGjKWUHCtWSkc+MP
 /Yg9JIk+92+JCFO/HKSMiyzG+OiRrQEhBJeas/M9H14V+0YeR1TchHbq
X-Gm-Gg: AYBFou3Zlro88tS2oH06rSu44HQrvAGY/bbYOnpS/SYy5BmVpz1oscPIv73RHd7NH43
 gRQfVeh7RhtKmg+CghIO2dFzw6Ad87cJETHJ3MmG7K7nXDdEF03zJGE6apgien7XcyukBGr6Vww
 J3/2Wl/7in/5IZ+u4ZrQ1V4G4bQK9ypWQSXCwWngzpgSppiNab2DFBraF4ZYC3qab0Zz+ulGJ9B
 G/rJBdLGdTw+Nu0B3XCl6rdSYext/9U167hdWROgVaafwiBMqUosT63JWDt0TC0LUtuX3Zzp3SJ
 lJNhyL7aw3VBsZmIlGhjpvPVGpMX12AYyhc7xu6SkkJtvvHqz9O4O/JlYzSrzZK1URotLkK+pYy
 hjyYlaMGQsvjj1gYFNsSmwtHTsMQF3Ak2ZlWQiERiAoBvdVyhT05x5uDyVRZEg/KvZNA9eVDV9G
 w2ThJqG7uHfle4aWUwDPU84Fm0pQTSSRCyDCeM5DVZnSXgIKPV6PyBIVpnZ/ZfPieaqe2KXHmZz
 W75hpHVo7cfeQ==
X-Received: by 2002:a17:902:e542:b0:2d6:3c1a:85ef with SMTP id
 d9443c01a7336-2df7dfc93c6mr35028765ad.4.1790261669688; 
 Thu, 24 Sep 2026 07:54:29 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c3a3dsm28629285ad.43.2026.09.24.07.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:54:29 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod.linux@nxsw.ie>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] dma-buf: keep DMABUF_DEBUG off by default
Date: Thu, 24 Sep 2026 22:54:18 +0800
Message-ID: <20260924145419.47354-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CACSVV01NZROH9U5Qjd1TSDu+BPyyPLC9pFByqSfrxXrPJV+wZQ@mail.gmail.com>
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
 <fe3a4297-f300-451d-9763-0b3016706111@amd.com>
 <CACSVV01NZROH9U5Qjd1TSDu+BPyyPLC9pFByqSfrxXrPJV+wZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Rob,

On Thu, Sep 24, 2026 at 7:01 AM Rob Clark wrote:
> So the assessment of what is going wrong looks pretty wrong..  VM_BIND
> should never lead to iommu_map_sgtable() (which is never used for gpu
> per-process pgtables), for example.. but is used for mapping for
> scanout.  And pages are never used for mapping in either path.
>
> However there are a few places where sg->length is used (in iommu code
> and msm).. AFAICT dma_buf_wrap_sg_table() zeroing out sg->length is
> what the actual problem here is, rather than any use of struct page.

Thanks for the correction - you're right, I mis-traced the GPU path.
The per-process pgtable mapping goes through
msm_iommu_pagetable_map(), which walks the sg_table with sg->length
and sg_phys(). With the wrapper zeroing sg->length it iterates the
entries, maps nothing at all and still returns 0 - which explains
the UCHE translation faults without any error anywhere, and is a
nastier failure mode than the async-bind-failure story I wrote in
the commit log.

With that corrected picture, DMABUF_DEBUG=y breaks msm in the map
paths themselves: msm_iommu_pagetable_map() for the GPU and
iommu_map_sg() for scanout both consume sg->length, and
dma_buf_wrap_sg_table() zeroes it, so every mapping of a
page-stripped sg_table silently maps nothing. On top of that msm
also uses sg_phys() in those paths and
drm_prime_sg_to_page_array() for the page array, so even with
sg->length preserved, page-less entries would map garbage
physical addresses instead of failing loudly.

So it looks like this needs work on both sides:

 - dma-buf: preserve sg->length in the debug wrapper, so
   sg->length consumers at least fail loudly instead of silently
   mapping nothing. I think that is what both Christian's "we
   should probably change that" and your "zeroing out sg->length
   is what the actual problem is" are pointing at.

 - msm: stop consuming struct page and sg->length of imported
   sg_tables, i.e. build the GPU and scanout mappings from the DMA
   addresses, plus the drm_prime_sg_to_page_array() cleanup.

Is that the right split, and is there a preferred direction for
the msm side?

> (And yeah, I should get rid of use of drm_prime_sg_to_page_array()..
> but that cleanup that I haven't found time for shouldn't be the
> problem here.)

Agreed on it not being what produced the faults - but it is part
of the same contract problem, see below.

Also answering Bryan's review of patch 2, which is in a different
branch of this thread:

On Thu, Sep 24, 2026 at 10:36 AM Bryan O'Donoghue wrote:
> Why is the fix Adreno specific ?
>
> Shouldn't this function be ammended with
>
>  > +    if (filled != npages)
>
> instead ?

It isn't meant to be - msm_gem_import() is the shared GPU/DPU
import path. And putting the fill-count check into
drm_prime_sg_to_page_array() itself would indeed be the better
generic version of that guard; I checked the other callers
(etnaviv, omapdrm, vmwgfx, xen) and none of them expects a
partial fill either. But with the corrected analysis above, the
page array isn't what produced the GPU faults, so neither variant
is a real fix. I'm not asking for either patch to be merged - the
series is a bug report with code attached, sent to get exactly
this discussion going, which is also why it carries the RFC
prefix.

> This very much looks like an LLM generated patch - the commit log, the
> large comment in the code and TBH the solution too.

Sorry about that - the patches were drafted with LLM assistance
and I should have declared that up front. Any later version will
carry a proper declaration.

Thanks all!
Jianfeng

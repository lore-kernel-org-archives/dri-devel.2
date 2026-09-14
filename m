Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B372C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331C710E762;
	Mon, 14 Sep 2026 23:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cUJlYs0S";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A91210E762
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:23:58 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cda5e048fso9325e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789428236; cv=none;
 d=google.com; s=arc-20260327;
 b=fjAUFZZTjjqCl5IrI8aRwOcXMBl6zMgVOTNTK/eByqgqmNXmIezEK+Bg5gwcQyye3u
 Fc8gBP8rLL9ecZVJP9j8LiDjgce1iT06NGeUJZ/mrt+I+WqmyXS78XRSiUlG93XAvfcM
 EjpVSGJyUwrYEnk0opeCmAya3qAmey3VDUOREhLDv7YcoB/uzy2/E9c24Y37ZPt7Z9sa
 XdyxvWUe9oPJb1xwHJnRFRJ45Qt2Cnz5zBJHs4M4W4nO3JmF8q7VLCY5wcboYlpN+bTJ
 xoLLIx6vtlM1cqgtrxOQhQrArwc6p8xb61pYnBaQX6yl2tbT6WzUqRNIKgqk/0sR7+G/
 Cwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7bCiBaA1KLPmBbIRbTd/usVfbjDAGvg/fHxPmUuwfOk=;
 fh=OwDJCfa9PdTVLUjQaizLlPx/i9YkKgA6AVTRNsr9jvE=;
 b=Q3/ZzU4XFDv38tump1Maxyl5MRFd0BeP9pxGT1l5wFMmq4sFtJk5JPgYqAW01xwdeV
 LPyN0lAKRnn7O8XjLBu999qQBYYOY5zUyzFE/o/og8IE1RwGMOiBdMggfP/BJELjGY12
 uw3PQXMPpjyeIxQ/Qap97qn2GOBwCSgRyZ5VdKhU1y9ur1oXtSDVREL5cjBBERHC6tJN
 1SZthT32DrYI950Y+6amRZIO0OCQ2FmXL2nSSSFVCDEhpWUiw8ItIA39G3mWxWmU/Ke3
 j5rL9TWVmqrYb5cSfdBNyM5tXD5I4wJZpd9HMctTLb6CqvBPTLddLoXMvYWyzosSKAyQ
 uuiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789428236; x=1790033036;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7bCiBaA1KLPmBbIRbTd/usVfbjDAGvg/fHxPmUuwfOk=;
 b=cUJlYs0Sji5fY7gpw+Slw4sToM24KQS0YE52s0RpqaUsqisr+BYCRLHfJbS0ZoR9nY
 ROxbZ/CAdncCpyqw3/lwnLF/ALPVl6meIv1XNtj1PVzeA7bRT/Kl2PFw6jNTU+eXptvP
 z5q5q9ge0gFiATn5zkL+FiW2fburEbnpMK4AWOQLziJu0VXV2w80hl1/nNuAnD2zoJW+
 JbC6fzlt2M5mg8naSZHBPH5hEDgAw4KnxeVCuB/JxerAvQdfrXGFv+vCpSPXksOA+EBY
 rVEFzIlbVgR1HRmcgDbHeky28Lxw+qVRAfNoCEENojr5opW5YvX2KV1bHYU+sP4l5bZe
 yDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789428236; x=1790033036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7bCiBaA1KLPmBbIRbTd/usVfbjDAGvg/fHxPmUuwfOk=;
 b=stXpX490dRMxPpOYxTVhEjZEvyiObI84WsTN9xRb2wTKGad0u47qPNM4uvg2lAedt+
 h0qF2p37AdJlidQYexYgkoY4vPWMyBnQB5KweJsew4KBuv0bDryy4faV4rvq2e/nlLq1
 UDhJgDoyB0TcGqgmIoeRQum2SOgVR2ocnOROsprjeRAwVdY6GrFEMmgCbW37BDzpWfzO
 pwwmBVxhiijVbkWSnaJsv1bmvC/KMtWnMsry33ie8q+011WHKMbR40m+tEwv/04k/Sny
 Mc9i98dKZBj5OTN3Fgab0HpygVCi4LQ1ZHA9zSkniwOFTcwUpbgQVK48NMHRjmZaMv09
 t/hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjvYBBJ4prd6WOOKS437BU4MyUKQdS+Iqt/16MDm538W3X63gp1UqXMWn7cDSbXrtmQRJu07aN+ZY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++krO/XSSE4JLaRYUWrYgGxwWrIJYUuhGmE5AG5VRrtyhHrvl4Ze
 UtxITmpzI9DjmGdys971A3Oic/1PEKJUneTAKKzrRuwph23hMK5rSx4V7Od7GU+q6vXCjVJ4HP0
 Lo5W51zGFnXjJAxHTNipeCspQKNqay0kkPYvZLuqV
X-Gm-Gg: AYBFou2qpnW/0f3ZjHqpgl+tLHwqBdYMv2N5qvr1Q0+DIAy5bzLjiQbBTfu/Fxj/cJN
 uueKE8pvGpX8yqloxBVMfUvZEmhU9WoeYK0Ah0zCOChQQjtgUKf9f+90Ef+u5ZItb9xVppnp+y+
 iIxsZVXu7lrimltMJio0BEeISz4154E+FBjQP+FmCJ3hvI+ETvnoA5WK4Af1YaOL1IUqeFZuUZ1
 dcdlg9tm4O/DIvMZENycMolQwPPez4qvTV1XpDYBBZ5UvV2nuYoURPp+TnvjpAf8aNuzQIu+bzK
 a+MbhIZJ61oTRqitJZdiKPhMtZVhudGBHHUA1qoSdntvX2fuAy+FaYKxzdeRRy9dbxHAu0eiDLz
 Lf2IzJD4jQA==
X-Received: by 2002:a05:600c:28d:b0:49e:7981:4294 with SMTP id
 5b1f17b1804b1-49e7f0a75f7mr109195e9.5.1789428235941; Mon, 14 Sep 2026
 16:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
In-Reply-To: <20260914212258.2657788-2-dave@stgolabs.net>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 14 Sep 2026 16:23:44 -0700
X-Gm-Features: AcwNN1WtjBrQlHaHMrN5leZ63LaTP-D5FEN0Ol0qz2UAQhJrFSDnK-hyD_rAvN4
Message-ID: <CABdmKX3Oum+wJPy2JUZKoke85L-E5VJKu1VJs-sy+LLbhe2LMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
 benjamin.gaignard@collabora.com, jstultz@google.com, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 14, 2026 at 2:23=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
> and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi v2
> page-table formats, and Arm SMMU's 64-bit long-descriptor format with
> a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
> mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB leaf
> entries unless it can be combined with adjacent chunks into a
> suitably aligned larger mapping.
>
> Adding a 2MB allocation order provides naturally aligned, physically
> contiguous chunks matching the 2MB leaf size, without relying on this
> being accidental for separate smaller allocations. The new cost
> is one failed order-9 attempt (keeping current large allocation semantics=
)
> per buffer when 2MB pages are exhausted.
>
> Two benchmarks, measured on an AMD EPYC 7313P.
>
> (i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
> measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
> (amd_iommu=3Dv2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks,
> only one of whose 2MB windows was superpage-mappable in that run, to
> 512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
> decrease by ~16x on average with ~32x for the worst cases. Unmapping
> that buffer drops from ~500 us to 1.25 us.
>
> (ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+close
> across various thread counts decreases by factors of ~3-7x alleviating
> allocator's zone->lock contention by being PMD order and therefore is
> pcpu list eligible. Once the buffer size is large enough then the cost
> of the zeroing takes over.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index c8959eadc71d..621cf238ef97 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -55,14 +55,15 @@ struct dma_heap_attachment {
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
> -static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDE=
R_GFP};
> +static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> +                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
>  /*
> - * The selection of the orders used for allocation (1MB, 64K, 4K) is des=
igned
> - * to match with the sizes often found in IOMMUs. Using order 4 pages in=
stead
> - * of order 0 pages can significantly improve the performance of many IO=
MMUs
> - * by reducing TLB pressure and time spent updating page tables.
> + * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K) i=
s
> + * designed to match with the sizes often found in IOMMUs.

and now also PMD order for allocation / page table efficiency in
addition to sizes IOMMUs can coalesce

>  Using larger order
> + * pages instead of order 0 pages can significantly improve the performa=
nce of
> + * many IOMMUs by reducing TLB pressure and time spent updating page tab=
les.
>   */
> -static const unsigned int orders[] =3D {8, 4, 0};
> +static const unsigned int orders[] =3D {9, 8, 4, 0};
>  #define NUM_ORDERS ARRAY_SIZE(orders)
>
>  static int system_heap_set_page_decrypted(struct page *page)
> --
> 2.39.5
>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

The origin of these orders is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/staging/android/ion/ion_system_heap.c?id=3Dbd5d6bdae118c49d194869ef7=
57fd650dcabd33e
with not a lot of justification in the commit message.

Downstream we attempt order 9 instead of 8 on heaps that we actually
ship on our devices to match the 2MB PMD size, and many other vendor
heap implementations do as well. Not that it's always likely we'll get
pages that big due to fragmentation.

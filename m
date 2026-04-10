Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1475F44847
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D1F10E94C;
	Fri, 10 Apr 2026 12:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SOe2CktB";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75AF410E94C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 12:14:56 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b9c01854477so326545266b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 05:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775823295; cv=none;
 d=google.com; s=arc-20240605;
 b=PbpxMWBY56o8Q6nXq6swAM275ukfBgpao1ZgOEqEEee2ImTgfUEP/sQio0/tWZh+aP
 KCxG45VpAtZD8Ix4rsx796Xk7d+o1mw2LNu23DPYtRsDmHWcd+AB7ru25mVfNpS1JDCR
 /abOyaQKRS6MKSWkIUE7c3i8PliB8de+o+IQIpCXJ1RHXpdP3k0UFlg1a3kwL2cAtw1G
 IFmFvPAksl6tup9me3CngEE6/gAqWh3CY6UnsvnHz1n1DYsKeNrimg2H3+Fn0jnDqav9
 +qzuPJ0LJ4Jx0ZvECS0oFJhVOMeRZ6VbMnmGX2zk1kxkneznFuY+ZEIQXSfnU+CQva+q
 8t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7jIY/1++oar4yAYBTP2iQ0v5rOvIuL4pDsKGubLCfjE=;
 fh=ioLfB5N+X19CvxVNPtHa4TghNgdJpnAo/xqtf11j6zs=;
 b=HAs6hn57FJUJaT04NXgpn3n0dthM1uCVG8ktlAgiS6D6+IkCa7FspR/tbGpeYVSKFH
 om5FwZ52FZWFP/ITNv9PlXhvYeOra4kZQxzYBuCO9btGA/e3eUFoE51Oq7o+ptSGA3k6
 Jlm3DNj4SLNBbx8VagNn4H8C4cZC7PsTW9u+MwbE5yOkv92QHXpV2j5oYHLEle32aOiT
 80Jyn/pMLxY+qx4QWw613bsHHX/n+1JXL4fT0Gv249KzhxDPbUFgtDVBQxRptF4WnmaC
 nlf3nYZPB15Gei0r6l8sfkP5Qu1K7oHLweoWRDjnr1/OXhA6Q/BkLdHLcEHvpw5befkk
 vZjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775823295; x=1776428095; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7jIY/1++oar4yAYBTP2iQ0v5rOvIuL4pDsKGubLCfjE=;
 b=SOe2CktBMvJLD21PW/yRp+LOzuGIBE378BiiEgTrQBV0gtmPS3eCIC58fB+vFvF6jW
 kmU6Q+dJ57y9ZIv4YJYlqUM8809+kE7/6zsh+FXOLcDmSH6PmVbbJeeUfyNCdxP4dXg2
 iCk2tS4YyHqHV9g3Qanwtlrqmrbyj0ALs/9j+iFNEsQIT9JHffQqf1WOObnBYL/yGExh
 ut+FH+DF1X3UiTG8bJ/VanbZ1HRgkPPd0+HzueWSuwqCVGnlZsYX3uLfkHV68XZS+U1V
 xlWRXuC1rUnrx5Cu5TqBxkthd2mr2XoYLMMdJj9iGGu273Idfo+fCfp+EFxTWOFrahye
 aC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775823295; x=1776428095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jIY/1++oar4yAYBTP2iQ0v5rOvIuL4pDsKGubLCfjE=;
 b=F5ecxsU9AHKnhlhOPPd8lFJ8xesw2sjX0vPIy8EJojBaO4kV56aB9Fcsq0nEY2Lbkj
 tI23BXv4AKDFPu5uu7bdGoHzAsNix8JcvGqWx9YYkHrANHLAyAKXobIT/9bMW8NQzx9g
 HKMbZWOpFNV0r1njG7oEBVJynX/WuvTbiBS0UxXqIs3/8fSsO1I0gt91wQw3FqY+bA9+
 Pf0WmiH8o4wG1Dxb+ypzJGtyLaxjjefNgShVZDGX9JRs97dFN87pXAnv5XeFwKQf9jcN
 diO3iOtCZWThCcT5ECB91itwd1GyCn+9BVN2hLy/m5nelaHGKxSwV344V2w6SufiPPdJ
 k50w==
X-Gm-Message-State: AOJu0YylmJXfyRw27zx7k07ShBPw8hGSw7M9+iehLvxDD+oyHKvofNiW
 aEFjCtHqIjgZL6dgQ3tGq/yGP5J5U8P0TQEqk4PixmSQ1qB0C1PfW14+xuwcTkRxt2Mv/QMtoRy
 LFO3C1boBwpyYl+W3x7xvsUE01TNqbJoH707xAGYwKQ==
X-Gm-Gg: AeBDiesV8mNU/309MxctzbZkj7LvUlC7RATQP0rF7EqwpESqIvZO2Krh66oCirfe9G5
 Agm7npbEKkO4c9KDlhPBlYYH33a8snatmpUklbGOESlF4DjGdJBSPeIKVKcf+6oAze9xQe2OhFz
 Z5AvKuAbkoajzISFzX0E1G2og9RDSGdH9mibgiFnbTkoylxikDXXXRAl4/1UXtra4uWTXWLShip
 +9FiNNoh4MDz4daatQEDrzpcr57nuTs2ULBT+ZKYs7yHx1B6v6wcJ/X9ZRxpIu4O6gSn8yMB1Ir
 kCxo9yg9apjcqrd/U5QtkkhTsnDBg6CtXzke5lo=
X-Received: by 2002:a17:907:e102:b0:b83:95c8:15d0 with SMTP id
 a640c23a62f3a-b9d7279bb78mr130310166b.52.1775823294707; Fri, 10 Apr 2026
 05:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260407092617.635223-1-jiri@resnulli.us>
In-Reply-To: <20260407092617.635223-1-jiri@resnulli.us>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Fri, 10 Apr 2026 17:44:43 +0530
X-Gm-Features: AQROBzADFveULcyZjtNgjI9rBi4aeeX0JzC3AEXYi9kt8DQW2Z9q1-iXZwCoelw
Message-ID: <CAO_48GFt21rv0PJd2Csa0O4OEpN053_p__4Zux+m7jQdHSagEg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: heaps: system: document system_cc_shared heap
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
 robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
 linux-coco@lists.linux.dev
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

Hello Jiri,

On Tue, 7 Apr 2026 at 14:56, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Document the system_cc_shared dma-buf heap that was introduced
> recently. Describe its purpose, availability conditions and
> relation to confidential computing VMs.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: T.J.Mercier <tjmercier@google.com>

Thank you for the patch!

Marek: Since you're taking the dependent patches through your tree,
could you please use:
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

and take this as well?

Thanks and Best regards,
Sumit.
> ---
>  Documentation/userspace-api/dma-buf-heaps.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
> index 05445c83b79a..f56b743cdb36 100644
> --- a/Documentation/userspace-api/dma-buf-heaps.rst
> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
> @@ -16,6 +16,13 @@ following heaps:
>
>   - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
>
> + - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
> +   buffers using shared (decrypted) memory. It is only present on
> +   confidential computing (CoCo) VMs where memory encryption is active
> +   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
> +   bit cleared, making them accessible for device DMA without TDISP
> +   support. On non-CoCo VM configurations, this heap is not registered.
> +
>   - The ``default_cma_region`` heap allocates physically contiguous,
>     cacheable, buffers. Only present if a CMA region is present. Such a
>     region is usually created either through the kernel commandline
> --
> 2.51.1
>

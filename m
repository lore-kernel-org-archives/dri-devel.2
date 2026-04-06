Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4316FB5165
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 20:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BE010E02C;
	Mon,  6 Apr 2026 20:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UCtvk8uJ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BD810E02C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 20:20:47 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488879dcbc3so210075e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 13:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775506846; cv=none;
 d=google.com; s=arc-20240605;
 b=WBsCnDi4YHtI6YTcECmU+reBs01goJdNxm+kVKOjwp4oSFkvqhck/jJckZ07/Nw3Vs
 AEsrSyCLP3R1SuS/rC57fx0JwtAQIyoSfRSxuVI2960COHks0AhI2cHuGPHG2xOjJV0T
 cNIPnpNW8kmDhupzX2Njy3KKK7x+8J436Knd4uGhhgVExhNkjIf3+c8szx5Z8wnhAMvZ
 chi/JFB5uecf9uxOOk7cRj2tE+g6zaOVxtUh94A5nPjz/M9ubSPFb5HwdfIVhhGBbf2c
 FwohXoqlyE9pYYECj86s7QiYGJUi9Cg2oFnWUcI/xq4pcjcbDWMalCLsszOqQWX5QKYn
 ug9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DAq+hiOQoaI832cP+7lQvu5renHjvWZOnK9BIt/n8bg=;
 fh=sPkvoiVW1RBgQUxYl4/XdROFjqxLmkR3wF8LHkDYD0M=;
 b=S6nEw+09jwxZaHbjJ9sN/As9/NwkSyOJfZmpE1UR5B2TArnUgzs6xItagvsHdR3CMj
 ALwPuZMyPYJy5giOiypHPKU0T2Yne4elCLHxAoyb5RuLWO2L07BAIe3OioCdVp1HUte/
 OFtE30G+xauxfA6fbz6xOgn/71LMtZZ+auqse2TUapgkkn0LQjp+BJDQaOp1VnGfm6su
 uX2EZTOjuAf1F8j99Mu2UKq/zVRTc952YNUCEW9uAc84Ov//kX7mY3TBT6iqPGtsAkEr
 rrMvvpjeo2cVB/f7I0JNhMl/pk4zcZaoHZYfodu1mlp6WZ6ky5Ui96IZC1megz074UGc
 WhFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775506846; x=1776111646;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAq+hiOQoaI832cP+7lQvu5renHjvWZOnK9BIt/n8bg=;
 b=UCtvk8uJibfzsuXbdUzFgjZ4KpmLxizs+vhI4l/mJ6XE5gYo/g7e10V4nhbZaCL8xl
 u2VGFPipnUJMmeTZMajR0coV5MalX2M69uXejB1+NHNBK534oD/Y+sS/8V4FI/hQ11DT
 DPdRgEvaPfml6cNg5o/vmqnqVrPecwLxNGB7cB8WkvCvPTkiKM/D2IrAMPxiMTmyu6HK
 1cOIdFOWKElsf1dSa5XVCQlC7zxFU89VlD0M5X49HXyr9rcYLSh28RbcTjcFKnzQAWom
 S8qGYw2aLVv7GgJS81wirKnxN2J+d72ygVl8YbT1HV5Tm9XbjIx/7H64TsjnyHY17smr
 idQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775506846; x=1776111646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DAq+hiOQoaI832cP+7lQvu5renHjvWZOnK9BIt/n8bg=;
 b=Oy5JHjLQDLMWsDb450FhfSp5WtOo4W/oKwpwDKpQ+uzOWsXwX6L7OG87ffltWdcCX8
 hyaTCHMIMUsHSQau+uj14rydSNgWbygyIXe2un3gj+NA/Ll6/JEQTMvwcEOObycCmYO0
 CJktr0tbhpYUET5JpgC2Bdf4PKrsQ3K6TFhMynDmtSeKPVz1BONj60BhNVIAsgY4oXKF
 /3jNJxFEMN8VakNxTGeStGOvZQtCal+jtwz9KdoJpmki+Iu2wQ0+m7R+K9BTcJSYxsCz
 2Hs8c+qg2ndM4AdG4fAOxp91UMGR4t0524R2842OSavG6cPkFqf1JhEG793tID3jZj67
 e2Rw==
X-Gm-Message-State: AOJu0YzIH9M9Fi7GXKiyW1ELM2SOeEuYPtuXUElejVe7SL8wVrzJU20U
 jUmDFaf+TG67lSJss+sPnUA3k9S4S0378hBhXugGYWRCXjpvOa0INhZpmHpBRMRGkfRjGNA7uw2
 u2hDBNAHnYmPfrVowzpHX455Woqd7zHS6ezsQcZC2
X-Gm-Gg: AeBDieuSao8yQ+HM/rCXVxmgz7SIysxaDFnOI7KIViIKmwe3MwB5WuhKDmx15pXYxdz
 Y+12tmSmuaUT3MEUTKq5jxrBcb38CSHHoUIEOSxsvWW6TwvTfYIhVtoqlvh8G+UfVNaSnAnru92
 aoKJdlYxtQwreoEGBUacDi/i37WIIROEvez80NALMsGtNDZuVDnUPZv1v2BB4Tml7zyT70/4PSi
 LVSubZEp8E1PpSbGHbE5ybMmhoVDjgiZA3Y67USslSgwCEk4/WNxuMoyHc1VdajdreOdeAPeDrV
 sCc43rk3uHzKP5d8fRORAkaxTxT17TXTHxTu7g==
X-Received: by 2002:a05:600c:6b19:b0:477:86fd:fb47 with SMTP id
 5b1f17b1804b1-4889a458061mr2963095e9.8.1775506845674; Mon, 06 Apr 2026
 13:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260402141103.598495-1-jiri@resnulli.us>
In-Reply-To: <20260402141103.598495-1-jiri@resnulli.us>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 Apr 2026 13:20:33 -0700
X-Gm-Features: AQROBzBphM-pvVrX6rS78TlEjxwdox4kg-mNa-24N1cUfIDHIUevXFcYB-smPLY
Message-ID: <CABdmKX3N70j8ZZs5DNhx6fhRi=Aa_+2xY1JHcW+uDoaV2+Sngw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: system: document system_cc_shared heap
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
 jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
 linux-coco@lists.linux.dev
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

On Thu, Apr 2, 2026 at 7:11=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Document the system_cc_shared dma-buf heap that was introduced
> recently. Describe its purpose, availability conditions and
> relation to confidential computing VMs.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  Documentation/userspace-api/dma-buf-heaps.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentatio=
n/userspace-api/dma-buf-heaps.rst
> index 05445c83b79a..591732393e7d 100644
> --- a/Documentation/userspace-api/dma-buf-heaps.rst
> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
> @@ -16,6 +16,14 @@ following heaps:
>
>   - The ``system`` heap allocates virtually contiguous, cacheable, buffer=
s.
>
> + - The ``system_cc_shared`` heap allocates virtually contiguous, cacheab=
le,
> +   buffers using shared (decrypted) memory. It is only present on
> +   confidential computing (CoCo) VMs where memory encryption is active
> +   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
> +   bit cleared, making them accessible for device DMA without TDISP
> +   support. On non-CoCo VMs configurations, this heap is

"non-CoCo VM configurations"

> +   not registered.

Doesn't seem like you need to wrap this line.

with that: Reviewed-by: T.J.Mercier <tjmercier@google.com>

> +
>   - The ``default_cma_region`` heap allocates physically contiguous,
>     cacheable, buffers. Only present if a CMA region is present. Such a
>     region is usually created either through the kernel commandline

Each paragraph starting with '-' confused me for a second there. Those
aren't part of the diff. :)

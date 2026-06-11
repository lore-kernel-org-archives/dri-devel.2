Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC5FCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD9310E755;
	Thu, 11 Jun 2026 10:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ixBA0sdi";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9080910E755
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:21:34 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso4293307f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781173293; x=1781778093;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
 b=ixBA0sdipl92qVng/6IIQzZzM3rCl0CcDVj8D6MSfD+qYuSGAIGhaXzM/WNB/j2FZc
 l8ZSKgZiDj5MdmieF8Sv6uAII3jodeeV23RIg3kGEyAgXx5iGLnuMppIF9+izPXNCWu2
 sP6MyY/snIgGV43+4u8I8QiQIR5p+/Axgok1qyZSxOo3rQvVWjla+peTV2kdVfnBGgid
 VnhGGzNw7XB7DfOrKo1a4qQ/K4PSHildLteUgnusux5pt3BAV8CLLbVLOU7eTbTq9BiN
 6z8W9doZ1Dxr9z0aef4ZENVBpEPgQPsFLgQWb8nNBpJ+Yu2F7QQbsXQyPB6ufcWjnDC3
 Y30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173293; x=1781778093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
 b=iCEBCb334EM1h0HN12M4BaywlCYjGhwoHc4TcgUrq9i76cVBxlDfZUEu6tXsLnYg7o
 57JSpt12ytdc5wnbuacWpq+/TRGI9AmisrzcJV2QskyOJYeHcb6SuBbSQzvP2BzWxKS0
 WkOBZwcjMwjj7DBKSMj1Ccss2C3xvQRqs8hisKlEC6FF+5VmIoWrHxzez3lmzDfPHkYj
 ls10ei/rzd0DUm6ZPCR/7sExP821WcV4KZHBh7vz1MOv+5NkUY9rVhfZiwYESJ4ags4j
 rLEMQjIT0SQ04jVcZmSPzcIGOan0eRDokKm5tM4qIvIhenXpPw605KaaKTW89TvI1vTm
 Y23g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5LPhlYzDmaCidIxwPZMGGM9qJRhxRaAe1s3JFi099p92SRKBdY8CmIpZKfZieUkjah/YcJhsX6F0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTlPItPW2hIYX4Mzji+jgXN1G++vpootapeGjV2iBEoC6g38qk
 C7vuVAHzX9CODqQ21huMtM09uPjbWhGqChCy13OZlBPo81S4Y6vvvU7CLCBWNCDNBN0=
X-Gm-Gg: Acq92OEX3DDJwb8xANrhOenk3k9u6W3jd8h0g/KnbRPQz4ZdCdjkzjFj65fPCNQwjyw
 FbYxq83K2lnzRCaCKtfeVSDQQxZ8Mep0LsyuD3zD3Tux0zTF/WPb62v1VILOX9N/CqzKytakrPz
 kGAurd+kdE8ZPVXS/EyNE3q6xqzFg+ezuO2q+5Nzn0IsvXL39OYHbLQWjK25GyZUqR0sEPqN5lS
 Lc+/uFmhHr0VMoKOqRJfbDSF5Okt7bOKfJGm2JC8/1g4QfIBalUNU3UwKjv9ZKdIP+9m3DaMxXU
 uIfC/aR/ExJgAopAg7mZoyDpXm28Ft8icbfDDzma8+XUhpy637csYtUk8toAbpREDj+4tcBdNxe
 5l4jnNBjTMdlNAjvo70YJTWeooCZu+T7XpLVSGBe8CofayeWUvucLnsfwIhHwDuuXw7bHCjGLSI
 NPNbfrQzMkUlwfWWE6/8e0W1eR93SgKKkAzu1xdw==
X-Received: by 2002:a05:6000:1449:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-460677c149emr3057787f8f.37.1781173293060; 
 Thu, 11 Jun 2026 03:21:33 -0700 (PDT)
Received: from localhost ([140.209.217.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda3651sm68603644f8f.32.2026.06.11.03.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:21:32 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:21:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, hch@infradead.org, 
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 linuxppc-dev@lists.ozlabs.org, lkp@intel.com, agordeev@linux.ibm.com, 
 gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, djbw@kernel.org, 
 thomas.lendacky@amd.com, x86@kernel.org, arnd@linaro.org,
 benjamin.gaignard@collabora.com, 
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 mripard@kernel.org, 
 afd@ti.com, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
Message-ID: <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
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

Wed, Jun 10, 2026 at 04:23:29PM +0200, sumit.semwal@linaro.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>While system heap and system_cc_shared heap share a lot of code
>and hence the same source file, their users have different needs.
>
>system heap users need it to be a loadable module, while
>system_cc_shared heap users don't.
>
>Building as a loadable module breaks system_cc_shared heap on
>powerpc and s390 due to un-exported set_memory_encrypted /
>set_memory_decrypted functions.
>
>Fix these by reorganising code to put the system_cc_shared heap
>under a new Kconfig symbol, which allows either building both
>into the kernel, or leave encryption up to the consumers of the
>system heap.
>
>Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>---
> drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
> drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
> 2 files changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
>index e273fb18feca..a39decdcf067 100644
>--- a/drivers/dma-buf/heaps/Kconfig
>+++ b/drivers/dma-buf/heaps/Kconfig
>@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
> 	  Choose this option to enable the system dmabuf heap. The system heap
> 	  is backed by pages from the buddy allocator. If in doubt, say Y.
> 
>+config DMABUF_HEAPS_CC_SYSTEM

Nit: "DMABUF_HEAPS_SYSTEM_CC_SHARED" to be consistent with the heap
name?

With or without it:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>


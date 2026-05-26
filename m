Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F977CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 17:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00B810E534;
	Tue, 26 May 2026 17:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="tW5IIKmX";
	dkim-atps=neutral
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CCA10E73F
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 17:33:54 +0000 (UTC)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2bc763c7256so234873545ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779816833; x=1780421633;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hcUFNVo2Sgdj71izYX2y2jUTakglUwC/840c4cOGT0g=;
 b=tW5IIKmXg/VjQcz+9VU9lXCl80IIlkjc+zFHXB+CqvHLl3VQ2M0v3yFEnFzwVCmiMG
 CddsY8v5setXAIFtMpdaatovvmF6Cwg1GArdQn69Zjq6DfqREhXXODkcdWM2+3hCQaVe
 /0J81Tt00N5fA/grcNmIL6v6TkuEJKTNdZrYAAsrU1xW1g0PCF2+pjHuXJXgyAtNykoJ
 wQDCYXxC4jGAl8DxxW0raA+mGEyb7vcaE3jWH4OpSvxMP1Ya5alk4VwzUcg7wOW2HLYt
 j9uQzEq7671vbcmclHJkk/rIv6CPzGXyxiH8jS4vbbAVtzxNCPqWTFWqzSNuLcgY1+FZ
 jXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779816833; x=1780421633;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hcUFNVo2Sgdj71izYX2y2jUTakglUwC/840c4cOGT0g=;
 b=okx466NUPe+KSjv8zlhn8wBXKEUhB6pnT5ugNK8e+60GQLBqXzBDps30gRP/Cy40l8
 XgMcG2Ju2OlAYuMMrayxXcYaaWFZUEiwgknssmr6WhHhaHKqu4HtOZAHpzzhyNpy3Mfz
 w6it5akh+rXHaQrc8aSqo2sUGg+z7A5t83ZKYq7rbN82+hCXvoXYH2Ib2AYhXLHJtGp8
 a7c2zYyH3K448U1GprVYhlx4inFnETdxSZpWsg0gZu6BUT+3NmuCG5Ew1Mku2KlGdPWT
 wAQnmGM0Im4fPsLBnYFxC/1Sndf7Mg0ETyilRZAC26mBn8LcFUaKdnT7N0GGWnMoi6xx
 VxVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ98vT6vYUVwVnyuXeUxg07q3a17zo1mHy/p6pniXxnu7opRNQ6Me/nG5EK7azxrnZwlaWN4OV8eNzY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU1Oj5nMyg17R7rKNDEw3Jxd3lia4kTSL8JVLmVPdzKBbMcwd8
 h9hjvKjZreYV++W7jNb9QyMZ9wN9jgQ290ncU574nQ/w/9+ie+bYptD2FBzgjp8SLGYuLkfAhdm
 pIQ==
X-Received: from pgbfe22.prod.google.com
 ([2002:a05:6a02:2896:b0:c82:798f:6276])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3947:b0:398:d6a9:fc9
 with SMTP id adf61e73a8af0-3b328cb9cffmr19853341637.5.1779816833191; Tue, 26
 May 2026 10:33:53 -0700 (PDT)
Date: Tue, 26 May 2026 17:33:50 +0000
In-Reply-To: <20260511214243.349487-1-xuehaohu@google.com>
Mime-Version: 1.0
References: <20260511214243.349487-1-xuehaohu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526173350.2359263-1-praan@google.com>
Subject: Re: [PATCH] dma-buf: Fix silent overflow for phys vec to sgt
From: Pranjal Shrivastava <praan@google.com>
To: xuehaohu@google.com
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, kevin.tian@intel.com, 
 ankita@nvidia.com, jgg@ziepe.ca, alex@shazbot.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 jmoroni@google.com, Pranjal Shrivastava <praan@google.com>
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

On Mon, May 11, 2026, David Hu wrote:
> In case MMIO size is bigger than 4G, and peer2peer
> dma goes through host bridge, we trigger the code
> path to assign total linked IVOA, greater than 4G

Nit: s/IVOA/IOVA

> to mapped_len, and leading to a silent overflow

> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Signed-off-by: David Hu <xuehaohu@google.com>
> ---
> drivers/dma-buf/dma-buf-mapping.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 794acff2546a..658064140357 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -95,7 +95,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>  					 size_t nr_ranges, size_t size,
> 					 enum dma_data_direction dir)
> {
> -	unsigned int nents, mapped_len = 0;
> +	unsigned int nents = 0;
> +	size_t mapped_len = 0;
> 	struct dma_buf_dma *dma;
> 	struct scatterlist *sgl;
> 	dma_addr_t addr;

Minor nit: Let's follow the reverse xmas tree format?
This looks correct to me, for this change:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Apart from this, I see similar issues at other places:

  1. In calc_sg_nents(), nents is accumulated as an unsigned int. [1]
     If nr_ranges is very large, nents could also overflow, potentially
     leading to a small allocation in sg_alloc_table() and a subsequent
     out-of-bounds access in the mapping loop. It might be worth changing
     nents to size_t there and adding a check against UINT_MAX.

   2. In fill_sg_entry(), the loop variable i is an int [2]. Changing
     it to unsigned int would be more consistent with the nents type
     and safer for extremely large mappings.


Maybe, we should also fix these? For example:

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..ecf07ffca2b9 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
                                         dma_addr_t addr)
 {
        unsigned int len, nents;
-       int i;
+       unsigned int i;

        nents = DIV_ROUND_UP(length, UINT_MAX);
        for (i = 0; i < nents; i++) {
@@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
                                  struct phys_vec *phys_vec, size_t nr_ranges,
                                  size_t size)
 {
-       unsigned int nents = 0;
+       size_t nents = 0;
        size_t i;

        if (!state || !dma_use_iova(state)) {
@@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
                nents = DIV_ROUND_UP(size, UINT_MAX);
        }

+       if (nents > UINT_MAX)
+               return 0;
+
        return nents;
 }

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/dma-buf/dma-buf-mapping.c#L39
[2] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/dma-buf/dma-buf-mapping.c#L13

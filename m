Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0381F459F7
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1689D10E9B2;
	Fri, 10 Apr 2026 18:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqKVvcpu";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE6510E9B2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 18:04:05 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so22545975e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775844244; x=1776449044; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wKvnnTJ8lXMy4pdWydbphtW8dXSxElA9qfrrK//Jm+o=;
 b=SqKVvcputRSWWWsDMePkyoaWAyIYMDoiTMZTLSz1gjjkOzU31QHYCg1MuIMdbXNVJC
 tiQBQLVymJJDn9PZUwJvS4W3mTul8EgQEv3RyK4zMkfXucM/t7ZRrMQy8xpBFkDAkA27
 hR8K2K0eT6zXrc/lWScTIIow6IcFM0YjNw2jQvgSpq28gpYBHQg0Q3AcZsVk76az4cOR
 3orlghrVeuG5Gx/yWlwerj53dkG2LqgmWIdFAaFq+tS7G2jgb1Aiyxthx7JLGZdn9Z3r
 9gvZD4YrcRvB7a580Ca+4u9O/RMxPLGipo4y9sN9JrxKyIrbw+JtO3FP64oHjb70tnF7
 Gs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775844244; x=1776449044;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKvnnTJ8lXMy4pdWydbphtW8dXSxElA9qfrrK//Jm+o=;
 b=EciNSb1ALV4QyA+Dh3XDD+oBH2EA/gq9MJ52N4484v0gu2mKmKhBsMaDCkzX3X8RIa
 hM4uytKy/2XpTsfiDT7kMvC+ASmj5hKfSbwOOA/gnV5VEcBaOhXFu5UC6XQ+d69iVpyH
 7v0Kl20JwcVa2wzceqrzvsqNpcWDBz6a2Ex+px2F+rGOSrOaBLDFwPjWzLYv5sQ2VwYR
 H/4zbPM0vZb/QmtTN7CQokPuYMqgIOWk1zJdLzNbdbGz5z+VW+wDM5H9K6plRH1hd/IT
 3MnO9IX+opkhvYD8PQmZe7EXYxGS0C8tfDMksI9KrCChI7iqiKwWEdFqUXo2SIjA9Jij
 C98g==
X-Gm-Message-State: AOJu0Ywf0UHgLer/pJFWPissyP/rWqwC4zS0MUug61PTcArJ1hF73mtS
 gBeiECRW23IrG+DZcx208qhL82xlWes+4IgUWg6Kv6Rh08gdsl4apk3j
X-Gm-Gg: AeBDievwbLaePBd8/KvHtbmdhckb0f6L6IuWsZm5bd0/mJEJaqTwCrJOJiXIXI0zQ/f
 BP7GhrLX0G/zIRkl4SnYUoNRp7jJGfjUbA1preCTnOK/Lx67ldRFkg3IUQ+jYzAeesl18iUNdp9
 owlyKAPhyh4NrHC1a/vq7u/3ZML2ZD+pNsX3MTzGR23x0SaxjA7UNxuYP8u+SLS5mX1PAqaZAbQ
 JQ6/BsPJCDWZ25Sr/aRnZUlzw8jaYdZDYIKLzP+erbESYmSlkz15YwgL/Fj9H4yT9IRztV29EyJ
 V5YtNIDF/wjJ2BnDudSc1IgjmtWCCQUlGFvHO8KYM6RQiL044+IsXs8zv9c2Dcx6TQctO5moFy+
 kM/J5flNwoDXYjM/BJugHSI9y2m2AfhkIL4HuAwOywsEsGrp0yoN+if5pMgfyG8LsAOXA8scxfS
 p73CMsEc8iS8O8o9rJASM=
X-Received: by 2002:a05:600c:4504:b0:486:fbdb:b718 with SMTP id
 5b1f17b1804b1-488d6868606mr51534155e9.25.1775844244161; 
 Fri, 10 Apr 2026 11:04:04 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d538c03esm89668725e9.13.2026.04.10.11.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 11:04:03 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:04:00 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
Subject: [bug report] accel/amdxdna: Allow forcing IOVA-based DMA via module
 parameter
Message-ID: <adk7kOUBwIyYnX1M@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Lizhi Hou,

Commit ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via
module parameter") from Jan 26, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/accel/amdxdna/amdxdna_iommu.c:68 amdxdna_iommu_map_bo()
	warn: error code type promoted to positive: 'size'

drivers/accel/amdxdna/amdxdna_iommu.c
    38 int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, struct amdxdna_gem_obj *abo)
    39 {
    40         struct sg_table *sgt;
    41         dma_addr_t dma_addr;
    42         struct iova *iova;
    43         size_t size;
    44 
    45         if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != AMDXDNA_BO_SHMEM)
    46                 return 0;
    47 
    48         sgt = drm_gem_shmem_get_pages_sgt(&abo->base);
    49         if (IS_ERR(sgt)) {
    50                 XDNA_ERR(xdna, "Get sgt failed, ret %ld", PTR_ERR(sgt));
    51                 return PTR_ERR(sgt);
    52         }
    53 
    54         if (!sgt->orig_nents || !sg_page(sgt->sgl)) {
    55                 XDNA_ERR(xdna, "sgl is zero length or not page backed");
    56                 return -EOPNOTSUPP;
    57         }
    58 
    59         iova = amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr,
    60                                         (abo->type == AMDXDNA_BO_DEV_HEAP));
    61         if (IS_ERR(iova)) {
    62                 XDNA_ERR(xdna, "Alloc iova failed, ret %ld", PTR_ERR(iova));
    63                 return PTR_ERR(iova);
    64         }
    65 
    66         size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
    67                                  IOMMU_READ | IOMMU_WRITE);
--> 68         if (size < abo->mem.size) {

iommu_map_sgtable() returns negative error codes but size is unsigned.

    69                 __free_iova(&xdna->iovad, iova);
    70                 return -ENXIO;
    71         }
    72 
    73         abo->mem.dma_addr = dma_addr;
    74 
    75         return 0;
    76 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1809C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119CA10EFE4;
	Thu, 30 Jul 2026 16:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hrBttk5d";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A2710EFE4
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:46:09 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso145715ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785429969; x=1786034769;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NX0JpvyzsEoK6j+vmZOEXvLrdaZX+FAFLPxJGdbTFoM=;
 b=hrBttk5dznZEy8JH5BroYGtY5D5EF/ZPhukKDFXvYpihBOUpsLRcNJ6evWHK5sHkwB
 6PkMfUjZhE3dXJJ6PLcD+5TfEJQsgay07EkI97pZ2wYMRPMEIM+aYkizM+Sl/Dbzh1vD
 /ByULewnL8xu35P+v2A0WFTGJRSYAd/j1eXTiasnFZFo5mgexYSXhh/gXirxO1Rua1qO
 ZKXCr8SUMlJbHgH5UvxVXN54oyD4A6nyiYwLWcS7qUejUle2EsjlEElHfeZsKvtteSIz
 XKAIc9VSZK5jM8t3NPTNVq2Lk2NhSGyy7Q2pCIwCXfoExtFTsyxjaq6iB85LDrbsvHYV
 z40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785429969; x=1786034769;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NX0JpvyzsEoK6j+vmZOEXvLrdaZX+FAFLPxJGdbTFoM=;
 b=JW7gpYJkBfGX9hp2blcHatPxJ5m4xnkvS2zAojsiBpGf7UpHbsre+vkLCTSvvldXKZ
 uKyHjzZhPKihwcHyonLZ61dWdiYCcLVdnpwEAURJ+Ebrkb5YSfV91196yFs3UbxWXzNV
 RddgNmXjQy4hiJ+BHwXpXftjGnE7qC6abPjS5EpcB9T7P0jT6aW4aewmpfhdBNHE+osJ
 j23P5iPis2NcXJ/3xNgnM4njS6IfUAOb5vuKMVP79YdYVFvHOPTf+OeezVI9GZasiMU4
 JcrSHuHX4QFPRu05MIaigfpfzx0ZRHHeGlJReVcAPIqldfhOIhx2R4snguFx5W4CGyA2
 XYnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrk4OsJ2Pbb49q9Hcgsdn2Ba8JdK0z8IsEYN7bE/J/bgFTp+ya0twCqbLhSXroMMSEWBhzbaLiMWZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4uUclk7xc29+0LpZW3Bofg79iT7Ag6qBKkgn3R4ju2H6FOzz4
 nfB9KDA8+NxazDebRqZ6474rtmXPSTUaaysnBmgkgv4eL1Eds8oVt089cf4jzpORjaYIu7acEXf
 YS3vHLw==
X-Gm-Gg: AR+sD12nf9+uymQb910i5jx9vGDAn9hoDvNoeGHf65E8/PZmJRTi4cmoBYzznc/iv1v
 mbZbwT6YCnCnyvmj3CzO2pTvRw8DXcdC0xJcaySWAn2JqUonFBpBc68Xi5RlpYteL6Li5lBO4e4
 Rj+5QpCJbTl4ckWLdtJHdBxGZRMHoLCmQo+eAJLZWdh2Tldk/RX60NtpQWLgky2nvVvGHOn1X3h
 8DzqVKvDC5ofBqwrwUTn9QDzQ41Yr5N+UOf0r/3A90nL3RqhE5NNYfZv3+sbAWQaoEI13mvojlb
 5K5is1w1j+KBjefkU6FsFDjSqFNGGUit7i5qxiTtaS/7Rb9IgtUfHnFyzmQlgeqrVV6Yk4KHOrq
 KVAjEsMO1bZM/B06oMP6KxnOseCWmYJ18PZ42hckblVAyrhFA0y/GPlkv4vXhyIwrfp0EoOEyoI
 M03ZFQckiXCcu1IIi/dw/Z4mQ8pIFnArUv0sUsJdR/u+dsJ2uKuFhChBxVMBoTQGdIOe5dL64qU
 MvaWHSmMKcMzavm3RSVOoc=
X-Received: by 2002:a17:902:ce90:b0:2cf:9ec1:ea6e with SMTP id
 d9443c01a7336-2d040c826f8mr102235ad.8.1785429968232; 
 Thu, 30 Jul 2026 09:46:08 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02fa474sm3347122b3a.30.2026.07.30.09.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:46:07 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:45:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <amt_x6-9lplDLdHZ@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-2-matt@ozlabs.org>
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

On Wed, Jul 15, 2026 at 06:47:24PM +0100, Matt Evans wrote:
> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
> 
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

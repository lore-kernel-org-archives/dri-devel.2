Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04490CCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0815C10E3A9;
	Fri, 16 Oct 2026 19:40:48 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122F911299A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 19:40:42 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso9069585e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792179640; x=1792784440; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMRRI5bEPrjeiE8Y1aI7MLDO6J4IuqM4URq6dJXpjo8=;
 b=oKkHCOhJvP8zFwthChr5urz8Pxbe8JbIZjfVDQ/71EuSMuXCjw0pD9PI7M8xh0Hq1Y
 /gMLXuWotihg6vHHA4mATpf5P+RNSRqUF69/moEDX/quqTzxOU+Tm51l29471FH4MnZq
 CHjBpny0bJEQOULHPtJnnvYrIf6cllxRk7nOjesxW+PGG9clG1/4Puj5X4C0aAMx23li
 JaaJarEziV64qyEIiLySGdiCdhDf94ATuH5nXi/xTtMeTrWlrpS/jqyIAVGJA/Sv0ZHP
 9GUwVCVyZemKk2+XSnr7UXTXq15HH1LKnGL54uVJXWhWT6/8QDrJv0kDORXZy65Kwcl5
 0OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792179640; x=1792784440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iMRRI5bEPrjeiE8Y1aI7MLDO6J4IuqM4URq6dJXpjo8=;
 b=Wg/y6b+A4VmhEyhM0JO5QceEKhtOK5MgsaNRt1rohfdWoGPQqxnM7uizEhpSvLbF5P
 RDmUtC1bMfaByvbuXetoo8o9O8Wk3GeJB0RnO4m43xQCxQb8skcUKeHTol9xdFkdQbtd
 i2NSLQ/N1R46pnQmyDYsxrOcKnv9uI6YPm/rjPJpk1DO4UNfXqHv5L7XqV7k9yW1vHei
 tIfWmhz+kqomNYvJb1poz9c7iZSRsWNd98l3EAX3i6UysaoFn6xo1EjoD0bERlyGjL+e
 X+nAqBI9Jv9N7izK4kyKG4vHYEtADXxxfCVZpFRdmNlFwSyDpcMRDSF5HeS9qFiECzrA
 7fug==
X-Forwarded-Encrypted: i=1;
 AKwUvBykYRnb5AfHcnnJQ+x9I0EEuJ0F7dxyHm4M8UQ72cszZqLxa3OWgviakxu4LdDGG6u/FPkVoOA9lCw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIHw452n530gCt/BGxCeuaPx5komQS2ZDL97LsPPjvskAp3iPs
 l/aY9aTyX5IfYfOzvDRjfHRnTELRXQXQgrbqHjgSpDfa6t7a45+3HafR
X-Gm-Gg: AYBFou3lsR4iclT/PkWYXfiq6P1WMYqPAmRQjk4taGkxolHMS8188518h/0UW56KYgU
 6GPGUqbOlV+tEDTRHi16rzZoqr2UoBdlQgOs68GdjUNY6H6Xq+sCtfMjrgNlGu251Y7jM5X5MwE
 q9SKp99m1mZi2A/Jl6N31SskTdG3ixhT6PpAlnHCc6bRYeTnlhEgbqxfO8SxOJXdj7UZsZL5EX7
 QcS+8bOrpXHw8j6gBaANrwdGem7MzLmp8Fxdjk7eWq5o3A8zoMV+lu15iv4IteZU8CcwDYY7Ve4
 gth//0pusW+hc0ehMRXQb9986YwFOzrdDgPEpTS9aEbowRes8y3mDDvLqej+Fv2IJt3QkpJ37Z6
 FbVujNbNPO0/EXVVCO+WcVa/GGYeUrhygDL0RPVeBY2+SkUUbWoUcpP8wNxPyIevWJXLU55jnbS
 LGxnD/qwEizTMKgy2HoyegJoghHsR2EEByLH7qTJfdh9f1kyDnss3T4kQ8oOut266IJNahcPkVk
 J0k3byM7ARS5xDy9n9Rbr949QCeVtMmUOY90l6GGsvn0/zihz40GkE0lyesKhtVqJBxaNKeqms6
 5Kh0n8F4v3zfwZ0ue2CYq/dCjqJS+UksOs01R1vcXJ41aHDChfVKNaMU42/w3R+L6pkvqEmDE46
 6nh6KY7qdkaCq
X-Received: by 2002:a05:600c:a102:b0:4a1:bc14:224b with SMTP id
 5b1f17b1804b1-4a1c66b37cfmr83617395e9.10.1792179639973; 
 Fri, 16 Oct 2026 12:40:39 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de.
 [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd5038b8sm7026413f8f.48.2026.10.16.12.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Oct 2026 12:40:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Alistair Popple <apopple@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 23/26] iommufd: Use the PAL mapping type instead of a
 vfio function
Date: Fri, 16 Oct 2026 21:40:22 +0200
Message-Id: <20261016194022.62065-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <23-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <23-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
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

On Tue, Feb 17, 2026 at 08:11:54PM -0400, Jason Gunthorpe wrote:
> +		dma_resv_lock(dmabuf->resv, NULL);
> +		if (pages->dmabuf.exp_phys)
> +			dma_buf_pal_unmap_phys(pages->dmabuf.attach,
> +					       pages->dmabuf.exp_phys);
> +		dma_resv_unlock(dmabuf->resv);
> +
>  		dma_buf_detach(dmabuf, pages->dmabuf.attach);

exp_phys remains non-NULL after dma_buf_pal_unmap_phys() frees it. A
move notification after dma_resv_unlock() and before dma_buf_detach()
therefore reaches iopt_revoke_notify() and frees it again.

A test hook forced that ordering on the posted series. The one-page
IOMMUFD selftest unmap on arm64 QEMU with KASAN reports:

  BUG: KASAN: double-free in iommufd_dma_pal_unmap_phys+0x14/0x20

The first free is in iopt_release_pages(). The second is through
dma_buf_move_notify() -> iopt_revoke_notify().

Clearing exp_phys before dropping the reservation lock makes the same test
complete without a KASAN report.

Karl

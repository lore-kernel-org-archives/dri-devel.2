Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00539C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 23:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5F010F0EB;
	Thu, 30 Jul 2026 23:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LK6kLOgz";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE79210F0EB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:20:17 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cacef7d299so24955ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785453617; x=1786058417;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i8nq0/Hmm93fF2JW2THyDFZojbW5xmKXoinFZToOHmQ=;
 b=LK6kLOgz4y8pnhQjyj2aQEP5VM4BVf6UprFtq2kwAkZURJw5HQFE8niQAb1i10RhIr
 p7Odj9VbLNR3+rfi/meQnoOkJ2Po0Y3GOjrXKAx2s9pSX/OULzFHWc8HO8SzRjqO7fAM
 0brsFfNKXu26EymVjho/ZgRTZ6fy9BsQ0rHqA9AzY3427GwYP4VwEluaLnavgdLVGkbK
 YbYLUxFaTPqJe0upE5sjzvgd135BnTiXQ0ExpmruvVA2dMd0yYjTbOAk8BU36sQ7vVQZ
 OAOBP/eLsmsBmqzFCw9NiUB6C1EiMksaDBKbMAKnnl4Ey26b9hEoulCHtOv3seEW9zyX
 Eqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785453617; x=1786058417;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i8nq0/Hmm93fF2JW2THyDFZojbW5xmKXoinFZToOHmQ=;
 b=ZwdPAKGHnOddzwxQTGQrtsARG6PINqYN3DKOQKPVW7FTJ2I+6gUUgpI8dQ+deetc6Y
 lcqv+9aTJnZIpXaTqLqmV/36osBd/tyuZ78DtdFKuw8f1kbpN0qKn1qX4iWNBu36fIC3
 AYGwsp1dlX792M8qTRH5EPNbPNlrffVX45S1Xb1piHRJjqgmrpTXumIq6v9agwoh2R8K
 2QIEq9mVdxqHZCOfMOmKXlYJ0fp7BMu9lVMzN3oe/K6nkXJEovv7qzuKZYRl6YuRGsko
 aUZBJNRanVT5yqlSjHVm6IL8xE9JWH/fpJ582gh92z6p2VjaVGgrSmTDAw4NusUKKfh/
 ewAA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0vj5ER+vfTRhwV7/VDD/2OsuqJXVQvpRlcQYoDkx6q1nLA+uUGkRolFUA6os7ZlNs9XhIHsg/1Fg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvyVaUEVLB31vZBfX5d+b2n5xQHwH6ai6BrwuG233UfqJ871C8
 nA+5YrTlEr8r961hT0OEvwJlRxtmbehQ5XVP/gLMLD8i24uQPoCjkud/a3h/JizjkA==
X-Gm-Gg: AR+sD134Kq0FM6ywgxJHVDbKqabpWNLajq3XeOvCDz3oh5V7hk4twucGu07W2q/IY2d
 Usf+o4efSXxRX4+h4yhdKcXHXh2meTNBdTBDQUhgsF0v353zxsEoxLDQFghWS/b2WirnZ/0F/L0
 NUEJbyDR8qtX2JBkMFb/XjccLEnlTXbRubE7qU8rnkVik0RlEVvLVErBafeDMZ/upftiPpld/3+
 JP5A+bBqvPOHCXzNb9/O0Ntmt0iAPGPasjlCGVJMa11shufwCIAID7XqK1hHpj9UQGEquoKFnNL
 ciemhFiPuyL16GfR1wk3sNegcUPsyOXXe7WI5ftoCm8rWSW9IPYI8QQa/CBQprqrgNTXpVJxH6q
 p6E6bEDrVq02zYUd4pCrCiH8lPHOWSZJ8v2jX21dYCaY68TNrdo1MvAqkrHcrk7A+zEOE6F/R6h
 QQmFv3vnE9UxGORkRJq2FnWQJH6ingyaMTKqoa0QxEk52qLVyiGOPurIDHioj19WoxEPimYGgbR
 jcBQF67mqiW5IudBInX5n8=
X-Received: by 2002:a17:903:2a88:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2d043c66fc3mr2363495ad.1.1785453616883; 
 Thu, 30 Jul 2026 16:20:16 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7265be48sm24706277c88.8.2026.07.30.16.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 16:20:16 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:20:08 +0000
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
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <amvcKL8FR60OoTDW@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-8-matt@ozlabs.org>
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

On Wed, Jul 15, 2026 at 06:47:30PM +0100, Matt Evans wrote:
> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls to vfio_pci_dma_buf_move().
> 
> This commit replaces them with a unified new function,
> vfio_pci_revoke_bars() containing both the vfio_pci_dma_buf_move() and
> the unmap_mapping_range(), making it harder for callers to omit one.
> It adds a wrapper, vfio_pci_lock_revoke_bars(), which takes the write
> memory_lock before zapping, and adds a new vfio_pci_unrevoke_bars()
> for the re-enable path.
> 
> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the zap via
> unmap_mapping_range() is no longer performed for vfio-pci since the
> DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
> 
> However, it must be assumed that VFIO drivers which override the .mmap
> op could create mappings _not_ backed by DMABUFs.  So, the zap is
> still performed on revoke if .mmap is overridden, using a new
> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
> vfio_pci_core_mmap() and so still uses DMABUFs.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks
Praan

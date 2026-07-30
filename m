Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F17C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 19:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A48710E034;
	Thu, 30 Jul 2026 19:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qti21Mze";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5C110E034
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 19:37:26 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cab97c86bdso2685ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785440246; x=1786045046;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WsNFudBG08sj5R9fNK8ZstEhl3SLgUPJa9Y8Tw68yBE=;
 b=qti21MzeRf+h/V/JJCQ4lAHTNzaAkJpiFfxDl9mIcBVi74SrEU9peTGAcWAMDW5xfk
 ufjKJVhEQ6d5FEV1lhCA9IsnjKeq8d6yzLVYhv7kyArXujSBRBiIjsSJB/GM/PQiHfF1
 FvL+rbhvxYYxmWQJFWBKNr1+g8MZ4x3xXyXWM5R5I+Ai7bv70WDePjeAMuJut4XaAwGU
 Gh6gqwEYS+cGGV2RiGR6TxbxNL+8L29jOjBL2R3vbRzMvUSLrpvtCohsQcgDkXpXqdkK
 5mG5UdEuBOq1r1N50bKesjghpraM3Qw3+DHAUdUpzk1WO3Pk/aWjSuP7yLdqT/JmmrmH
 OexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785440246; x=1786045046;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WsNFudBG08sj5R9fNK8ZstEhl3SLgUPJa9Y8Tw68yBE=;
 b=PZlMGwAPtriGhQuTC3oL9LuelwIm1I9y2oEdqokb72P9iVOUXBKdNgdG5vYXk6t9we
 lvcA6nlcXx1C2L8yFcqWv8txa06Rv0c4pNE26PRhlY4H/H10v+YR4PLVTLmno0UOogX8
 rc/Qc9pMBP/mauDHFbnIUU3RR2uOBbm/LbcslHru0Fb99z50BtE8SztTRvwC3bRqZ6Mv
 sXVQmadBY93meTFbxu5CsJtaMk7H5AEn2ttvBzNQv5cN3wq22VY9QYyzB7HOvD2Lh+te
 x7Ws2Zh9YJIu2UHm74z3tfwBR1MQIfSwrHSvn/I98lNaxE4oGgJkAIhHlB0DJt2Q+Foh
 CCaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz78HPDZlOqR2kty443EUB/1xrLkIepFcOlD/2keC8dB3At1eMC2G0FzZMRjYQ+t4Vi80J/Jx8Ylg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBxgt1ex0j7h2+Oz6CbsPk82feQTfaCaynudZJc4xYOlH16/tD
 7Ld+GZiUzEMkrYXqEYE3VqtKe28JLkTzQeoLXi9/0W4D6pKdQn+uiTDvVwFasZGJZQ==
X-Gm-Gg: AR+sD12POKaGJlEv1PnAh6EGmJ9symlNqWwQvkrxwACIc7iEiZnagN1jYpyMxtfSeKG
 F6ib1g0KSYsc91MC+Dnrtba3t9SFZWm25da6nj2e1VqXCJJ61Y/5HX0CEEvVlZ36DVkCk/A1LzX
 rM6LbCLlIUtRxu1geOOrDewUEFwKjHqT0VpTqffo9pyHrna7SI7lMlBq4S4oFOPIK2Yv8ZZLrm6
 Q3PljGSuqTqrYLd8DwqVnzFagIoLGFmKR0x7OhkHW2RVJnzhf8SRxoY8mvb0ZMGXIbgc5FF2exg
 SEUIE5mAg52D/sU4vJNjMHEgWw6cN0a63B3a9LoetX92zuXiaPHCGLUTvoLYWSzrwVmHNYg+iOA
 vKxHmDo81ZEw4dEbWM+2QQn41hGoHp/bxglF/HM3wLNMC5ijF4h3yjo0Y8liESwICSYGG4i9n63
 ZMppfkaqYRlp77onEFCzGEXXPqK8jLNgxpD4mo6j/PO+ZHWnDx9YCz3h4hk/UdFw4mit1uyJ4jA
 QiG4UXB2ZrTLKyXKOyrUH4=
X-Received: by 2002:a17:902:c40d:b0:2c7:f688:f22f with SMTP id
 d9443c01a7336-2d041586156mr1531825ad.13.1785440245065; 
 Thu, 30 Jul 2026 12:37:25 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e72745b1bsm22459117c88.14.2026.07.30.12.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 12:37:24 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:37:16 +0000
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
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <amun7H3esu-1OA49@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-3-matt@ozlabs.org>
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

On Wed, Jul 15, 2026 at 06:47:25PM +0100, Matt Evans wrote:
> The P2PDMA code currently provides two features under the same
> CONFIG_PCI_P2PDMA option:
> 
>  1.  Locate providers via pcim_p2pdma_provider()
>  2.  Manage actual P2P DMA
> 
> Some drivers (such as vfio-pci) depend on (1), without having a hard
> dependency on (2).
> 
> A future vfio-pci commit will rely on pcim_p2pdma_provider() always
> being present.  If that depended on CONFIG_PCI_P2PDMA, it would make
> vfio-pci only available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit
> systems), even when P2P is not needed.
> 
> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE and refactor the
> basic provider functionality into a new p2pdma_core.c file.  This is
> available even if the CONFIG_PCI_P2PDMA feature is disabled (or
> unavailable due to !CONFIG_ZONE_DEVICE), satisfying (1).
> 
> Then, when the original CONFIG_PCI_P2PDMA is set, drivers have access
> to the additional P2P features of (2).  This still depends on
> CONFIG_ZONE_DEVICE.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

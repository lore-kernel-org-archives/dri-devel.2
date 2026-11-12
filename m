Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D26606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KN276hfY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FD810EBA0;
	Thu, 12 Nov 2026 21:47:11 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B7F10EBA0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:47:06 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cd8ba7c2694so128367a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794520026; x=1795124826;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
 b=KN276hfYm949rQ5Us0w+J0b01ZSUPKWttuB78SxMA7h+S25tH7Qe1TovF329W2UhHv
 dhw7BPBb0c+cLbsGWLgIRtl1ONEH0Gn19x3Q+ume87EwK5+1nNn7zO6hiatFC4ofgyRp
 b4JnEpMqPB8BhTr/EFw4KritLZZIzB5ZoK3mW2EWJNcWfOXQ9Z20U3qCUD2bCFX0eNU+
 KkuP/3hg12XOJa4pNwncMkRE3F3LN0M83OBK+/rngK7tKant9Gj2OptCojgQHaDPV4pp
 ZnO2pE5eZsl/GHY4UI+anfuP8AK4BKKH9gVcpfakyX4FVToOiaIEWbdxgcQt6QbSznXU
 bzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794520026; x=1795124826;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MRvrBEIopDqvuVb/vZ72s+DUNbn5hAJVvZTwAj02wNI=;
 b=ly9USSvDd+V/OKeXcWfjpt91VzZ7vdutC8mF1WAi1uWKKQV+sZ5pom9FGIz0VLSK8A
 yVEAn9zA8Vf8dO4w2Rq3y280quaGQHBCdfIhWcCPlohBxelnaG7DbTtSd/1SqaJHJCXy
 MoeBNauBsA7kGPWomOSBMTzcE1FpMsW9G4VzZunXiK9q6AVf5sxyAAk0PcW2CMa1K+uK
 F8FSN5JXOITJYTPbC2Mrs8KSRLu5bMdtR3psAKV0MgRxQRXgUgDBwPNDu+1bxzo1iju6
 hp5l12Ac65Afn878XmrgTgOqxs/eJ3CVaqx1f9gY7dQ1qsC5euxAa4WhQbowJK/0phR7
 wfNg==
X-Gm-Message-State: APuU4Z8N4bKMLgnZXhQXDtSp7Zer72VwJdfV5vh4nCrx8MFK20DDkS1K
 ia72uuY8wFvL6T1uaKyM3iHZ0xLkXHRYEDSaBdGZKrcrPjAi6/5Ob24Pm60U9Q/osv06Fs7iq01
 /aDs30g==
X-Gm-Gg: AYBFou1A1ENfvm2AY3BEqAkCKE3aqobk26mjSn1AWMfBPMRj5aLpsun41mtPb50UvgF
 U7JOkRO4yLCs31kPg6TDGEy5HLUT+TesTrx/m0gfMrBcHPw0wT2JGuNsJFFsEq0GWaHIksc0aht
 usPpW+73jUprzUp4Wfu5lA9gIk8AkQDNNeF5oF3ayTepjLYjCFnD2QmKmyxILpZpf8lHwyQEUUU
 DpS8VS86y4Sx9U8XNE/GggIuc4fb7YUf7/vaQ3iveXQY0tMBid4dgG59dxtzgSlJgwYXU3xSAB5
 4vOp3mTrjVxhRDevY0wEy1WzaQPxfEWx3u9Cm8QEiIZ59or3ebAbCduCvdiMOjDw6R8E/UFN+AF
 tC6nxI748SgsfIDBzj9SLKsWW06MvZhkLFFGQ36XTxWQhbwMxylaxe3h9KYMZDfCVcmFaKXvZn3
 Ypj7fcbMkePfqDKr35WA6957RMGwXmFy+sQq7Wy4PcShdaQE1arFdlXEjmySKf9XUJs/ZHL1pIv
 zU6Q5DodIuAyFjGSijsml+PXBK0L1x6BJJ6tsYXBQ5wL3GLYy9AlWCnQHv6xyozabwuInVUN2ZQ
 V1K/VOdZCGrPfQRDwkq2qL5CM4tVj6G0ecVN1oZslDErQyJe8f0cy4+4XBhCaDByTdxPE+/tEC2
 brai8JGDkeA==
X-Received: by 2002:a17:90b:30e:b0:3b0:97b8:d6bc with SMTP id
 98e67ed59e1d1-3b1b0a0e889mr278699a91.16.1794520025137; 
 Thu, 12 Nov 2026 13:47:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com.
 [34.127.79.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d257a0sm6493095a91.11.2026.11.12.13.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 13:47:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 13:47:03 -0800
Message-Id: <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
Cc: <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, "Matt Evans" <mattev@meta.com>, "Matt
 Evans" <matt@ozlabs.org>, "Mina Almasry" <almasrymina@google.com>,
 "Samiullah Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Alex Mastro" <amastro@fb.com>, "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
In-Reply-To: <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> Hey David,
>
> On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> =20
>>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>>     uAPI behavior? VFIO_DEVICE_RESET (and runtime PM transitions) on the
>>     target device also bracket the reset with
>>     vfio_pci_dma_buf_move(vdev, true) and vfio_pci_dma_buf_move(vdev,
>>     false), tearing down any active IOMMU_IOAS_MAP_FILE mapping of that
>>     device's BAR even though PCI_COMMAND_MEMORY remains enabled when
>>     VFIO_DEVICE_RESET returns.
>
> There was some discussion about this in the thread below. My understandin=
g of
> Jason's point is that the current behavior, and differences between what
> revoking and move-capable importers see in regards to vfio-exported dma-b=
uf is
> somewhat incidental and not necessarily desirable.

Thanks, I will read through that thread. It seemed like a surprising
uAPI.

>
> https://lore.kernel.org/all/arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com/
>
>>   - Physical target devices and P2P topology checks: mem_bar_descs[]
>>     currently only matches QEMU's pci-testdev, and
>>     vfio_pci_has_p2p_path() does not yet check PCI topology or ACS to
>>     verify that P2P traffic can flow between two physical endpoints.
>>=20
>>     Suggestions on physical target BARs to add to mem_bar_descs[] and on
>>     checking P2P reachability from userspace are welcome.
>
> FWIW, you can also exercise the "P2P" path with just a single device if y=
ou
> IOMMU map a device's BAR into it's own IOAS, and have the device DMA itse=
lf. For
> eventually validating aspects of Live Update, maybe you don't necessarily=
 care
> if an actual peer device is being DMA'd?

The way I designed the P2P selftest support requires 2 things:

 (A) initiator: A device that has a VFIO selftests driver.
 (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar(=
)).

So far I haven't found a single device that can do both. But you are
right that theoretically a single device could satisfy both
requirements.

I can relax vfio_pci_has_p2p_path() to allow initiator =3D=3D target.

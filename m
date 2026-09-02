Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD97C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C8E8910E;
	Wed,  2 Sep 2026 17:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ILgS+Skf";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00FB8910E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 17:46:05 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-90f9f8553e0so9870026d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1788371165; x=1788975965; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ezr6Kp9rH9+35ejy6kYQ0m2wIG/3JEQzG3offk+MEvQ=;
 b=ILgS+SkfSAjLKABpBuXXDTp9iqgJ9fR0B5iBpHYu5WRRmxkwsVtHBCUhz1skW9opOx
 rhJzsYFAROuez/3UcmYlqhljE/21D129i7qGZGInkGngxlrjSbV6mAMCuJPUCcUdp2BT
 +c1zJfav/G/XQ4L5hoDplH1OSDqbBn+TvOqUU5P0A9Cm32f440jzBEUze9p+Yw3qYAdL
 h3YISNwACZ+6BfMcmG2ZOXiIgCe4PDN9/ROtqp9V7K3jYWclMlQeHSud2TnP7/qs85g3
 v0JlQKyrQDhLW/6D71MZBowV9ThwvnMKe/vihkggX6TS0LOLjcSl3A1cGxLyeJyoVxFy
 6vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788371165; x=1788975965;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ezr6Kp9rH9+35ejy6kYQ0m2wIG/3JEQzG3offk+MEvQ=;
 b=Fzqg55iovlrquJC/VEiAUiDGcbMVprv74X6MxAMQXeGTccYiJ0QQJcDA6FOnBrsBXF
 ACdo48fnxQ+h3LFzX3pUTc0OKoMY5U8mYQBgAQHKFGvoe+54H9EvKK+5RYM3y6mwyRLt
 z9jBEM6qgp1dv1aluZEg/zBp/UCdL+Fw0xo8MW0mXoTzVnsmluZaCSQnU5oY+vDOdEMq
 zJuvEFN5IEuWCL5B5FsJMBG+Cbs8f5LJFhPwIqu9Z4QZj2EwZfyx+6q8uwesun/3FFv6
 imvD1PrR5tEjKwEiBBrUvs/I2gxpZDkqiq3Y4g49GVJ8klFI87cG745Ymfz2wVJrwpk5
 hD8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMJsXfza95vmTNSt5DJr91saEo/oxPloAteI1C8j4PQTTyyXwz6BN1THqR6za5KYHdlTtf+EODVWg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVSDbM8N8NwXRgkFoxshcpakQu7SzXwZ5bToCPzah2y2QiGCSs
 WQVsc1Ds85XBargbmGqIjvQ2dX80uy3BxDEKuHKJw2McTafVWxwVAvUEhXJMbImj/RU=
X-Gm-Gg: AYBFou26eZDAKR75VgpKfeiCyoC2hxWli8IG5CPtf3euoqAyokVi2VpUsYZ791nxtxi
 F+hyetz7MxKXkvIH8Gp//GMiGgmd0BTKrayp2iQRR7pVn9Y/lFHGItV1DaJWrMIRpFBTXos4StH
 ZtvQWTCTW2JUs//YiV4mJ60bL/0Prrcov1vgtx0seIsPVTzI3seIZ7NlK04U5qI/35kGFydR61a
 I1MYHoRBMTsSkoVELvoDvz3gq/xGURKENG4Yk70V9Gwjx9jfaGjV7RXjE4a/yWIEe7uPBk1S6N/
 beIsO/2nQoU8YNG0UpQmNpl6KkJGs2lDtdD6hBNiiemt5wr8L8CtR4XmwIZsdW6rQ2MI+UKB3IK
 aTjy+2l5yi9tIvJ7DQzmHPiIFYN4pLy3TCuUNFe57pc9GiLWvE94vJIIIKot40mEsL5Xti6Dn96
 oCHdvPF5ZFFFeFeCIDpUwShh6Pqe9J8u3W0Cj26DfUMaz9Lm3l32ETWviBu2RdedZ6xkiUnzEPW
 npAmAjBDaZk2dg4ITWDFbpGxKOxNdDxzXRMOvXa+NnH3pAcGzOjXFQl
X-Received: by 2002:a05:6214:2a84:b0:910:3453:7d8a with SMTP id
 6a1803df08f44-91034538000mr9552376d6.31.1788371164336; 
 Wed, 02 Sep 2026 10:46:04 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9ee41b5dsm23518966d6.21.2026.09.02.10.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x1p2B-0000000Emsa-0EzE;
 Wed, 02 Sep 2026 14:46:03 -0300
Date: Wed, 2 Sep 2026 14:46:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Hu <dhu@x6u.co>,
 sumit.semwal@linaro.org, alex@shazbot.org, ankita@nvidia.com,
 chriscli@google.com, david.laight.linux@gmail.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org,
 viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <20260902174603.GE2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
 <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
 <20260902105919.GV24140@unreal>
 <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>
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

On Wed, Sep 02, 2026 at 03:34:18PM +0200, Christian König wrote:
> On 9/2/26 12:59, Leon Romanovsky wrote:
> ...
> >> The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as
> >> far as I can see is a complete dead end.
> > 
> > Maybe you mean DRM, but VFIO works perfectly with
> > PCI_P2PDMA_MAP_BUS_ADDR flow in DMA-buf.  What am I missing?
> 
> Well not quite.
> 
> The approach PCI_P2PDMA_MAP_BUS_ADDR takes is fundamentally tied to
> only map a physical CPU address into a PCI address and doesn't take
> into account that in a lot of configurations the CPU can't access
> all resources.

It is called PCI P2P. If the flow only uses PCI devices it should
always work because it relies on PCI spec things that happen outside
the CPU.

It does not try to solve the general embedded problem of arbitary
communication between blocks inside a SOC, scale up networks, and so
on.

So, yes, it does not solve every problem DMA buf faces, but no it is
not a "Dead end" as it 100% solves PCI to PCI communication which is
still a very common use case.

DMA buf users that are exporting from a PCI device, over PCI MMIO
should be using this API. It is the only way to do PCI to PCI
communication correctly in the kernel.

Jason

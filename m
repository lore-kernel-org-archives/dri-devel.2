Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B2C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2995D10E23B;
	Mon, 21 Sep 2026 13:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="KS71UERN";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C084B10E23B
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:26:01 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c67e5059f8so841315e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1789997160; x=1790601960; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jdn4c9lGyFJE/+rps4rYYBXSqoAaBa5j8WwP9obCXz4=;
 b=KS71UERNkNvagzBFmAjcgSDo4kpHGfSxVgZUMYlZTffHY2sh3PxKO3b1v9g9iL9SPI
 e69wmDwVmqEi6O/6E0KMIrn1IR3/h4oWPFs1IIJwVYry7osE6u9ZsnwGGxHd2IV5eHWR
 HiwUYC5M56V5ZmOZ00ORAZJpmxNrrYhTN5GIPH8t1jii4sFalclYzKJ8j6O+bactKB1o
 +0mIlbs2R9sLvoiElZg7raXFOrWP3llv6BFrheqmc85hxgZ+SmpnVPEBR1lUB0hMl3a9
 ejcJXR1jy4kd7WRlaUyNKcPWJGTGgxjeQkxRHKtgA55BFNKXDTalSF5URPWnDYnvsbQN
 LH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997160; x=1790601960;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jdn4c9lGyFJE/+rps4rYYBXSqoAaBa5j8WwP9obCXz4=;
 b=n/xT08In14VvqZECR9wR73kgEspVmxObAkDjogNRU7N2M+obI5AqzBN0iDqciFx1q5
 5Yu3JnR34iue3vsoIVL9UKAesat6pl8ZGZ/vW4OuZ2HDsrhVmptQq6xSFYxngYVcQqgt
 Dv0mHfpzLDfH9HCn4lEot/vy+HJjVl0BjTTIpQ/lrqJ2ygF3GVjfLeMoq0TSIYqosD2S
 5ezX6qRpmgLEbpkpm5mBG3zzGWspVw4vRU5Lm6veHI40izTioQQYLWku5Cyq4492jm6c
 kDAtUI1YG1cr7LRz9PtUQdWNAFflu326rl08BdkIWRUMnAFZVq8RGgychrtVudPuacbS
 caLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO2GDzi+AiHchNlVrGOb1hw2tkQOJ2WmoIiSaxNzgUbvCLN5BHFT2Nm1fqRM7NzHMVD2YlGoxVprg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mx0XTyUaABg0k19pJqPmRnx/unoDtHEVq38l/5ojgwO1d6Z7Qd
 mobgg6VLTBSnC1JToTZODiYfEltM5Yx1+1G/2ZkG2eehxo95vJdJ/PHxrQ0CW5mLakE=
X-Gm-Gg: AYBFou30VOdLmVX/2zRsa8iyZ4Wir4I3UyviinYJEXFJ4/mYWiM3NmEwtUzFdNJ1+Yd
 DkrrNJMWKq0men2GS35DKXqgVcU/CfEQTZfWXeWZ0aoitkxwjS4q2cbfGpTvD8qWxXFwRuPBtiW
 Q+AGbpJUZVqkRf7bD5sDTrlvKXqPGAUu+yDShcRsXGpe33HlS3TNmhJdvQclu4BP5JoM6+YQ+tR
 mcnA78PN9PKPXUzMOI/ks0Cfzby2LkW1ndiP87H8pXZir7N1GGAarpjg9xKnbp1v0ixL4X7Nm2g
 jDYo/xLHy+cDhgzoEbdEmRI+my25ObkyrGPWFrJ6AQ4z9tOowuX8BBNVInKxNyXsWXiIGDpwtW4
 gRE8iGc13BeKd6AkA5/BTz9LEGfoWGdT7NR6T6oMmYePehppwwuscEKWbjiYM2B0NJYHjMnVH6X
 ETKTrq5dskwHc69gRF4p4KJ2FJ8jB6aL+uje0CXwpOCsmDNx+pd263m5YGo2ZK5GpT0cJSvN2iN
 79xiIDyrgIR16ewPHvdWsBrJUza2nP6k5BApdmWlj1SF99gcl7dlON7
X-Received: by 2002:a05:6122:209e:b0:5c9:a491:641a with SMTP id
 71dfb90a1353d-5c9b8a6c1afmr4625797e0c.4.1789997160437; 
 Mon, 21 Sep 2026 06:26:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91260a60f21sm67324286d6.19.2026.09.21.06.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:25:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x8e1v-00000006Knm-1R2E;
 Mon, 21 Sep 2026 10:25:59 -0300
Date: Mon, 21 Sep 2026 10:25:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260921132559.GQ11599@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260918121500.GV13683@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918121500.GV13683@unreal>
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

On Fri, Sep 18, 2026 at 03:15:00PM +0300, Leon Romanovsky wrote:
> > That is, a flag to tell the topology check that some transactions
> > *will* take the host-bridge path due to IOVA being used, and that the
> > computations including pci_p2pdma_distance() need to check whether that
> > is possible (checking whitelist etc.) and return the corresponding
> > THRU_HOST_BRIDGE mapping type. Translated transactions taking a short-
> > cut using the bus-address would then be hidden from the driver.
> 
> The word *will* puzzles me. As I understand it, if your device has ATS
> enabled all the time, it should always get THRU_HOST_BRIDGE.

The P2P subsystem currently does not understand ATS, it assumes the
device will use untranslated requests and makes the routing
calculation accordingly.

If the device knows it will use ATS it should ask P2P for an ATS path,
and P2P should only return THRU_HOST_BRIDGE or failure.

The purpose of involving the P2P subsystem is to verify that the ACS
flags for the ATS translated path are going to work. There are many ACS
configurations where the fabric will hang :(

For something like mlx5 it is ideal if P2P chooses between ATS or !ATS
based on what provides an optimal transfer. eg there is usually no
reason to use ATS to access system memory for streaming (ie non cache
hitting) transfers.

Jason

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F6606A8B9
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bD9Q0W5p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00FF10E19D;
	Fri, 13 Nov 2026 19:59:44 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335A810E43C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 19:59:38 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-91f0c4f7a8fso23968806d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1794599977; x=1795204777; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
 b=bD9Q0W5pKpk/l30UApGzwem5h23kCTRP77QKy2i5F0tzxFmxlo2XYPxXmrZVwZE9ot
 01HUiJxqLmMYlDHxtdqXU/7pXYOd+z45rhoptIziYomeBYra+PQlgOQ3u2B1xo2TYT7v
 j/jRHaS7lcM31IPcE30f3VcmJylAh/OYac2aRBBEb9T3jJjkCmZC18ex/CnbL+0ZLnL+
 myn0iIpN3xY9+2LZuOAN/GJcdSasDB7ivByopO5y9vIYrpKkK4ZKGZJFP94tksOoC4Aj
 4cy80AJXO6G5FSoi52FH9cIFhQ7A6ge8MsS4OWWBjzEMEVoBX87Oar2IYWv9DcH2Z1dU
 Fcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599977; x=1795204777;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
 b=JBj1TASVuR6lP/Xr/5Et7Qv6KV2dYE567uUBNvbSfov3RSMM35x0v7qBC4vvIypYAj
 GctchrLso07q8QWYsl29osyJPMHBAIFc5JJeAY4pGCvRqkpKFqrLALlrSE2uiMbCf5Gd
 nHSd8taXVd0dHazUEQ1cEndqlgKyL0NGA1OBFT17PHg0LgiUycQZyHmC2DTXLm08t6W+
 SZmORH5r9GekEiW6TMegXduFuW33ke5QZM7RONNhgIRYik0kvlvxKWcLW/VzMtVorUcF
 19fGe2J2Tl32c0NzhdlRuo3tDXmzaIdFmMQgEzPLjulnroNc6iSTEluCh3KHbsLdI54g
 3FlA==
X-Forwarded-Encrypted: i=1;
 AL+hErE+WuQtH5VZeXAlJS+SKSUIUR5SebHmzkl4zJkowTeVCgwmYCo6o7lNlhdYyoE/NGrmcAYBzLpgGME=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zQyQaNA97gf/4sMjp1a9BfQvk2kj9on700awsu790K5VGsvVc
 l15poKsxJQtS8kVIeg5s+gW9+6lXrg2OgRuCVu94KND4BadahqI6vm8kb8WcbE9Ev2Q=
X-Gm-Gg: AYBFou1RFHW1QOe7vk75jueDGFRitYnKXqwJ50WYr5BZSlMmtLRjjnHzaE5Zzv8wl9F
 l5i0nEi3Q+kxHroAx5fldKHwSorDY8+eKAyPnMN4XoaK8VbyER6x5xogm4xMHvOg8PeqnwrdfQF
 cfkmG4uKxkUfr3aFra/TGA3Zs+4FeFyZJFFaQc/4WVmDuOf1kLqgxdPRyPBGwTi4pociboLehha
 wFpHZzMBzJq4UMQQiLd1XGGlWSL29LqE9r0O0l4j0TLTUGY99cVtmmL0JV7BeTe/edyJNQu5H2l
 pSGz83fmrx6L3487YzNfe0XAf8s/KOkuqihv/CbksMCNnrI/jJRV+eTwjLIylXe3yNrCXY3VpHw
 Qns7/Fk4yLb8JnhTrOIKKFA9iw9MScXz1kezGdm1yGSkHYb1GRucHYZ4E8j9Kz93U1+s+4r7e9f
 aRWvMLYht4z5lcqE0O6YcPeJlhhkST+6XSehuiPrqeLlXc/TvY5iiBBUWSocwAYmA0dTyQB5slP
 IS3NNas7fSE2yala0enQa6tNAdI+2OFDwEmLQWEZ7qVyyIh0lA8iveXRHRA2zkesNRficlJquAu
 KZ6fAw==
X-Received: by 2002:a05:6214:451e:b0:91e:8d6d:21c8 with SMTP id
 6a1803df08f44-91f2423e922mr59090456d6.54.1794599976764; 
 Fri, 13 Nov 2026 11:59:36 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23db49c5sm27322246d6.41.2026.11.13.11.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:59:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xRxQs-00000001ekG-3813;
 Fri, 13 Nov 2026 15:59:34 -0400
Date: Fri, 13 Nov 2026 15:59:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v13 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261113195934.GD2532299@ziepe.ca>
References: <20261111121602.GQ8635@unreal> <20261111224136.GA754433@bhelgaas>
 <20261112092326.GU8635@unreal>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112092326.GU8635@unreal>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:23:26AM +0200, Leon Romanovsky wrote:

> > I guess one benefit of this series is that a path where P2P Completion
> > Redirect is set used to mean that pci_p2pdma_map_type() would return
> > PCI_P2PDMA_MAP_NOT_SUPPORTED (unless the RC was allow-listed), and now
> > it might return PCI_P2PDMA_MAP_BUS_ADDR because if P2P Request
> > Redirect is clear, Requests can be routed directly?
> 
> I'm not sure the first part (return PCI_P2PDMA_MAP_NOT_SUPPORTED) is correct,
> since callers have so far ensured that P2P is supported before calling this
> function. The second part is correct.
> 
> > 
> > That sounds great as long as the Request uses Relaxed Ordering, so the
> > Completion won't be affected by P2P Completion Redirect.  But devices
> > aren't *required* to use RO even if enabled, and I'm doubtful that a
> > non-RO Completion redirected to the RC is going to work.  So I don't
> > understand how p2pdma.c can guarantee safety.
> > 
> > Translated Requests seems similar -- are we assuming that if ACS
> > Direct Translated P2P is set and ATS Enable is set, the device
> > *always* generates Translated Requests?
> 
> PCI spec allows "A Function is permitted to intermix translated
> and untranslated requests" and p2p doesn't decide anything except
> if routing is possible or not.

Both of these are basically the question we left open in the
discussion with Christian.

To use this new TLP specific API correctly the initiator needs to tell
the API what kinds of TLPs it intends to generate, and ask if that set
is OK.

So you need to say 'I will use translated, I will use RO, I will use
untranslated' because each of them can have different routing.

NOT_SUPPORTED has to be returned if the modes the driver asks for
don't have identical routing.

I forget how this ended up when that got deferred, but that missing
driver input is an important part of the puzzle.

eg mlx5 knows exactly which of the three TLPs it is going to generate.

Jason

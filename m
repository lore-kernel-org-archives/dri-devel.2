Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE665606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oohrLzyb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503BD10E100;
	Fri, 23 Oct 2026 19:00:46 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E794B10E100
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 19:00:39 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-53664b4860bso11282551cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1792782039; x=1793386839; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
 b=oohrLzybhavWg65306hNFLGadQt+ce9WiSiWT/SprBfrg0pMLfRAcpnr/cA3tNu1TZ
 1bXQ/clIf+E1/rEI759MkmrO9/XuspV5+Sw45WxSU4VwVS8RrK/VabcGwEH2pidB3XMb
 sYYAh4SQnuSuDOUZX7gWXgwqeGi3L9y+5jmbkxknjBuptfHKPtXjR/jx6rO5jQhX+AY1
 9YUCW64fuUMmo8wmlsSqr6XBPke0u6musyXxYXZgbjjeOBwWlHOE9N34PnFDoYUxHRzB
 yUSeBlBGS9Sn+my3HszyaeUQBAdPjX3lzronrEnjq9tXm9UWTf77r9JI/7LzlMq05LaZ
 K9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782039; x=1793386839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
 b=m3Hj5jBKgE+inAuY8nQBx2xfKQcoZEAE5TB6tZNemPITIhxaFvzvT590qtZ6eH5jxe
 nYPn6hD8xebfcfTtvbtn/fCbHS544h1at8/FX41Q2kEvEf/QZCe9S0O7TWMNoRPNpJGu
 1dZ789nn0NMCmFEd9/uFWZSaVuNstoMfKpNf8dP5G1kWY8TLfIfWcPEa/lVsFxkl7Mzz
 Q0CD46KF+xWBRvOCDow4I7nWuK9EoLzCZWfd0pg8FtHTxZo+f1vz0+ZJMe7smjg1+hHY
 G3W93zWFpDmFayh4N8hQA99m7YofU0Y2AKrUT1LqsvBAinyGQUZ13anwQFYCs3JW19N6
 P9IQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByy21n0cFfU6KTGAZjMN9SLbT0zZMm39nuFr2NpxKk06ocWseg6JAziD0eMxTlRAGQtazneiu/qU04=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK7ktNKa+5Gz8mZuDPNYlNdw1bMWxEylo8cCUl79pVglAtaxWzR
 IIkS8eZ4GLoZBYsodJz7TKEsVp3j/dSeEfrSr2FkdUkFN10I3yHatjwgW9Paa+YJ7JU=
X-Gm-Gg: AYBFou0aIuSmspMeGWvX03sYv2al3wwSWfCrIzgcxgiHv2JUdO/kdHOfbZN2JepUG0w
 ow7vzdxwOIeyI7WteAI+bVQKbGjYOlqHXVAmknriZUaG1iFmjxeHicZT8RE6FZuMgMcmNdDg8g0
 CCWY1TSjs3w+XOi2fb6Bmk5I+t/YxkWf/0kbeVeVKXXjkYVi8cw5r57zGf20diikXgHW+tJG6UB
 dU2ZHFgrsIGnvpsPHOtubYqZtl7NXyT2KLohy5L0L6seDOFqw90JJMO7riQUhi/c5b9mJ4GwyBQ
 yCNMNYwcUkLHG/K+GPXysEAUM9sup9YS4n2qT5lc8/atvFLMN4RbgbsnLiA9fzK9RK8TdhJppvG
 n8wH7RJ/UJPKLnFOV8Jpj/Dx0eke9ya5FU92q+rQij9yqL7lsZy+ZpZCVMA4ZchBR5ZSu58oJZA
 SyImLP/dTkb65qaTqV0t+GIDsg7+U52hwq4GS/LMzMb1rxYoPTGTqH+L5GC3WXMUUNqhkWpGRZ4
 4jL/dYi2ws2mPbu/vLDmuGguTnhry88Py1W6W6BuMQZIAFM6XinnbNUVmf7eSdXr12Sx/e2pk1W
 Aj1GFMaGGvoZkxcEZayYLeFWBi7WFc2nf+q0lA==
X-Received: by 2002:ac8:5d8e:0:b0:535:a5f9:7520 with SMTP id
 d75a77b69052e-536c26e2168mr47897061cf.63.1792782038589; 
 Fri, 23 Oct 2026 12:00:38 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53839709ed6sm1185741cf.16.2026.10.23.12.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xKKVI-0000000GxzN-4BG5;
 Fri, 23 Oct 2026 16:00:36 -0300
Date: Fri, 23 Oct 2026 16:00:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023190036.GL3977851@ziepe.ca>
References: <20261023155914.GK3977851@ziepe.ca>
 <20261023182715.GA2798722@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023182715.GA2798722@bhelgaas>
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

On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:

> > Yes, the ACS combination is selected to avoid ordering issues
> 
> Does a user have any way to know whether the configuration is safe?

No, unfortunately in PCIe so much is really difficult when it comes to
deployment :(

> I'm wondering whether users might use "pci=config_acs=" to configure
> ACS so things appear to work as they prefer but may not provide the
> ordering guarantees drivers depend on.

I imagine that could happen, but on most practical systems the root
complex will blow up if you do asymmetric routing so there is an early
indication.

I know this because I've help debug such configurations at
customers. Some servers helpfully MCE if you do this. Lovely.

> If that's a possibility, do we have any notes in dmesg that we are
> depending on fabric behavior that the OS can't discover and verify?

Maybe, it could be interesting if the P2P logic found asymetric paths
it refuses to permit it.

Jason

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E82609DCA4
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Tikr0cJj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F0F10E26D;
	Wed,  4 Nov 2026 19:56:56 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8FEE10E26D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:56:49 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-91c791d5460so14168776d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1793822208; x=1794427008; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
 b=Tikr0cJj2+I0rlNhZrrm+6hXbv1xcZJ6kWPBDFjLoDgC5pzOkx4J7oR11/TQkRq0+L
 xezn+E/ZmTFKxN2lFt0JmEY91J2bNg2j/sozRwMBmJnipSYZQog5gYYWpx+HIqI9kRRH
 d5xvN/3yd86Nk+bqkixqc0LwVUN6kbRbP8ztYNVbMd9gLDwKFvb6PHjelo2BTWelEIcC
 6kGtGj2UETw5c04RlgZ/dSTXwfhSBej5kjlZuHw18ykFQSK1lGEahUIP/EMmdwdha7nh
 krORa5gsPT2+HQVlAGK318+nNXWenM5yUd8jmomeK9fs5Ll5gqREcYDgz0uKOmp2ScCC
 o83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793822208; x=1794427008;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
 b=KMhwR2MZ6niHRUIXIV/DObl/B3ZYxP9lmDNUViMRXhUu2MBX02Rrs6IpesL4/+aZoe
 h1FbZHsa6gl+1Axb0yIa+2pYYHlg524Tnxra+ZBN+HsdicLE/zKowZDuhudLM7sWWa6/
 inP3bNEQAIZLHFm1AFpz8QI4mQ4LbZS3RkTej/nDaSo8I9QkqfYloxgafkQvLR9Kvohg
 9LJ1ykhDbR+cE2A1YaTF3ZoYCyhj3BVZWiu/hcBhGJWCaL+y78tYpTs/NZ5WTPG9Ry07
 AwUr65SXNMnvsKw/bUwCH1JP6LlTPpvrUoldrNVoP5mqOmayOlc8OQj60FZ7JcxdHApU
 RYvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3EITXEd0v5+jnzWrFjBQcPVMhsib0WKzg7TzKjqhDLzZL9Xve9bmRlv9PWi5IETRGDQVUFKXDEcM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yYTPr+6+DkD1t12wv0JmAnMPiUpUboPw3stT3nS5jbZJv4i0y
 7qVqH3DL+wGdyo7EF4MgfnQRm2oUJduaSVCTljujFK00gxK6NNDA8Poru1oskE9gQNc=
X-Gm-Gg: AYBFou0t0/j3ZH5j8GFu/MxKy0/5PubLaLxoTxyucSaX9DfXQ4qrSlv7mTnftNIyJ2G
 waUCBcxLDt2N7K4k44B2vypNlkuFXTGi1y4Si5Z3i0aMgwhKZZGpO0uuqnktUlt5iK7Qzz6/clT
 0W8EFQhM4v3GUNjOAZThAKqheZJoY5NBbtUwq0cJx/LIeeV4VJecN/78PnW5c9UVy15VFcQ6IUr
 zzg+Idi/OSwRLONpAPYCX51MV1DQPE4jRuVPFusBSPLLc+0c0JwgR9WmBEP2ao6G0PK5ZS6Oe2L
 pq+Yt4UdG2BIjWjCWoV6UdhkdBGxdvTC/2EkRlfmWIO19bE48n53cdNZWrHfvWHH9uSz5B25j8w
 hi66YYz5ppqSzqaLXzG0EIeHsmKsQDqlQ72g0XJ3YY5XqqpgHQ79CRqXOiXjQUzxR8aUs/eMeKh
 d46IpcKgbpLkEMpBVjtQopReWVoi0qzTcPllN6r6nWWcm7fou0lsk85W8VQDOtfWRoGNqfVMr1x
 A0se4fFxNS5fhxO5h30hGYIhUDNz2yw0h8s9rQROn6DMTGLlJHZIKJDFskIpPGDAtbK6Ijpx5Bg
 aZdRkKd1AsVELUmSFiN/XJFfQL+AFpGDbTlqCOkMbMuXnZAzrgL/vyJ2dAxniZbakH31ydIWJOm
 6SeLm1ClvzQ==
X-Received: by 2002:a05:6214:2dc2:b0:917:9cd8:f26f with SMTP id
 6a1803df08f44-91ca4b1b1afmr281180966d6.25.1793822208495; 
 Wed, 04 Nov 2026 11:56:48 -0800 (PST)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7e7b1e92sm27199686d6.45.2026.11.04.11.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:56:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xOh6F-0000000HJlF-1F1D;
 Wed, 04 Nov 2026 15:56:47 -0400
Date: Wed, 4 Nov 2026 15:56:47 -0400
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
Subject: Re: [PATCH v12 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261104195647.GD3889730@ziepe.ca>
References: <20261104084328.GP264423@unreal>
 <20261104171412.GA1247928@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104171412.GA1247928@bhelgaas>
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

On Wed, Nov 04, 2026 at 11:14:12AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2026 at 10:43:28AM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 03, 2026 at 05:37:42PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 03, 2026 at 10:29:39AM +0200, Leon Romanovsky wrote:
> > > > PCI P2PDMA applies Request and Completion Redirect throughout
> > > > both paths.  This misclassifies asymmetric and nested switches,
> > > > and reports one answer for every kind of TLP.
> > > > 
> > > > Three ACS controls act on TLP attributes the Requester chooses
> > > > rather than on the topology: Translation Blocking and Direct
> > > > Translated P2P act on a Request's Address Type, and Completion
> > > > Redirect skips Completions carrying Relaxed Ordering.
> > > > 
> > > > Evaluate each direction at the path divergence, decide every
> > > > class from the one walk, and treat a client with ATS enabled as
> > > > translating unless its driver declares per-mapping ATS.
> > > > 
> > > > This completes the P2PDMA side; dma-buf and mlx5 follow
> > > > separately.
> > > 
> > > Is there a one- or two-sentence explainer of why we want this?
> > > I'm thinking in terms of what Linus will want in the merge
> > > request: a fix for something that's broken or some new
> > > functionality.  It sounds like this is solving a problem, but I
> > > don't know enough to translate the nitty-gritty details to the
> > > higher-level user-visible problem or feature.
> > 
> > Not AI; these are my own words with grammar fixes from AI:
> > 
> > "The existing implementation of PCI peer-to-peer assumed that all
> > PCI TLPs were the same: ordered and carrying untranslated addresses.
> > It did not account for the variety of traffic types defined by the
> > PCI specification. As a result, only simple systems supported
> > peer-to-peer transfers in the upstream kernel; real-world systems
> > required out-of-tree patches and careful platform design.
> 
> Can we be any more specific?  E.g., what makes real-world systems
> different from simple ones?  What does careful platform design mean?
> Something about ordering beyond what PCIe requires?
> 
> ACS P2P Completion Redirect affects Relaxed Ordering (RO) Completions.
> Translation Blocking and Direct Translated P2P affect Requests with
> Translated addresses.
> 
> So I assume the existing P2P implementation breaks somehow when RO or
> Translated addresses are used?  How does it break?

Let me try, something short for Linus:

"Enhance detecting if the PCI fabric can support a peer to peer path
by evaluating the full bi-directional fabric path over each of the
three traffic type ACS controls. Expand the number of fabric
configurations where the P2P algorithm makes the correct determination
of support to include non-uniform ACS and situations where translated
takes different routes from untranslated."

Jason

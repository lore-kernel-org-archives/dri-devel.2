Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13A606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oDrdzggV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E92C10E6E7;
	Fri, 23 Oct 2026 22:01:59 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE8610E6F1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 22:01:52 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-93f1cf92c9eso150978185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1792792911; x=1793397711; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
 b=oDrdzggV2zqyl1xxCdqC/JnLxRjQ7+qzOhl3JdnRuRMEmcuj0A9iGu2MaMPBi88saD
 Y1gOaetkATp96weMg7LUE3Y980BLQy/NI1nQdo9bCWbSmNYUBpEvP6MNUoySSLthiCk8
 uNeWkbKYtetnRPGbb4x1Wm+KG79rD1Mi7J6FXxkFt1JyxlTwZNiRAZCPlREkCDWNyz3n
 bjuDclbUMqzyyDzMTRtnu82zESQa+aU3DHi7QSP/VXq+0yTe39ppoLIhR7YqWt8KEP2V
 4iCF/4jYER10UlEhCmMNalz27tuoAfvmiw0vkqrHbu1I+/jk4ki1DDPrlVYjaBN7SKT8
 CRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792792911; x=1793397711;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
 b=0KbonWp5PR09tzbVnx0gVqUdIh/baR9+NPM5Y5LXDtZFSCWvrbnPSiFF696quN3xUO
 ioVs+WL2RNKc3yrRgmG5hkl54UJVmEEsrl8MDDgnwEDiQjiHFkTZgIQaVBc6H/00++oM
 8zJFZxbn7AGgd2U5JyDIW2fxPFj97RrHt9zWy3mDHXBC8YPfYoy6IrEZDt6Y2RZSZhjc
 CYNkTvZy8tEqtBRMnCcQCb6WD2Zjuj1qQLke6MG+m525rNfJxWL84a1K5o+4EfBJ9b7b
 iiVtZXjnICn/FgAOZyDXLt7xfGrlKXdDjyjYLzd1b1SSV2y71rX+Q3AEUgW+Uldgkkdh
 KtKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf8wwIudWB6GBvHvkPuifH5bBFCy/8z6tfgVCjWyv3k2fpKEqTxGAs/NbS+nu+gCjEeVcdkkjIcGs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbK1w5e8ZBu8/8i2GGDZl6vazQU934qscARARYxzHytcIV44Qm
 tcOnca1l6ePLpJkrqhN+Yn7hxeU6BYMVAw+t/7cjueBPAXprlveHB2c/6l05vlFHP2k=
X-Gm-Gg: AYBFou2DI8/IDeRDlwWJjp8zWpvMr1uU43TePHHlKrOL4jUaAenAEW5jxc8Z+idkO4E
 V69uLb0CO5KdgUK1jq+95dWPAeIMAJT5jNKUHf1NLsaENzBq0yD9ksxmNZslA8c0x4P8lc8FuQJ
 LF1o/5ebnutukRvQ+c+mXB+SQ+Emeu4iBI/m15dekGDwiI7CViDJ5DWzM/RvDWxn3ae3B9P8qjs
 0CG/ZDSULpqCCx2lfXhtoX2bA2ngBTVTD62HutpQJoIbAAfHbm/B0XBS51XlxHytnWdVH65vavl
 f2/bY3O4bWJ7Kv+UQ7+azC8WBPrs5IqH3dgSY75g4e77Z/pLMxXiOjwfrrM9YQujtrGVs66GLCI
 SujaQMk1xAHX6c5UxgFCPgQUK2ODwKZWn5NcRUaAN/All8liDypn/AdRem9xruEutlkV/2TI9q4
 6UwxtW74eKdPE34QpIErjtQ7Sux9b0Zr5tptdapxbZ1rMyMjooD/JEEo/A0Gy7oyJae2nTGT74u
 QZemAWVH4axV+dKD7HllMwJXWaoRSU+eLBHlm8xSD2MhL3UmZeaQEdAmpUV6pp4Cb3epd9i2443
 kRioaEf93Jmvc70UToqFsc/G0suCFx/I8KiJ7g==
X-Received: by 2002:a05:620a:4441:b0:93e:c12c:f137 with SMTP id
 af79cd13be357-940ef9c87e0mr54142985a.82.1792792910841; 
 Fri, 23 Oct 2026 15:01:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f078a762sm18520585a.30.2026.10.23.15.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:01:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xKNKe-0000000H7Vk-3jIV;
 Fri, 23 Oct 2026 19:01:48 -0300
Date: Fri, 23 Oct 2026 19:01:48 -0300
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
Message-ID: <20261023220148.GN3977851@ziepe.ca>
References: <20261023190036.GL3977851@ziepe.ca>
 <20261023201531.GA2805244@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023201531.GA2805244@bhelgaas>
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

On Fri, Oct 23, 2026 at 03:15:31PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 23, 2026 at 04:00:36PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:
> > 
> > > > Yes, the ACS combination is selected to avoid ordering issues
> > > 
> > > Does a user have any way to know whether the configuration is safe?
> > 
> > No, unfortunately in PCIe so much is really difficult when it comes to
> > deployment :(
> > 
> > > I'm wondering whether users might use "pci=config_acs=" to configure
> > > ACS so things appear to work as they prefer but may not provide the
> > > ordering guarantees drivers depend on.
> > 
> > I imagine that could happen, but on most practical systems the root
> > complex will blow up if you do asymmetric routing so there is an early
> > indication.
> > 
> > I know this because I've help debug such configurations at
> > customers. Some servers helpfully MCE if you do this. Lovely.
> 
> I'm still confused about this because earlier in this thread, I
> thought Leon said you do asymmetric routing:
> 
>   Bjorn> And I guess asymmetric fabrics must mean fabrics where
>   Bjorn> Request Redirect and Completion Redirect are not set the same
>   Bjorn> way?
> 
>   Leon> Yes, in some of our systems, deviceA to deviceB is going
>   Leon> through different route than deviceB to deviceA.

Yeah, that's what I clarifed, it isn't quite accurate. The asymetric
routing is between Strict Order and Relaxed Order TLPs, not
request/response.

Jason

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C04606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ElwVowt/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A017110E0E0;
	Fri, 23 Oct 2026 16:00:04 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B74010E0E0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:59:16 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-5364d86f7f0so10698801cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1792771155; x=1793375955; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
 b=ElwVowt/XKmH7sbi3qv8BTYpUHce/dox1GqhHjDi1nqdwe5E0cpgSpqDzkZQQcHn3X
 f0BE+0aDIOJyrW0QcWUhSreWu1JwoD/eKey4aPwF6/uV1pUk1Bu1ZfGWRuU4YFpetyhB
 bjgA+PWWMmiWBwdXbBlhQLck2pL1Zmbcs5q0rBlogC9np1iT6ORMbrsrvOFG8nVxenji
 tCvpPOCccr9FoRgqlsLtwAjtBprG+fkS2LyGqATAjhzQR+9i+4zh2ahNK/ZT3xKvEAsm
 h2XRQ4WKI8fKavYdFVm+iW0bL0u+gxBZ4sRIn2I7mr6boF5H1NVXhw8TAqMMEOTMNcwZ
 CenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771155; x=1793375955;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
 b=0aM7dghjeoUfkRCz2+Xvg8Z9wLgmk+m9DYRXLWQP0nhCfTHFyC3mbb5ZAC0ErJh2nF
 rTkHo/1N2BlgngXZaEh5YmycAPmw1Mn+V+JZSarpDYOVxzZWKwhtbqDdgZRLB0tMz2tG
 e5DJ/olIOn0l5mzVpWKrsvdFKDsIm6fP3Ujvs5ZxMZlw8ZMxdwjozw/JsOYqSbn75Yz8
 +1DQLgr2Sm7xQ73IKi5lEoSyOZrvWmMybZlu+O7SHlQamJY6+R/UOogBw8ay7LZlkHw4
 t+EyNlt4X6Xtej4ad3D0DXH3YLD309ckE/MI2IBAeoAmz1zHxkpHtoi+YNJNUUE74CZB
 G4oA==
X-Forwarded-Encrypted: i=1;
 AKwUvByq27yUeZrjuyZJrG1esAdgNE1+5Ad0oD5UiBIBLwnazwIMyB+2WXAhe5mrTLKs09/ri3zGZME9lLU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLBAk+AQQiMSEEnijfQMrnSPwpbcARmq2Z54h6jaAoLfodMKpTu
 PZKKb/YLXsRe0hBIXDUZHp7MI6lUtiZUOOaiHhgyFbMNSs3l5BJCPAfsTzzsNjWbMnk=
X-Gm-Gg: AYBFou3yG1e8aQbUtOuLT6vH5SjRM2lv7YZ+38vN3ZAeg/CbDYwdfhIUqZS405v9XxE
 Vus1zrEBvUevrFk7Kn3Paj76BZtZX/bJ9RrALWKOOUAd3PgzVxGKaM3uYjn7nDA6trrQ+/gpwyi
 Kwssl5k8VEH3bfjzhhae1MBuuOTr2713GavYWvH7OUJA85TFntOlKm4cU8eudu+0EBlfkLKDBi/
 NYnKuchD9aO+0gN62Ht5zdxxpQRMrCIR2XJIUDxEz47l1b62CyDlxdGustS6os6gG4TpHU4QsRU
 bSE8rp7rxFcXUC3Cdd+yCouTUZljPP5uVFQl3yN5oc6NfPATsftgzpIR8tsweI5ZDWn97g0VWmb
 3YcplGJYrzpp2DDEbYwupx1ENcQ+bQkBrsz5R+h+3MwPjz7FQ7JRQxe9BgqJJJgv6uySKZXmRWE
 gef+Xv5CXC15yaF8FD17AvOqkyo+UVLGEFWflHQkl/v70o61lqLLBvbC2qYr7NbSLGPNuVjujmo
 yr550G9ObMedTEUUh7QCVK4ZsCCvn1oJEGWEe7Va+QCCJWNucGikR0HyOBwNULqT3LAO1pqWSv9
 qpFVn602ZTiu43RYy+mf7VPzZnW6AF+uENQDng==
X-Received: by 2002:a05:622a:a0e:b0:535:859c:b6ff with SMTP id
 d75a77b69052e-536c24e2452mr39136051cf.20.1792771155235; 
 Fri, 23 Oct 2026 08:59:15 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53836c78f67sm656181cf.27.2026.10.23.08.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xKHfm-0000000Go19-0EMi;
 Fri, 23 Oct 2026 12:59:14 -0300
Date: Fri, 23 Oct 2026 12:59:14 -0300
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
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023155914.GK3977851@ziepe.ca>
References: <20261007063227.GC7822@unreal> <20261007204045.GA783967@bhelgaas>
 <20261009174301.GC11438@unreal>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009174301.GC11438@unreal>
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

On Fri, Oct 09, 2026 at 08:43:01PM +0300, Leon Romanovsky wrote:
> On Wed, Oct 07, 2026 at 03:40:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 07, 2026 at 09:32:27AM +0300, Leon Romanovsky wrote:
> > > On Tue, Oct 06, 2026 at 03:49:47PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Oct 01, 2026 at 02:55:10PM +0300, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> > > > > interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> > > > > direction can unnecessarily force P2PDMA through the host bridge.
> > > > 
> > > > Does "the reverse TLP direction" refer to Completions?
> > > 
> > > In general, the P2P code treats TLPs flowing from device A to device B the
> > > same as TLPs flowing from device B to device A.
> > > 
> > > However, in the context of this commit message, yes: completions flow in the
> > > opposite direction from the device's perspective.
> > 
> > And I guess asymmetric fabrics must mean fabrics where Request
> > Redirect and Completion Redirect are not set the same way?
> 
> Yes, in some of our systems, deviceA to deviceB is going through
> different route than deviceB to deviceA.

It is a little more subtle, I think practical systems try very hard to
avoid that since many host bridges do not like seeing only half of an
exchange.

What we end up with is Relaxed Ordering and Strict Ordering take
different flows in the fabric.

> > But I asked about ordering because it sounds like this patch expects
> > to encounter asymmetric fabrics where Request Redirect and Completion
> > Redirect may not be set the same way, and the spec implies that
> > asymmetry may result in ordering violations.
> 
> My guess is that the hardware and system architects have ensured this
> doesn't happen. At least, I haven't received any complaints about this
> series during internal testing.

Yes, the ACS combination is selected to avoid ordering issues

Jason

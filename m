Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E25CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6863A10EA97;
	Fri, 12 Jun 2026 15:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rJ5/kS37";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC4C10EA97
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 15:17:31 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so130675ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781277451; x=1781882251;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TlOQuFqEcpnxb6HFkKMVShmOdVTUgHEmVlFieGLUVKw=;
 b=rJ5/kS37VJcYGhASzAad/u1PMhVT10Ld+tNchtO1in6Ql30t/Z4G7qIzxMiTkUkfYA
 a/BSXFZTcAB4HUUsm+uVYn3pn+z9KHOVAD+STanDyK4Iuh3lq/si7sUEXjH0uWKYa44p
 7H/2LvNL6DWR92rutlnq2HcpeqcXqrJt8DTUlsBvqjxoDpgCrlb9oL6dG+cPE0frOPoy
 cy3zG5UdMa3H5FJJ/Vuwuj0duYLZAIi5dGEPq903K8ZZbxR3U96AX4gnQFZ/88bYkXuF
 mLeLf5m08oE6ZckXr2fqDhpG4k8vDn3NHHxo/5dDHVMvx1oZaZgUl5dSrMrAyb4ZzQUS
 if1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781277451; x=1781882251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlOQuFqEcpnxb6HFkKMVShmOdVTUgHEmVlFieGLUVKw=;
 b=dqiLcl6LkeRdh6CGp/1aVrOAA8l6UvabIA0ggnqmT+5HlpAJTigtrEfnYzK6YFmSNi
 mif1jMuXdsBk3AGBB29ljWIQR4/LpgcfkD82+9hGXtRpwL+cpCbCqKit/EbXo2RPQEU3
 TQhS9vjy4LM84VIiHPUfMYC/2roOt0M7tT0ABYsyxSjruMDkW94VlMdIDdEJpd5bVQk7
 ts1wQnXmrmCCh/pFEO+8s7QRyvsI0GUsFnqgjnUgmXQ/Ggz17EVN/056GgRD8qvTxwcH
 JC5A3wd86M+Ho3ZHhJJ6T1ZxyknQJROTskCIAKKpQDX2EGxSxnaHN/sy3aZfo4YjEC6G
 6FQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dAAOkNOjQ2F9qTFD4la5QOug7YFSIKNaiUdpLgjVIWY58Asx4sIBevr93Xe4l6ZIJAeMvxUkvpfU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaIw7LRusfGja2Ym9QN/kXoLvX3L5pZMc6l4Wh0dgzBUM7+zza
 1V4X1QZx0cVwL25jot9N9C1eSef/Lz5KEOiZ63aZm3i3ikZBoKThSj7ubIHhyf0BUw==
X-Gm-Gg: Acq92OHJ3WTWCdvSXq1+tCGqQXFLUM89D9o6zCoDtsebDuURMbeZuw/0s4ZDPa5/BoW
 pcwZHb2dnoLAYdgSvbv7sGCkbw7xs5czKjqshuKtV2U1GXJ0R8nDe+Na014q/U60drb/cmtu54s
 W73H3t/Ii3faj4DkAA40GmGyO6jCIR7lTGWAIFzp9qHye0drGmyE6koq1cbUYXmJdZFYK0RqxFq
 LMbVQY1rGqLLB48xKBwZKyxuOUqE2Y/9iwJO7HYDGK/5+aTCoSn18iyDW0lh/L5RbkeOdYwrs9o
 kEGxBTS2wCQ9f9MB+quU0ENu9U72U+/pr1EojfqMEq+Ae9CoP0LttuVBIb84y2tEjoeWRaL1TCD
 BzGaCCZ8AdLlkwAMwMTdJISsL1QR8c+8CLNuVFRmnMPq24b1ABf9hL9lNjoSaoE99Ifrl+VgXin
 CYrS7LoXAje5SKuourqLUzdvM1gAYCHABxwyFUAxQpumeoaDSf3EMKdvUIkS1qfRpCk0ByesU=
X-Received: by 2002:a17:902:e805:b0:2b2:70ba:305c with SMTP id
 d9443c01a7336-2c3e1160718mr2635095ad.8.1781277450033; 
 Fri, 12 Jun 2026 08:17:30 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4328a4c14sm22623545ad.43.2026.06.12.08.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 08:17:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:17:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <aiwjAbFVhPkkj-6U@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <DM6PR11MB3690A65EA9D8A9B77AF93E198C182@DM6PR11MB3690.namprd11.prod.outlook.com>
 <9812ae0f-8f22-4d62-a706-4c7232a5656b@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9812ae0f-8f22-4d62-a706-4c7232a5656b@ozlabs.org>
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

On Fri, Jun 12, 2026 at 04:11:50PM +0100, Matt Evans wrote:
> Hi Kevin,
> 
> On 12/06/2026 09:27, Tian, Kevin wrote:
> >> From: Matt Evans <matt@ozlabs.org>
> >> Sent: Wednesday, June 10, 2026 11:43 PM
> >>
> > [...]
> >>
> >>  vfio/pci: Support mmap() of a VFIO DMABUF
> >>
> >>    Adds mmap() for a DMABUF fd exported from vfio-pci.
> >>
> >>    It was a goal to keep the VFIO device fd lifetime behaviour
> >>    unchanged with respect to the DMABUFs.  An application can close
> >>    all device fds, and this will revoke/clean up all DMABUFs; no
> >>    mappings or other access can be performed now.  When enabling
> >>    mmap() of the DMABUFs, this means access through the VMA is also
> >>    revoked.  This complicates the fault handler because whilst the
> >>    DMABUF exists, it has no guarantee that the corresponding VFIO
> >>    device is still alive.  Adds synchronisation ensuring the vdev is
> >>    available before vdev->memory_lock is touched; this holds the
> >>    device registration so that even if the buffer has been cleaned up,
> >>    vdev hasn't been freed and so the lock can be safely taken.
> >>
> >>    This commit makes VFIO_PCI_CORE depend on PCI_P2PDMA_CORE
> >> (commit
> >>    1) to bring in (only) the P2PDMA provider code.
> > 
> > the last sentence is stale as the dependency is now added in patch4.
> 
> Right, will fix.
> 
> >>
> >> End
> >> ===
> >>
> >> This is based on VFIO next (e.g. at b9285405c5f6).
> >>
> > 
> > Sashiko failed to apply this series. Is there dependent work in vfio-next?
> > 
> > otherwise getting a Sashiko review is helpful here.
> 
> It _did_ depend on (at least the context of) some fixes in vfio-next.
> Looks like it'll rebase on master now those are merged.  I should've
> re-checked this for v3, oops. :|
> 
> (FWIW, I had Robot Claude Opus 4.8 to review several times up to v3.
> But I agree, Sashiko would be interesting too.  Can it be manually
> triggered with branch guidance?)

I guess relevant steps to run locally are here:
https://github.com/sashiko-dev/sashiko/blob/main/README.md

Additionally, we can try providing a base-commit (which points to a
public commit). 

Thanks,
Praan

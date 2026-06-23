Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77FCCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B00010EAEC;
	Tue, 23 Jun 2026 12:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jdK8zKie";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE2010EAEC
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:35:29 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2c6b7bd4e8dso45855ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782218129; x=1782822929;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zrUGuQC1RmyduYSJ3/JT9tG3Cdq2ls0SnT0GavGxSKw=;
 b=jdK8zKiepKIff9yMtVgieinhjMo47XvJpDUgYsXMVY7h6a/hOU7jrB9ukWblHiN/yC
 lF6HYU1P+OQJG0Bv8NMWwkVCLjrWMFum5uwi1uFkpEB8RPWqtYY+MHtTfCvDMp8bQL+v
 74k2QYTGEGyfsOnbIbjHyK5pMGDolT6aaPBJ/rd8ll16IHPnXbHmVJpwfi0Jdmqtjkyw
 af+aO5xijIdnHk1K4wKUbNsmByljnhoZzRs6TnOPDK10wuBia93PAP30nsD52JlxqYP/
 XSkTS3CTnbNvn5Fo7qn/OvKP83ZQM90+Ni+QtfRCMZ7NqEvBJN9Y+BgBYT7TjkdgFA0g
 MEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218129; x=1782822929;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zrUGuQC1RmyduYSJ3/JT9tG3Cdq2ls0SnT0GavGxSKw=;
 b=gUZgMJ+9bhDfCDtTncizSsiRAmCMifKSL+DGxksyXh99VzNpnzClSFYZ+S2DZdt0Xw
 jNoTbjGJQai9Q3zdAsVX6KervAjnMZSe8PBAR9lc80C3oHeJX4tUntD4Zdn+qXqRQQoc
 2L5Ibbc69+t8amkryenRlHuduyiZw7zaN6CfBzoSG29f+YxZTqano9C1NItN5aCMNNeI
 hAnRSdYSbmaiitfzf4lrLS/CMbQNQ9wZ4aBc2IIiGdtlQHUEf5QnE02NKVoljPCSqROW
 dV4dvEYMXVU2C4qNfybk91llbSglF1e84BepfSSIEO4tNrLQYd3b7VP7TanXIQ9aXKlz
 fcvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxFIL6BwkktxCZyjA78QJwO7AgJ/D1BaLQM83ZFJ5UWFaH7INZ613duVjkOqEXFdWkVLreeqMuK9g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3M2QMaZIvrRMUa9SvG3TpiqpqmOROdtXHDGlqvBf4tvWdyrYd
 d9lMdT+RH7npioScDVG1UnAmkOc0TSwipftCd/QXm5FDO/H8hTrJAtZWbrg+XJ8NYQ==
X-Gm-Gg: AfdE7ckIGQGgO40JA5/WeliXr0l33ar1bmH8n8iyhzSUOCYnFlcacXoIzfD7ASLpLCn
 3cKa5rpZ4KZ9pbYHVBW9+QgQJmqwS0n3H9E/q7RJNS3VjhzXku/WitwSRtdD4kqUvbRC2jgB7vF
 jzn9pppsQDhyMFR1qkpGBTjOFpZ8e4om5zAuD2M+qN7dUkO+kq/cqnUjNF5kOu3jTkt/oJdamRX
 jqoWiu/KbH0RrlBTcXBn90P6UJxXJSIUUGz0OGXTjONU9ItHuSNwkGaWlub6kfNLw6k/vCdpY6p
 8FG97B8BP3Mk6qal1uuABl5m0eKQ00e9BztzKjfyw3dCsC1kdcuB0aPTXRXJbKDFIBheZXlS/YW
 A7iGiXGOVOsjvYRTJU2cAQS/KNjUEvWevWrIcF03fGABMNcdFpmqrKql9C5rzZytmze+DvMTIMv
 oD1mp3e2kbVAca1T2qD5KLORmGqYSrXBqPP7CMBq6MkQcyRRC2Jg==
X-Received: by 2002:a17:903:2c06:b0:2b2:70ba:305c with SMTP id
 d9443c01a7336-2c7c5030b6emr2113265ad.8.1782218128496; 
 Tue, 23 Jun 2026 05:35:28 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7444aad83sm105841775ad.79.2026.06.23.05.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:35:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:35:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
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
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <ajp9hwIw657qxji5@google.com>
References: <20260610154327.37758-7-matt@ozlabs.org>
 <aixgZQiBQKgS7yIM@google.com>
 <DM6PR11MB3690489DB5FA611413BF60558CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <ajGbRE3WWJxNxcrg@google.com>
 <BYAPR11MB3687AE280241C9E00B46FCF98CE42@BYAPR11MB3687.namprd11.prod.outlook.com>
 <24f34e59-7c3b-4b56-83bf-cb07e3f369a6@ozlabs.org>
 <20260619133116.GB278945@nvidia.com>
 <55ea7422-08d8-4c92-aa59-8ff6f9e9d781@ozlabs.org>
 <20260622171336.7d13f548@shazbot.org>
 <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb2b1a6-594f-48eb-887f-7cf0cdd4c336@ozlabs.org>
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

On Tue, Jun 23, 2026 at 12:08:30PM +0100, Matt Evans wrote:
> Hi Alex,
> 
> On 23/06/2026 00:13, Alex Williamson wrote:
> > On Fri, 19 Jun 2026 16:13:17 +0100
> > Matt Evans <matt@ozlabs.org> wrote:
> > 
> >> Hi Jason,
> >>
> >> On 19/06/2026 14:31, Jason Gunthorpe wrote:
> >>> On Thu, Jun 18, 2026 at 05:02:58PM +0100, Matt Evans wrote:
> >>>   
> >>>> My understanding is that the sequences above wake a device that happens
> >>>> to have previously been put into D3, and AFAICT it could only have got
> >>>> there because of a previous vfio_pci_set_power_state().  Seems its only
> >>>> caller is from the emulation of PCI_PM_CTRL using
> >>>> vfio_lock_and_set_power_state(), and this zaps/revokes BAR access before
> >>>> a transition to D3.  Similarly, an attempt to access a BAR via an
> >>>> ioctl/through vfio_pci_core_do_io_rw() fails the D3 check in
> >>>> __vfio_pci_memory_enabled(), and besides will try to take the memory_lock.  
> >>>
> >>> I thought the general design was the bars were made inaccessible
> >>> before going to a low power state, and remain inaccessible while it is
> >>> in low power?
> >>>
> >>> So the order of D0 doesn't matter. If it is not in D0 then there is no
> >>> mappings and zap/revoke is a NOP.
> >>>
> >>> If is it in D0 then it doesn't matter because D0 is a nop.  
> >> Yes, that's what I'm getting at. :)  If it's in D3 then BARs are
> >> inaccessible, so as long as we go into D0 before the DMABUF move, the
> >> order of the zap relative to the "go to D0" doesn't matter.
> > 
> > I believe this is correct as well, but importantly we cannot assume
> > that a stray read or write just returns -1 or gets dropped.  This is
> > exactly why we have such hard protections against the user accessing
> > the device while it's disabled.  Not all platforms, even within
> > architectures that might otherwise be considered lenient of such
> > accesses, consider this benign and might escalate to system level
> > faults.
> 
> We are in enthusiastic agreement here.
> 
> > Let's be careful not to frame this as "the access doesn't matter
> > anyway", the answer is instead that non-D0 devices already lack any
> > mappings to access the device.  Thanks,
> 
> I agree that is not the right thing to say, for exactly that reason.
> (For avoidance of any doubt, I didn't say that :) )
> 
> Thanks for confirming the behaviour.  I hope Praan and Kevin are
> satisfied that this patch doesn't cause the issues they first worried
> about (the changed order of the zap relative to the D0 transition
> doesn't have a detrimental effect because of the existing inaccessibility).
> 
> Alex, I'll post v4 soon, but if you have any comments in the pipeline
> please shout and I'll hold off awhile.

I think the discussion addresses my concerns. I'm in agreement as well.

Thanks,
Praan

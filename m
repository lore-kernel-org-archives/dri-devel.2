Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EA1CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE98610E2CD;
	Thu,  1 Oct 2026 01:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PCUrdfja";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04DA10E2CD
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790816916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
 b=PCUrdfja9Myxjs1BzxdFMAu5mLvh8EeN6fEonAzbDQlNZ3WlH3jqAzy1DdgbIZD3nfSNaj
 AQBiMwsFFIet2pMTr8OZeUcMZiXeZYUV9wKLTaY0GpRSYMLNfkkqOU0hsS+tpvHvnvluJ2
 qEEV1acqBrzPDIOTQL19NCJS0gures4=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-MKIdnt8aOZ61f6Yx7VZ2pQ-1; Wed, 30 Sep 2026 21:08:29 -0400
X-MC-Unique: MKIdnt8aOZ61f6Yx7VZ2pQ-1
X-Mimecast-MFC-AGG-ID: MKIdnt8aOZ61f6Yx7VZ2pQ_1790816908
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34344599f01so6290765eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790816908; x=1791421708;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
 b=Xd1iZ0zm4O9SXla8rRD+MGaBrTjOSWyZY409zB866hHyi+/sR4T2/IF/QD4WBEkADC
 htkl+se6Va3jn34oNSxAha435+BT6LP5Esc+6G8v/ItRL5jgynkwUGHfjWypE8VIhjvq
 NRLdoc/T82TKQXNGh6obhNBBG4wWZbXCL1QFQ/2n3K2A8IL7u1CFsfoTgr9FZPzKwo8z
 4sSepn9HrtSAu/GzQSqAojSTeUU0jpBXo3/LmGMNWM0xlIA4WX6hhFySd9lo8l5iC8AG
 BrocSp0yVRxMyk5Al1ZH/9IMNFJKHgVmRplDQdNgXRq8OH+d2IqWhpuR47+zBS/y6SMF
 /FgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+tOSKl4dtr907t/sKe32P7RRIAXhww2dDOqCgz2Rl1TxWfHceiyjSIgt1Xt9FUsBSSYxfhHTVM+0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5TjMq4dgR7hYw8zL5hMK5vUfqfbVcoqaZIKY0Ze398G1+o7b4
 3i7IOoPNoQ76O9fKiilwXstGh/vk/eLH8eiJtVclH6iC9iQLCYsJor9tkqMBsgqoYVYox6/dNIa
 LUG4AipB2k1k2w+rWYjHLnIcLYNZxhhqC1lfy8okt6eHvlrkXDWS4J2/22jW75U3wKWMuE7KwDW
 JAG8XnKghlIIixwoRClsnHwyJEq7hag8fNZSrGg8btn1dh
X-Gm-Gg: AYBFou17PadbXyYJlojbT0FSlctj2Q8y1HjkEBPm5KlmFpLFgi6Aed5aDWKRaCME4CV
 GTN+i+0JBjektxgagtnOUlksFguAzMpGuU3wq31fBK7i4tAdYsk9eVQWlUx1pLKgJ1r52F6I5Ya
 +1zlgyFHs7D5EkkQzoy9RRqt07/H9EfZmIJWpAhVPcO+PrjPqDgfr0roa7gIEUlWdWvzMKJoABI
 FXWFKUJ0GFkLRaQ
X-Received: by 2002:a05:7022:607:b0:13d:19da:9370 with SMTP id
 a92af1059eb24-14d3214813amr3682608c88.17.1790816907972; 
 Wed, 30 Sep 2026 18:08:27 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:13d:19da:9370 with SMTP id
 a92af1059eb24-14d3214813amr3682563c88.17.1790816907221; Wed, 30 Sep 2026
 18:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260922071807.2533884-1-airlied@gmail.com>
 <20260928140028.02900e68@shazbot.org>
In-Reply-To: <20260928140028.02900e68@shazbot.org>
From: David Airlie <airlied@redhat.com>
Date: Thu, 1 Oct 2026 11:08:15 +1000
X-Gm-Features: AclHuK8H40xGZ7LDm4tWEaoZ7Fx41p0eMmMGmCD_ZHFdFpJFjKlkMOkwot6pi94
Message-ID: <CAMwc25oCKJaYaUOt32-xegXOjLbWMpk2RAASyZDj1ooh_41hnQ@mail.gmail.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback (v2)
To: Alex Williamson <alex@shazbot.org>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>,
 "Simon Song (SW-GPU)" <xinmengs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w5k_AH0bU704Ml2TKAP7VRO9izmxS4UdSFEFkSFoR7w_1790816908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 29, 2026 at 6:06=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Tue, 22 Sep 2026 17:18:07 +1000
> Dave Airlie <airlied@gmail.com> wrote:
>
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This changes the vgaarb client API so that the user can pass a
> > private data pointer into the register that will get used in
> > the decode callback.
> >
> > This allows a bunch of pdev conversions in the drivers, and lets
> > some future vfio cleanups be nicer.
> >
> > I'd like to merge this via the drm next tree but also fine with
> > it going via pci.
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > ---
> > v2: fix loongson (spotted by sashiko)
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
> >  drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
> >  drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
> >  drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
> >  drivers/gpu/drm/radeon/radeon_device.c     |  7 +++----
> >  drivers/pci/vgaarb.c                       | 13 +++++++++----
> >  drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
> >  include/linux/vgaarb.h                     |  8 +++++---
> >  8 files changed, 34 insertions(+), 26 deletions(-)
>
>
> Acked-by: Alex Williamson <alex@shazbot.org>
>
> Preemptively, could this get merged via a topic branch that we could
> share in case further drvdata cleanup arrives in vfio-pci this cycle?
>
> I'm imagining this might also be a good time to push vgaarb
> registration out of vfio-pci-core as well.  Thanks,
>

Thanks Alex and Bjorn,

Okay I've cleaned up the last few bits from Bjorn, added lines and
created a drm topic branch

https://gitlab.freedesktop.org/drm/kernel topic/pci-vgaarb-rework

I'll send a PR merge this into drm-next and you can work off it as
well if you need to.

Dave.


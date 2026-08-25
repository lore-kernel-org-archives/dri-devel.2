Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75885C61DC4
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725D28918D;
	Tue, 25 Aug 2026 14:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="orbBPggv";
	dkim-atps=neutral
X-Greylist: delayed 367 seconds by postgrey-1.36 at gabe;
 Tue, 25 Aug 2026 09:52:48 UTC
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C7410E182
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 09:52:48 +0000 (UTC)
Received: from nr200 (unknown [80.68.231.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Tue, 25 Aug 2026 11:46:36 +0200 (CEST)
Date: Tue, 25 Aug 2026 11:46:34 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: sashiko-reviews@lists.linux.dev, syzbot <syzbot@kernel.org>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/cirrus-qemu: Validate BAR0 size during probe
Message-ID: <ao1ketQ4oxNiWGAM@nr200>
References: <b11f8965-5896-4119-98b7-6bd0eb9fa139@mail.kernel.org>
 <20260825074432.0B4511F00A3A@smtp.kernel.org>
 <ce0912d6-fdc4-4ead-9388-a9e0e9a1954c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0912d6-fdc4-4ead-9388-a9e0e9a1954c@suse.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1787651198; bh=MvH/GZjMBZncc502+FYWTWv0K2Z8oMHl739kUmAgO54=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=orbBPggvICoii+Nd15hkuQdaVT4uWhs0z4sbW4il/lbCDnVOE6amIE9ygg+Ht4iYT
 CYHDmQ3C1E1Ty9JxV9OQg0L2sziOirldjm08W1Mh1nhm3Ng9xDbmKL3qZb6705X/kq
 sQ+RYSnnW1c6qCNhYORfySESlYl9GLL9YB/U8T8Q=
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

On sie 25, 2026 10:00, Thomas Zimmermann wrote:
> (cc: Slawomir)
> 
> Hi,

Hello,

> thanks for the fix. Please see below for changes that should go into the
> patch.

thanks I will look into them and make a manual v2!

> Best regards
> Thomas
> 
> Am 25.08.26 um 09:44 schrieb sashiko-bot@kernel.org:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] The exact equality check for BAR0 size (`!= CIRRUS_VRAM_SIZE`) incorrectly rejects valid QEMU configurations with larger VRAM.
> > - [High] The VRAM size validation check is placed after `aperture_remove_conflicting_pci_devices()`, meaning the firmware framebuffer is permanently destroyed even if the driver ultimately fails to bind.
> > --
> > 
> > --- Patch [1]: [PATCH] drm/cirrus-qemu: Validate BAR0 size during probe ---
> > commit 75467ead62a494b6afbc057c666ab59f7e4b8915
> > Author: Slawomir Stepien <sst@poczta.fm>
> > 
> > drm/cirrus-qemu: Validate BAR0 size during probe
> > 
> > This commit adds a check during PCI probe to verify that the BAR0 resource
> > length equals CIRRUS_VRAM_SIZE. This is intended to prevent supervisor write
> > page faults caused by writing past the end of the mapped I/O memory when
> > smaller BARs are presented.
> > 
> > Link: https://syzkaller.appspot.com/ai_job?id=ba262a3a-bccf-4ad8-a1b0-583c55d34fd6
> > 
> > > diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
> > > index 075221b431d37..70c995025f508 100644
> > > --- a/drivers/gpu/drm/tiny/cirrus-qemu.c
> > > +++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
> > > @@ -602,6 +602,9 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
> > >   	dev = &cirrus->dev;
> > > +	if (pci_resource_len(pdev, 0) != CIRRUS_VRAM_SIZE)
> > > +		return -ENODEV;
> > > +
> > [Severity: High]
> > Does this strict equality check unintentionally break valid QEMU
> > configurations that have more than 4 MB of VRAM?
> > 
> > When a VM is booted with a configuration like -device cirrus-vga,vgamem_mb=8,
> > the BAR0 size will be 8 MB. The check in cirrus_pci_probe() evaluates
> > to true (since 8 MB is not equal to 4 MB) and rejects the device by
> > returning -ENODEV.
> > 
> > Would it be safer to check if pci_resource_len(pdev, 0) < CIRRUS_VRAM_SIZE
> > instead of requiring an exact match?

It seems that 4MB is the default one and 8 and 16MB are just for compatibility:

(qemu hw/display/cirrus_vga.c):

2951     /*
2952      * Follow real hardware, cirrus card emulated has 4 MB video memory.
2953      * Also accept 8 MB/16 MB for backward compatibility.
2954      */
2955     if (s->vga.vram_size_mb != 4 && s->vga.vram_size_mb != 8 &&
2956         s->vga.vram_size_mb != 16) {
2957         error_setg(errp, "Invalid cirrus_vga ram size '%u'",
2958                    s->vga.vram_size_mb);
2959         return;
2960     }

I will add the 8 and 16MB then in v2.

> > [Severity: High]
> > Is it safe to place this validation check after the call to
> > aperture_remove_conflicting_pci_devices() earlier in cirrus_pci_probe()?
> > 
> > If this new size check fails (either due to a malformed device or a larger
> > valid VRAM size), cirrus_pci_probe() aborts with -ENODEV. However, because
> > aperture_remove_conflicting_pci_devices() was already executed at the start
> > of the probe function, the firmware framebuffers (like efifb or simplefb)
> > have been permanently destroyed.
> > 
> > Could this leave the system with a dead display output? Would it make sense
> > to move this PCI configuration check to the very beginning of the probe
> > function, before any destructive actions occur?

Yeah I guess this new check can be before aperture_remove_conflicting_pci_devices().

> > >   	cirrus->vram = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
> > >   				    pci_resource_len(pdev, 0));
> > >   	if (cirrus->vram == NULL)

-- 
Slawomir Stepien

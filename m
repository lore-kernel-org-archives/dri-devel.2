Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=AqVZcw9p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554B910E236;
	Fri, 30 Oct 2026 05:34:21 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FBA10E236
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:34:15 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 89DB040E04D6; 
 Fri, 30 Oct 2026 05:34:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id i4pfNfqK1sze; Fri, 30 Oct 2026 05:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1793338448; bh=mSF4SGZPS2CDzaKvvs/6H+aTKl4UYtTySMgMP/nGH+Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AqVZcw9p1+5S1S7HgvPNff56JVxj7Eq28TIv2ohiPqPrGlBnjtFe4h3zRcEsSPk16
 zUISLeO/wToHBdLBKZhm6HAn2PPM+gY69OytGcnQfGvWWmXRGHkueqRut7VE0KHtRt
 jZaYeyeK2z23onvqGz5/01td0aWJWigWhJlmm/+TV8JEQcCtHx7x2eHhTrYftkmlVf
 XyQ5l9APzEnYz/0M/EwSOUc+sG7od5Wf9iXuz7Oi5b4u5L+rEKuqbR4Cbb1lN3l8EQ
 WRjjt065wQmSEtDPB1d18ONOS7+KdmfAUl8PGiQUNHa0KE9j3Ce+9vpQBK0gMG78SB
 H65MzfQNE3rK4GMXP1UAnw14Pj0j03AFmKgyD3kyUWAeTYxdhb+zGU8MAFgGuQUUaL
 jue3QGKh5QmChjn7gUfelvO0o1nOb04UbFZKXm2MttMtTI70tYOyz+CGkPdXvuLDUr
 F2lPtXFBkmN0eiFjeRDgsdm6ZK0fhXjyzkm25iuMKMeez2yPHzX5F2NMMqnTjPhna2
 74qvDSNhYaaTWzYWGe8IhD8PTI8pHMCZcTONu8LMSAmhUDaMn93Y8FeW1n28h1zEdO
 zIGZ2V8sk2VJm2bWrnzkwFAPFP4vM3oGXcSjBRjjNaLwCK7LvO1TucixSLqwV8zF7f
 BTCUXvJxciVUqGzVPM03QzXQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA24340E04D5;
 Fri, 30 Oct 2026 05:33:59 +0000 (UTC)
Date: Thu, 29 Oct 2026 22:33:56 -0700
From: Borislav Petkov <bp@alien8.de>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: x86@kernel.org, mario.limonciello@amd.com, tzimmermann@suse.de,
 aaron.ma@canonical.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Message-ID: <20261030053356.GJauQsRF8Rl_co7FOv@fat_crate.local>
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029162311.3389523-1-hengyul@cs.unc.edu>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 12:23:11PM -0400, Hengyu Liang wrote:
> Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
> without screen info") made video_is_primary_device() rely exclusively
> on screen_info resources whenever any are available.
> 
> However, screen_info_resources() also returns legacy I/O and memory
> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
> lookup fails and the default VGA fallback is skipped.
> 
> On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA loses its DRM
> boot_display attribute and fbcon leaves the console on VKMS. This can
> be checked with:
> 
>     cat /sys/class/drm/card1/boot_display
>     stty -F /dev/tty1 size
> 
> Without the fix, boot_display is missing and tty1 is 48 rows by 128
> columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
> columns.
> 
> Use resource-based selection only for linear framebuffers. Fall back to
> vga_default_device() for legacy display modes, while keeping EFI and
> VESA framebuffer ownership authoritative.
> 
> Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() without screen info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Tested in QEMU/KVM with identical KASAN configs: SeaBIOS VGA text mode
> (with and without VKMS), VESA, and OVMF with one and two virtual GPUs.
> All 26 guest-only helper checks pass, including EFI/VESA framebuffer
> ownership, missing framebuffer resources, and addresses above 4 GiB.
> Also build-tested x86-32 with/without CONFIG_SCREEN_INFO, and x86-64
> without CONFIG_SCREEN_INFO.
> 
>  arch/x86/video/video-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

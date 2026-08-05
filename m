Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD72C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B796C10F0DF;
	Thu,  6 Aug 2026 06:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="F7rSiwJW";
	dkim-atps=neutral
X-Greylist: delayed 1136 seconds by postgrey-1.36 at gabe;
 Wed, 05 Aug 2026 21:00:39 UTC
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A7B10E24E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
 From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fxxAvPqTAxUhxrKli4ShhvHTdIiQ0PK25MeGj4sJLvU=; b=F7rSiwJWtEl0UedHFaWY+P59rI
 hdvFPLQ/ap8JcAUAUTx0zU6GED+bFycLBxFX1UxKYAXyJtxjVV8ftKTbO60ACHuu6zV7Y2F+TG5Ca
 QpEGmefZgWZBfpWkwnC606WY9hY6TDtzVzseFAI6OO5WDRS4dcf9JoczTtM1KHcHTd+AFwUfrMkpk
 laDujPtPvFZij13FtXaMdkyOhRKKZ5z9x9cu0DgJL3QUf9Yly3rmOV4bILIAZXAJF979hqc5VoD22
 zWGu34Y16DrmUOYF9FuLBRc2qqO3d2+79gZjtvwlI6qoW7FC1u8T6oTXLsljB6Kc4zOiKsORqoOZd
 HxgLyY2A==;
Received: from [195.240.176.17] (port=54206 helo=[192.168.2.29])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1wriQn-00000002MWn-1pR5; Wed, 05 Aug 2026 22:41:41 +0200
Message-ID: <9a795e26-53de-41da-bdb8-9ced20b70e87@accessweb.be>
Date: Wed, 5 Aug 2026 22:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
From: Jellis Onsea | AccessWeb <jellis@accessweb.be>
Subject: drm/vmwgfx: graphics memory not returned after all GEM objects are
 released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - pan.awservers.eu
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - accessweb.be
X-Get-Message-Sender-Via: pan.awservers.eu: authenticated_id:
 jellis@accessweb.be
X-Authenticated-Sender: pan.awservers.eu: jellis@accessweb.be
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:52:41 +0000
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

Hi Zack,

I'm reporting a memory issue in vmwgfx where graphics memory is not 
returned to the system even after every DRM client has released its GEM 
objects. Only a reboot frees it. This comes out of KDE bug 523812, which 
was closed as RESOLVED UPSTREAM with the assessment that this looks like 
a driver-side leak rather than a compositor one.

- Environment:

     Guest:      CachyOS (Arch-based), kernel 7.1.5 and 7.1.6
     Host:       VMware Workstation on Windows, AMD Ryzen 9 7950X
     Driver:     vmwgfx 2.21.0.0, VMware SVGA II
     Renderer:   llvmpipe (LIBGL_ALWAYS_SOFTWARE=1, see note below)
     Compositor: KWin 6.7.3, Plasma Wayland, 3 x 1920x1080 @ 60 Hz
     RAM:        31 GiB, zram swap
     3D accel:   disabled in the VM settings

- What happens:

During normal desktop use, buffers of exactly 8355840 bytes accumulate. 
That is 1920 x 1088 x 4 — one screen-sized 32-bit framebuffer with the 
height padded to a multiple of 64. Growth is tied to rendering activity, 
not to uptime: an unattended session leaked exactly zero bytes over 7.3 
hours, while active use adds roughly 1.4 GB/hour.

At 9 hours of uptime, kwin_wayland held 1846 GEM objects, 1553 of them 
that exact size. All of them had pin_count = 0. At 34.5 hours it was 
8057 objects.

- The measurement that points at the driver:

I logged out of the Plasma session and logged back in, without 
rebooting. That restarts the compositor (pid 2612 -> 3156650) and closes 
its DRM fd, so the kernel drops all its GEM references.

                                   before logout      after re-login
     GEM objects, all clients      8139               19
     system_ttm usage              49.47 GB           45.80 GB
     GPUActive (/proc/meminfo)     10.86 GB           11.06 GB
     MemAvailable                  11.06 GB           13.32 GB

So: no DRM client held more than 19 GEM objects in total, yet roughly 11 
GB remained accounted as GPUActive and was not returned. The ~2.3 GB 
gained in MemAvailable is very likely just the browsers and editors from 
the old session exiting, not graphics memory.

A reboot immediately afterwards did return it:

     GPUActive     0.11 GB
     RAM in use    4.5 GB of 31 GB   (was 18 GB before the reboot)

- Caveats I want to be upfront avout:

- system_ttm reporting 46-49 GB on a machine with 31 GiB of RAM is 
something I cannot explain. My assumption is that TTM accounts pages it 
has evicted to shmem, while GPUActive counts only resident ones. If that 
assumption is wrong, the volume figures need reinterpreting. The object 
counts and the fact that a reboot is required stand either way.
- Summing the reported sizes of the GEM objects gives ~46 GB, which also 
exceeds physical RAM, so that sum over-counts — presumably shared or 
multiply-mapped objects. I would trust the counts, not that total.
- This is a CachyOS kernel, not vanilla. I have not yet reproduced on 
mainline. I am happy to test a vanilla or drm-tip kernel if that would 
help; the machine reproduces this within a working day.
- LIBGL_ALWAYS_SOFTWARE=1 is set here to work around an older, separate 
vmwgfx surface-handle problem that crashed Chromium/Electron compositor 
threads with SIGILL. The behaviour described above occurs with that 
workaround in place.

- Possibly related earlier work:

I am aware of the dumb-buffer leak fixes in vmwgfx from the 6.10 era 
("drm/vmwgfx: Fix handling of dumb buffers", "drm/vmwgfx: Fix dumb 
buffer leak") and the rework that made GEM handles own the dumb buffer. 
The buffers accumulating here are exactly screen-sized dumb buffers, so 
this may well be in the same area, but on a much newer kernel, so either 
something remains or it is a regression. I did not find an open report 
matching this.

- How to reproduce the measurements:

     # object count and per-client totals (root)
     grep -c bytes /sys/kernel/debug/dri/0/vmwgfx_gem_info
     awk '/^ *pid/{p=$2" "$4} /bytes/{n[p]++; s[p]+=$2} \
          END{for(k in n) printf "%-26s %6d objects %9.1f MB\n", k, 
n[k], s[k]/1048576}' \
         /sys/kernel/debug/dri/0/vmwgfx_gem_info | sort -k3 -rn

     # pool usage (root)
     awk '/usage:/{print $2}' /sys/kernel/debug/dri/0/system_ttm

     # resident graphics memory
     grep -E 'GPUActive|GPUReclaim' /proc/meminfo

Use the desktop normally for a few hours; a browser window with a 
looping CSS animation makes it measurable within minutes. Opening and 
closing 32 windows produced no growth at all, so it is the continuous 
rendering that drives it.

Happy to run anything specific, apply a debug patch, or test a different 
kernel.


Regards,

Jellis Onsea
AccessWeb

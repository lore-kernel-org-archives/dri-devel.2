Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238CDC5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E4310E69A;
	Mon, 10 Aug 2026 06:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="QXSSUo1S";
	dkim-atps=neutral
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC0810E4BA
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
 From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Ccy1tTRKYNxyFYaTMCpkNiMvnhQOjjAGul7K6mguCo=; b=QXSSUo1SgJpRVQbJjC+yUcSQeH
 YesHAsfNF6Mne5TG7xeBowgKToQhSJsiJkqqBfHnVgP4mVGn5aM8RO3uSybdOiD3quwnYjDuuV18w
 oVBYmKFTpr02+f3URd34Cj35Vq1nS1KPrmi8AWULYnaXY3S3E2VFHucw1sWUEcbxuZXRc/gGHOmfS
 NJ/ohDV8EoRDChh0RhKkIKku3/Jr/GckY7hHQHt9nvI6E28zzpdZr+hWqo/7WN8oJ2B+/IVDz0RM5
 clrkLKqkJu6AO+j87b+Jx/Vq6qaT12mWk1gOLsxNYJGm9PiUVjl+JPFH2JtOuPDjAnkE2yeT39JZL
 vT42xMRg==;
Received: from [195.240.176.17] (port=38242 helo=[192.168.2.29])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1wselD-00000008jjX-2F9R; Sat, 08 Aug 2026 12:58:39 +0200
Message-ID: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
Date: Sat, 8 Aug 2026 12:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: maaz.mombasawala@broadcom.com, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
From: Jellis Onsea | AccessWeb <jellis@accessweb.be>
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Maaz, Zack,

I have a test result, but not the one you asked for.. the bug stopped
reproducing before I could test the patch, and the reason may be useful 
to you.

Short version: enabling 3D acceleration on the VMware host made the leak 
go away, with the stock distribution mesa. No patch involved.

-- What I changed:

Until 7 August this guest ran with 3D acceleration disabled in the VM 
settings, and additionally forced llvmpipe via LIBGL_ALWAYS_SOFTWARE=1. 
That was the configuration in my original report.

I enabled 3D on the host and removed the LIBGL_ALWAYS_SOFTWARE override, 
so the whole session -- kwin_wayland, plasmashell, clients -- now runs 
on svga:

     OpenGL renderer string: SVGA3D; build: RELEASE;  LLVM;
     Driver: VMware (SVGA3D)
     mesa 26.1.6-arch3.1   (distribution build, NOT patched)

-- Measurements:

Sampled every 15 minutes. system_ttm and mob_ttm are the two TTM pools 
from /sys/kernel/debug/dri/0/, "total" is their combined growth:

session start        hours   system_ttm        mob_ttm         total objects
  
------------------------------------------------------------------------------
     2026-08-02 20:37       7.8    4.73 -> 15.09   0.023 -> 0.023 
+1355 MB/h   753 -> 2184
     2026-08-03 04:36      34.8    0.11 -> 46.57   0.023 -> 0.023 
+1367 MB/h    23 -> 8211
     2026-08-04 15:37      33.1    0.10 -> 32.07   0.023 -> 0.023 
+989 MB/h    31 -> 5586
     2026-08-06 00:59      25.7    0.32 -> 17.07   0.023 -> 0.023 
+667 MB/h    49 -> 2680
     --- 3D enabled, svga in use from here ---
     2026-08-07 02:48      15.6    0.06 ->  0.05   0.131 -> 0.216 
+5 MB/h    85 ->  244
     2026-08-07 18:35      18.2    0.08 ->  0.19   0.266 -> 0.555 
+22 MB/h  1357 -> 3272

Same machine, same kernel (7.1.6), same mesa package, comparable desktop 
use. The last row is a full working day plus a night.

Two details that may matter more than the totals:

- --mob_ttm never moved in any of the four pre-3D sessions-- 409 samples 
over four days, constant at 0.023 GB. With svga it moves. The memory is 
coming out of a different pool.

- --The dominant buffer changed size-- Without 3D it was 8355840 bytes = 
1920 x 1088 x 4, height padded to a multiple of 64 -- the signature of a 
dumb buffer. With svga it is 8294400 = 1920 x 1080 x 4, exactly the 
screen, no padding.

So the configuration I reported was not exercising the svga driver at 
all, which was the question in my previous mail: the leak I measured was 
on the dumb-buffer/kms_swrast path, not through gallium svga.

-- About the patch:

I did build it, to be able to test properly: staging/26.1 at 2ed36c6 
("svga: Pass buffer handle for fd handles for resource_from_handle()", 
the backport of b460cff2 from your MR 43386). Verified it was actually 
loaded.. the version string reads "Mesa 26.1.6 (git-2ed36c6b5d)" and the 
vmw_winsys_to_dma_buffer symbol is present.

I have not been able to give it a meaningful before/after, because in 
the configuration where svga is in use the leak is already absent with 
the unpatched driver. I am not claiming the patch is unnecessary -- I am 
saying my machine no longer reproduces the problem it fixes.

If it helps, I can put the guest back on 3D-disabled and measure there 
with and without the patched build. Given the above I suspect it would 
show nothing, since svga is not loaded in that configuration, but say 
the word and I will run it.

-- One correction to something I nearly reported:

While switching, plasmashell started segfaulting on "dmabuf import 
failed to mmap". I was close to reporting that as a second driver bug. 
It was not: I had left LIBGL_ALWAYS_SOFTWARE=1 in place, which 
plasmashell honours but kwin does not (it goes through EGL). That left 
the compositor on svga and a client on llvmpipe trying to CPU-map a 
guest-backed buffer. With both on the same driver it is gone: 18 hours, 
zero occurrences.

The one thing that does look like a real bug is on the KDE side, not 
yours: the failed mmap leads to SIGSEGV (si_code = SEGV_MAPERR) rather 
than a blank thumbnail. I will report that to them separately.

-- Environment:

     Guest:      CachyOS (Arch-based), kernel 7.1.6-1-cachyos
     Host:       VMware Workstation on Windows, AMD Ryzen 9 7950X
     Driver:     vmwgfx, VMware SVGA II, 3D acceleration now ENABLED
     Compositor: KWin 6.7.4, Plasma Wayland, 3 x 1920x1080 @ 60 Hz
     mesa:       26.1.6-arch3.1
     max mob size: 1048576 KiB   (was 262144 KiB with 3D disabled)


Happy to run anything specific, on either configuration.


Regards,

Jellis Onsea
AccessWeb

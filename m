Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B5C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6FC10E66D;
	Mon, 17 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="lvVYU8on";
	dkim-atps=neutral
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5226810E1D0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FHYtgoKs4djsrIkLu05EIcHe7zGrwjIZrw7SUr6DVH0=; b=lvVYU8onmUfSL4pD5bvqycWyHk
 XZroT++kkzQCO95JTGKe+mIqCCOwNsi2lbJD2KKwFQ3YJPbLt+LNQ5QY+LR6Qsoco9Kzd1mQsg90O
 TcWOqXO/4m4/c/+hingn5tFt6/iD74OaL+NCy+WmddT9gFlT/xlNWnrq3L2nyZc9sfaRJV4pC8KyE
 12OFQIbsIxgkUANwH5Fpko9GLBNC3PG9sryRzWpwKQLqCCK5jw01aofD3Yzb/TOws7khdOFN8UFWj
 84IOLZmmqNcr3V9RDt7Z5itdybLUXt3Hyrtc5WNQHrJdxS2lndEffhkT0CkpeM2RImNDK5EvTlc0r
 FgiuZfOA==;
Received: from [195.240.176.17] (port=47176 helo=[192.168.2.230])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1wveBA-00000001cLu-0gSE; Sun, 16 Aug 2026 18:57:47 +0200
Message-ID: <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
Date: Sun, 16 Aug 2026 18:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
Content-Language: en-US
From: Jellis Onsea | AccessWeb <jellis@accessweb.be>
In-Reply-To: <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
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
X-Mailman-Approved-At: Mon, 17 Aug 2026 06:55:17 +0000
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

Yes, it does, and I have to correct my message of 8 August as well.

-- Short answer

With 3D disabled again, kernel 7.1.8, stock mesa 26.1.6-arch3.1. Object
counts from vmwgfx_gem_info, sampled every 15 minutes:

   2026-08-15 14:22 - 23:53      idle, 9.5 h     370 ->  370 objects
   2026-08-15 23:53 - 16 01:08   in use          370 ->  772 objects
   2026-08-16 03:54 - 13:53      idle, 9.8 h    1274 -> 1274 objects
   2026-08-16 13:55 - 17:57      working day    1274 -> 2387 objects

Both idle windows are identical in every single sample: 39 and 40 
consecutive samples with the same object count and the same pool 
figures. Not approximately flat - identical. Nothing accumulates while 
the machine sits there, and nothing is handed back either.

I lead with counts rather than volume because of the caveat in my first 
mail: the summed object sizes exceed physical RAM, so I do not trust the 
totals. For what it is worth, the pools moved 2.16 -> 4.57 GB and 6.73
-> 13.85 GB across those two active windows.

-- This confirms my original report rather than adding to it:

The second window was a browser video call, with no RDP session
involved. In some of my later messages I linked the heavy phases to RDP,
because that was the heaviest thing running here. That was my own
mistake: my first report already said it plainly - "a browser window
with a looping CSS animation makes it measurable within minutes.
Opening and closing 32 windows produced no growth at all, so it is the
continuous rendering that drives it." The idle-versus-active split I
described then is exactly what these four windows show.

-- Correction to my message of 8 August:

I wrote that enabling 3D acceleration made the leak go away. That was
based on two svga sessions of 15.6 and 18.2 hours, and it does not
survive a longer measurement.

The problem was the length of those sessions, not the pools - I did
report both, and mob_ttm was already moving in that table. But at 18.2
hours it stood at 0.555 GB. That same boot ran on for 115.5 hours in
total, and by the end mob_ttm was at 15.15 GB.

For reference, the two pools swap roles with the configuration:

     3D off (llvmpipe)   system_ttm grows,  mob_ttm flat at 0.023 GB
     3D on  (svga)       system_ttm flat,   mob_ttm 0.27 -> 15.15 GB

Per boot, both pools added together:

   boot            hours  kernel  3D    sys+mob     objects
   2026-08-02 16:02   7.8   7.1.5  off  +1355 MB/h   753 -> 2184
   2026-08-03 04:33  34.8   7.1.5  off  +1367 MB/h    23 -> 8211
   2026-08-04 15:34  33.1   7.1.6  off   +989 MB/h    31 -> 5586
   2026-08-06 00:56  25.7   7.1.6  off   +667 MB/h    49 -> 2680
   2026-08-07 02:45  15.6   7.1.6  on      +5 MB/h    85 ->  244
   2026-08-07 18:32 115.5   7.1.6  on    +161 MB/h  1357 -> 9128
   2026-08-12 14:20  62.9   7.1.8  on     +30 MB/h  1405 -> 4418
   2026-08-15 12:03  29.6   7.1.8  off   +442 MB/h    30 -> 2236

The 2026-08-07 18:32 row is the one I got wrong. I reported +22 MB/h
for its first 18.2 hours; over the full 115.5 hours it is +161 MB/h.
I drew a conclusion from a session that had not run long enough.

So enabling 3D reduces it substantially - roughly a factor 3 to 30
depending on the session - but it does not remove it. The per-boot
averages also flatten something that is not gradual: long flat
stretches, then a jump inside a single 15-minute sample.

-- The kernel changed twice and I did not mention it:

7.1.5 -> 7.1.6 on 4 August, 7.1.6 -> 7.1.8 on 12 August, each taking
effect at the boot immediately after. Since vmwgfx is a kernel module I
should have said so at the time. Mesa stayed at 3:26.1.6-1 throughout,
so that is not a variable.

I do not think it explains anything - 7.1.8 with 3D off leaks harder
than 7.1.5 did - but it belongs in the data.

-- The patch:

Still built and still verified here:

     /usr/lib/libgallium-26.1.6-arch3.1.so   vmw_winsys_to_dma_buffer absent
     my staging/26.1 build at 2ed36c6        vmw_winsys_to_dma_buffer 
present
                                             "Mesa 26.1.6 (git-2ed36c6b5d)"

Arch has not shipped a mesa containing it; 3:26.1.6-1 is still the
current package here, so the fix has not reached this machine through
the distribution.

In the 3D-off configuration llvmpipe is in use and the buffers are dumb
buffers of 1920x1088x4, so I would not expect gallium svga to be
involved at all. If the mechanism Zack described - prime exports with no
deref/destroy ioctl, so gem_close does nothing - also applies on the
dumb-buffer path, that would explain why this configuration keeps
leaking while the mesa-side fix sits in svga.

I can run any of these, whichever is most useful to you. All four are
set up here, so it is a matter of you saying which:

   1. the patched build with 3D OFF, in the current configuration. This
      is the quickest - the build is in place and it takes a re-login.
      I expect it to change nothing, since svga is not loaded here, but
      that is worth establishing rather than assuming.
   2. the patched build with 3D ON, 48 hours or more, against the
      +161 MB/h baseline above. Needs the VM powered down to change the
      host setting, so give me a day for it.
   3. stock Arch kernel instead of the CachyOS one. Arch currently ships
      linux 7.1.8.arch1-3, which is the same version as the CachyOS
      7.1.8 I am running, so that isolates the patch set rather than the
      version. I offered a vanilla kernel in my first mail and never did
      it; it installs alongside the current one, so it is low risk here.
   4. any instrumentation you want, on either configuration - extra
      debugfs reads, a debug patch, different sampling.

Say which and I will run it.

-- One correction on the plasmashell crash:

In my 8 August mail I said the dmabuf import crash looked like a KDE bug
and that I would report it to them. That was wrong. The message comes
from libgallium, not from any KDE or Qt library, and the faulting thread
is an llvmpipe rasteriser thread. It matches mesa issue #6438, which is
still open. I will add my reproduction there instead.

Regards,

Jellis Onsea
AccessWeb

Op 13-08-2026 om 23:12 schreef Maaz Mombasawala:
> That is good to know. Do you still see a memory leak with 3D off?
> 

-- 
Met vriendelijke groeten,
AccessWeb ICT Solutions
AccessWeb.
	
ONSEA Jellis
AccessWeb ICT Solutions
Europaplein 29/7
3630 Maasmechelen
Tel BE +32 470 96 43 15 <tel:+32470964315>
Tel NL +31 6 492 757 98 <tel:+31649275798>
E-mail jellis@accessweb.be <mailto:jellis@accessweb.be>

Indien u een SLA-contract heeft, gelieve alle communicatie te voeren met
het e-mailadres gekoppeld aan uw SLA. Dit verzekert de correcte en
tijdige opvolging van uw vraag.



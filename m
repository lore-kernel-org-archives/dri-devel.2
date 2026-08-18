Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309FDC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE9710ED1D;
	Wed, 19 Aug 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="SdZFpozr";
	dkim-atps=neutral
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F9010E46A
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9JWkZGwNXyEm/7YQK3ZjEkyYO4xVPD47m/cjM12w06g=; b=SdZFpozrEDJhaMje08bwBZE6sk
 KB8skpKp9rK54k/PgU7/dm1mwlY3s3uEJ6+AwrOvYdlQqOSwLCDnbStbffzqKmJ/UQmxnPFzr974r
 EbjN0GoPW7TD68rnA11IZsDqysP98gLRpp8PIYnacTRYWNPNmFfgA7jeFFrBiPEIgRoXia/vZhwN8
 B1Dy1DieGjYFmyzkZZz2WizlrMoyAKL9Z3gxVEKLLth44o38JPfPN5XPBAseH6V585xJWhBkCK0Lf
 lMXnQOBx8WRrMcMTqRqjvsLUdPCB/2cw1Gz1xGSVuvIE2rKPrCZLLgIy1XweMwgMa04mwAlRnlaPB
 6DPp8otg==;
Received: from [195.240.176.17] (port=36660 helo=[192.168.2.230])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1ww8JQ-00000004prX-1ci3; Tue, 18 Aug 2026 03:08:18 +0200
Message-ID: <b0b0caf9-ca76-4f93-9495-d386d313fad1@accessweb.be>
Date: Tue, 18 Aug 2026 03:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
 <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
 <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
Content-Language: en-US
From: Jellis Onsea | AccessWeb <jellis@accessweb.be>
In-Reply-To: <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
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
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

Hi Maaz,

Yes, it is set up here now.

One practical detail: 26.1.7 never reached this machine. Arch upgraded 
us from 26.1.6 to 26.2.0 in one step on 17 August, so rather than the 
release I am using the build we made on 7 August, which is 26.1.6 with 
your commit 2ed36c6 applied. I diffed that tree against the mesa-26.1.7 
tag: src/gallium/winsys/svga/ and src/gallium/drivers/svga/ are 
identical, so for the svga paths it is that version. Our vmwgfx module 
reports 2.21.0.0, so have_drm_2_21 is true and the new branch is the one 
that runs.

Results will take a day or two, and I would rather explain why than send 
you a number too early. With 3D enabled our leak has run between 5 and 
161 MB/hour, and the debugfs counter we track is logged in 10 MB steps, 
so a short window cannot resolve it. A ten-minute run last night came 
out flat, which says nothing either way. I will run a multi-hour window 
on stock mesa and an identical window on the patched build, under the 
same synthetic render load, and send you both.

Two things you may want to know in the meantime.

First, mesa 26.2.0 does not contain your fix. It was tagged on 5 August, 
a week before 26.1.7, so it predates the backport:

   mesa-26.1.6         29 Jul 2026   absent
   mesa-26.2.0         05 Aug 2026   absent    (what Arch ships today)
   mesa-26.1.7         12 Aug 2026   present
   origin/staging/26.2               present
   origin/main                       present

In the 26.2.0 tree, vmw_screen_dri.c:331 still reads

   ret = drmPrimeHandleToFD(vws->ioctl.drm_fd, vsrf->sid, ...)

staging/26.2 and main both carry the fix, so 26.2.1 should bring it 
along. Until then every distribution that moves from 26.1.7 to 26.2.0 
loses it again.

Second, enabling 3D on 26.2.0 took our desktop down, in the dmabuf path:

   dmabuf import failed to mmap: Invalid argument   (x4)
   plasma-plasmashell.service: Main process exited, code=dumped, 
status=11/SEGV

There is one reliable way to trigger it: hovering the mouse over a task 
manager icon of a running window, so that Plasma raises the window 
thumbnail preview. That killed plasmashell every single time. As long as 
we stayed away from those icons the session looked stable. A thumbnail 
preview is a dmabuf import of another client's buffer, which fits the 
error above.

Once it starts, systemd restarts plasmashell, the shell rebuilds the 
panel and dies again: three crashes within eight seconds, then the 
restart limit gave up and we were left with an empty desktop. A manual 
restart behaved the same way.

The precondition is 3D enabled together with LIBGL_ALWAYS_SOFTWARE=1, 
which is the configuration in our original report of 5 August. Removing 
that variable, so the session really runs on svga, makes it stable: the 
same hover over the same icons is now uneventful, and the desktop has 
been up since.

I am not claiming your fix addresses that. We have not tested it, and 
this was on 26.2.0, which does not have it. But it is the same handle 
export path and it is now reproducible on demand here, which it was not 
before. If a backtrace or an strace of the failing mmap would help, say 
the word.

Finally, a small thing in the patch itself, which does not affect us 
since we are on 2.21: in vmw_drm_surface_get_handle(), ret is declared 
uninitialised, and when have_drm_2_21 is false while vsrf->buf is 
non-NULL neither branch assigns it. The following "if (ret)" then reads 
an indeterminate value.


Best regards,
Jellis

Op 18-08-2026 om 00:02 schreef Maaz Mombasawala:
> For the 3D enabled case, that sounds a lot like the memory leak for which I submitted the
> fix to mesa recently. The fix has been included in mesa version 26.1.7, could you try with
> that version? I see you're using mesa 26.1.6 right now.
> 




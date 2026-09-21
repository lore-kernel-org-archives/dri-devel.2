Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61962C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF7D10E4AE;
	Mon, 21 Sep 2026 07:22:07 +0000 (UTC)
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
 by gabe.freedesktop.org (Postfix) with SMTP id 5DA8E10E4AE
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:22:07 +0000 (UTC)
Received: (qmail 22312 invoked from network); 21 Sep 2026 07:22:05 -0000
Received: from stink-foot.audible.transient.net (192.168.2.99)
 by canarsie.audible.transient.net with QMQP; 21 Sep 2026 07:22:05 -0000
Received: (nullmailer pid 6931 invoked by uid 1000);
 Mon, 21 Sep 2026 07:22:05 -0000
Date: Mon, 21 Sep 2026 07:22:05 +0000
From: Jamie Heilman <jamie@audible.transient.net>
To: dri-devel@lists.freedesktop.org, airlied@gmail.com, dakr@kernel.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, lyude@redhat.com
Subject: Re: trapped reads in 7.3-rc1 since nv50 instmem handling change
Message-ID: <arDbHfeXuHDCKQNS@audible.transient.net>
Mail-Followup-To: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 dakr@kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lyude@redhat.com
References: <apnNRjrFPD48m4hO@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apnNRjrFPD48m4hO@audible.transient.net>
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

Jamie Heilman wrote:
> On my workstation with a Quadro NVS 290 running 7.3-rc1 I'm seeing
> this sort of thing show up spuriously:
> 
> kernel: nouveau 0000:01:00.0: fb: trapped read at 0100ef56e0 on channel -1 [0fee0000 unknown] engine 06 [BAR] client 08 [PFIFO_READ] subclient 01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
> kernel: nouveau 0000:01:00.0: fb: trapped read at 0100f85788 on channel -1 [0fee0000 unknown] engine 06 [BAR] client 08 [PFIFO_READ] subclient 01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
> (repeated 16 times)
> 
> I bisected it back to 34e27b90552a (nouveau/instmem: use iomapping
> interface for instmem handling).  The rest of the salient dmesg during
> initialization is:
> 
> kernel: nouveau 0000:01:00.0: NVIDIA G86 (086f00a2)
> kernel: nouveau 0000:01:00.0: bios: version 60.86.6c.00.21
> kernel: nouveau 0000:01:00.0: vgaarb: deactivate vga console
> kernel: Console: switching to colour dummy device 80x25
> kernel: nouveau 0000:01:00.0: bios: M0203T not found
> kernel: nouveau 0000:01:00.0: bios: M0203E not matched!
> kernel: nouveau 0000:01:00.0: fb: 256 MiB DDR2
> kernel: nouveau 0000:01:00.0: drm: VRAM: 256 MiB
> kernel: nouveau 0000:01:00.0: drm: GART: 1048576 MiB
> kernel: nouveau 0000:01:00.0: drm: TMDS table version 2.0
> kernel: nouveau 0000:01:00.0: drm: MM: using CRYPT for buffer copies
> kernel: [drm] Initialized nouveau 1.4.3 for 0000:01:00.0 on minor 0
> kernel: Console: switching to colour frame buffer device 240x75
> kernel: nouveau 0000:01:00.0: [drm] fb0: nouveaudrmfb frame buffer device
> 
> It doesn't always happen at boot, sometimes it takes a while to show
> up as it seems to be related to how much I have going on at any point
> in time.  That commit reverts cleanly for the moment, but I'm happy to
> test any ideas or enable further debugging as needed, assuming this
> wasn't intentional.

This is still present after deced5fa01c5 ("nouveau/instmem: handle
iomapping already existing") and in 7.3-rc4.  Apart from the log spam
(which has made journald angry once by flooding the buffer) it doesn't
seem to have any other serious consequences yet though.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

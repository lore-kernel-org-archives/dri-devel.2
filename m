Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C64C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 04:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8EDF10EC89;
	Wed,  5 Aug 2026 04:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QdUdqkfL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A687D10EC89;
 Wed,  5 Aug 2026 04:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785903265; x=1817439265;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uzW5QjbbO4S7UwlyG8xFuJUvhQUk5X5xou80QvZncxg=;
 b=QdUdqkfLMgEb0HAhg6xHcyft7ezVVlxlSWBOvtPTFDVw74KNRvlZ5DQ/
 GxmVRP5YvqhTKywfTWC31Gj/c8rOLmTzyq6yEtpPnj/1aJt+D9z6EdMg2
 OYPYKNACaExJjqOeRVjT+nk5vPrKmSoe1CrnqXxn4g8yTxUARIliWymJN
 jmL8JEMU+Bd7bRzlcPsoXqnKyzL+iD9WK/EzuBAI2VfTjaDqHxaghoIjx
 9uezoIpZT4lm/OTvPY99H51dpnyikC/ZCOkfDJf8A/UQd3U/x5ptzLAPs
 FQ+bCW/wtI8LWoWupESkW/sgB4RV6TXK4jmrAhbOrX2cXIGSOPvpPS16v w==;
X-CSE-ConnectionGUID: a/XZUyboRYKlBFjont9qsQ==
X-CSE-MsgGUID: yLlo+2f9TSCyZfnT5dG6sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97831652"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="97831652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 21:14:23 -0700
X-CSE-ConnectionGUID: xJP45RYVQtuepPqCjIv+Ew==
X-CSE-MsgGUID: KwMG0cDVS5afnmsJGgcapA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="259049530"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP; 04 Aug 2026 21:14:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id 1546C99; Wed, 05 Aug 2026 06:14:21 +0200 (CEST)
Date: Wed, 5 Aug 2026 06:14:21 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bernd Behler <bernd@behler.me>
Cc: linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Imre Deak <imre.deak@intel.com>
Subject: Re: Apple Studio Display =?utf-8?Q?=282026?=
 =?utf-8?Q?=2C_Thunderbolt_5=29_?= =?utf-8?B?4oCU?= DP tunnel torn down every
 few minutes on Intel TB4 host
Message-ID: <20260805041421.GE235112@black.igk.intel.com>
References: <CAM=hwCxiJwODObeut=JcCA8jbu4C-XVEKJpR-y2MnDJibBQyOw@mail.gmail.com>
 <20260802064729.GL20844@black.igk.intel.com>
 <CAM=hwCytVxuqfT2d4UNaf2x5FCOpMXaaGyuQ6xEoh_+w8NVJtw@mail.gmail.com>
 <20260804140449.GA235112@black.igk.intel.com>
 <CAM=hwCx7hg7ZubxmGOND02Do_Vp7W-qJRXK+NyN48sO0Zmy0_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM=hwCx7hg7ZubxmGOND02Do_Vp7W-qJRXK+NyN48sO0Zmy0_g@mail.gmail.com>
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

Hi Bernd,

On Tue, Aug 04, 2026 at 04:57:05PM +0200, Bernd Behler wrote:
> Hi Mika,
> 
> Both things done. Short version: the MST lead does not hold, and I can now
> show why rather than just assert it.

Okay thanks (and thanks for the very informative reports).

> Trace with nothing before the unplug
> ------------------------------------
> 
> Attached: trace-unplug-fast.out.xz, 2961 lines, controller 00:0d.2 only.
> 
> This one is captured differently. Instead of dumping by hand after noticing
> the blank screen, I hooked the dump to the kernel message itself, so it runs
> about one second after the event rather than minutes later. I also raised the
> ftrace ring buffer to 224M so nothing can be evicted.
> 
> Timeline for that capture:
> 
>   16:35:43   tbtrace clear + enable, buffer empty
>   16:41:18   1:11 DP OUT resource unavailable: adapter unplug
>   16:41:19   dump
> 
> Between arming and the event, 5 minutes 35 seconds, the buffer recorded
> exactly zero packets. The first entry in the trace is the display's own
> packet:
> 
>   [74467.055264] tb_event Hot Plug Event Packet Domain 0 Route 1 Adapter 11
>                    [00:05]  0xb  Adapter Num
>                    [31:31]  0x1  UPG
>   [74467.055287] tb_tx     Notification Packet -> HP_ACK
> 
> The whole trace spans 22 ms. The host's first action is the acknowledgement.
> 
> The graphics side matches. Between 16:36:00 and the unplug at 16:41:18 there
> is not a single AUX or DPCD access on either of that display's ports
> (USBC1/USBC2) in dmesg with drm.debug=0x104. The last one before that was a
> routine 0x00202 link status read four minutes earlier.
> 
> So there is no host-initiated access preceding the teardown at all, on either
> the AUX channel or the Thunderbolt control channel. If an MST register read
> were the trigger, it would have to appear here, and it does not.

Okay then, like you already suspect, this is not the firmware issue related
to the MST.

Since there is nothing the software is doing (well at least directly) to
cause this, I wonder if it could be related to some sort of power
management thing in the monitor itself? The second idea that comes to mind
is power supply but I guess you are using the stuff that came with the
monitor so it should provide the necessary power.

Based on your dump it also happens to both DP OUT adapters (11, 12) at the
same time.

Also, you connect the monitor with a real TB cable, right? I would think so
because the USB4 link comes up just fine.

You don't see any "usage" pattern there when this happens?

> MST disabled
> ------------
> 
> Tried it anyway, since you offered it as the way to confirm:
> 
>   /proc/cmdline                              i915.enable_dp_mst=0
>   /sys/module/i915/parameters/enable_dp_mst  N
> 
> No change. Two teardowns in the first six minutes after that boot, same
> signature. For comparison, the run before it had four in twelve minutes.

Thanks for checking!

> Second attachment, trace-unplug-mstoff.out.xz, is one of those events with
> MST off. Note it was dumped about five seconds after the event rather than
> one, so it carries the re-detection traffic as well; the signature at the top
> is the same.
> 
> > I think it was applied up to Panther Lake or so.
> 
> Then it should be active on this host, and the failure survives it either
> way. Combined with the empty trace above I would treat the MST path as ruled
> out unless Imre sees something I am missing.
> 
> 
> One observation I cannot place
> ------------------------------
> 
> After a teardown, tbtunnels still lists both DP tunnels as established, with
> bandwidth allocated:
> 
>   Route 0 Adapter 5  <-> Route 1 Adapter 11: DisplayPort   0/25920 Mb/s
>   Route 0 Adapter 6  <-> Route 1 Adapter 12: DisplayPort   0/8640 Mb/s
> 
> while the DRM connector is down and the screen is blank. Whether that is
> expected bookkeeping or a real mismatch I cannot judge.

This is not expected. What typically happens is that there is another
hotplug and the DP tunnels get re-established. This is what you may see
here but it's not visible in the log snippet you shared so I cannot
confirm. You should see in the log or trace that the tunnels get
re-established.

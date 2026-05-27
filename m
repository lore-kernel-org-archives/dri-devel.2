Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA66FCD6E45
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A5410E81C;
	Wed, 27 May 2026 14:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZvGfevqs";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD3210E577;
 Wed, 27 May 2026 14:04:20 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gQWZT4ly4z9tvF;
 Wed, 27 May 2026 16:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779890657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wd5htzRfLBGwibwUQk6XgZcfpjdhvIy1tNh3HyG0SI8=;
 b=ZvGfevqsj0s26ZioqgmqYP/Dr7HmLsJiRSxfUCYpHBdnDEc8SaLNc4nRt2whAxk1UAeJFC
 m8Wwig3odlhUEQ1gCAI3d52SlUvPB4/sGlQZ3lVVbnYvWr5Hw79vYK4pZrLCDa4m//Mbt1
 0ykyZ3z2zohSGAeU2UjP6gwCXQyhz8EVwSqeMfTxe8tWhx74LOkalUXrEFL07Qms94tctw
 hjFIwHb7WFCvYFonA6MxhBM4VmKTfJkky+y0ULRgsp7XXhYqVaMA5CtzevTNJ74W4C3zlN
 HjOlCVLLP3oABKNzLkdiDkxjPtTVPtuNTnxddJag+ye42fCRHIK8zdLF7FDrsg==
Message-ID: <ec64120b-c5e7-4622-9d21-84573d363443@mailbox.org>
Date: Wed, 27 May 2026 16:04:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, pekka.paalanen@collabora.com, jadahl@gmail.com,
 contact@emersion.fr, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260515120916.333614-1-tzimmermann@suse.de>
 <b5d03921-1e6f-4c4f-900e-fc9e28222176@mailbox.org>
 <cb461424-e4c1-4d2c-934b-ffd7374e2a56@mailbox.org>
 <4a7c2f87-60fd-458c-a579-a36799b86557@suse.de>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <4a7c2f87-60fd-458c-a579-a36799b86557@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rqxx3f1fpz8x483rfo6ubtay19g8ggmf
X-MBO-RS-ID: b673024b871ac3e9b15
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

On 5/27/26 15:07, Thomas Zimmermann wrote:
> Am 15.05.26 um 18:56 schrieb Michel Dänzer:
>> On 5/15/26 17:12, Michel Dänzer wrote:
>>> On 5/15/26 13:55, Thomas Zimmermann wrote:
>>>> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
>>>> refresh. This is meaningless with vblank timers, which run unrelated
>>>> to the hardware's vblank.
>>>>
>>>> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
>>>> for CRTCs with simulated vblank events in all such drivers. The vblank
>>>> timers of these devices still rate-limit the number of page-flip events
>>>> to match the display refresh.
>>>>
>>>> According to maintainers, user-space compositors do not require the ioctl
>>>> for rate-limitting display output. Weston and Kwin rely on page-flip
>>>> events. Mutter uses and internal timer to limit the number of display
>>>> updates per second.
>>> Actually mutter fundamentally relies on atomic commit completion events for that, same as Weston & KWin. Mutter uses the WAIT_VBLANK ioctl only for minimizing input → output latency (which can hide issues when completion of atomic commits isn't properly throttled).
>>>
>>>
>>> (Just a side not on the cover letter, no objections to the patches themselves)
>> After more discussion on IRC, I have some concerns.
>>
>>
>> The big one first: For drivers with no strict refresh cycle (i.e. an atomic commit can take effect more or less anytime after at least one "refresh cycle" has passed since the last one), does this change really make sense / what's the actual benefit?
> 
> I don't have a strong opinion on that matter. I just think we should clarify the meaning of these ioctls.
> 
> Timing page flip is currently not supported on any driver without hardware vblank IRQ or a vblank timer. The situation might vary among compositors, but there have been plenty of reports of animation and frame rates either being too high or too low.

As discussed on IRC, that's due to insufficient throttling of atomic commits in the kernel, not directly related to the functionality in this series.


> So I think we should rollout vblank timers for all drivers without hardware vblank IRQ.

I'm not arguing against that. It doesn't necessarily invalidate my concern though.


> Right now, vblank timers act like a vblank IRQ in these ioctls. That's a convenient position for user space.
> 
> But we don't really sync anything with hardware here, so the alternate proposal is to not support them.  This also appears to be the original intention of these ioctls.

Speaking as the creator of the DRM_IOCTL_WAIT_VBLANK ioctl, I'm afraid it's not that simple. While it's true that the ioctl was originally only available if backed by corresponding HW & driver support, that's mostly because vblank timers and the scenarios which motivated them weren't really a thing until much later though, not an explicit intention at the time.

I created it to give user space information about the display refresh cycle timing, and to allow it to synchronize to that. This seems like it could be useful even with vblank timers. At least if this ioctl and atomic commits are properly integrated, similar to how they are with a proper HW display refresh cycle, which I'm not sure is currently the case though.


> Vblank timers would just limit the internal page-flip rate, but nothing else. That's the more defensive approach.

If those two things aren't properly integrated though, then this might indeed be less bad than the status quo.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

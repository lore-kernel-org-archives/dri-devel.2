Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914BDC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E5F10E1E6;
	Thu, 27 Aug 2026 15:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=accessweb.be header.i=@accessweb.be header.b="CvKSNurG";
	dkim-atps=neutral
Received: from pan.awservers.eu (pan.awservers.eu [149.202.17.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59E910E1E6
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=accessweb.be; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RWYWQFXkeODc3doWR30hvgFUNe4Y5T/4MwtTcVuF9YA=; b=CvKSNurG7Cf/kSvjwRByyoduvc
 C8BKu/gK2mfczADhqhZ3T/6pt8N7GXdIJFoS39z8lK0IW/cO+gkW9Z82p8H0Z2wrOPhb5qxV89qs4
 J9/KeoP2TkSWGqPFvRAK9c+vPuHnwuVpauQoxl8Nrd3h88lJeF7huoE1YwTixTC0Z97QCueF4J/Ka
 H1s3lEpDc1SkF9TMAycfwM4zKJ4gWOOPA76WFhdU9VtJsTi00CZCfuJITFJRBy5yLNeTzTsaazz4p
 2Uio5WydhXM/1K2K4gumWT5VPIXCKcTmgUdWZnOViF8ycsGuNTfRCl6froOVR2DHty7jw9TP/Ntn/
 /zQ+07MQ==;
Received: from [195.240.176.17] (port=44304 helo=[192.168.2.230])
 by pan.awservers.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jellis@accessweb.be>)
 id 1wzblO-0000000Ahwt-0jwv; Thu, 27 Aug 2026 17:11:33 +0200
Message-ID: <b30024ff-e9bc-4123-8024-c4a431953a3a@accessweb.be>
Date: Thu, 27 Aug 2026 17:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
From: Jellis Onsea | AccessWeb <jellis@accessweb.be>
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
 <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
 <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
 <b0b0caf9-ca76-4f93-9495-d386d313fad1@accessweb.be>
 <7af1cbb9-bb99-462c-a3e4-c70d8fbd2dcb@broadcom.com>
 <5d110271-9a0d-4ba7-92e9-286ba557c16e@accessweb.be>
 <194908f7-fde4-4136-b535-86f21c27d967@broadcom.com>
 <ba7af534-c285-4075-929b-b2e37cd6bd65@accessweb.be>
Content-Language: en-US
In-Reply-To: <ba7af534-c285-4075-929b-b2e37cd6bd65@accessweb.be>
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

More data:

Now from `vmwgfx_gem_info` (3h uptime, KDE Wayland, three 1920x1080
outputs):

     kwin_wayland   18.5 GB   4054 objects   2068 of them >= 1920x1080x4
     plasmashell     1.0 GB   3383 objects    105
     Xwayland         33 MB      18 objects      3

kwin's GEM total and GPUActive rise together (+0.13 vs +0.10 GB over the 
same 5 min), and 570 of its objects are down to a single GEM ref. Growth 
is bursty and tracks render activity, not uptime.

Your patch did fix its own target: zero gem_close errors this boot.

One thing that may be worth a look: mesa 26.2.1 (libgallium) logs

     Failed referencing shared surface. SID <n>
     Error -22

572 times this boot, across 123 distinct surface IDs, 402 of them in the 
hour with five RDP sessions open. I can't tell you whether that is new 
the pre-patch boot had too little comparable activity to compare against.

Op 27-08-2026 om 15:39 schreef Jellis Onsea | AccessWeb:
> Tried the scanout patch on kernel 7.2.0. Confirmed running:
> `[drm] Initialized vmwgfx 2.22.0`.
> 
> No change here. GPUActive from /proc/meminfo:
> 
>      5 RDP sessions, 39 min open:   0.70 -> 3.97 GB
>      then 42 min at zero sessions:  3.92 -> 4.73 GB
> 
> Not a single sample went down. Same as on 2.21.
> 
> It also keeps growing with zero sessions and small usage of the machine, 
> so RDP is a good trigger, not the only one.
> 
> Build details if useful: distribution kernel (CachyOS 7.2.0-1), vmwgfx 
> built out-of-tree from the matching source with clang 22.1.8, no LTO.
> 
> 
> Regards,
> 
> Jellis
> 
> Op 27-08-2026 om 03:01 schreef Maaz Mombasawala:
>> On 8/26/26 7:17 AM, Jellis Onsea | AccessWeb wrote:
>>> Hi Maaz,
>>>
>>> Short version: mesa 26.2.1 is running here with 3D on, and the leak 
>>> is still there.
>>>
>>> Setup: one boot, 119 h, a single kwin_wayland (6.7.4), mesa 
>>> 3:26.2.1-1, kernel 7.2.0, renderer SVGA3D.
>>>
>>>    TTM sys+mob    0.36 -> 16.73 GB
>>>    objects        1948 -> 10365
>>>    kwin_wayland   holds 8484 MB in 4894 objects
>>>    free RAM       4.9 of 31 GB - we have to reboot today
>>>
>>> It tracks rendering, not uptime. Idle nights (02:00-07:00) in this 
>>> same boot:
>>>
>>>    22 Aug  -0.03 GB       25 Aug  +0.00 GB
>>>    23 Aug  +0.02 GB       26 Aug  +0.04 GB
>>>    24 Aug  +1.88 GB   <- the one night an automated GUI test run was 
>>> active
>>>
>>> The surface warning still fires: 1168 WARNING blocks at 
>>> vmw_surface_handle_reference in the last 27 hours. That is a window, 
>>> not a total - journald has already rotated away the earlier part of 
>>> this boot.
>>>
>>> Correction to my previous mail: "four times during session startup" 
>>> was wrong. It fires in bursts throughout the session.
>>>
>>> We have not tried "drm/vmwgfx: Return gem fd handle for scanout 
>>> buffers" we run distribution kernels here. Say the word and we will 
>>> build it.
>> Yes please, can you go ahead and try that patch, it fixes some errors 
>> on kde and might fix this issue you are facing too.
>>
>>> Best regards,
>>> Jellis
>>>
>>> Op 21-08-2026 om 04:09 schreef Maaz Mombasawala:
>>>> For the 3D-enabled case, could you try with mesa 26.1.8 or 26.2.1, 
>>>> both of which contain my fix.
>>>> Also if you could try the patch I just submitted on dri-devel - drm/ 
>>>> vmwgfx: Return gem fd handle for scanout buffers.
>>>> If you still see issues with these patches, let me know.
>>>>
>>>> As for the 3D disabled case, I can see issues on my local machine 
>>>> and am working on a fix.
>>>>
>>>> PS - Your emails are overly verbose and narrative, could you include 
>>>> only the actual problems you are facing.
>>>> If you're using an llm to write these, please make them more terse 
>>>> and human readable. Thanks.
>>>>
>>>
>>>
>>>
>>
>>
> 
> 

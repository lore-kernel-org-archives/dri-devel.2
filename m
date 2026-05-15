Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74E5CD4F47
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 16:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6A710E443;
	Fri, 15 May 2026 16:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UvGbHkwM";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12A010E416;
 Fri, 15 May 2026 16:56:52 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gHCz53wg2z9vGy;
 Fri, 15 May 2026 18:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778864209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THjYyH3uKjG/pqf0jTnTgVB5bOzHeeCO4NiACkPzCAA=;
 b=UvGbHkwMnE9NToXjbUNAsRia0LLJVuP/0ZjKLW6ppzyZhQjhcZMz+u2V8owicjpL+qc90x
 pT7ZRQpu3L7J/espeI8XH0yqUTi+/i2ei6D7Q8t89DylkuCkHKVKrHCQEmuwomb8THbO3P
 91TGgfWvRRM9aDNcdFxJddbLX7rHhYCfeEQM9BMv8jVPLYkLJttn+s8blSnzZrQ7w4Zngr
 WguOA7Ic/8jY+ANKQcdlrSdKDBFHC01WR1Sd0WAXYVjIJ/2tvmWFCYnG6mUGIFsWN9Ov4o
 dEMrs8Wdc8pkp+8WiAxu+ggIsRS0RPxrIimKc2/m8fDZxG3ZR6G22gMMbLpY/Q==
Message-ID: <cb461424-e4c1-4d2c-934b-ffd7374e2a56@mailbox.org>
Date: Fri, 15 May 2026 18:56:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 airlied@gmail.com, pekka.paalanen@collabora.com, jadahl@gmail.com,
 contact@emersion.fr, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260515120916.333614-1-tzimmermann@suse.de>
 <b5d03921-1e6f-4c4f-900e-fc9e28222176@mailbox.org>
Content-Language: en-CA
In-Reply-To: <b5d03921-1e6f-4c4f-900e-fc9e28222176@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: de84221aa493230eab5
X-MBO-RS-META: 9sey5mwxehe7tcisizu96h4qcw6kgr1r
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


[ Adding the wayland-devel list for awareness ]

On 5/15/26 17:12, Michel Dänzer wrote:
> On 5/15/26 13:55, Thomas Zimmermann wrote:
>> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
>> refresh. This is meaningless with vblank timers, which run unrelated
>> to the hardware's vblank.
>>
>> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
>> for CRTCs with simulated vblank events in all such drivers. The vblank
>> timers of these devices still rate-limit the number of page-flip events
>> to match the display refresh.
>>
>> According to maintainers, user-space compositors do not require the ioctl
>> for rate-limitting display output. Weston and Kwin rely on page-flip
>> events. Mutter uses and internal timer to limit the number of display
>> updates per second.
> 
> Actually mutter fundamentally relies on atomic commit completion events for that, same as Weston & KWin. Mutter uses the WAIT_VBLANK ioctl only for minimizing input → output latency (which can hide issues when completion of atomic commits isn't properly throttled).
> 
> 
> (Just a side not on the cover letter, no objections to the patches themselves)

After more discussion on IRC, I have some concerns.


The big one first: For drivers with no strict refresh cycle (i.e. an atomic commit can take effect more or less anytime after at least one "refresh cycle" has passed since the last one), does this change really make sense / what's the actual benefit?

In the case of the asahi & nvidia drivers, the problem with exposing this functionality to user space is that if the timestamps aren't accurate, it can result in missing display refresh cycles, which are dictated by hardware. That's why it makes sense to reject it there.

When there's no strict refresh cycle, that issue doesn't apply though.


Any changes made to the WAIT_VBLANK ioctl should also be made to the CRTC_GET_SEQUENCE / CRTC_QUEUE_SEQUENCE ioctls, which are slightly different UAPI for the same functionality.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

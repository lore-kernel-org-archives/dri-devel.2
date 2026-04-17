Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D292EF8E4B9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE27210E987;
	Fri, 17 Apr 2026 07:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CNx7Q47L";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876CF10E987;
 Fri, 17 Apr 2026 07:49:46 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fxn8k6qCTz9v66;
 Fri, 17 Apr 2026 09:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776412183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NP0kAekaa2ov7K7RoabALih+bni78kUN1FqC+MXu/6o=;
 b=CNx7Q47LTj2RRombmcP2AZRJtEaC9oB+382SYU0ayLOayYFLxYRLgTC+mZKHj2X8KJgXsR
 3TnLBzJ5+OO5mRevEa1TAkX5xGaSbr95J9gGG/RBta2iXgJithNzazMo3RZut1vXu2GoQN
 Vpny2z5BONKoCg/Lch5NKLfTHkszTaJC3Y+ohq8XPqu5qJvOvMEdF8yWi1akzTW4+OKGSQ
 U/FdWFiWBF+f3oZi94pnISA5eygq68qpLgZu50NzKE1BO8nCFL+tVQVn5XarmSmisYsy/R
 XBlAJu684+n5dKZxg/4R0ox+xjakswraB5Ey5FHJTEjxCsTWPUfUVyfYVfj95A==
Message-ID: <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
Date: Fri, 17 Apr 2026 09:49:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: Julian Orth <ju.orth@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 85b75146d8ac7ff98e9
X-MBO-RS-META: g8uypwikiihxm1pnnxjcqwjy66yp8hbs
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

On 4/16/26 15:16, Julian Orth wrote:
> On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
>> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
>>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
>>> <nicolas.frattaroli@collabora.com> wrote:
>>>>
>>>> This series addresses a shortcoming whereby a hot plug event is sent
>>>> without it being passed the actual connector that caused it. This takes
>>>> into consideration both the polling path and the HPD (Hot Plug Detect)
>>>> path. It also adds support for the vkms driver (using ConfigFS) for
>>>> propagating the connector ID when changing the connector's status.
>>>>
>>>> The motivation is that user-space applications such as Weston would
>>>> previously receive non-connector-specific hotplug events, and then have
>>>> to figure out themselves which connector needs to have a modeset
>>>> executed on. This notably did not work when the hotplug events came in
>>>> too fast, resulting in Weston missing an on-off-on transition of a
>>>> connector, seeing that its state was unchanged from "on" so can't be the
>>>> one that was hotplugged, and skipping reinitialising it as it looks
>>>> through the other connectors that could've caused it.
>>>
>>> Have you considered adding a u64 serial number as a DRM connector
>>> property that is incremented every time the connector changes in some
>>> way? Userspace could then check this serial number to see if the
>>> connector has changed since the last time it queried the serial
>>> number.
>>
>> The connector internally already has an epoch_counter member which
>> could be used for this. However, for the particular thing this
>> series fixes, I don't think exposing it through the uAPI is necessary
>> or desirable. Sending hotplug events specific to the connector does
>> not need any additional handling on the userspace side as long as it
>> already listens to the per-connector hotplug events in order to
>> avoid the pitfall described in the cover letter.
> 
> I currently do not handle per-connector hotplug events. Instead,
> whenever I get a UDEV change event for a device, I re-fetch the entire
> kernel state for the device. That is
> 
> - DRM_IOCTL_MODE_GETRESOURCES
> - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> 
> Once I have the new state, I compare it against the desired compositor
> state and perform a modeset if necessary.

mutter is doing something similar as well.


Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.

The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again. A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)


If this "modeset required after hotplug event" rule is confirmed, it means that after a hotplug event without connector ID, the compositor must do a modeset for all connectors.


P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#note_2984697 even argued that two modesets are required after a hotplug event, one which turns things off and another one which turns them on again. I don't agree with that though, a single modeset should suffice.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

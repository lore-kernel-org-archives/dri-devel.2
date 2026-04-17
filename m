Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821EBF436BD
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E01E310EA71;
	Fri, 17 Apr 2026 16:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nhc4usVX";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E74C10EA71;
 Fri, 17 Apr 2026 16:41:00 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fy0xj3KdLz9smP;
 Fri, 17 Apr 2026 18:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776444057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU5aiIBZVEWvROhGYNg2ix3jXKRsWSsQAwqKNG72aug=;
 b=nhc4usVXvFfYQ6wFYHZV7G//EmYBoYra0k1XN5hG/rT1f0BmfPoX51DpRQg2AM9wEgiGkF
 gETtmfMy1etsuW0KtYD18kqGhTUgEKuXVxQCBKuww4ESSliriMz6k/JE5zstZw2BUnxqsK
 AXTpmNKqtuWYBF0ZVR8brlEXaipSXG7Vv4vkIhOd3MJVEurPnbO3HNU2E+cy+DKveLgF8Y
 4rmEGx75YCgng/TycFohoAeUwTi6ukKOescfN2+UFZhuStkTBHxpqaM/+LrpXhnddav2YN
 b7brI8AAcoMEe3FdpVWzSIIGtoG1jjm+xLvAc8cxjIFmrChV/PwQasKvzhgYwA==
Message-ID: <3196f1fc-f241-4295-b5b8-380ee93e95da@mailbox.org>
Date: Fri, 17 Apr 2026 18:40:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Julian Orth <ju.orth@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
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
 Marius Vlad <marius.vlad@collabora.com>, Imre Deak <imre.deak@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com>
 <63a3d617-6603-438c-b22b-62acedb951e1@mailbox.org>
 <aeJJ4lKAZDwBuW_U@intel.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <aeJJ4lKAZDwBuW_U@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 35sqx8azd4gs8b6cucsunyatnyxt71zb
X-MBO-RS-ID: 5b47d5af7214ecb4a0e
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

On 4/17/26 16:55, Ville Syrjälä wrote:
> On Fri, Apr 17, 2026 at 04:17:45PM +0200, Michel Dänzer wrote:
>> On 4/17/26 12:57, Ville Syrjälä wrote:
>>> On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel Dänzer wrote:
>>>> On 4/16/26 15:16, Julian Orth wrote:
>>>>> On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
>>>>> <nicolas.frattaroli@collabora.com> wrote:
>>>>>> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
>>>>>>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
>>>>>>> <nicolas.frattaroli@collabora.com> wrote:
>>>>>>>>
>>>>>>>> This series addresses a shortcoming whereby a hot plug event is sent
>>>>>>>> without it being passed the actual connector that caused it. This takes
>>>>>>>> into consideration both the polling path and the HPD (Hot Plug Detect)
>>>>>>>> path. It also adds support for the vkms driver (using ConfigFS) for
>>>>>>>> propagating the connector ID when changing the connector's status.
>>>>>>>>
>>>>>>>> The motivation is that user-space applications such as Weston would
>>>>>>>> previously receive non-connector-specific hotplug events, and then have
>>>>>>>> to figure out themselves which connector needs to have a modeset
>>>>>>>> executed on. This notably did not work when the hotplug events came in
>>>>>>>> too fast, resulting in Weston missing an on-off-on transition of a
>>>>>>>> connector, seeing that its state was unchanged from "on" so can't be the
>>>>>>>> one that was hotplugged, and skipping reinitialising it as it looks
>>>>>>>> through the other connectors that could've caused it.
>>>>>>>
>>>>>>> Have you considered adding a u64 serial number as a DRM connector
>>>>>>> property that is incremented every time the connector changes in some
>>>>>>> way? Userspace could then check this serial number to see if the
>>>>>>> connector has changed since the last time it queried the serial
>>>>>>> number.
>>>>>>
>>>>>> The connector internally already has an epoch_counter member which
>>>>>> could be used for this. However, for the particular thing this
>>>>>> series fixes, I don't think exposing it through the uAPI is necessary
>>>>>> or desirable. Sending hotplug events specific to the connector does
>>>>>> not need any additional handling on the userspace side as long as it
>>>>>> already listens to the per-connector hotplug events in order to
>>>>>> avoid the pitfall described in the cover letter.
>>>>>
>>>>> I currently do not handle per-connector hotplug events. Instead,
>>>>> whenever I get a UDEV change event for a device, I re-fetch the entire
>>>>> kernel state for the device. That is
>>>>>
>>>>> - DRM_IOCTL_MODE_GETRESOURCES
>>>>> - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
>>>>> - DRM_IOCTL_MODE_GETCONNECTOR for each connector
>>>>> - DRM_IOCTL_MODE_GETPROPERTY for each connector property
>>>>> - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
>>>>>
>>>>> Once I have the new state, I compare it against the desired compositor
>>>>> state and perform a modeset if necessary.
>>>>
>>>> mutter is doing something similar as well.
>>>>
>>>>
>>>> Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.
>>>>
>>>> The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again.
>>>
>>> GPU reset should relight the display on its own really. That's what
>>> i915 does, albeit somewhat badly at the moment.
>>>
>>>> A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)
>>>
>>> There's nothing preventing the kernel from doing extra atomic
>>> commits whenever it wants.
>>
>> I made that same argument at first.
>>
>> Then it occurred to me the kernel-internal atomic modeset commit could cause spurious EBUSY failures for user-space atomic commits overlapping with it.
> 
> Not so. Everything just gets blocked on the kms mutexes and the -EBUSY 
> stuff never even comes into play.

Makes things easier in that case. I followed up accordingly in the other thread.


>>> But if you want to punt the thing to userspace then the kernel must set the link-status
>>> property to bad, and then fire the hotplug uevent.
>>
>> I later suggested using the link-status property for this as well.
>>
>> Checking with others on IRC and reading documentation / code though, I realized my recollection of its semantics was wrong, it actually doesn't look suitable for this. In particular, the expected user space response to link-status bad is to set a *different* mode (since the mode may be relevant for the link failure), not the same one which was already set.
> 
> The expected response it to retry with the same mode, at least if
> that mode is still on the connector's mode list. If the mode got
> pruned then there's perhaps no point in trying it again.

On re-reading the link-status documentation in drivers/gpu/drm/drm_connector.c, I agree.

I'm afraid you're optimistic in terms of user space support for link-status though.

Neither mutter nor weston even look at it yet.

KWin reacts to link-status bad with a modeset, not sure it handles the current mode disappearing though. Seems good enough for the scenarios we're discussing here.

wlroots seems to handle it properly.

(Any compositors which don't handle it yet need to be fixed, just pointing out it might not make a difference with existing releases of some of them)


>>> I think the userspace behaviour there was that you get a disconnected,
>>> defer processing it, and then you get a reconnect, and then decide that
>>> nothing actually changed and a modeset is not needed after all. That is
>>> not correct IMO. Clearly a ->disconnect->reconnect should count as a
>>> change in the connector's state, and a full modeset is thus required.
>>
>> While that makes sense to me in principle, as Julian pointed out, the kernel can't rely on user space seeing the intermittent disconnected state.
>>
>> Seems like another argument for a serial number property. That would make the need for a modeset unambiguous.
> 
> [...]
> 
> But for the case where the kernel only sends the per-connector uevents
> and the drm master sees all of them the serial number would do nothing.
> In that case the kernel wouldn't even send the uevent unless the
> serial number has changed.

The serial number is still necessary in cases where status flip-flops connected → disconnected → connected, user space never sees the disconnected state though.


>> Note that the referenced issue is about a different scenario though:
>>
>> 1. mutter does modeset for DPMS off
>> 2. hotplug events during DPMS off (presumably triggered by the monitor scanning its inputs)
>> 3. mutter does modeset for DPMS on
>>
>> The monitor stays off after step 3. The argument in the comment I referenced is that mutter should repeat step 1 before step 3.
> 
> That can't be it. We don't do anything if you try to disable an already  
> disabled output. And the analysis of the logs indicated that the disable
> (DPMS off) was completely missing.
The mutter debug log in https://gitlab.gnome.org/GNOME/mutter/-/issues/4145#note_2457199 disagrees.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

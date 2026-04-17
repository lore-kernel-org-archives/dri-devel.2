Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BC1F436AF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DA310EA4C;
	Fri, 17 Apr 2026 14:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="A/CJx6AF";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D37C10EA4C;
 Fri, 17 Apr 2026 14:30:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fxy2X5Kbkz9v5D;
 Fri, 17 Apr 2026 16:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776436196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9luBvWbMccbxOvE8WL3Ho7bBbkb1tIa3KWAab3Ol6ao=;
 b=A/CJx6AFn95ByQf1fgzitPKkYnFyl/mdp6FalIKcpJxb6GZA8c5BCujqSF8GP+d/kmnsDe
 6Z9v0frtValJFrrZo3I02OE7L4JOO1yGloJFZSDhnu575H6cV5L/gTb9FqSIZEOBx+25Ht
 NWFK1SkKCFfqiUxtDMyVP+P0opcPSl/LvGah1Vui0u2qvMeksjMncCj98IQ8qiPmm0CBUg
 ItuvO7tujRTgcetz8Nd1cBeHvMHdEreoJBULT5t0mXKt4WzPeGXP+oH9WgS6WcWYoGpq3K
 IZb9AmNG4zBlNPlS/k6UpNYyQfMB+Ag/GBl1SHyJUAySt9YyOU2WeOiiK3Gu2g==
Message-ID: <d8846d4a-4fc2-423c-b031-79a6a49fd2d6@mailbox.org>
Date: Fri, 17 Apr 2026 16:29:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Julian Orth <ju.orth@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
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
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <CADnq5_NRY1h6Z3R3faDPHfHqZL7ZkDPKpOFk7WXSm09DsDH5zw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CADnq5_NRY1h6Z3R3faDPHfHqZL7ZkDPKpOFk7WXSm09DsDH5zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4c00fdf2c9dc99df4a3
X-MBO-RS-META: p58166iyrtb6h1payj3jzws391dy3171
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

On 4/17/26 16:25, Alex Deucher wrote:
> On Fri, Apr 17, 2026 at 3:49 AM Michel Dänzer
> <michel.daenzer@mailbox.org> wrote:
>> On 4/16/26 15:16, Julian Orth wrote:
>>> On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
>>> <nicolas.frattaroli@collabora.com> wrote:
>>>> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
>>>>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
>>>>> <nicolas.frattaroli@collabora.com> wrote:
>>>>>>
>>>>>> This series addresses a shortcoming whereby a hot plug event is sent
>>>>>> without it being passed the actual connector that caused it. This takes
>>>>>> into consideration both the polling path and the HPD (Hot Plug Detect)
>>>>>> path. It also adds support for the vkms driver (using ConfigFS) for
>>>>>> propagating the connector ID when changing the connector's status.
>>>>>>
>>>>>> The motivation is that user-space applications such as Weston would
>>>>>> previously receive non-connector-specific hotplug events, and then have
>>>>>> to figure out themselves which connector needs to have a modeset
>>>>>> executed on. This notably did not work when the hotplug events came in
>>>>>> too fast, resulting in Weston missing an on-off-on transition of a
>>>>>> connector, seeing that its state was unchanged from "on" so can't be the
>>>>>> one that was hotplugged, and skipping reinitialising it as it looks
>>>>>> through the other connectors that could've caused it.
>>>>>
>>>>> Have you considered adding a u64 serial number as a DRM connector
>>>>> property that is incremented every time the connector changes in some
>>>>> way? Userspace could then check this serial number to see if the
>>>>> connector has changed since the last time it queried the serial
>>>>> number.
>>>>
>>>> The connector internally already has an epoch_counter member which
>>>> could be used for this. However, for the particular thing this
>>>> series fixes, I don't think exposing it through the uAPI is necessary
>>>> or desirable. Sending hotplug events specific to the connector does
>>>> not need any additional handling on the userspace side as long as it
>>>> already listens to the per-connector hotplug events in order to
>>>> avoid the pitfall described in the cover letter.
>>>
>>> I currently do not handle per-connector hotplug events. Instead,
>>> whenever I get a UDEV change event for a device, I re-fetch the entire
>>> kernel state for the device. That is
>>>
>>> - DRM_IOCTL_MODE_GETRESOURCES
>>> - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
>>> - DRM_IOCTL_MODE_GETCONNECTOR for each connector
>>> - DRM_IOCTL_MODE_GETPROPERTY for each connector property
>>> - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
>>>
>>> Once I have the new state, I compare it against the desired compositor
>>> state and perform a modeset if necessary.
>>
>> mutter is doing something similar as well.
>>
>>
>> Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.
>>
>> The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again. A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)
>>
>>
>> If this "modeset required after hotplug event" rule is confirmed, it means that after a hotplug event without connector ID, the compositor must do a modeset for all connectors.
>>
> 
> One thing we've run into is how to deal with hotplugs over suspend.
> If you suspend your system, amdgpu sends a hotplug event on resume in
> case anything got changed while the system was suspended.  However, we
> can also suspend the driver at runtime and we use the same path so
> when the driver runtime resumes, it also sends a hotplug event.  This
> is probably fine in most cases, but there are some problematic corner
> cases.  E.g., while the GPU is runtime suspended, if the monitors are
> in DPMS off, and then a rendering command comes in or something else
> that wakes the GPU, we send a hotplug event on resume and then
> userspace lights up the monitors again which is not what the user
> wants if the monitors are in DPMS off and the topology hasn't changed.

I should have been more specific: "after a hotplug event without connector ID, the compositor must do a modeset for all connectors *when it wants them to be on*", i.e. not necessarily immediately, and only for connectors it wants to be on.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

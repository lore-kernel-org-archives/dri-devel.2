Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27275F89249
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0EE10E84D;
	Tue, 21 Apr 2026 10:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rcx5wKe3";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0FC10E84D;
 Tue, 21 Apr 2026 10:13:44 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g0J905FVcz9v0b;
 Tue, 21 Apr 2026 12:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776766421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIvFVx7Gg7FStujpJTSUXzQWmcOuebhE4Q4g6bSH/MY=;
 b=Rcx5wKe3mNRXaHCVnKfrVjmE1Uh1gZHMg3KCp3fd+KdMLA8C6rGIeGrn/D9XN2NJobSbJl
 oGyrKChOarHX/ONFgt4lF8CXLA8Lub1gtQLlX7Rv6OOclYl5qefvYmDRt4iTTvf+F8yTWq
 r+LWtEFbyjCu+8/ZikNNKJd5AZiq2Dm1wHNiX1LfQXcdgzCm9vjiiTve1X52Ugx/H7yv+R
 MFu+bMh/bY+E3/8NFsV1DVEGxJUPRyID0U5KzpxlpENELc9/npOWAyzrbPXPLnJQvMrxlC
 gp8h0zYUsHhUhn4qUFheLpjQJAth96HlMKseMItEhbYnUUkKCEf7hHDXscGVQw==
Message-ID: <bcd00cbe-ba89-4927-a295-726856ab3d9c@mailbox.org>
Date: Tue, 21 Apr 2026 12:13:34 +0200
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
 <3196f1fc-f241-4295-b5b8-380ee93e95da@mailbox.org>
 <aeKA6D7Iei612FKa@intel.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <aeKA6D7Iei612FKa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sxmn7bqf8tpeirjye8w1qjiojhpg8cau
X-MBO-RS-ID: c505113c642c54519c9
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

On 4/17/26 20:50, Ville Syrjälä wrote:
> On Fri, Apr 17, 2026 at 06:40:51PM +0200, Michel Dänzer wrote:
>> On 4/17/26 16:55, Ville Syrjälä wrote:
>>> On Fri, Apr 17, 2026 at 04:17:45PM +0200, Michel Dänzer wrote:
>>>> On 4/17/26 12:57, Ville Syrjälä wrote:
>>>>>>>>>> I think the userspace behaviour there was that you get a disconnected,
>>>>> defer processing it, and then you get a reconnect, and then decide that
>>>>> nothing actually changed and a modeset is not needed after all. That is
>>>>> not correct IMO. Clearly a ->disconnect->reconnect should count as a
>>>>> change in the connector's state, and a full modeset is thus required.
>>>>
>>>> While that makes sense to me in principle, as Julian pointed out, the kernel can't rely on user space seeing the intermittent disconnected state.
>>>>
>>>> Seems like another argument for a serial number property. That would make the need for a modeset unambiguous.
>>>
>>> [...]
>>>
>>> But for the case where the kernel only sends the per-connector uevents
>>> and the drm master sees all of them the serial number would do nothing.
>>> In that case the kernel wouldn't even send the uevent unless the
>>> serial number has changed.
>>
>> The serial number is still necessary in cases where status flip-flops connected → disconnected → connected, user space never sees the disconnected state though.
> 
> I suppose that could happen if the flip flop is fast enough that the
> status has changed back to connected by the time userspace gets to
> process the first uevent. Although the fact that the uevent was sent
> in the first place (assuming it's the per-connector one) would imply
> that something did in fact change.

There are cases where hotplug events get triggered despite nothing changing from the user PoV,
e.g. due to monitors polling their other inputs. Reacting to such hotplug events can have various undesirable side effects, that's why compositors are trying to avoid it.

> But I do agree that having a clear signal in the form of the changed serial
> number would avoid a lot of weird guesswork in userspace.

Either that, or setting link-status to bad, yeah.

In the scenario we're discussing here, the latter might be even clearer actually, since a modeset isn't always required.


>>>> Note that the referenced issue is about a different scenario though:
>>>>
>>>> 1. mutter does modeset for DPMS off
>>>> 2. hotplug events during DPMS off (presumably triggered by the monitor scanning its inputs)
>>>> 3. mutter does modeset for DPMS on
>>>>
>>>> The monitor stays off after step 3. The argument in the comment I referenced is that mutter should repeat step 1 before step 3.
>>>
>>> That can't be it. We don't do anything if you try to disable an already  
>>> disabled output. And the analysis of the logs indicated that the disable
>>> (DPMS off) was completely missing.
>> The mutter debug log in https://gitlab.gnome.org/GNOME/mutter/-/issues/4145#note_2457199 disagrees.
> 
> I only see two modeset commits in that log. Both with CRTC 134 being
> enabled with connector 250. So far I can't find any DPMS off in there.
> Am I just blind?

It's subtle, line 12498:

[...] gnome-shell[2418]: KMS: [atomic] Committing disable-device transaction

(The issue is about the monitor not turning on after DPMS off, i.e. it does enter DPMS off in the first place :)

I do see now that the hotplug events happen only after mutter's modeset for DPMS on though (I previously mistook that for the modeset for DPMS off). The second modeset is presumably after switching to another VT and back.


In summary, the link-status property seems the best mechanism for solving this issue. I filed https://gitlab.gnome.org/GNOME/mutter/-/work_items/4760 about handling it in mutter.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

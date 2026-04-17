Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C70F436BA
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5494010EA4A;
	Fri, 17 Apr 2026 16:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wGZcKlC+";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3355310E2C9;
 Fri, 17 Apr 2026 16:08:16 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fy0Cw1dHpz9v1C;
 Fri, 17 Apr 2026 18:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776442092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEOhFI6FMsYr3RqKHmLgf8SxXkclhRS7RnspH6Yfq0g=;
 b=wGZcKlC+Heacy4BW43Xr5h4S0JK+GbQFfYPP3fnrP0ScSl5R91M/E+N/PWsw4j2pz1/X6c
 sEVZeQYT6XwXuLafjnxY0TlAJAQYSeVpt8lOyZoTS7hDL2PjDDnKiKWN4lnyf9vzB4IQ+8
 k7wExmm+GYZvNHjTUwJCBtOOPG4KhZeiWz1uTX/cvWS3ZhQOcC4Lh2BM+dRT4YpZaVLW8F
 aOLw1GHNqv91vKq3ZLai/lF81MnNgzLklhe16aFF2CEr6HqF0Dj+I9nVmT3uCqbgwGHINI
 s+q2g6lbbZ/zVHcPfzYu+X2EdxvrNqFlL2GMxYNjGs314r90X/W3F/+48E8Hkw==
Message-ID: <07072379-32c8-4912-8539-7fa590abf544@mailbox.org>
Date: Fri, 17 Apr 2026 18:08:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] drm: introduce KMS recovery mechanism
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20260212230905.688006-1-someguy@effective-light.com>
 <2e359cd9-0192-44d0-886f-7f93a8b0a4fa@amd.com> <aY99D-yXVydpMdwy@hal-station>
 <85319290-4027-4eb8-95d1-9009d23f2294@mailbox.org>
 <aZD0W7V_6--2yqNK@hal-station>
 <7f4a86ad-d642-444c-a576-17ff9caaa934@mailbox.org>
 <aZULq2bDnZpdXvIg@hal-station>
 <8588dcbc-621e-43db-9d69-32398f75d9e6@mailbox.org>
 <dab8d21b-1d28-48c6-87bf-f2060e2d2f1e@mailbox.org>
 <d7c7a96e-1686-4878-8b96-92c3427b2f6d@mailbox.org>
Content-Language: de-CH-frami, en-CA
In-Reply-To: <d7c7a96e-1686-4878-8b96-92c3427b2f6d@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7bd649e8221e05cb222
X-MBO-RS-META: 9tfp87rtgrzx9dptw3urqkdx3rj9fxm5
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

On 2/20/26 10:09, Michel Dänzer wrote:
> On 2/20/26 09:42, Michel Dänzer wrote:
>> On 2/18/26 10:22, Michel Dänzer wrote:
>>> On 2/18/26 01:45, Hamza Mahfooz wrote:
>>>> On Mon, Feb 16, 2026 at 10:28:13AM +0100, Michel Dänzer wrote:
>>>>> On 2/14/26 23:16, Hamza Mahfooz wrote:
>>>>>> On Sat, Feb 14, 2026 at 03:02:49PM +0100, Michel Dänzer wrote:
>>>>>>
>>>>>>> In principle it's possible to do (the equivalent of) a modeset with the current state for all CRTCs, no need to do it separately per CRTC.
>>>>>>
>>>>>> AFAIK that is what the uevent is already doing (unless I'm mistaken).
>>>>>
>>>>> This is about just doing a full modeset, which isn't something user space can do in response to a wedged event.
>>>>
>>>> I was referring to what compositors are doing in response to
>>>> `drm_kms_helper_hotplug_event()`. Perhaps, the enum constants should be
>>>> renamed, since the forced modeset is actually sent when the current
>>>> reset phase is DRM_KMS_RESET_NONE (the phase is updated before sending
>>>> out the event though).
>>>
>>> Ah, you're talking about the drm_kms_helper_hotplug_event call in drm_atomic_helper_wait_for_flip_done (I thought "uevent" referred to drm_dev_wedged_event in patch 2).
>>>
>>> I don't know about other compositors, but I don't think mutter will do a modeset in response to a hotplug event if no KMS state changed (because some monitors can generate spurious hotplug events).
>>
>> [...]
> 
> [...], a reason why the kernel can't just do a modeset itself occurred to me: A modeset might affect other CRTCs than the ones affected by the timed-out commit, which could interact badly with other pending commits affecting those other CRTCs.

In a different thread, Ville (added to Cc) said this shouldn't be an issue.

In which case this would seem like the simplest solution.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

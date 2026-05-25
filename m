Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75D3CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 18:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D6C10E3C4;
	Mon, 25 May 2026 18:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A24EMPyu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44B210E351;
 Mon, 25 May 2026 18:21:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 610D5405D2;
 Mon, 25 May 2026 18:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8B91F000E9;
 Mon, 25 May 2026 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779733263;
 bh=VXDb5A0uSCQP6fsSMHl0AF2XjVwmNMmezTZK1i26vFY=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=A24EMPyuiypyiRvqkQSpHlW43BUlkR3C3PiuhqMsMvBjgwuYrzDxELvoVGXot69Dk
 5o3vVaT+HkNLHTaHQyonKx1KxHWz7UZqdL4ScKoKvoSCpfN37vfSZQ5jX61mUN3sKi
 aJaiAXuddz4f6oHw1Jlt+6e+Z2Cxvg+9xYxun9UR20MxjrCg0QK+clwdSiYaE3C/U+
 EaCtz09i0QZJtosPhoh49s+Euo847Ao/hW2k2Twm0s5BrWqKUqob9fQjx5iqPRTD0E
 s7+SQETnmGjAAG5H4WPgo3vzkN5gxVyEt6KW4Hni6Cyyo5gGI2BUkdD1J1W3+zo8J6
 TmfHJeIQtA0uQ==
Message-ID: <e5bdc43c-6a3d-4e75-ad9d-721aaf7988bd@kernel.org>
Date: Mon, 25 May 2026 13:20:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add support for a DRM backlight capability
From: Mario Limonciello <superm1@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <CA+hFU4wEODFP=oPw522MyQs1asGq+KyYw6rcKpxxxj0y75fPXg@mail.gmail.com>
 <ece17b5e-143e-4196-8b07-57efff2e3954@kernel.org>
Content-Language: en-US
In-Reply-To: <ece17b5e-143e-4196-8b07-57efff2e3954@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 5/23/26 9:14 PM, Mario Limonciello wrote:
> 
> 
> On 5/11/26 6:11 PM, Sebastian Wick wrote:
>> On Sat, Apr 25, 2026 at 12:10 AM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> From: Mario Limonciello (AMD) <superm1@kernel.org>
>>>
>>> At Display Next Hackfest 2025 we discussed the renewed need for moving
>>> brightness control into the DRM connector properties.  I've taken the
>>> previous efforts from David and Marta, rebased and adjusted for the
>>> current kernel.
>>
>> Thanks a lot for this!
> 
> Sure!
> 
>>
>> I've wired it up for mutter but I don't have a machine with AMD
>> graphics and an internal panel, so I can't really test it.
>>
>> https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
> 
> Awesome!  I have been caught up with a few other things so I haven't 
> been able to give this a shot, but wanted to before the hackfest.
> 
> But I have never used a dev version of mutter, so can you give me a 
> little hand holding or pointers?
> 
> I was able to build/install your branch into /usr/local.  I otherwise 
> have GNOME 50 set up on this system.
> How do I actually "use" the mutter built from your dev branch?
> 
> Will picking GNOME session at my login manager pick mutter from /usr/ 
> local or do I need to do anything?
>>
>> I've also noticed a few things while doing so:
>>
>> 1. There isn't a bit of information which tells user space if the
>> property is actually backed by anything
>> 2. A fixed range from 0 to uint16_t max might be problematic for
>> backlights with very few steps

I managed to do this - you tell me if it was an accurate enough test.

1) I built your tree and installed it to /usr/local.
2) I switched to a VT and launched mutter like this.

# dbus-run-session /usr/local/bin/mutter --wayland -- konsole

3) From that konsole session I ran commands like this to change brightness.

# ./tools/gdctl show

I then confirmed the range showed up.

Monitors:
└──Monitor eDP-1 (Built-in display)
    ├──Vendor: BOE
    ├──Product: NE135A1M-NY1
    ├──Serial: 0x00000000
    ├──Current mode
    │   └──2880x1920@120.000
    └──Preferences
        └──Backlight:
            ├──active ⇒  True
            ├──min ⇒  655
            ├──max ⇒  65535
            └──value ⇒  22938

Then I did the following to change.

# ./tools/gdctl prefs --monitor "eDP-1" --backlight 12938
# drm_info | grep LUMINANCE
# ./tools/gdctl prefs --monitor "eDP-1" --backlight 22938
# drm_info | grep LUMINANCE

I did observe the brightness visibly changed on the panel as did the 
value of LUMINANCE in the properties.

>>
>> Could maybe fix both of those issues by making the range dynamic to
>> the actual numbers of steps, where zero means that there isn't any
>> backing backlight device.
> 
> I'll play with this idea and see how well it works.
>>
>>> The legacy sysfs interface is synchronized with the DRM connector 
>>> (although
>>> the scale may be different as DRM connector property is u16).
>>>
>>> Later after this has been adopted by enough userspace, it may make 
>>> sense to
>>> configure the legacy sysfs interface to be configurable so that only
>>> DRM master controls backlight.
>>>
>>> I've done a first implementation with amdgpu with eDP connectors; but
>>> conceivably this can be extended to other connectors like DP for 
>>> displays
>>> that can be controlled via DDC as well later.
>>>
>>> I have also used DRM review prompts to review this series and fix 
>>> some bugs
>>> which were caught with two different Claude models.  The fixes are 
>>> squashed
>>> into the patches.
>>>
>>> Assisted-by: Claude Opus
>>> Assisted-by: Claude Sonnet
>>>
>>> For ease of testing; this series is also available on this branch:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/ 
>>> log/?h=superm1/backlight-property-v3
>>>
>>> David Rheinsberg (1):
>>>    backlight: add kernel-internal backlight API
>>>
>>> Mario Limonciello (6):
>>>    drm: link connectors to backlight devices
>>>    DRM: Add support for client and driver indicating support for
>>>      luminance
>>>    drm/amd/display: Pass up errors reading actual brightness
>>>    drm/amd: Indicate driver supports luminance
>>>    drm/amd/display: Allow backlight registration to fail
>>>    drm/amd/display: use drm backlight
>>>
>>> Marta Lofstedt (1):
>>>    backlight: expose the current brightness in the new kernel API
>>>
>>>   drivers/gpu/drm/Kconfig                       |   1 +
>>>   drivers/gpu/drm/Makefile                      |   2 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +++-
>>>   drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
>>>   drivers/gpu/drm/drm_backlight.c               | 406 ++++++++++++++++++
>>>   drivers/gpu/drm/drm_connector.c               |  12 +
>>>   drivers/gpu/drm/drm_drv.c                     |   8 +
>>>   drivers/gpu/drm/drm_ioctl.c                   |  10 +
>>>   drivers/gpu/drm/drm_mode_config.c             |   7 +
>>>   drivers/gpu/drm/drm_mode_object.c             |  66 ++-
>>>   drivers/gpu/drm/drm_sysfs.c                   |  54 +++
>>>   drivers/video/backlight/backlight.c           |  83 ++++
>>>   include/drm/drm_backlight.h                   |  45 ++
>>>   include/drm/drm_connector.h                   |   8 +
>>>   include/drm/drm_drv.h                         |   7 +
>>>   include/drm/drm_file.h                        |   8 +
>>>   include/drm/drm_mode_config.h                 |   5 +
>>>   include/linux/backlight.h                     |  30 ++
>>>   include/uapi/drm/drm.h                        |  10 +
>>>   20 files changed, 852 insertions(+), 23 deletions(-)
>>>   create mode 100644 drivers/gpu/drm/drm_backlight.c
>>>   create mode 100644 include/drm/drm_backlight.h
>>>
>>> -- 
>>> 2.53.0
>>>
>>
>>
> 


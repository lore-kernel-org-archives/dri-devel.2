Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCBFCD3430
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC0E10E6F3;
	Mon,  4 May 2026 13:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pThgDbKm";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E493F10E6F3
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 13:56:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 838CC4E42BB8;
 Mon,  4 May 2026 13:56:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 516165FD5F;
 Mon,  4 May 2026 13:56:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9DDF011AD220E; 
 Mon,  4 May 2026 15:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777902994; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=j2hlp/6clsIxKcAavYQrD4NChynsESijBX8RXRMkRwA=;
 b=pThgDbKms2NLA13+nZwLI0zzAbBOv4c7xNMChf/jBC1L3Ti+emr2sjMLS7nGTthUQGAwfX
 p6v4gpem7omcsdsugaXdBttI8LwFWcni8wDNLJePTIwdCtenveRJLstlrMbCi1OxQf5b3O
 mEuWLS56s81cXLPBRJaGwzMGR0VTl2DCfQGt3C3xfxsyqqcCjLvxfMquikkY0nL+XI0vfo
 L62XI313cgOYk/ergTA27+RCHSTpHJPzf5rTtAHxHYO/admrH+ca/sXbD/H0vIxpn6OC56
 xIwpA7odUJwMG6W6OHYTK/JNzvd7GaetxzSYCK6Vm5CPiClCf1lmhc+Mjg3zzw==
Message-ID: <0f5cf41c-99d5-4427-86fe-18c4f1e2c95e@bootlin.com>
Date: Mon, 4 May 2026 15:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add support for a DRM backlight capability
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: harry.wentland@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <superm1@kernel.org>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



On 4/25/26 00:09, Mario Limonciello wrote:
> From: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> At Display Next Hackfest 2025 we discussed the renewed need for moving
> brightness control into the DRM connector properties.  I've taken the
> previous efforts from David and Marta, rebased and adjusted for the
> current kernel.
> 
> The legacy sysfs interface is synchronized with the DRM connector (although
> the scale may be different as DRM connector property is u16).
> 
> Later after this has been adopted by enough userspace, it may make sense to
> configure the legacy sysfs interface to be configurable so that only
> DRM master controls backlight.
> 
> I've done a first implementation with amdgpu with eDP connectors; but
> conceivably this can be extended to other connectors like DP for displays
> that can be controlled via DDC as well later.
> 
> I have also used DRM review prompts to review this series and fix some bugs
> which were caught with two different Claude models.  The fixes are squashed
> into the patches.
> 
> Assisted-by: Claude Opus
> Assisted-by: Claude Sonnet
> 
> For ease of testing; this series is also available on this branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v3

Hello,

thanks for this work, I am very interested in this progress so I can 
help you to test / implement more features.

I think you forgot to include the revert of "backlight: Remove notifier" 
in your series, it can't be applied without it.

I will take a look and see if I can create a VKMS implementation of your 
work.

Thanks for this work,

> David Rheinsberg (1):
>    backlight: add kernel-internal backlight API
> 
> Mario Limonciello (6):
>    drm: link connectors to backlight devices
>    DRM: Add support for client and driver indicating support for
>      luminance
>    drm/amd/display: Pass up errors reading actual brightness
>    drm/amd: Indicate driver supports luminance
>    drm/amd/display: Allow backlight registration to fail
>    drm/amd/display: use drm backlight
> 
> Marta Lofstedt (1):
>    backlight: expose the current brightness in the new kernel API
> 
>   drivers/gpu/drm/Kconfig                       |   1 +
>   drivers/gpu/drm/Makefile                      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +++-
>   drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
>   drivers/gpu/drm/drm_backlight.c               | 406 ++++++++++++++++++
>   drivers/gpu/drm/drm_connector.c               |  12 +
>   drivers/gpu/drm/drm_drv.c                     |   8 +
>   drivers/gpu/drm/drm_ioctl.c                   |  10 +
>   drivers/gpu/drm/drm_mode_config.c             |   7 +
>   drivers/gpu/drm/drm_mode_object.c             |  66 ++-
>   drivers/gpu/drm/drm_sysfs.c                   |  54 +++
>   drivers/video/backlight/backlight.c           |  83 ++++
>   include/drm/drm_backlight.h                   |  45 ++
>   include/drm/drm_connector.h                   |   8 +
>   include/drm/drm_drv.h                         |   7 +
>   include/drm/drm_file.h                        |   8 +
>   include/drm/drm_mode_config.h                 |   5 +
>   include/linux/backlight.h                     |  30 ++
>   include/uapi/drm/drm.h                        |  10 +
>   20 files changed, 852 insertions(+), 23 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_backlight.c
>   create mode 100644 include/drm/drm_backlight.h
> 


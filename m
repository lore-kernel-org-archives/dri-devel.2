Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2445BCA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662ED10E09C;
	Sat,  3 Oct 2026 08:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nbmdVTb8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C42610E03F;
 Sat,  3 Oct 2026 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=1FT2aHW4FQFzpdhNzBR+z098CQvzO9uKHLxt4GQ8rqY=; b=nbmdVTb8PjQdBsiQG/bi86D/to
 iGAyt+7x3xjHa9GYpbQ9rXd68q/gb5vQMozuLe/z6zqtiSn53lIuz8AauiO8ZYk0V1/MqUdrkjW0E
 TIx+9kxQ2Hsage4pS/DTA61U3C9aMw1kzOPCZqWR8zDuNcfZnaG27+Qt/P9+joI6WJrSCy2YRBJz6
 vTqC5biSe5GzLoulbdHIxmidU7V3knEDDTC2ZDBVFVvC4g6UayRADGeCr4ZVZxz6KYIBmoIbyY+k8
 ISzsCG91+4YdiXsIIbtXaReBtuzkmbWQ3MYqRLgAIFnTX/remt0MIIe+pj93VCDUftXmhfA3rLUdM
 8h5D4ulw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xCvEC-00Axgs-41; Sat, 03 Oct 2026 10:36:20 +0200
Message-ID: <401fd882-e9c8-44c5-9497-31ea6b8a596a@igalia.com>
Date: Sat, 3 Oct 2026 09:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] DRM standardized memory stats
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ludovico de Nittis <ludovico.denittis@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
 <5e0949d4-85a2-4519-9e3e-a1b01ae58f46@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <5e0949d4-85a2-4519-9e3e-a1b01ae58f46@amd.com>
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


On 21/09/2026 10:19, Christian König wrote:
> On 9/17/26 14:04, Tvrtko Ursulin wrote:
>> Re-floating a simple idea (this time with more Cc) born from an user interest to
>> be able to correctly size the swap space during OS installation, based on the
>> size of the VRAM a discrete GPU might have. And to be able to do it in a vendor
>> agnostic way.
>>
>> Idea is to expose a standardized scheme in sysfs, under the DRM class card, and
>> under a new 'memstat' directory. Such as, example from amdgpu:
>>
>> /sys/class/drm/card1/memstat/
>> ├── gtt
>> │   ├── total_mb
>> │   └── used_mb
>> └── vram
>>      ├── total_mb
>>      └── used_mb
>>
>> Or with concrete numbers:
>>
>> $ grep -Hr . /sys/class/drm/card1/memstat/
>> /sys/class/drm/card1/memstat/vram/total_mb:1024
>> /sys/class/drm/card1/memstat/vram/used_mb:445
>> /sys/class/drm/card1/memstat/gtt/total_mb:7394
>> /sys/class/drm/card1/memstat/gtt/used_mb:71
>>
>> Drivers need to implement a simple DRM driver level callback which needs to
>> report a stable list of interesting memory regions and their respective stats.
>> The region names then become sub-directory names under the new 'memstat'
>> directory, with each region exposing the total size and the current usage.
>>
>> Similar data can already be queried if the dmem cgroup controller is enabled,
>> also only for the participating drivers, by querying the root cgroup. But
>> perhaps sysfs is easier, or perhaps it is too much code for too little benefit.
>> I am curious to hear any opinions.
> 
> The implementation can be polished a bit but I seriously like the idea to standardize that.

Indeed. I think I've fixed all the kobject related flaring bugs locally.

> amdgpu already exposes the information as non-standard sysfs files and adds a bit more, e.g. CPU visible VRAM size, VRAM vendor etc...
> 
> I'm wondering if those shouldn't be added as well and the existing sysfs files then implemented as symlinks.

CPU visible I guess could be added with a small addition to the 2nd 
(amdgpu) patch. So far the implementation is driven trivially from TTM 
placements / range managers, but I could easily add a different stat 
since drivers define what they export.

Existing files as symlinks I do not know who I would implement it. File 
to file is not possible AFAIU, right?

Allowing drivers to put custom files in there might be complicated and 
could create a standardization problem. If vendor is strongly desired I 
could add it as DRM owned attribute perhaps. Like 
/sys/class/drm/card1/memstat/vram/hw_vendor or something.

Regards,

Tvrtko

>> Cc: Maíra Canal <mcanal@igalia.com>
>> Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>>
>> Tvrtko Ursulin (2):
>>    drm: Allow drivers to report standardized memory stats
>>    drm/amdgpu: Wire up DRM memory stats reporting
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  40 +++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  37 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   3 +
>>   drivers/gpu/drm/drm_drv.c                  |  10 ++
>>   drivers/gpu/drm/drm_sysfs.c                | 123 +++++++++++++++++++++
>>   include/drm/drm_device.h                   |  19 ++++
>>   include/drm/drm_drv.h                      |   8 ++
>>   include/drm/drm_file.h                     |   9 ++
>>   include/drm/drm_sysfs.h                    |   4 +
>>   11 files changed, 248 insertions(+), 13 deletions(-)
>>
> 


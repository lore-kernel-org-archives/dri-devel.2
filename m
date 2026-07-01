Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7A5C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDE410E314;
	Wed,  1 Jul 2026 13:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="EenuKiu2";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6A610E314;
 Wed,  1 Jul 2026 13:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782912770; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fr+ffJ+shEhGfx2Xx8c9Qmcguq5ShSEHRY8UHK2uikcoJrmyJN0mqBE5m69tw9a0GjFJJK2ZHiljtj7n1elao9c0EUXC0q3rTtkRLDIfZ/Bry9zRfUMaO2/N80OFUfY2Ru87j0PMBxQUJGR9r8tkrRspFLqEkBoP8FA/cKDK9wM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782912770;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NCJFDZPpk2Nltv1OnCZcz9TBVpSBkOaYqsSl+0+3BqE=; 
 b=LGkliixZVInpcr7ef/tpOHNITEYYC7vxVqQjXforxaPCUTmZxfGI1+H2XCYhMjWiB4TXkj5wiwCJHv/5CZRDMMsc3UIMVIiDhsEW3YzAZdIDLkgDPfro4xqsouPXlVxnK22cmkG3QY5Y82GU5/GjrEet83sXCKf9Ztf5LomeX4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782912770; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=NCJFDZPpk2Nltv1OnCZcz9TBVpSBkOaYqsSl+0+3BqE=;
 b=EenuKiu2ijrHWQFE9Sy76YtPQGepbJB0VmiQbtiC2wmY5JJnf5Yl3v4OS4NwSltU
 Tgdcnn+PX2Dya7IL9XqzvMBKETKI25FIKAmChvf4xhuWpyWfQH28UcRCPRf7R56hQ9L
 UBIdZkt1jfPjQrKmDZmivKYBIa9msFUaIfToDbfk=
Received: by mx.zohomail.com with SMTPS id 1782912768462667.1922482526628;
 Wed, 1 Jul 2026 06:32:48 -0700 (PDT)
Message-ID: <11792a51-aeeb-428f-a793-607ff09558f3@collabora.com>
Date: Wed, 1 Jul 2026 15:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
 behind driver feature
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Daniel Stone
 <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <3bc9d27b-2886-48df-a897-7e73f14a88a2@linux.intel.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <3bc9d27b-2886-48df-a897-7e73f14a88a2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Maarten,

On 01.07.26 12:41, Maarten Lankhorst wrote:
> Hello,
>
> All you have to do is iterate over all planes at runtime until
> one is found that has the pipeline property attached, it's not
> a performance sensitive area and no locking is required for
> testing if plane->color_pipeline_property is NULL.

that's correct - I checked that before and while the amount of code 
changes necessary to support such a 
"check-planes-with-cap-enabled-and-reinitialize-without-cap-otherwise" 
is not big (AFAICS it should be possible with under 100 lines in 
Weston), it would need to be replicated in various Wayland compositors 
and lots of apps with native DRM backend (drm_info, Gstreamer KMS sink, 
MPV, Kodi etc.). The small change proposed here seems like a more 
elegant solution to me.

In a previous chat Pekka and Simon seemed to agree, quoting: "< 
emersion> pq, you mean the cap is advertised regardless of driver 
support? that sounds like a bug".

> You can also make drm_plane_create_color_pipeline_property set
> the flag in drm_device::driver_features that the cap is supported.
Automatically enabling the driver feature sounds like a reasonable 
improvement - I'll try that, thanks!
>
> But the cap setting code's not really performance sensitive, it will
> be called only a few times during boot at most. Perhaps check whether
> the first crtc->primary plane has the cap is also sufficient.
>
> If you want to continue with a special driver cap, then please set
> the flag for the xe driver too.
Indeed, will do in case the approach mentioned above doesn't work out 
for some reason.
> Kind regards,
> ~Maarten Lankhorst

Regards and thanks for the feedback!

>
> On 6/30/26 10:42, Robert Mader wrote:
>>  From the main commit:
>>
>> The client cap is currently advertised unconditionally, even for drivers that do
>> not support plane color pipelines. If clients supporting the later, like Wayland
>> compositors and drm_info, enable the client cap on sich drivers they will be
>> left without both color pipeline and the legacy properties COLOR_ENCODING and
>> COLOR_RANGE, effectively breaking YUV->RGB conversion support.
>>
>> Add a new driver feature and guard the client cap behind it, allowing
>> plane color pipeline and legacy YUV->RGB support to co-exist.
>>
>> In case of VKMS make the client cap depend on the enable_plane_pipeline.
>>
>> The series can be easily tested with drm_info >= v2.10.0 and VKMS. Without the
>> enable_plane_pipeline option - currently the default - the legacy flags
>> COLOR_ENCODING and COLOR_RANGE should be advertised, just like older drm_info
>> versions.
>>
>> ---
>>
>> Related series actually implementing the color pipeline replacement for the
>> legacy flags:
>> https://lists.freedesktop.org/archives/dri-devel/2026-June/575655.html
>>
>>
>> Robert Mader (4):
>>    drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE behind driver feature
>>    drm/amdgpu: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
>>    drm/i915: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
>>    drm/vkms: Add DRIVER_PLANE_COLOR_PIPELINE driver feature
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>>   drivers/gpu/drm/drm_ioctl.c             | 2 ++
>>   drivers/gpu/drm/i915/i915_driver.c      | 2 +-
>>   drivers/gpu/drm/vkms/vkms_drv.c         | 6 +++++-
>>   include/drm/drm_drv.h                   | 6 ++++++
>>   5 files changed, 15 insertions(+), 3 deletions(-)
>>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


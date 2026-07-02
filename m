Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E1FC44500
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B7E10E4A5;
	Thu,  2 Jul 2026 09:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="jwyULO8r";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF4F10E48C;
 Thu,  2 Jul 2026 09:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782984682; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PfKFG9RhyxZ/Be5OuN+QqF3/BpbnmA1csy44z/dMcd+YIjvJgwvmOHOiJ+2KRMKxIOoQur2T9f+dCn79aiGf3rgs9pzZr/ieS/mvwK9ldHDTosm8k6kLHgd9ZEmlWkBnbQVFNBuhOybf15R8spj3zeYcFN+FZfz3YHoCfLe2aJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782984682;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RDz1VrwgVY8/yTgdWqaKJKdhG6xDvuE7IeCeMPv1hQs=; 
 b=HKOyBhxVPEBNIYCvY/Bipj1MqKUWcdyEq8GnntQKERrMfWcXg2ssZowkS2zK7JmVaooGdCka67TEXs9BjIuxT/LkSuJAjjeXngQEITJzTzXKcAjzUuN/eDLjjD0Tjl0E+AdBiRIVaC64WS6USM3mvCEZZS4VOBMUN5TEDnCSs/s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782984681; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=RDz1VrwgVY8/yTgdWqaKJKdhG6xDvuE7IeCeMPv1hQs=;
 b=jwyULO8rOuk48YoiNDxc+VCzbqUHPa1j1hZ0oj9GR9HkLwLwJf6lKsn7fiuFgCUg
 zCEtXPryDIhrGcXJOeO7hG/GTDwB2SYMuML5kDKujK2SPmgHJZGEdT0zzTmzsWX4yX1
 qzq44EBPrqgeGC1FAcPx4qxVjHnw72bHee+88p0s=
Received: by mx.zohomail.com with SMTPS id 1782984679497750.7953951953009;
 Thu, 2 Jul 2026 02:31:19 -0700 (PDT)
Message-ID: <0f495406-a3c9-4c72-8419-a647a864e0fb@collabora.com>
Date: Thu, 2 Jul 2026 11:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
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
References: <20260702081641.22990-1-robert.mader@collabora.com>
 <83f324a2-abe1-4b32-8782-439569f651d2@linux.intel.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <83f324a2-abe1-4b32-8782-439569f651d2@linux.intel.com>
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

Hi,

On 02.07.26 10:34, Maarten Lankhorst wrote:
> Hello,
<snip>
> On 7/2/26 10:16, Robert Mader wrote:
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index e2df4becce62..b2c0234eaf14 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -373,13 +373,26 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>>   			return -EINVAL;
>>   		file_priv->supports_virtualized_cursor_plane = req->value;
>>   		break;
>> -	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
>> +	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE: {
>> +		struct drm_plane *plane;
>> +		bool has_plane_with_color_pipeline = false;
>> +
>> +		drm_for_each_plane(plane, dev) {
>> +			if (plane->color_pipeline_property) {
>> +				has_plane_with_color_pipeline = true;
>> +				break;
>> +			}
>> +		}
>> +		if (!has_plane_with_color_pipeline)
>> +			return -EOPNOTSUPP;
>> +
>>   		if (!file_priv->atomic)
>>   			return -EINVAL;
>>   		if (req->value > 1)
>>   			return -EINVAL;
>>   		file_priv->plane_color_pipeline = req->value;
>>   		break;
>> +	}
> Perhaps put the most specific check (is there a plane with color pipeline?)
> last, and return -EINVAL, as that is the default before
> DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE was added.
>
> Kind regards,
> ~Maarten Lankhorst
Thanks, will do so in v3. Will wait a bit more for further feedback and 
send it out tomorrow.

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


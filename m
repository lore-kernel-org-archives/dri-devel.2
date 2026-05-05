Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38876FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CB010E434;
	Tue,  5 May 2026 13:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="fZjl5idM";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A68C10E434
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777986881; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Kh52UljS9IVk3YoLty3YsI1r8LK5vkNvPxIL6iB1DkORU8Smt5nUXZCvRG/FD7dBXb3qWVIP5HCgMd/n86rdT13bF9DcIEEH9HvQPgBAk5jnIxAcNYxwtrQh91u/wSORfTaHB74+EgUDkbwmhUnQy+Uf5uwL7Fj03mZrFqxZVAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777986881;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yHVnHlazVOsyMOL+GZlpXCOU1yuJjKoh6BmyS/UGtcs=; 
 b=dr1Af98sEAm4Rbd76TjdnqeVFlkFxz3AbpdEUwNTvmzmQUzAIRlahj8jLJh9H1W/DOqb9jignh+jJkarQPPzriO5ftFqYC2A+oOk84WlM0lqNlVr5DiH5bQ1Mdv6Fkxtb0jOsu6QlOrFqG9zTSQaCp4cEDMZVSQprIaSttEBud0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777986881; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=yHVnHlazVOsyMOL+GZlpXCOU1yuJjKoh6BmyS/UGtcs=;
 b=fZjl5idMOR+uH5gwlhQA9ToxBevqa1KOGVBuk+nwjlmqzR9p8nuxoEsjI3Erruyz
 I35++i8z7Nn08PLX9Qk1LcCqN9+5gqX+0qiuiBOPmwmGM5sNBRv2kinF1s55/7RJ1DG
 fyk+87e6P5fsCcUTX9Fxovgq72y4XmTDWJIY7Bjc=
Received: by mx.zohomail.com with SMTPS id 177798687946491.75887068535508;
 Tue, 5 May 2026 06:14:39 -0700 (PDT)
Message-ID: <f46b5843-017a-4717-8512-960e85bbe92a@collabora.com>
Date: Tue, 5 May 2026 10:14:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm: ensure blend mode supported if alpha exposed
To: Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
References: <20260504140630.68707-1-leandro.ribeiro@collabora.com>
 <20260504140630.68707-3-leandro.ribeiro@collabora.com>
 <c150652e3382375deea18c6c2555d5271c9ab8c5@intel.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <c150652e3382375deea18c6c2555d5271c9ab8c5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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



On 5/5/26 4:57 AM, Jani Nikula wrote:
> On Mon, 04 May 2026, Leandro Ribeiro <leandro.ribeiro@collabora.com> wrote:
>> Before "drm/drm_blend: allow blend mode property without PREMULTI",
>> userspace would have to assume that only PREMULTI was supported by
>> drivers that didn't expose the blend mode property. But now userspace
>> shouldn't relly on that, as they can't count with drivers always
>> supporting PREMULTI.
>>
>> Error out if a driver expose alpha property or pixel formats with alpha
>> and does not expose the blend mode property. This way userspace don't
>> have to guess. Drivers that hit such error must be fixed.
>>
>> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_crtc_internal.h |  1 +
>>  drivers/gpu/drm/drm_drv.c           |  7 ++++-
>>  drivers/gpu/drm/drm_mode_config.c   | 42 +++++++++++++++++++++++++++++
>>  3 files changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
>> index c09409229644..bdbb6b9b94ea 100644
>> --- a/drivers/gpu/drm/drm_crtc_internal.h
>> +++ b/drivers/gpu/drm/drm_crtc_internal.h
>> @@ -96,6 +96,7 @@ int drm_mode_setcrtc(struct drm_device *dev,
>>  int drm_modeset_register_all(struct drm_device *dev);
>>  void drm_modeset_unregister_all(struct drm_device *dev);
>>  void drm_mode_config_validate(struct drm_device *dev);
>> +int drm_mode_config_enforce(struct drm_device *dev);
>>  
>>  /* drm_modes.c */
>>  const char *drm_get_mode_status_name(enum drm_mode_status status);
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index 985c283cf59f..76766a370650 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -1059,9 +1059,14 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>>  	const struct drm_driver *driver = dev->driver;
>>  	int ret;
>>  
>> -	if (!driver->load)
>> +	if (!driver->load) {
>>  		drm_mode_config_validate(dev);
>>  
>> +		ret = drm_mode_config_enforce(dev);
> 
> Reading the code, I'll have no idea what "enforce" means here. Reading
> the function itself isn't helping either.
> 
> BR,
> Jani.
> 

Yes, the function name choice wasn't good.

drm_mode_config_validate() only produces warnings, while
drm_mode_config_enforce() returns error codes and should be used to
prevent initializing a driver that does not comply with the required
rules. In this case, the rule being added is supporting plane alpha but
not the blend mode property.

I could add such kind of rule to drm_mode_config_validate() itself, but
I wasn't sure if people would be happy with it producing both warnings
and errors. But maybe that would be a better approach than what I did.

> 
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	WARN_ON(!dev->managed.final_kfree);
>>  
>>  	if (drm_dev_needs_global_mutex(dev))
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index 66f7dc37b597..20fd26ecb957 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -738,3 +738,45 @@ void drm_mode_config_validate(struct drm_device *dev)
>>  	     "Must have as many primary planes as there are CRTCs, but have %u primary planes and %u CRTCs",
>>  	     num_primary, dev->mode_config.num_crtc);
>>  }
>> +
>> +static int plane_require_blend_mode_for_alpha(struct drm_plane *plane)
>> +{
>> +	struct drm_device *dev = plane->dev;
>> +	const struct drm_format_info *fmt;
>> +	u32 i;
>> +
>> +	/* blend mode property supported, no need to check anything */
>> +	if (plane->blend_mode_property)
>> +		return 0;
>> +
>> +	if (plane->alpha_property) {
>> +		drm_err(dev, "[PLANE:%d:%s] alpha property exposed but blend mode not setup",
>> +			plane->base.id, plane->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < plane->format_count; i++) {
>> +		fmt = drm_format_info(plane->format_types[i]);
>> +		if (fmt->has_alpha) {
>> +			drm_err(dev, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
>> +			        plane->base.id, plane->name);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int drm_mode_config_enforce(struct drm_device *dev)
>> +{
>> +	struct drm_plane *plane;
>> +	int ret;
>> +
>> +	drm_for_each_plane(plane, dev) {
>> +		ret = plane_require_blend_mode_for_alpha(plane);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 

-- 
Leandro Ribeiro


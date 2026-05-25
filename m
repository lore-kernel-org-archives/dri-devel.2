Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D486ACD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4340910E201;
	Mon, 25 May 2026 23:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="R4i0IHMa";
	dkim-atps=neutral
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Mon, 25 May 2026 23:53:33 UTC
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com
 [136.143.188.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6037810E201
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779752306; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Osc1iJdh9i//7IziDWI8TRqMtUIiNR5OuD2WNgr1FPdTgEx0i2U0OujaW0GCI+3bVvFwbg/eGPDxEmjFQKX7FbzWyNyvxdy0gWKriEKGNHGqQPPQJNnjvw9FJ2q/7oQisq1vmTnp8i2EasSRKrz+cqfCeo31pHCGcMUSRfvxqLo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779752306;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AWzAifp2Eq9PNUKyhqA9ZAbFibzkc5QldnOyWDzTtdY=; 
 b=QbPmZc/xUwgXkE07vfweI6zfHUzODSZ1QdEK1ACJUUKEhjolrTxdhNLpEtyCQ88x9DvsYK0bDStd/v+Rrub3yPIcmfpotzBm2m4Eo9kOt9kTGPmzeGbsTNUeSLLze6XizH5FKXbzP83mabOhK4+AjW7KNwBss8rf0gEe1Lps7CY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779752306; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=AWzAifp2Eq9PNUKyhqA9ZAbFibzkc5QldnOyWDzTtdY=;
 b=R4i0IHMaoCc3dMqg3h5An09/RCpaMWWuHCDvLkUegDYAAkLCfiOPg34IPD8UGOdp
 o0JrC6lBcoi4wuM8ByibaVA/TN65O/O6uNElBxWmxz3HMmpLasEqN5MkPNMCB1sEYrJ
 C5hVincZMLX5/IEI10PGyPltgiYg2HLoKY9MiKVc=
Received: by mx.zohomail.com with SMTPS id 1779752303243559.4926896587914;
 Mon, 25 May 2026 16:38:23 -0700 (PDT)
Message-ID: <020b2afd-b056-4502-9ad5-51eabba94074@collabora.com>
Date: Mon, 25 May 2026 20:38:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm: ensure blend mode supported if alpha exposed
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 linux-kernel@vger.kernel.org
References: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
 <20260518175429.80615-3-leandro.ribeiro@collabora.com>
 <ahCfY3RXV2l-fZda@intel.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <ahCfY3RXV2l-fZda@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 5/22/26 3:24 PM, Ville Syrjälä wrote:
> On Mon, May 18, 2026 at 02:54:29PM -0300, Leandro Ribeiro wrote:
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
>>  drivers/gpu/drm/drm_crtc_internal.h |  2 +-
>>  drivers/gpu/drm/drm_drv.c           |  7 ++++--
>>  drivers/gpu/drm/drm_mode_config.c   | 37 +++++++++++++++++++++++++++--
>>  3 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
>> index c09409229644..2a4862202496 100644
>> --- a/drivers/gpu/drm/drm_crtc_internal.h
>> +++ b/drivers/gpu/drm/drm_crtc_internal.h
>> @@ -95,7 +95,7 @@ int drm_mode_setcrtc(struct drm_device *dev,
>>  /* drm_mode_config.c */
>>  int drm_modeset_register_all(struct drm_device *dev);
>>  void drm_modeset_unregister_all(struct drm_device *dev);
>> -void drm_mode_config_validate(struct drm_device *dev);
>> +int drm_mode_config_validate(struct drm_device *dev);
>>  
>>  /* drm_modes.c */
>>  const char *drm_get_mode_status_name(enum drm_mode_status status);
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index 985c283cf59f..def78046a963 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -1059,8 +1059,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>>  	const struct drm_driver *driver = dev->driver;
>>  	int ret;
>>  
>> -	if (!driver->load)
>> -		drm_mode_config_validate(dev);
>> +	if (!driver->load) {
>> +		ret = drm_mode_config_validate(dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>>  	WARN_ON(!dev->managed.final_kfree);
>>  
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index 66f7dc37b597..18c6b5707532 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -674,16 +674,45 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
>>  	     encoder->possible_crtcs, crtc_mask);
>>  }
>>  
>> -void drm_mode_config_validate(struct drm_device *dev)
>> +static int plane_alpha_require_blend_mode(struct drm_plane *plane)
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
> 
> Why this? I don't think the constant alpha property has anything
> really to do with the per-pixel alpha stuff.

You’re right: if the pixel format has no alpha channel, the constant
alpha property produces identical results for COVERAGE and PREMULTI.

> 
>> +
>> +	for (i = 0; i < plane->format_count; i++) {
>> +		fmt = drm_format_info(plane->format_types[i]);
>> +		if (fmt->has_alpha) {
>> +			drm_err(dev, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
>> +				plane->base.id, plane->name);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int drm_mode_config_validate(struct drm_device *dev)
>>  {
>>  	struct drm_encoder *encoder;
>>  	struct drm_crtc *crtc;
>>  	struct drm_plane *plane;
>>  	u32 primary_with_crtc = 0, cursor_with_crtc = 0;
>>  	unsigned int num_primary = 0;
>> +	int ret = 0;
>>  
>>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>> -		return;
>> +		return ret;
>>  
>>  	drm_for_each_encoder(encoder, dev)
>>  		fixup_encoder_possible_clones(encoder);
>> @@ -732,9 +761,13 @@ void drm_mode_config_validate(struct drm_device *dev)
>>  	drm_for_each_plane(plane, dev) {
>>  		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
>>  			num_primary++;
>> +
>> +		ret |= plane_alpha_require_blend_mode(plane);
>>  	}
>>  
>>  	WARN(num_primary != dev->mode_config.num_crtc,
>>  	     "Must have as many primary planes as there are CRTCs, but have %u primary planes and %u CRTCs",
>>  	     num_primary, dev->mode_config.num_crtc);
>> +
>> +	return ret;
>>  }
>> -- 
>> 2.54.0
> 

-- 
Leandro Ribeiro


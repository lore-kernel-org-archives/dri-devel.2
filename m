Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139E8FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C09810E917;
	Mon, 27 Apr 2026 20:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="GZx2niL+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3875710E917
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 20:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777322189; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Gpm49hkutbmlezMZxVgcFwbA9HQtB9YRGJZuzMxb9xq7nh116BfHOywzEbQXYZT1VY2jS5AM6dTa8gRPs4+c4+XFZDH/bOwfzQua/7JuqsfM2nMGvyR9Rs3UMXEQ0deH+S0SGxL33TAVRml2MyDaobKG47hUixKDfII95APujJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777322189;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pIQcDJIsj+B+7mZQVhJczqVIjhfsLFSEL5WKUbpmXow=; 
 b=Ka6GQffYaDEh891jOKPWWoLvAWKrLPxgFWeqGDYaCtcAqxz/Z2iGMVgMWiNuBk2bvFj+waEem6JcamFHh1JjDUf7ecrWOjxdeEtUafCMfr+NSatBk70PVXkPMTaxbhCxbjrRL8oDBkJbeomOj5i4pqFS8JmvJmUc3xHbgMl8YDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777322189; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pIQcDJIsj+B+7mZQVhJczqVIjhfsLFSEL5WKUbpmXow=;
 b=GZx2niL+LcnTXFcWuY/9N3paN/tQL8V4TCukSK8k8qBwfVF1fZjURWlBkrP3h6t2
 35bU+9zXKIa+Ti6nut17hzLvHM1eAaSG5GvffCzIV0Wb5B3Lhsgt3qlDSKC1OJPvzqo
 Gt1IeYZCVIrgIa1fGWbiVmTc0nuRGrS72nmuxvmw=
Received: by mx.zohomail.com with SMTPS id 1777322188089628.065436419896;
 Mon, 27 Apr 2026 13:36:28 -0700 (PDT)
Message-ID: <a7f8f84d-f0c3-4aaf-a5e3-30e5d45e1cbb@collabora.com>
Date: Mon, 27 Apr 2026 17:36:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_blend: allow blend mode property without PREMULTI
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 tzimmermann@suse.de, linux-kernel@vger.kernel.org
References: <20260424143513.13004-1-leandro.ribeiro@collabora.com>
 <ae9T8e6NBaC3z0uH@intel.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <ae9T8e6NBaC3z0uH@intel.com>
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



On 4/27/26 9:17 AM, Ville Syrjälä wrote:
> On Fri, Apr 24, 2026 at 11:35:13AM -0300, Leandro Ribeiro wrote:
>> Some hardware only supports the COVERAGE blend mode and lacks PREMULTI
>> support entirely. DRM currently requires that PREMULTI is present when
>> creating a blend mode property, which prevents such drivers from being
>> properly upstreamed.
>>
>> Remove this restriction and allow drivers to create a blend mode
>> property without PREMULTI, enabling support for hardware that
>> implements only COVERAGE blend mode.
>>
>> This does not introduce a regression, as no existing upstream drivers
>> expose only COVERAGE. However, userspace that wants to support such kind
>> of hardware in the future will have to check the supported blend modes
>> instead of assuming PREMULTI is always supported.
>>
>> If the driver does not support the blend mode property, userspace must
>> assume that only PREMULTI is supported (as was the case before this
>> patch).
>>
>> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_blend.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
>> index 1f3af27d2418..e5015d0fb219 100644
>> --- a/drivers/gpu/drm/drm_blend.c
>> +++ b/drivers/gpu/drm/drm_blend.c
>> @@ -563,10 +563,10 @@ EXPORT_SYMBOL(drm_atomic_normalize_zpos);
>>  /**
>>   * drm_plane_create_blend_mode_property - create a new blend mode property
>>   * @plane: drm plane
>> - * @supported_modes: bitmask of supported modes, must include
>> - *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
>> - *		     that alpha is premultiplied, and old userspace can break if
>> - *		     the property defaults to anything else.
>> + * @supported_modes: bitmask of supported modes. When
>> + *		     BIT(DRM_MODE_BLEND_PREMULTI) is included, it will be used
>> + *		     as the default. Otherwise, the default will fallback to one
>> + *		     of the supported modes.
>>   *
>>   * This creates a new property describing the blend mode.
>>   *
>> @@ -586,6 +586,9 @@ EXPORT_SYMBOL(drm_atomic_normalize_zpos);
>>   *	pre-multiplied and will do so when blending them to the background color
>>   *	values.
>>   *
>> + * Note: if the blend mode property is not present, userspace must assume that
>> + * the driver supports only "Pre-multiplied".
> 
> IMO we shouldn't allow drivers to follow that rule anymore.
> What we'd need is an assert that any plane that exposes
> formats with alpha also exposes the blend mode property.
> That would at least force the drivers to get fixed.

Sounds good to me. I prefer that instead of relying on assumptions.

Besides pixel formats with alpha, we should also check for planes that
expose the alpha property, right?

Also, I'm wondering where to assert that. I see that before registering
the DRM device, in drm_dev_register(), drm_mode_config_validate() is
called. But it doesn't fail if a check doesn't pass, only WARN. So I'm
wondering if there's a better place.

> 
>> + *
>>   * RETURNS:
>>   * Zero for success or -errno
>>   */
>> @@ -599,13 +602,13 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>>  		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
>>  		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
>>  	};
>> +	unsigned int default_mode;
>>  	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>  				       BIT(DRM_MODE_BLEND_PREMULTI)   |
>>  				       BIT(DRM_MODE_BLEND_COVERAGE);
>>  	int i;
>>  
>> -	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
>> -		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
>> +	if (WARN_ON((supported_modes & ~valid_mode_mask)))
>>  		return -EINVAL;
>>  
>>  	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
>> @@ -630,7 +633,14 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>>  		}
>>  	}
>>  
>> -	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
>> +	if (supported_modes & BIT(DRM_MODE_BLEND_PREMULTI))
>> +		default_mode = DRM_MODE_BLEND_PREMULTI;
>> +	else if (supported_modes & BIT(DRM_MODE_BLEND_COVERAGE))
>> +		default_mode = DRM_MODE_BLEND_COVERAGE;
>> +	else
>> +		default_mode = DRM_MODE_BLEND_PIXEL_NONE;
>> +
>> +	drm_object_attach_property(&plane->base, prop, default_mode);
>>  	plane->blend_mode_property = prop;
>>  
>>  	return 0;
>> -- 
>> 2.54.0
> 

-- 
Leandro Ribeiro


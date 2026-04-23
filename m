Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4802F589DC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7C610F177;
	Thu, 23 Apr 2026 14:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="d+gPprh1";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3368010F177
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:23:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9623CC5EF12;
 Thu, 23 Apr 2026 14:23:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4427C60495;
 Thu, 23 Apr 2026 14:23:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40E9C1072053A; 
 Thu, 23 Apr 2026 16:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776954179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Y2x0WxHDMpLj4447G7b2L2W0rwGQGINgtz7bfN5M0/A=;
 b=d+gPprh1q0YgQWLLeRSKxGFbvuKkwGxP8Eooh0dE4cwmGLFjRwA31s6SSUKuSJDR7nLHum
 XI76Q81YtfSLvaRxq/ENVvm7ubWmMm2XrqnryFTl27bOQEdVv/JmFFrJMdsU2+3e27VNEE
 uUhb0rGeZPPsDNHbmYOLcUiK42Pd4DF6K56OiUOirtl7b+wwGHbp6erc/tnoAuyXQnxoUU
 yDesxraaXx5Fv9jCtiF5dIoAoraeeIJRd8KiG8uDpGl0azBX5wkXcO8ZdIMdsxxEtO+Y+8
 GXjx3rglYpdM9uefPcZYh+B6bM+OWtaHrB2MJ/ZrmyyRK6o3ZViWuGM8sfuvrg==
Message-ID: <d09a169d-2324-4fac-b08a-750e79bdfb81@bootlin.com>
Date: Thu, 23 Apr 2026 16:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/37] drm/blend: Get a rotation name from it's bitfield
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 victoria@system76.com, sebastian.wick@redhat.com,
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?=
 <jose.exposito@redhat.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
 <20260422-vkms-all-config-v4-2-dbb52e9aadc3@bootlin.com>
 <aej82CO0l9_O1sX2@intel.com>
 <d9a66f6a-e07c-4bc2-bd91-8b9cb2994760@bootlin.com>
 <aen13JEWrKXiqRw4@intel.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aen13JEWrKXiqRw4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 4/23/26 12:35, Ville Syrjälä wrote:
> On Thu, Apr 23, 2026 at 10:47:38AM +0200, Louis Chauvet wrote:
>>
>>
>> On 4/22/26 18:52, Ville Syrjälä wrote:
>>> On Wed, Apr 22, 2026 at 06:47:59PM +0200, Louis Chauvet wrote:
>>>> Having the rotation/reflection name from its value can be useful for
>>>> debugging purpose. Extract the rotation property table and implement
>>>> drm_get_rotation_name.
>>>>
>>>> Reviewed-by: José Expósito <jose.exposito@redhat.com>
>>>> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_blend.c | 35 ++++++++++++++++++++++++++---------
>>>>    include/drm/drm_blend.h     |  2 ++
>>>>    2 files changed, 28 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
>>>> index 1f3af27d2418..11d8e13caea3 100644
>>>> --- a/drivers/gpu/drm/drm_blend.c
>>>> +++ b/drivers/gpu/drm/drm_blend.c
>>>> @@ -256,6 +256,31 @@ int drm_plane_create_alpha_property(struct drm_plane *plane)
>>>>    }
>>>>    EXPORT_SYMBOL(drm_plane_create_alpha_property);
>>>>    
>>>> +static const struct drm_prop_enum_list rotation_props[] = {
>>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
>>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
>>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
>>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
>>>> +	{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
>>>> +	{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
>>>> +};
>>>> +
>>>> +/**
>>>> + * drm_get_rotation_name - Return the name of a rotation
>>>> + * @rotation: The rotation mask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*)
>>>> + *
>>>> + * Returns: the name of the rotation type (unknown) if rotation is not
>>>> + * a known rotation/reflection
>>>> + */
>>>> +const char *drm_get_rotation_name(unsigned int rotation)
>>>> +{
>>>> +	if (rotation < ARRAY_SIZE(rotation_props))
>>>> +		return rotation_props[rotation].name;
>>>
>>> The value is a bitmask. This does not work.
>>>
>>
>> That true, the documentation is not clear.
>>
>> Take a look at patch 15 [1] for the usage. Is it better if I change the
>> documentation to:
>>
>> drm_get_rotation_name - Returns the name of a rotation/reflection
>> bitmask (with only one bit set).
>> @rotation: Bitmask with a single bit set.
>> Name of the rotation/reflection, or "(unknown)" if invalid.
>>
>> [1]:https://lore.kernel.org/all/20260422-vkms-all-config-v4-15-dbb52e9aadc3@bootlin.com/
> 
> For that kind of local thing I don't think it should be called
> drm_get_rotation_name(). Also your docs seem to disagree with the
> implementation.

I didn't remembered well, yes, this implementation takes the *index* of 
the bitmask. So documentation is:

drm_get_rotation_name - Returns the name of a rotation/reflection
@rotation: Bit index of the requested rotation (0 = DRM_MODE_ROTATE_0, 1 
= DRM_MODE_ROTATE_90, ...)
Returns: Name of the rotation/reflection, or "(unknown)" if invalid.

> But this does sound like a useful thing to have, eg. in
> drm_atomic_plane_print_state().

I agree this can be a common implementation. Do you think the following 
implementation can be the "common implementation"?

static const char* drm_get_rotation_name(int rotation_index) {
	return rotation_props[rotation_index].name
}

void drm_get_rotation_str(int rotation, char *buf, int buflen) {
     u32 offset = 0;
     while (offset < ARRAY_SIZE(rotation_props))
         if (1 << offset && rotation)
             snprintf(buf,buflen,"%s ",drm_get_rotation_name(offset));
}

An other solution can be format macro (inspiration from IGT, I don't 
know if this is accepted in the kernel):

#define DRM_ROTATION_FMT "%s %s %s %s %s %s"
#define DRM_ROTATION_FMT_ARGS(rot) \
	rot & 0x1 << 0 ? drm_get_rotation_name(0) : "", \
	rot & 0x1 << 1 ? drm_get_rotation_name(1) : "", \
	rot & 0x1 << 2 ? drm_get_rotation_name(2) : "", \
	rot & 0x1 << 3 ? drm_get_rotation_name(3) : "", \
	rot & 0x1 << 4 ? drm_get_rotation_name(4) : "", \
	rot & 0x1 << 5 ? drm_get_rotation_name(5) : ""

> We already have at least one implementation of this in
> i915/display/intel_display_debugfs.c, although with a bit more
> terse format (and with somewhat weird "FLIP" terminology) to
> make it not eat so much screen real estate.

I think it is better to have a consistent naming and use the enumeration 
name everywhere, but if you think intel is better, I can switch.

Thanks,
Louis Chauvet

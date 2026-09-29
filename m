Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C903BCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174D610ED5F;
	Tue, 29 Sep 2026 08:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ONJwU9Hu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0FCVc9UC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hR8lb9hO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FEhj0k4/";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C53E10ED5F;
 Tue, 29 Sep 2026 08:17:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1E3F21C82;
 Tue, 29 Sep 2026 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790669873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YyPk9R8Z4DIh7E/2QQNXg/tLTWibegSnItDMfbsCiqk=;
 b=ONJwU9HuZnEU3+c9dBh2yGqq2anYAZZuGPRPfW8zqNDwp1bEf/hrqgW52zOOHkakd4fr1g
 MGw3skvt1cIPdxQS/9GbWikfs2jg8d+mcV/FiLoaPbsHxlVm2JjbwtNoggLJk0INbcGT31
 H8VARTDy5bX5hhLOrp2LqRafRxj7yGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790669873;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YyPk9R8Z4DIh7E/2QQNXg/tLTWibegSnItDMfbsCiqk=;
 b=0FCVc9UCKCwCWmr7oJ+3jTI6Fmal49wMWx5rG2xrwHRJE+JWVfVl4QYOB5euqrWCPmURF8
 6oP8u7EIPLDLETAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hR8lb9hO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="FEhj0k4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790669868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YyPk9R8Z4DIh7E/2QQNXg/tLTWibegSnItDMfbsCiqk=;
 b=hR8lb9hO/CaYy0ZDRY2q8bdEyeJ9OT+KqnoVdx9OrwoYjPXj8kVu85LmmnqcrbzXuayV1b
 h05vw9df6nN/3X2LTsS8zb0I4AlGULZqpoaYbrIhE1EwVUhEiiAOsu9xdkuXh1SR8v7GUI
 ZMwVDaRP7te4xb6hRfiDTX33u9yQ8gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790669868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YyPk9R8Z4DIh7E/2QQNXg/tLTWibegSnItDMfbsCiqk=;
 b=FEhj0k4/Z3WuBlmO4MJbbZZfxtFJUly34Y4maKpq6Hxur7ihB+Gm3p9segHIZ7PJaHu2zz
 fytE3HvmWSY8VLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A655133F1;
 Tue, 29 Sep 2026 08:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yU20Nit0u2ogRQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 29 Sep 2026 08:17:48 +0000
Message-ID: <b4aa7c7d-1502-4a28-bdea-41a3584c2980@suse.de>
Date: Tue, 29 Sep 2026 10:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] drm: Rename drm_utils.h to drm_panel_quirks.h
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-7-f2ae987d861f@igalia.com>
 <fe616885-5509-4236-8261-7cdb3b0ef67c@igalia.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <fe616885-5509-4236-8261-7cdb3b0ef67c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url];
 URIBL_BLOCKED(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,igalia.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D1E3F21C82
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Hi

Am 22.09.26 um 14:00 schrieb Maíra Canal:
> Thomas, do you have any thoughts about this change?

I think this is good for this series.  There is potential to untangle 
the quirks handling and link the rsp. object files into helper modules 
instead of the DRM core. But that's for another series.

Best regards
Thomas

>
> Best regards,
> - Maíra
>
> On 15/09/26 16:42, Maíra Canal wrote:
>> Now that the timeout-related functions were removed from drm_utils.h,
>> the header has exclusively panel orientation and backlight quirk 
>> getters.
>>
>> Therefore, rename the header accordingly and update all files that
>> include it. The files amdgpu_dm.c, amdgpu_dm_connector.c and 
>> panthor_drv.c
>> include the header but don't use it, so drop the include there.
>>
>> No functional change.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 1 -
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 2 +-
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 1 -
>>   drivers/gpu/drm/drm_connector.c                             | 2 +-
>>   drivers/gpu/drm/drm_panel_backlight_quirks.c                | 2 +-
>>   drivers/gpu/drm/drm_panel_orientation_quirks.c              | 2 +-
>>   drivers/gpu/drm/panthor/panthor_drv.c                       | 1 -
>>   drivers/video/fbdev/efifb.c                                 | 2 +-
>>   include/drm/{drm_utils.h => drm_panel_quirks.h} | 8 +++-----
>>   9 files changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 4426e18f7543..5f20fff2d466 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -98,7 +98,6 @@
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_eld.h>
>>   #include <drm/drm_mode.h>
>> -#include <drm/drm_utils.h>
>>   #include <drm/drm_vblank.h>
>>   #include <drm/drm_colorop.h>
>>   #include <drm/drm_gem_atomic_helper.h>
>> diff --git 
>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
>> index b9e90ea449ca..3211bd1472b2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
>> @@ -41,7 +41,7 @@
>>   #include <linux/backlight.h>
>>   #include <linux/power_supply.h>
>>   #include <drm/drm_edid.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_panel_quirks.h>
>>     #include <acpi/video.h>
>>   diff --git 
>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> index e7b555fa666f..9e43e70afe8d 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> @@ -62,7 +62,6 @@
>>   #include <drm/drm_fixed.h>
>>   #include <drm/drm_mode.h>
>>   #include <drm/drm_probe_helper.h>
>> -#include <drm/drm_utils.h>
>>   #include <drm/display/drm_dp_mst_helper.h>
>>   #include <drm/display/drm_hdmi_helper.h>
>>   #include <drm/drm_privacy_screen_consumer.h>
>> diff --git a/drivers/gpu/drm/drm_connector.c 
>> b/drivers/gpu/drm/drm_connector.c
>> index 8b4baed060f3..c4d844205971 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -28,10 +28,10 @@
>>   #include <drm/drm_file.h>
>>   #include <drm/drm_managed.h>
>>   #include <drm/drm_panel.h>
>> +#include <drm/drm_panel_quirks.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_privacy_screen_consumer.h>
>>   #include <drm/drm_sysfs.h>
>> -#include <drm/drm_utils.h>
>>     #include <linux/export.h>
>>   #include <linux/platform_device.h>
>> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c 
>> b/drivers/gpu/drm/drm_panel_backlight_quirks.c
>> index e417c7533053..dcb91e12bac6 100644
>> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
>> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
>> @@ -5,7 +5,7 @@
>>   #include <linux/export.h>
>>   #include <linux/module.h>
>>   #include <drm/drm_edid.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_panel_quirks.h>
>>     struct drm_panel_match {
>>       enum dmi_field field;
>> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c 
>> b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> index 3a218fb592ce..813a204cd201 100644
>> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> @@ -12,7 +12,7 @@
>>   #include <linux/export.h>
>>   #include <linux/module.h>
>>   #include <drm/drm_connector.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_panel_quirks.h>
>>     #ifdef CONFIG_DMI
>>   diff --git a/drivers/gpu/drm/panthor/panthor_drv.c 
>> b/drivers/gpu/drm/panthor/panthor_drv.c
>> index 46a3080b0b20..4bb74102acb1 100644
>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>> @@ -25,7 +25,6 @@
>>   #include <drm/drm_ioctl.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_syncobj.h>
>> -#include <drm/drm_utils.h>
>>   #include <drm/gpu_scheduler.h>
>>   #include <drm/panthor_drm.h>
>>   diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index ad8dec7807c3..3411be06d3e6 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -18,8 +18,8 @@
>>   #include <linux/sysfb.h>
>>   #include <video/vga.h>
>>   #include <asm/efi.h>
>> -#include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
>>   #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
>> +#include <drm/drm_panel_quirks.h> /* For 
>> drm_get_panel_orientation_quirk */
>>     struct bmp_file_header {
>>       u16 id;
>> diff --git a/include/drm/drm_utils.h b/include/drm/drm_panel_quirks.h
>> similarity index 63%
>> rename from include/drm/drm_utils.h
>> rename to include/drm/drm_panel_quirks.h
>> index c61dee76451c..60711a49d403 100644
>> --- a/include/drm/drm_utils.h
>> +++ b/include/drm/drm_panel_quirks.h
>> @@ -1,14 +1,12 @@
>>   /* SPDX-License-Identifier: MIT */
>>   /*
>> - * Function prototypes for misc. drm utility functions.
>> - * Specifically this file is for function prototypes for functions 
>> which
>> - * may also be used outside of drm code (e.g. in fbdev drivers).
>> + * Function prototypes for panel-related quirks.
>>    *
>>    * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
>>    */
>>   -#ifndef __DRM_UTILS_H__
>> -#define __DRM_UTILS_H__
>> +#ifndef __DRM_PANEL_QUIRKS_H__
>> +#define __DRM_PANEL_QUIRKS_H__
>>     #include <linux/types.h>
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)



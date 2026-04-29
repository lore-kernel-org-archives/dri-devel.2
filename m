Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF50FFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E0310EEDD;
	Wed, 29 Apr 2026 10:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nmOgx7yW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B286010EEDD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dFo9TUsqnW4ITaES3qRH9rTodjAjKR1gXdmM2ZYNjwg=; b=nmOgx7yWtiA4TkbK1BXBb1ONc8
 bx0B+9V1t86Qmn4fWbYwIiweKmD3fJTZeWbA5xsfMsBf0GtdKR8vnVNbX8MwMgyr/Z3kec0lNRSoZ
 kV4r3abl1ztQSjM9S2WU7qmBXwhOdj1rA881WqrjWSvDed6fX4WVmhyG29vQ6JkxUCtTQ1SIBvC7v
 g0EEOLdk39T6tI0Q0pIfABT0pS9PJ6zf4ADJKUjumTIre7+76fZyi1Gm/F7ZPVRhUYxAuCoyqvexE
 UzRAI8A8Q+/bcT0kalO4GsNs8iWM226SN9GT1z0g4QUil+Ua7WBEylXmqvolt/QX4Q3yGYhVQmnUN
 ZEw2ShJA==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wI2Ps-003tOj-Eo; Wed, 29 Apr 2026 12:45:15 +0200
Message-ID: <6cc225d0-774d-406d-a528-ddf89cbdf04a@igalia.com>
Date: Wed, 29 Apr 2026 11:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Drop unused drm_device_class_(un)register API
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Hans de Goede <hansg@kernel.org>
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20260429085726.69842-1-tvrtko.ursulin@igalia.com>
 <4b1e0f32-36b7-41be-8ce1-95e6f023b62d@suse.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4b1e0f32-36b7-41be-8ce1-95e6f023b62d@suse.de>
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


On 29/04/2026 10:35, Thomas Zimmermann wrote:
> Hi
> 
> Am 29.04.26 um 10:57 schrieb Tvrtko Ursulin:
>> The API has been unused since commit
>> ed89fff97382 ("drm/ttm: drop sysfs directory")
>> so lets remove it.
> 
> drm_privacy_screen_register() uses the same pattern. [1] If that helper 
> is being converted over to drm_class_device_register(), the global 
> drm_class could be internalized into drm_sysfb.c. Personally, I think 
> this is the better solution, but either seems fine. [1] https:// 
> elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/ 
> drm_privacy_screen.c#L405

I did not spot that one. The alternative sounds reasonable to me. Adding 
Hans to check if he wants to take over converting this driver.

Regards,

Tvrtko
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> ---
>>   drivers/gpu/drm/drm_sysfs.c | 32 --------------------------------
>>   include/drm/drm_sysfs.h     |  4 ----
>>   2 files changed, 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>> index 43b2c3eaa7e4..7433bf8136cc 100644
>> --- a/drivers/gpu/drm/drm_sysfs.c
>> +++ b/drivers/gpu/drm/drm_sysfs.c
>> @@ -645,35 +645,3 @@ struct device *drm_sysfs_minor_alloc(struct 
>> drm_minor *minor)
>>       put_device(kdev);
>>       return ERR_PTR(r);
>>   }
>> -
>> -/**
>> - * drm_class_device_register - register new device with the DRM sysfs 
>> class
>> - * @dev: device to register
>> - *
>> - * Registers a new &struct device within the DRM sysfs class. 
>> Essentially only
>> - * used by ttm to have a place for its global settings. Drivers 
>> should never use
>> - * this.
>> - */
>> -int drm_class_device_register(struct device *dev)
>> -{
>> -    if (!drm_class || IS_ERR(drm_class))
>> -        return -ENOENT;
>> -
>> -    dev->class = drm_class;
>> -    return device_register(dev);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_class_device_register);
>> -
>> -/**
>> - * drm_class_device_unregister - unregister device with the DRM sysfs 
>> class
>> - * @dev: device to unregister
>> - *
>> - * Unregisters a &struct device from the DRM sysfs class. Essentially 
>> only used
>> - * by ttm to have a place for its global settings. Drivers should 
>> never use
>> - * this.
>> - */
>> -void drm_class_device_unregister(struct device *dev)
>> -{
>> -    return device_unregister(dev);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_class_device_unregister);
>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>> index 96a5d858404b..7695873a9456 100644
>> --- a/include/drm/drm_sysfs.h
>> +++ b/include/drm/drm_sysfs.h
>> @@ -3,13 +3,9 @@
>>   #define _DRM_SYSFS_H_
>>   struct drm_device;
>> -struct device;
>>   struct drm_connector;
>>   struct drm_property;
>> -int drm_class_device_register(struct device *dev);
>> -void drm_class_device_unregister(struct device *dev);
>> -
>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>> *connector);
>>   void drm_sysfs_connector_property_event(struct drm_connector 
>> *connector,
> 


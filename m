Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C01606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PewgGCrO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E8F112185;
	Thu, 26 Nov 2026 09:02:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE2710E39A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795683762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p/oKY20OusxDDv41Q7c7EC8fbrlCimdqEtfaz8bn3Y=;
 b=PewgGCrOjs7ZfEdUFYp0SOquXj84YKK17oVTUkRSYMKhNUlLdXsoOLpewCr+0HNjuJFVfF
 Yo8+1hcvBLBmPa+UPCTAaLUKlSGity7kcWm/yPd6E7z5E2gGdkSJ8sATHmssJfENOvQjOH
 3hnbNAcQOGsUe68Mr1CHH1SS+7OGhg4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-9jkB93vmNWW7qIsGkxxivg-1; Thu, 26 Nov 2026 09:02:39 +0000
X-MC-Unique: 9jkB93vmNWW7qIsGkxxivg-1
X-Mimecast-MFC-AGG-ID: 9jkB93vmNWW7qIsGkxxivg_1795683758
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4bba856092dso10665275e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795683758; x=1796288558;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8p/oKY20OusxDDv41Q7c7EC8fbrlCimdqEtfaz8bn3Y=;
 b=GTrMiq59PcNtmRa4ZL4tQU/q7ECiWsWx3GuVd5nhiJ8KDWDbWyMqL7pIGWj0UsZCko
 tX34nVD16xWNgwtZNUG0sR8L2tC6US3/RdJbN5jdKhhihs/7kKIF+LVWCCdERg5TEPcM
 sJUZnONhpmptIdly9Ou1PDw4ph7Bs85CzzdVYV/KJ07PHCKlwX+9MURUPm0rgbNotl8T
 pe9roctmhNr7UF3OmfxL3o6A38hIsLAlZuodvpyxTdVX03Fs5lLdrtf4AEjgJMP/a87h
 R4hZ5p7b9Pbvu9ppuzv1sLV5bAjI/hBAPYsBbugcN4K61BvZJR3N8wy/uweX4Yet2Yjx
 SzEA==
X-Forwarded-Encrypted: i=1;
 AL+hErEO1KFPIOVjhD8quLEQFvuVKI83yVHHr1g1GrlR8VX5nfiKGjfYFf3B2DDSBkoDcDZGazVpVaDNx9c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9h9mAsH3upipTZEqscn5mznBATFfxS10peeVvW2ITd19JrbSF+
 sAJfzZ2UXYOicjPkAW05s15FbO7SuetHhBgiMlhWaHkT0VbLTX3q3GLrM4TMr4HK+t83ckMnxYJ
 6RCx0hRP4BqvsrvS61qKCDuW+9+bV1rd+RNPwHQwoGCAl+g4KWe+1k2qljHfSwD+2CWp7wA==
X-Gm-Gg: AZFdTZeP7i4IhP1d4cEevFIt28nV1j0D23RiQGxztE5QX1nnEHRo2mXfEurZMwEiXqK
 lGklfelgtQ1YTUdPVdWA2ghoSy8Sedgyf77uYXdeRtdLU53qLbmDCwgoY+Me7jbu/Th49s40yN1
 MHsi6eOgB3IT6nPJXPFK+RiHqbdkYQa9BaA40NVGihZnAK5DzCyU9nY3g3+BYL4WDfKJje+rtzO
 FVrhyjtuipawOOQn3K1yj5Y3wa2MwW47bHnu2kAPLNxP3J22ffhlfvq5+eCcIIZgtEABJLUeniP
 ws8I6IIRMp3Jfg2kM8WDQyweUM8SLQSDdPMCvxFAz8MEENvD7LZsvJEcABs2YUBWfg4uTkwRZIc
 F7jO7Fk0KUaWssRo2KFizMdLU45p837qnL0Ao2OmVQW5rbiJF+jG3OH62OPctYPUTb+3CMXbLrg
 bdfIlYn2yN5Nrx9LrdWtrV
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb887c2cb0mr453115785e9.2.1795683758390; 
 Thu, 26 Nov 2026 01:02:38 -0800 (PST)
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb887c2cb0mr453115315e9.2.1795683757931; 
 Thu, 26 Nov 2026 01:02:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm595663095e9.7.2026.11.26.01.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 01:02:36 -0800 (PST)
Message-ID: <fe5485e4-c3fc-4f18-86b2-d37106876c47@redhat.com>
Date: Thu, 26 Nov 2026 10:02:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/log: Add an automatic integer scaling
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261124224408.728354-1-jfalempe@redhat.com>
 <b5f237cf-582a-42f5-8ebc-c006ccecf62f@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <b5f237cf-582a-42f5-8ebc-c006ccecf62f@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NoRshpSq4S-UlOaOp6_jiIYkdewWBExBqm_EIYGAapY_1795683758
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 08:47, Thomas Zimmermann wrote:
> Hi Jocelyn
> 
> Am 24.11.26 um 23:42 schrieb Jocelyn Falempe:
>> On HiDPI screen, the default font might be too small, so if no
>> scaling is specified, try to upscale reasonably.
>> The auto scaling is computed for each display.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/clients/drm_log.c | 36 ++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/ 
>> clients/drm_log.c
>> index 4654091fe11a..7a0db2690b55 100644
>> --- a/drivers/gpu/drm/clients/drm_log.c
>> +++ b/drivers/gpu/drm/clients/drm_log.c
>> @@ -25,9 +25,9 @@ MODULE_AUTHOR("Jocelyn Falempe");
>>   MODULE_DESCRIPTION("DRM boot logger");
>>   MODULE_LICENSE("GPL");
>> -static unsigned int scale = 1;
>> +static unsigned int scale = 0;
>>   module_param(scale, uint, 0444);
>> -MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default 
>> is 1");
>> +MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default 
>> is 0 (auto)");
>>   /**
>>    * DOC: overview
>> @@ -42,6 +42,7 @@ struct drm_log_scanout {
>>       const struct font_desc *font;
>>       u32 rows;
>>       u32 columns;
>> +    u32 scale;
>>       u32 scaled_font_h;
>>       u32 scaled_font_w;
>>       u32 line;
>> @@ -72,17 +73,17 @@ static struct drm_log *console_to_drm_log(struct 
>> console *con)
>>   static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
>>                const u8 *src, unsigned int src_pitch,
>> -             u32 height, u32 width, u32 px_width, u32 color)
>> +             u32 height, u32 width, u32 blit_scale, u32 px_width, u32 
>> color)
>>   {
>>       switch (px_width) {
>>       case 2:
>> -        drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, 
>> width, scale, color);
>> +        drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, 
>> width, blit_scale, color);
>>           break;
>>       case 3:
>> -        drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, 
>> width, scale, color);
>> +        drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, 
>> width, blit_scale, color);
>>           break;
>>       case 4:
>> -        drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, 
>> width, scale, color);
>> +        drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, 
>> width, blit_scale, color);
>>           break;
>>       default:
>>           WARN_ONCE(1, "Can't blit with pixel width %d\n", px_width);
>> @@ -122,7 +123,7 @@ static void drm_log_draw_line(struct 
>> drm_log_scanout *scanout, const char *s,
>>           if (src)
>>               drm_log_blit(&map, fb->pitches[0], src, font_pitch,
>>                        scanout->scaled_font_h, scanout->scaled_font_w,
>> -                     px_width, color);
>> +                     scanout->scale, px_width, color);
>>           iosys_map_incr(&map, scanout->scaled_font_w * px_width);
>>       }
>> @@ -206,6 +207,15 @@ static u32 drm_log_find_usable_format(struct 
>> drm_plane *plane)
>>       return DRM_FORMAT_INVALID;
>>   }
>> +/* Find the biggest integer scaling to get about 120x50 chars on the 
>> screen */
> 
> Something like 80x30 (VGA mode 0x17) or 80x50 (VGA mode 0x102) seems 
> natural. But what is the reason for 120x50?

I think this was a good default with old 15" CRT at 640x480. But for 
example for code line length, it's now configured in the 100-120 range 
in most codebase.
When looking at dmesg, a lot of lines are longer than 100, so 120 allows 
to avoid too much line splitting.
For the number of rows, it's important to have some log history, so 50 
looks to be the sweet spot.
User can set a scaling manually, or build the kernel with bigger fonts 
if they don't like the default.

Currently, with 8x16 font (which is the most common), the default in 
full HD is 240x67. In 4K it's 480x135. So doing some integer scaling 
make the default experience much better.

Best regards,

-- 

Jocelyn

> 
> Best regards
> Thomas
> 
>> +static int auto_scale(unsigned int cols, unsigned int rows)
>> +{
>> +    unsigned int scale_w = DIV_ROUND_CLOSEST(cols, 120);
>> +    unsigned int scale_h = DIV_ROUND_CLOSEST(rows, 50);
>> +
>> +    return max(min(scale_w, scale_h), 1);
>> +}
>> +
>>   static int drm_log_setup_modeset(struct drm_client_dev *client,
>>                    struct drm_mode_set *mode_set,
>>                    struct drm_log_scanout *scanout)
>> @@ -230,8 +240,13 @@ static int drm_log_setup_modeset(struct 
>> drm_client_dev *client,
>>           return -ENOMEM;
>>       }
>>       mode_set->fb = scanout->buffer->fb;
>> -    scanout->scaled_font_h = scanout->font->height * scale;
>> -    scanout->scaled_font_w = scanout->font->width * scale;
>> +    if (scale)
>> +        scanout->scale = scale;
>> +    else
>> +        scanout->scale = auto_scale(width / scanout->font->width,
>> +                                height / scanout->font->height);
>> +    scanout->scaled_font_h = scanout->font->height * scanout->scale;
>> +    scanout->scaled_font_w = scanout->font->width * scanout->scale;
>>       scanout->rows = height / scanout->scaled_font_h;
>>       scanout->columns = width / scanout->scaled_font_w;
>>       if (!scanout->rows || !scanout->columns) {
>> @@ -444,9 +459,6 @@ void drm_log_register(struct drm_device *dev)
>>   {
>>       struct drm_log *new;
>> -    if (!scale)
>> -        scale = 1;
>> -
>>       new = kzalloc_obj(*new);
>>       if (!new)
>>           goto err_warn;
>>
>> base-commit: bcf5c42d6ed136cc407cea896f131d6893c830af
> 


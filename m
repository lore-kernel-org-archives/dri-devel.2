Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1176CC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 21:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592B710E052;
	Sun, 23 Aug 2026 21:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Juoq1ivx";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF2510E052
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 21:06:49 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a3ec9ef8d4so556875a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787519208; x=1788124008; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NXEuJBGfzMeA2VoyieQfWVfmlZbv0eldSLa+1qSHcFI=;
 b=Juoq1ivxvQVBF62U5pV2pRaZ7hspmng94FR3DEYbzEL7vQtCfOhcmDcYeVEa5D4v4a
 wCjewh2TKoVbkKsjZLIhnDRXwlUczeRrGbdhPlCwRm+wKTXBLYj0O7xzUyVrspG9yaYI
 /JfL674No52VKs/b3h7UxHYMqu6meJTNGkbRgt/RINcpjv2l1KF6L2Ip2UncT8ftoKgA
 GOvYBYQsgzzhlTNG448v1l5IqfzOmIn6EUbpjn7DvKN/FCGCW4NanF1XLHvZhSmGPiZf
 KzY6w0yEiz33pmYwZzPwHOH+885kEzB42quQAXtcgWYc9Lv1V+34dJKFkOE9hwn4L0Oy
 1U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787519208; x=1788124008;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NXEuJBGfzMeA2VoyieQfWVfmlZbv0eldSLa+1qSHcFI=;
 b=ZCalyRmQK0COQfRft9bdv6ttR7B7ep3DZhVbcDS9f/HZH4JpnwK4Py8fnkHkNpgke/
 oZvLNgOUtjc4kjbGYKSAqjFEnEBuopRxUUOjc3CC/uSGzp6r6WBpPN+MStXZVQ0Zv5jv
 WA9TOflGJfW+nULE7TbIuI4Ytf4Qm9KTZ21oD6C6X/kWrDLNUrRGxQ06c6F00svQwqhn
 ddtm46zITpXBnh8oWTQQkS5WGlAR0Q1n1kYR6tZWoQr3gd6bIBDuvge+L+LFlfyC9nVo
 R1NgyBTPuwV/LRmjknrOBKjOoCUdn7A8/yhk9XXwyI5m56NGJIPEB9qR57KFMDvJUTI8
 ZYDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY4JuUpCFjcnmzjP9idyxfaUDBfSij23DAywrc6cElrGrBDWtSGbaXOJfNPtBuqVA/W0ePJPDfgOE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mC9VGo6afp6BTKm5O9n7CjgU5T5+oWXd/d7tl3WTQtssvMuACo
 QlvstnayhxCbR9raF4OwmRD/g2uwo1JEl3oT5NkeNbWOBm/ib/YtaMjV
X-Gm-Gg: AR+sD114itiXGdEdizusmaK+4O1JyyrfCxO8Jny0+0Sc7rSNQiJrQiZNuKRxL7GxMfM
 JLyovSgvyDFkwJ3eyDONImVkwDRmZAi/pkWLedalRDLjmLgg+kMLfCaXHjZoPnlSDScBRIaoFyn
 pYe88q3nzn5CPNQ9Hs3xnlmbL1oSGn2u3GnldIoHh1yRoFOXVuu/PGtbt/UAZ9T1YLglCprw/W9
 +96GmSzcO+GyK2AupYipv6gPave98c5/Zjb7MzgGX7TKN5mPFRsCrrmhlvE+7qsQPgUXKgFcqrf
 vpiynWN6PaVfAm4IWjz86FTDOwksZo6ughKKcVazU3Tp9MKD6exNvnVjZ6mlBQRDz7sEkGm8+tt
 dqvxqZsMjqpn29xS6xRaDYEe7Ta4eapCHsY8+qDgBeCADy5To9d1bV/aW0s7qdsfU4Cyd9fwc/G
 O3BTfSJtfAobOgNcSxQ7Ti987xvpKbwAvh93/Pm/XREUAnD5ApkjlfCTVEjwyC6QKTnNgJZE//D
 /MMMTSejF/w2holdPZ0JRIFQD0=
X-Received: by 2002:a05:6402:d0e:b0:6a3:fee5:adc8 with SMTP id
 4fb4d7f45d1cf-6a42eeb84dcmr12976866a12.0.1787519207688; 
 Sun, 23 Aug 2026 14:06:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1ccf69sm5175122a12.25.2026.08.23.14.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 14:06:46 -0700 (PDT)
Message-ID: <a239b296-ba90-45d1-b8b8-713ab29fda5c@gmail.com>
Date: Sun, 23 Aug 2026 23:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] drm: rockchip: add
 drm_plane_create_blend_mode_property
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, andy.yan@rock-chips.com
Cc: hjc@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1ab6fb88-3b84-49b5-aa05-202a84edbd3d@gmail.com>
 <25031028.6Emhk5qWAg@diego>
Content-Language: en-US, ar-EG
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <25031028.6Emhk5qWAg@diego>
Content-Type: text/plain; charset=UTF-8
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



On 8/23/26 21:19, Heiko Stübner wrote:
> Hi Johan,
> 
> Am Sonntag, 23. August 2026, 14:29:09 Mitteleuropäische Sommerzeit schrieb Johan Jonker:
>> A validate_blend_mode_for_alpha_formats() function was added that
>> fills the kernel log with warnings for Rockchip VOP version 1 SoCs.
>> Add a drm_plane_create_blend_mode_property() function as fix.
> 

> This is missing explanation on why PIXEL_NONE is the correct value.
> 
> VOP2 seems to support all 3 blend modes? So a sentece explaining
> the pixel_none value would be helpful.
> 
> 

Hi,

In the vop_plane_atomic_update() function there's a comment with win0 blend broken:

	/*
	 * Blending win0 with the background color doesn't seem to work
	 * correctly. We only get the background color, no matter the contents
	 * of the win0 framebuffer.  However, blending pre-multiplied color
	 * with the default opaque black default background color is a no-op,
	 * so we can just disable blending to get the correct result.
	 */

In the function vop2_plane_init() there are these blends: 

	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
				  BIT(DRM_MODE_BLEND_PREMULTI) |
				  BIT(DRM_MODE_BLEND_COVERAGE);

My question:
Could someone with more know-how tell us what VOP version 1 is capable of?
Is there anything that needs to be set like in other drivers?

For example:
		switch (pixel_blend_mode) {
		case DRM_MODE_BLEND_PREMULTI:
			break;
		case DRM_MODE_BLEND_COVERAGE:
			break;
		case DRM_MODE_BLEND_PIXEL_NONE:
		default:
			break;
		}

If someone comes up with another solution/patch that's also fine, as long the kernel warnings are gone.

Thanks!

Johan



> Heiko
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> https://lore.kernel.org/all/20260526181700.25310-3-leandro.ribeiro@collabora.com/
>> ---
>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index 0090d8ff0c79..0bc5b606f021 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -1850,6 +1850,8 @@ static void vop_plane_add_properties(struct drm_plane *plane,
>>  	if (flags)
>>  		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
>>  						   DRM_MODE_ROTATE_0 | flags);
>> +	drm_plane_create_blend_mode_property(plane,
>> +					     BIT(DRM_MODE_BLEND_PIXEL_NONE));
>>  }
>>  
>>  static int vop_create_crtc(struct vop *vop)
>>
> 
> 
> 
> 


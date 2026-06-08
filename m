Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5285DCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EA710F5CA;
	Mon,  8 Jun 2026 15:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc64mVvP";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765F510F157
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:35:57 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2bf55c39e16so20002665ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780914957; x=1781519757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7rfjN8gvyO5A78qI/nvGvuW8Ai7Jn9ZQl2KKv15ni4=;
 b=fc64mVvPTlJEortReKJBBhv6yUqtd0c9hU5cM9bEfrXJZV/I6vs4/3UAXFPpAxUrpj
 hblPO5K84ljTcYpZ80hDBGyFbvZo5ukT31EY3W0HL+dq6oSxmauLRg8gpYQHBef43G8C
 h3H8PabWIAk530QKazyNaEnTxgj8gZeEd+wBEd7EIRTTKkSuDZnWP2rzsdfWcK8uxD+p
 T+qECGiT+UFphC13Bw/1IVU8zKDtGp3fggxrMZ0hG+GFP6yYo17Wh3lMjru1/hszariP
 SD3pz9sOS7cf9bSwrzs8CUnfvM/Zc118CYhLwgM5NF+1PHngk4/WjcKlk2LmxSt5zeK4
 sOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780914957; x=1781519757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7rfjN8gvyO5A78qI/nvGvuW8Ai7Jn9ZQl2KKv15ni4=;
 b=LgJAf3LjwBCpox4uou/OogcUomk0P18vawEskc7b/EpT6WQP6+I7uZhKhHkG3KDXnK
 Pksr0WoerhW3LB6DGRT/sDFJBeDDOo7fK/wVlL9FXl1O90pkQjzhatNUMcgyE4278q7v
 bOoR/IohfiV05BINxKZEvfvkMz+im2qCb8euN5p5HYYd01i2CmWTeK8dZDMfb4MLnI1V
 j7puwc1lyWT8kGQSCOHr5GVtBDkeAxImzk5Bnnm0H7ZzAeaDotqCfxtFBGKUiywtNgR1
 FxE/qfwYqgOAYeIIFy1hJrAHzcqpk5XHaAAEWmmJ+BMxS+n9+P1SH1nN5+mhoUkBPDsn
 mzxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZX3kJpsTen3DmShbbwvbq+eqTkt2cEuH0c1ttX2+sfWZ2gAOkd0Aw8vaPTndHbDn4F+P/RLixizg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAk6DkaaI1AChiqUjsHjsnfKUs8nrXHOaZ4EIVkXswG/yda9c4
 kQmvsVwz6jchSwsQF42vtzKYtTA4c7nBp/8QP6LCYmSecW8kQoW9Jrfu
X-Gm-Gg: Acq92OGBwd+WDgsJwrAmThi1CCr+TfBJBU7bG62DQv8pB28iiHoBHpF2u5e0GUByCMF
 pB+3tv3sxrGKLM/pu3Mmkz/lcoSqqzihfUyB5dSbRwiHTGbsAz3z3rSj8nwSOQ0bZmTBUpVHyE/
 ZQsxeDVWWgDZE4iJu6BUUnGR/NXjYskIAeAex4aKEG+HLNJFzo5huRlBlBLvIJefWltqDUHcyX+
 AJAzbcNWirM0Rrm3icbc5nJgw74otBnHfzamHok66QEx4C/NNWmq6ut5+BahfBI81tojeMB1p6P
 vRtg4nHQ3GwiGzbkITSEH/r8o5/4EaVewm8Hj1Ad9IWLlfKq8mKXBbvezedE6RpAYgR3QZPtC1K
 JNjRe/9NMHBHwgHwe9jbH0pzY9HvveXViJnrjYeLQGJ37EeP7cXtne9yaE7GWuICKWg7KnX+1PZ
 nom4v04TmuZFTbuygpailIi2ZCFsD5lGzMgapA22p2NOm9lWo5RoQujk3AjMyUPU3h4xgj2Mr1h
 I7g1daOV0HEc1M=
X-Received: by 2002:a17:903:8c3:b0:2bd:d6f1:3388 with SMTP id
 d9443c01a7336-2c1ec9271edmr112272305ad.28.1780914956983; 
 Mon, 08 Jun 2026 03:35:56 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649ca4dsm176604255ad.76.2026.06.08.03.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 03:35:56 -0700 (PDT)
Message-ID: <af7ebadc-600b-4128-ba32-d45b5ba6b546@gmail.com>
Date: Mon, 8 Jun 2026 18:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/verisilicon: introduce per-variant hardware
 ops table
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-4-a0987203069@gmail.com>
 <399cd127b56b4a2fb3161865a681606e04e6b2c6.camel@iscas.ac.cn>
 <98eb7772-257f-4fa7-8e9b-51a635cb12dd@gmail.com>
 <340c213ca47dabb8bc3d260311e2fd4818bd8001.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <340c213ca47dabb8bc3d260311e2fd4818bd8001.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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


On 6/8/2026 6:06 PM, Icenowy Zheng wrote:
> 在 2026-06-08一的 17:45 +0800，Joey Lu写道：
>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>> index 1f2be41ae496..75bc36a078f7 100644
>>>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>> @@ -53,12 +53,6 @@ static int
>>>> vs_primary_plane_atomic_check(struct
>>>> drm_plane *plane,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> -static void vs_primary_plane_commit(struct vs_dc *dc, unsigned
>>>> int
>>>> output)
>>>> -{
>>>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>>>> -			VSDC_FB_CONFIG_EX_COMMIT);
>>>> -}
>>>> -
>>>>    static void vs_primary_plane_atomic_enable(struct drm_plane
>>>> *plane,
>>>>    					   struct
>>>> drm_atomic_commit
>>>> *atomic_state)
>>>>    {
>>>> @@ -69,13 +63,8 @@ static void
>>>> vs_primary_plane_atomic_enable(struct
>>>> drm_plane *plane,
>>>>    	unsigned int output = vcrtc->id;
>>>>    	struct vs_dc *dc = vcrtc->dc;
>>>>    
>>>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>>>> -			VSDC_FB_CONFIG_EX_FB_EN);
>>>> -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>>>> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
>>>> -			
>>>> VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
>>>> -
>>>> -	vs_primary_plane_commit(dc, output);
>>>> +	if (dc->funcs->plane_enable_ex)
>>>> +		dc->funcs->plane_enable_ex(dc, output);
>>> Please note that all theae codes are for primary planes, maybe the
>>> helper should be named mentioning primary. Overlay planes will need
>>> a
>>> different codepath because they change different registers.
>>>
>>> Thanks,
>>> Icenowy
>> Understood. To avoid confusion, I will rename `plane_enable_ex`,
>> `plane_disable_ex`, and `plane_update_ex` to `primary_plane_enable`,
>> `primary_plane_disable`, and `primary_plane_update` in `vs_dc_funcs`,
>> `vs_dc8200.c`, and `vs_primary_plane.c`.
> Maybe keep the `_ex` here as some operations is still on the common
> codepath?
>
> Thanks,
> Icenowy
Got it. I’ll keep the `_ex` suffix in place. That way it’s consistent 
with the common codepath operations, and the inline comments already 
makes the intent clear.
>>>>    }
>>>>    
>>>>    static void vs_primary_plane_atomic_disable(struct drm_plane
>>>> *plane,
>>>> @@ -88,10 +77,8 @@ static void
>>>> vs_primary_plane_atomic_disable(struct
>>>> drm_plane *plane,
>>>>    	unsigned int output = vcrtc->id;
>>>>    	struct vs_dc *dc = vcrtc->dc;
>>>>    
>>>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>>>> -			VSDC_FB_CONFIG_EX_FB_EN);
>>>> -
>>>> -	vs_primary_plane_commit(dc, output);
>>>> +	if (dc->funcs->plane_disable_ex)
>>>> +		dc->funcs->plane_disable_ex(dc, output);
>>>>    }
>>>>    
>>>>    static void vs_primary_plane_atomic_update(struct drm_plane
>>>> *plane,
>>>> @@ -133,18 +120,11 @@ static void
>>>> vs_primary_plane_atomic_update(struct drm_plane *plane,
>>>>    	regmap_write(dc->regs, VSDC_FB_STRIDE(output),
>>>>    		     fb->pitches[0]);
>>>>    
>>>> -	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
>>>> -		     VSDC_MAKE_PLANE_POS(state->crtc_x, state-
>>>>> crtc_y));
>>>> -	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
>>>> -		     VSDC_MAKE_PLANE_POS(state->crtc_x + state-
>>>>> crtc_w,
>>>> -					 state->crtc_y + state-
>>>>> crtc_h));
>>>>    	regmap_write(dc->regs, VSDC_FB_SIZE(output),
>>>>    		     VSDC_MAKE_PLANE_SIZE(state->crtc_w, state-
>>>>> crtc_h));
>>>>    
>>>> -	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
>>>> -		     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
>>>> -
>>>> -	vs_primary_plane_commit(dc, output);
>>>> +	if (dc->funcs->plane_update_ex)
>>>> +		dc->funcs->plane_update_ex(dc, output, state);
>>>>    }
>>>>    
>>>>    static const struct drm_plane_helper_funcs
>>>> vs_primary_plane_helper_funcs = {

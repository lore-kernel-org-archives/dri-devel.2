Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E7BC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A20610E19A;
	Thu,  3 Sep 2026 20:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n7wrKmCz";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A8710E19A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 20:45:02 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a5f5d37778so25545a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788468300; x=1789073100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X3guYpEVe0jojtjWvcu73KPb7DZ8REKqlzshck7w5p0=;
 b=n7wrKmCzmWI3Es5lkADFQWDO0QTrWxvFZkAT/NFTAB0Hm6h09pAtm89u3In+FnSok5
 ThXrr9azgGnC5SLeG7pBn3TI+cHNPnsITTWAXF6iYP5K5QuaKmQH6CwNU8wo6ICCupBp
 9OHLSyc6bQwFWEgAT1xT2XZD/v+3Q0TQKE3qjNCWE8WOrSHIqDcWzr5F0fcvd8hPoQs/
 q1pJw7g5iZzjJkcLBD5HK8X2jNh/C63tl3HrXloNbL71zDwFUeuk58habDxaQHWOjfGz
 lyG9GDYEYIFSfSm6rzak3fLm5f5Grjc4szefM+/OOcHLgCLta8F6NLpDL5JYm3ZU9nou
 7s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468300; x=1789073100;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X3guYpEVe0jojtjWvcu73KPb7DZ8REKqlzshck7w5p0=;
 b=hCa3+4dHJkmuTYr12b8tnguLGtd+Ah7+A8PD9s0vkxuiBjmoWtrh9SQZKg56hSatNz
 bI0RlwIIa477r/o7gWjR9nbf+oFPrPgDUp3DFeHknsQPxCyunullT+2kv9Ei27xqoJNt
 7AnH/fAxDeJr3rqAlf2vd8255LqNKA+RHRbEHjpSkJpU/U5MpNE3ZB2JFHhQrDdxM11l
 XbPey+S7+MZKT9XshheUVtwNLh5CP85kodxjBH9XcyFWDMJoK7tvVsGLXdfbBlYQpQF8
 kOyKy/BnjF0hkr5Q2OY2th4I5hU23999qB1yg06Gico+rmjZmzkcCFfF+cL4ThalA3s5
 XO+Q==
X-Gm-Message-State: AFuF++nxMQ0HAyZrrKdDCECIPUBXTX9oR5hD/GyYWD9Bi7WffmkirSc6
 z7RDZoUAFco7x4nnGC18gsesm3aXeR5otjX+B4xO5IGKxN37Wq2Sh9ry
X-Gm-Gg: AYBFou0H952JLCs/vcB5rce++7vI++WGVdfZK8gJxqPgF62Eq3wGcpxrBvrnoaEuqdc
 4m/8B5NjwCL4NCHKAUm0Zf9UQbeTX+wMnnZxq5gK54Yqzuq+vFTfpKWl92uO+xd9dAGYlB7Z/IV
 o15yVHmpJL6RK2YxnR9bKcMfArjx2iOOH8ZMcHn0pYERK0SBeNX4VhBS8tyoF6YLGaF+fGEcyaz
 uQKtJvZz4NKY9RLkObzLJpErU+/l6h9r//rQeV5mv+kAEZ7Q4QeHmyl8BksYqmVTHAPDNLSiD9d
 OyOTXUvPKI8O7MIg4GZAtRV2fi1Rsy1q2hHOhHNjtzZMvbYcomoGY//qviwoZPbdVpxeDm+y170
 WjK391c/gGY+O5wjottgecR87vnYAFQZYrTobGYX/+FJ7U6RWyvj2yFTfVybs/T9U03QFycYwdQ
 K+k3u625nrzySbmHJ2W321PEhPvQNQPQRVYiNNITNuX4RtC3cIs09OfIKTmBeeYOKuxr2qB//Xq
 yR2yjw/hIW9NdQzdjrWc0xVuMZEsG0cYShiJQ==
X-Received: by 2002:a05:6402:1d48:b0:6a0:d411:930d with SMTP id
 4fb4d7f45d1cf-6a7e8d9b328mr180296a12.2.1788468300064; 
 Thu, 03 Sep 2026 13:45:00 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e68a6a1dsm233448a12.7.2026.09.03.13.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 13:44:59 -0700 (PDT)
Message-ID: <afde7cfa-bd1e-40d2-9315-d3d88abb7606@gmail.com>
Date: Thu, 3 Sep 2026 22:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?H=C3=BCseyin_BIYIK?= <boogiepop@gmx.com>
References: <20260824-drm-v2-1-7f9273c6020b@gmail.com>
 <2814844.6tgchFWduM@diego>
Content-Language: en-US, ar-EG
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <2814844.6tgchFWduM@diego>
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

Hi,

On 9/3/26 17:12, Heiko Stübner wrote:
> Am Montag, 24. August 2026, 12:21:19 Mitteleuropäische Sommerzeit schrieb Johan Jonker via B4 Relay:
>> From: Hüseyin BIYIK <boogiepop@gmx.com>
>>
>> The function devm_drm_bridge_alloc() is the new API for allocating DRM bridges.
>> This conversion was missed during the initial conversion of all bridges to
>> the new API.
>>
>> Signed-off-by: Hüseyin BIYIK <boogiepop@gmx.com>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  drivers/gpu/drm/rockchip/rk3066_hdmi.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> index f28d6a883e09..39c65ee07caa 100644
>> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> @@ -703,7 +703,6 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
>>  			 DRM_MODE_ENCODER_TMDS, NULL);
>>  

>>  	hdmi->bridge.driver_private = hdmi;

Can this be removed?
See link/comment below.


>> -	hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
>>  	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
>>  			   DRM_BRIDGE_OP_EDID |
>>  			   DRM_BRIDGE_OP_HDMI |
>> @@ -747,9 +746,10 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
>>  	int irq;
>>  	int ret;
>>  
>> -	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
>> -	if (!hdmi)
>> -		return -ENOMEM;
>> +	hdmi = devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
>> +				     &rk3066_hdmi_bridge_funcs);
>> +	if (IS_ERR(hdmi))
>> +		return PTR_ERR(hdmi);
> 

> If I'm reading things correctly, the parts in rk3066_hdmi_register setting
> hdmi->bridge.driver_private (should use the container field of struct
> drm_bridge instead) 

The driver_private line was added with this patch:

[PATCH] drm/rockchip: rk3066_hdmi: switch to drm bridge
https://lore.kernel.org/all/20250428102309.1501986-1-andyshrk@163.com/

and hdmi->bridge.funcs are redundant by this change?

Not redundant, just funcs are attached in a common function __devm_drm_bridge_alloc()

https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/drm_bridge.c#L383

void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
			      const struct drm_bridge_funcs *funcs)
{
	void *container;
	struct drm_bridge *bridge;
	int err;

	if (!funcs) {
		dev_warn(dev, "Missing funcs pointer\n");
		return ERR_PTR(-EINVAL);
	}

	container = kzalloc(size, GFP_KERNEL);
	if (!container)
		return ERR_PTR(-ENOMEM);

	bridge = container + offset;
	INIT_LIST_HEAD(&bridge->list);
	bridge->container = container;
	bridge->funcs = funcs;
	kref_init(&bridge->refcount);

	err = devm_add_action_or_reset(dev, drm_bridge_put_void, bridge);
	if (err)
		return ERR_PTR(err);

	return container;
}
EXPORT_SYMBOL(__devm_drm_bridge_alloc);

===========

Other example from sti:

https://lore.kernel.org/all/ce9c6aa3-5372-468f-a4bf-5a261259e459@samsung.com/

>>>> It looks like you don't set bridge->driver_private anymore. Is it on purpose?
>>> This looks correct to me. In current code, driver_private is used to
>>> hold a pointer to the driver private struct (struct
>>> analogix_dp_device). With devm_drm_bridge_alloc() container_of() is now
>>> enough, no pointer is needed. With the patch applied, driver_private
>>> becomes unused.
>> Then we should remove it from the structure if it's unused.


drm/sti: hdmi: convert to devm_drm_bridge_alloc() API
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac4531424d907f3983e919a7bda2b90ea0cede4f

============

This serie was missing a few bridges too many.

drm: convert all bridges to devm_drm_bridge_alloc()
https://patchwork.freedesktop.org/series/148229/

====

Please advise what changes are needed?
RK3066_hdmi is broken since somewhere 2025-05.

Johan


> 
> 
> Heiko
> 
> 
> 
>>  
>>  	hdmi->dev = dev;
>>  	hdmi->drm_dev = drm;
>>
>> ---
>> base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
>> change-id: 20260824-drm-e4689f65ab8c
>>
>> Best regards,
>>
> 
> 
> 
> 


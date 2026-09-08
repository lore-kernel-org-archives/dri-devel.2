Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B054C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9752C10EB9F;
	Tue,  8 Sep 2026 12:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x153Wv/W";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A02310EB9F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:16:57 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso57347005e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788869816; x=1789474616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GscIAiMi1PshYZNojpTcqqxjTAW/t//XtB7WYCOhKZ0=;
 b=x153Wv/WbQIF0qyStLMKGfDL4AT4LJcz9wOSj57iDFXkExd2v0Pc4BU5cJHfSKRcRu
 1EfcN6lq0CKRJbncPYNsNilnedbU+QG7AOlIJKuR7nfcQ7BpucOxQq8Pcym5aYl4oBQe
 sr8/uVpvfWY0cOa5EjsqAp31TVWPna77c7y+e6GYU7P6lWHJOUlyjFUjYKU4lFUSBvRf
 kebdFyDwvyaNXUu212ZxQ4Ydem6+mwMAmJ5V+//JuJtL9KiI37WmU4UPngyfvkW0gb0Y
 s49QdlefuW3ZlUegWiIbEAryuMHVmDHT1Lzmh5PHEF3L+08vA4DYNYeZyCsFPKwBuKxl
 QSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869816; x=1789474616;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GscIAiMi1PshYZNojpTcqqxjTAW/t//XtB7WYCOhKZ0=;
 b=PY+p68FjO/fgGfjcsFq0mi1g8eh7Q8CqgdY8bBTcEusAE0mYbPFLKuSgIDyp06GijR
 0Vsp+B3+q6+Ving0sa0xgz9su74oHzDej2z0AXqJFPpQOLhwnUM3t72k6f+GKVdv8got
 Ws1QYwu7pNXlnqJFPmbJ2xXglT4z0wB+trCe0TRDyqGfvsyKXcOgLdL4DCXBwISPTE9/
 etiGakmMoq0YJz9n3aVlTz0YLSKH7pKrRpltbSQOGZaSs1MOxnqYEJes01XhSzKyI9ET
 ahO4AqTGpMA3b4oZOKDXwaS/HO0udwQGxBqs89LUsh9CoLPXzXZnZThva/SGmD+Kbr9l
 t6uw==
X-Gm-Message-State: AFuF++kZlkudBiWv8QTbV4X0zNDzAMlXzbcSt+AcGsWh6aSliKa6+OOt
 WrbHQi9V38Vi3QSg7la3dpccAtQl1W0XuvUU8VQBz39mubBwr6nmfqiKZ/dzWXkAkps=
X-Gm-Gg: AYBFou1Yv4ByrDaiT5hxkMSwSvBMErnVbaLMCSeQBtpYcCM3ICWk1X6A7hLoXGGbeiI
 mqATASiP0G0W937kIyx09Hr45qKius6FMZSrEHLYM7OwoCNrimiw0dcODItgBmMG1mK02G1EnRV
 5sZUMtpN8os3BuKVe0ahmNFwwPPeE4PA9TQfGwz2J7SC9umBHFhPJrk7Tz/EisEmNwq7/eW43uJ
 2bXWzUxdkPGUJSycy1vS1QO4DdbJVqXAC0e3SQz/d6DKyYIrgXzA9gjGPp+WZiI1nuS70NZa/dP
 0aUxU3dulX60LVi2JheDulquAs9WQpyAj+DQKPnMjtvnw1NNeRTwGQIOt1VzBvtONrsn7kG+GQA
 uVhUybSgZBbS9UPBE9bjPlmI3PuHQAjXuC8mqPKAadIzzjWSJd/UNBy4iFSKX61I3ujMxwuE1yE
 LO1E+RUmrogmkdajMrR/AD7vg+HA6zv8xVFkLILMcOaLUyFEP6LsZU4f3q2EoYVK2o1J2/JHV3j
 wWS4pDVWhsOS78PekrYv4IWljM0tighudtdUXJQVsk=
X-Received: by 2002:a05:600c:548c:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49cf8267dd3mr297679935e9.12.1788869815441; 
 Tue, 08 Sep 2026 05:16:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ea45:883b:8b89:b4e5?
 ([2a01:e0a:106d:1080:ea45:883b:8b89:b4e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce592b01bsm1456845e9.2.2026.09.08.05.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:16:54 -0700 (PDT)
Message-ID: <07ebc005-7443-4231-8908-e71f7d7c35a4@linaro.org>
Date: Tue, 8 Sep 2026 14:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] drm/panel: samsung: Share test key command helpers
To: Linus Walleij <linusw@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Yedaya Katsman <yedaya.ka@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org
References: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/3/26 23:21, Linus Walleij wrote:
> Several Samsung display controller drivers use identical three-byte
> commands to enable and disable test key levels. The commands are
> currently repeated as driver-specific macros or raw DCS writes.
> 
> Add a private Samsung DSI header with typed helpers for all three test
> key levels. Use it in the drivers that already identify these commands
> by level, including the S6E88A0 AMS452EF01 driver whose comments identify
> the raw F0 pair as level 2 commands.
> 
> Drivers with conflicting level numbering or without an established
> test-key name are deliberately left unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Linus Walleij (2):
>        drm/panel: samsung: Add shared test key helpers
>        drm/panel: samsung-s6e88a0-ams452ef01: Use test key helpers
> 
>   drivers/gpu/drm/panel/panel-samsung-dsi.h          | 38 ++++++++++++
>   drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c   | 71 +++++++++-------------
>   drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 70 +++++++++------------
>   .../drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |  6 +-
>   .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  | 23 +++----
>   drivers/gpu/drm/panel/panel-samsung-sofef00.c      | 15 ++---
>   6 files changed, 116 insertions(+), 107 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260903-drm-panels-sofef0-73886714ac49
> 
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A1FCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3134110E225;
	Tue,  5 May 2026 13:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H9ibgiMi";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8FE10E225
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:28:32 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so83348715e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777987711; x=1778592511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=v8zvshtiKUBMbbv4GkLxrVfyYZwq8RqVDHQpw4VGH8g=;
 b=H9ibgiMi2PjbEYVVz50VmjV1870QEZP81efnWOjqpPsTLemfFL2xDDuqaxDQLJ/GVr
 ytzoJ3HK83UwrsDQI/FHWfpdiR+rlmv/lS8JcOJowNCUMs3N5a0qxo8ufquBwKZx/RGo
 DRB7bLu44rqXdes+2PjeroMFzJXCuR9Zry1SA7w14tAOeCPmlQdqdtWpwx/aVXSFQk5R
 zzTFFt4VfRVEv4TWyRSN30OSoyYkTsjMLzW31SrDsNkVXLt/BD2vHl2PgxXdRRqHMKLd
 U+zw9Wz26ggV5WO81r7qQ+P/6+qlyWaw8uhYIT9ygu/8zrFxsV62JVVAbiIe9u0QBqq8
 SNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987711; x=1778592511;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8zvshtiKUBMbbv4GkLxrVfyYZwq8RqVDHQpw4VGH8g=;
 b=RqlomblT1rUJquNfinrHi9pQmsYWyL/kDRYPEOXdO56yFO3xBUgFvhk/X/9WWcihFx
 tFlhKl4zyTdfAoEQG0u6rHJ3Ku0GQ5PtI1VqZaqYEZGwEiKMvyGfxSG/+NxVx2YahZhx
 6BUilZVt6GincmZuhJY5qAydz5VNHH0piRnARUT/1RpD//nzWLove1Yvsmqk/bS4MJx6
 ti3GJ4CoS3n0rrKwyaVF6RamLsjhF8YgVJonr5QoUv6/6xtS4bXfJZ4HLuaXUL+jvtwn
 9umQDTc+HBuEzRFBd8PhbHhREDgnf2SBoMRk/+iQkB6oyxn/7k49aj8mMujXV43twHI3
 lIJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EJCBEAjnY3QBG/WKTUftoFoHPLkbYMi3ri9tzK9fQMQWJoQ0/6ovEabyjmvJ6hR4iq4Outt5e9/Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqeWTe+Kx+Eb9icWSz54q1OvwrFQCjqK1uQdmEtE+daKdp+aYp
 RTnLoFffe6F2GUdte1JDyV6DfF2mg0o33i4m7MVJqkm4m9MrXBgl7YHb3w80bdmGeYQ=
X-Gm-Gg: AeBDiesEJwCNltFkfR/Wz/x4zWi0VngEoL+gO2tHkltCGGiZz4Vzn0nDBzzx435YeAL
 kPMxO0oDJMOCCjTRf5HvDgiCWI5fevsI5cEGBb7SJEr7vQBS2KIqXK3ooXQnKlfkhJWU7Y6x6NQ
 vUZvg0LT5gUjJiGjV304rSrhT57RsqC/hOOoGSBelU1yjHL+M7lVDq3XtHLeJ5Evu67eBhlvHSx
 ICa/a9yiS/7P4lH77wRFxOrBabzKVWIw+OgtcCuap4VcicZJjYqMBhe3ZM5iu53TTZO2FvxJffv
 ptz0NylrLtwQ/8ojMwkd0t/v15rQhG4LtdnP/21EzVIn2/E1LeDYZ8J6lB9A7wlbNdcuAEfBCab
 +aY+yd8zR3MqN81vS3Kv7cyanJcLMFqKvyfxJcT4p/xDCgvrrPNTS0f1tbcpDPvVoDMqnYhnyDU
 eGhOzlndvfPi/Rpj4GkxtJ14E4P/DDT+bJGMTMDzD51A4KFpZRzISkDGvNpsGBWLvQCVPeekIlZ
 L0RdlvjAT0cjNjUsg==
X-Received: by 2002:a05:600c:a118:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48a9865d8famr176983735e9.13.1777987710597; 
 Tue, 05 May 2026 06:28:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:19a4:dd04:854d:9f82?
 ([2a01:e0a:106d:1080:19a4:dd04:854d:9f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6ffb7sm354941905e9.5.2026.05.05.06.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:28:30 -0700 (PDT)
Message-ID: <602c39cd-d412-4315-8d1b-28053c55db61@linaro.org>
Date: Tue, 5 May 2026 15:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 2/4] drm/panel: Clean up S6E3FC2X01 config
 dependencies
To: David Heidelberg <david@ixit.cz>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260422-panel-clean-up-kconfig-dep-v1-0-d825e9ffe911@ixit.cz>
 <20260422-panel-clean-up-kconfig-dep-v1-2-d825e9ffe911@ixit.cz>
 <ebe54ec7-9cf2-4243-a616-34b18c50fd57@linaro.org>
 <e20e87fc-532f-42c5-a60f-37b900d74dab@ixit.cz>
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
In-Reply-To: <e20e87fc-532f-42c5-a60f-37b900d74dab@ixit.cz>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 4/25/26 16:57, David Heidelberg wrote:
> ...
>>>       tristate "Samsung S6E3FC2X01 DSI panel controller"
>>> -    depends on OF
>>> +    depends on OF && GPIOLIB
>>
>> Why OF && GPIOLIB and not on separate depends ?
> 
> No particular reason, is the multi-line syntax preferred?

Since OF & GPIOLIB are not strictly related, yeah please split them

Thanks,
Neil

> 
> David


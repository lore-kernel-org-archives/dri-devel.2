Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D088BC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411D710E598;
	Tue, 28 Jul 2026 15:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qvt4TVUt";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9FC10E598
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:34:49 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so21173345e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252888; x=1785857688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y5Zf7wRSskDiF2pA206nVhKZfl95/heLe/kfq7vnsjU=;
 b=Qvt4TVUt8ptCujW3zem5uebnKvH2/6DdqWhYXgN3Q6L3oHwr0Cme8rBpHR6RDNSlJP
 yiJqxCJOQCyTCrQHbzi9Ze0WYKbIx2u3jPf2zPzDRZ++CL5UMvqY5QkTMAOw2E+M4fw+
 s+6ZJnP81MGekFgU7CNYfvnbnlwxLuvm1DhmzmzzZKIYsMZuqxAjfHibziNiNPMFtXYc
 DH+a+YGKRevfVw8ELcmT10tqIYDN4lJMDGrosUJ9QFNqaPwh9LIsOdjmTZdKQX2tdgnr
 Ip3P8U4JPP1Z1bfmgaMFrNUF0RQWJ8q9sd1AKols3mdBCigFo/+WsM3IpgJQBsBhfAyF
 kY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252888; x=1785857688;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y5Zf7wRSskDiF2pA206nVhKZfl95/heLe/kfq7vnsjU=;
 b=pfxITbAMegWus9HjH7dSLVtRdjZqeC6Ct34koDQl/GelaGDYe6Lu+7BfhmnD/veyK+
 5ZQtNzxBR0E6hOGyHEiN5bHWX308BZPcUZ9vjUMAJgxtIeNejTaNivcE/95w4ePzojVd
 JeoUXlDmNI6F/6B5uyWtCdw26yh6vra68D/KMsCwAoWrf42p75pQrcwbkfKBlV1wE9Io
 4F9Z/9OBuLuC3YUYOudWS3XBqavdybZ5snG/ECB8cjCuAX4g1Yn8doGyiJL6s0TirBiq
 SwfWVwdCwASVRFJHBghj/KjP0a8tGsm5d/qUeDlfqv7OVZhdyKpfyturNoz9AAJcMpa1
 UMWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFnMpWG0iZ0b0lpG4VE9ubTOn4WmFu3vfYvZjUZX9hjKnxJRoywU40yIqDQqkVX4xfrirZzhGmswA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4wAWaiSWwB7EaETEpVIPqWYRP2wyi5D/JeoxYv0nVHrmsBtFB
 oa+fBZsGxrAbsQcCX0CDXArcq8YU5tw9dsOiY8vuZvQPvHw0KfgA3Is6skX3OF+D1V0=
X-Gm-Gg: AR+sD10wCQZeNchuh8c7PNQhcOZemmtLwI5HsnZBEUQUxfBaO1Z6bQ5ic1NsgEQ7hEu
 JHdUQkBYR9oZOQlocdxCMChQCaDi9QTWICwiaE3f7hkbGM+mTP21BEAmcqObzc343I/mM+wKMRC
 4/F6CRzGkPXIcG0rQ6bVAW4WcwSd//Bbd+qLKaGew8GS8ejUYTB1Uy96WcGkyq8w5tAEEmB+Dl0
 2tdyOUeGcIS8zPVpOeZJebK8syuyFgejgguyPgHxNCqm4NaHulm1WWq+2X0C3iEsB3bGrbm6+yj
 k1aIyFvaClsHPXpsttzdxkr/xVuZm3B9YpOBdpDxjL5wqE/ffX6H5JvGuNVmvWPy5h4FusLbnVq
 0Wwxq4aTZ4zDxOIzG+XTXVTfC1etA3t9cZt+UFUXi6SV4coGcu/SYMyiPpgq9q4y21llfqmK8DO
 llAYTypRG4BBp/yG8Tj1eUG1LPM7VpbCoNGOjNilPdp12fFB1zB17OvuyOww==
X-Received: by 2002:a05:600c:c4b8:b0:495:5858:8101 with SMTP id
 5b1f17b1804b1-496c642fe09mr37096115e9.15.1785252888034; 
 Tue, 28 Jul 2026 08:34:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6843:9af3:9745:9034?
 ([2a01:e0a:106d:1080:6843:9af3:9745:9034])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45ba4b0sm88914705e9.6.2026.07.28.08.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 08:34:47 -0700 (PDT)
Message-ID: <97ebc5b4-0a54-42f5-a3c9-560852f19330@linaro.org>
Date: Tue, 28 Jul 2026 17:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: chipwealth-ch13726a: Fix washed out colors on
 120hz mode
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com>
 <CALHNRZ_EQyP6apD-0YboXEua5Hk1u2oVMo1M7vACK6vzMRp03g@mail.gmail.com>
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
In-Reply-To: <CALHNRZ_EQyP6apD-0YboXEua5Hk1u2oVMo1M7vACK6vzMRp03g@mail.gmail.com>
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

On 7/28/26 03:38, Aaron Kling wrote:
> On Mon, Jul 27, 2026 at 7:44 PM Aaron Kling via B4 Relay
> <devnull+webgeek1234.gmail.com@kernel.org> wrote:
>>
>> From: Aaron Kling <webgeek1234@gmail.com>
>>
>> The issue was determined to be two-fold:
>>
>> 1. The non-continuous clock dropping into LPM during blanks causes
>>     voltage drift at 120hz enough to affect the gamma curve.
>>
>> 2. The agressive horizontal blanking width did not allow enough settle
>>     time, further compounding the voltage drift.
>>
>> In addition to switching to continuous clock, burst mode is also enabled
>> to further stabilize the blank intervals.
>>
>> Assisted-by: Gemini:2.5-Pro
>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>> ---
>> For the initial submission, the washed out colors were expected to need
>> to be fixed by a color profile. However, further investigation showed
>> there was a problem with the timings.
>> ---
>>   drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
>> index 562dc573528dd..92f0c4f1587cb 100644
>> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
>> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
>> @@ -128,11 +128,11 @@ static int ch13726a_unprepare(struct drm_panel *panel)
>>   static const struct drm_display_mode thor_bottom_modes[] = {
>>          {
>>                  /* 120Hz */
>> -               .clock = (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 120 / 1000,
>> +               .clock = (1080 + 60 + 8 + 60) * (1240 + 16 + 4 + 8) * 120 / 1000,
>>                  .hdisplay = 1080,
>> -               .hsync_start = 1080 + 28,
>> -               .hsync_end = 1080 + 28 + 4,
>> -               .htotal = 1080 + 28 + 4 + 36,
>> +               .hsync_start = 1080 + 60,
>> +               .hsync_end = 1080 + 28 + 8,
>> +               .htotal = 1080 + 28 + 4 + 60,
>>                  .vdisplay = 1240,
>>                  .vsync_start = 1240 + 16,
>>                  .vsync_end = 1240 + 16 + 4,
>> @@ -281,7 +281,7 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
>>          dsi->lanes = 4;
>>          dsi->format = MIPI_DSI_FMT_RGB888;
>>          dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>> -                         MIPI_DSI_CLOCK_NON_CONTINUOUS;
>> +                         MIPI_DSI_MODE_VIDEO_BURST;
>>
>>          ctx->panel.prepare_prev_first = true;
>>
>>
>> ---
>> base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
>> change-id: 20260727-ch13726a-washout-54ef8fa65be6
>>
>> Best regards,
>> --
>> Aaron Kling <webgeek1234@gmail.com>
>>
>>
> The sashiko report that the timings in this change are inconsistent is
> correct. Which caused the 120hz mode to be discarded entirely, so the
> 60hz mode was being used which has correct colors. Fixing the timings
> to be consistent restores the 120hz mode, but still with incorrect
> colors. So this patch should be abandoned while further investigations
> continue. Sorry for the churn.

OK, please add a Fixes tag when you find a proper fix.

Thanks,
Neil

> 
> Aaron

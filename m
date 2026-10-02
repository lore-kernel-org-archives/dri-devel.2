Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC030CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3201D10F795;
	Fri,  2 Oct 2026 08:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KJOcEPZE";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926A310F795
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:12:32 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso75865425e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790928751; x=1791533551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xs5oz1JmPTBBqK5n7Rqihg5Y4URFjfrr+i3MIUtEfRY=;
 b=KJOcEPZE7VybRgwKfYMpLSep0Nlvf3wbvFeOFX7NUpfKTGEo3WITp9M+FkGcqBx1DV
 eKUuE16KKVAsqkF35jVmiSvObHb3YkH6YxVSg8uBoni0JlvBlX+nZBvaTxg1SIctnw7G
 qOCmjxvYdABgM51T4i0bjQMzev42bDYHd0Z6LEGyd3+1c11oV8YJhnlV6bAWfeXGDypK
 B/xSZJ1iEst2VV2XoxaR/XSWR/3qIGZA/qr75GA6Lco5di+g4BY5q+y9bo/44nzjsLtJ
 rzx20ubDnQISZyhUTPpQ+2vXAAQyqkBVniBVsb6xQ71MjWU4bRtMXYJHqAGFcoCsuFn2
 Ku0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790928751; x=1791533551;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xs5oz1JmPTBBqK5n7Rqihg5Y4URFjfrr+i3MIUtEfRY=;
 b=s6h8HNRKHJZzAD3o49/yH7eLTql2xGAogwzo5qbKiP/sOcj0wkawP72h6oiz0/53l0
 +zh7/ydwXNNuEk2KImTOsZ1ZuSqJRZR6cez3wtwb7saHXgpqjwRM1ztwiVCLMIcK9Lr1
 i1NENvUrovbCoGINvdQmXS31W2s0mtwmuu6MMVLzcZJWbnaCmBt5J1Iifa6g9/+pcbwz
 H6nq9a0ho8ovW/+zfFJK8IKc68J2rFpZ7cX81alaeWyA5OxiOLNFnuQHDP+iBnDq78+4
 13cdcMomCzjzKpQjZkmsmBUCghrpKwSbraPGiajwMUHkbYhTpDm/VX1qQFhGYnlEp+i8
 /IFQ==
X-Gm-Message-State: AFuF++lo2qjTDUxr5cSH14c4ULXjs8IOAV7bjiN4YgH0Jb702792pmdo
 PNGMjuIHFn1BWdk+5wyJAfx6/BP5u87BuX7A4Vq0UfYiVgdp4fgQl6TX96SbM00hnZw=
X-Gm-Gg: AYBFou2VBvER5a6lW2fy4m+WLG1Unawyevo5rLMrGTPEwA0VV3aHE48yO65SIoqcCD/
 nvK21E3/VZt7gROVLayxjoWM8MkJ6sf/xVJ32Rl2eztMoYidR//3YmlBC4aPfFoKVNdlu5UeAZI
 I5a1XRhkXCgP03Y5jPOXDmoghU3wU0WWczXWqXdH5swBt4Wch+3XM4sd89QyPAYkqieU4a/xqHg
 iY4qQBGDBr7RRg5GmCmy13nkzhIQthe/AZZd4iVShOGEAbZBntJWxqqe47U4VSYXhsF9uo15MZC
 SoBHTUntL/ejXXYrPyknHWr7YkGPxRFowMBTRV6XadwOtHUKuJLpXNNjavjmRoMgIoFDYVy+bEf
 5BeRXHGp2bcpJPBjU9YPCSt2hOsDzTAzh/kMjW+I3qd9Z/ENqilGyZS/jF0jW1VTzJzqba6LSz2
 4k5ZZVoPmQfLdu2MteDDVNLD3KNkjl0k7Hvhh7p7nS5YC8haIZoyR0TE7VTZY0RmfuCh/iD1Knq
 InFbkvkgE9WgW3L3MAy69A/GmAHr476iSMN8/aFpTt8O4sdMkc=
X-Received: by 2002:a05:600c:c3ce:10b0:4a0:317:1996 with SMTP id
 5b1f17b1804b1-4a02769f2a5mr24217955e9.27.1790928750805; 
 Fri, 02 Oct 2026 01:12:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2f62:6d3:721b:8c9e?
 ([2a01:e0a:106d:1080:2f62:6d3:721b:8c9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0394c937csm30885075e9.1.2026.10.02.01.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 01:12:30 -0700 (PDT)
Message-ID: <cd764af7-3fa9-4b35-9c0d-9a0b863e464e@linaro.org>
Date: Fri, 2 Oct 2026 10:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: ronbo-rb070d30: Ignore DCS errors in
 disable()
To: Hsieh Hung-En <hungen3108@gmail.com>, dianders@chromium.org,
 jesszhan0024@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
References: <20261001004940.110776-1-hungen3108@gmail.com>
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
In-Reply-To: <20261001004940.110776-1-hungen3108@gmail.com>
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

On 10/1/26 02:49, Hsieh Hung-En wrote:
> If rb070d30_panel_disable() returns an error, drm_panel_disable() skips
> clearing panel->enabled. unprepare() still powers the panel off, but the
> next drm_panel_enable() sees the panel as already enabled and does
> nothing, so the panel stays dark.
> 
> Always return 0 from disable(). A failed ENTER_SLEEP_MODE is still logged
> by mipi_dsi_dcs_enter_sleep_mode_multi().
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - Add a comment explaining why the error is ignored (Doug)
>      
>      This applies on top of:
>      https://lore.kernel.org/all/20260929080143.559685-1-hungen3108@gmail.com/
>      
>      v1:
>      https://lore.kernel.org/all/20260930013029.3241267-1-hungen3108@gmail.com/
>      
>      Compile-tested on arm64 with W=1; not tested on hardware.
> 
>   drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> index ebe6352db..9adf97aba 100644
> --- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> +++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> @@ -87,7 +87,13 @@ static int rb070d30_panel_disable(struct drm_panel *panel)
>   	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>   
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> -	return dsi_ctx.accum_err;
> +
> +	/*
> +	 * Returning an error would leave panel->enabled set, causing the
> +	 * next enable to be skipped even after unprepare powers off the panel.
> +	 * The helper above already logs any command failure.
> +	 */
> +	return 0;
>   }
>   
>   /* Default timings */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

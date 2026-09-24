Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA09C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083E110F581;
	Thu, 24 Sep 2026 13:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pdXVFJ5l";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704DD10F581
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:37:52 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so844868f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790257071; x=1790861871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czECHI0/k3wkyu2UFpcXryFcDXjrvdMhsjt10rPpJ7M=;
 b=pdXVFJ5ls2gT60HAwNfPiAX/BV7HxHyBAQBkopm+/EuHH9ht19UK2PUQOzrbygv+kf
 wYmDO6kk0EWm0zMjxrRDqfUK1J6QYr03OqrH8+JCtTmHt6go+M4eyMS2sPkOwauEqOnC
 IG+J8usU7Z1Y5Rdsm2VWpw+v5sjiyYqzUPCatSqZC/Q0keFHA/z+ZugeWtsHPgzh6y42
 hTma35kg5jtsIRN9QjLOwQwHSBOmw2cP0GOtDEsOGlRXtN1DBCk52KI9QUtwrDimrRdL
 0czsqnbOFMq5FILrxpXKlwgeoj2JHRgdXf4MlbbE2+ByyTSltCJxQZz/Gkokirco+iG0
 /6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257071; x=1790861871;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=czECHI0/k3wkyu2UFpcXryFcDXjrvdMhsjt10rPpJ7M=;
 b=ffKFI/VIX9lzF7jXdOxdaDQO6IKwf/6Xct5qiYyeMqyutS6j+gijyjv05ommP2fUH/
 CqJ5bd2PS/FqD1dmnRduwNQX4b1JjTuQuGYxHFkLd6AanLThtH1HUfgALYJQvl9mwYsP
 DL71K+xJb9zm10KweHEFRXNYiCK+XAt27ZWVLySnTi/4IRb0QDCTqBukXdJZGkp/Wtvh
 GYvFZ0hF0KjMFxtZnu7HF//Vspht/1ILxSxFx6RIubSVnfGMApPultQPjbQYd4CP/9vt
 fR/Fe8GkOLqUq0V583qPWcmnY/randUVNzKuwuSM2hMDUbTrwoLIOMAQw43USpDxwzjt
 Y4LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6ILmlrNP4OR6hXqpkeFYMqT89bOa4Fih0O5Kc9yoDlbdGi6/1L4O1hdEkHVXeoC/bEbLs2XFZZ3M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lF2c8ozU97vvDs7JZLgctPGioYWiEVsxXpihJTHpdfHyGRSV7V
 iDvn/+kf0ri+N183IUwnbYI1o22oMy9Jr2oWkAbSW2DeX/B5UBodNulqAqSvqQTxOK5cDHjQbL6
 J30cL9mU=
X-Gm-Gg: AYBFou08AZs8aZuNEIQ6H1LUof6un+gkkDzA4NiCQ5xP64gFN8onSheEDOFAy/jRa7u
 zAsClZMpR6X5LjV0XtEX6Q/250bgzFr6eLekS0crz1umPFyk0OiswSE6ToIzpFO1U4D/rPQpgzP
 6qeQfw8ZWJw6GE7CD6Cs8v67WBiT9qTZ1qfZG4BhiVAD3kb8GkjJugSGPF2DM6h+1xfbcvodWVq
 dSSHDQeSr5asRBWeAKqUUnIf8IGKdeDCwKGIcRl01rClTeOcyT0GY8vCmSNiFGDp71qfYp9SbpE
 FvwBazocDtEACYqlN/9vMudSh0HxvIrdPQ1q4tKWYiAu+0q75+6zTVZhJtTM/CmUejVpZ4AmnfY
 +SixQkDKna2S3/JI1aY9+hVi+7Y0Hl6KkuNth5yCDKM6umjCPTzwlATdRcc5/ydO1wSUOivO7po
 571Xa/ff3c1hJ1GAPqkql4Tke4AgwIge4WCHCWFMf19L0zA1A6cdY9lfBxlbcgvsf7/bigE+98j
 yfBMiHB+mGJzBnqWBYiGUUbutvwM0uI9iqDj0EvYedZ3XBjsV4JaQ==
X-Received: by 2002:a05:6000:470e:b0:487:342:eb37 with SMTP id
 ffacd0b85a97d-488716954e0mr4204794f8f.7.1790257070687; 
 Thu, 24 Sep 2026 06:37:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682673bdsm14741846f8f.2.2026.09.24.06.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:37:49 -0700 (PDT)
Message-ID: <3aaa9d04-6bf4-46a4-80d7-9828405b7468@linaro.org>
Date: Thu, 24 Sep 2026 15:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: tdo-tl070wsh30: Remove panel on attach failure
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260919191524.268810-1-meatuni001@gmail.com>
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
In-Reply-To: <20260919191524.268810-1-meatuni001@gmail.com>
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

On 9/19/26 21:15, Muhammad Bilal wrote:
> tdo_tl070wsh30_panel_add() calls drm_panel_add() to link the panel
> into the global panel_list before tdo_tl070wsh30_panel_probe() calls
> mipi_dsi_attach(). The panel object itself is allocated with
> devm_drm_panel_alloc(), which only arranges for an automatic
> drm_panel_put() (via devm_add_action_or_reset()) when the DSI device
> is torn down; unlike devm_drm_panel_add(), it does not call
> drm_panel_remove() for you.
> 
> If mipi_dsi_attach() fails, probe() returns the error directly:
> 
> 	return mipi_dsi_attach(dsi);
> 
> Once probe() returns an error, the driver core releases devres
> resources for the device, which drops the allocation's own
> reference. But drm_panel_add() had already taken its own reference
> and linked panel->list into the global panel_list, and nothing
> undoes that. The panel is left registered in panel_list pointing at
> a device that failed to bind, where it can still be found and
> dereferenced by later lookups/iterations such as
> of_drm_find_panel() or find_panel_by_fwnode().
> 
> Call drm_panel_remove() when mipi_dsi_attach() fails, mirroring what
> tdo_tl070wsh30_panel_remove() already does on the normal teardown
> path, and matching the pattern used by other MIPI-DSI panel drivers
> that pair a manual drm_panel_add() with mipi_dsi_attach().
> 
> Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> index fa961abdd2d7..32f2dd2bcee7 100644
> --- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> @@ -179,7 +179,11 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
>   	if (err < 0)
>   		return err;
>   
> -	return mipi_dsi_attach(dsi);
> +	err = mipi_dsi_attach(dsi);
> +	if (err < 0)
> +		drm_panel_remove(&tdo_tl070wsh30->base);
> +
> +	return err;

Switch to devm_mipi_dsi_attach() instead.

Neil


>   }
>   
>   static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)


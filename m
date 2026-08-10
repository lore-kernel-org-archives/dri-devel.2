Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430C7C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7089610E6EB;
	Mon, 10 Aug 2026 09:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c2GgHWNZ";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2CA10E6EB
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:52:25 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1335887f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786355543; x=1786960343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A/rNB53EPT8cj0jg6UkNkJ8sSSyhUGBEo5y4v0oy9uk=;
 b=c2GgHWNZ9LM34aRvEemAkhtZX+iuzS5gbMzUvfClxepW/A/Se0Beyh4Kps/rWxSiRP
 6JnwWMf1wAwFBjXpS8zS6P+K9fA81avabKr0eDS8zHh5UgtAd6tThErk3wx7MdRib9Di
 LLTzFdEXj3ur9S09MMlB04BnXzjc3pEF0ze4LQSP6VvHNoc2udL7TTz9F40RlAk3nOwM
 kBxldYm+fNO2lWh5OUkbCBEPAzFTi5hEn03QBK+xh7LPvJ+ceqVZXIVsE8pNwFtis4eW
 fw9uO6TcM1pTMZDVplhsRdpkOCBqM4dEddqGtMSZb2tn2uf024ksAwZHniRhEJa2pZv9
 X4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355543; x=1786960343;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A/rNB53EPT8cj0jg6UkNkJ8sSSyhUGBEo5y4v0oy9uk=;
 b=jGy2pkUprrIGnZGAjJaJC2Dn+C8N5JTUOp1lUt3p4QyzxnIt3IhzdggH8ocXJQA6m6
 QZZjMLBNBe4mCjwBFJkXVHcLIRzhJ1SYyCNUkK0UhgRKl/OBd+OEyO9sA7istUOwwqmh
 Aw7L//6utOyF4DqYtd3cY5uOoiF1sJhY/Gvv38kQhHKqm9kco7Xm7vyv7MlOSPHfhuMA
 f2LxJLNCAQc7IU+CC6JQb07TtfFEHTeBue80Lvi6O6n7GdPHgyq/nFSh1hiSNV6EnIlh
 H1JswChIjWJIzbgu7JBXgJFl+LHMcNBHnQsOLdApbtXoKxsvfEpPa/43SNK1/kTkTts4
 oeVA==
X-Gm-Message-State: AOJu0YzDwtZyXS4+mzO1dhE/nWFjEgrJ18+O8kOUlAz1SeTKFWGzE05K
 to4vTdg2gBUaKh4t99oChDnsQ0Ui0iI7DvWkmt4wMPPHueOhIG80XqiSxcBbZPCm5iM=
X-Gm-Gg: AR+sD10OKRODsmqCCbXmJVcgNoejjHg7mGmCiApYk7tB9BGCdNAiOft3tBAd0TlYZfo
 qWTNWfrBoT/oQf6PLYEEAJrLX6VXs/RYC2qcsjZreDIRckYofOEX//Ke4hz9AgSZ0bYw4LX2I9w
 WUKYTBA0KdZlfV7NAF1QxFTl6btWsL3SBwSbovfYzEROfSSUe2zPTYIgknivHIFXxXgsrgiv9eP
 K/hZA0LPMxxJMGdF1Bh2E/bN6BXsHs3BM+/EEepXiXr2K7o63oCYm1S7EKdyJ2DmZvwUwrwgEFz
 Q9GQyUdGauYTl8pXkdaUxH1PfIwynD7YOquEn2MeA1ns7a4OxSVWPt3G15QTeejPAgVeJ5HCvax
 UUM1u6sI78+Ls0ySkqvQeP2JBXQUL5Y0QvpKj1nJ0RrSCmBJLpNrtx2ulSwNmY198fo9FR5Fd2f
 em4TJyp1st8pOmtTG+zzuuxDumaLOSBoGZrVM71r1RNr1sMbRQMncBAbKPhrYo2E0ruTO9nDhWZ
 oYXrA1k1UUgU7hq6Rq2CBq6aHt+nutmi1kURnTMtTiG8544iY7KaA==
X-Received: by 2002:a05:6000:4904:b0:47f:93b4:2def with SMTP id
 ffacd0b85a97d-481456680dbmr883503f8f.28.1786355543374; 
 Mon, 10 Aug 2026 02:52:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32?
 ([2a01:e0a:106d:1080:eb7f:37e4:e8c9:f32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8b09sm36993326f8f.23.2026.08.10.02.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 02:52:22 -0700 (PDT)
Message-ID: <66864dd5-0ab4-48d9-9404-70f839db320a@linaro.org>
Date: Mon, 10 Aug 2026 11:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] drm/panel: lg-sw43408: do not assert reset across
 unprepare
To: david@ixit.cz, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz>
 <20260809-fix-blueline-panel-v1-1-e7f3a6beb1fa@ixit.cz>
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
In-Reply-To: <20260809-fix-blueline-panel-v1-1-e7f3a6beb1fa@ixit.cz>
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

On 8/9/26 02:04, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Asserting the reset GPIO in unprepare() and leaving it asserted puts
> the DDIC into a state it never recovers from: after the following
> prepare() the panel answers all DCS commands, reports display-on with
> clean self-diagnostics, and its configuration registers read back
> identical to a working panel, but it never lights up again.
> 
> On the Pixel 3, vddi is shared with the touchscreen controller and
> remains powered while the panel is off, so with this driver the DDIC
> sits in reset with its logic rail up for the whole blank period - a
> state the vendor stack never creates: the vendor firmware only toggles
> reset as part of a full power-on sequence, and the vendor OS never
> power-cycles the panel at all (LP mode is used instead).
> 
> Leave reset alone in unprepare(); prepare() performs the regular reset
> sequence anyway.
> 
> Without this, the Pixel 3 display never comes back after the first
> blank/unblank cycle.
> 
> Since there isn't any other panel or device using this DDIC, this
> approach seems resoanble to address the issue.
> 
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 293826c5006b9..0bf8e08f10b9c 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -50,18 +50,24 @@ static int sw43408_unprepare(struct drm_panel *panel)
>   	int ret;
>   
>   	mipi_dsi_dcs_set_display_off_multi(&ctx);
>   
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
>   
>   	mipi_dsi_msleep(&ctx, 100);
>   
> -	gpiod_set_value(sw43408->reset_gpio, 1);
> -
> +	/*
> +	 * Keep reset deasserted: vddi may stay powered (it is shared with
> +	 * the touchscreen on Pixel 3) and holding the DDIC in reset while
> +	 * its logic rail is up puts it into a state that no init sequence
> +	 * recovers from - the panel keeps answering DCS commands and
> +	 * reports display-on, but never lights up again. The vendor stack
> +	 * only ever toggles reset as part of a powered-up init sequence.
> +	 */
>   	ret = regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), sw43408->supplies);

Asserting the reset then shutting down half the rails up may force the DDIC to enter
a special low power mode with a bad sequence and then would not come out.

But anyway reset has a sense only if all rails are up and we want to get a proper
initial state, if somehow we want to handle those special low power mode to speed
up suspend and resume we will need to understand how to get in and get out.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

>   
>   	return ret ? : ctx.accum_err;
>   }
>   
>   static int sw43408_program(struct drm_panel *panel)
>   {
>   	struct sw43408_panel *sw43408 = to_panel_info(panel);
> 


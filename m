Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71104C9831E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0C610F573;
	Thu, 24 Sep 2026 13:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rOjrpW5e";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D286C10F581
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:27:25 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so7275775e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256444; x=1790861244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jfb2GnzFdumBY8sSVQT0iDXZ6nvLBLs0k9mm9TK0BfE=;
 b=rOjrpW5emkUNNUb1EOc/1ya6UW4evtpT41JCKEDSjAlsLM5WmIe26kSo6seUjyOuGB
 d8X+VbinuN7oz4A7tEsLSdwKqrhty5GvJqGrmpJxY7h/tEwsyIqwXJMyuYb0GbvdEE67
 UGX8ncM2r1vsotXTqZu4uGg79iAPUH82jlyA+6IYh53aDamHtxJ69tguJthQsJwDGH1E
 KJrKJWOJBQ7ImjkWUmJRkLjGTyuYbOu53Wuwd1CS2vwHfrqcoOVDoPaH+b9a9pZi6Zaz
 D4pVFy/ca/XIw8b/ALxxMAGRg/OpkM4OOLfkI8qszz6/JgBYtnJQ5Htkuke2BuYDgkbn
 rOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256444; x=1790861244;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jfb2GnzFdumBY8sSVQT0iDXZ6nvLBLs0k9mm9TK0BfE=;
 b=EmNtaKbnC7BzSUEsk/7B8Knc7RQJx4YLBjT+4/776yywLBSWx/+c8EDAv0Ty/dixpB
 c26h279DpxdDmGut7DViqjK8rD1vKellUgD0MOvvuXDxG0wbOCRUj/K2Reu62E3APtI2
 8nm+dQB5OlEoV7ptL5wjYtLZPonej5oqpq48orbGpaVx2j5rCNsKlPgZY9pzCWi8UgB4
 VdZ9qdAjzxBmheRgd8LL96I46X0fwj7+hmCRTzILBKEtreAmuMv+E7zedW2ZASq+x0i9
 rgSemu7cn2FW9scL5RWbi9KBqgsuFs2wfHmnl2AytsXBfJ/TTo4U+gy8ZtBderRFxLE/
 Hiow==
X-Gm-Message-State: AFuF++k/p5KiKt6LqkLFIo1pEgEwU4dv+TY2JAkvz212p2m+NtJ3GLFw
 O7fg2XYrpIlU1x1H50Daee7hxFxVw0/96q5lPkw6KrPkWC4xn5ekMHg0c0+VcoW2MJdt0wuXLVQ
 rN+PZq2M=
X-Gm-Gg: AYBFou00qnrV2a/FrzLdgJaqwx9Hj+vH1fTVvSARbelMLA28EJOj0kcOoj+RW22rkOE
 SWIokTBBTTpp2hztdVdi2SdLgZjeF8vlmFSJyQCvvrZBnYOiCb/MlSLRfz2mMWCcg3xjWyzFjKh
 w/WSQT/MycgM05LtIL4FObybJ7CKuv5HKkf1I+8GMRUuo4dm676oPFlWDZZ+pxK55Ccry9izygp
 vzVTPanocDy4aDhCcyzcWnKI3TohjRt0AI7h9Rc8RsE3rlndRrMXoQ/JIOD4XbaWz+XQRRVbYuz
 iGlTqOfSBY5a/G+vKdcL7zEhoGgyQybwIkOAXSktVOf7PTf2m48erxBat1k6zkNQDI990q2lCPe
 zeiUWDsiZ7oHXoxxrA/NR6snFewFpbwRZJGXceFP7A9O5YORoyY+NH5akA0+4d4Kuy+hNHicgQp
 rHPmJAk6UvsiKWb6AiCCQ9KwRR0lQ/uH8otnJ6i6JTwvxX3FOzt2sjBOpuMbCt9TEy/hcRo4OoV
 El7v9GIpaAIG7hMYHpPBek1D2zk7clC/rbmcRncV9KpOJgzK5LkPg==
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id
 5b1f17b1804b1-49fe66ca6f5mr46789385e9.0.1790256444044; 
 Thu, 24 Sep 2026 06:27:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd134sm68870805e9.9.2026.09.24.06.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:27:23 -0700 (PDT)
Message-ID: <bfbe08b3-2de1-47c3-8436-a4f4013ba844@linaro.org>
Date: Thu, 24 Sep 2026 15:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/11] drm/panel: s6e3ha8: Assert reset GPIO in unprepare
To: david@ixit.cz, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
 <20260920-crosshatch-panel-v1-7-de6e9512da96@ixit.cz>
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
In-Reply-To: <20260920-crosshatch-panel-v1-7-de6e9512da96@ixit.cz>
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

On 9/20/26 13:05, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> For correct shutdown, the reset should be asserted.
> 
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> index 99290913de69a..2591b8c1a7753 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> @@ -58,16 +58,17 @@ static int s6e3ha8_get_modes(struct drm_panel *panel,
>   
>   	return drm_connector_helper_get_modes_fixed(connector, priv->desc->mode);
>   }
>   
>   static int s6e3ha8_unprepare(struct drm_panel *panel)
>   {
>   	struct s6e3ha8 *priv = to_s6e3ha8(panel);
>   
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
>   	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
>   }
>   
>   static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
>   {
>   	gpiod_set_value_cansleep(priv->reset_gpio, 0);
>   	usleep_range(5000, 6000);
>   	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

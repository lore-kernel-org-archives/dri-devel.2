Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56777C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DF910F543;
	Thu, 24 Sep 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KtIli44P";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D6110F543
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:25:05 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso11656265e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790256304; x=1790861104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yYQCACi0L+UzO/UuTx/CBlh8yUR2BDqMNext39iQHo4=;
 b=KtIli44PLEAmGAJwiUJXhLdU4u1aTxnpEKAf0obZv9BKwBS9pBONBAWOh4+Gir+3JS
 uoWkUIUrrZw/O9gGPmcqckFUlMt7zQHd/xPxFBpDAurF3zF6Avt0qqENT1SQ7WZlPDAj
 vRBhLBUEl9VIVA6Nyg37DFsga4oFQkaZny1nmFiHHhzGVGdWVrNKHAFCeRCc3BotIBdf
 Ts2Sk4MYFF3TaDe/G/frNRMN4CF5YryO/7m6MSr7KT7Nf4Zfw0X9NMfRWXnRPq04g7CE
 NsjPQyp9ebwu0Lq2Eu1KE5o2FDWYuUUXQkiqYMB8VhRpJIAWkvE+Tbbg/M4RYC4u5Fzi
 HMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256304; x=1790861104;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yYQCACi0L+UzO/UuTx/CBlh8yUR2BDqMNext39iQHo4=;
 b=G6kPgQ0MidfzknmSgcv2zvDhoJIBAplq/XXqBR0IKy764L37rvhzANWKNGJFzJVwNq
 f2Ct48Hws5VZDzZ4gh90GmjKZPBayr1DAI0LPfu/fYVr9xbPRrkyL1T5wOOEQaNeZRQO
 kYN8nJ7VWcovO1HI8HieX7U8PRUeyQ33vRl1ts/0J6oC9vL92aWzPyxCkWqrKL//yB+6
 BI94xUAfROH8n/tkU9SzzXZKUYsP1uvNEXJi/B2LGwhUQ9onL23z9UPQ9n5kMQMxU1E3
 P4zePwaA7QUk5YiqFznVHmS8YA9g/DogBgj+Rc1vpk+FWPcXbsROA4sMEHym9mUAy7Mg
 Ed8g==
X-Gm-Message-State: AFuF++mnL70XPVk6mUIBLZv6vpGGdrd/l9vZct/DFEVZF2K2ue9TIhvt
 NV9k8/yYT8MmcZnUYZBtazh0nbiizA/dgptaHB861pkXESek/grZJS8+EWAqkFyjeAM=
X-Gm-Gg: AYBFou329PLc2eFTLL3/LWhzczHzr56qonJHi8riiWAi8Fu3d2hY99Vr18HXTtdWWUK
 D6HJoIcmjoJGd36ha2IoBed+1PgDeEN9La5Th7JskI/smavRGBPzMFh1EhmkLgAsBA4HfCv8Aw8
 dr8ziTSb9lxYNHuaw0fkuAfSo8Adbou004y5CIkqW8ibCOh7S0RsPdZs9ot9ct6avnjZsm1mpQA
 Jy31feFNBE+CAI4KorKwDvvvu39ljmp+PMHN4KznEwn1M6mKl64Kf+4tanSMAcPyKQ2NcMSynop
 epNWXycvEgaksr8TnyJ77Y0ekd4xaq6xf51rnphtQ7UcIZ6awSphJMMdEmD8fiqkuU6PghdJdzX
 E7Ijv0dKHhPKIwkVNKFJqQ6Bpm354igDik3MLra+9tbA2ETUoTUEqSX3Fwm1Y6ZFpsc1M3hpV+v
 F6maYVwtAYymA1Is1rfmn0w0TkKFu/llDoyvL3/kJVpAz3nX2cLBriwXR7PNvEfjWeslEe+K1ZW
 B/Ur87zY4EGytidt0nGKtaCYrlaOulTg3KEPFwBnMFnyrDC+JGWtuuV
X-Received: by 2002:a05:600c:630a:b0:49e:719e:e215 with SMTP id
 5b1f17b1804b1-49fe66fa3d9mr40160945e9.26.1790256304008; 
 Thu, 24 Sep 2026 06:25:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a?
 ([2a01:e0a:106d:1080:336e:a1a0:8f96:9f7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5de4de4sm74069035e9.8.2026.09.24.06.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:25:03 -0700 (PDT)
Message-ID: <339d4a24-29b6-49c1-ba3a-85fc62f093d2@linaro.org>
Date: Thu, 24 Sep 2026 15:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/11] drm/panel: s6e3ha8: Introduce AMB577PX01 panel
 compatible
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
 <20260920-crosshatch-panel-v1-4-de6e9512da96@ixit.cz>
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
In-Reply-To: <20260920-crosshatch-panel-v1-4-de6e9512da96@ixit.cz>
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
> S6E3HA8 is the DDIC, while the panel used on the Samsung Galaxy S9 is
> the Samsung AMB577PX01. Match on the new panel compatible, and keep
> the deprecated DDIC-only one working for existing devicetrees.
> 
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> index 835121b322f4a..a0015ac0e2782 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> @@ -296,17 +296,18 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
>   		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>   		return ret;
>   	}
>   
>   	return 0;
>   }
>   
>   static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
> -	{ .compatible = "samsung,s6e3ha8" },
> +	{ .compatible = "samsung,s6e3ha8" }, /* deprecated */
> +	{ .compatible = "samsung,s6e3ha8-amb577px01" },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
>   
>   static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
>   	.probe = s6e3ha8_amb577px01_wqhd_probe,
>   	.driver = {
>   		.name = "panel-s6e3ha8",
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

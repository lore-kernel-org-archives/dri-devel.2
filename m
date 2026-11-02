Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED0606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lpAftXIm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E096810EE5E;
	Mon,  2 Nov 2026 13:23:00 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2DE310EE57
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:22:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1741932f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625773; x=1794230573; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tOUwoJJ2xHQgVFDnHDlORcv3rq2tKQISQ2U/UtTWQ6E=;
 b=lpAftXIm3mEsH2FWkJkn9o/A5A9VT0sH+5nbVbs27HdAHifzdgvA/+gaocWurOF6Kc
 +aP+XTOyCECLzhToY3srsu6f8x92Whg4N+6t3xPNkRYAH/Kqocfdlm2PFofG87kdM5Po
 lRnpDF1hX+10sDRm15/08gBGaeCSH4Lmfe8t4FbQVpG53Lm8Vr71mYhlugAo+Bc5s1ss
 WN0ACiBEbL518TRbTV93sQ9lcm3l96+2IgD8KlnmCH/4kGgtvzezWwKB/RSA/I6iSpUP
 xyGXcZawoS/DntrAx9IhF3EUkx/7mTsiWdgkEo2GJqapZTEqi/2EK54SLWfmLn81U1dr
 daGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625773; x=1794230573;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tOUwoJJ2xHQgVFDnHDlORcv3rq2tKQISQ2U/UtTWQ6E=;
 b=CaSli4GRiLBikWkqn05cGikGB55SbKZXIkih2lp6CnG9Veap88P8LaFO03Jl1gwV//
 TMI6tiCuoQQ3eqUZ6ZUdMM8BGFooBHaRXGcLQDGWYPaZj3ZI5ki//GCMpmK2XF9W0n22
 wYNliNbMLrchNa3Vnp6cl+0KzAhCdpVGs4ExEi1mhNsVa82YLTnLXx3jniG57eniDdyg
 MMJzrudRuNGnheTzeInLTlgwW4FGm6vXbTxibdXYDVyExJMbTG/+wob2HKW32qlT6zLo
 sbv7YHp+VtkJN2/1rXks4ERFaR7g8ifFLicdRyLONZpSziVIry9f5ReUVtnEUqN/YuQF
 UABQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHY1Ol+ydneO235y5VNUYwz/MvDsnrV41dpitxj8SvoiXnz0P7zUF+meCM+PWvkQ/LzSTtWe4GqjI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tFfV86Q84cnkxvheAtvmXf0SbBb/qVmO1KccIdw/4+ykaRF6q
 Uq6h/hl8Tsw8oYf6PmbmhGthKilt0VDbVYXyaYgteTTJkyeh7e+P7SG9wojcRKjEIr8=
X-Gm-Gg: AYBFou1YhBmHC0J82UhbUiqrrG+K+62b1BjWCNBpUkINWykOv83BYe3uLXgBgd0Uxyn
 wuTvRwyYEC9Cr9jSDxvNUuAoDGVokFxhHdOT1O8vUsndIWTzfKbxY3lTmfVd6OlqGSGVp6w/Ood
 IkAS99+OTR4T2Ht0JG6EgRgMuybc1mab05+69gN51IeQ5OQ32EJUq1k52GBNxqprv4SAQ1bjDJu
 JZs/rAkRlrFTvw1k6yo2/CF7bXq/eltkrfC0zJQsZ/313cFB8YNXdde7YZc/0P1BB2cEf/bFxNb
 xvRNInFgnc3OEMpnV6ohQjiKsq6rLDsqchwXw9vWvxDwgWdaLFAMwJuEuSN1X1OtTWG1ATKCEFd
 wMOhLgt+71Ig40IqtLSat+Zj/MZAa/wMufdRfbiuTP4bP3RtXuW5x4H3xN9NdWNHrpBIl1YuylP
 +lpOLl6i5lurI428Qt5Wdz0HBbYV+opFIFoGc9NAVCXjp7eVt5fBDhcKb+dLueU3jEg3fALHO2z
 NY7Q04sJ5+Gkj2720A0e1b5UmPoWFaU63s+OUhVkOz62JiZRXgHn/e6RxBlguH2QBW+49NiLFeh
 mWrK+2FMU+8LUqeinMs2DKmPnF6BbhIUq2pxaTiXee4yqlB3SYXX+wfAn/lVFmwp/Gh6M15Xm+A
 gud11uy53ZeMjnA+XmTJOGtP4Tww=
X-Received: by 2002:a5d:6f0b:0:b0:48e:f14:61bd with SMTP id
 ffacd0b85a97d-48e6e2f6772mr23661360f8f.14.1793625772934; 
 Mon, 02 Nov 2026 05:22:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728ddsm19859094f8f.9.2026.11.02.05.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:22:52 -0800 (PST)
Message-ID: <07adb06a-5760-40fd-9c67-b562bbd72ad6@linaro.org>
Date: Mon, 2 Nov 2026 14:22:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 4/9] drm/panel: novatek-nt36672a: Set driver name to
 novatek for consistency
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 phone-devel@vger.kernel.org
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
 <20261011-nt36672a-panels-v3-4-9ea238627f8a@minlexx.ru>
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
In-Reply-To: <20261011-nt36672a-panels-v3-4-9ea238627f8a@minlexx.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/26 13:54, Alexey Minnekhanov wrote:
> Since this driver should represent not only devices manufactured by
> Tianma Micro-electronics, but also from other companies, it makes more
> sense to name it according to what driver file name already is: novatek.
> 
> This does not change neither module file name nor Kconfig symbol, only
> driver identification in dmesg. This makes it possible to e.g. grep
> dmesg for "novatek" and get messages from both nt36672a-based panel and
> Novatek touchscreen.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index 464d9ce47d87d..73bec4f47ec60 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -479,16 +479,16 @@ static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
>   	drm_panel_remove(&pinfo->base);
>   }
>   
> -static const struct of_device_id tianma_fhd_video_of_match[] = {
> +static const struct of_device_id panel_nt36672a_match[] = {
>   	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
>   	{ },
>   };
> -MODULE_DEVICE_TABLE(of, tianma_fhd_video_of_match);
> +MODULE_DEVICE_TABLE(of, panel_nt36672a_match);
>   
>   static struct mipi_dsi_driver nt36672a_panel_driver = {
>   	.driver = {
> -		.name = "panel-tianma-nt36672a",
> -		.of_match_table = tianma_fhd_video_of_match,
> +		.name = "panel-novatek-nt36672a",
> +		.of_match_table = panel_nt36672a_match,
>   	},
>   	.probe = nt36672a_panel_probe,
>   	.remove = nt36672a_panel_remove,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

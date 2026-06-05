Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A75CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E491111A849;
	Fri,  5 Jun 2026 13:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zr3RcVQX";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDF011A849
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 13:09:20 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso1142024f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780664959; x=1781269759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RWwic0XMe+s8tgCpCjfW/lHyoR3ERWBmi/iK7F/Oi/w=;
 b=Zr3RcVQXO8Y4/lsNdVJH//3j1tBRHHJFz8iSP8MJFo7nRNDYDqvc7TnKHXb7mYCRrO
 Kc3iZIpvmc8z4WTO/fM1tUo3tfbwK7GHtQ+iBtmg0sSfSBHNYd3f1htpkOpIyjUa43gl
 4NNzC+cNLNlo6aR6qZMrq9uW5G4CLjARdmQCyT8IgFOZyHXLj7lCgpg7yIBO5t6zXRoX
 kyaX3UiTOgJUHRXakDhKMGokJMSjj3K2jJE9W/Egwaitwm8gSxIzV8koY1oKh3cZtaG+
 NlGu3QMkwyXhDXai2st6Le6CZ0thdpoUZot79dsGMELJIbhJ3yZhJ8oIP8kwSV2WBkIQ
 f9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780664959; x=1781269759;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWwic0XMe+s8tgCpCjfW/lHyoR3ERWBmi/iK7F/Oi/w=;
 b=q207lgqO9uRuhxY7Bww5E9a78GxR9XgZ8FiF8reCuGZEb0CWvPN9g8GZZ4D/rYqDDy
 heHTNdbr0pzr64wkqTh7W69YNobUow1WQgN2JPNx6ATuQ+W30qcFpVjjZGX6hVOrereK
 V1ZnVoUTNaioMnOKZP8SOX0KepYxydiheU20b2meY9tzye4z/bEaAN5EZLxzxN0dxarC
 6xSy7kUFx1ZQzCEV+VQPIlgOcup7M1qSD8sogs1A+cBHAZQJp2LWa9//shNpjyWYLJbR
 dH9H4qjJGa30sEjKiNIK5ELHStyIPnAHLzCaJdZHEEcHFLRU8iKt7jvx0JeL67W53+e8
 18eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wOsaA4tPRFsLb8ODmzHjt8RiJ52fF3dvnc3wDE7Ojdl8OndxySitX/xS5plOkzsqvi/w3FXpNBfc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEKCCGfmfG1WVsXOfwlP6prYXAl7OrgsHfD/NXLYM0KyDelMzj
 vXS0ssiBe2UvnsvaO+4HE/oFNgQhkvOjQw81YOblIaA6uP8radWgK9oDsqk8loficV0=
X-Gm-Gg: Acq92OH03CO8qqZ4d95p2/CsfKVopMGf0aqAtMUQveaMt/CXE/UIoQ/5HvzxFSw9Z3e
 Oe/zXC3iuckshrrhMmcc1XYe687t1hCpu2ZEtQ49CwZuh7IeXj4WvKoHYiUQpvF4/bNWjTiwnPY
 ux1E1sAISGuIqmjyz17r8ezDtI9iydlpfiW54K1m8csCh7D57QLW0mv0TUWFWJqIKaThxvdd3S4
 kKYetdXYV7xkf7zfGf64jxjWV9hnHIky4ywtfRdqZ62rmg0jTDUW17h2q47L0lnaEVFbPBEoUJT
 QPTvouOz1rGYERM3h6JctwMDWruM/+o+YS4xqiODHhLL+4lSoARtnxdAOuuKHaMEgzNgJ32Z5DC
 VJkQAviWRH8DeW8zKVtPl4m4fpC4joVEkQ9vIaMqdpYBoJysHeILKAD3SkgFBX2Qu4p1meWo9i+
 XnCZ+3mTx2bOPYAFpaLA4l6NEnE/p4VxdQwwwa8H2boklcxCdE4GT7t9WOgvnfMjx8OacnVMACj
 oiL1JPQpxFTyD+1dg==
X-Received: by 2002:a05:600c:190b:b0:490:be9e:fd03 with SMTP id
 5b1f17b1804b1-490c2589a02mr53379745e9.7.1780664959143; 
 Fri, 05 Jun 2026 06:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm25764494f8f.16.2026.06.05.06.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 06:09:18 -0700 (PDT)
Message-ID: <06489359-1b96-43ad-a065-bfb9bee51a10@linaro.org>
Date: Fri, 5 Jun 2026 15:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Fix stale rpmh votes after suspend
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
Content-Language: en-US, fr
In-Reply-To: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
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

On 6/4/26 22:08, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> There are stale RPMH votes (BCM votes) observed after GMU suspend. This
> is because the rpmh stop sequences are skipped during gmu suspend. Fix
> this and also move GMU to reset state to avoid any further activity.
> 
> Fixes: f248d5d5159a ("drm/msm/a6xx: Fix PDC sleep sequence")
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 2e5d7b53a0c3..a2f6918c4f7f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -642,7 +642,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>   	int ret;
>   	u32 val;
>   
> -	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
> +	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
>   		return;
>   
>   	if (adreno_is_a840(adreno_gpu))
> @@ -1465,6 +1465,9 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
>   	/* Stop the interrupts and mask the hardware */
>   	a6xx_gmu_irq_disable(gmu);
>   
> +	/* Halt the gmu cm3 core */
> +	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);
> +
>   	/* Tell RPMh to power off the GPU */
>   	a6xx_rpmh_stop(gmu);
>   
> 

Thanks !

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK


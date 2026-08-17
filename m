Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EE2C5DF7E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBCD10E884;
	Mon, 17 Aug 2026 15:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CSkDZ8/f";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1500210E884
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:41:18 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so666879166b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786981276; x=1787586076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VoBtZfhuywbVuLLdP5All4NoUQGWiUJ7pstL6sIhZxI=;
 b=CSkDZ8/fDeql3eyrjPXiEqYG1GmIqVk35CZyGxiQp2wHghJA0b0J9/AGQXUiMKvjyI
 BF3MOjexG8YoOA9Srxl7UOBpJoffV2RQpLWWrH+lDrMVMVc/slIfXL0kX2qk+v0e/P8p
 NFoQ0DljLK9rn8s4IRru2TaZzet9Fh/DhOePZVcoQEsWnBzmTO0rBxsVIAGM7FsMkmtV
 gNcfieR3R1Kuj49ZSP+8xZJMuvdofprvSf02yNSb7p8c3H/k+L4Li0fAJAJZjGaJcbN5
 kw1XJThutedBsNISBmZRRH+Y0uR5WRPHH3sFAL8woyt1vKoslgmGv9V1UWQVZuCQ+6tD
 WONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981276; x=1787586076;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VoBtZfhuywbVuLLdP5All4NoUQGWiUJ7pstL6sIhZxI=;
 b=cQgbWU+2ffy6YkSN9MN3zLLkuqWXJOvKLDwEkZJHEMyUk35tD264ueXUhcQRNdYQe2
 KzIWQGCdFD17z+Duqrc9En+gzgU9y9l0eM1jCd9XWO/fvmda9sgO/9Aa9x3EJEZ/149R
 40qE7nTC/BTDdC6aGbepB6kpv3IxDhe7k5x2lDHlvWolsc2FiHF1X/40q+B7pEqK5u6o
 5JT49tMM81Bc6XIBtLeJKGge7JJwyaTwREOWaibgBua1OfnOSVmN1ye0KdfXbl3eUTdm
 nruTMR5E7K2xwXhBW+zl3CCueuzs+239+EU/M9CWlct62+a9FhG5mU+8A0GWsWg9VskZ
 7fLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqVOfyKtRmuDfy8hYvetXQwPd8XBK3NTu22Jx+QoxLPUkidCzfTqNMa51AY0/Y4AH9X8b6cmtNl4U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNcliGGRKxDy3TOW3wJBjaOVYPicvB4BDagLQuZFvgPk4RGOub
 PmCCgNxy3wOt1atC2Ru8gcxLfLM3bXHkipPEU3hDAJ2i3ufrFWMPc+6M
X-Gm-Gg: AR+sD1170BA50+nwWdeNCJh0TaL5meMeA7fr0RelObwWwY01QPZgUzJjLVpC9N10uu/
 GFL77XUSU5q7zYG3Mr3bnAoJcn/+Ki435B0FeEKzxtqphlJ2FsyG9hjCUj3vgjvOBO8AWv24MH3
 fSnfKr+rzBc4KYR7m6oKE3aGYSf6e6SJjD4WawTvZAgokxw6oOk474f8HzRk5CO/p/Nx4cpu7FT
 a49VPpYja1NNzVYQdq/TDPcRrV5jTT7ZbqPJVITqgpkYrW2h5rMRNoLCg7E6WgP1nG0LxQH2eD7
 bEVe55+a90FMgDKzevKkblk5t5Nl4SpMLGQsQxZt5q+cL/dkhm9+Tly8e82XFsvwii9YvXsmh9N
 hNfY2MUubFZiO4dPuUl6u9fFDbCIxOTUiXegUkF/mc6dpGOmOECVENaHNabxxeLzKZu1+RMS2c3
 9/A5s757cW1ZfmaJG19WRkZSPsKw9y9QI98JoxYaCFb7C89D58oWB+Y/n4hziuu9eGuUlsN7rj
X-Received: by 2002:a17:906:ee84:b0:c20:eeaa:ec85 with SMTP id
 a640c23a62f3a-c212a1857cfmr1355311566b.17.1786981275977; 
 Mon, 17 Aug 2026 08:41:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2185bc9697sm44467766b.61.2026.08.17.08.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 08:41:15 -0700 (PDT)
Message-ID: <b63e93e4-2f4c-4cad-b726-e1b0565379d7@gmail.com>
Date: Mon, 17 Aug 2026 17:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] qcom PAS TZ API migration breaks GPU and modem on
 TrustZone without PAS (sc7180 trogdor)
To: Paul Hollinsky <phollinsky@holtechnik.com>, sumit.garg@oss.qualcomm.com,
 andersson@kernel.org
Cc: mathieu.poirier@linaro.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, akhilpo@oss.qualcomm.com,
 konradybcio@kernel.org, mukesh.ojha@oss.qualcomm.com,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20260808034716.58888-1-phollinsky@holtechnik.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20260808034716.58888-1-phollinsky@holtechnik.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/8/26 5:47 AM, Paul Hollinsky wrote:
> Hi,
> 
> Two commits from the "firmware: qcom: Add OP-TEE PAS service support"
> series break the GPU and the modem on SC7180 Chromebooks (trogdor):
> 
>   f3b1357673dd ("remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs")
>   0be72be03ca7 ("drm/msm: Switch to generic PAS TZ APIs")
> 
> Both are in linux-next as of next-20260805 and neither is in a released
> kernel yet, so there is still time to fix this before v7.3.

First of all, thank you for the amazingly thorough write-up. I've been on
holiday so I couldn't look into it quicker.

[...]

> Suggested fix, drm/msm
> ======================
> 
> Given the above, I think the right fix is to move the availability check
> behind the DT discovery rather than restore the SCM check. Boards with no
> zap-shader node then never consult PAS at all, and boards that do have one
> keep the qcom_pas_is_available() gate the original patch was going for:
> 
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -52,6 +52,12 @@
>  		return -ENODEV;
>  	}
>  
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(dev, "PAS is not available\n");
> +		return -EPROBE_DEFER;
> +	}
> +
>  	ret = of_reserved_mem_region_to_resource(np, 0, &r);
>  	if (ret) {
>  		zap_available = false;
> @@ -170,18 +176,11 @@
>  int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> -	struct platform_device *pdev = gpu->pdev;
>  
>  	/* Short cut if we determine the zap shader isn't available/needed */
>  	if (!zap_available)
>  		return -ENODEV;
>  
> -	/* We need PAS to be able to load the firmware */
> -	if (!qcom_pas_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "PAS is not available\n");
> -		return -EPROBE_DEFER;
> -	}
> -
>  	return zap_shader_load_mdt(gpu, adreno_gpu->info->zapfw, pasid);
>  }

I believe this is the right fix

> I have this booting here: the GPU initialises and logs "Zap shader not
> enabled - using SECVID_TRUST_CNTL instead", as it did before the
> regression.
> 
> 
> Suggested fix, remoteproc
> =========================
> 
> Keep an SCM gate for need_mem_protection and add a separate PAS gate for
> need_pas_mem_setup. This is what I did to get it working:
> 
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -2079,7 +2079,16 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (desc->need_mem_protection && !qcom_pas_is_available())
> +	/*
> +	 * Memory protection is done through qcom_scm_assign_mem(), which needs
> +	 * SCM but not PAS. Only the memory setup path issues PAS calls, so
> +	 * requiring PAS for every need_mem_protection platform prevents the
> +	 * modem from probing at all on TZ firmware that offers no PAS.
> +	 */
> +	if (desc->need_mem_protection && !qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
> +	if (desc->need_pas_mem_setup && !qcom_pas_is_available())
>  		return -EPROBE_DEFER;

And likewise this looks like the correct fix too, feel free to submit
both as patches

[...]

> On the API contract
> ===================
> 
> For what it is worth, the kernel-doc for qcom_pas_is_available()
> (qcom_pas.c:256) reads:
> 
>   Note that it is mandatory for any PAS client to invoke this API.
>   If it returns true then only any other PAS API can be invoked.
> 
> That is a guard to call before invoking a PAS API, not a statement that a
> driver touching TZ at all should refuse to probe without PAS.
> ipa_main.c:764 consults it only on the loader path that genuinely needs
> PAS rather than as a blanket probe precondition, which is the shape both
> fixes above are aiming for.

This is a sloppiness that got through the transition patchset.. previously
as you mentioned, qcom_scm_is_available() was a blanket "can we talk to TZ
yet"?, and as the conversion happened, it was largely just find-and-replaced..

Konrad

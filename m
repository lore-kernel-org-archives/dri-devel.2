Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A29CC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1210E10E5AB;
	Wed,  8 Jul 2026 08:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="scAz6oOz";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4424A10F05D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 08:41:22 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69a50189d25so736377a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783500080; x=1784104880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3DZTTXE9BUksJ1j2NPuZCs/kRS4hcs1yGW38pGmaPVA=;
 b=scAz6oOzO1iCQNmfvqA/02qAzWlsaIO6ABK/pWAjVgHEsQAzSuZBprcdPpTOirzdCX
 ygpo6hgRxR6IK2BKOpQ+zop+OQViC2wtFBz/LW3eG2zK4c4NgoRmTW4V8//fii9KdnkV
 KvR+Mm7ipDnOQ2QK2QJuqN8SxLSKsBnDZkzvOH79ZJK6PbFt8qPpYfDNQQrwSnoDBTTF
 yDLVgsUIXt7eT+kfmccNeMkZvXevG55m0PSbmAQX/9gVyN1DpHt7LVjXr69VGbrovgKO
 YC3AHXdBXZJY7yATdLP9B/6hzFA9Ys+rccOCRFsujWNV7wJYybmzOPv8BOquqBiIvptw
 GLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783500080; x=1784104880;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3DZTTXE9BUksJ1j2NPuZCs/kRS4hcs1yGW38pGmaPVA=;
 b=gucIdKDFas0H1znqae+IXa4dlogtTVx+Ugo8VxB/FWGbBY/pNcGzqGM9RiiK+08FJC
 vHVrP6s5TrMB4xUVgoCoKo258UqTMGAwNIzGIxwyD0xgJRZKPOMZa8AfD8cHbxMQKRGw
 TiiWbPNrCgoZYREV5Nopc+Kkzjx8P0N+AfsIOf5Cl0TMCNC12DMCzWvABT60CA0VhaQo
 RXzyjgbXcghzJUtxJhQqJ4I8FMxCRyevBBrLlEwYtTuIkUf+kB3r3UyXCgDmODrZ0udI
 JsX6qNSm2WasTciG4yA3qK7kv3Tb4sbNlS6mQhLNsR0u6wv4va7B6tilj1tuiA0fNZrq
 D9Sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrF5Y13D3aY8Z0OsQ+rAxi4QUICMNCsxusr4ytZPhfDUgx2yp4SofXCJCyJWOKXpKUrJ6DhOxONaJo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfY7CuVSLbr3c46asuwCEaGuCKE9sTTL9zJa/wZDs1ToRrmNNZ
 sDT/F+MChfbwO/hBOqDuoPBLAb56b4J8tXPs1Xja9RVbTb4Use7v19/c/SbBaDZveRY=
X-Gm-Gg: AfdE7cnS9fI7kUNT7D+ByZpb/DqURdamyAtNaePG37y0nsPShu0wSgZpvvphiezUW0U
 ilGS8jipQ9kHPozY6PEnJ49wtZ5AsDyJQsov2Js1A1zltt6COjwN8XfR/56ovbGEsVuDbjWvhik
 P8J5DXP/ONMprUPFxhcgqNCjrwcfSuJMGumfGytgWS6GMEfSQn7QXpmdiEWDwozn7zHWAIDK4+4
 HKsIMoYIQ9cJaZwcfviBarz+ubPafndEaKGYclxrl+sYWR6tAFJuJu8FZtP5cDhZUsRFZ5ol644
 WwpdIJVIcAEGFgjjrN2z7ff+XazV1chqKy7SyJgoSxF4xxewWXJ2KRrYbhfkrckBg+py3FsYTjq
 UKmSkg4CvKZ9V5lzbqqb5A7EMk9EnrqpC/jgFW8BmcpkaaZQIkn7gmDsqich0sw/aQc8ROYiyrS
 wrZnw8EpidrW7l2oWj3JjvoTb21Y27+KjKeQ==
X-Received: by 2002:a05:6402:2755:b0:697:5140:a146 with SMTP id
 4fb4d7f45d1cf-69ab445334cmr563051a12.5.1783500080309; 
 Wed, 08 Jul 2026 01:41:20 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69ac41d7ceesm160654a12.23.2026.07.08.01.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 01:41:19 -0700 (PDT)
Message-ID: <6b551a44-96fe-4429-a337-9e6a32ac5156@ursulin.net>
Date: Wed, 8 Jul 2026 09:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: use correct selftest config symbol
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260705080225.436-1-pengpeng@iscas.ac.cn>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260705080225.436-1-pengpeng@iscas.ac.cn>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 05/07/2026 09:02, Pengpeng Hou wrote:
> intel_engine_user.c checks CONFIG_DRM_I915_SELFTESTS before running
> the engine UABI isolation check. Kconfig defines DRM_I915_SELFTEST,
> without the trailing "S", and the rest of i915 uses
> CONFIG_DRM_I915_SELFTEST.
> 
> Because CONFIG_DRM_I915_SELFTESTS is not backed by any Kconfig symbol,
> the IS_ENABLED() test is always false. Use the existing selftest symbol
> so the debug/selftest guarded path can be reached when selftests are
> enabled.
> 
> This is a source-level fix. It does not claim dynamic hardware
> reproduction; the evidence is the Kconfig definition and the inconsistent
> guard in intel_engine_user.c.
> 
> Fixes: 750e76b4f9f6 ("drm/i915/gt: Move the [class][inst] lookup for engines onto the GT")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/gpu/drm/i915/gt/intel_engine_user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> index be4bbff1a57c..d5190e11b270 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> @@ -259,7 +259,7 @@
>   		p = &prev->rb_right;
>   	}
>   
> -	if (IS_ENABLED(CONFIG_DRM_I915_SELFTESTS) &&
> +	if (IS_ENABLED(CONFIG_DRM_I915_SELFTEST) &&
>   	    IS_ENABLED(CONFIG_DRM_I915_DEBUG_GEM)) {
>   		struct intel_engine_cs *engine;
>   		unsigned int isolation;

Looks correct but we need to have a test run done to see that the checks 
this guards actually pass. Please stay tuned for results and please do 
ping us in a week or so if we forget.

Regards,

Tvrtko


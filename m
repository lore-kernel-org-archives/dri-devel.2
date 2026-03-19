Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9EA1091904
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9C210E490;
	Thu, 19 Mar 2026 19:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=marek.ca header.i=@marek.ca header.b="FgPsrYJS";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C9B10E18F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 19:03:04 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-89c4feaaeb4so12526426d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek.ca; s=google; t=1773946983; x=1774551783; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1HBWRD3UdfQ/mqZ4c9b3lsjSPXBlvDoL130uUTkvuA=;
 b=FgPsrYJSAJwSZMnykr8x8H+IXFKX54aFKXm4HwZaZmCUbH251w+DKbyrv9ezOlzffr
 sXRDSM91e5S8B9fe/kXklsn1xvYw3oXb5QZ9010dqIejBtjq5KGfyl2MggSI6MWQq7NS
 rfkVchlTe+n1+1Iox09RTUBaJs1ewOcctSrKIn3/hm89wmowj6umHmyUfTyVlzBKe8fZ
 +ieBGajprdTVrdDKN6P4IGDtsXtHGPGpcKbwXK7lIPiytkCSzyHs+TR7YVuMdEeUQVAC
 QxpQINqNGex6xgBJa31rEUN6rKZpp/fA92Jaa+xjt1llzp8n3q1tAmeyauS/yYacH9L+
 Ikvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946983; x=1774551783;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1HBWRD3UdfQ/mqZ4c9b3lsjSPXBlvDoL130uUTkvuA=;
 b=nhq7e4vNAZZDciaCJ6c0ornl/1vszg9zydp114+cnRE7M5kiU0DlGStgmFbgIFJv3F
 ZxGyzEVoQ0qxI7qFgVPvvjmLsOL1YHYv/vn8PohqAjyayHtJcd+RCmEAEasPCL0zWsBP
 Z+XFdj+9TSij/tlKiJKGYodF3iz5RUB2Wk4OryrFLq8JGKWIqNYjpF6l/F1bV5cE6pNf
 bLN0YfV14tN8D05o+CysSRQlLFEwXAEvngHSWaBqD2O24oeTdSc8+Cb0CTBiTEsvORUE
 twfzRCqdsrocaZXRKEb5ArWsfzzQgSd1l1O4HYZHFUvyKeHiINMNLE6zLE1dnf1mCqnp
 iRpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUyLmWZVVNFFD2oRR5hXPDURqliApvjtK5LoEvGA88FzwMUH1k7OxE6Oai17sbSZ+nJ6Ub/qjOpK4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywc2uosUvNlNRq51DVJMG40miYCCbBrGaAxOUh4pRn6qSIPs3ip
 xjm0XCrSaFoZOmAwhVSI+DqtFr17HbIWLFUzqsMSxE59fLiH/p0kI4bL0HtiCJzvW9U=
X-Gm-Gg: ATEYQzzK8o7VEUSUFKzpzIL9ySVEugJJcD3VfRwgKCgXuv12t9NPlaDxYjWBUNr1ZXD
 7/rkIWGlKuoPPWMiqnkf2xPx2kfTWg/+OjYIHZQwSzP5hm+YKmI/wx058nOvSk36slmYfI8cAvX
 bQ1wPjSLujOsRKXtQiqtlxYLO0XZTsqj6ZY2S8ugDsIiGHfFJaT3IkDq7t+JbJVJewyYH7UYNBF
 hjbXpg8satkB83hni2ngX5nVd7Hz9Y8WtccNehbsgzTbDOC/VsclJdlQgfgAHhxhH+z3TPKZC1p
 NVkaRp/puHURN8KeO/HNcdqKD42yqcrMpSSSSYb0pohLCQpk4KdQvgVVYZFtEmZLeOVmiJgf6ch
 VzKpyuqWWZTNGaFGgnRDhLourd+CzAxsMLYOsZ/d8pgaOMpFTXVLN3oZdrJZraKhlkCeDSk1vcT
 KUQS0wfxBzfih+pjhhmcOSWrj5K1lZU/oIPc1INn1YsXvxSSWFNYm6s4NQZiRl6kr3eorh8g==
X-Received: by 2002:a05:6214:411a:b0:89c:55c1:4234 with SMTP id
 6a1803df08f44-89c859cb38dmr3785616d6.2.1773946983319; 
 Thu, 19 Mar 2026 12:03:03 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca.
 [135.19.110.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85379401sm3035576d6.46.2026.03.19.12.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 12:03:02 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <EEQIOfQNcsc4wya1P0uxlYBG4w9lAeW4OcTZpsxmpGCzf-tgl_3YO0H5zoZyU5XIwBKurxuki_gGca-Z9YfcdYOXN_wpwixoK8q_fITL1bw=@pm.me>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <387eeb90-df96-9d32-14fb-8fa7fa2fcd45@marek.ca>
Date: Thu, 19 Mar 2026 15:02:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <EEQIOfQNcsc4wya1P0uxlYBG4w9lAeW4OcTZpsxmpGCzf-tgl_3YO0H5zoZyU5XIwBKurxuki_gGca-Z9YfcdYOXN_wpwixoK8q_fITL1bw=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

On 3/19/26 1:31 PM, Alexander Koskovich wrote:
> On Thursday, March 19th, 2026 at 1:23 PM, Jonathan Marek <jonathan@marek.ca> wrote:
> 
...>>
>> The hdisplay calculation in dsi_adjust_pclk_for_compression (which only
>> affects the clock rate) seems to be wrong, and I think Alexander's panel
>> must be running at a 20% lower clock because of it. dsi_timing_setup has
>> the right hdisplay adjustment.
> 
> Checked against downstream and the clocks seem to match more or less:
> 
> downstream:
> pclk: 110070156
> byte: 103190771
> 
> upstream:
> pclk: 110073457
> byte: 103193865
> 
I was curious about this and looked into it a bit (without testing any HW):

- using MIPI_DSI_FMT_RGB101010 dsi_byte_clk_get_rate cancels the effect 
of adjusting with bits_per_component for the byte clk, so the byte clock 
ends up being right
- using DST_FORMAT_RGB101010 DSI pclk is in 30-bit units instead of 
24-bit units, so the pclk ends up being right too (but that only works 
if widebus is enabled)

a recent commit (ac47870fd795) changed the hdisplay calculation in 
dsi_timing_setup to match that in dsi_adjust_pclk_for_compression, but 
only when widebus is enabled.

So things work out if widebus is enabled and MIPI_DSI_FMT_RGB101010 is 
used (note: looks like the only upstream 10-bit panel uses 
MIPI_DSI_FMT_RGB888), otherwise its broken.

AFAICT if you revert ac47870fd795, use MIPI_DSI_FMT_RGB888, and change 
dsi_adjust_pclk_for_compression to divide by 24 instead of 30, then it 
should also work (and won't be dependent on widebus).



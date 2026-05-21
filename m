Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF103CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 18:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBC010E1B1;
	Thu, 21 May 2026 18:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTXUp/ki";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D8410E1B1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 18:09:48 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45297094718so5154634f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386987; x=1779991787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SwRKMllRpAzGBdyZ/lJigiiPKVoHGY8aJQFT7Qv+hEs=;
 b=eTXUp/kijuo5jwwxmftqBouUYT17hJ4sRHPicBoSoQnogpIG6usLjZr5LOP0oeggJc
 Y4HdAJGbyX8VZXjP8ImDs7Z2sND9cMRK8hRRq4BVRtwh8YRFT5mfHsHDTVKqG8krtFjV
 1WXUL/DR7YAdRZSnhHJ4gOYvIJQiuQex5qhs72HiiuYm/t4bXBKUfRQpwiWWs/PMVcQg
 csDwBXm96Puhpl2G4oc75Wn5ysp73njpqyWCg68ugVomRnhBPvMFbzWb1ULPsIIICxYp
 RHyNyCf7TIh/ZmkAUDRGiMsCGGN3VaisF8Xf9fu9eiccmW+VEH2U9hJpka+hMj1k2lOt
 G5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386987; x=1779991787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SwRKMllRpAzGBdyZ/lJigiiPKVoHGY8aJQFT7Qv+hEs=;
 b=cJteP3zfVJzWNBeux0D6nHD5N558FV5HVwVZXWLm8HQthv/LSN+uG9sKV4pdKjmfA+
 8xkKyZHKi0VVHMBTqDOiGNSoezMcSVUyKdqvW2nt4/QVEiocNR3qziRwm4rWQA6FJ9Yt
 pX+DY68xGd8KnWLpneZp6ggLuyTLTaALdl7YTlE2wXIw2iVUID8LKbIDXzU23zBZMO1T
 qs+Y4+pWX4zTcbw4p5IuY0hwQa3+QsmlxBN6Wxc54ctyTPpmqFhdShKFiFsiCWZ//9ti
 6OK67iDi2QppFGHvEUKhu4TF+a7ZteGnJF8gMRCgxFFCBKYydgKSld83BeQr+0FJuTv+
 tUxQ==
X-Gm-Message-State: AOJu0YzvULk8OxlPLrV84LDE+YDX3FyJYh71b0srqPsjtrY8TiOtjB5V
 veL2UJgLoJ1xZuJP7eSGfrNCJAXMhAO7ZSIpxi9q7yVX4tvQCxl5Si4=
X-Gm-Gg: Acq92OFHRHG6dGRAAf12k56/var1cA2+JzK99dGaRSr5m5D9+0DoDOm7m3bmGZgxRao
 1F6UZubR7vbDAF9YtMIiQYk5yUXE5Q2sORGRO8m7LWhRcBiIzz4UzVGPU8aBW4/mOvT6pLMCOUi
 jom0/5AE3Xa3AvGMIxd0TfSokgqdZkY1LtF8E61/5HMcMT2lpVqNAUo+Re/Gv/tNzw2fSMOoVY8
 hVbbejrOBg6A+Sq611QKBJaScoMwYwTxTAIvh6g2KKIfWewi0LqVUB3bUmUqMYSZS2mhBH56T0H
 C1zFUQPfWy4V9JBes3Ts8YEXMc53w19ZNuQnmL3/w/TdNBcoO7tjvZT49lkBVTFMGnbM4fiWzoL
 nsA7oRQ1Sf3jUBNHH2FpsWKtOmGRsmT8qe3PxB6oZx8pile9jSHRDmjnIrNcqYT4kwUd3zJZ5P5
 J9y3Y0wZnfxNpiPa4oGWlErJ7G0ilxWnCc3SAoqWEPCU1UWglRl5cNxgo/fTR8GImQP3PcKvw1m
 LLGMP4oCnSTcI2C7dz6YVMzgXcbcKFiYb/QTQotvyyx3TAFwBtT3noTK9McgSu+/2JLOQ==
X-Received: by 2002:a05:6000:40d9:b0:446:ef9a:8f41 with SMTP id
 ffacd0b85a97d-45ea3cea561mr6344829f8f.40.1779386987437; 
 Thu, 21 May 2026 11:09:47 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:52d:7400:bbd7:ca83:de4a:f625?
 (2a01cb08052d7400bbd7ca83de4af625.ipv6.abo.wanadoo.fr.
 [2a01:cb08:52d:7400:bbd7:ca83:de4a:f625])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa935898sm4632173f8f.28.2026.05.21.11.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 11:09:47 -0700 (PDT)
Message-ID: <ed3397c7-bd78-4236-96de-82dd75a96ae5@gmail.com>
Date: Thu, 21 May 2026 20:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] arm64: dts: qcom: sc8280xp-arcata: Enable the eDP
 display
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-3-9df52552bf87@gmail.com>
 <cd5a8576-2f06-4620-bbf3-43b3f84de630@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <cd5a8576-2f06-4620-bbf3-43b3f84de630@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 5/21/26 10:50, Konrad Dybcio wrote:
> On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>
>> Add the vreg_edp_3p3, edp_reg_en and mdss0_dp3 nodes to enable the
>> Surface Pro 9 5G eDP-based LCD display (LG LP129WT232166).
>>
>> The enable GPIO 36 was found by decompiling AeoB dumps [1]:
> 
> I'd like you to strip this from the commit message, as it
> doesn't add much value and makes the git log unreasonably long

I thought it could be useful for other people doing device bring-up
in the future. No problem to strip this in v2, the info is in the
mailing list from now on anyway.

> otherwise this lgtm
Thank you,
Jérôme


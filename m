Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA4CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 18:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABC010F3D1;
	Thu, 21 May 2026 18:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nhk4szcQ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2083010F3D1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 18:04:46 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4903974854dso9498965e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386685; x=1779991485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0YT7TiQIY/LxcCw1ik30ZVCCkxlu7cirUrNio/yKO3s=;
 b=Nhk4szcQxU5pT60tkPIZBd60eByHWRdbhTUjXpu4l58ZAL8OxCJ5tx29KjHCfZHt+A
 WDacqupg418zHi4EAd8wEyB1fnooV4vbs8ULp6YL0FLM01BABqRQ4SvxGLBU/qCPsg97
 dfBEcOon6dMh1WDmtgDdhJZND4r/rxNCqBm66ysZi677WPVxyHDUMSKSAOUUMDgNrAiI
 ytZxJ5QriKjGoU9Vofyh43Qk+i9n7SDizMkANp70lhhzp+64gy6lyfzwAy7zeIlNKxva
 Zhkrpmj0OMr9LTf0a19ZUyQ3FSTTlbUBkqaS3bw/07YKTKNPzfKia5F46M63ndS2WAnT
 Si7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386685; x=1779991485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YT7TiQIY/LxcCw1ik30ZVCCkxlu7cirUrNio/yKO3s=;
 b=NHHxUqRIqg47zbPa7tv9PJEPWzyo7kw6Z17w3SA5QJZ3WxDflbyPV9yXldQoHTB+af
 cFfhjKb8dB4/nJT4cEtOSeN/E0/Apo72iWrvKaDV8QtkHeW1B0lXn/kgqMeG3Xb4FI99
 oqCc/UMLebwZgHpapVbNK7ok3p5l7DKgwd4eenitJWg8U9xEQPkl//BkJgFubTQCxEbx
 e59isG5nzZm+eaVRdBLRBZGBEWffhl63KmeILXuQQlHyW9qyIMIraaX2XPbnTYjeR7/F
 pAjilwgnMiPPmEPW4MXprQEV7/Ayk837NNf61PSytX7klZ9aEGMoG/XRucFvaLyuWZC9
 Ylgw==
X-Gm-Message-State: AOJu0YzL9Sng+vKYXgcaryTMZ7IuHXKUsByXwx9JXFWfC6iiudTX3Gbb
 5/HUeTs4TSHmMoglyRrrgJ8KhlyeVfV09of0GfCRcIs6bE3AAM+EDMw=
X-Gm-Gg: Acq92OEzjDocOP72uQfz7WFFHEE5vGstOPYR6ynnrDtdaOWG9E1xlCERMRqLdcwNDDn
 2NEJlwe2GhcJDy6eSP7SEq7FSmR3UhB2bC73Rk6tuG1tlZDH++VRtCn6ZZGlBrfHKBFVZVXZBBS
 N1pAb68D5vs1EDakfJ0XDsH5nZR/dUu9einAktNTi2nzYMw5b67om3aI10TVvVhJILVAofDb/2N
 QnBa7Bbf9kMTvz4pvXn5P6fL3iSVie16JkbbZmCkaD+Y23K0ovsgLAEOf7Lkjld37ixCDd9242b
 VKtpBtQMi23EZbPr+Cl+Bx8DsDP5kOztS7HAwRHZuCFndK2zztwJ7ANb8DOjpWt/kCrJYgjHHjJ
 CngRvy5aY7H68PyXmV1IArHIY33GgmGpzwLLHSBbJ/hzaR7i5YOKQV1wgMYXJgu7Nq8yZIJjhM+
 eK3TxY4PfwyVNCxQb0zSwQgy7ZhJZUp8pzYdQi9hWc5A9H9P0kxWoxD8xLoevPJEclUD2WUxC6p
 1+SqbSbbTjur9gYvk6IYNvyGG69sU+dT4sVWqMckiKmD1rDTRZ0PcZ8UjU6cqmyM/cu8w==
X-Received: by 2002:a05:600c:1c06:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-4903604823emr65479145e9.10.1779386684493; 
 Thu, 21 May 2026 11:04:44 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:52d:7400:bbd7:ca83:de4a:f625?
 (2a01cb08052d7400bbd7ca83de4af625.ipv6.abo.wanadoo.fr.
 [2a01:cb08:52d:7400:bbd7:ca83:de4a:f625])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c9445d0sm45599865e9.0.2026.05.21.11.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 11:04:44 -0700 (PDT)
Message-ID: <8347b792-1c18-458e-9c2f-e34de156d78c@gmail.com>
Date: Thu, 21 May 2026 20:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] arm64: dts: qcom: sc8280xp-arcata: add USB-C
 orientation GPIOs
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
 <20260520-surface-sp9-5g-for-next-v1-4-9df52552bf87@gmail.com>
 <418efc2a-d7de-4c1d-98e1-634f08bc3a85@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <418efc2a-d7de-4c1d-98e1-634f08bc3a85@oss.qualcomm.com>
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

On 5/21/26 10:52, Konrad Dybcio wrote:
> On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>
>> Define the USB-C orientation GPIOs so that the USB-C ports orientation
>> is known without having to resort to the alt mode notifications.
>>
>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>> ---
> 
> The commit message is slightly misleading - there is no orientation
> data otherwise

I will update it in v2.

Jérôme

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29F4CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 17:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704D110E539;
	Thu, 21 May 2026 17:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6PXVUvp";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D6810E539
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:57:39 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so70935755e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386258; x=1779991058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gylbKCiCuocOK7umlWhz6aOgovCb2toi5YR+NyOexAY=;
 b=d6PXVUvpu/KVsDa1taxU+LUIAFjvie7+u67Wd5G4qD8LZHcYdSjlq4ENBrzax9CNlh
 w7yZ7I6aVYmzRMB6W5YRFirAxqUK91vQQ6c6rk2ATcHCQ0zy4uScYs4//swM+tzv13i0
 0dFrzn2kaQ0OXKAccOyHtQaQtThg+pOVPIk5AJuVIfjcaopGnR+GgEYLCGQ+6yEyRlXZ
 4E0xu3vkxkxRTNGhEqO4clnR6hwXntAdqGmq5CX52NolOkMqSO04dLN6byrFNzT5g2kF
 pKfmTPujqWNp8hg5yV2fWXgIKZvff5GEFaYAIMcKpMTOvJH5NpOQpAD9T8M4rEsMPTOD
 gKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386258; x=1779991058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gylbKCiCuocOK7umlWhz6aOgovCb2toi5YR+NyOexAY=;
 b=mCfMw7Ov3BmN44sTLyO1fJBse2wR+feLteTBzNZuVq4TeEL2wUAdLCK+jEmCuoCEha
 pBk8mY7Cc1fo5XeH1JtbOw0VbDVRYEftPFY1Ny0A3yQ26DZDQkIjVdiH2LwWn8t27yjW
 j4/A3vmmgL26bOWng37N8RRN3vNjwnJETCS6oO2keXxS87WZbhRxdOXdG+GzmN7p/yXb
 A3ATe0CSI6h11R8k7SgwPRRHCRo7QYZyJbWGNJS6q91ewO7qdYFyOkOlnA58NDD5PW7V
 ndOOsqkmYs3gwHjDDTyetCKzkbstu7gPmF3IzJ6PKLJE7/AuYKNFq2zQtVVKptPU0TsN
 PnJw==
X-Gm-Message-State: AOJu0Yy7rPmGftco8ZunVnAsZ4w1r7hFGGYUycXUHzvjLIt2NOJ0NIF3
 A8hViRKfPmfd26CGycYE+MwQRRYVPipQ9I9mDqX2uH26GCVN4EB7Ftg=
X-Gm-Gg: Acq92OGg6tJ6WtFca9YS5i721KVsDIXfegTUI/zHQ9ooFaGM64n4niHSib89kx0HHxx
 C0SXRpKggJguJXCsbHVK2pUdjXqZvU7ms8PCIpDLxGycagsFCTieqkPO86rM2fSpnTnVg+PzDa4
 OzQBq1NPjQFou+KEdlT+fhVTTvJpMqglLU1udPHsG7K7x6eFPtt/L6pFgpBFS8l08p9VZdPFPV0
 TG8cLv/UPCT+e6h1+Bu0O/VCFye2auGpVIaCJ/cffFoj6Ycd6+cM+KQeBt0fp+Y441F3VlsNkwh
 hvcvAPOdeomaqwpI0RxCoBkQYVyuhPl0yVPhojyi9sGeS+iukI9nkqO8M5IHcvoulq3GuM9BuSz
 Qb2q28shSAwyDYDr6D0TOt8aj6I82sl6tRcgvh4DroXL8lSHuJITUEeiKRkk4sDvJT72y8g05na
 HzkUnQQDDHXR5k/ni4V0bO2Y5hLFNofJ6+mRwllOQTiRJyPjGI2oznzpBFMb2vi6Jd0BI9kKBj2
 u+W4290VGWcVoR0MFXGuP1JFyoG6mBY0lFbYEFFCKGUONk/w1fqtndGBBeTRl7sziwbKg==
X-Received: by 2002:a05:600c:c084:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-490360d2970mr47342025e9.26.1779386257641; 
 Thu, 21 May 2026 10:57:37 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:52d:7400:bbd7:ca83:de4a:f625?
 (2a01cb08052d7400bbd7ca83de4af625.ipv6.abo.wanadoo.fr.
 [2a01:cb08:52d:7400:bbd7:ca83:de4a:f625])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033dab0besm74323395e9.15.2026.05.21.10.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 10:57:37 -0700 (PDT)
Message-ID: <9eddfa15-ec2e-4d3c-8d55-2be5a974866f@gmail.com>
Date: Thu, 21 May 2026 19:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] arm64: dts: qcom: sc8280xp-arcata: Enable backlight
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
 <20260520-surface-sp9-5g-for-next-v1-2-9df52552bf87@gmail.com>
 <f5f70aa2-a1b8-40e0-838f-6709e6e08a5a@gmail.com>
 <624a780c-0b22-45e3-aec5-e61c319de901@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <624a780c-0b22-45e3-aec5-e61c319de901@oss.qualcomm.com>
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

On 5/21/26 10:48, Konrad Dybcio wrote:
> On 5/21/26 12:26 AM, Jérôme de Bretagne wrote:
>> On 5/20/26 18:40, Jérôme de Bretagne via B4 Relay wrote:
>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>
>>> Add backlight nodes and enable backlight so that it can be controlled
>>> with the corresponding buttons found on Surface Pro Type Cover keyboards.
>>>
>>> The nodes are almost identical to the ones from the ThinkPad X13s with
>>> a different enable GPIO for the vreg_edp_bl node.
>>>
>>> The difference was found by looking at the output of /sys/kernel/debug/gpio
>>> on the ThinkPad X13s to see the properties of its enable gpio9:
> 
> [...]
> 
>> and ... backlight still works! It can also be enabled/disabled with:
>>    /sys/class/backlight/backlight/bl_power
>> as expected.
>>
>> I have no clue why both gpio6 on pmc8280_2 and gpio6 on pmc8280c can enable and disable the backlight. Is it a common scenario?
> 
> Could it be that one of them is an ENABLE_BL pin, while the other one
> enables the regulator?
> 
> Konrad

I've looked at more device trees and seen that quite a few of them
simply don't have a "power-supply = <&vreg_edp_bl>" property in their
backlight node. Trying a similar approach, the backlight still works
so the gpio6 I was adding wasn't used (or even useful).

I will send a simpler patch in v2, removing the power-supply property
and the vreg_edp_bl & edp_bl_reg_en nodes.

Jérôme


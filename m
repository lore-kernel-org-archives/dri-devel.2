Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144A2CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094F310F285;
	Thu, 21 May 2026 08:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSvSrWoY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RLhHpHXs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FB310F285
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:48:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L7KqAB119200
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fPSwqpTo03Bkl0v3i4c9hpTGEzAjY7Tg79AzsZEcbAE=; b=YSvSrWoYRS8d2pDa
 zeYLe7C2ZycakQs0S4vZ842NP5K15wj5uvyeK91nQCDZ69KKlM8R7T4fc/S9jagw
 dw3VxxPt7Coq2v/m18HeCyWKI549nm3Aq34G3KnxLuPLNAWeQAhf9lKrES3RhamF
 Rk1RNBTdq4Jp3BnTv2CeCcy33P3gcg9sHdW7LgSH9U+6nWAEQat3AWY7T1UWoIqk
 6AakZZDIoaPANRbY5ODRzb5wcwYLprRSzomYJCS0jRZ3Utm+FMjmC+cJ73Z+TjJ8
 wp6JqswWPVVqZw5RDGR+0TvJ7nKQpTNCY5JDf7GQoambvkPqjwBBiin5Beaj5lGq
 RRnuGw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c2t6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:48:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e62562b6aso18421391cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353317; x=1779958117;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fPSwqpTo03Bkl0v3i4c9hpTGEzAjY7Tg79AzsZEcbAE=;
 b=RLhHpHXsRHnRWQI+D9eaBfH/HkD08wz6Aan11e13vbrddBpgamiEoNZWJZIxxzUXpL
 SA5KN/BzFzVnYln75vw/R58KeqEtZg9GoIzgC9oFjpwBeZpYei+KKCji67Us1wr0lo8I
 qXvrDt90p+cpXYkMzjRljUW7qMN+zZMd4NbVuagI8Jtvep6oH0y6FhVDhZrks+adPaL6
 1u5xYI8n1ydLp9cVGVCdygcYUpq/m0ufBk5uV4hwCC/QFlCPvtJHi3nMSirAF+/mUOnS
 nFmW5PrfQ/WAT/+/btrfCHN7Lw+kbzTEJFD5B1kK7yCzYKTKMN02p7vR4Mr27S8RNaXc
 pejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353317; x=1779958117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fPSwqpTo03Bkl0v3i4c9hpTGEzAjY7Tg79AzsZEcbAE=;
 b=IKJ73XhUrDdkEGnqeIrf6F+lMut0pieDBjnkiOY6WLX4aX9h6QxoJP5zMmIvF461VN
 m3euxF1uOsYByLom6w0m7YSqsLrxBB0dfZbexnCJV1spJIN8f3iRZX1QOnjFyhO+5h0P
 TkmhOqfI89Mt/+qcOGS44DtvKtpFTifjKxBXtqGtVHdl2od2ud1qTGf4xSJKjWAKaXtx
 fRBRqfWckCebsAyloJ4u+T96GU58py0nlhmTzN0ikKimO041t/bEr446S3xFBYHFx3E9
 rhjyvtUID1aPHLXWp7hZQp3oIihWVZz8/9I985uOsQQYjrh8FrObYi7PS2FsuVqgjyvq
 ckRA==
X-Gm-Message-State: AOJu0YxtBXxb2Ew/+xDaZEPD2zJK3qUgxMQYJ1u/LYZZpilwTkjdUp8N
 hNUahXDazfBOw3x9NxVylQQelhQRT7AXk/0lkqPBpJK74Z9+G6dwh5J4soMt6NYoIkdT5/DhoMM
 I3vFPs7qscNLF56osZEYHaM3ipgjeFXvYeQyPT91qS8Q6EVaprEPWsuO8kLL5GSd8QQs6mQ8=
X-Gm-Gg: Acq92OHxeJfeMlrnWNsCBDuoaTz7/Bx7DWPRm4X/HQy7BXDie4l0RaQnxiy0CkcJy5r
 11mHq27ich0vJcLarQYhcoC+erVnhBPOKY0hzXzFvOd+AFbq7bo4k7JN1r+0AZLkauPKD7hmMoM
 metUDRT/+bM9d/c8y/o1E7OzFLYULMe/f9biLTBGWNt/eaNKIR8CdP/8I4khHy9amb5W1nL5Jne
 J6EBIrx/k98irNzMKIQlmOW4f0sHrSHZbK6dCQuE0TwlNnrsxtmSVOobuCghT2em5vVDbKAGz0y
 AKZhBfsy57Rxi97aMnXzgN4wMwsr+qcFoPAkMlUZ5aIF4jRCWg/Ag7f956tdpiozaXirurSh/u/
 7OFSJd/PY/35fY/EhBjnkVUfNTNu98traEXnsqX8McJxMiJoPFtXJRN4YJRa2PkpyqAv+t61Yp4
 I6ofyFnHkeXe6vPw==
X-Received: by 2002:ac8:5812:0:b0:50f:b9a6:82ae with SMTP id
 d75a77b69052e-516c54382cbmr18835291cf.2.1779353317525; 
 Thu, 21 May 2026 01:48:37 -0700 (PDT)
X-Received: by 2002:ac8:5812:0:b0:50f:b9a6:82ae with SMTP id
 d75a77b69052e-516c54382cbmr18835131cf.2.1779353316998; 
 Thu, 21 May 2026 01:48:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdc87890ab5sm17545766b.4.2026.05.21.01.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:48:35 -0700 (PDT)
Message-ID: <624a780c-0b22-45e3-aec5-e61c319de901@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] arm64: dts: qcom: sc8280xp-arcata: Enable backlight
To: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-2-9df52552bf87@gmail.com>
 <f5f70aa2-a1b8-40e0-838f-6709e6e08a5a@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f5f70aa2-a1b8-40e0-838f-6709e6e08a5a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wE7yORRWjzYUxc4wHxe9pKLmp4UVtxv3
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec6e6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=-MGe_S8tJvSwwJYLNm8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX6SS87RiNATEu
 /1QOsri59Q6nFFDp7Zuau+J2MufISNjyOL+A9RHdQAGmoFxxprZYOzBf4zJT1jADwACMmeckY21
 xPPSbJkpIyFktditBx0V/B36sENtpxMvaEgOpYleI7xhsoC/z+58EVO9b5PlKon3/YdQHb7Ttco
 9pP5BpbDS/KVe154NNkqt1xD8v0Yjekc7XC/MSgjKtfvGmwvekj7ZZMrnMtLaeH2e+dJ0BaE7h+
 b7tFlYgm0RMHujTjvjLoyLNC9j1KxBZrz7STrUsQy0Upeyf3tLKFYMqgne989Em03gC4vMt+XhS
 WMx+c2PmkcN6c2XAqgGME7zCBijf5ezNtSa7p95yELhdmfSIKiOj3wN7Dohk0df4uNzoFhS4o0w
 R1Kt/jd+cZ8jca7fDbFAyVJmR42GCT2cXQHCae6Lfrr8Ue3VuSm0VZcV3ApKA1xT9n9VKZvKhf7
 d3XHFuoJ0b/xkG6TfUA==
X-Proofpoint-GUID: wE7yORRWjzYUxc4wHxe9pKLmp4UVtxv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210086
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

On 5/21/26 12:26 AM, Jérôme de Bretagne wrote:
> On 5/20/26 18:40, Jérôme de Bretagne via B4 Relay wrote:
>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>
>> Add backlight nodes and enable backlight so that it can be controlled
>> with the corresponding buttons found on Surface Pro Type Cover keyboards.
>>
>> The nodes are almost identical to the ones from the ThinkPad X13s with
>> a different enable GPIO for the vreg_edp_bl node.
>>
>> The difference was found by looking at the output of /sys/kernel/debug/gpio
>> on the ThinkPad X13s to see the properties of its enable gpio9:

[...]

> and ... backlight still works! It can also be enabled/disabled with:
>    /sys/class/backlight/backlight/bl_power
> as expected.
> 
> I have no clue why both gpio6 on pmc8280_2 and gpio6 on pmc8280c can enable and disable the backlight. Is it a common scenario?

Could it be that one of them is an ENABLE_BL pin, while the other one
enables the regulator?

Konrad

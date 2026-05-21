Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904A1CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E1B10E474;
	Thu, 21 May 2026 08:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptVDuDGb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fuZEvgT+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D778110E474
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:57:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L2Swl73815908
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8FjEMX7Xg61uERfYxrB9paEF59vrppq67TlyjKhGpss=; b=ptVDuDGbznTcuPWN
 0Dnwp89uTPhkRd8CDzvkQ/MosxKpjwf/aG279ydRDDs96TNTWfiVeJRuCYfaN29P
 uHquFiqHAGan+u6AgS08+cYCD/YZP574kjHaiJVMqggcLUI9csXnBceEABvfIqYU
 VEGtGa000E6NzUwtlabartw1ZlPBywwijO6RazC/TnppKpZHVfhH9FpkKs3hspkr
 xJLbJmI+9JsYMEV0/n0ImIRybUivlpP8Cv19KUko2P/oV4DPyYzhdRvPW1EaFkV+
 QVkjYR3TLPKW9+W5cko1C8MbQqloKix+ucmouuQlWY/iwjiaZB7LTnYOtP1tUipY
 pfsGCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa1cdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:57:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90f04f07227so147432185a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353847; x=1779958647;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8FjEMX7Xg61uERfYxrB9paEF59vrppq67TlyjKhGpss=;
 b=fuZEvgT+0IHW19MthrYqvlQC6OqW5p/0FWdCd4kvZC98z1k5GUT7ZpWwFYOu8WtLbe
 pRc6HKju9VfXt3nRyQxp9fcxRnfco7G338dR/sQOW8IyxSjmLtjxC30SNQ72jJbxkqmS
 iBSJ4RT2Z6rUCn14jZrF1eeVv2zcH6j9+Ds7VjfxcMRFc2N2/Q0zk2kkmmPvlp5YXvZj
 WR8y0nbDovNy1Oz6Mi9yW9IRocayhBcaPXpboZHazdvoS2Q8g2BAf3AeNQuuUv79ihZv
 JiQQ2t4fX/m0ZhbN2B+ISk0AyZ4JUSAHlQQ6duIYwlAJRlgMLcytchXCo/sf1+rP4/Db
 bsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353847; x=1779958647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8FjEMX7Xg61uERfYxrB9paEF59vrppq67TlyjKhGpss=;
 b=gOqjwvmUgloPIO0UZ+W0vsGk/gfxm9oK//E50OKvR+Zeskcclq5l94Jtu2AAaGfgQG
 DF2o5BLFmtcN2extTuLKk/ZE16/5HAE4TVNs6uH38JFZ7TEGxVfHwwiyM4WFSPt7Lnxc
 Yt4lCtogAGKNMakaE/T1XcN4FfIAf4JE8sytwLKr1m2wEzCLskVxh2Iwm4yTVtorX5Lc
 FjaR/U7JJlmI7Kasqy7qQTUuXPPVBrGGy89BoTEc1eLc3I69VJndwVBC0ZPttOFbVJis
 afKnbXDOXS4iFhdABgT65XKSKXzXn/RAIL/ILXx35nFM9t3gFTiMMENu/ScQ9H1DBwu5
 SyvQ==
X-Gm-Message-State: AOJu0YxDY0YyjZBlLFs1BWKdJ7TB/PE8ZL9H1AI711QqvLU1KHdqMk64
 9eX0+E2W3X1ygg9HCs3Ii7z5jmAIXpNfQUb20o+kT1uwntgaH5mVqZfGz0nLf30+JEEDxm2dy2Q
 jKv0iIbq0tZ7I3hdi6UDF8M0CUkap/lVRiWF3zrx0egUGMnj3Jfc53owuL8SY6r4rq620vh4=
X-Gm-Gg: Acq92OHF3kbYg2cLmTv9xGUGo+dskH5hekF7/cvn09hoQGVMxM1IG+R/LYcg3ISHs+Z
 xKNoe1Zn7giOh/SQwqHAUtIahuBvAMkcV5hLvGSYBSDnewjXhY8nfnD9lEc5I6kTbFoqSER3DRS
 Nb3QrFH+SHDBmtPbJWKQJtpEjuwVMHf5L2moUAFbrt4Po2mBYhfdONLBiOOQwLjbdyxiyZijGc+
 vuU2RMX4QNmx+4lENwHGUgm32p0Ad2y2WloSKwo6jX1OQqVbKLnAnD3j4Lig7QwUbYu5W8Jysa1
 8Osy8yPEZYg5amYczUiJyrZuKd/8LmYfp+HCkVYZ++Xyv2u+BGZym4/QOFjZ5W9I+elUhFwal2q
 buNEOzKf+pWZB1j6FTGLrdVj/tmZli96mz5liIUMesxMmlW9TogkgKmON1ojgmR9BKNC4nO90KT
 Ub1lU=
X-Received: by 2002:a05:620a:4456:b0:8ee:e440:fae2 with SMTP id
 af79cd13be357-914a2cee72dmr157596685a.5.1779353847219; 
 Thu, 21 May 2026 01:57:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4456:b0:8ee:e440:fae2 with SMTP id
 af79cd13be357-914a2cee72dmr157592885a.5.1779353846676; 
 Thu, 21 May 2026 01:57:26 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68310b3e8e5sm9082419a12.4.2026.05.21.01.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:57:25 -0700 (PDT)
Message-ID: <890213e2-8e9f-42c6-a59d-77ba2049e979@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] arm64: dts: qcom: sc8280xp-arcata: Switch to uefi
 rtc offset
To: jerome.debretagne@gmail.com, Douglas Anderson <dianders@chromium.org>,
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
 Krzysztof Kozlowski <krzk@kernel.org>, Johan Hovold <johan@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-10-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-10-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NyBTYWx0ZWRfX5ExYfSkFD1vm
 UM+WACD+9PAVgdxPnwq/JyO00xwvMLVoAiA1f+9frXG1KBqh70ZcsU9gTy7AHUmHZfWGzogvHIN
 cO++LJVYgLPwxHCSGa5pOxguujmyCSPJyQt01dwKCkRTuExYiYg6gVAPLBaKN4mCOwFvO3h0CWo
 0N3vl9FcF0DbpKEkliLlIF/igzYDlZ1fmiB60ams6nxOEekkGG5wSUEXARHz+B0Oeu3+JTvwY9J
 CfLH75KDYne7Mh2BRmjaXCtkk+8/u6EZzU5bsWWDEMHdsD0zo4//JzgHWDo+PvWe/GlGQazTF+1
 8zAU3mEg1n7NqGxGGdBARDjqrSLN88zIHK32qxUQXPIX0mztsMm5QHXcQN9HIbbE+rDJ9IY/lb3
 +QqCgy2FjpBIACzQfl8S2O+DAdDoeOLugCM/orG5MEhrHorfs7Pt/L+xcWZi4Dz39VsA92xxZr6
 Y7XMdfN3DGmodgwAKNA==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec8f8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=S3QPRrZGCkirkA1mjOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: p3WSavNvMVugCzMckQN4P8w3_vA4T-G0
X-Proofpoint-GUID: p3WSavNvMVugCzMckQN4P8w3_vA4T-G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210087
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

On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Align with the reference implementation from the ThinkPad X13s:
> 
> Switch to using the Qualcomm specific UEFI variable that is used by the
> UEFI firmware (and Windows) to store the RTC offset.
> 
> Use the new 'qcom,uefi-rtc-info' property to indicate that the offset is
> stored in a UEFI variable so that the OS can determine whether to wait
> for it to become available.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZxMgJ9LH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V/hsBfqG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BB410EA03;
	Wed, 11 Nov 2026 12:44:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D5E10E49E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:44:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZ00c2286883
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Svom+v5DKCDjCiWUGZ7T4HxR2P7zbfjjfUl54/X/CgA=; b=ZxMgJ9LHyx+yYhb7
 DGDEcUnJoT5haAODh0YG7f7GPmJBi6ogrxMSbDi/RS+7aI0rfbfwIDQ6D043tCwO
 xzY5Osy18UV5kSLtcCS3N6EWbJKZFoEMYQttlRJd9Kg7eWREXmvDNC0WuPxVmOan
 m6bznMkWN1p7NrrhTtbF1wMiIbwPdD/fdPKChkXD2rlmQeRPeP0+4lZvd4aEBE+o
 N6NdBP9MtjVLoB5mMJZHx3uL6zKk2yu3Y/u5k671dCgJZ6Ag5AxR6WoBct5BjJhO
 elzMzwtUO1FJm4Ct+Kr/pN/bz6wKAHLTMeEJV1tQKSJn8qqCaBer8ckXHTuZNSSF
 ooJfNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm96yn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:44:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9308eafb465so659610385a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794401070; x=1795005870;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Svom+v5DKCDjCiWUGZ7T4HxR2P7zbfjjfUl54/X/CgA=;
 b=V/hsBfqGcRAnzjVdQjIt5xVyFwuVCDPXqr0SFsszOVOgq/xcB3FfjdB8yeegLqdSZH
 hCSEABv52JJ/U8WVBTcr50jSOEin4KIY/tA2tVsts8hzA3GBHB3CSDd+3/ZMg642rDwW
 BPi8Fj0xOUP1cIn6qGbI/hqpLW97AiPU3BXGseDhS5ULOckCj5ExY4FvpIGM7dhvs8D7
 s9hP3Lg/bY6vgmFuFtdqGxybaAVFp5gBald5wXRUoBp3mkRWBLMb/G/et0raPusdQ3ZZ
 YDLZFFDnp0Ez2HIqaF5uXhJiOTnTaOdTSIeZG9cliqat0UDDdfoEwgSlMmaeobhrrqgY
 5sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794401070; x=1795005870;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Svom+v5DKCDjCiWUGZ7T4HxR2P7zbfjjfUl54/X/CgA=;
 b=V5YNszBk0o7y4F1NaZoePEYeKg68MoGRqGEV8MCWu5u7h5xprixPrwLudPVjKIIdFV
 l8Kb3oi43uWfwhi3mtT5E7n6YEhPX4wjQveMKVBC2A/Ji2cLNLZwjuIih1l0qI8Q8MyL
 ryxefglY49F2tXpfVgjMZYijOf291WloGOeAe3Pon2NOqM0xlxYDkdprK5a6I0EbsCXc
 SiSYSV4iqku7y8ztq5FAhegdXmkj0YkcPL8AcEuAIyTjuqb3u/HvPsLRYRjPibFwV6E0
 8U1fLY5vgKM7TNBJYFqnrHZYn8GkPMoGAo4xW6KETul9zEqyWVUd1YGyInULhmyWHchf
 MzFA==
X-Forwarded-Encrypted: i=1;
 AL+hErEBm8EtTL2t5rNaxrFO/TbgHN1lVDFb3+qeziPylz+kJLflIC29A6Pg9gN0LW0fWnzsIjFRPIgZ3qg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9US2xkSpQZMwUAeLh4pUqsyh2zSSTgIpKFeED54mDQWuBoQwy5
 5ZxatZlngZQt6YDxURW5WBDdhm8T/fYZFa7FatYWMxMJV3Ksntw3F5VEfHd/FkEm3XRRVTUsQZ6
 spEdAUiZNq0NGkj+zhm+Qp5jkJNPyfxYxBm+wKUBmD80fl6XPG4NHH8WuubJGilm2iPf3JsA=
X-Gm-Gg: AYBFou35yiuPHve01752boldepYK4QdztmX7aZxtpkYtaeZbXO8m7GZTXN2ZFZaCOF+
 QZ+MM+DdiutP46rz99sTDMkl7lR0yuvjW+XdPTEOkcKAUrL1IaZ2GsnP9ZRf5bpq9iEhJjguvex
 KCoPb/KfHt+3YxO5i7n7lrf4t4OX81o5vrxZaOcc+Qz0fBbRRglfXwrE5umOxBYdTuRbHLta0BN
 WfF5I4w+Qik6Yt43jeLCJiSX2VGLluiYN4mKkAKSqIMvb7PSUccgxa8WVwKtsw7sulT4Ze7I7HI
 3r4nq+VlGFtJbDK5FxAkxM5o65zxoEndJ1pZ+KKUv8EIk/oc5Vyil8Orckky2zQz+4+IUPNcQww
 OsI/rghUq+2y0ToP/5ysjWvAzTckqAqFgt0qHI5rMZtznps8pGd+oQ1VGM3yivT+Wnp1qFpgNPE
 M=
X-Received: by 2002:a05:620a:1b9a:b0:93f:2c95:658c with SMTP id
 af79cd13be357-947aff969bemr317652985a.14.1794401070232; 
 Wed, 11 Nov 2026 04:44:30 -0800 (PST)
X-Received: by 2002:a05:620a:1b9a:b0:93f:2c95:658c with SMTP id
 af79cd13be357-947aff969bemr317649185a.14.1794401069520; 
 Wed, 11 Nov 2026 04:44:29 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bc9asm10036962f8f.29.2026.11.11.04.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 04:44:27 -0800 (PST)
Message-ID: <0f2c0eae-ed05-41a2-8688-e4b6fe1b7ff3@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:44:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <jo@jsfamily.in>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>, Alexander Koskovich
 <akoskovich@pm.me>, Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>, Michael Walle
 <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Jens Reidel <adrian@travitia.xyz>, Michael Srba <Michael.Srba@seznam.cz>,
 Shawn Guo <shawn.guo@linaro.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Romain TISSERAND <romain.tisserand@gmail.com>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
 <avRM_GhtR8vMdTO4@houat>
 <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
 <43373a9e-9ff3-4641-b961-b63f4de21cb9@oss.qualcomm.com>
 <oubzclitudtqiv64wvg5lvxvbhuffxmc5bgbsdz4ou24pfhbb4@decarhvjzl2a>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <oubzclitudtqiv64wvg5lvxvbhuffxmc5bgbsdz4ou24pfhbb4@decarhvjzl2a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PEnQpneswWCU8lTJh2bkvstd16CEhQnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfXxbHPRAF0p5Rz
 /AV1xSVqiuYAa/DpukEIJw7FROtumG44muIORJRciQOWYgWRckBjzYemJO70DI1wClFlvvxXcfs
 oBhGox4GOOuJ4HhfkMu2IgY73HTPQdRRP9RUTDCqg64xtd61mcd6wFFjFzoWNdjUjKB4bHfIJFy
 EeUFSInxpjx3iPztdjSfsLVfburCa90bopb9f71wucyuqmjJniEMiWbS/sLuzoSHmG5px3tO5Mm
 sYEgy9+ldFPp0qtU5nl6yjQ0xZQyTBYbsnF+drxl0TjT8v4u/uWAbW4Ov1djMW0GH+tv5PRiB1O
 fCJfEDyt9ttLwFDLg2Kehd28V4kvME5IIr6TfZcypBPz1bu+NA3PB20YhoO76YYuZwm7YAQ7983
 dp21ETYKwTPjRV0WK3XRfHz7DbiBRvShuUfCIb6Ti7Fo65v8Cdtt7MLC9Q/0hMCdFaIXt4PZfPk
 sPk9MfYnkn5tSJUzxyQ==
X-Proofpoint-ORIG-GUID: PEnQpneswWCU8lTJh2bkvstd16CEhQnR
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af4632f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FoKKIyl-W1BixC_GgiMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfXxgU6ZMve9iuL
 awmz5lktOLlLPo6H9EC2tml2X3ngsGY6ejv/aCP4+dBJgfGr9Y+kE6gAor2NDWWO2BlguwAP44x
 zr8CrOZhEJ68k37Ot5cmIth3mcIMih8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 13:37, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 01:31:39PM +0100, Krzysztof Kozlowski wrote:
>> On 11/11/2026 13:30, Krzysztof Kozlowski wrote:
>>> On 11/11/2026 12:13, Maxime Ripard wrote:
>>>> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
>>>>> DSI panels can be placed under DSI bus directly and many Linux DRM
>>>>> drivers will work fine with it: mipi_dsi_host_register() adds device for
>>>>> such panel and DRM driver does not use OF graph to configure lanes.
>>>>
>>>> That's not true. We do use the endpoints to configure the lanes through
>>>> the data-lanes property. See drm_of_get_data_lanes*
>>>
>>> Some drivers use endpoints, some not. As discussed on other thread,
>>> there are more than which do not.
>>
>> "there are more than one which do not."
> 
> Which means that those should be fixed. We have legacy cases where the
> drivers assumed that, but we should not target legacy.

These legacy drivers work fine for 10 or 15 years, like Exynos.

You can improve them, for sure, but if no one does that then requiring a
graph is a mistake there, from the panel point of view.

...

>>>> DSI busses can handle multiple devices, and multiple data types. If we
>>>> were to drop the port node, how does the upstream video device know
>>>> which device it should send its video output to?
>>>>
>>>
>>> We do not drop the port node, who suggested that?
>>>
>>> You do get, that we are not talking about the DSI host, but the panel?
> 
> The panel might be driven by the host directly or there can be other
> chips on the bus (someboby has been asking about the retimer or
> something else sitting on the DSI bus between the host and the panel).

Sure, does not change that panel DOES NOT require the graph node.
Neither current Linux drivers, except some.

Best regards,
Krzysztof

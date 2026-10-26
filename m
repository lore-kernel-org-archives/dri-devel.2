Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D3606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j31RrgOU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SZSTbPdj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002E810E29A;
	Mon, 26 Oct 2026 13:04:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A4910E29A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:04:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtWtr1547931
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TLD/r6Gz4+An61s5hBdFiidrjOGPaqrooCSaDwERtz4=; b=j31RrgOUjSSFrksc
 5i8WpzadNLO8nMuKnl2WgsWEDTUo3UiQOkBhCzdti/BOGnv+BqueC/PgNzwwUTkJ
 tzO45m3+VwpacDfcZF7NXR+u9CHPWrs7HBuJ6Hgl+gnMuUzGAWXk4EaGc5nUc1Wx
 gEwJcs6OsLiJoxf/ed7qt9SU7biesZzKZwUKC9FBL3Lolw9NnGvCYo+kkc/B78S2
 jX3p95HuOAg6/mj10NEszE/mpxSYLogzROT8/H/XA7WenyTX8GFkmPLe42ywhltT
 o07vrcOFpd7R3shXTd3FLQ6wKSKCrV9nIaSbvrchAy6ZaLorLYmrxw82Z6WmqcQp
 ulSR3w==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsthtg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:04:35 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-4a7da05b026so4201393fac.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793019875; x=1793624675;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TLD/r6Gz4+An61s5hBdFiidrjOGPaqrooCSaDwERtz4=;
 b=SZSTbPdj9guMYAgMEh7ERiyYUKQ2t0KmD5aMG5M6djalLPOiYZqXa/BoRCBKnmkFQC
 wnl0N/DOKuYCLt6xjEq8YuqvNbWD3QdhJ0a0CjQIyPy9j/OJMe0l1/tjmw6q+8qRSRF3
 v2biQrMw7mb0dXqHUnKrJD3s4lFahH4bw/dlPkZgSK1SzMgb0TU71LfbaClpk+1rGO4r
 PYqKhPsy55SDZFLYMQZcYazppH+LJ+GvK5cTvKf2ibQOtMuN/V/fcFYzX0WFOmIAar8v
 /LNVvEgStbGYyT9L4Fb6xZv5pcR85WULE5r4oj9L0Wo0r4yI27Z0CEbaLzJSKhysa5U3
 ym8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019875; x=1793624675;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TLD/r6Gz4+An61s5hBdFiidrjOGPaqrooCSaDwERtz4=;
 b=nPaEwIIOiO0gTG0oPDtRWJ8gH2DQSHvMLWBU7bzSXv0yHKxUDY+ltvI/WNrdVfi4H5
 wpwfb9R8j8hWJBE+ET6WqWxv5qCWD2X7GR0JZBUUYbto5Rb51KY4VL0HuZnG7K3kWFuA
 vtVhoRfl6qjMeBUt6paQKvrziYNX/rtrCo4+aJNjg4d/Q4rCbfH3MNquHwzLUGJ/ulkq
 k9Yq223U1U9HLZLDVVSDC/S2MAzWta6vTgMt19c8rss0nmI/1H3jP/rkyZJdr7jYEA0k
 52kA1BwD/TpibAmXb4iR7YHhx2J3pS/HfCi+Az83kCkPIolxxl56bVJSEwHwm8QKdxTk
 X+RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1y0zUAnaShdQHMrvMRDasTXT4FEQKbRUch1pdnEE1GzJCS00y/hSPdQKxkxUKl525eGcRVX2DfGY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJm5QmGdZoeHQy/Apj2hNv1qHSoli76eX3nJstunUorQX7Isyue
 XqjgM/7ZlkzvHh/+T/Kszn1OhjS+MucGHUv2qQzc4v/FPzn7MC+Kqwx/o+8IEUPgcmdOkinZ3vT
 p1WTkU7EQl7lIgKL+OQ9ooUhcbGhxXGBDgsgtMxYDq2EaxSkW1PxbtOx1D+2IEV+IrgHyapU=
X-Gm-Gg: AYBFou0YQiKs5Ag5WZ26Vm53tlLcZciS7ft3KruRpzsCfH9emomWRZ2r1B/0EhSZMcM
 H7+6gWfoBizGuFilCgbBeSW5eqFsZuN+PixbeunUxRcABafljDVAjV5quvo/EVpey3kX7dL3uI1
 RbTuRwATzCIdn0z/re3lRvNAyLjV1hahz0bNMnKIBRFlCDaZwTl5nufcQOQoZrluO3AzUU1Cx0a
 lXIaA3eg8dgq1POBpM2i1dw/nMFWlhMPluuvAuufyqVMy6Lqw0wKL3JVyDbcAJFGebKrz7k9ieS
 bWkw0FhF6T+X/9ydAL3L18bnNsa7FqNNt9TOdz+nn8lT3eXhv6fOB2lCTxtKAzyk+2c/+wH8DG5
 t2JR/WOAoDC9UprGkaRWKpM8Kcpt8juAF4HuXnAA/Jk0K8FIjSwZP7pp/G9/EfhrjEoNLEgOAis
 nHM5/BUVDslKxIZmpdiELeGuzU0Io=
X-Received: by 2002:a05:6871:2b16:b0:485:d31b:7767 with SMTP id
 586e51a60fabf-4a83f5c5dc3mr3995550fac.37.1793019874773; 
 Mon, 26 Oct 2026 06:04:34 -0700 (PDT)
X-Received: by 2002:a05:6871:2b16:b0:485:d31b:7767 with SMTP id
 586e51a60fabf-4a83f5c5dc3mr3995525fac.37.1793019874362; 
 Mon, 26 Oct 2026 06:04:34 -0700 (PDT)
Received: from [10.190.200.105]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8431bf31esm4742983fac.12.2026.10.26.06.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:04:33 -0700 (PDT)
Message-ID: <23c34b9b-2692-4fb6-9a8e-6c11e4787f76@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 18:34:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
 <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
 <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
 <5568fd0f-e412-4f2a-9f1e-729a469da572@oss.qualcomm.com>
 <65f6883d-8ead-4c6e-80f5-81f6857df0b8@oss.qualcomm.com>
 <f624b075-df3b-4862-8231-8fcae7f18d50@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <f624b075-df3b-4862-8231-8fcae7f18d50@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MSBTYWx0ZWRfX4Db8espfj0d+
 +YcQ5TfHY0hEIxKLD5fkFoCSy1+GgBGx2GQup812v/ep5zqDqVN37sVZO1/bFX7Rp/o547mEu3b
 wXqT39AHVVC5DjYbhCK1fq5RWkX6GKM=
X-Proofpoint-GUID: ryjVHpLh06UbBQ73k2W_ERTcSVngsmx8
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf4fe3 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=Sv1olGuBKYLPw-ZkEP4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-ORIG-GUID: ryjVHpLh06UbBQ73k2W_ERTcSVngsmx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MSBTYWx0ZWRfXyQ6vTx1IVV2O
 toFg0WaaNtMQM45eHSrxZsiRQtxMi9ezPkwMasnCatHUecCMvDBPkPElRNPwHEcrHme+T5knMqT
 gCZgCliP2foLjrVEiMGf4ZH7xsuhxXnsjHpVzCMpCwP9ZZ196qYBg8ntBgkvONE0u91FCk93xRV
 SKOFLz+TNm1oCY+WmUlmfZPKnGrVvAK//nB6F9ysDcg8nepE899JSpksH8PYnZ7cZ3BYoT9GYMh
 0559zpRNFP8Jm7HXnzivWEvxsd3af/EsoUTdKc8YHUT1FJEK8odE6L8VvxnXRn/fc9BVOu+ardb
 AQOxEAZeTx+4ZGKEhhHHuZ58UxP9o7vRJYh98iVKe3UE/rCApAMLU007/TJu1IQWpdmEjv/cvSB
 iyhFuysoAU5t7o+XFBae4DoJZroFMSI9Hzn+rRF1Tc4Ii/r8gqJBOwR6a4RLUd5mY1oEZt/yjCo
 MFhRpaSGLrU7FhZwJFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260051
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/16/2026 2:56 PM, Sibi Sankar wrote:
> 
> 
> On 15/10/2026 19:02, Konrad Dybcio wrote:
>> On 10/15/26 2:47 PM, Gopikrishna Garmidi wrote:
>>> Hi Konrad,
>>>
>>> On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
>>>> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>>>>
>>>>>
>>>>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>>>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>>>>
>>>>>> Signed-off-by: Gopikrishna Garmidi 
>>>>>> <gopikrishna.garmidi@oss.qualcomm.com>
>>>>>> ---
>>
>> [...]
>>
>>
>>> Thanks for checking. The only matches I see are in the MPTF thermal
>>> package, which ships"883ROT13Inch.bin" and "883ROT15Inch.bin". Nothing
>>> else mentions ROT.
>>>
>>> I also checked all the ACPI tables but didn't find a codename there.
>>> The tables are here:
>>>
>>>    https://github.com/aarch64-laptops/build/pull/176
>>>
>>> Following the Lenovo gen8 naming, would something like
>>> "microsoft,surface-laptop-gen8-13p8in"
>>> (mahua-microsoft-surface-laptop-gen8-13p8in.dts) work? I'm open to
>>> whatever you and Krzysztof prefer.
>> [...]
> 
> With this is mind it might make sense to create a common
> file mahua-microsoft-surface-laptop-8.dtsi that all these
> boards can import from as well.
> 

Agreed, but I’d rather not do it yet. I only have the 13.8-inch unit 
right now, so I can’t determine which nodes are truly shared. Once I get 
access to the other variant, I’ll verify the hardware and move the 
common nodes into mahua-microsoft-surface-laptop-8.dtsi.

Thanks,
Gopikrishna

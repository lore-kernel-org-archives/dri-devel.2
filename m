Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAA8CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9503810E11B;
	Mon, 19 Oct 2026 10:32:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBD110E11B
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:32:28 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OoRf3256577
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZpgRYqGBJFaTlw0Nu2YxpUpUPwy5exJAI3Mr3Bp0pFE=; b=pUt5B6UtyVEue8dK
 i6HVuO/CQ2g4p7EkP330vUXL7uINxzn9e8uVakLcggpSEawoAGVFCZHTcZIoENx0
 P77BdelwTqWSG2/5bekVj4eKniMg5vPc/Leqec2Yuj/rzZWj2raIh74PA8zIy/Be
 gQfI2GFbflsAx8oywQ1Itkkj4pY+p1zA0Z71zGBs0tdZ9aD0VcYBZe/GmeKKGxIt
 /pKjm+c3LPWTpATqECgS2XkenB5ETNtKTm+azWoLmxfK1OqEgtRzIZZYIkt8BJ5v
 U4EMizY/tt9np+mPs1btFLZk0tE/CtJ99FHUCSaTnkGrhOzJHJqW/fz2/Lkdw6gT
 tWYI5A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8mpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:32:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso70216585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405946; x=1793010746;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZpgRYqGBJFaTlw0Nu2YxpUpUPwy5exJAI3Mr3Bp0pFE=;
 b=GODyfdCxO0kETJcpjSVQSBIsqIuXdBbREdvp6EJbNuoR32Nn661O7arLLuR7hCRZnk
 JU/2jseZikNRi0P3TNmsa0u3+9QBycEGn6l5cjHpv3yMEXG8gCc7EJqBs877mGOUjQlH
 8I5ExQqMgz8E3iiOh7uIgQnZ+7RmRA2OfyVg00Y1ky8bW19r+K1tJOxS8G7nt83UoA2q
 OyLN6g7cUmun/j0I2M52i7e8L7khrxE5cS7HiT80RD3Jb8RouYMrbM5nUfaYixxlgNxb
 yeSCMJNnZUoVT8lwMX4c5r8MBT/YBejaGnRma8PKYe7p61cXnRIuFLkhsqR+CfDLobMe
 8B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405946; x=1793010746;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZpgRYqGBJFaTlw0Nu2YxpUpUPwy5exJAI3Mr3Bp0pFE=;
 b=t6e18ctBeYCgySXp4Are8PCqh7/q/jWymJaLHGA1eFhWPOK3W2x7Zdevq8KiTVWkjJ
 EIKirDSQwXo5YbyxaGxBrhJad66adZER6qUiVyzArcM0JSDTfgD9cvKynQPm3tqL8VBp
 Mrvou+ZwhkmkhD2bQwfqW3DNTPkvoWk61WROFD7NwlW6DxoeNvmCDoDvuTppReBBObY8
 BdqMbZeI2P5xtwJv+6+Ip+CLT7ZKdjy3dg0Nd/Yk0PjxeQsB0KX6stV9UfycAUz001zI
 2JnJYMBt6Yf6+2WRPqtnRDX2RYWrsEAh/5q0S772peA5mSKQDs0dfkfLoGkhoI5wGtKB
 /p7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmqkQH/0ZsNTRS8g1/iJo7YIXLxC5ZVFELvFFHEeq1gSpoGUadY+GVeUp0/nNGctdPU4hMGe4vWik=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK76ZNn4cTHlh2kriQg1cIyP7FJBIz9fhPcNa13qEIKvvo+WyIw
 sof0N4x+P78ZduNqFFah6E9mYR033U7QjsuESw7ezyQYRwf//UEXpLB0HGFFajrfERaRXCtQ5/P
 2NUVjINnvHrR+35eQ8/nroV19md0PgK5tYebKpemixaNdir8lG4H47TG5naT8xeN76Z42uaE=
X-Gm-Gg: AYBFou3bo7zHlBBzyhrW4HirKVxE/45b8lQbXc3gZOM/4AaNoMLcA7gk3lE+whYKYlF
 FvJl3w8rpB4FvfZh3vQSaZUFNOVvIYO3uEPZLLvW3u4eBavmEGJ9YdflXoxAJB67a3YeAM+q/Dx
 uKyXHtVwMvuGZu26PS8iZG1rMeQIgTcuxxtTp062nGZqZOy3LmkbBn4ESu30AsvxbHBxOuAKMTW
 I2CTO08/puKsQU/YNgMfEIM33WexJuMAEA5mNJcV0kUMnqJ5K76x9w3Oho15Kt++zxYJa5gIOCc
 XmUJIybAw1xHLXCUobY69R1Oyv7ygyIto7E8dO+6zNvird0q2y06nWVn9P9gNkEbL8dhK3WA7vA
 Sau16EqZplARjRM3A2TMzlg==
X-Received: by 2002:a05:620a:7086:b0:93e:e111:2771 with SMTP id
 af79cd13be357-93f29beee37mr1334611485a.2.1792405946485; 
 Mon, 19 Oct 2026 03:32:26 -0700 (PDT)
X-Received: by 2002:a05:620a:7086:b0:93e:e111:2771 with SMTP id
 af79cd13be357-93f29beee37mr1334606385a.2.1792405946016; 
 Mon, 19 Oct 2026 03:32:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1eb8dbsm3607079a12.37.2026.10.19.03.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 03:32:25 -0700 (PDT)
Message-ID: <5478c0da-e28b-4ea5-9b7a-f7aef2c7f437@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
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
 <5cfc6414-735d-4df3-868d-c8c3c4a98e30@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5cfc6414-735d-4df3-868d-c8c3c4a98e30@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: K5H7aBDpJpHwaHkE4jX3ISSTkG_jrLwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX1nnjskCx1LEr
 iSl9LQAc/IW/gQvzo1yll8eqftp+nF9DlPukWOOotHiRxbGCdV+y1OeI48leQINWM0op3BFNSOH
 EGTB+BnnTMHNdiXmB+JvuuIeSFnTiUTWDgZF7j2xtuIY/w+4ecgmq7EUIpi8hR3p3XssJE+GNct
 Kcn8KftU4a9dLkUJfPHfaqt41a8h/vD+Rwl27injtu07Eh3GgngI0d8NV4cuDG3qG4CqCrMl/rt
 ASRmyixddRpgE3THO9H7CYzAbKUkG6ni23yzsi7z0Kto/B8rzqo+TFrrDLukR2TvMeDRuD6ecCO
 mWdOsyvtgj7nHIZvFSKmrnOcrCDV2OlCvk56k1nlDh237VyLujI1MrKmyAYJ/nmiL4Y/YeHas5q
 Xq2RvsS34vCPbaWs7pR06Nkh4B+uDt/ErHNqVkfYx1e/jWIg/koO0F/qKE8EDDRZ65Oky+B7Zga
 ofT/dn1tS0iXxxMAnlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX9I8VR4nUMyfx
 tvZBWjLSAImyn2YN1nSaH9rmz/KoWUoF/GjqZZ4ZW7nZJpFy1zmFCZU4ex0/D0wiTA9O+TveNmf
 IMmcy6gBIfIuvjUh5AFaatzzQL/83AM=
X-Proofpoint-GUID: K5H7aBDpJpHwaHkE4jX3ISSTkG_jrLwg
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5f1bb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=UWTLkw_F3LfYAFS6jcEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190041
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

On 10/19/26 12:31 PM, Konrad Dybcio wrote:
> On 10/16/26 11:26 AM, Sibi Sankar wrote:
>>
>>
>> On 15/10/2026 19:02, Konrad Dybcio wrote:
>>> On 10/15/26 2:47 PM, Gopikrishna Garmidi wrote:
>>>> Hi Konrad,
>>>>
>>>> On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
>>>>> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>>>>>
>>>>>>
>>>>>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>>>>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>>>>>
>>>>>>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>>>>>>> ---

[...]

>> microsoft,surface-laptop-8-lcd13
>> microsoft,surface-laptop-8-lcd13p8
>> microsoft,surface-laptop-8-lcd15

(FWIW I don't think there's a non-LCD option)

Konrad

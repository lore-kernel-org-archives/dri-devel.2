Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ADECC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB7D10EA18;
	Thu, 15 Oct 2026 12:47:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB9710E3F8
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:47:13 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jguT1955865
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HpfO9Gqu9uFueM3NL3ptgyrxDHq1TmvbTG15ptsawcI=; b=DOCppP58g9XesA42
 IzTA/UW5or2UmvB9V4Pr89taVGK8r8vfLoATAnO983XeXGrD/ffWQHZ+XnZYtCCC
 zZhuxOs6AouPCZTKqywEr+t3LsB1cRQITcKYU2Haqq9ljE9hAwb9gevOsOoER43E
 Ehun5k3qu99pCMXurt6wTdLjGVWrbF2WitXGEuR0BAbGtBlCYuLZ9etz/uFjQo8a
 f2fMx1FJ3C2hUyhiCfi9lILVoGWAlz6BfDcP6VssNrZ7A7XtdZIvqrhYjJ4wUccP
 2ElQ+h0/WnshHtdcYh4UAHG3g5TDFByvsl4X0m+fZpUiOkr8eiCOc1gnhmw9Xp87
 6SmC6g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdetx4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:47:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so21227865ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792068432; x=1792673232;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HpfO9Gqu9uFueM3NL3ptgyrxDHq1TmvbTG15ptsawcI=;
 b=AZuGM0ieY6aHf7xIBJgoyY30QMXjftknOJ9D4eoG0AJ4i70Rrr/YjDiirN2DGYLOM9
 0mp7bHo5NKdL8Id8dj0yCECR/gmUFy6AQ5vlemddkf8qDKsfo2kEHGXQznFMvnjnYQbf
 P7BE1AHuVD/H7LCM94C4/ySf+YCvx8VhiE1seDV+GXro2eXVmQ0g7pNq/RgiRhfX3MqB
 CJOnxYCLXunpYwgZvZDLn2qFlOXgH/xVp1cOdBwhBiJ5kBVEWze9nxbtYM6GtprpgyLW
 5PxlQoLnnRvEqgIAOXWqK7tR4BXCMbJfgO7+ePkbAdP3MQxk3LGQzY0BynMl/FDy1M5z
 GymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792068432; x=1792673232;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HpfO9Gqu9uFueM3NL3ptgyrxDHq1TmvbTG15ptsawcI=;
 b=g4ctIKy/buzTP2c9Sq1UzteeW8piSwxszf5uzWGge9g057+cgoUhj9M6AB2n+0Kuek
 n4mWyH6OyXqmIa0C2dT3lP/cG4O38nq3fxyCxl8NEVIjctmBunVHRyTxTJlqCNgepqLd
 bUxHl5bqi+qqjZo6A1vDMlE984dKioOCiPWfeydKgPX6NuyydqrHTciDaMm3JViobRWu
 H60JiZKHDACR+LK93LxiB4BgLJgB3CHWMcJVvHnNMnHrYaPReYkVlUGHEnX1ZWFKznUJ
 FbL8NuvIj0xyUockiZ8pvI14ueFNA0FKVEuYSCJf0dndhE63gdh5Z1zxto9vr2pDsRea
 GRXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiVOmQ77dbYEFz7j/hOxl8oW5O6wSJsvxLptQ9UwcPpCZN8O3HHnZbdmEpBAV/Pg7ox3pW5b0nVRQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIBMplb0JDUNUtZ6b0Pmwy+/G7J1SoItLTknaRGCvtn/pcFtZVR
 P3clY9rbR+37qQxmnZgNhB3OMEdN8B6tQECmsygk/lN9VnS8do0xsCU9zTGaJIQ5gfa2SIJt+Nb
 55Bx4W8T0hYej+FUh2un3H16XolLjF09qYX1EebQi/g9mrZmdZ/l1waXPAp1z3e5dNwC+gRE=
X-Gm-Gg: AYBFou1Cd01IbaA2pwS56l8DGa4lj5d6kDJabzmUvWXP+Yw0WAHjkqgcDHM0FsMfx0b
 g55akk1MY+zQKVXkasL8vy54nQ2gc5v3PwELU3PfRCPthE26PL2ZIkuz2NWDdVqutlKEkPnG/uP
 GTQumyNF/uSTwDOfb8rMNKxaupRzbnZfb4G50JAvl0M8vEjBBBbY37r+hmESXxRQ0asMbnN+/qs
 HlfF+cqPheg8Wtry4Zjph9kmEHDs7GsHwy7SpvlsYgxDyGTMu3oQEl2dfVVqnpdxS60AcGUfuXu
 TcYBIWEuJqQK97MV6/5QwXDPL1vCou/k/s+FPlV3UWMz0fH/ReY7CZ0xYcmGc0KsaqfNpCgWU06
 kTtu88YWdn5NSAFtodSff2qII1PJpiJGWRXdD3TMZDyRrOH7goM9US5+qOxr29WHzFgjNIVJNu6
 PBCq12K2Oial2aEvarcI3gtZS9XQ==
X-Received: by 2002:a17:903:903:b0:2df:8b09:93bb with SMTP id
 d9443c01a7336-2e842aaca0emr153739785ad.10.1792068430849; 
 Thu, 15 Oct 2026 05:47:10 -0700 (PDT)
X-Received: by 2002:a17:903:903:b0:2df:8b09:93bb with SMTP id
 d9443c01a7336-2e842aaca0emr153739435ad.10.1792068430276; 
 Thu, 15 Oct 2026 05:47:10 -0700 (PDT)
Received: from [10.149.81.110]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8cb6sm81962855ad.60.2026.10.15.05.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 05:47:09 -0700 (PDT)
Message-ID: <5568fd0f-e412-4f2a-9f1e-729a469da572@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:17:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
 <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
 <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0cb50 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=g9vuQ9wz1Of9mYxFF6EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: z-Gfnl3dWFmM3J88D1S0LRSzz212FhVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfX3Jn2qynadaWa
 mUPbcLICwZ39RiYrBTtcSsBaiD9d1yjqJUBDyOnd52kv9jpYfccLGnMpLR4gn/I8eCrpKhKbL8l
 aYN4e4Z7nu6KObx94Q7u2Ja+G/5o/kTW+Zi/3vCAvZvpAGJmwgDkmfxd+3O9+yWjeOgrKgHiYCu
 yBso72HB/FB75ukB+MhDOqIcsJ62Y02fxroWN+onIfPKAOjuKexCWuXAOtLQ3Mif6hayAIxsyd9
 OZ985JcxShk3ynhq3JBcQ+kt1WYsRfYpk8Ql6yj+ct0A9WV6oPLMN2utNySPkBWgMGscdW3ELSx
 wPsAIOpJ7HltRySfGn37t6yY+ltuouEpJRmfjlWl/0ZMvqwnNMEo+2+ueyymIIhsCGNlwTfnELh
 TbCOGB3t8wLLDNJ3eiV8B73hXxG1fSyIV/m9Za0y/Wikk3eddnB43se/PW7uz6PkHzi/OGcysID
 e/+Z0/59hE726zPS8Ug==
X-Proofpoint-GUID: z-Gfnl3dWFmM3J88D1S0LRSzz212FhVE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfXwkfqmF26uFKy
 BcVtVI628Z3nnF+40t5h9VA8pV8Ei7B87xBK+B/JoB012m++xfPVKx+Zwl5s6hjh9wPNznGX8Ca
 nqSW6/NbYj8KAF30AsSdXY5sPYP8okc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150050
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

Hi Konrad,

On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>
>>
>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>
>>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>>> ---
> 
> [...]
> 
>> Before review, I'd appreciate your input on the naming.
>>
>> Surface Laptop 8th Edition comes in three sizes [1]:
>>
>>    - 13 inch:   Snapdragon X2 Plus (6-core), UFS storage
>>    - 13.8 inch: Snapdragon X2 Plus / X2 Elite (Mahua), NVMe
>>    - 15 inch:   Snapdragon X2 Plus / X2 Elite
>>
>> This series adds the 13.8 inch model only. I named it
>> "microsoft,surface-laptop-8-13in" (mahua-microsoft-surface
>> -laptop-8-13in.dts), but that clashes with the real 13 inch model, which is a different board (UFS instead of NVMe) and will need its own DTS.
>>
>> I couldn't find a codename for these, so I can't follow the Laptop 7
>> scheme (romulus13/15). Could you please suggest the naming you'd prefer
>> for the compatible and DTS file name? I'll update it in v2.
> 
> I can't find any. The LLM suggests the 13.8/15 in codename starts
> with "ROT" based on the INFs.
> 

Thanks for checking. The only matches I see are in the MPTF thermal
package, which ships"883ROT13Inch.bin" and "883ROT15Inch.bin". Nothing
else mentions ROT.

I also checked all the ACPI tables but didn't find a codename there.
The tables are here:

   https://github.com/aarch64-laptops/build/pull/176

Following the Lenovo gen8 naming, would something like
"microsoft,surface-laptop-gen8-13p8in"
(mahua-microsoft-surface-laptop-gen8-13p8in.dts) work? I'm open to
whatever you and Krzysztof prefer.


Thanks,
Gopikrishna

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C510A3D80
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C755D10E95C;
	Thu, 26 Mar 2026 12:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bv7GV5Po";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bxPig6Mg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77D310E963
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:08:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QArPqI220364
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j3uXmHavq943V2Js6d0I1kkJb88a2umuDyIJzCSdvhE=; b=bv7GV5PoYzpk5G4S
 r0TTc4P4eahiRFwNYoQy+tt5/i21VruN+rw6OCgO8MW50pC20QYxZnAY4yKClXAn
 Lml7IIWGBeqiNrSZ+35nf6RgW5Wrg5Bs01yg1ErilqDksTR76792C2Nh80sf2Zpl
 FaZcTOLUvz6fsAuf2lFFyAuK6hpYdt2i/Od3jmaBPrNXdYva0TlkZhBRIvSnKVLb
 yeY3WV8g6Er987McRDhNvnsElc+EHUd4eNH6n1ejGOwBCuB1Mrh8ekXNaVawO3ic
 91TrASsyCr94DEmyZeMs1ma7NL3KlggF1XJLGxwixgnjPs1UPvl6tB4yv3U8jAK+
 TuIFJw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqg76f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:08:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b33a19837so3868811cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774526883; x=1775131683;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3uXmHavq943V2Js6d0I1kkJb88a2umuDyIJzCSdvhE=;
 b=bxPig6Mgbe44lfVEuwY6vjEeX/2AIYgPWrOABKeEgtXNi1RXHFG81b0N+HdbhZ/YYS
 6kqVihYDylu7zZzgV+GHAmwO9+yBVGdQhgbo+2Thm30/oB6eU1iZcsr7hds+2ZhDwTg9
 IzllbIPNkzNn2Hv6QEjeffHy8ZZiOcd5QiVjPgwj9Ycyy6Bo729MGdcrqp0LUD6kALoX
 Hsur+927R9tgliTajGSKgevi4mmAJ+VkuQhzLFPrjyrLtaDD1r72yUA/is1cvP2nTdiN
 s/xtjfA/vRHMgL8m+mje9HesAgSHGi8hEgwLnKDDUaFiAJPYPGlUEjMsGWa9QF3LUu0f
 4BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526883; x=1775131683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3uXmHavq943V2Js6d0I1kkJb88a2umuDyIJzCSdvhE=;
 b=H42X9lCzSk8STf/N32h9gSPWrguHjfwceIU1zIxHVo+jhK9a/z/Nad4YJwoENWHJHX
 fimLXzfCnqVOLz2clJZkjfMogHEfisoh6uggtaBED31atVcmXNZC+I/xCgahBANQu5lg
 Z1trlSuQq9Dr7FpNwOtFjfdCAuAg2UbfMeYYEM8+BUwV/S0cOxaw/GfN9hFVqhZOKD7h
 kDOZ3DEJmV1Ptrie7Sfi22lk7cbZcsmeHrASzg8H7gejqyV0md/1gNQ0sh5AVtLqMKXo
 ft2QAKvUWZ8Nwd0c4uBS1kSCzLoi/trp1RtJ32i16t2NFMTbxqwXul81ZcPhYItoZC3P
 8rkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDT6twBlkTHxou3zBFoQx1U+VxKP12k42az29gVCI9hTyBOWfSYqBey+zZsa4XRMby6F6tE4qvnps=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGVwJc6S702mcIzb6vHa0T6ABDgp4fjTNicuaIc0m9a1VgRGrT
 5P6A8zigsXbIdn3ujc5qSg2wqcjWdpt8pWfWyNHa3fw9Fgs+q15R6pZ9SrHEsHa0rRZVwb6Hby5
 kTju8uxwUsnj1v9y6zvFkdWqgHWrHVl8GPX7BYfhBYTLbrnkDZ7o1iePgkRaVKg0r8VKOpPI=
X-Gm-Gg: ATEYQzz9GAeoTAO0ZAg/Xx/6uOq0MW1CJTM4VUGhLtjobb/dfmwmoDF1tffPGP2Olbw
 XEJRQvkb4J+NLvdHv3NigUu2T1i4wY65BRVDRncrsAVAA7Di5ytk8wncsL9NyACsW8t+ppbcd6g
 FTYoLAZyCSwbY/lexGzvAVs6AMInTniG/3nsvWTB37QEhZI2y2CG+hgG39fypJ3FT0GpXg/Zpyf
 mLTlZKsbaQnz3Jfb8k/KP4bHbIeydi6s5mGJ7AYS8q3KtyEwGB1hhf5yW3Nai3jnVjE/GySlnR7
 hswblRShYtZvCvL19BuPCvDO/da1eQMT4ECV8bmgF0ql05EElAy8z0Ndq7N8MZS/KbxQnxyFG0H
 6WFhvL5iw6LcvRZmqVM5J54sjMgZ0AwfioxgCvkOXD9Ak5QU1+rHYjUbV07XjzhtMGvYRt8Ilw5
 HEnZY=
X-Received: by 2002:ac8:5a04:0:b0:509:2239:8b46 with SMTP id
 d75a77b69052e-50b80af3a6emr75124361cf.0.1774526883214; 
 Thu, 26 Mar 2026 05:08:03 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:509:2239:8b46 with SMTP id
 d75a77b69052e-50b80af3a6emr75123861cf.0.1774526882726; 
 Thu, 26 Mar 2026 05:08:02 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20218682sm114362166b.6.2026.03.26.05.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 05:08:01 -0700 (PDT)
Message-ID: <87943afd-2601-423e-878d-36b69ac3d6c3@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 13:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
To: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-3-d4b8ee867de7@protonmail.com>
 <109d21b4-5d16-4689-8383-ecd29bbbf8a6@oss.qualcomm.com>
 <7wYxWlqdcbL3ANB9n0g4t74x-dwE2yG4CmVw9TwGNmwARxbT5WsdG1fpuIDSA5ab750Gs8OUBwmVa_nZd065guKDJueytb1AmlQ05__IzmU=@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7wYxWlqdcbL3ANB9n0g4t74x-dwE2yG4CmVw9TwGNmwARxbT5WsdG1fpuIDSA5ab750Gs8OUBwmVa_nZd065guKDJueytb1AmlQ05__IzmU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4NCBTYWx0ZWRfX22A0eKdWwhSe
 0460QrZRfv8x5tlkBkAZHuCfcLRyowIZ91RN10y7LtdQfjPllMDtPLFVHT7HYpdFrxhpirSmepv
 U0oE2E7Vir3PAGbxQCmSONs0wnaRpSwhgz69Asd9TiKtlRzIqHi5M8dxLz6vaqq6fq8XBoSx/V5
 qP79NkWb0K9+eWxLDESDTM7oZT1gFAkUHXaEMQWoi2hcXPDXk9KHcr/6fD/F7zh/OrBr7HTL/ii
 pp5/cEWzh0YHtFG65zfXZjYgJFtZQJoN2pgbSq8JBjdNmBkimsllmC0/hCMBFGddSpI7fRlRUYj
 ljkGyTNh88h/dOR4ab9nDxPllZqx6JvuPhy0Yhw2mbneGclIa50/DAmFOrHHTgKrte12f6LofCi
 PdyNjt/tMe/tufuYZ9WnShphsvIKxR0pus5FLAefT55AnQkaXqnqvNGzEl0KCB2bz7/qAcXOE3g
 PPKX6eNqFhLuY5AUlTg==
X-Proofpoint-GUID: 4tvhK-AyPAXkky6evjC5M71i0UbxKWLl
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c521a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=sfOm8-O8AAAA:8 a=XqikXB0HrO5LkgwUDCoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: 4tvhK-AyPAXkky6evjC5M71i0UbxKWLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260084
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

On 3/24/26 12:18 PM, cristian_ci wrote:
> On Monday, March 23rd, 2026 at 11:52, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>> On 3/21/26 5:23 PM, Cristian Cozzolino via B4 Relay wrote:
>>> From: Cristian Cozzolino <cristian_ci@protonmail.com>
>>>
>>> Add the description for the display panel found on this phone.
>>> And with this done we can also enable the GPU and set the zap shader
>>> firmware path.
>>>
>>> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
>>> ---
>>
>> [...]
>>
>>> +	panel_default: panel-default-state {
>>> +		pins = "gpio61";
>>> +		function = "gpio";
>>> +		drive-strength = <8>;
>>> +		bias-disable;
>>> +		output-high;
>>
>> This says "by default, actively drive the pin not to reset the display
>> panel". Is this actually necessary?
> 
> I've tried to remove panel pinctrl stuff from the panel and the device still boots/works exactly like before. So, have I to submit v4 without pinctrl at all for the panel?

No, the pin config is useful, I'm specifically referencing the output-high
property

Konrad

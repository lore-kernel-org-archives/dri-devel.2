Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06DB606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aLcrDXCU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hQIc33jR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E66110E35E;
	Thu, 22 Oct 2026 09:29:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA60910E35E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:29:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M708X83517483
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 asHkksXryHP8fncE+DgQVjyvFM4/Pmm9WIL38dhPa2I=; b=aLcrDXCUR1JjXUR6
 pH3vOrOhX9wQJyVTB6yLshBTnlXqgYdWRavOFu08uBmsxajGWGgVWzjWTyUMHSyI
 eiUdK+lTmjUbkBuqYavMS+21sJ22tqqJ26m87E6NXlU2QC2f291Evo6cvJmzQdEn
 Prg//kZBCb8KxrqZHHM1s5/10emrzAlJ6ygkkZgrpx0O5nEygAFW6VjhmawptLPA
 3yETgMyGeTxSloGyYPbJFUFEVD74gwxaAK8MErOatvvRx9UACM+Q1vJSMFZV+oDH
 5PdALBGOrBn0j86PCB3d4A84LzzWKpVGVqZdVJF15NgD5MbReHcPFjIBit3xkp9S
 3D6Cgg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bhnub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:29:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2bdebfc5so46808185a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792661364; x=1793266164;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=asHkksXryHP8fncE+DgQVjyvFM4/Pmm9WIL38dhPa2I=;
 b=hQIc33jRBa9VeEqRevF0hNb42yBsthuuYPO1fvRXSxO3NckYkMJ51EA0R3pkej5o+H
 QPJSfuK55mHF6dl/WYu/khaQ2J5hFWTK/ZflyWR5R0DthN1uUCZ9O6n4yXVCqLn2TNmU
 4WscMHxVe2VIlE09yLU3/dSmYpC3Z/QpjJLXV638lbhfR7Pq8TLmj/h6EjbkZJmlKvv4
 x3HK9d4nWIZFpt/hxxff15SkDNBggaEVqUdi5A4RGMpcPYdzRlAEfHunqInZ1v2B9uD+
 5pD9XgvyTxWcDloGGd1jLBL2kzWFV6TMVPzhCFzLNKiUoICjuE+0KVC7VelsnRYm749k
 m8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661364; x=1793266164;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asHkksXryHP8fncE+DgQVjyvFM4/Pmm9WIL38dhPa2I=;
 b=Yf+SOcZy/9T1yS+o0V51oVItKPxdiW0jILw9hhlYnozXyueCWvocfiEGhQyB+R61xv
 sE/0929+Bd/CXMuIPkZm9lpJA+wtzuhucXqwUX5mscIQyukt7EowDmh5n3y+ZmH7fLWm
 KO6Wqi+nZeJZA39NZJxxn8fRlswK/kziR9/cb0a1baThZyz9WNGsc/8poRVuPlv5c3y/
 9baoBUHvFO0Hq3XWxg+XjaDmTe3J+B5vd/VE0aiChW7ZrfJvKMlst3qKxTrUcBgJCoY1
 tXsItAjdPT6ezJ17Ew0a4qMVX2VTz7esG9nmlX9fr5BMbfqWZGYJj11ontUKesp0VI6l
 JKSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS/ZZscjz0iNHnhDhub27oSgxFE2BdpMTumuzT6AmjskmvLsY7NshTIuxMOtzxrYLAMjwHnnR5VhU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIu4dcCvOg3IvWREoYE8TRcsW3zFlCTRlcJXsFhFJEP6JBvMP1l
 GxbAL+i2psHDmHdD+gh9y5dLDCe22c0mNlAnUuKS+mKX3BRBvO+3mz3CLiOFs0NCx6+rHd3KOaL
 5CifOpSMVRgZDU9ckM1odv2P2VrLVq3r1ZwpBdW3AjJR508da7On40Y9h2fBXIuOZcXRSJH4=
X-Gm-Gg: AYBFou2RwPjV1meoBqaALFtSfupYlNN9WTl2/Z1sm7DfgkVHlR/6f1BIzSdP3SFPEui
 87afepXzrjreTMc3iMitE4W6Y2uT+7Ueoj8eYEDSkUj/bXOH43AyHUfVJqyc8983vLwBv9c9ESG
 7CDHLZVyemf6srEZLLQr+N4TDvzO07e+YK90z4RYKB0im9oibKPGG+LNOJZ2fKxXBGUU1k1rBbD
 7Q7Zlf8b66wj5STdi/s0V7cw8bZhkef5iqIsOAW8wEm07tOV+yJTAC0CfEKaunO6u/eC2U6DnUJ
 ih8wQ+J73diHuDElPDBpTKelggPifJaXAut/xS2/VwhtXK1b4iaK/28uAPGqnJjvcOCwPz6cbzE
 A/AevKR3K/F6gtm1YTslBaA==
X-Received: by 2002:a05:620a:4511:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-93f57f23fbamr994611585a.3.1792661363767; 
 Thu, 22 Oct 2026 02:29:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-93f57f23fbamr994607785a.3.1792661362985; 
 Thu, 22 Oct 2026 02:29:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a1eecbcsm87380366b.7.2026.10.22.02.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 02:29:22 -0700 (PDT)
Message-ID: <bed18f22-ee37-450f-8b56-d3f21b85c3cc@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:29:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: sophon@radxa.com, Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
 <3bb9a390-3b5e-4321-a25f-77e4f5c88f9a@oss.qualcomm.com>
 <C782C697D7D26A70+05200ff5-c7c6-4425-ad15-67222a2ebacc@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <C782C697D7D26A70+05200ff5-c7c6-4425-ad15-67222a2ebacc@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX8lTs8tMCOK1y
 Lrb42rN/md0snieFl6dMlB7Wh7fun8i7QBV4079fl3fJeFMvhKl+p2DHSMUv/Lb9ZskaEj7y4IG
 bes/q8XFroO8igUnvqBwwpnH/LDxKL/JCreDn7CRYEi9FNDafA/hyOkXKcsmc222VbtgloTibxX
 LC36+6xnJm7EnNRtlGFml9m4HD2J/WSZzp7zyrsrZObEDVhgvHFXvGXY0zY4ubhxKoQRGTA2/Ye
 QAr6xqiOW6pBZ2S4QmkgsVD1R5vB0P1ZANcjSgnGDt+0paNXChOLWF0UQ5AbopiUTgtPgoNPf/F
 ZvcHNrmEEZVb4s7k/ZZKmVk7XFzyRnGAdgCxJgS4wu1WNiffVUdZYyOXG1N5YpBKqK2RF/kmgb9
 f48KF8KM3By6VN1u4CZWSDsxoaLjyjjSEY0JXzEaUVNN+9fpK/WzY9jBWCflorsj57/W45OQVFj
 m8O4vb9ZWLdab+F8kKw==
X-Proofpoint-GUID: qHXZcMxm00jdfr1oN5RWYN56qPe3_PTN
X-Proofpoint-ORIG-GUID: qHXZcMxm00jdfr1oN5RWYN56qPe3_PTN
X-Authority-Analysis: v=2.4 cv=CMy/zhrD c=1 sm=1 tr=0 ts=6ad9d774 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=XKtpnFXEKgIDAPG5UdAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX2o+Uy1zxOvw+
 TAidSSTgmql0rsyO0jHtDhxiFXBHQ2pZ4e/8Qx6PL9LhCz56jibmVoBN4yvxsWmCzAka8TWNdI1
 iw6un2L99WnkvfCTdboAiSoP4+Bt6Lc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220037
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:11 AM, Xilin Wu wrote:
> On 10/20/2026 4:27 PM, Konrad Dybcio wrote:
>> On 10/9/26 9:55 AM, Xilin Wu wrote:
>>> Add initial device tree support for the Radxa Dragon Q8B,
>>> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
>>> SC8280XP platform.

[...]

>>> +/* M-key Gen3 x4 */
>>> +&pcie2a {
>>> +    /* Place ECAM and BAR space above 4 GiB to accommodate large BARs. */
>>> +    reg = <0x0 0x01c20000 0x0 0x3000>,
>>> +          <0x0 0x3c000000 0x0 0xf1d>,
>>> +          <0x0 0x3c000f20 0x0 0xa8>,
>>> +          <0x0 0x3c001000 0x0 0x1000>,
>>> +          <0x5 0x00000000 0x0 0x10000000>, /* ECAM config */
>>> +          <0x0 0x01c23000 0x0 0x1000>;
>>> +
>>> +    ranges = /* IO (1 MiB) */
>>> +         <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
>>> +         /* 32-bit non-prefetchable memory (256 MiB) */
>>> +         <0x02000000 0x0 0x40000000 0x5 0x10000000 0x0 0x10000000>,
>>> +         /* 64-bit non-prefetchable memory (3.5 GiB) */
>>> +         <0x03000000 0x5 0x20000000 0x5 0x20000000 0x0 0xe0000000>;
>>
>> Please drop this change on the board side, this is SoC-specific.
>> Likewise for the other ports.
>>
> 
> Ack. Do you think this change can be applied to SoC DTSI?

Yes. I'm not sure about the extended ECAM thing because we seem to have
never moved forward with enabling that (oversight?) but in general:

PCIeN	|	base	|	sz	|
-----------------------------------------
pcie4	| 0x4_0000_0000	| 1024 MiB
pcie3b	| 0x4_4000_0000	| 1024 MiB
pcie3a	| 0x4_8000_0000	| 1024 MiB
pcie2b	| 0x4_c000_0000	| 1024 MiB
pcie2a	| 0x5_0000_0000	| 4096 MiB


>>> +&sdc2 {
>>> +    pinctrl-0 = <&sdc2_default_state>;
>>> +    pinctrl-1 = <&sdc2_sleep_state>;
>>> +    pinctrl-names = "default", "sleep";
>>> +
>>> +    full-pwr-cycle;
>>
>> Hm, is that something that comes from the controller itself? Should
>> we advertise it on other SoCs too?
>>
> 
> It is observed that the boot firmware can leave an inserted SD card in a state that makes the first Linux enumeration fall back to 50 MHz high-speed mode. This property allows the MMC core to fully cycle the controllable card supply after voltage selection so UHS-I voltage switching succeeds reliably.

Got it, maybe let's add a comment

Konrad

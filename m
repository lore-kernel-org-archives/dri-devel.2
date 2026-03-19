Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C6D108E1E2
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DBF10E96C;
	Thu, 19 Mar 2026 10:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVYmaXqE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIO6jqIn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94ACD10E96C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:42:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J73w7M3771110
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j6Ckq6EbrjkZQ8EXCi0UoQh+NfXwqejA2If5XX47JQQ=; b=MVYmaXqE+tZSlfgC
 /oQnNfAAdrsYvw04K0yLF4TxdGsBz5jlVwG6ZMIs+OxBBlqoBSKVhMwW/bwAHMfm
 dlmfogtfu8/B2E0rXiLd35RsyvjYJnif0KXuHvwwxKP9C4Keo/L6h98SiNkxc16U
 UgG/wdU5AsHjKO+uvHvh05+CXEAXKbjR96fCn5OyzL99Mut52CEv6a42xH8bUxc+
 wAAdQhLYp22Myv0LU7InAkanwHsH2gSPoSnBJOkAUBZlxwyTSRPM3k97LZRp9J6p
 BzmhjMXcBJyPVqYjed5tULZlfE8JQKaxHXmkVQMvy4qwjICT/zb9+gDGMKysAJbt
 I/vt2Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r9dw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:42:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89c69c8dc7bso6821506d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773916950; x=1774521750;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6Ckq6EbrjkZQ8EXCi0UoQh+NfXwqejA2If5XX47JQQ=;
 b=BIO6jqInE1u/uH858yX0U0WE1Ecj8sN6FPi+Qu4Hx+Uh1xFmgYWpvw84xHfcmG62XJ
 QtLFQgATMnhB7lqTTs0skQLqdOXST3v9sCRl3dvmkTd/HyDshl0dOQTqhksWAAG4g6oq
 9COTzZGGlrccEd4dTa2+3GAhAiE6WSoyf40Gt3JVC/jCPKpP5wk2rdhTf3R1IpywIWwS
 2QxcNSD8FwMqlfhC3KsfaCAZ6jCxOLwiKPGpjsAqXSEY019negOWq2a4yNFHGEpsSB5h
 TaPW/llQ4+M0kdrn5sCn6lVKEsVpz4Ov47gl23WrGjiCroy8KjfWKj7Gchoer+8y9zld
 RRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773916950; x=1774521750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6Ckq6EbrjkZQ8EXCi0UoQh+NfXwqejA2If5XX47JQQ=;
 b=jQkAmGPZv3zC/8kyuJwIN9KwofVwp0MuU+8zjgur6gfkuE/cTYrNJF1cDFDRKvjlsb
 dQ7Sik77pQDGVqWli/2XroVcTqKCj9ce8Zvgat+KhkIqfJITLbEGFPRWhMTAkAwd3ZYk
 Bv8CnUQIN+1Joh+PNrsIAXyDXw2Jwu1yz5KRmaKOHT3BxrbiViOtBTh/a5/m48DkwPUv
 kR1xkD5ibNO4A4LJfE1Xx8KKU6k2ZpaC6n8ZEDUeuFYbweJKkzmLTI/yvpHwwWaROyG3
 c7rYgjZa4Bx8WAYtyEIHcH/iEGEypk5SDfdJWSkn5zGeCQsrzSPi8omuMKnx7l40xMHw
 W4yg==
X-Gm-Message-State: AOJu0YwDfbch3dJt/HQ1RiqDci9nR4F1G2NR8worJJrpyxVtdUQd5+M0
 gN7M3NqNbh+GMD6srmpOzHPLDzBV0W3/y0uMOZ/oRRGmqxYi9tY6eyfV4ayQ9mxuCz1xOuvKXVZ
 5S9bm2hSVH+9QUdMinAZh16Yu+HSmnVMGzI4ucNxvIOEoN/xUAqwMXJb/qVxVEWAgp9UC1lE=
X-Gm-Gg: ATEYQzy5ESrham5c2SZ0nJUCdpjyNKHqVmA04NxWqdQ+EZ6trqDgItk6BHHMPTW07S2
 IPyCxsSjDpu4tX5vGFrhZU6AZPDWA1dsK6fKQvXwXrs3lZqBphSIam/tp4ucDYq8A3ToGVkigL+
 V5mb5zxqpdCav7ARjGwCcbSg0giAIhPNONKFtcpbDfg3/6cWgJlMPG+l22tmyQejhAnyk8rtKLs
 x4GVuXeUz4LzLXx7Pgm92+cJa1d0K2KKHwRfCsqU1P0t/HhISkevccSF1zwq6dZjFU7r9BZxyOk
 8HoHVezociU0Giv4tXFObGpREv9uoKqXDHU7VTDrKb7gfBgd/BmM0o07jGCN29BgMjrxikX43db
 grfIhKjM8QcynQtnHO9LEh7kG/eDySBazrY934Cc9VmogGRXOAJ2Mz0W6oSebSKfPJXhoiqLOB7
 7jPUk=
X-Received: by 2002:ad4:5bea:0:b0:89c:534b:735b with SMTP id
 6a1803df08f44-89c6b4beb0emr79650406d6.2.1773916950058; 
 Thu, 19 Mar 2026 03:42:30 -0700 (PDT)
X-Received: by 2002:ad4:5bea:0:b0:89c:534b:735b with SMTP id
 6a1803df08f44-89c6b4beb0emr79650046d6.2.1773916949616; 
 Thu, 19 Mar 2026 03:42:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f1686b7csm427117866b.31.2026.03.19.03.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:42:28 -0700 (PDT)
Message-ID: <c9056612-8944-4bd7-863d-7632be0ed79d@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 11:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 touchscreen
To: cristian_ci@protonmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-5-c1bf8917449e@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260318-rimob-new-features-v2-5-c1bf8917449e@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Xakk81P5MsJmlxpar_g9q_hpNCtkmQSB
X-Proofpoint-ORIG-GUID: Xakk81P5MsJmlxpar_g9q_hpNCtkmQSB
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bbd317 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8 a=FcDylz7_6oNKbyFHn_0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4NSBTYWx0ZWRfX34P+nCFKOV/e
 J781fSciKIjdoLRzmDktsRhGImAnVgZp6K53u3EfVDGM78BVIVAo+08Niq+lJrbfkvGswNy5vkc
 rk9VhLyImoI9CIrRLOV5x9sXChdRHV0TWAqDYWSBrlYhgDfeSP/paaAlosh2l+prNyo9ubp1hTX
 B7Xs44o6LMq+lfK/Td8tmwfS4jUiJkzxfRTmnqeo8sw50pQ5wOj5gEZba9Uc2FYKvWpeFI2YzkY
 afnkVFj7OyNaq5OnVuF4P7PZUTwfhf2wLi2BBxBCXFsMKo4gBtpmyVCVByyPKdsvWcOaLWYQ0Tp
 C+Zuh5nZhJobCIubQ4X2xxrB8Hu5xzPFAZFv5G6cumKsLBGBfoXi1S4GjNToUXLuNYJsMbjTq8H
 DiE4gId9GJEpPa8PO9TIDUWM0cgm41ddcDFMFvYYBxn6GyVvYHEaZ6w/ON5MtQy1/k3c8TW6V/o
 14vui7ZN7tj2XycZfCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190085
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

On 3/18/26 11:28 PM, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> This device uses a Goodix GT5688 touch controller, connected to i2c_3.
> Add it to the device tree.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

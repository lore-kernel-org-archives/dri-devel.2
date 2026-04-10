Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CC4F45A01
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259C110E9A0;
	Fri, 10 Apr 2026 17:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrPr5XbP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xow9cwgp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B2D10E9A0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:08:11 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AF6G6E3760345
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SSw6uo7wQYRFUP/Y1wiTkctP3k+hXzw1+IVpWEt9h3c=; b=ZrPr5XbPN/A5E/Zf
 +FqrSJToxNlTn12UJhwww91gASUw4GeapYqdC1ztSZzneu8+iW10tUbQv6Dg7Ioh
 yXBEHtqlN+FVg4Inh2NfEJGJ7XZsWXS2/FeVGFLs4vQjzovawH7RjVZVIiSqFYjM
 6Pmo1jic4wmlt7Cd8AUu+QTmThYDWe0beGYuMvVkceFsV1CCWVdiD5a8wPJTtUCE
 ikBUIsgiyjB/v4KijX+Yg+F6mf5mpwYKRnB1E6tbXLWhL6hOEG+2iRc+2zC72MDa
 B8ee+q+/Okrm/tj+3hM1iZ3r/PUowgXAig22zViRzem1+o4VBc65QyqzcZhFD8h8
 RauIVg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4df3j1gc32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:08:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so2972585eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775840890; x=1776445690;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSw6uo7wQYRFUP/Y1wiTkctP3k+hXzw1+IVpWEt9h3c=;
 b=Xow9cwgpDSYZBiIWviaKVoc5f8T6gwuDe6Hsr94IIWiIC2KlLbug4DpUir/ClS3f+B
 bgJwSZscIWpseaP7nKLYJ9d67vIgzSJbJ69UjwJ8MIHnqqy7X85lWm7WQZ2qFBXnV804
 IDxSDx9UPLCGtXs6GEe8oHfUla1ehpsN5ypPVh6nyc3FGrFVGvtVxgXRoveBdvLY27+O
 px8cbCrPJnjvUjRQ2vuNPPYprTKegi3xoyrbPS/1qZLh09mSmeIi3zphmgr93eOi2LbC
 W7iEwRNwhC2ktpos2HQT7Aspo5LpfWV9C+sM7xwQNeJjRcb/fHRhrTkOntkAal/fmjH3
 L1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775840890; x=1776445690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SSw6uo7wQYRFUP/Y1wiTkctP3k+hXzw1+IVpWEt9h3c=;
 b=DpWw7un4MLk+C0y/G4qQTDFpn1OWyglRtnks6GGloxoXGa3oq8wweYWSv+N/DPGQ3L
 rZZEx33mpXThRhVLC3Ivvf6rW9wZgOu34txWXbzoNygUHLE55KWMHuEvovJ+/Vcd3lTM
 IXQNGiO8TRpXhRpqNYn1YEZPMZGRhpA6K6lrMrxCzzRp5tm4ocPniqhzT1cpafNCsXDF
 C4eGrJvxc1WwhM0Kjkd5l4ubJXh9FlQn0VEmq7usQ3E2/filJEzCDCJqNLIIXnrDL5Os
 v28yHNaJx+EmeGbVnSGLTk412NqoB8fl4Vmih08VtuPcANYZZ35ClMVYxkrEd+dMvMG8
 zmNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVehMUgVlHxsLHXjTTpI3OmwUNP+1YY4yorjmMfzMskdD+tkycHHtxsienwUfrnfAMUAuhE6MOVD3g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSLs/gc4V8ud/QmUx0Q48Ktxj5PgP9LhXX19T0e6Ay4fFv0A0n
 wx6FSwiKsFiHr+EjBrcd9Ypw3iHuqDIv7lECZ+jY/zopH74slotoS2gxQWKaGLgwafxFZCQF/Za
 OvxTXqrv8eQDfvHVZA/Gp0xRwcBPpuOcRZf8aB+BU8nPZOS4K4Ix6P2B1w29gEsr4VvBOwgk=
X-Gm-Gg: AeBDieuVDyFzVH9f/Bzhefb/OWCqsO/QW9+X+aKnx92mX1XMITgDgkzRzP11amT6FJh
 OoQZ0mpNJ8CjuC1JwAdRCTfO2SW3UW/4mBhd9dSqRz8F4HzX85/6RHhvQ6ybB99g6q0T0qVo2gG
 SORp61tA2nZBkEvuNz5Q6OCOdX/tVBg9mE4a/Meyu0mYbJFVm1xtBj+WCKPF0FY8ZFOzWjFWaE/
 JHmNDY8ajayQsZBKVB+Il4EVej9RVtoaqal+fPgvx29lwL6IY3xE6Z1jhLdy42WAAmY7c1Y823Q
 wC99pQYhj9F0iSPEBwqAeWsDEh0ztjT9joDrReMIZrXWzbiAbz0VMDrgwq0SWQeL2lrf2m0Y5jj
 Z+iboKGXWE+fxxTM3g/d3nu3+i2gtrnnpbF7uLmR0rYpPzgr20hX8dqNatds8aHAUGwxuuEEICL
 A=
X-Received: by 2002:a05:7301:1014:b0:2d2:d7b7:5c6e with SMTP id
 5a478bee46e88-2d5876a0692mr2102068eec.8.1775840889559; 
 Fri, 10 Apr 2026 10:08:09 -0700 (PDT)
X-Received: by 2002:a05:7301:1014:b0:2d2:d7b7:5c6e with SMTP id
 5a478bee46e88-2d5876a0692mr2102040eec.8.1775840888986; 
 Fri, 10 Apr 2026 10:08:08 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561cd2c09sm6239376eec.18.2026.04.10.10.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 10:08:08 -0700 (PDT)
Message-ID: <7755ccdb-54de-478f-8f12-98c6dac03e8d@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 11:08:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: fix incorrect counter check in RAS message
 decode
To: Alok Tiwari <alok.a.tiwari@oracle.com>, maciej.falkowski@linux.intel.com, 
 jacek.lawrynowicz@linux.intel.com, quic_thanson@quicinc.com,
 carl.vanderlip@oss.qualcomm.com, ogabbay@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260410112015.592546-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260410112015.592546-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2MCBTYWx0ZWRfX/XYEZVpPnXny
 kqY1LubOc3BBCHn1fS2S9YvbiUkOh9OzLYMy+k8uM2r911NdGz8TW/IBPZcHKs28q3n6T1to21t
 lF5ZlrnO2C3zl2D2OC9H5g2oy8wHOcwq96kF4/eaZmfIQwByB43Hs0+KuyzAWAUJ5qfeTy+qEjj
 CyGo7mAtszqcIIbR74LmJjmfxLyVwJkSJBtlnrCaXl4FTHV2ROe1c2OJOK914a3ns5mmfV0WpF4
 fMxl3LeC3/bSuOyj5DSRpYY1ASvcGRlekIuEzsnUEb4MEXH6xkKiwh3LT99n/zg8nTf4ZXQRnwu
 +AP+TPPuZA05lQlev/MbM8DrOqcQl3xH+aeJA7Iccfmr46pyjAwslpPzzwoW/E1enlJ2IGeNatq
 Zvs7BcI6eWIdAUgsHuW4a1bo4IdCiU2S51k+SWyKhFwKK9FVdbiQ1Da5wYMBPRBeQDVuos5gBnP
 TPIE17t6gzd8/q5g5NQ==
X-Proofpoint-ORIG-GUID: CdCX7vETGdzyLRoliU2igYVOwBLGsSmj
X-Authority-Analysis: v=2.4 cv=AbKB2XXG c=1 sm=1 tr=0 ts=69d92e7a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NFNAc6_Cs8KxrqNOKKQA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: CdCX7vETGdzyLRoliU2igYVOwBLGsSmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100160
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

On 4/10/2026 5:20 AM, Alok Tiwari wrote:
> The UE and UE_NF cases check ce_count against UINT_MAX before incrementing
> their respective counters. This is logically incorrect and prevents
> ue_count and ue_nf_count from incrementing when ce_count reaches UINT_MAX.

Nice catch. I'm curious, how did you find this?

-Jeff

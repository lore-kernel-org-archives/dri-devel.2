Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BBFC5DF7D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 03:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0F510E04A;
	Wed, 19 Aug 2026 03:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2ifR37d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLKrIO2k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E45310E03E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:27:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lb8g3508014
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K9MFSVxotXlCBa73yynGBBxMfalpY0DT0tWa7BXWNpg=; b=B2ifR37dfY5kBpzw
 WsZwYjey3p33qcNKTDzEP4pb+Diu+wJMM2ndmX85T9mU+vlzbm/KlVat/fqqf7mL
 327IeHZp3PMbJuDTjZ1pSVA/2ILXdK6hW5pscYGW2AviKN1AoDS7+1ajRl4XCyTU
 aGUzlP75GK1TfZuo79x4IzQgxgWnbUBA5dFJqGjcCLe1mXCb3IMpZbtckYyrTPgo
 g4H6yg+ERZXQG85IiYorXw857LtUa5C5kBT+FExQfmMGCo2+8F3EA0l/gEFtqrfM
 JXw/xjNPyjMwLGLFZXvplpAyfFzP8KZE6atIiRjSai+PAH726r3KIk2BWZqHNlRE
 xGA0BA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm92y1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:27:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so10424085ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787110051; x=1787714851;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K9MFSVxotXlCBa73yynGBBxMfalpY0DT0tWa7BXWNpg=;
 b=XLKrIO2k2Tw91vbbW4u3xn0ulsjd/fQJVXZCsaxB3gYZ+WH02L6AZoHWScc6EgXxyv
 1rjOBB/010ltMMiCG8EfK5L7U+dTDnZ8wRwti7VeG1vCRh+IuLjPXK816adrlkp9rDnP
 8K3WBiB9Y9HLztllSQW3STkXiLz+7xKB9IjhAUOcV40lN2KzvW7BUvr+7oykv1r3e7Sz
 EOQrUNpWVpMQwlqGFYNr635UCEiXKImbyz1UmB877hi7dpYBCTV+Fr+EU8dnyQpslgfK
 HERTxd5OsjJpZ0HSGOvhZrzbvek2Spuz+JYE3tdcAGlMxNZzNZxR6tvo8emH0M7ZUfn2
 H2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787110051; x=1787714851;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K9MFSVxotXlCBa73yynGBBxMfalpY0DT0tWa7BXWNpg=;
 b=ICgo3Glxnv3LVdRtZ185hs/ji1S+YGW0DGeHMZmPGSvr/frbYZcYBIXy547xGRmtRT
 AlEoYDTHxp2fNs+o3NqSbMzDW3I3cYP/s4ZxHj5n9ZasvFiOMf5EO1n65MjkcWU//6sF
 Zhq6xseMOGXpKX+8VEtj4mEWV7IBUZMUvwlSfhxRieilimY+/+XBq4h6rN74F3O7OHJC
 S57TZttz8prpIpl4JJ9NQYjD3qpzKVjuKmSY8u4alTDDRF7vr7PNYn14U1n9fHK7i3uE
 R0OyiQHXBKTRRi7HqruN9Umv+AaXNG6Zfgc20aGn8b4aGPff8rWdpZEVlyY7R2oQV2kR
 f5gA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8ksBdRKo3C9ujla1bguFlqPDe5ARsw2DkTA6jOhdf9Jj+Y9e5/JddCpn++0Dpsym6xCR9ScgMh+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIqKHKO4SbRHlO4Rz/DYzqV9ZlMd36xVXxS1HRdglWX+oYJMWC
 QlSVlYOxiNY2pQM7PS4zx6IcHR+Poh6ccC2jK2322yJVayxeCMMaUKMU0+SCKLW1G/QZ1Y8AlPE
 zCyY7VYjbJqNaAjncvqEiyzld2/fFWZeYhuqJf7YBMLsn3cUjUIGRdJTSBmSduQFRH6mtcAw=
X-Gm-Gg: AR+sD12qsJFv5+gZ+vI3jSsjfWh0OKXjelyg9+5rQcAWeD6JRvpTxve7AkLiRlHVF4T
 w2ra4e/8MMk3Y3FC8hhucCQNv/mXXXyHpToBjsjGnd+Y7DVn0l+5WisNteiYSXPbXeGm79yDKFh
 aBs0o2gMdgFa7yXBm7lodTVUsaQxeWaiCV1FgE52ZzE+bQwKRriEXWlDW48R8c3faph90to18nF
 mWocEqWYEgp740bGsJ+P5EGldCXzn9TC2pKSgghwNJ/u8Ri0uyB5hB1uV56qSZzWjZ7kW+UdSP1
 6DnxrpmeArowG7OU3ALMh2ZPtuTZ5ti9F+vd7p+hu96Kx/KZxOYQ/Ti/M7BN1bru4UHOJcZWi3/
 TW5OBLtG9eIvQhQYpjJubrFuF2+M=
X-Received: by 2002:a17:903:b83:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d5fd5eaca9mr31892855ad.3.1787110051013; 
 Tue, 18 Aug 2026 20:27:31 -0700 (PDT)
X-Received: by 2002:a17:903:b83:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2d5fd5eaca9mr31892105ad.3.1787110050597; 
 Tue, 18 Aug 2026 20:27:30 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb49755esm23186825ad.17.2026.08.18.20.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 20:27:30 -0700 (PDT)
Message-ID: <e8704537-90dc-4774-9fa0-56f2e8b63f0b@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 11:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
 <db2a18aa-f5fb-4ee8-8747-05fcf740749f@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <db2a18aa-f5fb-4ee8-8747-05fcf740749f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 18teJJk2XHsfcRKX2BmXJ2Q3kzs6W9WM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAyMiBTYWx0ZWRfX2Rd4YShwaGmy
 awi6ecsRHinxhbftbZlzUTFrBEkw1F3BiSuTsMU3ZxZGdtOsctVTPbutkYiXx+oQJlCeNp6q8i+
 ANuRrS61KcznDPkT2In64kpjtXKDJY0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAyMiBTYWx0ZWRfXwekUzgQ+0i/j
 LvHV+P1OyaG/TKrUbJmmJ8q+8XFQSOKnj5t9JtseLxw+P4z6k+tcHnZr17hJfOGkfJIuGONt3u0
 MwHGLxnuXtzLOPMwtE/D9NPH6v/nMMoTWq/Nl9O6DzJN2btJM4UrnPBgF7/3VPYRJJP5L8wjK74
 H6A5Ewv5Ap4sixgCVm7Jeli0SsoP2nYWnc3/oQfhy6B+bLdAeOq7L4sOesqvbtRaAhbP/Xlkmc3
 tQCh6iE0UI4zXm9AJrOponLgY+3CIK2clOCxX2AkuJlTkxzllth6eEzkz+7/oGI0hP2e2wL4Ypl
 0L5fWC0L4buhoyjGkFIPq9gQk77196H3VI+IaxGazu6iF+xK14vEApK+dxxXr1c0ruAuxubEHtE
 GyGL9s4Vrd41sUZKXzyRKeivvGzXqxWK7+vDH0X2w7DOVOOjO4UTxLp1q270rVeFeYqThR2DQtw
 4y7kdhUuZuhniCdMp1Q==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a8522a4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=hXMCaxYEdCLwTpMgVTgA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 18teJJk2XHsfcRKX2BmXJ2Q3kzs6W9WM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190022
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



On 8/17/2026 10:14 PM, Konrad Dybcio wrote:
> On 8/17/26 4:13 PM, Konrad Dybcio wrote:
>> On 8/13/26 9:44 AM, Yongxing Mou wrote:
>>>
>>>
>>> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>>>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>>>> powers a subset of SSPP blocks.
>>>>
>>>> Can they operate independently? Does INT2_GDSC need to be
>>>> powered on after CORE_GDSC?
>>>>
>>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
>>
>> Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
>> be enabled itself if CORE_GDSC is off?
> 
> (I didn't quite know how to parse the list of states you provided in your
> reply so I asked again)
> 
> Konrad
Sorry, here INT2_GDSC can be on only when CORE_GDSC is on. And power 
sequence is:
Power down sequence: MDSS_INT2 > MDSS_INT >
Power up sequence: MDSS_INT > MDSS_INT2

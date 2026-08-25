Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06ADC61CE3
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F12010E914;
	Tue, 25 Aug 2026 06:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VOtgFOw8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jQUUr4gX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB25710E914
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2RG7X120801
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OiCk6OBZunfUknJgfXfdLbIqA4ktnCpbCIH2IimRzuI=; b=VOtgFOw8cN7/xgnp
 nFRdMkMYbG7j0UhPzQjxiBiflvNNVr9eZpS49DxnEvVxcTIFvFnzZILODybqdSzh
 +0+KTVHEWJW7UQmSM9qjLUbgYZj4DaqBoRIxuc1YbLm8l2Tbstofqq5wyJZkUJZN
 3LnrvDAqSoy6aLX9e3rNjpdCKXJzlyNKQOk0xMW/QnnOv66c5VPdyqRe8oVH0Wuu
 o9AEhRenWT/6T3XJiaZ2BZihZDpAMGXlp/Jzhc886oyBqKqqrLZoZ7MuIxlJNZfS
 Dcj07NrYJ3Q/a2RIbjgVJ30vdLFc/oOFZCyfzHPduTPI/JzWB2JL55C/pOLxTmnp
 aD9lNg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8t3dtffg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so5093305ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787639348; x=1788244148;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OiCk6OBZunfUknJgfXfdLbIqA4ktnCpbCIH2IimRzuI=;
 b=jQUUr4gXgCq2ivXi1ifKBM5vQbZiRyycH+NzWYqDM280uiAgWYSaAUWd19uro4e7/O
 asVeiONWWKsElQioK+qSgh//gxeCEBxsIonr3R00B/XmkzM7IJKKm3izPoUnrxh6MK84
 BZDjpfh1ev5RgE8AT2KC7/ZKiUoeWvP5nnfCCit1AflxTOApRzjGG8BVLNlnXDh9+T3z
 aQaCeSawwYpl9IoEI7pl3PdDeiHPQXyX/rjN4YLBjzNQ/mxyxwM3odEw9Ti1voIEudev
 vbtzxmVmM8qIa4+gml/Pruv5Gs0IfnPZ49LWREdnSzW1CmPuRNCMNY3QF+IgvSu+t9MY
 tG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639348; x=1788244148;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OiCk6OBZunfUknJgfXfdLbIqA4ktnCpbCIH2IimRzuI=;
 b=NqIejDbvjscsonQyjxO6+RF0BF9e5yy6/nNHmXLUEITflNUwldEfY7Np9a+aUhcGDs
 mIeLHtOjBrSIqsgiGY85rCH9ddmIkj9nLPK7fPh+SkHMMvyla70OfoVWyE3z+kP3KhRn
 rtLLopUa2TRdJNKDb+kHDRyKIzAYKO0UAt1HkR1feKg0uln7v3zVMt1AVYp9IZo9oKUO
 XiWH2eqf+UQ7nq3xm584NADiCGoww4N5YNFKz5vT2LfpEVKQXrTfYPvHSod8uPoSPeRs
 kIS892uKFtJyjQ8tJQ6wCWaRdQ5DUNsc/YCArzfBe/CfZghUE9ZrQZ8hobo+YMgUPXQo
 +h5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL/LXwGUVONS9BNx+8960nvJXJ3f/fmXBIO0QaoNfYgv3RVdMC1kUCr+WlsAhR4/soKoUevVTYBbc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwjo1ItisEWXIcG/u/t1Xaf1nWG30guzYD4Ic8/QqBiizrIepb
 QKCZkxIsWlRhuf0am3XpvbcbcOExb2Spc3QCyzXLTrjfedXBn40OJv7oP+aDPzowTFJyBW/s22/
 CeFZ5/hNQJ5U0XDCOFhjT3KkjmffvABB6J3TOD3K1XmJj4j8hLjFxd9+bPjxGIdw6qlCUwZw=
X-Gm-Gg: AR+sD111B0cdd/9+In3aVCa7ssDD8/RWfdok03OCIawJwULRnPGRqTbbB186SEU+zHB
 5TmtLm3zwE512vol/Yv4l6OI60219OysHoN8qiOe4xKT6CwFmh/WmTsfnNLnX3LTL8jWxx9aL1a
 lv9QAu6Pf1MtOTLGFzPIRFWdNzA1T6ZowHUzzV95UFE7TeuoRewT20doWTFQhJro5EIthjSm8BM
 okfWgGeBqkBOQYdTJVn/LB0lsI/WIe3hRHxENMDtyJ5s/Ev42FRJtz4MGyPI3ZtkahAXWwZ/VGI
 HMQUmLtJO+VEsNhuGugeEmW5nrtbyWkKBGECkh0eZn/rW7tAB2hhrANQN/DuY7JdEz/+WLpInjV
 NesDFsuCgpETiShR9TN9Gndug2RONBBP9/2RxXS4wFyhADotQjDvGI+hXfItvS14Hyh8oQRce
X-Received: by 2002:a17:902:cf01:b0:2cf:7db9:e13e with SMTP id
 d9443c01a7336-2d6dc9b28dcmr52884605ad.3.1787639348392; 
 Mon, 24 Aug 2026 23:29:08 -0700 (PDT)
X-Received: by 2002:a17:902:cf01:b0:2cf:7db9:e13e with SMTP id
 d9443c01a7336-2d6dc9b28dcmr52883995ad.3.1787639347971; 
 Mon, 24 Aug 2026 23:29:07 -0700 (PDT)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768b9e3dsm24218565ad.65.2026.08.24.23.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 23:29:07 -0700 (PDT)
Message-ID: <f344a913-cc95-4fef-880b-f1fee200c108@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:28:58 +0800
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
X-Proofpoint-ORIG-GUID: Z8nQjFNShMAQc_ILea3UZA_ePMRyO5HC
X-Authority-Analysis: v=2.4 cv=OLAXGyaB c=1 sm=1 tr=0 ts=6a8d3635 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=hXMCaxYEdCLwTpMgVTgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Z8nQjFNShMAQc_ILea3UZA_ePMRyO5HC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1MyBTYWx0ZWRfX2IZaDTmy1zJj
 1I8V0pqXypqILJMOLjc+GeDWQ2riLwXaFOb6OPyD6YxK5EPynu7XJfQtkfNZyMappEmT8FQ5rku
 tceqJftBVJ5WQe9pqGzUDKCDA6pcoFw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1MyBTYWx0ZWRfX9n+vMtm8sNXm
 bouo6eTQodhOidaPTmpM2YZNmhsp5pbm0enELs8G1uVqGlVOlyWDqkfHp/Ic3Q812F9G+B2Eu7m
 NPfiA8pvCc/2eCv5V+zGUAUakpPtmQ4eR9Qe6rMKXcIbnboShXbXk4XC5x47iLSMhD7H3KZjsv9
 MbAuwPf/M8nsyrMPyX0oEpzCHQToGhpWOnxv1+XCX7SrAICkDY9LQIjNzMMhjUAeI8aGQGD1dox
 K7VbP0v7PLhW+d+Ocj+AcPMCaZ4Lxuh5BWRSziBGzauEsigpJlybKBLBsoK8fJ8XpKpItJGBHmo
 NJSha5uNALtDVtiDfmp1TfU6MSJ6kG1hI2K//8ZXffmbvONUQQwCTQdK8rsQYN8kHHGAuP8Tkko
 P/r6Xeus59bL0d3NWNVbiujGjGb1ZN1pQ8+E+UPHBLl0jrkwzRVt16hjEM+coYrN/cDC9MRqHJk
 SZZc50JJTZ6wejHbIHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250053
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
Hi, Konard. Would you recommend adding the parent clock in the clock 
driver, or handling 2 GDSC in the display driver? I'm preparing the next 
revision and would appreciate your feedback.

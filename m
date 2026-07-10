Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F31EC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD0810E11E;
	Fri, 10 Jul 2026 03:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2w2tnKg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OK7uUsMv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D727310E11E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 03:30:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669KZCwq2917380
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 03:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VX8a8JResP8XCSCJbfEz2gGZ3th51SS7z/g4qLfLxKc=; b=i2w2tnKgEyl4Mlfj
 U8enrOZFpMvtR5iuVS8YP4x4kmO+Sf2rp5UA8hnuAS/yvqekipGk63VufHhquwMf
 oTTNAoHg9jt3t9wdranPm7MV+Ceh+DiSJspimHkFa6p2iWa5mAoMQhXzJ/aIKJlT
 XlvS7Bs/6J1acZ9ZxnvLGs04ADrP8jrD8HeJQ6GDuezV6P1vC18w1opLReMRJxfD
 i3dJJZVI1xVdfloS/ryqrc5r9zKADfUoXd4M7ZlQ9KDf3kwWFehgscLOqtZHniAR
 a9xtzfZGlvKhsTLnHUxyQv7GJ/SIUjq6E1Sotu/9RAMXRsRkiYgIsXukQWltO52h
 GJU/JA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte14pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 03:30:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484b9fb055so1298207b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783654231; x=1784259031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VX8a8JResP8XCSCJbfEz2gGZ3th51SS7z/g4qLfLxKc=;
 b=OK7uUsMvkcmedtWvEKGd07Bd84wm2U/L13enbAiCSVKuc7yU9yVxeNHk4Q6qCUegX6
 5wZc1rOn+B7pPENcBdgDRZGtsxDXuqAgvZUKZ+Gsc0cn7r6MF9ZODhRSCX/STd3owGom
 ap3waftGeTbtGMPNY792l3VLfHrMpoI5kCeVz+39Eh8qW4sD4AYjskPA8QGkWxiHsWjL
 HTTW3KzKHdpHrL2Egngoa3WHC+Dd1MBuY6n95eU4Jemh3wqejCvphga2wrLNdoAW3sZa
 MKx0tHfQU50ehlC/Bw1UVGLvvpknUKdcPAeRt/uQp2y9X8/914sSOXt+2sccX05zMPru
 5zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783654231; x=1784259031;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VX8a8JResP8XCSCJbfEz2gGZ3th51SS7z/g4qLfLxKc=;
 b=AUJRTQUJbMkj+KYnBRAnBy28EDEzcqD6CKLiAedGhxXRZCvdkYsdm+gIAXxyulMdHO
 9KnLg/Fr7eHDzqIweHMBv1R2RbBORD9smZiIdHCzxmujxW0JWFoVVQJfKgBHi9gU/mSz
 fjycW+vqHA/z5blftlbyFXfjBz0GWyAr/jTrs99khIQBZf1c21xrLMvD2WBTdg9mlb0f
 1CnYDFeXKb+s+uIghVWqrNPyC0xQHI2UVlEyeSp7Es9tYJggn/NNeUaII5VMwicnF52F
 Cm5fgksrYTS94NbURgPVu3lwWaxPBPV7l6VfWZ07KAokBKLkZ90n0Xta3MVDbED6sBrq
 UxQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1JU9U0CS4NW57HlZjyCByH9bAbqAn7Lm7xAds8Taj0IOBSuP32RDmRGL0i/xIgo4+RHeYVEwl2Rc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyqg08pDncSgp0UuP0oOJh+Q2YsRZUvWReMLz1Qd42SNafXmbtd
 GDzW0kNrMfzrQ5CRFwePYt7GQJWEOIiWzsfVvlp7zc+FOMsOF2LcD3BqvH01b+ryBQHZlhS8Bjh
 k1iN/n4RAkC4CCqVMEFopiq61vYS/3tw6OPLl0RnFyq2h824mrEEUSDPOqgXa2ZQhruLN2lY=
X-Gm-Gg: AfdE7clGlE8rxuqbCROgtkd39rnpip7nnOAiPdvJP5NLdlK4uxrFhBfVzgYyYMLuE4J
 Z+YzwENiV3Ht1b4N5KCTGjNMBhvvnS8+SbTXezz+rRfJcjHzamVMSczenWQp8eGjyqEvoGcDum+
 r1fis8Bkc5PwfInNGrsXEOTMtZKKJ/wg9+q0G8+InQsFTBYJG+XjYMd/t5uFDg91oD/Oe/BuRlu
 wN5mkmdRu+rpA3nReGr9Z0Ehdbxlsk1w7upCls+B1/rNxgkaZkBHyjZf1SckZqwYwuLlFVbB6a+
 U3fV+dI+K4R+GWp0a37o7ZQPmO3oFGqHe3ROS9xXaDXVOKVuxVkI4kWR7+7SDUl5i/b9g8UNbpp
 xgHYiaLPUvaP+vI0U4YOBQgnvNIGsIZOXvJVaWI1P
X-Received: by 2002:a05:6a00:22d4:b0:848:788a:e7f9 with SMTP id
 d2e1a72fcca58-848788aecacmr543861b3a.18.1783654231476; 
 Thu, 09 Jul 2026 20:30:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:22d4:b0:848:788a:e7f9 with SMTP id
 d2e1a72fcca58-848788aecacmr543829b3a.18.1783654231035; 
 Thu, 09 Jul 2026 20:30:31 -0700 (PDT)
Received: from [10.204.79.106] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8483262a17dsm4980282b3a.4.2026.07.09.20.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 20:30:30 -0700 (PDT)
Message-ID: <1dcbc6e1-7b78-467f-b39d-eec4aecbf577@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 09:00:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: Document Nord FastRPC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260709082040.4070711-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260709082040.4070711-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qCfzB7yTFgLqVsMoF-5Sisnb2jL3gz-L
X-Proofpoint-ORIG-GUID: qCfzB7yTFgLqVsMoF-5Sisnb2jL3gz-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAyOSBTYWx0ZWRfX/HpTpmwz8HZ/
 4Mxz348qqlqpRdX9+zeQXE+Ff1O+ODjZEUOs5UlT3EZRXXYkxy7dEyhkFDe7vvQxbpJoleN8Wc7
 Dl+Zj/1U4eQxTU6DJ/9sdZq4iIqrBIX9Xqihgrc8UOB20XhpMalKzsr+dOuiNOQyGd+wfMWvUKT
 VpUbzcMmHvXJyRBvLjV1B3aIh6oqQ+fQ3hjHv0QdDSOvqBEoeBuj6pvLyKqcLi26ea8DE+yk9V0
 GDQm0hFK5ghl3+mQ5pcnVS8QwsLTLiOdcmh4d6NLAdxlaFlbEcVn2s0X97kdUwAn9GuOf0dcFMK
 JjLS6o4ahY0tbgUPwUyurLQGbMlBG72JTMMO2zRwrixCyj6fCZA0igLGm4MK7DQfeZ9ZqzXB7kt
 gxfH8HtRiIULHJ6jIUlKQ8iItBvyceE22N4GQtTq0InstTLycUwIfBHpDrfRjg2esgokdo5g7vA
 h5LDO0Yl0Wad/rIy1Nw==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a506758 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=LFGRwP0lTeoBuEiPW_EA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAyOSBTYWx0ZWRfX/Id5cTxwj5Xs
 NI8IxNLFbAg711Bpj8bE4+neQOu4Q77ja7mBPqn8ou5Ms3iSKEyU4dtGo+q2EE5XUPvNaGk678q
 KKTrHP8dbzeiJuqyksgayhejrhjYTOc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100029
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

On 09-07-2026 13:50, Shawn Guo wrote:
> Add compatible for Qualcomm Nord FastRPC which is compatible with
> Kaanapali FastRPC.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 2876fdd7c6e6..24fc0752c11a 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - enum:
>                - qcom,glymur-fastrpc
>                - qcom,hawi-fastrpc
> +              - qcom,nord-fastrpc
>            - const: qcom,kaanapali-fastrpc
>  
>    label:
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>


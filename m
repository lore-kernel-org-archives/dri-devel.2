Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C584CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F05112239;
	Thu, 15 Oct 2026 09:11:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F400A11222F
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:11:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F86Ru81707508
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WdtX+dyyVh6BP1HakGebp1o99ElPTtIZjQj7vLhLhyg=; b=AogNQwqAZL9D8O1C
 72ugis4zGLSjwVmVlHqQ1Uw00SWq+/uokvuCnwPJ4aB8NypSYZHZeJDIwBmctMpu
 6lNEHwWc0Fj/+qoWLhn0wuiomkYXSJ9ZyzwaAqB73hR4kFiUyjwavYrhCRtcfwdh
 bXQ2km1dFQID02/+ouh+RwxshawH7jPobd+xw+LD+/tLOx9l71J5cLA9NcXaS6JG
 E3fOykxNof2Ai+Jx//OIEpucs3aQpydwLi6seB2vSX+y9P1y3lNLc8JsYbnZdU8Q
 Fm4sRaxUSfXOeEqHd+WLyF8xXWXbrIRLpk5WStKRD0i2/7dFhMnccPSAV0z8q2go
 P0JDrA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54sq5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:11:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53568f05f8bso14690721cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055474; x=1792660274;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WdtX+dyyVh6BP1HakGebp1o99ElPTtIZjQj7vLhLhyg=;
 b=TErClKlHh8Itt0VYH/tBy7NPFHYZGYH+qIBiNb7uGSGwf6qHeMVqJ7kJC+oM0ihYC1
 hOFBMJjsivey5whJCmTJDomPNFCYU81P8IfHhE60burXkWKfS7m5reh3H/MX6FDnZa/E
 oKrtt7yRtM4RXJ6JIpVtDqBziIx+dAW7+nwtq/nWsTGzFpVzLTklX2F5zq+aB24GI+ll
 JlddpoSu/EKE5DQlSAn6yccBJtkpwV0U0JL0rM5UxfUo+kWxoNn1uKFRK9pPb66PVs13
 FYCs5lzAILl+7Ar9qr5+Qe4FiBvkBdnjODld0m5v7N/2buKCG1F6D4zhI8E5iaLtolyH
 QB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055474; x=1792660274;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WdtX+dyyVh6BP1HakGebp1o99ElPTtIZjQj7vLhLhyg=;
 b=dlr3CxyA3n5CjpNaPLC929SqSNoMZONjgPgAsSu/KSwMdFZGH3gwdczOhH8ARtmn6s
 LG9joB7L4pXJW9BNffaP5uqew9xpYWuaDRcF5K7ukKF7UUjJ8hdQ6x1+4h31eDD7tczT
 5bPVaaaPedzNM2BevgGuAwMxyxcY3YRLqe6K5vQYd41wwLuZIq9pSAGxxR6qzXdeiqRD
 Hx6OLvU5/GRlyzOgPHNoOBGq9B1qtOj2vJe680/z4W2keWncsoRWaVto7LYfnwYciGL4
 5zB24FAFcmm6jdNhDZlDiMDFgetOOggTUjQCtzS8o797H4vlG0YTXxfEfsteWmdz1OYS
 czSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuTksrFRhOsbrqvRxROuj2LQ/+H6iUBi9I/4fEh1zymh3LzXdHJRrzVB54xKQmGzNz/2f3ExEavok=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIP+vRGnOfr5A/Ijo9yqBuvrbz3YtyVrW+bPTO80SdjDQtY5rdq
 RUlQoYnlEnbovHdA3JK5wI08DhfC4qSASYybbI0Z5PuPVHCjVmJ+fC7dpCA/ZMNxpiha6SqMmAT
 Qx7fDCdEG0OTorGyBakdVx074M6A7f8K4uR0TujZGe5aY+IBQG47OlyLV+RKJbtTf68LeWvI=
X-Gm-Gg: AYBFou12Gq8+bdF+D5ogq4X8ytfIYlixWCgWX/53LFnHfDvPaFWC1z5aieA88dpDQh9
 XKL36tcUWbp2oQX381Unm/1Od1lKJHHRu2SZQjar7PWvggycMK/pkVUc33Us2+8B65Ued5vHnq2
 B+F24H+iNI3k+KrKOj2AIzFJ/rz5UC4HU4GGhUF1CmXMFQP5RpxsltECGVUsFYKaRchFEop1NS0
 VR1kJCXR0wi4ZPVX+/CKoCfvw655qLibEQ+xKV/ZlBuUkTYQ4MFsFW15GYJBN1BYRRor3KGSUO9
 7w9J0guXY8l5+ItOv7qoixhjmlCQK+rTrsHtCEAPqK0mArA2p2y/Y2+BGozgKY/D2m6Dt2Ymuqu
 R9+GllaaOEKxdBbSGIUTC5A==
X-Received: by 2002:ac8:5f87:0:b0:535:fd16:4393 with SMTP id
 d75a77b69052e-535fd164be8mr94188081cf.5.1792055474093; 
 Thu, 15 Oct 2026 02:11:14 -0700 (PDT)
X-Received: by 2002:ac8:5f87:0:b0:535:fd16:4393 with SMTP id
 d75a77b69052e-535fd164be8mr94187711cf.5.1792055473655; 
 Thu, 15 Oct 2026 02:11:13 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3edab11d7bsm101289466b.83.2026.10.15.02.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:11:12 -0700 (PDT)
Message-ID: <36e8a372-3a4b-4466-831a-2445313dae51@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
 <ddbb547a-f59f-4ad2-8c99-4436bdae84c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ddbb547a-f59f-4ad2-8c99-4436bdae84c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad098b2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mAFRzXhWWU4R2_A-WnwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX4vJohU+yoKEz
 A1jwGRh1VEBdwLPS5Hh6aF+PV9pJTX9cSeyQvFv3UFHCe9PCQoGwoYbvV592hdV0Wy4cHl2kOA6
 ZmTxyVCRosDciuCOIjN28R6iGByw6BwyyPX6y3G6SysEy3meMxU+RdwLu/heAez4rZpAYnT7Nfo
 wWrlFsqfqe9/jN/sIhPi7H/fuJ6HFbKPPe7IxF+uf1TGOQyl2cZZqYV6UtYZAuL+6QrmB84RTnB
 IiFGmKnFCcMdrkkTRbOzL23Rtw/W07iedmmd1uA1hziHq/Bj8/BjDWygjY4zxgSjgsDTqmWYBDX
 svOuNNK72K4OyZnVwNWfFaert/d+nvwCjYnlbk4RAQk1Qt5bMe4k33lvFiRT7C0HVSuUCIqeML7
 tj6ea2iFE0wgIPfl9fV6XhFR30YQhDr2jw5bm72NY2dlfaA5Fi1KL5VunaOULbDOcdi0lG2opWU
 hghkw0X0Fq1DwQfu6hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX2kmyZ5q737ng
 OddUe7cxr+FQUeFGIaP9YlCzAkU1EXYTzw0J7vrsfROnx+RhJHksNcb73Vtf76SmA2ZUMNgZKhh
 y1qFfvjN9DA1ZbhMhp+/92AEDmuOeY8=
X-Proofpoint-GUID: WMYGWmdTfnVJAws-ut8Rbz3oB72Yngtv
X-Proofpoint-ORIG-GUID: WMYGWmdTfnVJAws-ut8Rbz3oB72Yngtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036
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

On 10/15/26 11:10 AM, Konrad Dybcio wrote:
> On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
>> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
>> the wrong address the mux driver fails to probe, the Type-C controller
>> and the DisplayPort controller keep waiting for it and the display
>> subsystem never binds.
>>
>> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
>> Assisted-by: LLM
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
> 
> Hm, there's an ADDR pin on the FSA. I wonder if the previous guy had
> an earlier revision of the board which routed that differently or
> something.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

oh wait.. the previous guy (author of the Fixes commit is you.. :D

Konrad

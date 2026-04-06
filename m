Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EFCE9D826
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 01:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA0F10E16D;
	Mon,  6 Apr 2026 01:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gzJUqMX/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b6U097Ko";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F226710E16D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 01:12:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635Kxnlg2469655
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 01:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sJ6QF2B9Gl2iuduiO539PK7o
 l4CzootqweIKsqMau/4=; b=gzJUqMX/fqGj0mnu+FKAL3ggrOqqfmemmGgDC1FE
 W5gQmzAFvItdrx7BkytVsu/xWIXKjHL/jn+1tqVNKLwZgUuGVUafa0InuzR6VhDk
 B7q2WYjhySavx2lFhUOV4lKdxwv3qGb+G8CTHd04MYMPBuECsKatU0NUbzlpjh/e
 WJxql5VBf2hMlAxH297ooyQpjN4q8y/X9Yuh3UlX6an79AG6UUX0a21UjHVn1Ge1
 W4shLIKxdaq1X0/zu2QDbxX8hnfBcqJ8lxdtbrDLgN0Y3Bsipn6lYbo/BwD4Yd1I
 xZMxF3NZDF981zt63f7C/fwWXpbU2FeRfdLj4NtdMkBVtg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mkpxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 01:12:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d6bf346adso46820031cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775437921; x=1776042721;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sJ6QF2B9Gl2iuduiO539PK7ol4CzootqweIKsqMau/4=;
 b=b6U097KozKv8FEZqe87mFGy8Z+0upXN3mfb9jO4OKL+SsxrcHP8DttYawL9+3vZnf6
 AMZzNoJvnod2JhC/+3i+MtMb+U34y+B8/bySj+HVpJzM8AYjwaGn+MbvbsSP+QN/r4Zz
 lMfWIqZYF80TH1uJYvZ/6oOjsiOsL6JKxioRfLvre92SqWgudKL7ZKoI0RwoV+6FQEak
 rb3kcu+FPG5vLqGabJ1c22xQpwHQMqEscOdQV43E33MpnGuE9SoedWdC3F6l7Ln1bGnX
 D2VoJsFanjP6bejBGt4isxaQ7mHwiDIqa/6/Tid2xNeoX/wTUNSatb0xhj+WRYOqyo8C
 GFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775437921; x=1776042721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJ6QF2B9Gl2iuduiO539PK7ol4CzootqweIKsqMau/4=;
 b=D8zp+QOlT0HCz6AcryZ2M2XfFzT3yBRYdwBSAeaUphBwckGnLzA3tH+DFWQHAFtyKA
 w4EDaZBBlDiFYORmCiTVYs4AeXY4HKgIbCbzmjh72S87vP8FVINNOkuZ5CgQoMk0otUn
 Ma8C5Da4BZBA87AULs8KGbnapYjvlArZa4e/H7jpiq3QchnNkEtaBxvWOk/83gSadVQx
 tMoZxCMXcYTGaxo7o8Wr0+rDOMXPRzjeU2X+yNTUZMSu51FcIOELZRfPJw7ZG98pmUma
 YCo++ru5oaY3bh2Rg3mEeUxV9MIdxONmefLEv4Q9ec9Ptsb9GwOqgPvzG89Ixzb+J7cP
 0fAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3CD7hdZxO/M5qKVvI+uhWcg7yROoexfkoxDBGcKdU0nmDFyy3M6hSlraN2pQFbpaUNErcLW++Kxk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5m1n25MO/veRkEUrafP2uV2WXvwAFncOaXxbKZaplMGEdODii
 Tbr2+0qFcwj2Ko5jp4L3nWzJb+uCXLJzBK7GUHEyvdPCdz3+XIAatvUYqOP3xIWaiRoDbawRzLk
 rrEmPyW2Atmv2cz2tFwLREeRtz3uNcea7TdFhHC5+WT5iTClfCB7PsXTpqDUAlI7SqyVZgpY=
X-Gm-Gg: AeBDieuoPNrVGgltAPkx16zGV0PC5Lk6H8VuA5eRoPiV+xFWlqJ9PZbzSnHviBQOOPf
 qCrS3lhrv7V2AXTKmayPmgROVzf9b2d04AD3YdkAowtnDatRDvON8x6pWZ68ERhc2X53VyI2EPu
 OWSizLNKfs20vSKu4OB9Po+xSneOX/nMWIVpd8mnr8WFGMMsd6t6KdfNziM6UGb+Y9MyW9mYxAr
 gWStlm52J+e9kdSf4SveKt5WhG6HU292yL0Qysx0HZaUaPpoxJQAfgXa37gx8enhda72D8ast4B
 SD57hITh1pjb42Fj9S4OMZK79xh7VWEcd3ueE8WfgeKV3TtbufT23Bg+yf55O5nDKG2yZT5Ki3z
 IFgOJk68KU9XJPEUi+jEUg5NGQMxsbYs7Q9NgcKZvZ/HZRL3sKZkZL84wy6NPBoXYkEypKIMdNs
 dGpqX0tDICzJkj6om11FFm/QUckzidvvlHtyU=
X-Received: by 2002:a05:622a:4cca:b0:50d:7c13:6b14 with SMTP id
 d75a77b69052e-50d7c13732cmr100361201cf.14.1775437921385; 
 Sun, 05 Apr 2026 18:12:01 -0700 (PDT)
X-Received: by 2002:a05:622a:4cca:b0:50d:7c13:6b14 with SMTP id
 d75a77b69052e-50d7c13732cmr100360921cf.14.1775437920977; 
 Sun, 05 Apr 2026 18:12:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ca32c0sm3038067e87.36.2026.04.05.18.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 18:11:59 -0700 (PDT)
Date: Mon, 6 Apr 2026 04:11:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: display/msm: dp-controller: Allow DAI
 on SM8650
Message-ID: <xannpjqglr6ag4c6dln4kash5pbytbsvjpaytjyrk75p6esoj2@hanwlnbu7c4d>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-2-daa54ab448a3@oss.qualcomm.com>
 <ozofiq5dwk7luisfa6a4e4wbqw4vuvcs2h463hqxt7uee4aod3@j7aslgp4hkn3>
 <c17e30a7-6aeb-44d8-b3ad-b417bd188dd3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c17e30a7-6aeb-44d8-b3ad-b417bd188dd3@kernel.org>
X-Proofpoint-ORIG-GUID: 0b8E_-2HSTvzA4Eqpn_rIK8sx9EwTmU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDAwOSBTYWx0ZWRfXz7hpFg+If1Lo
 nWkFeCevmmIcXCcLEjQcskkQT7/luk9Ws/lXsdSdiIE86eFp4Qlt9zRUTkbLmJmYHIuuhSUfw6A
 5+jAKRjlGyydOSciAazURkcfcksTD1/pR7y3j1E2vb6Y4MEL3Z+VYdwSx1BbP/jA0fvcXNEzgEU
 LmLV1LogC7Blfk91wRyT/g6ojsuVm2wnlWkwaxiDNn1zLvaqm5SJEOARn5B//VyWwtX6paXkBIh
 TI5TcGjF6Pp1QaXfgDO1qKDy+HZrZxD9h1IWfhZaPfxZ7uA2hEkems2sZb/Yj/HRoUbqto+nC89
 GQnum0atQZD3ClZr9Incm961hbsBIspuVPEL7u85eaUKZEwU1Tu9e01KeCqVqDbcxpW3URuZ1tH
 o/xafc4cMRaiM1uleoBYx0JE42cxK0jGuwszQOhbWEWaLD52zEGzjzQMwk1nv9c61LrEKEKy9kT
 5IsFy17LN1ABs3p0niQ==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d30862 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=7EEuWH7kyJsibKM1IGcA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 0b8E_-2HSTvzA4Eqpn_rIK8sx9EwTmU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060009
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

On Sun, Apr 05, 2026 at 08:54:14AM +0200, Krzysztof Kozlowski wrote:
> On 05/04/2026 00:04, Dmitry Baryshkov wrote:
> > On Thu, Apr 02, 2026 at 01:45:13PM +0200, Krzysztof Kozlowski wrote:
> >> DisplayPort on Qualcomm SM8650 (and compatible SM8750) supports audio
> >> and there is DTS already having cells and sound-name-prefix.  Add SM8650
> >> to the list of SoCs referencing the dai-common.yaml schema to solve
> >> dtbs_check warnings like:
> >>
> >>   sm8650-hdk-display-card-rear-camera-card.dtb:
> >>     displayport-controller@af54000 (qcom,sm8650-dp): Unevaluated properties are not allowed ('sound-name-prefix' was unexpected)
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >> ---
> >>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> index e4f17d29343b..f8daaee8d065 100644
> >> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> @@ -210,6 +210,7 @@ allOf:
> >>                enum:
> >>                  - qcom,glymur-dp
> >>                  - qcom,sa8775p-dp
> >> +                - qcom,sm8650-dp
> >>                  - qcom,x1e80100-dp
> >>        then:
> >>          $ref: /schemas/sound/dai-common.yaml#
> > 
> > This clause is for the platforms which can work either with the eDP
> > (aux-bus) or DP (sound-dai-cells) setup. Instead please extend the else
> > clause to $ref dai-common.yaml.
> 
> OK, this binding is not getting readable...

Feel free to propose ways to improve it, constructive feedback is really
appreciated.

> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

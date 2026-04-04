Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043A4E63FFA
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3B210E02F;
	Sat,  4 Apr 2026 21:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B67aOBwu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBfuJv2q";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB6F10E02F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:22:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634KJuGU1309708
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jAmb2DJFQpjhoL8lvIGCkQkm
 M7lGqiPcwTOeSmd23U8=; b=B67aOBwuiQxLzL456Kyv5iF3uUZHrZ7/YuIWWwBW
 cCnHIxDaZFbLXD8RpY+R7dmqyhD5M3THOZtWIun0cSoeWL0oJLfPWRijIVtFVFhK
 0KjFBD9G1YwyRJQ8O2BoeAxo7HzNIayIHPwHDJgMuIS6+IzUUokRp4AeKuazoBtJ
 19qx8vXiGR3WGxMNg0Yl0ou04xGIeXCW1aq4G6FOZu9nDAV1dl8639vt0SYO7wUu
 KW9g6CB0yCxPfDxZ65gtlUUYK0IPhNuRAdr/gWCV7tbYEOEpAHRbC+a1MkWxeDBI
 c5LZdORIKPdwvDHb8tmbSjWEY+VooQCgdw0kgPFkzRYFbQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mhqub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:22:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50937cf66b5so134446861cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775337721; x=1775942521;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jAmb2DJFQpjhoL8lvIGCkQkmM7lGqiPcwTOeSmd23U8=;
 b=kBfuJv2q3lcRYE4AB1cH/OAjeBSgAGiiKMvJcm4gf+xJ4Jl8CcKKby/Y+xT1Bw7+3x
 2o1GXYxOBVWFukM9svlDiZWyHZxbYr/AE6/QLlvbW2/hYLp85I8qIzxIFUWSGpasGCBU
 e1JHQQtHAroKuTsDq7CzA3F0wegHZVLxx/TDGeKRCxlIhs4sYcHh7JMJWDbgy215Qpij
 AYcg7UFSOWuTHhGG2UbN6CAe5Tt510rCa+hO9nJSEsEn6vdWreM3Srs/RO51zlrBHyev
 /x+f1Z54L2bCjKmNuw4qOfdg07ms3Unl4lWr24TC0GVueYDUaRkOaSfUASz7CUo7EMM5
 hBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775337721; x=1775942521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAmb2DJFQpjhoL8lvIGCkQkmM7lGqiPcwTOeSmd23U8=;
 b=If6Oi6s3OGh1WXew1dbeMH0NLl6HxZI9kL4GwapRGWg1ahvpDLa7BH1B8IwFzmFZLa
 NMidm4fAZJCGtExh+PtcMUJIFILWai9cgRK1+ATFAIvvLJbQSxfNbs+gDFL2Tz8phWXq
 4hZf8iTpmMKwMD0rnNRB9JZfXbdWwfPoqWHI1p0rLubuLj3BhBVsGpcr06nmwgXsALy/
 Nk6ddcudrAOZgCG+PF4mxdE1aDceVwohm3Jlx+dK/x9XoauzzyFx16CtSm9xqgmFdwHw
 mcSREh1fx5vxjD0PGdQW8WdOsUuqf0xGSlwYwngHi5+Mx/cIN9rYegjELMOZ1jr7DxDh
 /LSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8mKiJWmZvl/82GjwZ4VjBLbGgbyoaQbqeWxwt/Kx69NWNqjzIQhI5M7QyYeRozpzqtHUngJ/YXK8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjRCRqK/9Ve47L0KFWfAx+YBgiRoMNwN9+vS6c38WyT7wQAFn/
 k5OzQBA7vwY82mpZUuW3LA2ZTgmgo4SZ+ovP3JL0mtFgDnoPaKx6I6PGkYogSft61amnWlP6n5D
 UmQX48hnC2XHaR84ofa6fN/oI2DEZU0zUvDZBV5dQK0vUO9A/OuM/fZbxFyxueVk1/MYYweY=
X-Gm-Gg: AeBDievFJ/+h8k90cRn8duf1Gk9FM9SsK226UC7gQwkcoybdHrDTnVtG2UJteY3XMvz
 9/q1290PiFpm0hU7MGsnQMtg4T4pQQoac2imBfBi65WhuFyR6hcFf91VPOJdYthhPbk4M0Arlpe
 trii7bI9eV3s7bpnT+BvYzG7AkN0DZXG9Or9+w3XbNXVbXLg9MK0IAex4xMwMw5U0z4eyu1XRSn
 0WQmX9/KGFYgI4RXMIy808NmyKEV5Q2YjzPIdotmnOWDaWXkOGHI2g6jri/4+dLxYI7ELZxl8YK
 hx/rP8nu9OYuYjhXls7e6sBn8sS54rpanQz3hn6o9Q02EUDXAGiIfcZ0aFah9357rfphdgtSla3
 45vzrFZQdtwfSmFUJuUEtq5vDVTxkG6IK7RX6RXaC5MbgiSvk+ALICdT9TBaDf78ZWBjXkKHyCH
 Sv/0W/XBRqMCtHcPZkb1tH5bVHyD7iUiAVniU=
X-Received: by 2002:a05:622a:40ca:b0:509:26f4:64f5 with SMTP id
 d75a77b69052e-50d62a8d633mr123568471cf.48.1775337720886; 
 Sat, 04 Apr 2026 14:22:00 -0700 (PDT)
X-Received: by 2002:a05:622a:40ca:b0:509:26f4:64f5 with SMTP id
 d75a77b69052e-50d62a8d633mr123567911cf.48.1775337720381; 
 Sat, 04 Apr 2026 14:22:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd2187070sm20755501fa.42.2026.04.04.14.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:21:59 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:21:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/4] arm64: dts: qcom: glymur: Add GPU smmu node
Message-ID: <uuub6ue4yvirtlg5fzgzobc6y4of7ipud5xt7enmifpnbhjjxo@7gsmb4nrjr4i>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-2-2135eb11c562@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-glymur-gpu-dt-v1-2-2135eb11c562@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: tnOBp6fel74R71qSJQt5DNXk9gYFxfna
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMiBTYWx0ZWRfXx3a/izqmHCsZ
 Mv9qYOxGqGZe7LukkmX3eBGfICZ5USRdr66oQA3OL9Hdkf4yLq32fgbK3Yhvato79HSYF1wwe5F
 OA0D40HB2uqZNCzY1Xn2D4nBuiOSj92f1Yhb+oxa3HtMrfmi+5PfscI3kuX9U6yom9Y24NTpTNW
 cIAJCWFqGxAZ7LkwddnpCR/yBdEmDXB64ISVq0Bm3lvVZyHik7togG0kco2flOxO/iapZZ4M7CW
 frCx9hdMpFoQyl0+3SSQK6fQCwahh/i/FcfGrtDpB/OEMjgY4MWQDsyMZGm5WK/1Z5oONWATbdR
 3Ml2nYILu29m0mj0iMM4E45XLbdgHZDGYy6SHqez13OeLO8Rz8W8RmaWf9FWyqzp4B5wNIfQgY5
 C6jCZR8+BE2DvPa+Z/ajgc2c+0r+MkFbsBEebDOZzgJd2481vDKZ/tx45rEaDps8iWKricwsXQq
 BWH1rYCxAztSJXMUBqg==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d180f9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tnOBp6fel74R71qSJQt5DNXk9gYFxfna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040202
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

On Sun, Apr 05, 2026 at 02:33:15AM +0530, Akhil P Oommen wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add the nodes to describe the GPU SMMU node.
> 
> Signed-off-by: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

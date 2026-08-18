Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585C0C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC8F10E9C4;
	Tue, 18 Aug 2026 03:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hc+OyDCo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXocQCo1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0495410E499
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:30:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I3G2wc3833709
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0eGLIP08xW5C8N+4tfokGJwm
 d3WHOu0D+8SfCX55mAQ=; b=hc+OyDCozmUowshH46wmKQ/GJaHMBJy2MX42L5iF
 UEr5JAsgiwM2KLJnZ0hcqM5BOsO02m95rJZ9Li1SUQiZ50/lbStVI1F8PBnjnw9R
 PUqWKFNIExV7633t4EByFIjeZUjKQ6JjxqAvjhIYJj2Giusj0ytuHbBpKQreCN5O
 qOeZM+1RfMH5jpovUZE8hftIDc83Mh3JAD2qc005qyR7l/QLfE6tFGn9yps3k3rZ
 y8DEuQczHIk3xd88Z+K7KHuyncox1kt3G882vS7ClRk0JOU7ftvE+5Ha1Dz+kLEe
 UOYVkSa8gM2UmAMZEsbgBQDTWkIoUNWWjfSO7URPuDxQEw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fba81d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:30:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso46352271cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787023803; x=1787628603;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0eGLIP08xW5C8N+4tfokGJwmd3WHOu0D+8SfCX55mAQ=;
 b=VXocQCo1CJ0xe23fjo0xRYAZpVYwStJLwH6VlDO8diw2u8YqJjMRGHk9IIMKdpQn9q
 mOoRrf0XqTrIes/xVoX+5QDTQJ4zv5pC0hQ/d02TOPtFAve0yZza8piHeRPsjCLZM7wc
 3idkNCGuxrbAu5abWUhXK0UBUofFUSmcyNi1EeCVBWan4S+FlF5Zusao5L4xN0Orf9R+
 kpSo1VBgom4iF62qZX7ZSlW27VSuua5TUKnv7LNCX2CPzdNIsJP9VMHXtzK6iWiLT/Ku
 qZ9G0V90JOkqF+Wuob5antqVDIj3cmnCDvSnucOU9fbXebYdEeKF8PTuO0K6gMo41nMe
 QOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787023803; x=1787628603;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0eGLIP08xW5C8N+4tfokGJwmd3WHOu0D+8SfCX55mAQ=;
 b=sd0B6c+Y9ruvaecWRoEBXvxQTys1/ny6Bhc5DVrfGx9VzGz/IltAWQNNxdhDQC05gh
 /ASaa4npDlGkrvqHcZkAS7ej+78SltPyLUGDXEw6Fd0Kj4/oZUDufkFS0baYP+EoMoK0
 zXSx+A6NZ8TfMn8Y81wcVKgEoqK3CBrp3Jtod25GzysDKyEADsfa41f1unJMnY3/8HQp
 6W8jRaiovjjU4Veg86ChWTEayR8am6xiWSLIkR8/f4eeQg/6JaYHmAlbEfn3Sea2/eY5
 Kevt+vquXMF1y47U0DHhRkzp5OhpvNaub0bgNP85p3hgbzMx0TAdI2fAeukIUjbivzya
 RNCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrplumM+48IJmcFcxMIz3AuIZoY28IFIIEQh9+uPOdQljmAxjWcLWyx8T3Z6+t/Y7mxiLtZoPqe+kY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3ugN4zmTNFvc7W4Xm3B/dfSQCwNzdrma0JoGZ1tlh7WtsZMon
 mRLVeMVAp+aQBgmKwFgxrfyvW/BbVz36HhkqOKI8vvCx78X0DAWvXiW0Lt/4wQGkz72WOwekyrv
 xC6ozLAeuVR4ez77hnt+GeRsOpPTmG+b/+T0so6IUoUVlkRWxFIzO487WMWIaOmQDdKCUtH4=
X-Gm-Gg: AR+sD13SS/wKIQPwjcIy6gnDaRqf5rggHLE9+wRC77w4q7s0B2LBkp31/VL454t0qFD
 7aX9a0vh6kFBvYVCeOCNOqgetY8lfy9/OsRosAfrtAePOq8hFt0T9EwyAjkj+2HiTmcnJM1vKyI
 cTGQbrwoSZA8VabylAQ3QdMrQZfXGfNlqIILrMe37QTBV1PCGwlT8w35zLF3JsoftNORUsYU2Jg
 J3kcowP0AJRje2/lidJuEq6p7KiQYhksjuVDcRZjxbAo5TsIbpCkNAbcEiCSitUjlomL5HmoVaX
 P/P43qZUrSqgrtE9pNAK6BFhAkOG5/DHof4EfemXYAkEXX0kEfKHI1a/+4FpuSjYw2lpxWOyLJp
 H7a1e1JXxtYO8w1opnZ+a4y2GoTmXceslg3QQSrWyUFVH5BaqibxHyTXnvD1DKrjk7fdr8TY/t7
 CGbMPaEJpxLmxF
X-Received: by 2002:ac8:5f4a:0:b0:517:6550:2a0 with SMTP id
 d75a77b69052e-52d853b544cmr310911011cf.19.1787023803334; 
 Mon, 17 Aug 2026 20:30:03 -0700 (PDT)
X-Received: by 2002:ac8:5f4a:0:b0:517:6550:2a0 with SMTP id
 d75a77b69052e-52d853b544cmr310910521cf.19.1787023802765; 
 Mon, 17 Aug 2026 20:30:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46d00b5ffsm848096e87.67.2026.08.17.20.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:30:01 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:29:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
Message-ID: <44exzg6xzsxsgfspasbfwdi6mkovpoon6rsz4ahsomcveuvmkg@jau2b6lutygo>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <20260724-cocky-uppish-pelican-3796ee@quoll>
 <bad2e899-106a-4d7e-b082-345ec757ee9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad2e899-106a-4d7e-b082-345ec757ee9f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX06RvyUAuwwcv
 mQiC6lxI8zw7uH9drcnrf2tLjve/bmM8gkV1d/yQViC4GGXfdL3MBwAhjBnO5UeEQak8skvXU6H
 h2ctw9UgMP7Enmm1cdK1evfLnlRqHhk=
X-Authority-Analysis: v=2.4 cv=VsITxe2n c=1 sm=1 tr=0 ts=6a83d1bc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=dX4k0HLE7GFHfSP62QsA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 0SS3763jGaVL86aVT4ZJHX2gG9JZYNSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX305FJ9jla19y
 9EIdcDuUj2qKKvNhZzw989Dq961v/e/d89FEH14BPHhO8+HU/I07r/e/vhbnAzJTZJwD+7LG8SI
 BN38BvqD/X3g63lfwIKjS1MhseIo+yQrhSrSOa4dfSks5XAZjJTcM3OLFSspGwkAgRi+g5Ydtxw
 ZkYqwkcKtn94ZExUy2kqNsXRKaH+AOBmwSB6LP0pcrlpyggW8fhgBBFgsrsf/uq2daRaFpcRTCF
 JLXm5fLYWbhBe9d3xgVfmCYyVVcIn9x9m+lN9/JDVQtC3XRZf5Piuf1A2QKy24FlkBvA4vGJQLT
 OPUW1xsheSVZaNGHaXY+VxqrExMTHkLz/A2T5EDg8Hs2RPPXoEQlATBDqi2Ogfq4XUvhdanhh1p
 hsZVEL5UOEVxzNiB8RTUZo+TWUm6QvGDVliDa3P3JwPooOMMtYvSKVCXE5ZtVcID+uCD3m4hPjl
 OCDlTRzbZ9Izyr/UOLA==
X-Proofpoint-GUID: 0SS3763jGaVL86aVT4ZJHX2gG9JZYNSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180024
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

On Thu, Aug 13, 2026 at 03:45:18PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/24/2026 5:36 PM, Krzysztof Kozlowski wrote:
> > On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
> > > Kaanapali (SM8750) and Glymur use two display power domains.
> > > CORE_GDSC powers the main display hardware while INT2_GDSC
> > > powers a subset of SSPP blocks.
> > > 
> > > Allow the MDSS bindings to describe both power domains and
> > > their corresponding power-domain-names values.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
> > >   .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
> > >   .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
> > >   3 files changed, 26 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> > > index c6305a6e0334..c0b650ffd9ef 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> > > @@ -31,7 +31,8 @@ properties:
> > >       const: mdss
> > >     power-domains:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > 
> > So all deviecs now get 2 domains and this is completely ignored in the
> > commit msg.
> > 
> > Best regards,
> > Krzysztof
> > 
> Thanks, will modify a proper commit message next version.


And add if, enforcing either minItems:2 or maxItems:1 depending on the
compat.

-- 
With best wishes
Dmitry

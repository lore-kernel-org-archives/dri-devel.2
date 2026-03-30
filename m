Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC441061B1E
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F1F10E690;
	Mon, 30 Mar 2026 19:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozLdK5hb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYc+WWw8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DE710E690
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:39:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UEDF331090787
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+34cAjsx8bqZcK2OkX0asGC0
 QUBSB0eVNVg2SXT/ntk=; b=ozLdK5hbRe0J/retiIb5TPOC868uoqZHr2IQJ9fL
 WdmtH7fVwbeLsAcTMgpcl3GGvM0aRjCTfPNLrT6b/mpzZL/lL1F5/Mfi1640T0qY
 k77f71kn484ZiR/P0Yd8dMsb+YshgLoh8am/RkRV3GmaYe9WAWT1VpcRFAxASmWX
 6ZH40ifh7mNVYUlicNt6YpykDGKrdU9GcLv55e4tU7iSGWJhSnMLERfz4X2uVAWI
 DF2pUkMubT7xFOeOeYcXEFceEX5FPkKWrO35uzQ3ydW232+LQahI2sz1ZpQMUHoP
 6i2LdmzD4QkHHyKeWrX/jlBJTth26VPB/dLaWiqsrZvUnw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7trd1age-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:39:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50939597b85so125683561cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774899554; x=1775504354;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+34cAjsx8bqZcK2OkX0asGC0QUBSB0eVNVg2SXT/ntk=;
 b=MYc+WWw8xnNhU417qEOiqXQsNO40bQ9WRRMVcybTqO47cBGUu92fZwA+d9H/IJTEcF
 kyx3oQ+GSQhoVNfidN4dPxtInsnv5wZ1apI5vwwQeO5TtwUUMNzvk95myjEfHUHfXnBH
 dVyL3d+ubBew7xJ45Rc7trdzpsN/ojkFAVvNGCGKspaWTIy5r5EBuX1oo0nslmq9oF0h
 VYNnSGEelUAIBmnehVHudlTS/8aRToNH/jqvu9U26lBGRKzuJQR83iF9/ConBks+Ti1u
 mMzfFpdjeP5XknHzYJiSs6VMdrJiXfkOH7pDeAPK8U9s9lZ+1XJUVmKHML1/C4dPRNtU
 QQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774899554; x=1775504354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+34cAjsx8bqZcK2OkX0asGC0QUBSB0eVNVg2SXT/ntk=;
 b=VEqm7v/CKeGwMu1cnJgqYV5ZprolmxyI/CaJQbVXgP2cW7ADXBxvX8q/ibK72I6Sm0
 mBAv1hlk/hBiRN4l3ZEar3g6s9fb80aHWhkY0hPx2/PWPWQ0fNJRqPwyFtM5fEjnaJoG
 /9GCw8pa4cti5Czyl6TvhdlHqPvFqUK/k2Org1GPEWX41LMAkz5qHwV169X+syh1WJ6B
 P/Gyir4AGSVtuFD+eAebZs/0t6Q9FGDZ+KgPFMAer+AskNmoHyuIHgO0eEZrNxOQs8He
 7akQCpb/aXz1q64UWHDgn3Q46g8oygYqz17Zn5RYC6S7WU1hGR8xKJGxU1wrGMoVUatO
 HTVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+JMiKFi1Mw2K41u0aC8XTDq4rSBKr2dG1Un8yscGaMTBKWR9AtGCDojhesLHsoNFsr7wJO7M3RGY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5mjv2InIE4DQyBUvS1AYQqp5G8NbMH26C0Khs0I5N0KXimooq
 yEOAWIr3DVqqPSXovkiPMKXeVyt1l2i63ephT4IfHZmR/XdDocj01zcCVzeqMLmBjgdwoX1eukd
 ekZwa2QfbgW5/xt4gckaGBhK9QzPMDdmgLTjo/7rRRHj1yt0QLpiLmFDULvfbxGAY0e+TIoY=
X-Gm-Gg: ATEYQzyZqGFPzn69n7Ngu9codKlZs+UI1D/pLPdunfP2rhAq3nQ0z8hQ9B/8YO7TmBO
 5WJz9y8INDgAN3QPSyuSh01iRA2ToKmz1XtcfNAb3Xe1IYu7eBBB6P8MNDZ0ajTbaNRE+dQz7bH
 iuWP/IA+TCHmcpK+9iTt3Wet/bE5FRprpTvhjfP6x0Yws61QW02MwAHleeuYhLVVl9NpHuBvUwx
 HEECX50+ny+0ZPeyiCWQ28WxCiN0zGPHdPgxCtOTejwLKdy+yjdJ/HIK+8lWYv+WWpD6rRPcJ+B
 CfU4/KKgvmj2S5dz4b7YgZPtNWPVgKWsh7hma4lqW+dek4GAD31sY3b046olqGcAMJQL6/B8TUn
 qypiS63k8acSf4u3kv6CUMeh2Kny0iYNE3kcXexwR9TrfdDfZ0nhREWqekaVUz+C1R1KI88pxIJ
 yhIG4Te7sRpPFAOVs6eMcSCj9RhDKF27K7TyM=
X-Received: by 2002:a05:622a:15d0:b0:50b:28b9:b0a1 with SMTP id
 d75a77b69052e-50ba391db58mr184558841cf.45.1774899553836; 
 Mon, 30 Mar 2026 12:39:13 -0700 (PDT)
X-Received: by 2002:a05:622a:15d0:b0:50b:28b9:b0a1 with SMTP id
 d75a77b69052e-50ba391db58mr184558421cf.45.1774899553358; 
 Mon, 30 Mar 2026 12:39:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b144f4eesm1848348e87.57.2026.03.30.12.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:39:12 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:39:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: display/msm: qcm2290-mdss: Fix missing
 ranges in example
Message-ID: <yjow6vpqb5cxyhnvepa3humyhgnea4vrttlpdvzvh57ubbet5k@vuqpytq2qq7q>
References: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
 <177488647743.633011.6769674149013868210.b4-ty@kernel.org>
 <wsf7oet6r7d55i7f6cdwgor4cqu3hzgqcv3r6lmyfsoivzgzls@v5z7bbea6fxe>
 <05610919-fde5-4cde-92b6-a35c93e84547@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05610919-fde5-4cde-92b6-a35c93e84547@kernel.org>
X-Proofpoint-GUID: 12dkTohDVFkCjf9y7PgsR6FtP7MH5uEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2NCBTYWx0ZWRfX2Q1MMZhL6Fxi
 LjmhpCX9ZpvT4+rz+JrlGrzFdSkg/mQL1ta3Li+uDMDsGYyVhYOqIfBt/pyGmFuyzKpo0V1Ynti
 wmJdGuny3UhHR5ZHBBWmKlalM+b+bwYUmlABE7YCGma3Dss1xoLTxx9hQJ9X6LZaVsUV9RzjZBZ
 YQA5KCLYGRZldAx9ftx3p0rtu+tuAAQLIvDXnyb6u5b4/ben4w306JCP4Zd0G3AYDvGzU6AmeCC
 p22zEi5lKNnvvNAxpTKw5Nu96yI0yRkWEEB480b3Ub92WJl8SJMp5Kq0DbD0Y326JrAF+sFl8JS
 qf3yO70XXe9K1kNFvbcy97k+3luW4PqqZOTv+YjGeX7L0Gz+Dx4oPZm9NO4XPHoQVg3KaYdW/iy
 Lio0HvIDS5P5WZIF2ACzwxZtBcxeFtnKrID/Zi5HiDnu9Ot5Nk30b+LRqdnlWU5sPW4yxFfg6SD
 BWjzFrACGRiOjX6NqqA==
X-Proofpoint-ORIG-GUID: 12dkTohDVFkCjf9y7PgsR6FtP7MH5uEg
X-Authority-Analysis: v=2.4 cv=H8/WAuYi c=1 sm=1 tr=0 ts=69cad162 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=vZIQzkT8WsM8uZE4rHEA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300164
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

On Mon, Mar 30, 2026 at 08:55:04PM +0200, Krzysztof Kozlowski wrote:
> On 30/03/2026 20:50, Dmitry Baryshkov wrote:
> > On Mon, Mar 30, 2026 at 11:01:21AM -0500, Bjorn Andersson wrote:
> >>
> >> On Wed, 25 Mar 2026 13:22:10 +0100, Krzysztof Kozlowski wrote:
> >>> Device node has children with MMIO addressing, so must have ranges:
> >>>
> >>>   msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000 (qcom,qcm2290-mdss): 'ranges' is a required property
> >>>
> >>>
> >>
> >> Applied, thanks!
> >>
> >> [1/1] dt-bindings: display/msm: qcm2290-mdss: Fix missing ranges in example
> >>       commit: 88bdac5443e5269bb39c4968d5ee0becbffe3f82
> > 
> > Hmm? I don't really mind, but...
> > 
> 
> Please read changelog in original patch. I was also mentioning this on
> msm IRC (although not towards you), so this is not done silently.

Okay.

-- 
With best wishes
Dmitry

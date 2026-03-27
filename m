Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2140710F2874
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 22:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEE210EE5E;
	Fri, 27 Mar 2026 22:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXbgFEkx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAyGx9Ms";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892C410EE5E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:57:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RLfwid4127104
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZD0T2UGNWyjaocuRVZIPGls5
 8uRnomBelAEtEdMD7Bc=; b=LXbgFEkxwdptNZ5NlStNkQVeG0+zkErpr7g1hdkh
 D5YSMubcjdDfNB2k4oooVFglvcGyuA7HaqsNk1hjQixBz2lZCbhRDf2PLxMI4jpf
 z7+P5+ZfVj3TbHR/vergFA3xy/CJS2ihzmUAxo4zAuClCwaONq1AqOci9KaZ1+4Y
 s6LPMx52rifD6nq8vB3wR1k7FAi6/dQD7Yv4TzOs0BFHXjB3krKvyoSk2Zx9UnZx
 DD2aDOo+Gf2yRDpfuoZrmRI2gan1V28z+jvMF9zBDgwEprFeDgBdeUjbGIRq6ide
 BozXbP3Eij4f2Qzvs5845yHX7x1nPjcYB6boetdcxp/qOg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn136dq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:57:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b274f94f8so6072821cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774652256; x=1775257056;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZD0T2UGNWyjaocuRVZIPGls58uRnomBelAEtEdMD7Bc=;
 b=FAyGx9MsppLACdf6W+QrX34jzXXyIfpBQIr2v/QVZgxemS0W7kh+vTsr2FM7N+8quT
 VVSK1EzJJT3r+TCiOQdXwzvkcONpbZe68WOuMwx83BMqcMDYMgcTD8ZHJCG31fiOYEhl
 JaFIyET7DVU5zLyiBT740Q/hvuteTuqDB7ejnpE3QumMNFonGs/4Rg5SAhRWZCqjPyDD
 kvxE7HT54NPFL6xXdBuZLNdfJDiTzAJ40n+sOOIdt9/s9zz35H1X067clAoJKm48Dk5p
 7qqGkGL1L4VH97t4i3eJv3IBmFmGExaonvsqnOyL/rn/SfPvUMTT8e5tuSf1yQo5w/hP
 bgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652256; x=1775257056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZD0T2UGNWyjaocuRVZIPGls58uRnomBelAEtEdMD7Bc=;
 b=Z6nJOaa5Qj5Q9tZO50tkgkOkFKwE/og/DkRsgMyHzcZgLHab9L2v2f4gXYvoo3OGIT
 uFjjV4APbtZj33sHxUH5RvtK89SIUoq8OQpmEkp/P9/CojM37mT1ohR4uu9WnEceI5gt
 DrI0EdQEu+pzwOzVcVJ/6VGSVOPFMPSKOeJZf9xCkxlx8kaJ1a5ibOCCI0dLF4vHwB2G
 iIcaQJjIrnU1y19SmkB+v2t7jm2WRn/64bFLqjrXDdxronYkqk/bRfntiu4X11ujuePR
 hbKvlDuRmJuntDSvbRysQ8eehRe0r1lyG09RkB0NYKPyiwfWOtuDXh78J1Xs296aPmz4
 WIUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoQgs5VnvoJJ0F3bBI36TN1KxiMCCh9FKcVx6ItpTpJtKUuv6GQlyYqh0HF0Q2DLCDOyF35XHAn+0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuzV0b+ubag9jbxXlX9AcBSq4WiQ5xoS9DnG9tHkq0NbPb/17X
 KlwNaDZRn2hFVrftFYFOabmSkaKLmiZXukIU7i9tx2yT+Uqpkl/BlbfoeAqdjvxS25bkkqd5IN4
 xe3k7Sl6p84ANU7UmAaBhi7+FY66T9pBiriQjq/KIhgrGaRLOsp95kkGmyGCYj7Kcd1Y1hqo=
X-Gm-Gg: ATEYQzwiE1r+zpxN2ZCFVRfZ6s0/OmdW30nacNdCvGAjP0Hr0d+2z0tex6Y90DT8HWp
 f/4hU5MA3TH2MertMLOxZcaefx17SwDFG5EwZOlckHnhaXP+e2EvOB+HMeOqs/MMXe9RXz0MZ7F
 2MeWzUfWqvkxvY4HhZn9528XDQfjwBH5uRSwalT0u+2RrNJ/bco0ry3HCxlAdt3m0jQFHWqhmZD
 apZl8QjYNdOmGeu8Tl898TF0fRROpuYPbPfhm++cOugoWfIxvokpG5h76wpEapuCd5rf3a3qWIa
 TJnnRNqfmVV3LkDtB9mBxS7TroQDN+FflWkQfThn5emnG2UbShNTwezM2E6qiSk8D0LsHfuAgb2
 M9eVuT6300BgU044O64rGs0rD/qUWpmfmlpakol4imHWRV3FFNu87Kg3PW5rT0K1W8VXfcEvhz4
 h/0PfGfOI4ew5N6vnRrzGFeB9hEJnsy8fd1H4=
X-Received: by 2002:ac8:5992:0:b0:50b:46ee:5aed with SMTP id
 d75a77b69052e-50b993c6a6fmr91618461cf.10.1774652255704; 
 Fri, 27 Mar 2026 15:57:35 -0700 (PDT)
X-Received: by 2002:ac8:5992:0:b0:50b:46ee:5aed with SMTP id
 d75a77b69052e-50b993c6a6fmr91618261cf.10.1774652255243; 
 Fri, 27 Mar 2026 15:57:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b140a4desm70884e87.33.2026.03.27.15.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 15:57:33 -0700 (PDT)
Date: Sat, 28 Mar 2026 00:57:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
Message-ID: <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE2MSBTYWx0ZWRfX6G8tDbTbflpR
 Li/Y59vpsVlEfLvYn+sA+97yvxgmI49OrwNSBlfQRLNWoC0H3seLtLSUlR3uIJhHfxJRzkza/kF
 QT/Ic1/5aBpK33NcZOks7P1ghQvSZdywMeZURg7PHrT0Dg8er26ut1vJWUQq+U32t+aC0ZlyRLG
 VOykwdDzn3QdaZLZWn1ZERXzQvodJ7rPLYhU6DE3D48hOelncPNjUbkDh8IdFhou9EskvNl2zIS
 0JTv4Wy+SpWJH0RtkDypjDR3wYiGKcptiHo14l0bnTkECo8bqftzDMAVz+v+O0HCr+Vcr2FiQFB
 lAHxn9byGXdtkgMONsbSsd+dbBsohfpdQj9whmzsvXlH+nNnrsZRAUHIx9V4UNuNKvxhWsxCgx8
 +nfEENOddXKTswkem9zc10U3I5lC1kpG5BfNJF0uuq72lS/qrJD6mD43DwXOupNVVrRkjGs+o46
 ChUmprpRxiXjUDURZow==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c70b60 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=sfOm8-O8AAAA:8
 a=EUspDBNiAAAA:8 a=ER6jexHYGgKHINCZH0oA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: 2ozsyYo4mzKrCOwA5RipCjquCakqzPG1
X-Proofpoint-GUID: 2ozsyYo4mzKrCOwA5RipCjquCakqzPG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270161
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

On Fri, Mar 27, 2026 at 03:30:49PM +0100, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Add the description for the display panel found on this phone.
> And with this done we can also enable the GPU and set the zap shader
> firmware path.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

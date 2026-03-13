Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34E4106FD62
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE65010E376;
	Fri, 13 Mar 2026 00:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4P0Hlc8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TCf6Mhwo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD9510E366
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:45:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CIH8Lk4026471
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PuLD6LTrr3Q3pWoNLdnKssDY8cst/Ajrx824lOib/70=; b=R4P0Hlc8FGygrGJE
 l8r+7f4IcULEpx6CmjzAIcySqZzvgAryyJioOVMksbXjijdlO+iuvvHVr3wlpuBD
 Jq007k6bWEzSimpG11ZoN+Hy+yumz5bOGNOM8ZkeI9iaRswULRAsdbIOTXAm6Lpu
 MtRqwm3PiHfcwcWoaQyZZkhYFnUgJyZ8U2f5k+KGbQN28IcSdzwv7+maqORYwquN
 L7hf+DvpFTBtTvPMYg1AtA3nf8JpSFWn/FgPm6qIwWeZViaODI49UqNKZv/ZR+Ho
 2WrBLdfMDtCQJ+WuGIUBmcpdIehs42JkxjSX25B8eoZBVO68VNWi5wMeUWV70TDZ
 yckhPQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh54uv99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:45:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091a96f0bcso91013711cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773362746; x=1773967546;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PuLD6LTrr3Q3pWoNLdnKssDY8cst/Ajrx824lOib/70=;
 b=TCf6MhwoQIYiAcnvSuCQjicXY9td5Dvca7jKH7Lk5eDfKPse7JAIMabjgbAsAupc3B
 6kJBcdcNpAAmY+P6jlX9UBukhvPmgdnHsQkIochyGYZY5D2qtLkdaVesHz4NeYa/z9UY
 VN9dxg0UoJRVZL16v0F8KmywczWCRAEcFnD/adKvdEJCJ/GtStMLbh9dVe8wZqLfuHk+
 a0zzbzsbAfN9THO5qNFSPMQYghm3ZO8zUsGXEynkxoG/xfoJSfBZrFrJFvztkaTATVDS
 97Vlz79BGwZ9Tm/AtEcHGzxjLJ6/eckRoqhx4J9OjZOT4DT3TTUjK/e71OEjpF7aiKOT
 EnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773362746; x=1773967546;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PuLD6LTrr3Q3pWoNLdnKssDY8cst/Ajrx824lOib/70=;
 b=QOIcc2hUcMwqe3MlL72auJpH2uMalAcFka0aBQRZWj7+rEXjMuUshvGBzKb2ZoVcfJ
 1KdAe0GOqxXdUnZpAnb1hgoboPd9PYTXYq6/pGge4IhZXbzTIOlrpqE/CmaWNGuucdv2
 2Ei2321H5nF1MJYmcmoUcvSbRRKXVJW2ZHZx3z4JA0iCWbxNivSaWfCmXbczqzqnsUKp
 TdB9o6pbwFNbGo/k7IulrD+2a+Fd7Zrk1hszVZSkXvIKSQZm2iXqNH/fjmUZBG74GkZS
 gnQMFyuHbKwcbV4F05fC3rDhRBWPykHXKqI2zhrHVPSs6fClWZiYkhZ9fxHkOReGSqlZ
 jevw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiTVaFCNzwbZ3WsP0P5c5KyGGz+cqkoM6uyKfgE0ShdAdaXVbF4DeTTNskHZTUbXYw4avDK6i2EaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYvd4JcczG/JGaMn91L3GTHopDm48V2khZmV/PzxeHoxTUK4eI
 /N+TvxommA91+Un7zdtXKDydweDHH/Mg71B/6gIRmLS98wolLGk2WtEtDFNKEF74YbmX2fzwAAF
 TcVJ8dHDBU1+LHtsqytxIqN14lUGO+2GQGXx8n5CkyORJWIxpFKMfUc508JagdrOwj6kjeGY=
X-Gm-Gg: ATEYQzxwwEqlesA6c/eQ0acSAKaPdxg9TLyBUSZbxCB0W9Ozh7oLDKvkBRRnQ0jN7bf
 rNqN9luBxmkCK1ZUnrl6hemo8Nr78HpCth7a36GeRayxQmQeS/ICJyRU85qe+zkF/aZilzfgE+I
 39omElEbNnATPkvEpGz/zQBSbUiGzcnZnktmOwBTim/+2hURi8y3j/pMbsSnU5ZhaUOddko9e5Y
 4k9CMQ0xO3Ucg/v/FkD8ZH1TzXdW2FrachxEjG0nrpHwgP5nwU0FaUJXpJ+ssB9LmQclZPduOBS
 +HLteZCg1VmymsBcWVz4zTlF3GLFrt62al9XTR0vOnnn3nwSQQj41IHSvky52keWrntBf/QRAKC
 mGyy+5ZSS257H4X2Etx6k6RU9uusTu1+QIyx4c7a+7tb8YuNR37Oyshc6Db35BKtncuTx06P72V
 GTte5puiTJKeP6sP3yRNpwu+fOM1/UnIpvfn4=
X-Received: by 2002:ac8:5fc9:0:b0:509:27e7:a067 with SMTP id
 d75a77b69052e-50957b89146mr21206701cf.6.1773362745757; 
 Thu, 12 Mar 2026 17:45:45 -0700 (PDT)
X-Received: by 2002:ac8:5fc9:0:b0:509:27e7:a067 with SMTP id
 d75a77b69052e-50957b89146mr21206251cf.6.1773362745220; 
 Thu, 12 Mar 2026 17:45:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156162ba3sm1219995e87.47.2026.03.12.17.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 17:45:44 -0700 (PDT)
Date: Fri, 13 Mar 2026 02:45:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Junjie Cao <caojunjie650@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Jonathan Marek <jonathan@marek.ca>, Eugene Lepshy <fekz115@gmail.com>,
 Jun Nie <jun.nie@linaro.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <jivp322t6tkw2jcvfurghhogrveqhamh5wxkptkygiel2dsnf2@k5efib7zixow>
References: <abL8qtbnNzspJMGC@prism>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abL8qtbnNzspJMGC@prism>
X-Proofpoint-GUID: 7rJ2jk68yHnK1WK76U3q68IoI57LmdIv
X-Authority-Analysis: v=2.4 cv=BNG+bVQG c=1 sm=1 tr=0 ts=69b35e3a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=RAbU-raeAAAA:8 a=pGLkceISAAAA:8 a=tBPNNmzy5-6KNAIXalIA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-ORIG-GUID: 7rJ2jk68yHnK1WK76U3q68IoI57LmdIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDAwNCBTYWx0ZWRfXxKs2YT0JIlRr
 QpZb4zhRZUMUk1sjlLP0q5gAsPgg80iXcTgBHymLhxS3O32HG5U/B/5ox+xkoFifojrhUpSpTl0
 Zrk16hTrq9/8ugDmndF7AmDcYr1Sa5RHW7uSjnUFQrb2fWuz21NZg38fK/iOOGhluxzEuql1I7J
 0FxMPXl0Cki889l+9LFLZTh333WucjS9OIBmtNIX2ly2+u6vpnn7UnkYrDNucUQGDXh0GdhH9XX
 QFBZiLqjibIfK/JLM0brlBAFzfL/oaoIrn7bsUj0taoonezarl7mMrsiZ7PWTvljYcNcfpFVT0S
 Z5lcfssg24N2WymgmrGpd444bGE8BI2CsByPrvzAvx3qC5ywrHF5sv6SIT/32IZK4iTQcJQlZus
 V2Ci5ynvpRpsM6wSrlR80pXP6atXFlGgfEXAcgP42h4itqDh/LmFqXtC5BTqRlpoSO8GPYVwemL
 TocQLkOhmysrXkXu2Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130004
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

On Thu, Mar 12, 2026 at 06:18:59PM +0000, Alexander Koskovich wrote:
> On Mon, Oct 13, 2025 at 05:34:06PM +0300, Dmitry Baryshkov wrote:
> > On Mon, Oct 13, 2025 at 09:17:04PM +0800, Junjie Cao wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年10月13日周一 20:31写道：
> > > > On Mon, Oct 13, 2025 at 07:04:43PM +0800, Junjie Cao wrote:
> > > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年10月13日周一 17:39写道：
> > > > > > On 13/10/2025 04:52, 曹俊杰 wrote:
> > > > > > >  >Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com
> > > > > > > <mailto:dmitry.baryshkov@oss.qualcomm.com>> 于2025年10月2日周四 10:04写道：
> > > > > > >  >On Wed, Oct 01, 2025 at 09:59:13PM +0800, Junjie Cao wrote:
> > > > > > >  >> From: Jun Nie <jun.nie@linaro.org <mailto:jun.nie@linaro.org>>
> > > > > > >  >>
> > > > > > >  >> Some panels support multiple slice to be sent in a single DSC
> > > > > > > packet. And
> > > > > > >  >> this feature is a must for specific panels, such as JDI LPM026M648C.
> > > > > > > Add a
> > > > > > >  >> dsc_slice_per_pkt member into struct mipi_dsi_device and support the
> > > > > > >  >> feature in msm mdss driver.
> > > > > > >  >>
> > > > > > >  >> Co-developed-by: Jonathan Marek <jonathan@marek.ca
> > > > > > > <mailto:jonathan@marek.ca>>
> > > > > > >  >> Signed-off-by: Jonathan Marek <jonathan@marek.ca
> > > > > > > <mailto:jonathan@marek.ca>>
> > > > > > >  >> Signed-off-by: Jun Nie <jun.nie@linaro.org <mailto:jun.nie@linaro.org>>
> > > > > > >  >> Signed-off-by: Junjie Cao <caojunjie650@gmail.com
> > > > > > > <mailto:caojunjie650@gmail.com>>
> > > > > > >  >> ---
> > > > > > >  >>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
> > > > > > >  >>  include/drm/drm_mipi_dsi.h         |  2 ++
> > > > > > >  >>  2 files changed, 12 insertions(+), 15 deletions(-)
> > > > > > >  >
> > > > > > >  >Please extract the generic part, so that it can be merged through a
> > > > > > >  >generic tree.
> > > > > > >  >
> > > > > > >
> > > > > > > Sorry, I don't get it.  The generic part, generic tree? Do you mean
> > > > > > > the drm tree? `slice_per_pkt >= 2` is seen on the panels of these
> > > > > > > tablets that are equipped with qcom chips. I don't know if these
> > > > > > > panels are used on other platforms, and if it is necessary to do it
> > > > > > > in drm.
> > > > > >
> > > > > > There are two changes here:
> > > > > > - MIPI DSI header change
> > > > > > - msm DSI driver
> > > > > >
> > > > > > I've asked to split it to those two commits so that he change for
> > > > > > drm_mipi_dsi.h is more obvious for reviewers and so that it can be
> > > > > > merged through a drm-misc tree (or through drm-msm tree provided it gets
> > > > > > a necessary ack).
> > > > > >
> > > > >
> > > > > Thanks for your clear explanation.
> > > > >
> > > > > I don't mind to add the field separately. But should I submit it
> > > > > with the panel driver together? Otherwise, this field is unused
> > > > > for a while.
> > > > >
> > > > > However, as you mentioned, this is not a part of standard, neither
> > > > > mipi dsi nor VESA DSC. Recently, only Qualcomm devices require it
> > > > > to calculate parameters, then we use them to program registers. Why
> > > > > don't we parse the field from devicetree?
> > > >
> > > > Because the value is uniquelly identified by the panel's compat string.
> > > >
> > > 
> > > Yes, it is panel specified.
> > > But can we set it for every panel like
> > > 
> > > &mdss_dsi0 {
> > >     qcom,mdss-dsc-slice-per-pkt = <2>;
> > > 
> > >     status = "okay";
> > > 
> > >     panel: panel@0 {
> > >         compatible = "foo,bar";
> > >         reg = <0>;
> > >     };
> > > };
> > > 
> > > or moving the property to panel node? We access it from child node.
> > 
> > Why do you need it in DT if the panel driver can provide this
> > information.
> 
> Hello, I need this patch for the Tianma TA066VVHM03 on the ASUS ROG Phone 3. Is
> the only change required at this point to split the generic part, and is a v2
> in the works to address this?

I haven't heard anything from Junjie (nor from Jun Nie) regarding this
topic. I'd assume, nobody is working on this.

This patch needs to be split into drm and drm-msm parts (they will go
through different trees). Please describe the data field, clearly
stating that it defaults to 1 if the field is unset (and that most
panels are expected to work with the default value).

An alternative (and maybe a better) approach would be to add the 'all
slices in packet' flag, which would clearly identify that it's not about
having some slices, but about having all slices for 1 line in a single
DSI packet.

-- 
With best wishes
Dmitry

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3EDC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C583A10E514;
	Tue,  7 Jul 2026 16:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MiYr/TPI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYfLk6j0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2209C10E119
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:40:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTLZ0018214
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 16:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ngMJFXW0MVpSyT9cIuB08wDD
 gujyroBQVzUzKlhc52Q=; b=MiYr/TPIV1tgnI2ssrts3PiyItGY+zxGj8RBOb/N
 1US8orSQS1Kqkf5lDLxiYel8uxWhE1agG5lZh4l9NrQ1+3s3uU1iu/VQEr93MVLy
 hLqRCwJEW2fTBgHh+GNsCmTRW0NE+TllBeUgadAL6gokqzklRbdaJk/4GDfpKVaS
 GHputQFD0WBQhDtgOgcQjtX3N97uCAAqy2nFq2EYtzlm1iqSm/Qqzu8Zs24Dk0Fx
 qg0cPK8IkgftVeeByYZ39VmtZm+mreJ4g+8P+NdkDKHnkoDGrdFPyJKu3opDXq/4
 EQnaEm8R8JojofSQZN+MI6uHIH2aGXhvJf9hoINEC8deWA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep26ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 16:40:03 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-967552ac7f3so505982241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783442402; x=1784047202;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ngMJFXW0MVpSyT9cIuB08wDDgujyroBQVzUzKlhc52Q=;
 b=XYfLk6j0Pe2+JDUoUZIzdFimoi+YDLoRZy8ipPtDHVBwOkD6JjNFvpoMGoJMKNsOdO
 eOMNOj466Ej7MOEuKO63nzEL6LvICM6YWKoe4XOAv9E6DtFDJBL3fldftVV8GG8qJ/xs
 g/l8LeUed+8EzkMOPk8B1RxAzrvIj48m65TQpYWsCfOa2Xr41IcO/9nqpD+lzw+nk8My
 x2XcSfM5zvQq4XWtL6YwsRalkFIlyxrV4esFN5Rd2URA9XJUD3jKBq1aMEV8U8bp+sW5
 BM+5whJG9A8SDiSCenb8dAy9VCB+oHPyBg5wn7udfcSFP6ozJs5Fb0mt0okBOOTZod4j
 fmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442402; x=1784047202;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ngMJFXW0MVpSyT9cIuB08wDDgujyroBQVzUzKlhc52Q=;
 b=kX43pGJNlZPS5bDbnZXrcmgp9MGMssOsIjgbVrMcOUeJWpR40lUMcM+LpTePDCI0zW
 ZzkCGBQsQYcao4TQv89kPkr093Ncnp1NSW3wQp8zGoDmsfMtRm2vwrx5sTIw9z+iTD5S
 JHHK5yEb1rWH4UZthjSImB1qC4lUQ40sr0txvG9/I4LOXWRKs2Ucm6VPbvW5axeFn4cD
 PER/IXCpjqJ/POOXHfclwS6lk8Qyxz2dzLgjggWOaRx8Z39rjpPoZgoYR7T6mmYYKSKH
 Lv/haP2Z8rr4gxe1G60u/B1xNOZiBPCDoB9X/5X0huTQ24or7WVRuIlg84C7/CZZ59P1
 m2TQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR0/Xn65UBcqbSz/9M5FqHkKllm+2etuvPi+83+EESC5g9MgjbPzikmZkVgMN4o/zi6jdHpnaLe4E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzLap/bhMUXRmwNtjpe4DQUXFEcjkL0z8ZcBBFdEYQoWADt/Fc
 5WoaeZlWbDF/zuVeqiT8zW7AinHdBbugWXa6ErH2K9nMSfSZA6ginMQQ2vuZGhwcfChgloi46ZJ
 ns/yXd24UavCAy9+O8jMt0jbUwXQ+fzL2aA0iAOx/IxGKJbloIpV65JbJZKEnhRiXO+tVRT0=
X-Gm-Gg: AfdE7cmHVjxLd9vcOtRS9prCxU/wzvTvqQRCpwqH1JhtSwoeyPyt7TDii0QnQ0sE0qt
 DyKn2xUGwHub3mTctAXQ8Ba7VDvER+tCcEtcCAKZsA+tNntjwj5r1v/sHvt2BTIjZeuX1qtQ2Jr
 jr7MXRry4bky9oT9LGMEu75eo9RDuEUpY2JOr2iSG0fCWQBbp22D2IWh8pgS4ETDlondA68xmNq
 cnRIJn8KfJD3k9K9S3SjYysvZUXVIqLhUnK5XZV2x6pBz5Nkq9OpvYaawf1qFVeZAkaUneCd6zH
 sUKptlQ4BAy1/1t0neoM/WCGEYW8ou3ANO+8B3HuAHorK4uaGof2SaikhrD3Ce5BxYJHybzewIi
 xJ8g6WRNsnz4zi+cgbTsPFJLAnHYwkdbSyKgYsipqahzEuE81pOzzu+VSjB13P6o6n8FNIKVPNY
 63QyO6ofPQpyLMUBbWlgRorU9g
X-Received: by 2002:a05:6102:5f05:b0:738:be7b:add3 with SMTP id
 ada2fe7eead31-744b7ade412mr3295758137.6.1783442401892; 
 Tue, 07 Jul 2026 09:40:01 -0700 (PDT)
X-Received: by 2002:a05:6102:5f05:b0:738:be7b:add3 with SMTP id
 ada2fe7eead31-744b7ade412mr3295690137.6.1783442400917; 
 Tue, 07 Jul 2026 09:40:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bb3aasm3792026e87.53.2026.07.07.09.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:39:58 -0700 (PDT)
Date: Tue, 7 Jul 2026 19:39:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
X-Proofpoint-GUID: DUZ-cBKVZV43QeMdnYSIJxWF88i4_Nwq
X-Proofpoint-ORIG-GUID: DUZ-cBKVZV43QeMdnYSIJxWF88i4_Nwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX/6EdUwHSCdlH
 0wXDXDNilyCkODtc7W7+TpcCAl6FZfE19Ho9aN/MWZuH8kon0742VXl+2KkmLuBruh+mxiC3D71
 J72OdBbVDs3LYwQKWd3R1kjv2nJSa7BTixeEhriMk+w0A0vu0VFQ27WCaKutt+hy+hj+5FtNzOJ
 /G28gJhbJXKmF7PsgCJzOciQ4fC3tnbH7CazGaLiwzIYyv67Hiao9jLKOaW8X+jZq++Rh6bNHCp
 WynB9cBspV+ORpK3AWlLmbCldzzuJFkFOahfQYOkqh2h9LftNCm+dMRrJSWs7Vnw0/+51loTfWX
 YlLnFC/nIQ3twdtpFTdQ9z8Z1lT+ehUiubfqWSluM9NaANwekU4ip5LIGxcJSFLKWHsExl/xjlG
 3JSUddNHpdpaO5PPD21ZEk93D+ZjMkSlZzlO1p119KX+WYR0CaUnUf+TVik3N7t6QV+cvtFPuUI
 zxnQY1Eicck79RIGQfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX0wDVtGq12909
 9BG4VYwMVSmDjl/QD3cd16DKgRa9BgUjcZrtTHcA1WMNeFEiljnf/Lr/xzsQjAPg9zlJpnJ+1PF
 KeGjuP+NWdTaP5S1VUpg5rP7bmI889A=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d2be3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=1fOCVGvR8NE8L1w4xeIA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070162
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

On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> > On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> > > In order to associate the SID used by LPAC to it's own domain and
> > > context bank we need a separate node on the DTS.
> > Can we use iommu-map instead of adding a new device using the same
> > addresses? You provide zero explanations, but it seems like you are
> > trying to separate a part of the GPU into a separate device, but it's
> > unnecessary.
> 
> What I was trying to say is that we need to map sid0 and sid1 to different
> context banks.
> 
> From what I recall, so long as we use the same dt node, the iommu drivert
> provides no way of doing this.
> 
> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> and secure.
> 
> The address on the lpac device doesn't really matter. I have very limted
> knowledge of DTSs but I think we could just leave it out altogether?

I think, you were poined to the Glymur Iris patches. Another option is
the QDA driver being submitted too. Both ot them use iommu-map to
describe the same usecase - a set of SIDs which are used by the device
but which should not be a part of the defaut set. With it in place you
don't need to have separate qcom,lpac devices, no additional properties,
etc. 

I'd recommend following the same approach.

> 
> > 
> > > Add the code to look up that node on initialization.
> > > 
> > > Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
> > >   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
> > >   2 files changed, 21 insertions(+), 1 deletion(-)
> > > 
> 
> Best regards,
> -- 
> Anna Maniscalco <anna.maniscalco2000@gmail.com>
> 

-- 
With best wishes
Dmitry

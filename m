Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50E5C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD68710F67F;
	Thu,  9 Jul 2026 19:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f51JX49F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tmf8yEKo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2628810F67F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 19:39:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWqbV2563406
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 19:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lXtkLmMeqA5Txfu3sYVMsQEq
 969mvFVnJZMw0O2S5F4=; b=f51JX49FycsxSY94vb3shNav9rc4rU9buD/v8EbY
 gVT3Lzsu85teQtDP4CIdy4rdzXRUPg42PS7hEJP4b0FsK6YCzMl1q46AneSH5TZh
 KiTZVG/rQcrE/J44s0nXXL/PfqyCp9d9o8YRwns0vDcsmgnm0IaLH+DDznbFgCyr
 iU3M7WhK1e4+S6M6odp6pB0/bZCh0rGdAAEyA+rajwDiFSXUBTR/F8zsUQ4fyqgN
 Xd57d61SwMw2Xn/A3UrfTytP5EsFkWf1198r7R2i86Y97z6boIBCgQdzRf1jWfwY
 h3EwAl+O3tTATUnjedMXV0VdoK2YMibTyYBQkNrldiFmFQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3h5g6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 19:39:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-744e7c40512so41360137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783625947; x=1784230747;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lXtkLmMeqA5Txfu3sYVMsQEq969mvFVnJZMw0O2S5F4=;
 b=Tmf8yEKoGDgrkZmucWfnJzIKNFuevbznGNmPiD3IOapaEfHi2DVBjRPgqPTwURsMFc
 wyVDRO6k2vYCqL0ypSXf1XoytS9MdlW798iX84bfFxl4SvBTzDR3eaCs9uwYhgYbNC/h
 KgrdYITUsMv3sWvBDxLpK1mkzBj9MZXLWYE64MbJ6gbkb+tQtPqvkDNKEOi6m3TOSioI
 9ntaKtupdmmvmDF/VanKq5yMbVQqG/o26LuKpdj6f8K46aTUHbjbRm3ZpB8gscmeu+C4
 tAYY7woWWmxQKXXk3gD5TNBAMc3NOhqUhgH3OYNjlc03NvygtJIwV56lp87w3SWErmq9
 6S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783625947; x=1784230747;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lXtkLmMeqA5Txfu3sYVMsQEq969mvFVnJZMw0O2S5F4=;
 b=THbqZUR9MeGY3igPeXfj5Vyb4UOi/iNPAGwWgQtDInW5wF1qBNQ4VXeIhjKFF8cLvY
 qtZtPiY2l7Dx68JLOoDGHOosvcVH9+kWc3AUFHZTiwRsBvl0QZ4v0RBMocnQVp+85dWY
 RSC+1xStUtaFu2Kg4iEYDlQSenPteTNBfEKwWrbfpQpsriQCiXSKCrILOezfUn9M31kl
 Jwg2IZ2/IUbWnjAWfcqHOBhWCj6/aYSF5zRFy53Z/Zj+ubgYWijtiXBVRrbCs2L4BCXk
 9KEO8YdmWGshVfIyWkhEoh+WGmWnCfHKUP0F06BozTMsCporea3AykJUyBE9rO9lR5Zj
 /TVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvdwiJ01cWdCox0bmPmAhbMVGiH6T8hGt9TUYfJ8KPbtNiwUO880hNnXc3/X8/YAapvmNZW4XOXIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIlnWMUwN3g+NLhDCziWjtkMKiAICajbZyLtVGUT/7dHLymuMk
 ryRKxjEWev1aOYX2G6t9P1b6Ks7kRxhu+x49WQE+jWrYUcUJ4n08whIpsHWJ7DABIBvX2xXkApc
 pUKWNbWGd91vE3X7IiA9J86rogVwYMMTlmQQy+z3uOB4ATqyNQ9EqhCjzUmLIcZC86ITsZ2I=
X-Gm-Gg: AfdE7clmJ26Y97vF4K7hSHPHA6Q451guDHAq0wcdTw+3tKSbAYp8RzP8QW+F1Lgx2QR
 a8x9EwM8qFxXth1xygCC4cb6JI4VY3e2RraCTFVUs+Doj/WrM/hXURVIfzq6vBiHL9aTt2vu5mY
 i6baPGbUyxm5yZXMCs6tZZegsg4jg11VWRbBug1FDN9agzLt7/7es5xYwnOIjFyDL9RfoGLBS7c
 V6YLLun0lNCDTEZ+GT5qIpdeQDvF0TOucRpHBh6dAFpBuWURzgndN2r+ed2mICKJBelIFvSDnaf
 jQFSt8aX9iyPDwcRR7ooi2l7cxd88BejNKcYy2jJH8hnxy0FEdAocWt/FIg8cwKvIVr47uvaB9r
 9x3uSRFguXWwuCepPfdKqixbmQWuW/+FusWsQPAyd4/NrMEfFMumouJiwED7LtFb95p+zMQB4XT
 5CtOsqF3vZ9nWjG1rv8Bt1e/kH
X-Received: by 2002:a05:6102:1490:b0:631:af51:7d8e with SMTP id
 ada2fe7eead31-744e00d15demr5013512137.17.1783625946401; 
 Thu, 09 Jul 2026 12:39:06 -0700 (PDT)
X-Received: by 2002:a05:6102:1490:b0:631:af51:7d8e with SMTP id
 ada2fe7eead31-744e00d15demr5013479137.17.1783625945914; 
 Thu, 09 Jul 2026 12:39:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b13407sm5148981fa.12.2026.07.09.12.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 12:39:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 22:39:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
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
Message-ID: <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE5NSBTYWx0ZWRfXyKR28wSE+7WG
 w8A8Pk7ExQrBw3eQOVwEv70ahCKOKL2Carsn9gZNEG4XC//RQpT/ROaa19IGGbQHFaGSr/x8BDI
 AkxWm3frHorQTk4j+kieNAlTtUMkODoBbmCudZ4It07376ZEeu9TEUiLjHMWP0NqFETBrmCRBa/
 kdeGOihJ5r2M7D+DI0GECZycEMQB3wlzWejpQOn5db9T7XQ3CluaizhpUyleXk6cZqXC+0gzt0w
 8j0pTh/ihkqO2AzQVJ9kTgJxcE6bvY06wQKOnRvcYItQZDjdxHL07hd3+a8xJVyTuIzmdtJ0R3i
 N4Qatlub4g4EkiDNvB6d8d438LpBHuqXZZGD460S7zQxzKdglOO1ws4E8GTaoY+qnSTyPeDZg0W
 +DXOJwQWd5wLOzCHPQRci5WI/Tt89Ss2M2rdqNCwjg2V2xKyaQR/W8DIFDODqQOsRTxENqbyfV2
 YBFpsyu5mtl9NL5Gdug==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a4ff8db cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=9jRdOu3wAAAA:8 a=KUW68C9JwZgBSL_lDhwA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE5NSBTYWx0ZWRfX+Xx/C60mum1X
 QXYVzTp1UExNkrcEHHojEvgQZJyDqGu4ajxbdylixUDSoapX1ZcMKVCihi+UUrRgIErHmn3tCcO
 bVonAfxbEZqvql+iwZ9qQ5+HP6fZ/vg=
X-Proofpoint-GUID: odCqBT4AyXDTZ6ccCguxjyIejm69k49R
X-Proofpoint-ORIG-GUID: odCqBT4AyXDTZ6ccCguxjyIejm69k49R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090195
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

On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
> > On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> > > On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> > >> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> > >>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> > >>>> In order to associate the SID used by LPAC to it's own domain and
> > >>>> context bank we need a separate node on the DTS.
> > >>> Can we use iommu-map instead of adding a new device using the same
> > >>> addresses? You provide zero explanations, but it seems like you are
> > >>> trying to separate a part of the GPU into a separate device, but it's
> > >>> unnecessary.
> > >>
> > >> What I was trying to say is that we need to map sid0 and sid1 to different
> > >> context banks.
> > >>
> > >> From what I recall, so long as we use the same dt node, the iommu drivert
> > >> provides no way of doing this.
> > >>
> > >> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> > >> and secure.
> > >>
> > >> The address on the lpac device doesn't really matter. I have very limted
> > >> knowledge of DTSs but I think we could just leave it out altogether?
> > > 
> > > I think, you were poined to the Glymur Iris patches. Another option is
> > > the QDA driver being submitted too. Both ot them use iommu-map to
> > > describe the same usecase - a set of SIDs which are used by the device
> > > but which should not be a part of the defaut set. With it in place you
> > > don't need to have separate qcom,lpac devices, no additional properties,
> > > etc. 
> > > 
> > > I'd recommend following the same approach.
> > 
> > iiuc, the conclusion in this recent thread is to use child nodes for a
> > similar case:
> > https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
> 
> Let me check internally.

After a brief discussion: it can be either, depending on what suites
better (and if you can persuade DMA / IOMMU maintainers to let one extra
bus or not).

-- 
With best wishes
Dmitry

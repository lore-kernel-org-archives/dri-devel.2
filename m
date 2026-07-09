Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A6CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35B010E6D2;
	Thu,  9 Jul 2026 14:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgFK1CrJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PygS+96o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D3610E6D2
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:54:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DwCsh1833823
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 14:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZMd5SzYa2JtJsuef3gXqhLim
 tjjWD7XXATJ3fVJWKFY=; b=fgFK1CrJsVkn9+lyI6grWkzihN4jSETSO5v1zhyx
 yJs1ZTq+7KHtpwkUTbuaxhcF3PrJU2srnVT/38qhJ9mzZM1mQ4QjpOepB4feKAhb
 qUCPsOaFsIoCJtlfRnch1AnGKK1yM4fPZZ7L0NHLzFKXA8C32Mq4xZlovyMONOpy
 As1q+d7o8m7GZ4QhEASjtxVGnbHUjp59LzbgeSQo4ZsQoFzzQ+geRApF82v6PJQj
 J5c9kaLgTPyqOhu17GRIOLVfHTARtljnj0obrgas9663NRdQSoTqMvFGSqpoDCT6
 DLVVepZvtOFYWaPqh6A4NGKOmJiJpHkHoVfPC2GrQjWg2Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfutx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 14:54:27 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-744e7c828adso377357137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783608867; x=1784213667;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZMd5SzYa2JtJsuef3gXqhLimtjjWD7XXATJ3fVJWKFY=;
 b=PygS+96oWafg7AHho8PN820eOHSEEsaVHWnF4qj8pUUoKj/lkHV2y2R85Jgqb7Z+bG
 eQQXTM9wHlCbwzE15/kqXx2w9MMZolEt4NfcTCYkiFosUE42xdE7sYYUdU9sLLThYphQ
 59OhYzsICmbDvseUTH4B3r4SXZEFPqEeDV2fNT8NzlmmbPsBgyFUBpPd+to6DMD982Dg
 fR+O8Z9TDJfnl1ct/TQz9OhPojOf92QL5mZVJAr1jB11RWKX9zSH/lR4SLAXCqPU1tVq
 WGzD1Kpcnn8SWLAin/2qqHDsu5NuluuvZiIR9rxLaL06aume4iKTB3w+2x8mnWGfzcj/
 RncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608867; x=1784213667;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZMd5SzYa2JtJsuef3gXqhLimtjjWD7XXATJ3fVJWKFY=;
 b=RgaMS0BwwxmodtfrvY+dQYBUAD3zYO1LbAUYId61xbvHTdr9Wb+rPHFSP6wFVnieE/
 UynAerApxVD0qQ+mUwj6qCSzDPHISBr/j6M+HpQv9AZxhpv9xAVQFCCgMp4QyY3LBVYH
 tWw8+irKjbOwXg5DY6yTAVIv6fpz0enDjLvE6xiCxtCkLA6U49WNH2YHjg9L8xF9K3Xv
 rZawD3IOlJFr3iO0tQxV08UclZjhxDVfFuPSH3On1RuxiQTaj6vTNkFYaTkCUpSQzAw2
 ioiKn+5uUgoiCTOglJBaHkjnFFLgfitCnwPovOaxKtRYjyIKsfOuci6FmbD7JWpReWAW
 Rrsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWC4TAkDJCNHNUPtVIbBkJkftNykwGjVs8N1+dhYQW2xtIWBTW3rxtAdkI66TpyFmLtBiMIaxZZGg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE9GmN/AHc+LTN0v7qWCpLv62wROHfV633Zmo2SwMqfaBqDv2Y
 nLul2yFaDkCwYI/O6DFXcXBlhrPU9eO4Jsah+YrifbDGNrJJem98uLkl4F466qqRpDj7PG4rZyL
 T6Nt4XWL05LZtaiokbxWYUm0pgRUbRAp5MMnhG2+C32ZqQ5Se/t5qOLrw0ZIE7/xdvr/NKAU=
X-Gm-Gg: AfdE7cnaziVC5xplumo4i026evwa8AvRPc1E6HHfXjVd788ZvvX/kRWWNUfHqoY19L7
 nNa3zV3REsS41HTN2+11x9EQniRcFSMxmysyrQUjXczHTJFBpmKusbfqb+w9/ix3A5JE2X9CIkM
 EoQghRb9Apk8/WwF4TBqWZuKNsDK6auRuLuDLDN4K6/f7eZS5Ps8hR6h7NFP6h0bv9vx5CAL6Cr
 wBoGm2OxpVe+PuSAak/A83CEp35qr8wvT8X0kayf4b+2VyiyyGqjeX+BIEK12PW5+x3/5jTa5YF
 D93t+/orsl68pYiaksdnctFhNt8BM8Cu++KRulk7UIdkG/ulNlgpaeqHQldoVX/Wwiag/N9Ziu5
 sT3/ArtDGRrrZriehIpRduatWckgKTSctWFHCuXEsYJtiS+aJbJmbZOwhwPJFrnWfdRePX0LRCJ
 U5qCSSDfMCy17+flPRvpxDxpyD
X-Received: by 2002:a05:6102:5cc1:b0:62f:522f:5b2a with SMTP id
 ada2fe7eead31-744e03d0408mr4194083137.22.1783608866705; 
 Thu, 09 Jul 2026 07:54:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc1:b0:62f:522f:5b2a with SMTP id
 ada2fe7eead31-744e03d0408mr4194057137.22.1783608866193; 
 Thu, 09 Jul 2026 07:54:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b017c29961sm500429e87.29.2026.07.09.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:54:25 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:54:23 +0300
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
Message-ID: <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NyBTYWx0ZWRfX3c6qSjjLGdUc
 BO9yxkRu9Cbd+qe8I10CbsBJ0uPMO17jpbUjlH+QlfgHTwy9hyoAgSzTk/CE24DevSGAB0iQ0Ir
 JvRBahagvaCH7j+QeaAaClpX3KgTGl4YFmBvwoHbUMIBDKxtXSfcMysQ5V0sZdC6a+ChIz7fCA2
 Xo4xf/Esgi99BzVk2+X1uUqgmBn5SrtXi6bHyMpIAYdf+aNfrKdY4jn32k1svnUNPUiGQgHag5q
 Gv6mpZjh1+ICTNNYm7nRPt9iwhb3wW94CTqYynvJDKCv61QpkgZOZDhdd4VNFJTI+krMxU+XlWs
 uzVvBXhB2q2rtGNDyrodl+Mx51h3qhPJxXg/N/CCJeDr8wDzyXwWQTX24I5NbJ+3fsTnGfZ5on0
 Yv+9gel/JDxAO2+WChoknfGKWkZD1dkvvNNIlIOJua+egSjxQ5IjYACotiDBNZnavimDcz04F/K
 wM0eYgGs6dykEvHw6rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NyBTYWx0ZWRfX6ocAXEC7hnku
 AfTtWwOSznlLYa710X8IQHAxQK+u36jwc3z6hMU/wCyujWggSak760CDrhVnrmx8+AVpV7RHsCE
 vmLzyeGhmmtvszcfSbRqo3WF8wp8Ol0=
X-Proofpoint-ORIG-GUID: R3B4fG53lVpIM0GxMEacxY9hV4_R9Oo-
X-Proofpoint-GUID: R3B4fG53lVpIM0GxMEacxY9hV4_R9Oo-
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4fb623 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=gTY0VpHTFMgWGwS8g40A:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090147
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

On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> > On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> >> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> >>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> >>>> In order to associate the SID used by LPAC to it's own domain and
> >>>> context bank we need a separate node on the DTS.
> >>> Can we use iommu-map instead of adding a new device using the same
> >>> addresses? You provide zero explanations, but it seems like you are
> >>> trying to separate a part of the GPU into a separate device, but it's
> >>> unnecessary.
> >>
> >> What I was trying to say is that we need to map sid0 and sid1 to different
> >> context banks.
> >>
> >> From what I recall, so long as we use the same dt node, the iommu drivert
> >> provides no way of doing this.
> >>
> >> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> >> and secure.
> >>
> >> The address on the lpac device doesn't really matter. I have very limted
> >> knowledge of DTSs but I think we could just leave it out altogether?
> > 
> > I think, you were poined to the Glymur Iris patches. Another option is
> > the QDA driver being submitted too. Both ot them use iommu-map to
> > describe the same usecase - a set of SIDs which are used by the device
> > but which should not be a part of the defaut set. With it in place you
> > don't need to have separate qcom,lpac devices, no additional properties,
> > etc. 
> > 
> > I'd recommend following the same approach.
> 
> iiuc, the conclusion in this recent thread is to use child nodes for a
> similar case:
> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/

Let me check internally.

> 
> -Akhil
> 
> > 
> >>
> >>>
> >>>> Add the code to look up that node on initialization.
> >>>>
> >>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> >>>> ---
> >>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
> >>>>   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
> >>>>   2 files changed, 21 insertions(+), 1 deletion(-)
> >>>>
> >>
> >> Best regards,
> >> -- 
> >> Anna Maniscalco <anna.maniscalco2000@gmail.com>
> >>
> > 
> 

-- 
With best wishes
Dmitry

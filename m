Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E8DC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2493010EACF;
	Mon,  6 Jul 2026 21:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/g9HkW4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bj+kEWgz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A8410EACF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:37:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEDTY1665496
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=51ioZRkWsr8YoDDsIq7CqvS9
 RZMTHGeh6Z7fA8LH+6U=; b=n/g9HkW4D60PuJ2NZSWDYc5hRIKJKU8BpfsglSw1
 tgDVNoy5flTOTKVlT92I2uQLIGcVUu2ceQOuCoueRx6rIxt2Q1eoJ27LvZq42NJA
 CsLnVxmG7WgXa1AdD5pCbmD0AsVUpfVNhuyW8ugquMLtNlIHlaFapc45+Ey6Ms76
 Pou+uFpaFih47E7zYwBfx9KzzuBFtU4rQEWG2qgVdzRq/W44hUCVTIhpTMqdVM+S
 /k6TUo3bPIyriitLltZgudduDaZlT2ADkEIglIEwQAlk6VkEm/UBWVYcQWXqNS88
 Z++6Ff3ySp5Kfn7BE5oLSq/bUjeCr8WYcPG1g8veWZv6qg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu0yx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:37:11 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-96966afe3d1so3826152241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783373831; x=1783978631;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=51ioZRkWsr8YoDDsIq7CqvS9RZMTHGeh6Z7fA8LH+6U=;
 b=bj+kEWgz0dHpXEhG7cxD55mK5kV7+y2AmqyUal/PNWdHY7c7EbrWGtVthUSzx60Bgi
 Tt3pYYNepq85LYUJPIakGRsdLta0pYoGKQjiQb3QB4Y1pmdsf0DZ7tIx1KC4SOVtZzdM
 iHxjWw+DCtZ70dO5hHx/jfXmSiMrU1vuCKtrUGhcB9Wo78ea62wlxwxi4dPt31+ElC8q
 hvDEvHNFD7/IqjCwKqShlg10HgdG5n0k41KAXXARZsBeS/7qZBiE4RjjYfauEztlsTVY
 lIXqfxRkFexyhT6YtrF6HVbjnrkdSmb7wOjOFuM1qMT6rLnZy3R/dpFiS1un/JkmSabH
 CyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783373831; x=1783978631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51ioZRkWsr8YoDDsIq7CqvS9RZMTHGeh6Z7fA8LH+6U=;
 b=l21Xi9xoDE1Fr1u0IGn5egyKfqfqx6pWk5nwxouINVDcEJ4f03muuedcGpxFU7FDMD
 QgD1LZXHi+ecUqsxZPHO4YjfuBWr1R+hdveOWiknK3kl02IOUUpudBwzUvzNtp0I1LGx
 mosrR96AfoCiIEMgq5PRp+g9lrXfjhIUN5jWYdom64VcdelESS95VGe2nH3DC/YNmLTH
 swKiilHS60Yt6vTpjlqP9PIH+fpQBq9wuCXZ09RYa414K2kCq/pUur/Jv6YrngMilNBd
 +PA2P/c5XrQOcrfoqsJraHn7TQNtJmB+znVGrDNe0g6sjUoaS4L67t+hJzOChk5IIw/N
 A6Zg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7q2khZfH5k4jq++uImiKOVqawPJG5XX3APMA4SHrMLc9XGS6+pkCdjyCvL5nzPDEreWCnzsj9/58=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgViLfQIUToUOY0zvA9IX7+qN5ZR62Ke+AA5P9TLnnmtvRTQTt
 FFeKtIAy7JYF5BjzRbeMIaSm29WF4gfHafJJTmzSWQebp4eMP7XarV6HEK/x8AikyLoyxskh3Rr
 Q47FzTxgrCqrNeGUIch2A5RYlEgWT31oZOmYbG5ZAFcUjZL4JKJ1yOnmqs51hOcoLxSJRSoc=
X-Gm-Gg: AfdE7cmafR97RN1E7nCegn8q6JETox2JtqwP3TtMuhsSEYtz20Ii6w0834j+kOLFCW9
 e02NVBwjEZdzCkUWfgk/LWAF0AXFe7y8BvOKJyldVRjxghIpoVP19ZMEyek4Wmv1fGlRg58XmO7
 ns86InqlVCU9OUb69Dtzp+FN649Rve2PPMgdMTnBf5i2cTq3vqyyM7aXQ9dIxI9RPBRR6VKpAjA
 4p8rDc6ofQf4lbReKqw9UdUR2abX8lptnq4EXJSIc7Coatd2kHPonI7Bx6YIk0qeIBbfC5oLtg5
 0wVmZ6i0eh0chop1cl//do81lzbEnCXwx18kY4afdnZq/SeBea8ujfUrKI/ZFIK5mBYqBxREnCA
 RJUicxYUO/KvKCIY+XlTEQpAkldwWTgxuAWEGGS2M1xSDBDOPSepKZBb0ES8AuLP7cjGOiWiCoZ
 Dafl+q6d+JmNsd1Hv46SDorFxv
X-Received: by 2002:a05:6102:5e96:b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-744b7e0bec0mr1289304137.24.1783373830750; 
 Mon, 06 Jul 2026 14:37:10 -0700 (PDT)
X-Received: by 2002:a05:6102:5e96:b0:726:cd42:d039 with SMTP id
 ada2fe7eead31-744b7e0bec0mr1289236137.24.1783373829228; 
 Mon, 06 Jul 2026 14:37:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c8c3asm3167623e87.82.2026.07.06.14.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:37:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:37:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/8] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX-
 variant register
Message-ID: <hahn2b6uu6bwzuext5jkb34zbs55yerrkfpdfqpd4dgzprywcy@wqcw6w4bkjtk>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
X-Proofpoint-GUID: ZVy2Rz8QO12WlKfccHcPHZV8w9m0Z39j
X-Proofpoint-ORIG-GUID: ZVy2Rz8QO12WlKfccHcPHZV8w9m0Z39j
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2007 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=3yiLn2T9MxZ6V1egYJIA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX4XOmwhYjwjrM
 HtVn+gk5M3X2SiUOv47lEur4XJseWwmjsXxXL454vMgN3LCgRBYEpntMLJgguxlem9BgRzZ+1vu
 0HwUxEhQhz5rps2aM1Rh7o7bcl1Ma35efZJu1bC9GCX/esUk3MH9xZVWhnckTMQwic+93JW4CbE
 Rs9a0xZjhpve+tjTx9X4Lcr9w3eKaw3U/BOB/nPRO4Rtii9Cvr+ebSeZwthQ1swF36pmYiMsILK
 w7VhOJOM2okYJCdyzl6DStctdatl2mMlRh+3HUaKo/rpZhucgSsHdXIDnh/gqzTBmJ0w2TW+IXN
 B3jfbLm0IE78cVIxOBBgdOqPq1vupaNwPwgkBhqOpA0TbMSGzCSOKQUr4qJa5z9NAtRR5VnHEs+
 dWgN7NfY9KRKEjPpz9oZfT2luD1011BKQeyNyNeYYEezFOi0fyX5agJYPntPYaVeXQT5PZxCyba
 GbPl8fNA2u27rPHgKlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX9ZEfFQNKfDwY
 yKGev07oVo8ajAXIJFSyakZJnQdTEIIaJDdBIEFPhIzLwvA/bBGf1rmjx/iQ0i405Di/sXaDnZr
 7/RLE2TXXvxKEy5G4lbX9faBY4OqGcM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218
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

On Sun, Jul 05, 2026 at 01:44:17PM +0530, Akhil P Oommen wrote:
> The GBIF_CX_CONFIG register exists on GPUs prior to A8XX (it is used on
> A722, for example), so it should be tagged as an A6XX variant to match
> the register spec. Widen its variant range from "A8XX-" to "A6XX-" in the
> register XML and rename the generated macro accordingly at all existing
> usage sites.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     | 2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c         | 2 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c         | 2 +-
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

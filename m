Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED339F5A8CE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 23:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C2910E774;
	Mon, 20 Apr 2026 23:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqgpgIvB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GEIbZ5rF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE73910E0BA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:50:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KHYYR53015175
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lFeVto6DtjU/NMUp/BHqlwRu
 TqkDdZTaowkflqaDISI=; b=cqgpgIvBM9otV9/ZJ4c98JG6Y5U9PrWnFJd6cTSj
 V2jZ1ygHqbMkTU8JhGrsVFY5lkKDNs5/OI+RgvHgFo5uXI5Wr571ET2tCCFR6ogv
 eErNrn5RTje0ywEw9JfM5CSkVcAglkJsPrLEBVI+Zmc2ZYoifidkcW2r0QEiQckI
 wqJ38bc+atq9Bmn7Lg+gWWSTTCKKHwoDAOW5IqRBftrV9ppagSDNCFqy+uXU+V8s
 RI9lySZvr61vThZoWwskqh1F2mJYGWKJ84srhfYB5+huZ0uNNv8AtF1PgPfTXArc
 jNALR1o5PLKUIwNKxk+HtKM1ZXmnWCKZlvxqZZPxccw9LQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnjukthun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 23:50:10 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9539bc7e2d0so6533096241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776729009; x=1777333809;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lFeVto6DtjU/NMUp/BHqlwRuTqkDdZTaowkflqaDISI=;
 b=GEIbZ5rF2enpBTWrmIbqX9e4Y5i59CQHgRQ32qsuhhlUQhrUZF6Hfflw0CXlPPPYvk
 AXvjgUPaTuBiCjt9qR3fhI99gKtGKaDn1+dl04m5r0Ixe7ErlCFD1baipnb6wYPCq34w
 bf1ONb9U5ImS3DBuf+AyBMDjFP5cz4tboD0niiSej7ZMaU++f2oFgMDvCVlFpjZd5ZIJ
 rUAVj1OrdpCKnB3yhv8R2CqvXyAlNDiRfScKCZvZhhExRl90eoL1EEK1TRARb1J+Lofx
 tqnilCpWBSKuC+Rmd7rN7PkzPVc0FD7oi2YzjHhLP/NbQU7ionerKX23sJo/D1Ip2Cb3
 2fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776729009; x=1777333809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFeVto6DtjU/NMUp/BHqlwRuTqkDdZTaowkflqaDISI=;
 b=A1jEFcJAPdEnKf1qcKldxZ14Ej9f8UgAERMTXZak0luEuARPYkfbDxRPtP05/LKQlo
 J1egBjKG+vMLQdxMwzafHjmpvjxZQiAbFqZ6fKgEyThgFFPo+Z+Y3zdWoLfzQ4Fb2Bx5
 X37lKZVRowkwqB1UFDnG6iVyEAmk4hm/9skCl0nRkhIKetDaVsonfS71LfJN/yGuivz4
 Q3OXa01kNL38gP3Ckj2C+hCoFMU0j/oX0zlWHjHrWr9eg5BA95h24q+L9RwLyRE6ilCa
 qYf3je6+HTpwaDQuCZFwZcngEX9+QYu7fVLtmjHw5+I0oIYWjupRCcT8J3ZlkLg6GUc7
 eYCA==
X-Gm-Message-State: AOJu0YzSDQTE+NIlf3Dst0xzty+vAHXN2H+FpXOGxYDsEbK9olDiSbNq
 3xCFJu0SEF+nxA8ZHvRLAgZi8eCwYRkJhtA/FVw/B1h+jmbr0wR3bVr4EBadhWhFdHa7Kdt47PC
 q5CiEAu59l9keZO+6sKcgxOVSGzPiX7HDvUyut9PFohIZY/PIyuSzSBFo7ELHiiIDWXKWD18=
X-Gm-Gg: AeBDietRZPnE+Wy713F3Qqvn54c42JuEyewcYv1Xh3bqCua88CFtoX7VMckVAYp7hpD
 p1OMfBsgAshGbzy7KVttpFz0nx2Ux4R0jNYsTkqQTkFF02VCA6L0PUDd28zCACYR1wYnKHoIRta
 lI6rlS0dMU3iVgA/1/CQEA88PNwVreI7osZYb5cOc/kpro7wrjSSif7md3bXQLYwY/CUkFXJ3jh
 fR51SaWy8BixQwLKZ/MQyCWnIyIet1WJG6Degn3iBXJ6SQXIH7vcM2sXyy0aBhuS8Oujlo8Rg2p
 LesdfZNQVHeID/ETDRLOd6WLzbUv/RFB+n1B1ae2zfmvFupBET4PihbcMnY6XJHGnokDhVatT75
 rMVx8j5N1zQrrhz8mh5G8TZG7PJkDfsPBGxJiOkaS07zhfZax2QjTDTMFsP9p6jJd1Fc+u6/5c4
 dFulXwW65I4DCmc+Uhz6pY+gd3GOkedSIfxgcffre6ZF/VwQ==
X-Received: by 2002:a05:6102:5e94:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-616fb8a0537mr5184440137.3.1776729009489; 
 Mon, 20 Apr 2026 16:50:09 -0700 (PDT)
X-Received: by 2002:a05:6102:5e94:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-616fb8a0537mr5184428137.3.1776729009057; 
 Mon, 20 Apr 2026 16:50:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f5012sm26460691fa.3.2026.04.20.16.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:50:06 -0700 (PDT)
Date: Tue, 21 Apr 2026 02:50:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] drm/msm/adreno: Sync registers from mesa
Message-ID: <yc6istybrtnzwft7uyl4bjfruapcfsso2mvfgnhcxrzntoi4rf@bubhdghwswj5>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-3-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-3-robin.clark@oss.qualcomm.com>
X-Proofpoint-GUID: MBPJ6kgE0qUY4KN7npfrm1lrrzyzK58e
X-Proofpoint-ORIG-GUID: MBPJ6kgE0qUY4KN7npfrm1lrrzyzK58e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIzMyBTYWx0ZWRfX4x/LNpymBOfu
 nrwzjE9GuKrNEyVrAIt0J+0WNKgrt4qgXniFCyFeV2oPlX9WIH+blgFm8X2kLXe9JXxOeq9XZzb
 WnH02VTD85/jXxqnGt7ez4mId6TG7aNFskZgevUnUq8lr0V+llqKMmf6JWGWBJvRMIEcSVMWs3K
 e2Q3vWUSLj216b7t1G9Q8ID2LNdKGsNU1y6zCoxzhT72pfqloC8Lo12X383DL43bQWFi9G8RkG4
 spGCnDRVP5plgUSp6VNsHyVwCn5wURBbFmQjQxFtSBS2BXc+xxKb4FswBv5ffqWfVyZXtNo03Ay
 hmlsMqJgfyH5Sx8QSvwnsxzpJK5ombR4brnl5Zs6xoajbD6L6rtRn16dFyFNRrZvAAK32Tsr5lZ
 GlVcb0ABk1cWpCb/BKoG/cBNW+n8/TQuIge9HHkB0KgyPy7n8VS/yHgPcVvbDqcNbQU+ggpLONw
 PEH83JkM5MD4PK952gA==
X-Authority-Analysis: v=2.4 cv=WuUb99fv c=1 sm=1 tr=0 ts=69e6bbb2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=YSpEM1VExy63LNwymm8A:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200233
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

On Mon, Apr 20, 2026 at 03:25:24PM -0700, Rob Clark wrote:
> Most of the churn is just reworking the usage attribute on the mesa
> side.
> 
> Sync from mesa commit 4d4a951ac622 ("fd: add a8xx perfcntr countables").
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

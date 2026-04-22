Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB66FA1FC7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587A610EA5F;
	Wed, 22 Apr 2026 15:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e+lkRC0y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UH/4NPza";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B2E10EA61
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:48:07 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFfKfM2956096
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ydzduTyV0eTG/hO7P3OkxNIA
 rGuTrVWNHOh3wXzqnOc=; b=e+lkRC0yRY4nVHKKvrNdGl71PO+9WzFPh1B8Pemx
 ZcweNBTX7zR4cw4oOIPvYRt26DVi8cqYS6abpxeeCK1e5ShGttHVAyFco9t+nmup
 ujLk1Rz1LbGqFtFiQw5sBp4/w8MS/QoemWhu/YjkkcCGakLdK3phJBivfcyoRUUh
 sEQhY6A9e9Ju3J0MAhZes4EP5vocWVFnxON1C3C6OWj+7S8RJ23Zl+sFe5x1jlwK
 yZC1jM+1pkJs7z/pybjM8c+jEQvw7Gq5B4Q9U7+ii1HH/0oFQSUv3uSNqG2QJYyd
 gytI/X1txDV/NlZ7Nt6Vvb7gaun4DtaDWLnvtTSp4WJt3g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16q00q4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:48:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e575a50bcso48858881cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776872886; x=1777477686;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ydzduTyV0eTG/hO7P3OkxNIArGuTrVWNHOh3wXzqnOc=;
 b=UH/4NPzaR69Yx9STO95V51tJPUCQSdVS8x4AJw8UWz9WvK9aCSnzS0wllUY2pT1FSY
 am6O/HS7+5kdWy5tC3Ra4jNK+ZopSAiMkBskcRfGYqL0oSCLBUqL6m/kRkIOXdjhj8Kw
 b92RX+YADkeKSayVleWdkeu/m9YSXkVE6cBoqNJUEAyUvwIfy3wyDH68xOoZNZOHSLcp
 2NGV+TFvnBhOQi+KL9ZGpLwKOtoAMDiJ861MWHGFW96kA/kccSxCywuuNmkOurKYqitP
 n0mmYt1V8Ng4ij9K8NUxJxMXWNXf82WflvrIZ/wZCnPJQiW/O2zofjVIBAzIml3jHCaA
 2ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872886; x=1777477686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydzduTyV0eTG/hO7P3OkxNIArGuTrVWNHOh3wXzqnOc=;
 b=bOpHMob/E5Xm3kc+1N/+iboCIREoGXUaOGpOT/X9E/gGKuX0MyvFmTg9/+xA+IeUAs
 debX5k2dbLDkfYyEkqDFQkrnfZWI0SOr02y4hRkb9r9tEoEEWSXRQaeE7n2yMckJhBCi
 Y76boZHnQdaJ2LhBa6nzAqks8lUyYc1BdyBViTaMbBU15o6pcNoCQUCJZqUg7SHTBiOy
 5JLrcEiHtGBIgy4zq9LF3Mv7Pf65HuVeYNdbf+AyNvavmgD06ZWxFhqivBCS1SA8StvB
 gp8AYaKRLUPdOFTSa7/cuW2z/xo6ulnwY9JgQ2FMGPA/d7VkoWQYcGf04PannW5pDKBg
 VNew==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oTlry4T/RAssPr+g0keZi/FkibsRESV/nQZM8s2AxYSquVAglkJw5nyS+RtTVf+qyz9mWF7rRfb8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIhBZ+WAKBfegM3y/PQX1ApP7ynmzFLgDKDquT2odoGbj9+EBF
 ERdbFWkgc7i471CxeVTqjkOhnWmYfR+P8qu4Op08fulX7XzwPIy63aVMEsxvUTV6ZroE88qcnzH
 JyLYy0EeWykmaZ7m1UbYaDTzTRMY41207DMO9ACjsLrbLSSDBLFWMyXeh5wpfEDGHqoY/n/M=
X-Gm-Gg: AeBDievzVds43lO2rNPCjPSNtvad5jz5WOWwRoKpq4irgK5DQKUWkN/27e3MZAiPSzb
 HFZLcpmPSpH9qP24hWhRDwAo6i1TK/rWEn637aFi7tC79RAUg0h8xL2z7xEQD3NgZWOFQChXx93
 gxG6gXhWjxEjyfgjPzGpRz/hc2/aAoZq2E7Fqr+zWDaIbtmwuMOPuBw2rljzoKt9L5q1lT2JZPo
 6oSXopMXZwlxi27No+PA0E8pke/R6o6dUyAChxijXvK3PsksxGOmHvyHHIMSIgFhZavcn5Z9BP9
 BQr2imOONcNioyk5tzSLFCJEoezh48Ha3t6uKmCpmqSmyQ5VBiPgLGLTZe9+sOQkYpsywBImqXW
 C4lf0H03pC9Jzk0LfpGln/aWVjcHmywM97+8e5y8YChnGMWai+TYtl6209PY5dRxgIQf9Mizvty
 Qmfci3Wedy6mbIStWe2yAadzgbOFFhytSw92q628l0is3F/g==
X-Received: by 2002:ac8:5dd1:0:b0:50d:6baa:9e9c with SMTP id
 d75a77b69052e-50e367ffe43mr324747771cf.6.1776872885972; 
 Wed, 22 Apr 2026 08:48:05 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:50d:6baa:9e9c with SMTP id
 d75a77b69052e-50e367ffe43mr324746971cf.6.1776872885335; 
 Wed, 22 Apr 2026 08:48:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad12asm4598567e87.1.2026.04.22.08.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:48:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:48:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: Re: [PATCH v9 1/4] misc: fastrpc: Move fdlist to invoke context
 structure
Message-ID: <wlohwqmz6iflmxkkbv25z4xwa5jv4xgxjbwvckiyunnysea3hr@fwjl3ueblrw7>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
 <20260422092409.4107093-2-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422092409.4107093-2-ekansh.gupta@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KPNqylFo c=1 sm=1 tr=0 ts=69e8edb6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=P9wsaLPykV-ZOCfS800A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: iTiH76a25OADvfVuPIGG7EPtE_hg4qNS
X-Proofpoint-ORIG-GUID: iTiH76a25OADvfVuPIGG7EPtE_hg4qNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1MyBTYWx0ZWRfXyasBa+DXTOUF
 CE59yQH2NZiq3anyTo9VwfRLhiwUR4dACIN1cQEhrFbipBeNPsfhJe+f+AEjUYunSPKm9zy+Ofb
 eNTHB9SGeZf8Is6b+LFw0codzjKDEnhlkMzQSctSRgyKZOv2VAo3pqqgP0msQaPO//TbO8MWbmE
 kXOO/jSZr+556VyAFwEVgKhxUOvO8ZJpheHEEKZP4TqOSvaAIw9xDVAqG51I1hGCgG/KD8s8OKY
 liwWwgIn9h6BPYnelXYkZigOcXDWq7Z26veuTtBcofYp134K7KnH4nB3LZtCjSpHN11UI/kztzM
 3i2g0CY0+locgSzGPJX6/Lx/gZAbxPDYTbSxfvg9tBje9jTkzCHOw+GGHRdHf6gVghsxqGC7MTN
 Vi4iYM/EFrbi2hSD86+AfMRmn8tVAa380Q5uvdSMRh4h98HXjIvUzxmztEhKz7BStRIUCSZ0LPt
 Kl00jHrwPHMxAuYIxGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220153
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

On Wed, Apr 22, 2026 at 02:54:06PM +0530, Ekansh Gupta wrote:
> The fdlist is currently part of the meta buffer which is set during
> fastrpc_get_args(), this fdlist is getting recalculated during
> fastrpc_put_args().
> 
> Move fdlist to the invoke context structure to improve maintainability
> and reduce redundancy. This centralizes its handling and simplifies
> meta buffer preparation and reading logic.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

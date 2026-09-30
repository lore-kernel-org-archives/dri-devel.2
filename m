Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761AECA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C804C10F221;
	Wed, 30 Sep 2026 16:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9OBUABX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJIh1TRw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4525F10F1AD
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:03:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxqPU3668537
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Mw2NmiDzGrvm0Nc5TJoWz+Vm
 SYKEEwRfglbvsWyB/cQ=; b=T9OBUABXWxadqO2acfVmAO6Ln3+3dEoJPlZCgzAt
 yTnk+TPxblHPGXGaEtdrz+FpjA45cJfPr5xaXDhrdJEG72JptZdAGIVIbRMVmEAw
 JbeDcMh5Tupv1Aw3r4epR3AwtZHAV3lVBK7fFhsWVr1X5epPHYjyg4abarTL2Joc
 NozTbcICpwOdFRPTvGBgaMbOUq+Oj3Fw648kXEQK4UN0bqJTgjRWKNg9qSEb+u6m
 nJGlQ/Ypj2KQaq5j3kjaK/1WYkBWDK/RNSOIo09H3n/W4b2U+fRghjxUiKowNkou
 izxR9OA71idq7ireXNMUvcz/K7fUroVAcYxz+/2x6dG4Dw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2ur9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:03:53 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-989cd936d30so46848241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790784232; x=1791389032;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mw2NmiDzGrvm0Nc5TJoWz+VmSYKEEwRfglbvsWyB/cQ=;
 b=iJIh1TRwbVzwLeNkbsGywQSaUCGz32rrrJezJ2CzfCXeNkxqRs+WiUzXf1NEtoIxTQ
 yk9cxbSNG/2RliOxpja4TxjK1v6ZygtbgjPS8Falb8bU7KlY/LXxlDHPopVa6BIgGldT
 AW9/sC3v7/LHtolKqUyeEfSMxpmsU3/dYffRzdap6Ac/j0IXWJ2qaYZART8HAvqrloSq
 10PeN1jTAh+8+Wsr0PB/Oe+bO5k+Pn0QUfdHSFHetkoJt37XC4q6zFhHnlNo268Qu8a9
 E9JyKFrFSf4qYEeqyTptZJ2TRCARGQqCYfT+WKi10xZvQXkkl3Za23HONP4L9SAZBPlb
 0Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784232; x=1791389032;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mw2NmiDzGrvm0Nc5TJoWz+VmSYKEEwRfglbvsWyB/cQ=;
 b=Ws5i1rucBA+xJmPKWym05Zv9P+/IPov7rj1D9w4t7B6lAAKv0cSfEDalUfleIvQG2X
 DizF56khEUJ1miVbcKjiDumthcvrkN0R8W2DSaxautWflM0pmH+5f81QUjgP0fcsnVfT
 7d0NF2jgCNHxL5yGaJkfatSyYnQFPBKwF9LaN0zOxmD5u9dzPQ1KRDUBJMBmm36qOWxh
 smuo5MnPXi5waqqWolzpiCH+zLdSD39/2bPSeqtXtzz+LqrBTbtR5Uk96sJRkRWyge0L
 ek8I7Bmc5JTCWjDxIcwDz7DN+vZjlgEi1mtohQ9U/XL3ZtxZArSrAByYHWharysm7fit
 fylw==
X-Gm-Message-State: AFq9FYKMm82EhK/JbXbIu2ql0f7mazm6k5AIBaJGMuvUnquV+N4328Ie
 Ed4ohpOXV67V5f/gwR0ix/icaQZly0COotNsEojcIU77gcd5IgehKaaDvc5q04VEx8kZ0gXnpoP
 IHkwjiDmF295ElGB0sCqaDUtw/cwifID5/KvGIjpngX3c3SJQkhyldjko45Y7xmX93AQvHOU=
X-Gm-Gg: AYBFou1TO8hhx7Y9KBVTnQWghaZunlphonrNZk3GY1FwDH8JIPoJIYq0istPwhEJHNy
 uRoMzHnhn8u1Nr97GmT7JmvMj2J8G5pxO4Kn/XTE0UtMwgHv77OU5bofvt2jfGhGek70d0Ec+2T
 glUAUWQfDLxJLNuf9DDNa7FLaV+Yq5BlfZYG2/esnKsCCJKwPBPktGYOUyUP5rI3t20LmF+aB5a
 vMKKVvQ+Tx1LNDJYn43NUnc46mllXBMPPzgA7nmZuJZzj83T69pjoOfiLh1lIOUp3yiHBK9aPs5
 pidd6oDt/JX54AbQG33pO+07VUSgSF1iKHO9c+FjYOfy1JlpbMNS71mnDG+bG00Ay+u8HGiyLzb
 e7hm6SDdgY7rFwfZpAfzaIofrCBCkzw4BoUc8a0Skkg28O/MzQiGif8AjY0rE3hZ8BiUudYsqlE
 ALYEL9hJryS5AA
X-Received: by 2002:a05:6102:162b:b0:7a7:196a:84e6 with SMTP id
 ada2fe7eead31-7be73e956b7mr418887137.30.1790784232365; 
 Wed, 30 Sep 2026 09:03:52 -0700 (PDT)
X-Received: by 2002:a05:6102:162b:b0:7a7:196a:84e6 with SMTP id
 ada2fe7eead31-7be73e956b7mr418863137.30.1790784231690; 
 Wed, 30 Sep 2026 09:03:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42faa832sm82205e87.14.2026.09.30.09.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:03:50 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:03:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs
Message-ID: <hvd2zaz6zvhcalnjew7p2krbafpctx7hmsgnsbyrvvmh4vhe7z@pdomohlcb4vo>
References: <20260930152645.22194-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930152645.22194-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ht67ZAFpSpsTYpo1-CBXn4EFNU43BJKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfX7dEEBbPgXuhd
 na/W8FYtiPfVgnwB6cVgp6Yy3tjYdhuNfXfi4fRE30pKmM+pQWvaH+S9d0bwoHFmFQaX0n/+3Wg
 IisHtzN1Xw0jgRtAqZCNFWJrKgGm4TdFiYlp3oYMbWu8J/uNN2+5KEN5Q/P7tDL/LNf9rUqal09
 kKbMa9vIixCMg2opyM5pltmoJPCh7/5V+PIcY5yLZKyarBlIWhm6daACIVBhcVgoUI+JiObHV/+
 8gmt+3gxJXLyMUnqjXrvLByIpfJldiEVxb8ly3z8EiMVMNQTighUEXOdg6Ak2snU2hSiXeaeu/J
 H38OwO5PEt189g3Ky0aY9hz8mZD4gP9XDiNnkGdjS6W45kjE1j1UgEo7Yb0K+HgyYYEfye33Re9
 Z8KP5JeJT4283eYiW5J4O+1BzRNqWNF/Ds3FZbisVgYJ/EYtKraaueTyupVvSI5vc/ELVd106My
 A93vavi8PNNzVnGO38w==
X-Proofpoint-GUID: ht67ZAFpSpsTYpo1-CBXn4EFNU43BJKF
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abd32e9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=wTaCxXlcGNsknM-wzUMA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MyBTYWx0ZWRfX02mOjtKZzObi
 WuxTkWi/aQjcbU0449dLfBRTyMUboIJ78TzF99M4jQIF9czLf17rJ5Pa0T2nw4R/S1zr4AURdJq
 wgG9Na+hKzK3aNZiW/+M7Nds1lcOY84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300063
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

On Wed, Sep 30, 2026 at 08:26:43AM -0700, Rob Clark wrote:
> Add missing GC block.  Fixes GAMMA LUT on glymur/knp/etc.
> 
> Reported-by: Connor Abbott <cwabbott0@gmail.com>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

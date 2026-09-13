Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7683BC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AB310EA3C;
	Sun, 13 Sep 2026 21:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQ70ZX31";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfTDUzLV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F9A10EA3C
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:46:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK06nd3218078
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vbAlXC0DW5rovY2mimpWnBtg
 9Fpne77lgrVF++LV5Ls=; b=NQ70ZX31srNGMLUNu1TbIFmX017U5TDAwdZh4+IT
 GHgBjBs6FEe4oLQwvAEt7OLthE0zK0FQRx/Tb2lmqC6xeipYB8OpoYKaK5t8gGUl
 szMg4hhlXrJXNlsLY+YOKXCsjuX66gTAxEiNMJiG+KBzxE6hdzTdfQlZexG0Wxnx
 RDAfgGPwT07AEBCJd9hR/4+sEAzV8+x+AxwD+JHhXhx1k6d4lj33Sr4HrgMS/Lid
 9ZS30EfGICfwJBPGpe9ErLt1xOVxRLvj9cJs3qUhaYwfsC6GcqZWfL7/STrTPTTV
 vTT/m40rlPjxtWX8iZUeWx2TFRw8PyO1VxHt8iir3X7O2A==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm71u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:46:07 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-980989f5030so2260163241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789335967; x=1789940767;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vbAlXC0DW5rovY2mimpWnBtg9Fpne77lgrVF++LV5Ls=;
 b=jfTDUzLVTk9+qhaHXw45Dh7MCgTCMK618dN9FRyMWKabDplNG+8AsHZvC7GZUqJBhG
 HB5VFjvZ/qAZdhBTWxO+b1LmHn8rFI8TgzR+0fgjTqclAT017SQ6h/VZjYoMyXFbuRIq
 BdlylNaUAfoY107kuy19Pdf7HxqdqzcMHQDMzJm7mtJFuIMJuPkHqkGZQI2SJyQEvjxt
 Le3icUx9jGdEPzxo6ajRB07M1ZBqRcLvt7Bdt4G8IMfHhQ07pKZdxddg7TCiTFEtIw/5
 uLpju0//uB4c49cLDr1AWzg2ybebxMxpr4FnVzhVPYzCEnhiFvKt/sf99oe+lcJowOUq
 yKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335967; x=1789940767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vbAlXC0DW5rovY2mimpWnBtg9Fpne77lgrVF++LV5Ls=;
 b=N0VgarwcJ2NnkVySz4Yw+FHd/gtgTflf9i1fYSruE505XaAGTLgqVxkeqRtilpLl/8
 Tsdd+6r+mqGWkx56X7IOhDu2OCdFuxJ9f8Sslyp/Fwad/WuEOaJuJZQ/mR7OBt1DW5Y+
 QvSWuwFeDdgCah/5ryYBxtYyNrp6VUahCsVXIl2ijrLDEYxKlhoWPnAZooTkndD4O9gr
 OZCUd/MYlR/K25ZCU+QjvLSJLNWD62TtZQ2t4o8JzM38BJRqThkWj/ewbj/kn4Z7usvk
 fWoRzASiBWNsXwLngvnvwcILvyDnIw524hIxnI9vZTRHz5wq3lY1ttaKiJ7cxDCtAfau
 Pikw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8DB/sw+5CLGEhCATbVC6Cg+PK8km4hXRQB1yCgLeHw5W4+DtfzjL/7NiKcC2XJ4j4rQMOuHXjh/o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8gTJtkWQ40b5JyP6Mtp7C3jYHIK5L8IC0fM2GWwHOxYsgEB/E
 ap8fcaD7Cr2FPXwLCiHuFzej8ZUzZJ8OPdjiVPLOmNSzmqQb90kw47+GAGxH/CRUHwixfKOAH01
 g1o3MxbdyTvHjQN/DL0ZmKL9uxLAyeln9i/5RSYbr+DBYswVZ+dQvDphmuSK12fKrFFH/oMo=
X-Gm-Gg: AYBFou0LIpN7FDWpbn21srywsW49d9iJ0k+QDwTQpe74CMsxxwZKFBhZaTtmLSq+3cF
 8zDIuHdmu7QG8qaW4QjIBZ0AbhqgSXm6R3ifAZ97h36ZwlYiMFOi80pUI6KZIPQOXB06wT1AIKo
 6dBpXR3V6b/1pJqFOOvxvk4mHV4UxFBOgptFgynFJVkqr5IB1xndtitdNe63kKW19w3GCoNYjA8
 csUAKBtIWTJAfF2yUz8zbtSAGe2dJi96IyuLYball8vGMKV6mpLcu4b2U3oJYqADSb6AvDan+A7
 unLq3w+46Cu4MJgHsUJkVbnzCs2bmr7fWHpPGyQ0QIlzLSP1xVtx6Sd5v5I5qsPy4dMELzlIfZ8
 9TC302f5bwqruVJk+CZPBV5zq48Fc6W2rjVwnSLkoPLUTGOn8B7EMABB0oAErfFt4S2U9npNHt+
 VJG822eYgaPs7J
X-Received: by 2002:a05:6102:578f:b0:79b:1b6c:4f66 with SMTP id
 ada2fe7eead31-79b1b6c5faemr48500137.1.1789335966952; 
 Sun, 13 Sep 2026 14:46:06 -0700 (PDT)
X-Received: by 2002:a05:6102:578f:b0:79b:1b6c:4f66 with SMTP id
 ada2fe7eead31-79b1b6c5faemr48479137.1.1789335966559; 
 Sun, 13 Sep 2026 14:46:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0474df5sm1981637e87.64.2026.09.13.14.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:46:04 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:46:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saim Shujah <saimzst@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Paloma Arellano <quic_parellan@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: clear pending peripheral flush state
Message-ID: <skz4w7uewtxgmiuhyfav6krul6b7itlfb6io2ysmcypql4dka7@ar5hawrzijaw>
References: <20260828065440.140410-1-saimzst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828065440.140410-1-saimzst@gmail.com>
X-Proofpoint-GUID: OZszvVUZ3uQCfWYRdjWXy7BpbjkZUveL
X-Proofpoint-ORIG-GUID: OZszvVUZ3uQCfWYRdjWXy7BpbjkZUveL
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa7199f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RN2DTS20WyuIpY-t6BoA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMxMSBTYWx0ZWRfXxSF65eVO1K3K
 L1PdFLrA53XUqmiPNCiS47WiG2FkPRfzxe2rHRpHyvWZyCRuUl29LleBCL5bea6SETrm6Tklu5O
 ifXw5X2aBYdFLGyoxXoC4xwqLUszD+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMxMSBTYWx0ZWRfXzgq6JGsRmqH4
 FPQyah1RWaknDKgqHbkynoj8DV23q7sZYJszGEQ22GjWaoQsjqas2TkOwZHgjo5lDufXBym7JeS
 9S249C0STDVKrbDOyxWQKZXZZYhYHUPxdN48cfzb97y5jQGgxhYtQSl6qj/B8KizOEATBjoPGQo
 6Cc9swpd2wNVOiTfM1MGVrunH2EX3N4iebOX/0dEzSuE4iYXva4fwyrPuqe1+dXC99T9EcufOHI
 98gJwk1MdU1WHl/+e5q1yegOdp/O7f3pbg/22w4z4FghYzZT2na+HJj9PEgwfOATxIGczsvSBOc
 yfweB3J5MD+eXazKaaI90fx9nidv6cGVBaA6LxKgAQw7GNEXXCe83cARddK6YXNCOa0zJ3ebm2h
 3jxWZ320Ey5zfFcahhIW6otPmZRsUbISheqOVwSsL3cLdUA7o7qzi+LXmOjGIn/PqWK5G13jz4O
 0rZ18AMk+24z/aB25XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130311
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

On Fri, Aug 28, 2026 at 11:54:40AM +0500, Saim Shujah wrote:
> dpu_hw_ctl_clear_pending_flush() resets the cached per-block state after a
> flush transaction, but misses pending_periph_flush_mask.
> 
> The peripheral flush updater accumulates interface bits in this mask. A
> later transaction which sets the top-level peripheral flush bit can write
> stale interface bits to CTL_PERIPH_FLUSH together with the current state.
> 
> Peripheral flush support was added after the helper started clearing every
> individual pending flush mask. Clear the peripheral mask together with the
> other cached child masks.
> 
> Fixes: 64f7b81f0358 ("drm/msm/dpu: add support of new peripheral flush mechanism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saim Shujah <saimzst@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

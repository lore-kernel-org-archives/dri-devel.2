Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8061DCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD06D10E482;
	Mon, 12 Oct 2026 12:15:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D74310EE39
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:15:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0PgB2088501
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=W5Oee20wld3PH/cVGW463kUn
 G9EKd1KKP/fCR95AWfM=; b=fxE1te11jvpvYkuiVwwTsQSTXk/MB0NPmyKhPMrC
 AJrnrusz6Fo641hxXNp1V3xt6ttNkv8vZsmI8ZGGUy6pA2mXE/5Ivirg+8aQfuVR
 QRzAfdiDxAT0iKviWX9If4Buu+7ASPmqD6NdLBGQLeOizragQ1T6cjrBZxHBu0jq
 wAc0RLky4P3i0p00hksSATIUC1dt5qfr2rocFTIVrZRSM0q2zreegGrdrJaQROnq
 KUcJCxT28V+jYVFGK5CR+xEqlZ5EGx8SO0or/5FKrTaeHts3kINp8L2kOsSTfoPs
 aB0gD9qzaGoqJ8MH7SCeCa1tSCHtIiobEOvX36YIPjDNLQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu1u6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:15:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso385967385a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807330; x=1792412130;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W5Oee20wld3PH/cVGW463kUnG9EKd1KKP/fCR95AWfM=;
 b=Oglf36ILN9ehXcDPgDCIlDz8+t6cR1pioi7xMzmYl8FTL7wO4uZ6jN7TFilGV7/C/0
 8zUYhlx8ZyaWs08PZYogqGWPC+Fd7Lz7hl6fIA3ryweNiBguT89p/ija4YwIkcaDgAgH
 EifUP14pHtRvxPhwElI9aymFnu33SdGSioQXWVY1BsBWvBkp6bFfXkmK4tGGMNYLaU0f
 I9CxbBstRFfZWiku+JIUEm11PTGBHZgUHA06ZxczLxS3SvZMSBIsmOgXCG91MFHZei3p
 qkyappN5w9mW33IfaX+WcYV5xEKqy4wkwsDF6nJJq793G8W6iweWBLEQzjdSp18kXqeW
 x5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807330; x=1792412130;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W5Oee20wld3PH/cVGW463kUnG9EKd1KKP/fCR95AWfM=;
 b=XzSTaOnuQYW0Mwj4Rp+y0It/2D//G16CAP8YCq0XoTAj5k66wKXmkHCYFnH3qXoQ9U
 1dCvcd10XwdBExVo/KSzLxq7xZ0YkT0IPDRxOYsWeqzYIA51VEJGhwxIf+Y2QRR9TM9c
 xtJoe9MVB3yYGBv9nxE5yfxNqkgXO00kPlEXo2SGZmVzaWWKw2S+m72QrQm8sYKzihCp
 EgzlgUpVQfxzI0IYene+oPpubcTfjeLB2s4xYq3GYVmt67tTD/ksPm2dVaSLRwNEUwXG
 MdU7rS/PiHutbOnNsVSHCfgYMgnbsUO96Hit11LxdVsy+q28lHtSrkIK7kB0h2r+90gn
 RX3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvx3B32cZTTFlzrP7AGvp1R2lPX08czY1qSHQxMfwt+xJcuoxbm86k2erwW2m29vd5sFoK7I5jWKU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJoKSo8p5VNeihCCHsQWv6fOJDaVQ8ZqqMgMshcpXdlSuAHVnJD
 ad6sGgPz/OgVPsO/3qq+naRuBG8EX6yCMwhbFLd98KtjE+602ZI3/1vMjbtaPdXBt2RJHqbs+wk
 VDqF2Yvdqcc/LSmPxqnPABqALtGKAvm15nZTadYaAn0a064WMQX4lI2R5TKMdPENnVsToWqvSfu
 bGO4s=
X-Gm-Gg: AYBFou143KqqoOJwiHGjJ9/9zK5iMdlT2UJ2fieIyswAiPvlBQZ9Ae5EGGv7cksdmmp
 NouP/4tBeXGgd+aT6E1oM796p0+WvX+IXjVP24Ps3y/VI6BD/iV56wDFkzMEt5bnVzlKYg9J8gi
 z6WD0oRJD+l9U/U8VcM3U724/JYn62iKiEmM+Ge3eh0DffORgs0syqrYM/u7dpF9Y79dKAGnnfK
 Pvhofj/4eB1pO0pfsmn+XKWYSKsBCc5ux6U7I8ounekyLkeEUp+PpMETlOOfZ/JLcIwVDUgEIII
 69Iai1WGf4T9o6Omb1fSJ5Vmn8iKcDLrISz5xo9UgibZ+4Qnz9UnO6bR5bi4IEjW6JcffyywM/N
 SjbEFUp2xeBU5GEl87hvyoAMbTjy2q+xtDKDfhF298M7d4jMN/QgU4JZ2E+pEotcJJo1r2cZyrO
 UteemWhiEXzozc
X-Received: by 2002:a05:620a:6303:20b0:93e:c12c:4416 with SMTP id
 af79cd13be357-93ec12c494cmr973980885a.82.1791807330236; 
 Mon, 12 Oct 2026 05:15:30 -0700 (PDT)
X-Received: by 2002:a05:620a:6303:20b0:93e:c12c:4416 with SMTP id
 af79cd13be357-93ec12c494cmr973978085a.82.1791807329765; 
 Mon, 12 Oct 2026 05:15:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcf2ab872esm909446e87.41.2026.10.12.05.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:15:28 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:15:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] drm/msm/dpu: filter writeback modes using
 writeback maxlinewidth
Message-ID: <7n7jevfti3hty27mbbsuq22oht6bxtrim52umza7xmpctpqgjn@ov6vn76takpt>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-4-fa986071c3c1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-lm_fixes_final-v4-4-fa986071c3c1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acccf62 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=BE5bDMB6e2GY2Q6Qa0kA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX8Dpq8Bsy21Mq
 y8r2Y992iyUkHXLVsJC1XESQxbtMBdFMtZxMi07u+QO7KIyHQorbZHpsZetDvBM1HS5vwPscE2C
 jhUnjzVpNgHYdVt1345gf7WCEQE1iLj1JfPDKvlyiPCZiWfY8/Xv4xlitB6OwdROjg3KUP2m4b2
 qb1j8+H81uoluJWNGbsoDngsNHDn6abIwLb9e3LbeT4YXMLaCnBT96eXmGzRwGR8jMmbcMbU7sz
 xmbhZpK4983YhL0Fg49+tE1dqBXkrTMdw6vgXCN8iYk/vr2PHdldNUWPrQUQ/4v4wl74Ilx13ph
 lYuSBtrctXBNzb59lldARcc3QtCWPQKMc5Xa+hIVqz46SLoM/8pz7ApXYUUrI245Qk8ONB1CSqm
 tUZ/82hwsyF+rQZD/P8O+93geX2wqHyD8mvhHC199dRc/PCsbRUt/Fzx2RVKI8/GoO9bTaVCOEY
 C2cKAzql7W0yh+SYpKg==
X-Proofpoint-ORIG-GUID: Jf3TlSeQ3dQVViIlgQlWTrLCFrv6aihz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfXxZpfx3ZX28SZ
 5G86DTUOSSDsNQ8enPSKSfP01fu4GoYnNzSHIluZeqjm+T5u47cnzDwCfZAbUgdvm2hHLByVBMc
 SDnnRsXmOOe+apYDdizJrGhlZT9+WoE=
X-Proofpoint-GUID: Jf3TlSeQ3dQVViIlgQlWTrLCFrv6aihz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120048
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

On Thu, Oct 08, 2026 at 10:53:50PM +0530, Mahadevan P wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Maximum width of the writeback mode is limited by the hardware buffer in
> the WB block rather than by the LM properties (LM doesn't have an actual
> buffer). Use the actual hardware limit (the writeback maxlinewidth) to
> filter modes.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> [DB: fixed commit message]
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

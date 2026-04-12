Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E8F3ED5C
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694B010E269;
	Sun, 12 Apr 2026 00:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2Fd+hJN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UT8orI1M";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5AC10E26B
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:11:32 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BNlFFN3013443
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SXR3clQGGXCPD36LnBK1unVp
 b6SaNrAIwD6Q8PNPH04=; b=d2Fd+hJNGm+KXuUh564lsWAUagM5IWb/0flOMLG5
 4CJdRJhCJ0HkvqqcDA6gjlR6i7I2ogf8IHvknyjAR91XoTg/e2wZJfmwQH/IzXYT
 zxELvSBSJorozF0E/Tl70/NJRWZxunjpBUrxIbOHFpo0kPLsCMRAkYxRo1mUx0Sy
 c4gXdrdxmHfbRQKzGIgRUWP9HynLFbvSnUtvbzbKIpxIBICcuHivk8waGHv5VhIr
 dt3S/sWVjYg3Ox2Z4i91WiJWgRnuOqqQqYA2nW3iAbRzzBPINt1oqlznMFO93FEs
 0rPPVhXJOk4Q3p7u6hzeCYSBnBBZahMSSDR2URW+bY22IQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2b9hhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:11:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4987c698so88689931cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952690; x=1776557490;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SXR3clQGGXCPD36LnBK1unVpb6SaNrAIwD6Q8PNPH04=;
 b=UT8orI1MkiCYul/vNDWrY+pT8Z6M1wqnxU8/r+EJNFecudlBv+SiKB0DH333DgASCR
 YlWfVJ8TPcuq2S5+pb9/DxPKY5x5RAY2j6hqNHHCykoaastEVM3nEWYbeH6slzhJYXUa
 vCAjUrMH/D17jHwYoSShsOkrbztnwBcJ1+RLBhuqAx+s6mGHs64eZoVFV5RsdatxsYgD
 b3tWBVqv0ZQlOlx+um0jsSfxQXCq1r9zebalbEN4/Cd5uQM1bd5CQCHTWKKDbP8Gsghe
 utWfteGsD6FqjuS/1hDtVU6gXD6isgeZQFrw1BT+Y1okw5zu7G3zfsFP7ZhtnpTfXXqM
 Au6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952690; x=1776557490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXR3clQGGXCPD36LnBK1unVpb6SaNrAIwD6Q8PNPH04=;
 b=B9wQwhqV3xzCu3h8SQsSaVjATK8Lock6bsdUD5g2KMlxFT4FouhDmjXB9lN7h4Ot+a
 BLVnDIvdcExd8wXWoWEnncoZysp+9xF4H2B0dE88G0iLMZ0JeAz9GqtrXj6M1mHf2h5O
 HOdGhpT2fpqdqFpMtzNxuCd+JhsTZlCpPjfA9y00Y6RyRGB5lB0hnOlt59Wzjrync4U3
 if2iuVtki78S99LN004XqooMNHatOmlmiwd1SmzyVFre5tB2/Zyc7e4k4VfmURNP7mlo
 mh2LI7NbExPn1wsT/5qVWZKRNMvPyLgT1AOqpjygcTLOOeV9QfakZHmvoCNuJpEs/Uay
 k1yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj8EXbk4urSxUfQ76JQEH7g3CBhnT+3VRamTZEukyXCB2yc5BcJLJMTzqpkc7thMDaNBVQ5AZMqhE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxfi7sGMlMnu8xiPfEvjglGCqP2urAcOrZF9EorkBw8w4kUPPgH
 7T0EPy4KREHea98S4Vy52OMZInKlYdPMK+Y/IlLcggGbXU+wNizFqOQnCmxKiTRCFFiSJsL/Htf
 7quYrkNkcWcxs91n2L5VRu4xvzM9hl2bJ9OcWL/9qta00SzbOzdsryLqDhUJWYVW8DQgYO2Q=
X-Gm-Gg: AeBDiet32zJxaWv28i7BB+GOk0KxoxWTA8Y4Vbyo4PdOfnEejz7rYvBRpoVf64IfuYR
 vvW9k5PASoj3WEYYuJGPyB+afklqk1fuq6RpiBipkKp9yWUM9JjrJoVTAGqR0+SW5jQLMpVmobj
 MDUWIr/gwzSLz9Xspnw2Op/cbjO1kX8WXlR/Nsis8TqUfF7CEy48U/NGEMi8bJFG6TqHvKO82fr
 U00gn3dIEeuO/2M0DLKSwuHooyNFqbX5muwCZ58sUt+SzyExYOXyYi3lszFmaoPpS1mTlpzvPJk
 CAmMqh2WHUNng7X1v0LmOwhkg0sLs05ARMv5xrzmzwPuo8cx0/l2w8Fp6G9Jq1wIwuyxtqeLSoJ
 eOd7zWuNe52K41FpG9J8zZZessViraqsXnzfrOCj3k6R0t3tH+nLIZpM2sp3Hu+xBhv+2N5xuD0
 XbFpw8heK5tL/4BC2pF54YX6ocgG+oy9T/h2E=
X-Received: by 2002:a05:622a:2c1:b0:508:ffad:4bf4 with SMTP id
 d75a77b69052e-50dc19b1083mr167075161cf.5.1775952690555; 
 Sat, 11 Apr 2026 17:11:30 -0700 (PDT)
X-Received: by 2002:a05:622a:2c1:b0:508:ffad:4bf4 with SMTP id
 d75a77b69052e-50dc19b1083mr167074891cf.5.1775952690163; 
 Sat, 11 Apr 2026 17:11:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49541ddfsm16791641fa.27.2026.04.11.17.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:11:29 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:11:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 28/39] drm/msm/dp: Mark the SST bridge disconnected
 when mst is active
Message-ID: <ge2bgx7rn4vcyptf4cd7hnodnycrg7gdjceqq5zdncmdmmnjlu@2cuu3lcotxeb>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-28-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-28-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIyMSBTYWx0ZWRfX0dSk72Mo+K+D
 IU57Y77W8r6lpmmB52DBbRxxilVy1+QEaZ50S+h7QHqTH61eImpgidDBhs0tEW+WGzm1SqPUlym
 uGhDZ+La0qh3MI/rcrlUcSqdW5ScuhkWfBVo2aS0MJgRpm8PBuZCIma7r0PMLOvyKr00SJNmNnK
 jrzIxlLP+zpRb38dSbpRk9w0o6dsTu+fhPMRtqTGp4+NYJxaWqU0wopaNOwV3bV8Uf+Q2VNzrzA
 PJKvR6AwvsaZnc+124KDrMyi6gyfAEAXaQM4rHERfO+F3SYdKlPYSsOWxoHblwZPcSmn4Sq6Cs7
 a/KwiHTNQdp6F/tSVOxnYgDKAMjedgVQjwZZD6P4A04lqq/gZLPA9sLU9THqwNoEGpSVa4hd3Gg
 cA2r/9zP6WmQVstfxT+1V7uzALux3H60y9OAjZYL2v4JrExccQfhsb298WcCvWRmpIwB4uGYCyD
 vRTIO6V9A9PrfPHoqvg==
X-Proofpoint-GUID: QOO_0dL71dGZhks4tFpWNU1O1l7SWTUO
X-Proofpoint-ORIG-GUID: QOO_0dL71dGZhks4tFpWNU1O1l7SWTUO
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69dae333 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Cr4VjbKX6U7v81t0Q-gA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110221
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

On Fri, Apr 10, 2026 at 05:34:03PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The bridge detect function is only applicable for SST. In MST mode,
> connector detection is handled by MST bridges. This patch skips
> detection for the SST bridge when MST is active.

"This patch"

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

-- 
With best wishes
Dmitry

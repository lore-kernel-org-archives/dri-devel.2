Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA702F3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB49210E20E;
	Sat, 11 Apr 2026 17:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HO6LDDWs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="keCHUr3m";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D614510E20E
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:36:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4BR8j653215
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=092FG5gBJ7FcCA6OMLl6+2Cg
 GW9zz4afSlLEnZPEulU=; b=HO6LDDWsGdRG6LXFKJcTslKFVd+fWpPz/8ruG7jz
 fAjD896bE60nEb3x2YmyerZTZiX8Yu9Wd3x5QUqL61rb4LyWbbAwKMdyzc5SxGN3
 7tuCxNUv2Yclwa+tRtjj4QsNnKcLnHyNkiHJcxtu+RCvoB3E+W0sc6ECfKlDXL9g
 tkYtco/u9Tkr5DAOB8tjJG3ioNGRocMRcfRxxnyQTdXzE/W5y8UU9Xh7JnHEIY5J
 z/eqFJYiCLHGhAy5J8JeppXN1CUMZiSG4nfyHleQqbbdvmGpVjxGa264EeSwWxD+
 MvJuIEick7D9IXi8DD8t4VVFL8mEptAVpF/3JNDr+Dyjkw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2b93u8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:36:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d76f460b2so71977901cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775929008; x=1776533808;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=092FG5gBJ7FcCA6OMLl6+2CgGW9zz4afSlLEnZPEulU=;
 b=keCHUr3m8wpdtMrMcs2r3Rmm8pNXu1e6jyZi4LLHXQ0VmN/FOLbG9q9VgZWAepckEm
 MKOyk7H8Y0Z0A8MSbPsyZFlLZTnEuHpJUUs3UBqtuuXCMx5FR/ERxNVDqdf9xccTtP1M
 nqUqR3Vyn2aAZ6JQOItYeY5Naf6WEHFS4rE70gbKHkttBSA7h9iWl+2h9nCoesuuUwSx
 oM7acHogp0gWdrhg1a2Ukvs79Bk2BbGiqsvIeCnCt6F+d4iqEboRGdetsoxJEwUF/Gzj
 Ul54Tw3OfKZS/l2pIksIVi/AOAiHSOtn958Ffx8xJXS0BvndGPb8tZpSUiU4cdzS+wWO
 9h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775929008; x=1776533808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=092FG5gBJ7FcCA6OMLl6+2CgGW9zz4afSlLEnZPEulU=;
 b=owBC+WebpReZ90SpHvw/yFKnBQoUBsWS88ETMOwRfrOs0M7NoLk4o+G1RmOhaVslO7
 PCKMKSwsDPcnJOVveLsCVhoNbm9JQ2sGV6+iwfp/RrVwW2JgGtRvTWkVs7+hGQJp8FUz
 c3dk/2Ck+1ZASmjozhgC9FozfFxXC+HuVQ3VLHfVvF5HEz+NnnnOm5s69/Na52I7kh/s
 ABT+5aIQMKo/zwya/vm38R+DA38QXIkHcZjd+ePfa/r2wutO1iNW35HkSFSbKfFoIzS3
 8rlq7pkIAfCVwNlZmSRn6+lrrvbqWe/M1C+Q5oAAljgfsjvb1f3R4E4Trl5WeT6DzLvS
 Fz1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIkk3T/SRRSvs2s+KUN1nlj6Sd7GFg+f+P6hueOQ+7M5xZLKm1HIwRqztniudalEwvFciKUZ+jXZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzEyhDKmJ7WcmGJ/6h8vCuay6T7KeqLAD/0oRC7198rLrOzBmg
 jXBJLfo7wRJpdGeoEx1wt6V+0fQ7uKwRl8gy8Xx2unM4uBbDkyJAxHqsC5sgNKR4hMIhMQ714W7
 fOq6cYKYy2FuFIjgAAwsdDap0qj8erkoqXR9Rv8325F1WMgdx55JXE4qn+KHQL/VlCDTraRc=
X-Gm-Gg: AeBDietCQne6jwh+zUbqTmmJwo5GHgSrkpVP9QIB1tUmig+sHm4db6H6PHfAhj+hLfp
 /4fmOpzWsCDVTz6e3z10aYXM1zpJP/ctzewVKZnW98Rrt6Guo2c2q+jBj7DH80AXpmQhohy8/ek
 cJVX57NWwQiM9/4MicMtuWnkgST5HA+8eVrbDTgWpIn0jDy//AEODoZSA/6Hi6ofCTiEbziiD7E
 /6do8x1aY478CDyEvLtuw0WKp/adyZUPcwryv3Zt77oSCbGTHtK6qHjlrLY5oH27RrPj5C+fxSP
 +vFZUWa5PAMZ5OiiFht+tm/10gJIkuHj95OU83ywGC4JNl5VlW8ngQi6SwQsfJxJltAlzSq6A7i
 ySLD32y45PX9zLRAGrIfzAwRGIBsGUiTRX23pWxTpWCkZerYtjSmmuTBzlcV4ymEOpg6M/x2CmR
 WsNMye7/sVCMZShSIX0X8KnQG+xhPlvh2Rkdw=
X-Received: by 2002:a05:622a:4d3:b0:50d:a248:68e1 with SMTP id
 d75a77b69052e-50dd5ca6348mr116165921cf.56.1775929008013; 
 Sat, 11 Apr 2026 10:36:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4d3:b0:50d:a248:68e1 with SMTP id
 d75a77b69052e-50dd5ca6348mr116165581cf.56.1775929007583; 
 Sat, 11 Apr 2026 10:36:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefcc2asm1550367e87.70.2026.04.11.10.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:36:46 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:36:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/39] drm/msm/dp: split link setup from source params
Message-ID: <2ecuv2mhrwcut5vc53wbosg4wmjea7gdgugs7ady2ychnrjzuy@6lbbumdgh22j>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-7-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-7-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NCBTYWx0ZWRfX7GAfV7VYh0eI
 M7uFgRfIuFUoR/nP081w3agUCKzSoECtElHT55qe5xOospV70zjl5Z9ZJbVUOvnz6BI3yCICZMd
 mwt0+1RJMWmFTZcl78M1odjBkusqyKBv4GNf3D9BIk7z4SbkbUAmuiI78mPRZv7Dif6T4nwuOU/
 ntAAYuhvAQtx1iOU8DFVCj83tcYv8ZUS+ZFt2DMxyG2SwkhQ9H3v5DT6wBlhSIcni3WqisIPU68
 nExHNEfh77Xjk4B0K9rwGeB4VgDFHBRQP7hfb7WjJyTFMdZAbAB/DOQi0LjrNdzd1RpaKqsgS6v
 x/l6FPxGnj9mIXOzGCfkVbyGhQZCoAewyIpqs2MVJFm7oc6HtBUweCCxBMYqYtnxPD6fYB/LJUa
 QT8eMNyPiKPwlCtg64y1GhqR/H1kZZHFHr0mY0CihGKgNs136gzRTUeLLeOFGZ2JnGvRsCbYYp+
 SjB+9zsXfhi63+76grg==
X-Proofpoint-GUID: GtugZHI0Y13lJT4fMsBO7hYhyydLsTSw
X-Proofpoint-ORIG-GUID: GtugZHI0Y13lJT4fMsBO7hYhyydLsTSw
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69da86b0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=U2n3WS0MpVb9lCSYAfQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110154
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

On Fri, Apr 10, 2026 at 05:33:42PM +0800, Yongxing Mou wrote:
> msm_dp_ctrl_configure_source_params() should only handle stream-related
> configuration. Move the link setup out of it so MST can program link and
> stream settings separately.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745C910D1489
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 00:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3C010E078;
	Sun, 29 Mar 2026 00:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4Ult+bg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/5ITVBM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680B410E031
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 00:25:01 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62SNo2oj1650437
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 00:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HUOEicf8kvoElEElyXiEl4ay
 MNeZrpns2xYrgTBKlO4=; b=L4Ult+bggWTIwX62SS7FZHmS1w9OAekPtHxV3Mue
 /8dLAFMvY9uFrXwy61vnUbU2QpfEfwPtMO05SFYv7OWkapgEHblc2Atku+1IAkpe
 FDZniQRtUdRiGybxGLTu4LdzqRoa5fa5z2pSffNFi3qn8T9xs/gqBUVgSJOIsGqk
 SllVRHdVVJtshEmF3xjPUTyM8P6VzUUkzOs8GufnbmIUWRj5pieIfjbyUGXfscHU
 D3ucHXOMI0ahwKLyBA6kjk9nVcUHWDPHGZhOTlmHqNNrN624R3XauNda5INNShPv
 zaXDdyahITU5NvRbx3Uo+hJAcH52pf/nXGrYKubyg0i+jA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6898hmwk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 00:25:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b6f869676so61783711cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774743900; x=1775348700;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HUOEicf8kvoElEElyXiEl4ayMNeZrpns2xYrgTBKlO4=;
 b=d/5ITVBMXd0Yjb+o59EG2K6BkVnlSaLNtaOCJJJqeQspbGBcX3VWXkgNohoXgIfHNx
 PkOoibSWxUv5U4CMGPwTcnVz6hh6mUpoJVS6te66zwfzJEZHwC/r1UXN74sWE98hexQ1
 etUpEzkKWSI7StoiQE9w+TsAndqsLM8fsiIu/5YFMWN20k7VLR04M1msWtSj1mCCVAXF
 2+w6Zlad2lVTYGYzS5TQ5F9TQbcWDXXm0eeZfrIlLchNy3R5zuFzrpD/+gCiCavJSUl3
 sTB3ueFmqRkfBLivFefVz3ySmR/dA7Pl62LtIVIfyXm3KZSijOEtEc9z40K4qKCM9cqj
 bDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774743900; x=1775348700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUOEicf8kvoElEElyXiEl4ayMNeZrpns2xYrgTBKlO4=;
 b=crbYu3YlWTzElHnCChudrmCRpTfoEIyo9yemcIPufW8idxv6sgXhUEdoLtuUSd6ADS
 /5k4zNsG6z2h3q8f4IJZWTJvWIjgGhYRUtraymqHfDXfmggEBz+bc9mNMLI/9onLmdkx
 kKv4jSqiBB4H9gVXHfa8hwjrkuDe8lT349yjsaPNJw+fXJc2Qq48/DPJaZPgPsIu41K4
 CYP04Mmz/f4zw0pOZx7UthOJVtXI51+U8TbVGTjondulzq9SpJROViieDPAXIlbenTbk
 8OcFfn8anvSOYeJYRycjG34v76vDhBmJzZ/oJ7uTKRM8yeaK7VvUa4N+IZXo+pHVvDkm
 0Fmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSrlwzSbVX6fAGnMWzqwEALQGIVQ0uAwlOqj0ECAaPYps+RQTGkdtKFJV5AmcmLdQ6uTQliDBERTU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBt+06p5ZiB5eBRgqD2I3rvTB1WWgLmqHyiIrfb9H28Y1G0H3o
 HEsy9JyvsTBIB5YygHqiYE1SdHysNFPpAcwc6jbM8tENd84wJD65uK9h6q7WK6/h8vQAJxHDqS4
 cO5swJx0Fm53G9ydYV50VhfsgpKErBfu/k0BvoIvMKekNhxY1TmOMIW/4ZbMS4u4MS9T4zW8=
X-Gm-Gg: ATEYQzxTSJ1ExHhnSmjp2bXtTxJhWsAKXJHLzs51N56CeckyJlrupaYvieWSj5B2hmh
 rLiF5k5ldPmoJL2drGA6FuJJw1rEo+mDaZDy9ha0uDprMAxod8tkGodxp0W154Y5Sv2apa868wd
 TpHPnD2RYpE3RrAZh1ArTgDffVeP6il1gm3oxn5z70oyE2Ga4FWoKK6JZDtwU7WDyV9YJpmQtAT
 x6Hyqk9jd83DwzYEi7qlcR2jF4FtVyIhdwZXshamA7fU0J3UNUNCRC+/TIbswovnkdHcd6ToMTe
 wA7UwNuObq74spvSZBPqLPXNiFbnvpkhclRcYgOtcwLFHKQlmVcO7JkgxjBGAktQ0GblKTSN1SZ
 Zr5c85ijJxh3/99POhfmb86kyMgEl+3CfUB4519mjY+d7fD8023Bw7j9Fz+47I+r1F+mqxOZYjs
 jaH6XkSXxVFGBSuP3cEdS6G9PbLXeAcHcedyY=
X-Received: by 2002:ac8:588d:0:b0:509:1cf9:ea09 with SMTP id
 d75a77b69052e-50ba39c2c9fmr98680711cf.67.1774743899933; 
 Sat, 28 Mar 2026 17:24:59 -0700 (PDT)
X-Received: by 2002:ac8:588d:0:b0:509:1cf9:ea09 with SMTP id
 d75a77b69052e-50ba39c2c9fmr98680421cf.67.1774743899489; 
 Sat, 28 Mar 2026 17:24:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b145dcddsm748410e87.73.2026.03.28.17.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 17:24:56 -0700 (PDT)
Date: Sun, 29 Mar 2026 02:24:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com
Subject: Re: [PATCH] drm/msm/disp/dpu: consider SSPP line width during mode
 valid
Message-ID: <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
References: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
X-Proofpoint-GUID: _r5u3-wIgxS14g0gWIYa6a71pAy89itq
X-Authority-Analysis: v=2.4 cv=RtHI7SmK c=1 sm=1 tr=0 ts=69c8715c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=jl6yBGYvvWoCh8uJDikA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: _r5u3-wIgxS14g0gWIYa6a71pAy89itq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDAwMSBTYWx0ZWRfX2fmXipbgvYof
 /cO7mJGmdw7tW1+Ui2h3Ndr1WUPbRNriO+cuMF/ppvwAUhhu3cJJMl3LL6y9VEMcKLsofkcoLww
 uHbmv+Wh6cpjUt3YkyzXSVLLvrF2m8ukEL41jtwF2dWX6gnsZvSWFQH+OsQsfNJd5oLqEF9LQJc
 2Re3x8dtaeq27GZUYNs7tcmGZxkX7mdhUcr4stzVncfR3SVZLgB9/mVHzrUnwVlfok3BdXoBn9e
 BNeA1F3TBOFLcEvGhhdt99PAl5atbnRT8r+BQir6Nsg7gsAisCm9Si0PJUVWpNHkOC13scQrLpB
 HiFXHSQDdymN15g6iUTQGv60tBRg9dE3WnOWzQ9Sf67k45jTYx3H18m1rm9rbIU7FVsKLXKsn5K
 koKZ9Px4kpUKFwzcKaS+wnQs5390H8hoO8H2gyxFtaXST2avePcXlzrnngOWxiTKG44xbS3dK5o
 F2H71NHzQ6ljBrBaXqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-28_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290001
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

On Sat, Mar 28, 2026 at 10:45:35PM +0530, Vishnu Saini wrote:
> Few targets have lesser SSPP line width compared to mixer width,
> SSPP line width also needs to be considered during mode valid
> to avoid failures during atomic_check.

Technically this is not correct. There is no requirement for the
planes to cover the whole CRTC. Nor is there a requirement to use only 2
rectangles to cover the screen. As such, it is perfectly fine in
mode_valid, if CRTC is wider than 2x max_linewidth. It would be an error
if the user tries to stretch 2 rectangles in such a case.

> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry

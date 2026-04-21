Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4216F5A8D1
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 01:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3165310E144;
	Tue, 21 Apr 2026 01:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0lz7zBq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XtNhuS36";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED0310E144
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:55:06 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJ0RFc1532102
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=78k24sGovg1DTm8PpM75Wm3V
 cwUiG1h7+NdhF0k7e2c=; b=T0lz7zBqDZeX/f47KoIPoIOA2eOpWIHas0JDzCnm
 3NQv2edj9s8Z8moIQEqI2Qfs3oay6MK9QtwBjm6YmQKOruX6gUwrwxyTHxWr9EG2
 5jIqv5aD9ooLOtDdovSVb34oRfgIbH0TpfGUOG8l1z2sAncAhWuWS2isppi0kuJh
 eLjFW6ZCn9euqSP+z6JzDV0rkY6XQvjgRQWGZr/2clWGXErJHarawdCuHIsIvpeb
 AInYIZQacNAuzVgFfSu5D23T5hVg2/irsHlGiuWhLf1FqWrG+UedMe0WzkRm1uzY
 mRl5hcBGHiaQ2pHIHtbua35F+UKZyEknsmTDtCd5SZxkhg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus3vn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 01:55:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8ec812425efso305898585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776736505; x=1777341305;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=78k24sGovg1DTm8PpM75Wm3VcwUiG1h7+NdhF0k7e2c=;
 b=XtNhuS36Y8anEtuFKG7QjfniOKn2H2ohTfzD4ODcqQOpvGRJi+sDMl0BJ0Bl4stKbm
 h4mvUa7sRh0hcN8rdAH0EmePL8PSz26MQkVv3kxGwbzuQ8QbFOwdnE9aWHJrGc1Cofa5
 PSMBoNDaCj0XXLiZteqFUUFCaW1Gec1wnsgdyjNg8mcWIP5A5uPbF6KamuAx2OUJeGV5
 rtjV7BzUAP44WqzrN2sPZSsuZQPqmc6lpxzNiS/s0peFYIVOIEYD+srIzMinoSXy26FB
 eow90I/2JVDetI/10dYEYJUHREerbUdmRzOGww2q6py5c/zgIZ0Kil0jtKMja1O6+fdt
 LonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776736505; x=1777341305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78k24sGovg1DTm8PpM75Wm3VcwUiG1h7+NdhF0k7e2c=;
 b=aDpR31DF5TrStV2mPqMgCYMsX5wIazw15FPNUsaoXk6heHzAsNU36j2ndiAeWzKjTd
 p6cIX4ARbsLz7S0MIQYpGwCcfQyVp+OZPlekC2GgbqtedHscvt08kGixytdgqNvQRGrw
 ny5lX8iwhxwIdFO++jEp+pUK0+agZK/SIFgY8Kw3dzajuP8e9icWGzuV8aRoOnw04UPm
 7vYVuj1VZAr6m1OGqp1JexrMilt4/gPrT8z5AP0dA9+1T0M1PtK9ul1FBDfA8bfwCh/H
 ag2xuPIp9E7CxNGZjMNOWZjZhYKyt9g94m5HLB42mcg/iNDDFPRqiKemqyT4XoaMi3zx
 fNSw==
X-Gm-Message-State: AOJu0YyClnQf3+CvexyCdypaLZsxmYdLGCLMaKy+hPR8GSyAVfx96MGg
 RLtOe7nZi9AEIs4eq0zZB3lQHpmIONgY475m2rMenrJSBQlaxf6dE9mqMCCZXpVLAHlVU4TSgyP
 FTTJwcjrTPY4o30H5UoOrZ0WI4VUZEUDUF5nnYiw8ADNOKEZ9dUKweEPUL2JRINXFBjzlGpo=
X-Gm-Gg: AeBDievERVfDsLs6/5OV7wvsLxb49GvpKOBzB7jrt6pwdc9APs7AZFciqEx2dBYoafX
 CIb8oKQvXGBqXHfxqz1rdWTm3AW7TPTfcJ/MuOxAujIYFBGLd4l478TYq/Vr2WLkr7W1tVH0pDh
 FwG/HdztynNnekzmcjH7oeSgApCBXtuxej+n2oniVaboQ8F08Wt7TLjDUkk0Ph6bgv3j/DreCL/
 aFnIJacW4/xct+QyK8+nVAii2R2xs68RJYNrHl3CadS9lk/LiG5MNrIFVL30Yz25Qk/fb3WBzd9
 ize+QLQzomu1bK/DPVRXJoGuhmHJMmQtbu2+Jn+wuLmrkKuFKKpABTfB0CN2hD81307eTUTeEBP
 Re4La7mpSHy2G189qAwzTa1bqdy82+cpz/flRImL1Re9m2ApGhjrh2mQXs4A65wdO2G8acDeyX8
 WQUCCXNRM582Bd2a2N0R/aoXXGDyg5Kx25Kq9ti9fFEKq9ZQ==
X-Received: by 2002:ac8:5e48:0:b0:50d:af3a:d8ed with SMTP id
 d75a77b69052e-50e36c495a7mr241650871cf.41.1776736504863; 
 Mon, 20 Apr 2026 18:55:04 -0700 (PDT)
X-Received: by 2002:ac8:5e48:0:b0:50d:af3a:d8ed with SMTP id
 d75a77b69052e-50e36c495a7mr241650601cf.41.1776736504424; 
 Mon, 20 Apr 2026 18:55:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41ab29ae4sm3026380e87.4.2026.04.20.18.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 18:55:03 -0700 (PDT)
Date: Tue, 21 Apr 2026 04:55:01 +0300
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
Subject: Re: [PATCH 05/13] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Message-ID: <dfczwbybemcfqetfbymrtuempyp6f23k535pqarkadi3wltncq@b6u6vgx3q26y>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-6-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-6-robin.clark@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAxNiBTYWx0ZWRfX76Qjvi8wf8Bp
 6bcfnKK9FmqoNpLxiHA5USk+F2jhb26oh06jp+qx9XQpPQp/YdhO5e8srqh+RlVkMy8Wskf/7Kk
 WzvpjlUplnFQx82ZWctaYkARu9nDvjFUi9hJ4cJmbT3nAAzvkUys01ocBNhWapx42Jm//Sdn1HK
 zCLheb+RRwQ39Bjea0WUh2pfQ5Lf56vjYptsr3rzSiA9O+9WbvAlXTXjcLdbHLdATdbhEioVqz2
 O8cA6cWwKxjIs37os+aAWNo7vOHA4rWq9pA/u5UnzgjElr5uXFfCQeNu62pR25q5Shl7X8ZqoDS
 MtFbc7Stmnogogg1CNwji5i0i25yWk+ORa2Et9vZGFr9EpABJdQfiEya7c0VMfkA9nIWSB8tDkl
 IWBk0ihaseQBUiuTpkS3a4QvD+3nnhu3R6dsGvvIJ/nBwTOJ1Au+xKOgSaXB/CziYsRYs/iVKah
 GLgtaMKG1CnoH1ul03Q==
X-Proofpoint-GUID: MMDY3s-KbIYYwJaQ5EKaR2cHUPzSdncf
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e6d8f9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=prs2R5FM1gg_gDYrfJkA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: MMDY3s-KbIYYwJaQ5EKaR2cHUPzSdncf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210016
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

On Mon, Apr 20, 2026 at 03:25:27PM -0700, Rob Clark wrote:
> Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
> This matches what i915 and xe do, and seems more appropriate.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

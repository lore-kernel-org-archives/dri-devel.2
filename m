Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13251C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2900710F40B;
	Thu, 13 Aug 2026 16:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+09M2iw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqcpmUSg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8153B10F428
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:15:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFr2Gw3181683
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6e+LaW3yul46PnnkTF3KFrhY
 9wadBG1CabWIFspdcCI=; b=b+09M2iwW9KlmqorbV6w5LXAOnncoC7Vz930iiaw
 xcqEucJlhL335OPjnX1dx5mbiQcD2r9jL1vwCZY5YwX7R/GAq0ITyzLXCwI533y9
 CRY6Uwbd7C+4rbXG7tt81eF9v5hi1alCALyGsi5FkQMd22dURg3jjJlqSsAwEHUk
 ttAF/xyhMDnyjRlx5O/77b4BHpkRVKPYVLsV2CBFTgKHX025DO8c6FXAIHhWsD1o
 b0ftuptILIjcpiwqEs5wGdaVsMPmUQvx2lZw4nuRLdPGZ4aP1Ly4O1qvAPcELPh3
 AgVryZJhYCbTlF5mpXfrTRdaWSXNQynGd+SbaTMCHpsQWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4r43h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:15:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ef13b61bcso7353385a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786637733; x=1787242533;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6e+LaW3yul46PnnkTF3KFrhY9wadBG1CabWIFspdcCI=;
 b=XqcpmUSgZEvjAfasXK8zgDI6Bqy0p0y7vNUI8Qc3XZk4SH6/PkaTiQzUyP1osRylOH
 d8verPdKj0k7QhCLyWvfUXRTnnoF3oQVerVA1puOm/8onvsVdOkGNj+JaYiIDKLzm0eo
 68W9dbHiVsV860MYod6K07WNXiYdZ7mfKpFZTob9pQs0hpC9lp4DdHu9mjIuDot5KJy3
 3TGJrcx2sM6mnRnoRQdGl1e4H+/sB6imypp1ZfvWmF5IFwlDmE+SvzNhf6jr+rPlvZa1
 wyjFSrs3rBeb9lw+V1ApaI88bjuNer4tyMa8lWA3QAO+J53DWN0xDKkTXGzjPJa9joWG
 jzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637733; x=1787242533;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6e+LaW3yul46PnnkTF3KFrhY9wadBG1CabWIFspdcCI=;
 b=Zj3oszVJ280otINTP0sfjGbc0hj75OIJ8xNO580KPa5jNrAmAnDvaGEnW8182dEOyJ
 dPKhtUyCIVKZhXiaoS5bwvOogDL7Lv7ZfoSx5BsfnLbcPovuc86EdoBgkh7Yxt9M9KKl
 qp3tooDoJZijKu84O0Xrf8hiyspZQkv2xwq/8hiwfVa3j6nWvSwqOwTL1WtzFqMmbAoh
 3pFH/21QHxXxbThsqoZgn+o1Q5nDoY/BhEgCE+KKOPGv5vV78fUQBY/NNQLvLfZdWY53
 kn5F5LQJPIrF/88EYup2yl3Vo1TzaSAHvgVTRQ+0GfnRGjZLh/ohSDJB2mHNL2TnD0PD
 AlZg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpd602l/n1qJMq75oyHxiSD4avKTGL8wzuVVkpjGUv2yDyoDgJQ+wGA4wwUMqGkYtEInuOTa5FwwdI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVV4TltZDbHpNsiafL2NGgSqHxgEheKyFGeFWSb9NmERCbfp8I
 PNeGS6Bo1+7Xe1kU3cqktJKxPnc6qzptE+OMjPh39njxAXFnX7X8mj75hy7jMJ2CMukVUxZXpSi
 uBBCB07TsqDS5DHxxpvdnedeKIHW17dL099oURAg1cNSj9GXxLUS96JWVlVuS5zg0xBL6zFw=
X-Gm-Gg: AR+sD12xOdIgWu/1EBNB+hxQojH8QdSqhecfc7791T0N+EBfP9kSBU4Jf1gATiXeaif
 Jr+3+C6oagdolCMbrV2i4taibExvH2nAvLYYxg/k6r1lb1SFBR9LoIib+zSwzUIvPJXLBQZoC7Y
 R0W2LeEnNwXQZBMtmYunCNg23U30EfhQlqsGwtXwZN6XomNlzmcsKuohTXiHZOtc7O2gBTdkyGm
 MhGfDUepVQ7mqVd31lK6SRvg9rQ0tQwaxUR95lNdXLv6l9hoH3kt/7i/kCHLong2DwJZpXLpTU3
 4NCu8P9oOX3FHnzLnkf++OgMJdtYKN/FQC7nt9y9AKN+pfXZEu3eGUihZkbmvhr8pkxgzfZ2jzE
 mh3g/xCwj2X9PVCFsZvz0f+tw/gFzTeDJ6M5QPpMkt4a5BshlTYSFwlW/bg6k2v8fu/NrKNHsWY
 phmPT+6MbuYUaI
X-Received: by 2002:a05:622a:e0d9:10b0:52d:78c9:9377 with SMTP id
 d75a77b69052e-52d78c99f36mr34724701cf.36.1786637732606; 
 Thu, 13 Aug 2026 09:15:32 -0700 (PDT)
X-Received: by 2002:a05:622a:e0d9:10b0:52d:78c9:9377 with SMTP id
 d75a77b69052e-52d78c99f36mr34723971cf.36.1786637732188; 
 Thu, 13 Aug 2026 09:15:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b453a68391sm582574e87.78.2026.08.13.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:15:29 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:15:27 +0300
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
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8750-qrd: Enable Adreno 830 GPU
Message-ID: <rrjisqkx5bjkbcqtrd7so2fdopvuzxvmijg4oe3cvaz3ccbecr@izesra4p62tz>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-6-207ad1fac1c7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-pakala-gpu-v1-6-207ad1fac1c7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: cdWL590Wq0oj7uXgivQh49CYMT-1MFSC
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7deda5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNiBTYWx0ZWRfXyjd8q5Pwliu3
 dG4oy7lYHTpW+uRWB0BvKLASJPZNtCY+ENjg4MKi+RaK8F2xFQQ0K9GDAnqiPaKH6l0ciBiwFfu
 c7cn5HH6FzWXTDEZNKzCWPAezXHERe0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNiBTYWx0ZWRfX/WZ3VGOUqAz0
 /zKBUzJNgL99Wgxki5FtedKH7sLEl2P1Z9S1gxIN3A3zsEQjuE7wg2oma2YtiAADJWBmO7YzVDv
 cSi42DDmVLviOnkbhmdYB0ltEG1qu0JhWB1zqPPAwfGfBziKHh0ZKVytEz+JPuZdagmlZGvQZLc
 yTUlSWPaiSEMSYW0sIwCInPpmR9csnIlBcI66EN304dolQcryZ/o8rr8SNYsVxfVXDqke/JQ+dA
 Y3Lk07aHSgz4dqPDscNGumf7jD07VzCEdvIIxG1o9cZFxpzAWVgeiwqOtYCrcSJjci9lxRHlIl9
 ft4JZ1j8MT3WyMKBgMycvFJOn9xJA8Luhkl391Kykl22Zssj0pJzFzFPD7m0353wuYJCB2fQP/2
 mynWbGT/2vfw91mMS2e21GQeiOvJyDNCZZlEAKExyVTezrE/qlkjvhJKuqxU2CWBEMW0LMerAfH
 B/7e5TgWOxLlAymyrrQ==
X-Proofpoint-GUID: cdWL590Wq0oj7uXgivQh49CYMT-1MFSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130116
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

On Sun, Aug 09, 2026 at 01:53:13AM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Enable GPU for sm8750-qrd platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

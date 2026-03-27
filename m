Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8188310F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDBB010EE4C;
	Fri, 27 Mar 2026 19:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeU+Jr5C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIWj3z3x";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670E910EE4C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2q4r083479
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9xUya3rDnbfXOwBBfrr+GJsatb9QGfOZ/NoUziq/dZs=; b=WeU+Jr5CCpWN1psa
 yn+bxLiER11kOE90BLtlRpqQd9OLYd3sRP/bL4BafkK0D61mwdD92OriGNGHKOnc
 VMRMQYXO4ZQiPbnANGFDZ5I7i9++B4/rL0Dhld33nzwZY/lNH1ahw3ejoIeDiTe1
 /DZuUhelpijWq1Jbfd2Yz69nZ/aItfUSZYoifUgfEooXq482lnm+pRo2mJh5W1N0
 HZyOH8L0sc2rqhBU8Tntc1ip7bANB+h97yO0Y6VxqZV9rtOCfNDJkmtUJGs5V+sT
 4idInldFE0GgJqo8izrTDzSVLNqqDV7PUORFF6+OqzlJuwYlCATRUP6WJKGlJYhc
 oDNJxQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx39ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50937cf66b5so118729821cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640910; x=1775245710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xUya3rDnbfXOwBBfrr+GJsatb9QGfOZ/NoUziq/dZs=;
 b=dIWj3z3xHF50fzGMkNT3BH1gZCrTzToFpSmmrBbQKvNQtaM0l79/+tRVGyRtEXw9I4
 DLbUfPV8L4tzHI5W8+CVxsx9YLxpwb3Zkw6pwfLllrGqG24TJ5HjrEEht7Ury2Zsw0na
 mMEeWKvBpqAgR4/GHBfC5S5W0ohmZWtLS2IOi4NSnS2Uf/Wlty7k0Z0lH/D7CfqbOAFY
 PUGGuxsiXdjvWPD+0JkaUNxHP8eOXSHkT0TcgJkxliAfq7BjDUf4b0hoczHhUXj158i3
 8xMRWgC8jzvMh9lj3s53XWxZAcZ1ShBZhDD5M/+FdNPQwSbXmdkKUJENjrrFWFGr6vFF
 c+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640910; x=1775245710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9xUya3rDnbfXOwBBfrr+GJsatb9QGfOZ/NoUziq/dZs=;
 b=HdLk22yKWtR3IeVsW2eF/2Mwra9ZCr2Bq+4GPnrFfTsXNhBDzLil/tlEapDiwZmaPP
 W0Xgjwjdr56qcGDPEFD37Fjew/o0PIoOARl9LXJa7t3P5PB7+db+wW+DMyaIc4AnKMkB
 WRbyvJcmDRv46mQsOkU8hgD5vkUPEky/GaOl2BFUYNu9Iiol2dJN6DyllR9qQNQadPlq
 cbV84FcEBXzNNJpWnkFzaXjkPp9pK0Q2UZA9ymKSMaMCARMU+Qr586x278aIZ31Uvcik
 EbjeC0gD39db8BJlRJwi77DxiVK7WOVCx3cjOMcOy+kAG8uMZ0/tTqH6T7UoGfG1U3mj
 7wGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLGdUzbs7MmKZYdHdwbACkMz8ess2DnZ9lbGo4woOX2kashGVJL17U+ix6LNkPrhvzIEHYYbg8tG8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy/MjS5QenqRbdkHfkHoA8VTX4n8gfsxlWf9E+erH7r8GhSSGP
 smu/aT8m37LpxcTynBX697gdQgl7tPlWoVUzRlnUGJ0byapcnRAY7AE3z0jMJt66uvZ+M3RguFe
 +lPyERrQM4k32WlaAXHxx1GhQTVKqQ8ITukmCe911CGfZcBX/xHi07YgW3ELyeo1ASHuLRO8=
X-Gm-Gg: ATEYQzzR5qwaeNFNngJVEMocwJAXOcPTX79csMibUQywuQg/LiQRy8bKGjgskZDVTuL
 mEAIQYTSqcgK8Xf4m0mq4mVbGfYDhqMLBnDh+G4ssjIewxjgCOlLRjR0UqSX/X8EbkZKDIj8Rc9
 yAZJuM3gvLONM3gAKF5tOl1jBH9x2yVQ9T0I3P8MJm6sbv3RGwn4Zk7Kep0z0BsxdVK/kVBcTnd
 fI7d9PlludRjqZVaJ94PjkLuyolrTRiuMqcBLwUwakx3dS4DvpyWUhZyh4E3ZyhTd/7RsCvJTWr
 W7sxXz4Ggp0sz7iZyE2Xav+eTxbNc+5OpOHewMj2TlfhcMM/z1sNzW3fTvLEloOdTWUO6DLx975
 Z9NT+S5TGkSqYLgC+yHdD29fTl4QqoCRs719mvmaCO6Lt0nujMLNbyFtXNaw/wEow7vjWZ7q0VT
 obZ3BzZchplweMCQ6HrxNdc1mlfU91wLQz
X-Received: by 2002:ac8:5acd:0:b0:509:2527:d789 with SMTP id
 d75a77b69052e-50ba37d1d6cmr55045361cf.6.1774640909932; 
 Fri, 27 Mar 2026 12:48:29 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:509:2527:d789 with SMTP id
 d75a77b69052e-50ba37d1d6cmr55044901cf.6.1774640909485; 
 Fri, 27 Mar 2026 12:48:29 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, konrad.dybcio@oss.qualcomm.com,
 Krzysztof Kozlowski <krzk@kernel.org>,
 yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tingwei.zhang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 0/2] drm/msm: fix mismatch between power and frequency
Date: Fri, 27 Mar 2026 21:47:55 +0200
Message-ID: <177463970812.3488980.1593803967421467214.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109083808.1047-1-yuanjie.yang@oss.qualcomm.com>
References: <20260109083808.1047-1-yuanjie.yang@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6df0e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=5-8HcrL-3tWewVUv8uQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: d_X1JJGUH3U8af8EZkDSNESEUeJXVVUq
X-Proofpoint-ORIG-GUID: d_X1JJGUH3U8af8EZkDSNESEUeJXVVUq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX9BS7Kbecbkmp
 60sBnZNHJCF82FJtUnnxQBnsugEqH69EEfbWBGN8ON67y2se3T16eL4sIbPXa88Z4lmor9NoQ4K
 RsvxLLI9lLFwthV697sSjcAYvSgJG9zONXLrcjKB/TfXHUH0zKzYuHviKr874ex1c1cbunXilhu
 YekFc9T4qDVIzep9pzG/GdaTJzP3wfl1BRxDoUFM1ALp6XorrTLrIW8MeMiBR5rK60GSLfNvtCF
 kJFrrRDLNS0Nwi79wvU39io4pSyhUncQYNJ2kCmbRam+zPJfQodEwN+g8TywJQvZKu3lbi9TfTE
 q4S355F6F1qbAMmHik5v9jxJt1rkNUdq8bAvuOeBdCP/8jqA6rbZO9qS8fVs7Oxw3mBXEz9bGbq
 KSU5vzqJxMhkDK5ReBf89k78vzM0f8i+kd2IxpO3ul21yTbJU44pLWsHlRAjh4VUYUh6wmC6gyl
 Mbrz2sqi43k+gqwQpWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Fri, 09 Jan 2026 16:38:06 +0800, yuanjie yang wrote:
> During DPU runtime suspend, calling dev_pm_opp_set_rate(dev, 0) drops
> the MMCX rail to MIN_SVS while the core clock frequency remains at its
> original (highest) rate. When runtime resume re-enables the clock, this
> may result in a mismatch between the rail voltage and the clock rate.

Applied to msm-next, thanks!

[1/2] drm/msm/dpu: fix mismatch between power and frequency
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bc1dccc518cc

Best regards,
-- 
With best wishes
Dmitry



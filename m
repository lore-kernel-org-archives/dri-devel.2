Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7F1F53D86
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0071010E493;
	Mon, 16 Mar 2026 18:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6i2S1dr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqC6SAsS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD2510E313
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GG6Oaw4022233
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3K+xBV0IW2p
 AA7sUkhKfEISVHPHCQ8PY8xf8X5kxOkM=; b=e6i2S1drtHd2SCsDyqDwgUrqgdS
 SYlNQpzzTNCE0eajslMOeQjSsVLC972X8gsvW5mrklCQPezAh9HcKtLOKhFcGR9N
 BfyXW3s/PG8K3FX9GHh3Z02RAR6rYHzvmDkYnA18fNXNEeD0xgjPx5jqD3i0s2DK
 emDzYPk/SKl8A1JihuDqO3yRZkQEVRiqu+tioTmlDfS2wfXULHasZhagm5dA+WmO
 J7OtwnJOrfgR/ETVL+qZP2HyDHLWdyp7zMSPRBzpJbFibV6BCQzclnZifqSWCR2x
 9gs0heKINXSAz3m97udpljmK0NvAuEYilQHvOriIgaCosTXt8CyUO01rqCg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxn3fgh72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:34:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c738f71723aso3091358a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773686084; x=1774290884;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K+xBV0IW2pAA7sUkhKfEISVHPHCQ8PY8xf8X5kxOkM=;
 b=GqC6SAsSDPlBTl6iZG51niGGrECBlOiVvaxeNDRoJQVrA2LEZKXRfdUzbXyDBeCGdi
 bb4BCqgy3alzfel+Yo/Ep+Ka1QTGpCzc5hjIBF70lelsTRs5vQKy61KwrPiY51eFxlAz
 w0LWDLJx30/0lWhnHzG+EyOVMMCfhnBu+XLio/T2f6CquXJ1m8Y1sDMCWQxMIIG8jjEp
 ULZC73CDyNLhbyuJa2T26u0WpwzW6rgnSUW9C1LVGlFKDBbBoEn6RcJ6i3xqHdpXDiAQ
 tucOZDL5LF/cTRGf0nuwX7nvdcZK/d9YHUwkq0i/ZMzeJ1m8rwnT6E7FHl+kn3No/dSS
 eMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686084; x=1774290884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3K+xBV0IW2pAA7sUkhKfEISVHPHCQ8PY8xf8X5kxOkM=;
 b=eTc/Dj96annrXh/x3CGqFM34mmXIuZGjAQSizYzR3PDpKgcLE81Rq5s/jXTg5nkOHS
 AG9Mh/HeXCxoblFLCnPOi2QAV7kAciw/lUV4ph/gdoJjNxIZC/alq8uGJBnjvaB2JyV/
 Si3Y4RWAllS9rbOCRl4kln+iEnxto/SvLrj0PqUa48hQsk6bt2wIQHov/uZ196Nzw6Pz
 tVbaixN1LZXKgTsJvZYo0Nt606dl3/BQ4LO56S3hO9B78MPCaGBjI2Sss437q1cuvi/D
 WUvzrD9IZGvQYUjFL7MvH9oRYX4po6sGEn8U2iU0Fg9wCUC9JTYFleWcgUNH/mXKxzrP
 RPkw==
X-Gm-Message-State: AOJu0YwyCee5eZacWu8gPvIv2nfW0FFoFtxjZIavZZftRfAaR0UEeZfc
 MFC4J75sCMfmfHKdXCJ3jGH1mkiP3+ySpcHLLw0ZW8XlngnhW9EXqLRNLalrPcRPUSrdxaWttKJ
 RyRMno8gC1zSI3bf6f++jrzZEujp+z/QEIPhgNAm36/p300Zn/SMJaFy7JjqLSgjiRqZMxKdskR
 F2Ss8=
X-Gm-Gg: ATEYQzyOZKG0sdwOx6ZPnPY2/2BjFWUIqdCPHfnzT74v4JyE0A3pdWxEV42ePgovl3G
 xa4ZJO7OKtqkPcvC62yFD++q8OCaYYeTUkqNumoMBJ165/roz8iuK2sR+KWJYKBPj8+UmL8OJLM
 /uUypQE4/C5SNDhAfK+UfFYHd3ZyCjGy7xOjGaiaLkc2OW2VaHqU7KVAVo3rFHudFzrcH/OP/X4
 bJ2HWCSowyhvNs7QFl9jSVk922LETp5XRS8GKxLtLW54kuiRIx6wEWwQliMqvVAKp1JSNKpX2aP
 as+LQIgDtyliu5U8hVMBp3OeRJodSPSDy+q7YAvWNoBiqg6baxgu6hZxBqS7YfmfT/8DTwXMCht
 3ADPNduj6RafM6B1EHrmYCcZ5L7rhMrco
X-Received: by 2002:a05:6a20:430d:b0:398:89b6:1b2e with SMTP id
 adf61e73a8af0-398eca6b5cfmr13444972637.16.1773686084202; 
 Mon, 16 Mar 2026 11:34:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:430d:b0:398:89b6:1b2e with SMTP id
 adf61e73a8af0-398eca6b5cfmr13444940637.16.1773686083724; 
 Mon, 16 Mar 2026 11:34:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c740000056esm5980813a12.24.2026.03.16.11.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:34:43 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm/adreno: Change chip_id format
Date: Mon, 16 Mar 2026 11:34:33 -0700
Message-ID: <20260316183436.671482-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
References: <20260316183436.671482-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C5bkCAP+ c=1 sm=1 tr=0 ts=69b84d45 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=MCzI1sFhaE8V-z833YcA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: yNjIv-6J89JDrkYnqjRgHId95IiqrhGq
X-Proofpoint-ORIG-GUID: yNjIv-6J89JDrkYnqjRgHId95IiqrhGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0NyBTYWx0ZWRfXwWaF5ajKIINw
 rsx/aRpoB5fqOK3lHjAoJ95lNu56HJf9KhS0sjZXCLW2FtfpK2a+O2yallxGHTRAK2rQpnfT795
 rioCNjzhqxEAh9lYQi1mA5mDSnTv3YJUcm1D7aPZXtRnCcjWQUelWk6+XST8UiYxamlAsvaCrZB
 EXxJfN7MXXDMppBKNIy9VAV1oZIhPWDH9jRLw1xO/trbdUzmXMkS5wqmE/fcZyH3NFEMouFOS6a
 oMGZGFRsVZttjyv/NS5ioMPBISPalwEURneum1sNELV4kJ62GJ739HEUG7f0pfNGQhaJUc1h5IY
 Cq1Z5G2Z+fvJIVXr4iwSS0iBNVL6N0/T2IZQ0UmbPDyk3KNR8HtBV5UoIItveI9aRYXllh9coA9
 0WdSl9SgueOASt1ITmq2pUWto9o8bab0ujnHXhieGQJtzFZD/MEZ/6PFuJAlgrkF9IAZmiIeXgz
 lGjA+1DJuBcTvLybEGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160147
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

The "ipv4-style" %u.%u.%u.%u used to make sense when the chip_id was
simply encoding gen.major.minor.patch.  But this hasn't been true for
at least a couple years.

Switch to %08x, which is still easy enough to read for older devices,
and much easier to read with the new scheme.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 1d0145f8b3ec..6cdfafcb0c57 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -67,12 +67,8 @@ enum adreno_family {
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.
  */
-#define ADRENO_CHIPID_FMT "u.%u.%u.%u"
-#define ADRENO_CHIPID_ARGS(_c) \
-	(((_c) >> 24) & 0xff), \
-	(((_c) >> 16) & 0xff), \
-	(((_c) >> 8)  & 0xff), \
-	((_c) & 0xff)
+#define ADRENO_CHIPID_FMT "08x"
+#define ADRENO_CHIPID_ARGS(_c) (_c)
 
 struct adreno_gpu;
 
-- 
2.53.0


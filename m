Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52716C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36AF10E747;
	Mon, 24 Aug 2026 11:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kgWveR9e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+WVtrgE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9798510E74C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:44 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMcG42372592
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZLZv27GFMdz2STMsdvHGdhaNYpEqqU2M4a1flwXbgR0=; b=kgWveR9eOeTiZKf9
 JtBtq/rJHMgjCrLl3uUTfLmATdPeZn0AwKvmmPN97fAtMilH4Gxm7xK3y/nHWGfe
 XPIn7EF5PdYkyPfEFHyNspHDOCMSFCGe1PpA1QahHxrCvC0kEbTco7H2l24uQlKJ
 3j/kUV+uZkXdIj1g6VWKpa44WxmtGf7JqaeVI4xOPllPR8d6fmafJUQSZqAUel7q
 tQv8JVjkw31hoxsCshcK9zBIHyaaQi/JLtPnelTsaa3dhI9wxb5qIqqPnWPv3Ycu
 6c9BWKilvRtOrsR+ceHQOPObRGq1N7w1Qian/vGE/Ytz4djet5IooAoFtgYZUE4r
 0YgN7A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshbjx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:28:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so5288942a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570922; x=1788175722;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZLZv27GFMdz2STMsdvHGdhaNYpEqqU2M4a1flwXbgR0=;
 b=N+WVtrgEhHjm83/9ZnULaR0JsCyVN2wefwu3qS5/G+pBOlb4E82KieI0WVY5LgHCIm
 BarI+xl8wZPWyMmSRvpFTTq5ckid08jkk4zHjZ16trTenEZ6F2fCh/9g7mGfGVZml9wI
 FgXY9NxCQ40zOgKToKbZ8qE2ufiq79zF79QMWIMnBAW2ABOi8SE96pyWFuJx2TVn+fwV
 AVVjb8Sl+RrcW488LcsTLoyvRVkxHu9CyHvWXcdao1OzrqfqQZkETdvE2+wpL/rIxm+X
 b0M6OvO3wKtRhPu3S39B5y/ceLNMVy++iVdIyC/EAkiaGc3sXVQhkKf0JVaa4wnatnVr
 3SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570922; x=1788175722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZLZv27GFMdz2STMsdvHGdhaNYpEqqU2M4a1flwXbgR0=;
 b=HhzNWLMLejMcYTzkODOThRAj3F91Eb6kWMk68UNKGVEIifOaVQWPo6zg0L7Vfj0PUL
 2mnnrOB36uIsY2umWQrm8R1yxrz0pMivmy3tXUSFocQB6CymrKm7aSZzMS6XHwP39Jm/
 IGACiN3OKqKRYNJyspdZeVtB4JGGDj+P6MYzV4QmbQYMUd/p+GaB+kNpoqhxYBwGHoC+
 kgm+N0WM26LNrs+2+QhWGSk9X+CS1SZv48rhGMLy9bwGSjw87tHix6HJ376fWJtZBtBO
 qzn5IP63mYRK41857oO6yOoC/1FxoqnMm8D8wrKhKzdNgjzgaHR7B7tW5ZvgZrUMAXym
 gz1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RryNoE3tg4pw45s0zko4LGvxDJA1UwwTHICKtIwV1ix3ut1J9jPWBH/srap+OuUFnUrvdClmPPFQ/E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mvvFiSbfwEc6Mq5wvLgrbSEIiMIO530i17UoJ/Q79F6VJj5yCy
 7mKWKK7NAojFmC6XbzXeu/oYnTYAZVe1OCKWaEbwK8/GfABb1UOp5OSpx+dOB2VKXmOdL9SgNmV
 XLxXGFbQ/8obCi8rIl6d3UdAA6p00SnWndA0YEjvmE7HjGBRGyr1pW2WatbMHYApVa5Gcif0=
X-Gm-Gg: AR+sD137D/k/B5xbAQHdSW7KC+xL4A+u0J7d9iZJ/bjtOC5389SPWTcRicrC+vJ/DXO
 Xu49sJbs6ZTgy8Jx/VNLGHZUGURlQdyjCraHuVka1d/rQtd6SuaRpZ2evp8MbbUsfBi+lqRJwVs
 RQX0ZWurSGiwxurFdU0VQZ6n1Wbg9F04OlbAl1H3Np5ZmBCWR16xFGZWUQywRWPpoR86aYFpWow
 wswTQ6SxStVbsfT9muoZAR/b6TTm81buYJlACnAklgaUTJB2M3OYKFr5+7ZrWx1zadWfxia9ETu
 T29V+Gy67ALdctns+5NVq2XP7cw/4is4+EWKEg3I5pzwDoHqfIh85x7ymZuczwZUjt/AcxwPu5n
 f7b+arbUq69HP0Loq
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-395c34fed98mr40733960a91.4.1787570922487; 
 Mon, 24 Aug 2026 04:28:42 -0700 (PDT)
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-395c34fed98mr40733876a91.4.1787570922038; 
 Mon, 24 Aug 2026 04:28:42 -0700 (PDT)
Received: from [10.213.109.15] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af750esm9825643a91.11.2026.08.24.04.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:28:41 -0700 (PDT)
From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:58:05 +0530
Subject: [PATCH 2/4] drm/msm/dp: clear force_link_train flag when link
 training succeeds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-qcom-dp-typec-reconnect-fixes-v1-2-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Vishnuvardhan Prodduturi <quic_vproddut@quicinc.com>,
 Mani Chandana Kuntumalla <quic_mkuntuma@quicinc.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787570901; l=1035;
 i=saurabh.anand@oss.qualcomm.com; s=20260824; h=from:subject:message-id;
 bh=Mk2iABepIE1j1SqlHuK8xywuEsIdXul0/MUc4PhM33o=;
 b=xSb/4S4PD++J9HOE9OF1wpOpDqfbMO52EZhU9enL2AW1OLH6rpVrajVg5lZG4CpUFO50HQdNr
 tarYw9mrH7qDRnCK4w60xn724kYZhx8AlG7MKTQybAPWUvWyCxyQNPt
X-Developer-Key: i=saurabh.anand@oss.qualcomm.com; a=ed25519;
 pk=AzGwbGUPO11yi5XTeGyJKOJWLfzXp5Dru4z+PCg/uXs=
X-Proofpoint-GUID: MDvmzcL8AEIVebAb0uxUzeshr8LLjkfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX9U3esIaFUGwe
 Q90IV3yTlA9pLMFkZFl4qea9oCJEhejj3hQtxg+TwehWmUkYljVBAuqHryh/Rgfgglx80FDJZ8O
 kMEJQBdUcKkfFEXOrlEQyJGAGEU6I1Yce7X4Of07y3EMFAcy9f6Wo0RRWgp7zOnvjh6zd85BBKd
 5GCKqyDEOJcKMG42Zwaj/dZoAQJ0TYSoMDD17yP3IIB7wkkD954H6IRp2L716dHYRXgArE+5hIo
 0L0e2CZlR3WE/13Gf9GbvzvN3iwqKCtbwsGDkePi55R/ULoESDjjQRep2t7Go2gngc+YVG1lRog
 538me3Fk+pX2duzXRKRjGSRhKhraYjDyGbPlu8O+3wyg6lgXpbo41inXVvBc1gFwe/xPFZt5yY5
 KYHP7lwfxykF/tO4XJgM1RrJNE7L6vPpE5k4UEAYsWeGlaAvHJd9WxoSmGwriWQQ58rh0R7TxwN
 go0PS9BJiPhxGjqCuqQ==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c2aeb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rL4VQYfKDX0HzXWNMRkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: MDvmzcL8AEIVebAb0uxUzeshr8LLjkfn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX8dTyz10aeqzm
 DXpDD9oLu9Nzk/1F6KOjMwon3ybr3orkmeXOhPoMmGYzO0RlPQutm+wJgNHiZHPmc4uDapGlCkU
 krEVW3yourLv1PAQvmeSSEWfrqCWdZY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096
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

msm_dp_display_prepare_link() sets force_link_train = true before calling
msm_dp_ctrl_on_link(). On success the flag was never cleared, so
msm_dp_ctrl_prepare_stream_on() would unconditionally trigger a second
link retrain even though the link was already trained.

Clear force_link_train on the success path so that
msm_dp_ctrl_prepare_stream_on() only retrains when the channel EQ check
fails, as intended.

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..40e19d506a45 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -649,6 +649,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 		return rc;
 	}
 
+	force_link_train = false;
+
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 

-- 
2.34.1


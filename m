Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6F5E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B1910E91C;
	Fri, 10 Apr 2026 09:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dsTSf6x/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HgOz/0ZM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716AE10E91D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A672nW3352625
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 61XgEuen/vh1qSyxqs8oQ2EWPQNDTMGXs/P/Z/wvWxc=; b=dsTSf6x/NzDD4CAy
 0lH49QILi6G+snmybk+DgUclv6TEZSEVj40I1j3wVKIIbDnVeU+Kn1T4dgMVlWG/
 8v+QXi+PWvbLEVqA/D2+rR7aPnXuHTZU1CGXHTC/UtyEgK8AAwkGu+pWe1012RYo
 Uz8RJ8LkFT/NtG5akvbqDLX2CG1nzBRogqzUJalmsOBAH5eN+hYeLxobJu4JXUeD
 O2F53Bsnwn3Ir1EgnUtCYkZyfKiRzYcCwOwmNHiEVQ6tJVrrPMFek3wLOqg26J+I
 J8teCbcuQOzFT9guTBJC4S1iSP0Xp4UEmDKmjA0ojSnC8/0yK9HXJbt4GZcE+rRb
 GAFzxQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec1quvbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89ce2a7fef6so50315606d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813754; x=1776418554;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=61XgEuen/vh1qSyxqs8oQ2EWPQNDTMGXs/P/Z/wvWxc=;
 b=HgOz/0ZM0YYQ2KZCuCv+sd+y+hA0zXk/ogIoBJpAJGZdrtCy/9NgcW2cDrhYHw71Hz
 YXmfr7DfcH/F5n01vUDrh33GC7sE2+/pEFY2BMWHBJmlZgfjZiWAZhu4qdJjWUOf/T4F
 SmRPmDC9m7+IIqmg/fXjCp62WE4kgeKvUN4veqahoaHxzDUMXa6FCEC7qs2HS0KOT5mk
 9SP/oRlLPpqOERvYxhDZ172TbmDjWSk5bYEapIqv3nmmIPOIlEBIT7Hb2n5v6B24mqTc
 /5kmzcMGu5r1zYPRV4AsC8s1XsD5qjWpFX4y0eISd0qe0mNVdTAXKtQHEUMbOWp+NTmP
 SfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813754; x=1776418554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=61XgEuen/vh1qSyxqs8oQ2EWPQNDTMGXs/P/Z/wvWxc=;
 b=dy3RpCdLkEpJFk1cSFIVYXTh/XdoK8W5RqqXsraYVq+OhgpL3+VWLadks6lf6Nfv8l
 Y5IiWXfVOOdRvFjGGS03qKsaYoZxlXGLcfCfQuQ6vgpeL1P0PVr3nZeSlebqzK7oKhT2
 EUxT7sv9B+Nteru+7UrRPBs6jJXwU5IlWc6dW7dvZHsIV4imi2X8O3xbrL/5r8Iw9kBH
 lSFEJQXJFxu83fDDuNlnBCeVrFlwP5JwvVtWVYgnjpCvEUeYWp5btHq0ejVjz8CK3kZn
 lSUX/BSBCuwULxJYyfWN+1/znV/JGYIOKDi6niIjhAu/4KcgInQ6ZkAAPZdzcJakz86f
 ScFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrO1QXnMizDsZufRN8V2rU8uS+gzmViv3piodrTKaIts1pMtckhfxHoyQD1Q8sRqtzvf2WD/nfFTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziSnWVricZ/EWbOxlxx0ruJI5ID63Pv0d4k6ndimoiXARcmWIw
 OFWzDsaZ0ikeItR3mGi0fZU/xNWcB9wTmtJWWdyAMRW2R5OTh3mowLuqBQ5dzzWlVsQVJk0Qu5d
 fxFe/34chqp0v9NFWQVhl6kMJ4BkES9GiwuuMP000ADRiXt6fSeA8jly2oSF2FKHRowf0obY=
X-Gm-Gg: AeBDiesk6l0cyfd4TDp8Te4IakOgcsLn42AITQFwa0wlod8kAX2cHcTalAPrJy92B3q
 QKbPB4vUrTYNNfJUt623qYEkkNdDpt6tI6D0DJxvgNFR/2EaCnoVn0RwRV6N7YIvdISV0+rW6n1
 LVglCkGWVWX7coEDQeAC68mnsbKyd+DWTHHUTjR/RCDN+56BgSGV1Oy9iC5PnrNeCszpZTWGuaV
 LMExLO6e0jCbfAwejFfxq6nZtSTam95cwL9TWq7zzV0YeAYRbb5RE0q4ZeetMUOfbugaeDQFWxK
 2y7OjCCgf34pIsVxvlIoiZRunVlGkJzS0DSqjXcnqvfA0aQwPp7JzApILMrbzDzF8zP7VDE/IQ3
 SKYf8tR+YpUc66m9yfGEQdjJET/jF7tMkXZ8bDqYLq3QMJyZlZJj8Ob1WSHuuXcv3D2uj9BUfjw
 /297RYV9M=
X-Received: by 2002:a05:6214:449e:b0:8ac:7f70:4441 with SMTP id
 6a1803df08f44-8ac862b51ccmr32891156d6.48.1775813753739; 
 Fri, 10 Apr 2026 02:35:53 -0700 (PDT)
X-Received: by 2002:a05:6214:449e:b0:8ac:7f70:4441 with SMTP id
 6a1803df08f44-8ac862b51ccmr32890866d6.48.1775813753334; 
 Fri, 10 Apr 2026 02:35:53 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:59 +0800
Subject: [PATCH v4 24/39] drm/msm/dp: simplify link and clock disable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-24-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=1710;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5dPPK/vqSa+qtBhbsYuPVQd47tbzmeUp7YSNmjusLwo=;
 b=YnPj9rhLUqX0YMJuz2KcI13tmzC5pqiY6d5hLKxDeRa5BnhKKAvFXqZZs0G2L1JkUppp16Gyt
 XmGF/bb3PUMDT1iH5NZwq881b4Zg+vYe031JZuwYOXjWIRCdbH16bxQ
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfXyYguFRP8p80/
 ce+cbuRWtfh3E5XQvxv+XxQiuGy6r7F/uJd4WJZt/O7KVEyzZ59yBQYPbo1bFnaSH2lcfmLTII1
 FIrPqvNN3rzvHEDhSkT45DqNMg3e56xabGL+cE3LBorgbFwhNgSNAfyx6Yg4GGPiW1oTYi+1FOL
 ARA0nB9C1kBOIRxnTF9eggNBAlpcm77EIBJAbMYZyE5HBOl8oaaOtEBLqKHeDnknvW5qwtHwVEm
 vxknCEpPrknRiS8EOdPt4/NgEUuKioWXrBklBCt1ASySiXqcAfNywvBKefpSD9Jdnmj/coL7/CK
 gw1fwqHW80KaZ2Zmfmb1ikyknJLS/PNgjxakkEtYslu4eg74h9RJiVWQNUXaYPtJxiRfaF1w/jc
 xtue51Pgqmpx6qauLvWgi4/fmWwtQsEcvEZcSR9wTdriKBIcpQYYws9l2AK4ZmnOT5Ab6YyQMBJ
 hRXUB3NhECVPlShT4kg==
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d8c47a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kizIpwokdwCcU-m5XREA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: oIjEhedoJkoE8APjHr9iil2vQ-lnzx5O
X-Proofpoint-ORIG-GUID: oIjEhedoJkoE8APjHr9iil2vQ-lnzx5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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

Move the common disable steps out of the sink_count check to make the
flow easier to follow.

No functional change intended.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e8028402f748..7b3b9160e005 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -734,28 +734,19 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 	msm_dp_panel_disable_vsc_sdp(dp->panel);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0) {
-		/*
-		 * irq_hpd with sink_count = 0
-		 * hdmi unplugged out of dongle
-		 */
+	msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
 
-		/* set dongle to D3 (power off) mode */
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
-		msm_dp_ctrl_off_link(dp->ctrl);
+
+	msm_dp_ctrl_off_link(dp->ctrl);
+
+	if (dp->link->sink_count == 0)
 		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	} else {
-		/*
-		 * unplugged interrupt
-		 * dongle unplugged out of DUT
-		 */
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
-		msm_dp_ctrl_off_link(dp->ctrl);
+	else
 		msm_dp_display_host_phy_exit(dp);
-	}
 
 	msm_dp_display->power_on = false;
 

-- 
2.43.0


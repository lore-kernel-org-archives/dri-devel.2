Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4064CCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868E510EDB7;
	Tue,  2 Jun 2026 09:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hohob0sA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUJn65JN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E36E10EDB7
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:12:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6526LIDl2885067
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=; b=hohob0sAycBvqqdr
 cpqG86dXz2IaSY+iEs6Fq9x3tkF8+NOvcQuM/5nPzi+lQY3Uiy/JVmBR4uvuLowP
 hyT75i07ImJtfhKJ7W2xOHEQITteMr72bs6QYvQbWxvxY5PjvQ0t87Gql+9n1Vvh
 MvF9dijyx66cC42mwVHXfviM44ZLijS1nGnFBYd3WVmFEf7jEYCaxFAGhPXVQzE+
 0SLEM/wQMg9eDB4MoLOjEr1XNlZfo3Kn3fDZiuPgAGu1TMr7v1utOU17ztDdEIxP
 BecNJPXC7JiKiqaFHBbsa1dDhL/MblZCozL3+iUea+MdOU0tI3GIFu6uGW/R11h3
 D9oFzg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu10pfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:12:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516e0846095so49551631cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391540; x=1780996340;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=;
 b=FUJn65JNT4wt5lxagJerNbr1fGxlXE/d8rb0TVFl1qy9kIOAjtPD67dh/EFifVx2QE
 lppPNAMJJ+RgFInPcGRG8+1v/vm7Q5xYfklwuMA+AhTWjgR47ShiA/C1h+nAJBUMJnIL
 KODlS4iRfQOJ6YmwIm8dtFbcW8JVn9mGkD2pgK8pBfSTv9hcfyepPjNPzDA0g1Gnd+se
 kPsfaS2TNNP3hP26eTSgx0NKr8vTwPw0ROnRlEPQnp2OfVS1zzI4e2QDlVTT3JkE3k0g
 y1tDWoBj/rMTL6/9yP55HZ9VNBvlDmwZoofu9WVhDgRO3tt7DKtwh9QaJy3JGj7JMa7O
 PwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391540; x=1780996340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sRjgMQtRt4M0KMMF63fnqZRXOOmmbwogwYrfMYQ8brA=;
 b=YzhH5pnTegvPN0yaZoCjRKG9KPF5cIg8xHx/Xg2rbQuzqodoN8g8qXurhqEF7315bK
 vLXLAMVS7kNKjnvBvr2l6D4TrjazCcvQbMqt2PX/dQ/z22qhTgnX11YS4XtSa6Of630M
 5dx0f0zUaxjql3zj2wB49X4HDLGvEYV3b3c5FyGY/ZAAS+l4Ybk7jm/IuArDSPr1XGXN
 jyUsCvHcfSU9E/qEcFKYL8M2Rap+x+4KpjCaX1NuJDigjI5QtgM86Rl/wu13YeqVQQcz
 cTkyUKIpFMAzaFK1/TWGXnMMBPH4ybvCCetiB1jvujBTbCo0klRf139FjXTf2n6bRIvA
 llfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/A59wlLAFDrv4Maea+RkzyRg/ONHLPHLwHMM3raAcsM78/EPCH6vAO02D4kVuxVquOLlF+Inr3yt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyP0snCkFPr8+khuEfWQPSsreEBVU35goh8fHIl0F3d4C08uwOk
 ppeL00+KMRzH82oZRdbLE8nKmdJiBFUaOOVHM9c78Vnec+hDM0nrgs9NnIVGLM8vbcuJR1e3iC2
 0X+59DKehtdrg6xfBTAnJEBlV2iK/MLB7sVzJL0wTRMtHPswJHk+TMTL+avaoNYXdUwdJyD4=
X-Gm-Gg: Acq92OHD35qnebWoyOcepVOrczgtrxhIxOZ07E2LXdMp7Yx0k2VKtiMuB+4m0Fd9BpX
 gyS1O+vOfbk7Y2NFM2w/OMelzb/LKsGsWLivMrPFKyJ3MTQqZTQ28NWLHBnx0BaaVwB0m9lF4H/
 zBcsf3+II6qZhL4r2AI6Sf6JHGTitu8UlrOu1TOOBBwDnqHCNlbULqSeuYhBuKM2yK7ADH500cJ
 rU5psIlQFpog0BToZ9WB944FZLBjURur7j74ThqvzUFN4xnvR4vIHVpXBrT+TT3acW8IchhTFpm
 rg1spyFav7lS84yXgcJyy1BMetjPi6om/v/xXX4FWlKogN6JGyAvwIFARy7Zc+5bkq7pcNwmrWF
 R3gJT8N8m7SkgMn/OyUnMmw4gCsLiKE/JvZUrSZ/z+mKpDxg7YUY/wsVWgJQt3tNClXH9zCfwFC
 HnhtaBvqIgpD6GQ5kJTA==
X-Received: by 2002:a05:622a:5588:b0:516:d4b1:48cc with SMTP id
 d75a77b69052e-5173a5b4efbmr215705311cf.8.1780391540653; 
 Tue, 02 Jun 2026 02:12:20 -0700 (PDT)
X-Received: by 2002:a05:622a:5588:b0:516:d4b1:48cc with SMTP id
 d75a77b69052e-5173a5b4efbmr215704941cf.8.1780391540253; 
 Tue, 02 Jun 2026 02:12:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:12:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:24 +0800
Subject: [PATCH v6 12/15] drm/msm/dp: simplify link and clock disable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-12-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=1745;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=4TJKG8RTz4R+dv3UNXgRl/mjeEf45SUuZJzked/IkbU=;
 b=ox1G7nychJ7oiBzA35Qma6lzidQKD+nkk6+TZgyPQArcq3cOd+PwVMakMQT4j5LHOjZb+smiV
 9CGT1edwi8UCq2Zn53qsPUrVFxLMT3ox/KsmqBNE7QmpzHyHPCKA4pc
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: XDEgRB3Fq5DFJi8kZRPjfatMyLtMdxPT
X-Proofpoint-GUID: XDEgRB3Fq5DFJi8kZRPjfatMyLtMdxPT
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1e9e75 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=W1j8KJVysGQzs9t885kA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX/6ADsyZE2GtX
 11BMO0AN2LtQpu/NdUp52SeffZV9s1IDLEDoxaOlEW8QrMYWezePmDP0NvqvqXw3CROYpG1+Bxf
 gnuoJemejMZD7hgorX5XgdPPEM48A3UtjiVYa041NjoZHW+1UuODnYgz6VkoBQvp/1F5j7xu9zV
 XAOocNG59sgvGt6+NMiXYyR40RChbgVbBPO+/swa0NyAgaiQxEgbvrnHdFWW5IXvB/GJ60mF3Vw
 PSanBO4a2T5G5GZAi2HC4NVyzBGr1Yf79Z720xwKbhGtbkSzu84YPtEa33doDUhual126vLbe12
 vy6d0NH7JdyfrIowEKDjhq/sl3CFRTm/AOG5tdazAtgeh4gFENZmt0FGg/9T7Sm2G3foxBSernj
 4+njM36VHFsfWG5PioqAIf2nylKjjp7lrZZZF6iG2gD8TfxuE8U5XWUwCYPlQ77Buv9FpbtxjPO
 C30UV1hPyQ05vzEdgyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020086
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8f472633da82..63e5b191f95c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -716,27 +716,19 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 	msm_dp_panel_disable_vsc_sdp(dp->panel);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0) {
-		/*
-		 * irq_hpd with sink_count = 0
-		 * hdmi unplugged out of dongle
-		 */
+	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
-		/* set dongle to D3 (power off) mode */
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
-		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	if (dp->link->sink_count == 0)
+		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	} else {
-		/*
-		 * unplugged interrupt
-		 * dongle unplugged out of DUT
-		 */
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
-		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+	else
 		msm_dp_display_host_phy_exit(dp);
-	}
 
 	msm_dp_display->power_on = false;
 

-- 
2.43.0


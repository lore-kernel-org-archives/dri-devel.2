Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B86C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE51110E86D;
	Tue, 28 Jul 2026 10:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6DVw3Vy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZhVwsroY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F339A10E879
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:48 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82GhE2128832
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z788nYiu2HLdFhRfZEP+hSwajDMxayhxM5i9UjJG2QM=; b=h6DVw3Vyp6PF6c9P
 npKWxg4heoyO9CifxkQgx+YwOA0NznY/BdD2yYb7g3wlPbnT0wNBXtkDFU/ox59P
 g49dIlteIxqMPzcoH0SrgXjx1IOjGFxpGWo/JdHg9sLem4ukgd+KCS87jqYqXJyp
 N2pjqe2SfmsCtCGsH8cfyCqk9q/F+qXtAVQ9asz9LIYOFfSbvU/YFWieYg+JjxZP
 LTpbYKTwPvkZrO/MQt8AkLmWlV/Wsyt9RM2cQSyvqTxD+26H2fnBxJ8OlfD2ur+3
 PkO+gSNqtXJSEaV9yVqp0ZFdxs2x7gGzf8TqCTrIiaI/HjlJpfbSRyScA9ePsWBR
 ODkHdw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8bqb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ea75996387so87953956d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234167; x=1785838967;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z788nYiu2HLdFhRfZEP+hSwajDMxayhxM5i9UjJG2QM=;
 b=ZhVwsroYNxvUZrbuCBERYX7M96R1gaHsemfjKM4AxZ91djc8z0jRxWAVcqSV1uiszk
 6VISJaYbOZw+uNRSMXRr/l/szyohu+22gaOsU0vd3RSA1OPFLwh3be++FFHtLTOHJhh5
 HgDCFCSSm+Sv2efZ3hNihwxkm/DVyqrx2V2EGb7SeOa0D/ZkPn/Fd9HRtPjHjpii37zx
 NAkcIodZUN8ELSo1uJvZgehPOVMlTjOaDUCM5Y2bWUuhRYdADjBdNWfpUHj3p23wTtoH
 dcqdxDNJfttXUaT3lUgjfygAcJ3/xcpB7hEujmfREKYq75M8pu4q7kLVwmO7Bd3CiJLC
 sfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234167; x=1785838967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z788nYiu2HLdFhRfZEP+hSwajDMxayhxM5i9UjJG2QM=;
 b=m0LseHzbKWUNtggwdudbkRiwXuF/S8aHvbbMh/6lgkGk1tXIR2Je8dnuv5AQ9b4woI
 d7DRr0FNM2pFx2Zjpf6hmj3jj+JgzWCFLRoLfnwqs06tO0lz9KfZrpM3oydbILrJBhj3
 hU1Zo6o6pmit1oLVtuGt5XrbMGYT6FtNeDAxQliUrwB5YNkXaMeaRKVEGJ/aP1iTNMXK
 /+S6iprcupX/editkX4y8UsvjAWvJazGwivxLvfj2/V2eqXiyh4gxy7mj1g98dSo6mKt
 GaNQzMdLmsRGUxsz6LSs2YjCpLztVr/jekW+m37QAQgjsXLFgnt482Acjra4OICKh3lx
 jpHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUZ1vtByCmDiehJL8L4ptKnPpqS4jIDvw1Zf8rYBaK0MKjNI9LGUqBOSPaEHwdMZfhvklrQ7nzi4I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytyM+ucN3HN4whr/0oLqkbReytw3LkMjET6kIgUhtf2mTTTHOe
 uv/x4p20aV0hcYXC/zrwiNkNvdoItg13+TgRuoyHEnrQfmxeCDnNQQhU5XcvpVlEbEXrTqo1a2R
 YjWoQC3WdQrz+VTJ1XSofJZc+1cVbLmBm6c5cBDRfCw587zBs3P+JXOGS5n4ETFcJACPN/wU=
X-Gm-Gg: AR+sD11OVZkoed09dj9MW4HJPjlMNUORnpa6Rqcu3zxb2LDGR0tZqsSAK44dwm+/1w1
 rUXuXVwh881zK79KRpSptRmoVsFmF/vfyXz+xfJkd35PnpQ1cjAdl0mfjNfERWvwbdSKU8K2Zbp
 x30fMFGjf+XOrKlUfSU8d9SwPESNjssYUg1KKOvHS1KlgA/wkpzYhMAx3z/xiFLDpyXii5r78/k
 JviFXCtIn8xcGjpWoLYFMGXFudysD9bFSSdpV8A4q2q3eHilfiw+u4ENg7f4SoAjFadwCRWGaOj
 nf2puzGMk4WZVurCSEtv29KOJY9loaxjjrx52cdJsyZ+dmv+NWOD7g2hD0nb59A+UB5tt20l4tZ
 msmPlmLFTG+xHiElnNdne9P8SpXDCNm0MnHySKIe/rxkdNsWhtfN1yve0ZRiA7j0=
X-Received: by 2002:a05:6214:4984:b0:8ef:cb5b:6de3 with SMTP id
 6a1803df08f44-9081700485fmr15792656d6.29.1785234167451; 
 Tue, 28 Jul 2026 03:22:47 -0700 (PDT)
X-Received: by 2002:a05:6214:4984:b0:8ef:cb5b:6de3 with SMTP id
 6a1803df08f44-9081700485fmr15792436d6.29.1785234167075; 
 Tue, 28 Jul 2026 03:22:47 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:46 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:43 +0800
Subject: [PATCH v9 14/14] drm/msm/dp: pass panel to display enable/disable
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-14-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=3579;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=nh2+kNLn2Vl0YimiFzcscodcZxyMDV+yOeRvY1eg5ZY=;
 b=vkly1nbRCoVTFo4zj2O+gkpXzL7xe0O9DRyIM62cqVFCAUX0K1SiGsvBKcmg29YHxr2AWv3zZ
 Wk3RcmvzuKjA8IS3Preg07HA4Hde3X6SQU6E9kupvNTk16K90WVsPM5
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX9S9+FPmfAsI9
 Rds1hSpJ35TRDJzf3znvmKA8wqbnMvy08MH7zbXk/phzUV+tD8fYbSAVmJrbdzKA/84Lt+mXzQh
 rypvGgh9CyaJtgDr2OoLIqvqdMvdFiDFkTcidVRcoH+ZG/vb+UVBXfcS8tuRUruG0SAAGr/1/NZ
 iNdvxlaeQKXiCgWuUr6N+KCpasdHMk6bdvSiuhXocoO24g65Nud3JYmIx0GjhZbW/Pp4nHO2xu4
 clY0zzUE7LoqSDODZgA4J4lArnRt/BGn7MhKy74SmBtzD1H24fboI3v19dho9C6Gwx5CJ6ScEVq
 3BiznoszMO4nluB+SfAKS2WY8wiADyc0c/iXDoXPl9bUx/5ZXMSlZp/o/JhZ/omwtuSuNOuk344
 sdhPpzLNeS3nz+tyXzGKhorhDuZFb531WGltGi4xvf3ui10cBhMV0RqJdy22DlsuBT+sOYnjdro
 CjjH7iODdXyDrgs7b/g==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a6882f8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7Bdkmk_NF71dONvui9QA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: EVtgXz7aNR5M4uQrPXnDnBdrr6GJ8bB_
X-Proofpoint-GUID: EVtgXz7aNR5M4uQrPXnDnBdrr6GJ8bB_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX8horbi1g89vW
 sRhbHEUL+JVts48SzRG4SRTvvW8XOgLKW1lXVgbEgZsfJsjKbbGxAJt1RGjBnkG7+Rtlf0ZoqAy
 3pZNy9AR4O+/jPl5PV6WubPfxQ7K7yk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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

Pass struct msm_dp_panel to the display enable/disable helpers to make
them easier to reuse for MST stream handling.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 88ca263010c6..8a2366e28eec 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -652,7 +652,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -663,7 +664,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -709,22 +710,23 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 	msm_dp_display->audio_enabled = false;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static int msm_dp_display_disable(struct msm_dp_display_private *dp,
+				  struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	if (!msm_dp_display->power_on)
 		return 0;
 
-	msm_dp_panel_disable_vsc_sdp(dp->panel);
+	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
-	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
 
 	if (dp->link->sink_count == 0)
 		/* re-init the PHY so that we can listen to Dongle disconnect */
@@ -739,7 +741,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 }
 
 /**
- * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
+ * msm_dp_display_mode_valid - callback to determine if specified mode is valid
  * @dp: Pointer to dp display structure
  * @info: display info
  * @mode: Pointer to drm mode structure
@@ -1441,14 +1443,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 		return;
 	}
 
-	rc = msm_dp_display_enable(dp);
+	rc = msm_dp_display_enable(dp, dp->panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp);
+		msm_dp_display_disable(dp, dp->panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1483,7 +1485,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.43.0


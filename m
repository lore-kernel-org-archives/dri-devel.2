Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84572CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D795510E366;
	Sun, 24 May 2026 10:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6J9Lfg6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g1cMSnxW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4C110E353
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NNasHf3215919
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VVckI6rGuC7U14wE7wUxK06VoWfdQ0drTPZ1Rf+ykCc=; b=a6J9Lfg6epSPS2YA
 sxt7DnvJz3Xw0+U8r+kexsDc7509fFT4FLdRz1Cvnw/PD5HXTv0WL0G+IfmEkPf5
 jJmwNppFZ2Cn/zyRD69WziEVEWasvE0jIBQFasjuRB5g5xpDUVLtpN0qjPbtMGo3
 weEDFFeAhtNACGEytSIQUI+/FYeoJpsvAKUJQWNHb/c1oM7+FcFLgilFe3FxhZBR
 SGoVlcONPte+TcsfYKE1/KnHAmw1US+Qht4Cu7N+h2uA2PKSKeqXrlGOfMUNnZh6
 DO5HJPWx7O6OJG93MbVbmQ/JyCUFxDdgVSY18oPnKKvet/F/Egi5ZjY3n22NSGlG
 ci6ycA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asty77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:56 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-58700e12faeso3688154e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618836; x=1780223636;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VVckI6rGuC7U14wE7wUxK06VoWfdQ0drTPZ1Rf+ykCc=;
 b=g1cMSnxWrIrORyumGicq3BDMADgvex95kqjZzMsLQW3TSE/5FjGX6axfLyDb1bln2e
 4PkZGEMo7Nhlze+H7nNtcIg+qOTfOhAt8vayxpsM2lqTSdDMRk2VYHhaNMarMXKGlp2w
 33gPs5o4eIXPI21YyG6gS4sJPYtZyYEzS5U0LthUTpFZVCczPUm/ooqX+5ZqFcS4coYj
 J99uf/YSGEswdANenToHesf+PDv62naJvak8zXwcBeKxRT0X1wTSeGm1cTtt8OlS6tJ0
 0qTLkCIExcmty3iE3Bq7jeeUFuy032rI4cJ8K+x9jFxxo6iNA2Z6v+tVF9cxkRJgmG2r
 o/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618836; x=1780223636;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VVckI6rGuC7U14wE7wUxK06VoWfdQ0drTPZ1Rf+ykCc=;
 b=TBMhpjCQ0p4ZOjbh2gPlC4XZbmh2+qdhl/zG3Neq5PsJ+ABWUxGAU19eSZpzHuuPQ+
 cdZkEPpYfB8cPp9SVa8C0ncF42QIWTPg2DlKARMSq8T72Vsk1We1n+Jn+pGOCuoj8fol
 yQMlvwQKcOKeKUOxGbvI7CT57DZ0BAIQbEAxeNuac/YoSDmkwl4VUUKrw3LnYZ5lzL+s
 6rZxT1RGsDYrAQTMYQEZGi1NK9tfjaF5HPi+Sl5cdobKTzZkeNZM1VISixkXfTT6X9G+
 peu3H1lSuk/XRXkWk0xhb8PfhTYSlw99340mhvpItrU9tPxleYlzRlNue15+gPqYxH2F
 wx9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dDvQhBmHUCnFyC3WMqgVv0F3S66aypNdtsYAo4ZxNlwVxuDCVtEfNxxO6UAC0ONz1OUahx5pvthA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFgQEbLmUZxGGLpluK00dhi2IXOzs1CG3CfWtqgtKr7r+M0uZX
 BhcqwFpavZbJXMpAxGdkHBmMsuPUQUindgQZUxJ+mVikgXqYVAIViAmg4lBCR9cWzdnmYxiSr8t
 SWsiTECCzr31tIvagtrhrj6YC+IinbZRsuKDkxIGYhT4BlaMcmQGOjJxlK9eesgbcQShSp78=
X-Gm-Gg: Acq92OFdQ69gQb0UM22FdxlxFfU1HokXmEDP3CNv6qNBLwHcdC4b1/ImxISkGRtfs7m
 rOkNockFWw5vLO0F9oB06DtRiswKAaEwwOUiSoDIiBmc1BxuXYftbaaZTlM2Uz7Q/w/o9z9Rh5r
 T0JJaA8dBLZRe2qfxy+23DjAAXJSQD9Y5aqrPUSZx216lY7ptPwndiWOtImfA4Xz0b5FO58D0p+
 s0YDcFhb4y3yAJX/Q+cSuRNDQVj9rBYLvzzvAkGpRILqJMqgk2vq479kIpx1A1PBgr5fDq7Jpe8
 2PAkQQSg9LIguv6llK9vNtcTH/CY1sae9kB46+TCFtUoc2VvnQ45wULNnVFBn6EovPpdjJ66Ub+
 Y2PDYnAwFNN3ofIN+Bpc17llWba670GFj55r3ECnvwdDndRsH9yCqNQNyo00wtVSyd9pw9vL1Jl
 cbnrcJlkWw0d1IYVQ/LV3FWmG8Smzry+Tgae7GUSjFPtmLRg==
X-Received: by 2002:a05:6122:4896:b0:575:27de:3eab with SMTP id
 71dfb90a1353d-5866347ff44mr6103381e0c.9.1779618835896; 
 Sun, 24 May 2026 03:33:55 -0700 (PDT)
X-Received: by 2002:a05:6122:4896:b0:575:27de:3eab with SMTP id
 71dfb90a1353d-5866347ff44mr6103372e0c.9.1779618835536; 
 Sun, 24 May 2026 03:33:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:38 +0300
Subject: [PATCH v6 10/10] drm/msm/dp: clear EDID on display unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-10-cf3ab488dd7b@oss.qualcomm.com>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mGqmteM+m4hLI5Gvz9eQdzWvrlFnUpxrfaJFRPfDGQg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP9ak9oVvpCmWFPCObKin3NC2NbwoC3Y5mtg
 6N6KGWWN12JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/QAKCRCLPIo+Aiko
 1RM9CACMTtdXkwt6OJzCTlqYe1RL+OTe5uRHjgpBQmycP+rPLqWqYtsTTSK4B8OY77OuubDBgqr
 a0d+IV5yrsalCLmrldKu3wjux/l30cgyRTlsVm6PCOF3jvoLrybo6O9wrqgdOWXTJMG33xswszw
 Eyh7xoBqU+4eE2hpo5Pot7+WsjRS8csEk/peIuXH38g8f74BDEedB9Jua10U7YmB6vx21eAlC+k
 Gw96GUN6sm3wNEJI7gNnPGh7ccSBt/U+PGYaKefw7vDTmIsBaeV8aKFav6fHZ7S5QeuM+5mK70D
 p3cx341tChRRYCRYBGNSdrJiOlQFIet+OKXxjd/7N99LCCJL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX3MYkE1LqKAJ3
 yGsXRFDQoH1pWBbynznxhGFT2DEXPnJ9WGe0TFWom7zp05PXfceKrnnnW3w8cFtLTsZgAhSvOyY
 wQHdJb9e82kaRJZFniJ51mJcqsXV+xhjlPdatR+NS6tc1/okEvjpqf57LKVEjsPlPS8qSGXIkKk
 ovqWtYgV0usCCMu0bUsaxEg879IvoLM7cpZ7y41YfCc3vGzJ+3OvI4ga+49UF8PSwOTvWQzdVTU
 +90EQzwgZPnVB6Sg+s2OiUsexIHpVNNcxtplcbyRYRU1dFxzaS1z2K5bmtsRNykjt2gxjfT7uvx
 RgYnB3CgqY+el6SWTcHBfkb/No92wuVI2IJhF6Ie1RFloQxFuLTG19LDPfRwda2ytZYaYTpRbPc
 TmIo1OXFxRWEhy+z9yQa5exFhGD6g1dlwV+ZBh4W0PFUxhe5QvlGdAvrUbKSFYHhz7e1LeOTaVS
 StK8/ERuS1pPX8kOG5A==
X-Proofpoint-ORIG-GUID: 9JzmqpMftw02lXAyVYRV5FCVHSe3egf6
X-Proofpoint-GUID: 9JzmqpMftw02lXAyVYRV5FCVHSe3egf6
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a12d414 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=NIqqIfc2bYnrFRhDr3kA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107
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

Currently the driver only updates the EDID when it detects a connected
monitor, which results in the connector still listing outdated modes
even after the display is unplugged. Set connector's EDID to NULL on
unplug to clear the list of modes.

Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++++
 drivers/gpu/drm/msm/dp/dp_panel.c   | 8 ++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h   | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5fa745b486f5..6800c628adb4 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -451,6 +451,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 	if (!dp->plugged)
 		return 0;
 
+	/* Don't forget modes for eDP */
+	if (!dp->msm_dp_display.is_edp)
+		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
+
 	/* triggered by irq_hdp with sink_count = 0 */
 	if (dp->link->sink_count == 0)
 		msm_dp_display_host_phy_exit(dp);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 891211b23202..6bb021820d7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -293,6 +293,14 @@ int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 	return rc;
 }
 
+void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
+			    struct drm_connector *connector)
+{
+	drm_edid_connector_update(connector, NULL);
+	drm_edid_free(msm_dp_panel->drm_edid);
+	msm_dp_panel->drm_edid = NULL;
+}
+
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
 		u32 mode_edid_bpp, u32 mode_pclk_khz)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 177c1328fd99..9173e90a5053 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -49,6 +49,8 @@ int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en);
 int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 		struct drm_connector *connector);
+void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
+			    struct drm_connector *connector);
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,
 			u32 mode_pclk_khz);
 int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,

-- 
2.47.3


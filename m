Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DCE9905D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9762D10E91A;
	Fri, 10 Apr 2026 09:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LLwneB/F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btKcC6Dx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE7010E927
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6wvOb1729913
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 suciv5ycZtwqHNXye/yopkUYEmvYPaNYsbC0MiFy4JQ=; b=LLwneB/FbMUtauz7
 lRXdIGUXqW8fjtOIs5JXdIt1j0e4jhc7YELBTfnwdHnfilyeqD3EjFwdDBUW+/HV
 JvsuGZpvgNaymW+C7j4U8Ts13rFniYP1UVXlUJMmVBNHTWQaiAyNrm0HV3zE5+pO
 vKO6b+1olcwJV3Vv2+Nr9ykrRyqopUW/l9sjgewq85CsmqUjPbe4gEbctdyPAVcB
 MmcabUKY/gXIKjkvcAJi/hV5G6xlIxCAm6GOhFPgeqGnFICiiMyOQIiZjsBhziCP
 mzX/skWy6KLCvo6LycsKuQ8ZBfkNQ4OdXUeLTby3hjFsE2Nz+P+4mXB223YPwkKK
 gfW8nQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxknbk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ac7ff4a18aso28423926d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813788; x=1776418588;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=suciv5ycZtwqHNXye/yopkUYEmvYPaNYsbC0MiFy4JQ=;
 b=btKcC6Dx09wbCUqNpGqk3kz3ew4dIklLf3Su+9CSTFGGrhj4o+jNSKKEh2Zi24QQz7
 +fdajQZhaFyqo8HrsythNZ5/2j3tmT7UATWQvU+lx3sF+rjPA4h1CtR50Fs/tojuzOK9
 aiacLFweYoDrXa6pCoOo4UuEK4pYSLeAP8dvnlBWjF+9jzBeXN7gHRtWOw9DyqXu+KLl
 dU/h4eHc9zxnzn3q0KbK+mXRqWBUz6PHxM9opde3C5Al7/sM0kHb+K16HvnKPEyo/4zU
 eA5uelvcZkFKLR86iddyTzj8AJSpVhWfdFZqstIbCGVj8XLi9C9AFy9cAaS0mQ8kj995
 3/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813788; x=1776418588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=suciv5ycZtwqHNXye/yopkUYEmvYPaNYsbC0MiFy4JQ=;
 b=Z/8dIyZJV7ZaBLi2PqJjTl/gaOTsFpL9PPHDtFDAsmc6KmtZ87IHbl6oG84eXNVGoy
 iQyDOE/cMalfWyloJha/7YXrrBc9X1jOKd7YbrXhFN99xDw9jWqAIA63qb1kd65fSL9Z
 +MzqrHcVhM73SQedhwjWid8iYYkiaZ+mastr083pM3+5A3WwBRijNY9fvPCzPXNUZO6V
 PcKibNZZ2G9oPTR99csoLjAGC8Q5U/v3SfMC34H2XptIYFLIfmqqgSYvwNpn3hgutGFj
 Ir/21SODW9ero/pjtSaNg61ucbKqjxMDwI8a6pwmRlJnxB4lapQ7mvT3Mi2yI3SSE1zi
 oltw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaAWxPgadigE8Nyr1P4BpWunwz2yU+W80vN6ACYfhl2Bf3px+qGfZg78UNehg0gI1kCA76CcYS84w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhcQBsLz5Zam6Pq4RlYwuNCHpR7wqrXktkEK5pTDKPUuQqxLs2
 eFq9OCGI2yyyrMydMwQTlWZDqU0RJpZYs8DNFvKuaEG3UYPIcGbht22yQgX4J0bHV54vyslMbmM
 zjf9T+er0Kq2jleL54Bmq1hyZQBdAQ+2r1Ev+QvXDHVV/YbRXpFYBictBGwe1ZeY5iXJFzSw=
X-Gm-Gg: AeBDietZpjUS1c+KRW0pp2MfX0cN6JE6Z93JjKeyo6b3oMzMZaP5xpRx7KxKcmF9Rvm
 gu24/rZbl4hRQ+b1dSFqKNVS8xEtBJ/KQJHKTX7PjFhVJxR3zKd0mSRo7KvbL0SlGCR73LZHEGm
 5Eqao2gOxFbacLlWIOZIPUg7wE7T+Bj51x/iXd89Zx67CgmNaVCcpizU7th2m3RHVJZAxYH0P2/
 opADRG0t0fF5noY521oSRsFLpgNfGF73+3VvH/+aVBF+OoMjM0ZWn9CrebSUHWMMasoy75HoqM+
 TMqFUzkYv0ve513J6NK8ChRpCCjuHML/6WxJvCIROfOkg/9eHSEDYsw/F2hrZLymsbdBatJlgtm
 1Rw+UTo3aCApeB5wqIdu1W4+VGIs4+xQKqNGs8urOyhqH5ck03R5MrNSpyo3gIZeLdhA718YrFL
 F6CDBjPYU=
X-Received: by 2002:a05:6214:c2b:b0:8ac:8337:ca08 with SMTP id
 6a1803df08f44-8ac86245532mr35195636d6.51.1775813788058; 
 Fri, 10 Apr 2026 02:36:28 -0700 (PDT)
X-Received: by 2002:a05:6214:c2b:b0:8ac:8337:ca08 with SMTP id
 6a1803df08f44-8ac86245532mr35195316d6.51.1775813787576; 
 Fri, 10 Apr 2026 02:36:27 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:27 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:06 +0800
Subject: [PATCH v4 31/39] drm/msm/dp: add prepared to manage link-level
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-31-b20518dea8de@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3575;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0SRrv+FxL8qkWFHKN4JQjVFRw38qXcyyamUUeTeLiXQ=;
 b=6d5c41YJLaWP774PXbiRUaSi6hpDLZVBF9fp3dCvVjbBoHJ6jCxZ05GuXV7ZHazoEe4vypBTO
 Z0Xo2DMhypUA+vdt+2phn6uLryBin0XvB5YMh0bhYXzseoaHpiy4STj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: ngVm4UGP4-LB4l7c2t4zRfkY1qsQCAl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX9v7cXqXU63BM
 VWAZ7p8jbmcCHyZc4Wx4JcQ11qvgQ5Tv1YIBiltaYPeW3cmkiDF7G6D17V/o/eNv0q1rAuF0PYr
 cYbLUucYZFyPhgrPgo8FaDQ5hciKuGYu45r551FALV9YWGj9zpTLPjvd3dwxffvjfGtDq/z+Ajw
 c5+XtnkDLcoPPfljY+ldcpRPEd8zRsWPIl8+yUgigPSM9mUhY94Ie6pyBlJXGqbfsNKjTExR7Oe
 hywUDSspvzN+98CZ/h3WxcwgD9FkahItFBSGMQJKVCi/v2l8GEaBgSAxLJ9eCWUFQib7OeseSYS
 v8YVJVb+f50l8RFx0XGBEhXMtmFmpXB4GWEW0rGxni7GZRTYIxyLQ7CvPsEGs+3I4Mv+d+GIUAZ
 eHiVWkGHFvF/75WdUKoYnXcKRf3D6T7+0tjbIrS8YZe5ZVBr3YHYdM3gOtdxP6753fzNzlGpGy0
 Q68fa4hD9D25xyMHaRg==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d8c49c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qXKybx3EirU-fK6T7NYA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ngVm4UGP4-LB4l7c2t4zRfkY1qsQCAl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

In MST mode, multiple streams share the same DP link. Track a prepared
state so msm_dp_display_prepare() runs only once per link and repeated
calls are skipped.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 34 ++++++++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1f26283b2dee..9eaf6994a350 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -715,6 +715,11 @@ int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
 
+	if (msm_dp_display->prepared) {
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+		return 0;
+	}
+
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -734,7 +739,11 @@ int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
 		// TODO: schedule drm_connector_set_link_status_property()
 	}
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
+	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
+	if (!rc)
+		msm_dp_display->prepared = true;
+
+	return rc;
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
@@ -1590,14 +1599,16 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_p
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_enable(dp, msm_dp_panel);
-	if (rc)
-		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (msm_dp_display->prepared) {
+		rc = msm_dp_display_enable(dp, msm_dp_panel);
+		if (rc)
+			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
-	rc = msm_dp_display_post_enable(msm_dp_display);
-	if (rc) {
-		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, msm_dp_panel);
+		rc = msm_dp_display_post_enable(msm_dp_display);
+		if (rc) {
+			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
+			msm_dp_display_disable(dp, msm_dp_panel);
+		}
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1646,6 +1657,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->prepared) {
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+		return;
+	}
+
 	if (msm_dp_display->active_stream_cnt) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
 		return;
@@ -1664,6 +1680,8 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	msm_dp_display->prepared = false;
 }
 
 void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 5f3ef295d710..bda76319c459 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -22,6 +22,7 @@ struct msm_dp {
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;
+	bool prepared;
 
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;

-- 
2.43.0


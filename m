Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0774ECA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630E410E863;
	Thu,  8 Oct 2026 13:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLqEsLlX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OwJGR6a1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1849E10E87D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:15:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK8Uw3099351
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s0CM60eRkOWtuG19BA/pq1pewSHHDCFRHsPAVhWCO6Q=; b=GLqEsLlXLp8HLkTu
 P2tDIeBhuIgzJb6Qi+7tGZbV7ve33nA9JcdrhWCxx89kmGVKwnm61Yzk1WRTB2mI
 FZkw8TsXFzsgyTLQVL8NGJsMgo09lYh26LJIJwpeqqEa8ThT/M/RM2j6UAC1FFHk
 ZweLFIRm3MySStEwMor+zOS0i1a1E7VqUat3MKbVEiCQArSHA6OzQHjwdK88zkBg
 3o25R7/Nc6WO030djGS9b4fzL4rXo7CIoTjDjCcM6J1jsdVm5jnzMo6pbLuldKma
 b7h+usripzx9j+he37VzCqM+8JE2JbYBhn9GjFOd636mDICqxfPqwQsGi3XkAfe8
 QZOljA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe82yay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:15:06 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988c61af159so626026241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465305; x=1792070105;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s0CM60eRkOWtuG19BA/pq1pewSHHDCFRHsPAVhWCO6Q=;
 b=OwJGR6a1z2UF3ymzK7XsCY6XRHAenk5vSs0Fz/NBLl5LiEUL4lilco8bCKLg53SbGT
 rjOuqH6U0riitqKhip7xVqb6NjDcKiFGSYW9XKa5pB3fFds9hBQuzire0qpNSBwmNIVq
 J7SvFFZ2/UqYC5CvYZy5VQCCreZpTxEkEeWlSowSRDygrHijFXMIWDpB01hFvQ14IoDL
 gQlhJI2Qc3KQJh2tAfKS3fMcGoMtpAKHZyy5BKRUp9f8jiAU2+b55FlFACt9bJhrVq5X
 9dmAS3W4PfqEkxUOVcHgO9RSs7Xom9oRQlZBYziWlxZKKK92jHf+qOsDr9AfJbihg+xL
 4DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465305; x=1792070105;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s0CM60eRkOWtuG19BA/pq1pewSHHDCFRHsPAVhWCO6Q=;
 b=cas8870LqUZ7W8xnrirvZpAqegN18tAhOpooySnUtkNIfMOVWLyV2AD5jZMvd2mHX9
 NcMaylBWjV5C3dEiQY36MtTAmfl8k0kXcUmq3lZ1lXc5b79BTg/fO+HD83y2ZMCaSUV0
 v/7DmRNF5IoEZP0l7d/bFpBVX2R/Pu5Gl30yxJsmP1aGszy8zOOUf3ocYLXg3Y5xqFFP
 xqxyHps+f0iq5h53yU42oz1r7RzipkBx/3zOLBHowtOH4s3R3qZdPdgWVeOLzoFnv65A
 BQNmfRsl67cdBtdXPRapyhn3U6he1R4dvTamoHFqzUyRLxdWG+y7w4JDlxYWTjJJ+Q3s
 q+vA==
X-Gm-Message-State: AFq9FYLXU3JIVpYwL5HC68UIHhpWQ5zgGuWgVSUUx4+8BS9PUY6YzCDx
 TQSVsMrxGiS/wEFPE+aqhLTU3wTwoGS8G/1ZA7lfus0COuD8ZZcyp1yDl0nSrFwwHaxuDWy02n0
 Ej8gqZ6N9zp4UnLlt7naYH4e0BUP4dgR1cJqbd5fmvhVmFEIBMZIT2tRsRK1s7wg1OYgb9qQ=
X-Gm-Gg: AYBFou3ZXHM63aSqgO4j/HWV+qtgld66PmlQzCy43HYFsrQrv6V41nkZvxt7QneoLJR
 DFgdIJXJEb+lnxbJz5YS1XGfPV9P7RQxFhqOdpZve6Fx/QWM8mt1VQWGA2tVrEqxwbLVZHF3s6/
 J4ek76C/PAhTI2j+iBIVaa6eeIHOOGAF5o9ySlTCj5jGvdL0am8Ncyzbmx6H44QX5RAaKwEvFLH
 c73aZQ8H960gURcRmUlpeVxkD7/gJ6c5jG1a1kGtqGiDWo3kK0YaZ2ENUrfSMtpGQ2WFfEdm77u
 6TtIMZ8V6XSJCw7aNsY9zTSNJ5oeR6GckCPlq3sXkuV1UXAFS/sXIoNzlQ7+CEviUe6uhwAhSw3
 dieyomFXz7iyAr+gPYcHDK7z2oukhmx3ov05sxx27L1QTMe7S0I8S/ZbNV1bbljDlTKMN5GT/cW
 ctl6SJDxK8jSAv
X-Received: by 2002:a05:6102:2929:b0:7a2:7ccd:280d with SMTP id
 ada2fe7eead31-7ca38913d7amr1243989137.8.1791465305277; 
 Thu, 08 Oct 2026 06:15:05 -0700 (PDT)
X-Received: by 2002:a05:6102:2929:b0:7a2:7ccd:280d with SMTP id
 ada2fe7eead31-7ca38913d7amr1243980137.8.1791465304665; 
 Thu, 08 Oct 2026 06:15:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:15:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:29 +0300
Subject: [PATCH RFC 7/9] drm/panel: add atomic variants of the enable and
 disable callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-7-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8798;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=L5JDbGe2zS2DEbSeC985zbiJ0u3XsyxFbnA7BGKrMNc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dHcaOJzxngINynszu2UMOmvhbuEv++2DWBj
 wMxztTNiM2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRwAKCRCLPIo+Aiko
 1U2LB/9YVTDANuaqn4XC1qtcHTYzuFFzzX12OpQYhYX8LvzRtPHtTkJYc4M1rI1GWTH2tvvkmiY
 u3bNuSaDeWhYT0QEaVJxRhonouNedZ3WOuwPS0qvuZG1n8CA1yddl7jfmedyTxACrugXawKzDJt
 I6t5nEcE7U0FTRl29OeAHGHsegA7vlJ30ExgqVMKgl25xHdcxQhKztDIO/3GgX/0/reLc9xi0Cj
 dsr88xAjR07NnW0faRBhA9GEIXr5SxoIpjXHxjw00C8qU97BCj1uAkDzk/47QsNh5ACUniV7GPg
 Z7fAJjfoXNbO9Wu5F9MQW136Us5UtlhmESyllIaXx52vwtm0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX+l3WxrhjM3pZ
 mFgv/TiIiS1KwFwkeuBfq3RtvOU5/nYndmRfRqptgV3ohihRgqwToQfB/gMOinrpbIGuVmBcvVU
 Owe1f5FLqbIUDdcfJyXPamG+PnfBCid88FqHL2tWz/NaNmmYIbWO79SOK74AE3udMpMraHYj07j
 TDXVeeqCw7bjmtfSlBN7bfaPYbyLjFaZHMMyKlVFU7dln9zzmam0En6QgWI7ZexCnO+BgHIZU/3
 ZpWKitXFhuY4IRLvINi0pLZOQEXNfnxErX3xCCBchk1GeyNAFUJ/JCPI/qQU5JMAwC+hefZgZjZ
 wzQmFF8HmPvZrOdZI1XpdWaKCus8M1rp89fPdZAmjHgddwEw/9pSKAsjocXCjo6g1nde28NyeB2
 i/1C7Cc+oGlZrbHNMxgMoRBwwwRd/hEjmN7c+e1Fd1IIRLYn9w6YzRl8a9FDx1ib92Wb/iXJhuc
 abFWgK1LKPitZhVVbXA==
X-Proofpoint-GUID: -czvslN2lPu-8ZtNKnWXh3VtFtkpROxv
X-Proofpoint-ORIG-GUID: -czvslN2lPu-8ZtNKnWXh3VtFtkpROxv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX1i7rlbB2BeVj
 MpXXNlrYmXYGQsV0eNnUjrTjupvfJjL0TtXTYQ83BNQQ4+A+JUcFQWNFbkh00enHUhBL0GYOEIr
 MKdAHMgEMGDocIIaVKWikz6cR8jX6dY=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac7975a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=HYHJ6GXdE3zNCkCZCCcA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080052
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

The prepare, enable, disable and unprepare callbacks only receive the
panel. A panel driver that tracks its configuration in the atomic state
cannot tell which state is being applied, so it cannot program the
panel accordingly.

Add atomic_prepare, atomic_enable, atomic_disable and atomic_unprepare
callbacks receiving the commit. They are called by a second set of
functions, used by the bridge embedded in the panel, which fall back to
the legacy callbacks for the panels not implementing the atomic ones.

The callbacks are only meant for the panels using atomic state, which
are never driven through drm_panel_prepare() and its counterparts. Warn
about the panels implementing them without the state callbacks.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel.c | 125 +++++++++++++++++++++++++++++++++++++++++---
 include/drm/drm_panel.h     |  54 +++++++++++++++++++
 2 files changed, 173 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index ed0d16e04eae..a2cd043fe146 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -56,7 +56,10 @@ static LIST_HEAD(panel_list);
  * drm_atomic_helper_panel_create_state(),
  * drm_atomic_helper_panel_duplicate_state() and
  * drm_atomic_helper_panel_destroy_state() helpers or with their own functions
- * if they subclass the state.
+ * if they subclass the state. The state is computed and validated
+ * in &drm_panel_funcs.atomic_check and applied in
+ * &drm_panel_funcs.atomic_prepare, &drm_panel_funcs.atomic_enable,
+ * &drm_panel_funcs.atomic_disable and &drm_panel_funcs.atomic_unprepare.
  *
  * The panel state is the state of the &drm_bridge embedded in the panel. It
  * only exists once that bridge has been attached to an encoder, so the panels
@@ -221,6 +224,112 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 		drm_connector_cleanup(connector);
 }
 
+static void drm_panel_atomic_prepare(struct drm_panel *panel,
+				     struct drm_atomic_commit *commit)
+{
+	const struct drm_panel_funcs *funcs = panel->funcs;
+	int ret = 0;
+
+	if (panel->prepared) {
+		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
+		return;
+	}
+
+	guard(mutex)(&panel->follower_lock);
+
+	if (funcs->atomic_prepare)
+		ret = funcs->atomic_prepare(panel, commit);
+	else if (funcs->prepare)
+		ret = funcs->prepare(panel);
+	if (ret < 0)
+		return;
+	panel->prepared = true;
+
+	drm_panel_followers_prepared(panel);
+}
+
+static void drm_panel_atomic_unprepare(struct drm_panel *panel,
+				       struct drm_atomic_commit *commit)
+{
+	const struct drm_panel_funcs *funcs = panel->funcs;
+	int ret = 0;
+
+	if (!panel->prepared) {
+		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
+		return;
+	}
+
+	guard(mutex)(&panel->follower_lock);
+
+	drm_panel_followers_unpreparing(panel);
+
+	if (funcs->atomic_unprepare)
+		ret = funcs->atomic_unprepare(panel, commit);
+	else if (funcs->unprepare)
+		ret = funcs->unprepare(panel);
+	if (ret < 0)
+		return;
+	panel->prepared = false;
+}
+
+static void drm_panel_atomic_enable(struct drm_panel *panel,
+				    struct drm_atomic_commit *commit)
+{
+	const struct drm_panel_funcs *funcs = panel->funcs;
+	int ret = 0;
+
+	if (panel->enabled) {
+		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
+		return;
+	}
+
+	guard(mutex)(&panel->follower_lock);
+
+	if (funcs->atomic_enable)
+		ret = funcs->atomic_enable(panel, commit);
+	else if (funcs->enable)
+		ret = funcs->enable(panel);
+	if (ret < 0)
+		return;
+	panel->enabled = true;
+
+	ret = backlight_enable(panel->backlight);
+	if (ret < 0)
+		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
+			     ret);
+
+	drm_panel_followers_enabled(panel);
+}
+
+static void drm_panel_atomic_disable(struct drm_panel *panel,
+				     struct drm_atomic_commit *commit)
+{
+	const struct drm_panel_funcs *funcs = panel->funcs;
+	int ret = 0;
+
+	if (!panel->enabled) {
+		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
+		return;
+	}
+
+	guard(mutex)(&panel->follower_lock);
+
+	drm_panel_followers_disabling(panel);
+
+	ret = backlight_disable(panel->backlight);
+	if (ret < 0)
+		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
+			     ret);
+
+	if (funcs->atomic_disable)
+		ret = funcs->atomic_disable(panel, commit);
+	else if (funcs->disable)
+		ret = funcs->disable(panel);
+	if (ret < 0)
+		return;
+	panel->enabled = false;
+}
+
 static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					   struct drm_atomic_commit *atomic_state)
 {
@@ -237,7 +346,7 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_prepare(panel);
+	drm_panel_atomic_prepare(panel, atomic_state);
 }
 
 static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -256,7 +365,7 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_enable(panel);
+	drm_panel_atomic_enable(panel, atomic_state);
 }
 
 static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
@@ -275,7 +384,7 @@ static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
 	if (new_crtc_state && new_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_disable(panel);
+	drm_panel_atomic_disable(panel, atomic_state);
 }
 
 static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
@@ -294,7 +403,7 @@ static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	if (new_crtc_state && new_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_unprepare(panel);
+	drm_panel_atomic_unprepare(panel, atomic_state);
 }
 
 static int panel_bridge_get_modes(struct drm_bridge *bridge,
@@ -740,7 +849,11 @@ static void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		      !funcs->atomic_create_state != !funcs->atomic_destroy_state,
 		      "Panel state callbacks have to be implemented together\n");
 
-	dev_WARN_ONCE(dev, !funcs->atomic_create_state && funcs->atomic_check,
+	dev_WARN_ONCE(dev,
+		      !funcs->atomic_create_state &&
+		      (funcs->atomic_check || funcs->atomic_prepare ||
+		       funcs->atomic_enable || funcs->atomic_disable ||
+		       funcs->atomic_unprepare),
 		      "Atomic callbacks require the panel state callbacks\n");
 
 	INIT_LIST_HEAD(&panel->list);
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index a5879b7b986b..dedd792d2c52 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -192,6 +192,60 @@ struct drm_panel_funcs {
 	int (*atomic_check)(struct drm_panel *panel,
 			    struct drm_atomic_commit *commit);
 
+	/**
+	 * @atomic_prepare:
+	 *
+	 * Atomic variant of @prepare, used instead of it if implemented. The
+	 * new panel state can be retrieved from @commit with
+	 * drm_atomic_get_new_panel_state().
+	 *
+	 * Panels using atomic state can only be used through the bridge
+	 * embedded in the panel, drm_panel_prepare() and its counterparts
+	 * will refuse to handle them.
+	 *
+	 * This function is optional. It can only be implemented together with
+	 * @atomic_create_state.
+	 */
+	int (*atomic_prepare)(struct drm_panel *panel,
+			      struct drm_atomic_commit *commit);
+
+	/**
+	 * @atomic_enable:
+	 *
+	 * Atomic variant of @enable, used instead of it if implemented. See
+	 * @atomic_prepare for details.
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_enable)(struct drm_panel *panel,
+			     struct drm_atomic_commit *commit);
+
+	/**
+	 * @atomic_disable:
+	 *
+	 * Atomic variant of @disable, used instead of it if implemented. See
+	 * @atomic_prepare for details.
+	 *
+	 * The panel might not be routed to a connector or driven by a CRTC
+	 * anymore in @commit, the state the panel has been enabled with can
+	 * be retrieved with drm_atomic_get_old_panel_state().
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_disable)(struct drm_panel *panel,
+			      struct drm_atomic_commit *commit);
+
+	/**
+	 * @atomic_unprepare:
+	 *
+	 * Atomic variant of @unprepare, used instead of it if implemented.
+	 * See @atomic_prepare and @atomic_disable for details.
+	 *
+	 * This function is optional.
+	 */
+	int (*atomic_unprepare)(struct drm_panel *panel,
+				struct drm_atomic_commit *commit);
+
 	/**
 	 * @atomic_create_state:
 	 *

-- 
2.47.3


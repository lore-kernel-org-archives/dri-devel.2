Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134ADCD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 10:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B3C10E35B;
	Sun, 24 May 2026 10:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MxGRUePd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ep2339VY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D1010E103
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64OAOt2H3384835
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P5QWn9vGsj8eMKf1y+Px+TGh2HowGm6WIdOaf1OPM5U=; b=MxGRUePdzd0Vj21A
 GojBMkQx1JlmsLcL6k6YSjZgAD6aVLtqA7eKaHqc2hIoU+yNGszDr/e1B+AeFi+F
 u3XKNKQyR5qfJdnvofxiaNlvVAFcten/29uD52ZmsPxEC5nVmDerKe3qEZu5tb3V
 xp53lDixzkRUeMrOUd9TvCw7A9tv+rRLPyJLiXALUnQOOM/3zwR81Eo9VRifRPfn
 tyJnN92tUJu92Uitdc0jIKsB1KdVRhRVaT+nAw6IasqqbLPzOuB7YnOQRwYORZHq
 3U5aVrpjvJIdA0wN6KllLd0pIM02uymPGRQ5XO6JAhmZiJG7R+YxrcnRxP+cu9MK
 GpF7+Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9jt6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:33:50 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6347ed78bfaso11461116137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779618829; x=1780223629;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P5QWn9vGsj8eMKf1y+Px+TGh2HowGm6WIdOaf1OPM5U=;
 b=ep2339VYOLy+SpEtlP2VfvxufX8E5RY7HvaLpcUcN52ZWDO68lspKnuQ7Uz76Ck5iZ
 l/CmxuIFqIyUpb0y7VVJYKU1ALaXux6OYZVm0Q7Q6hmI1mTNYiBt6Sg+ShK1NA8DpHTE
 gqV3A/nr3kac+c/iInbUxCPgZSi4rJ6wvEqX/Ujnb8z3IKAoD97pSZVTacAMfOSLOF5V
 8xlAk4/g7z9j5i9rU28OTnMJ9b7B6eYGQ4FNM1WAi6LehkaxxxDeCv2CAdQfYJmJ68ox
 r1zezx3VFrMEkNsLCFJrq+tZK2gultRw6LQorivbmtlQFx0FjaRN90w4OP8aeB+/gvPa
 If/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779618829; x=1780223629;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P5QWn9vGsj8eMKf1y+Px+TGh2HowGm6WIdOaf1OPM5U=;
 b=mn7kyRi+ZVjINW1glZ7pBeeP7UBlVzhjk1F3wFCbCtDEAEgriGlTkz9OcAdYrlh31K
 c42NmxHOr93WWUKa9JwFDkY1KZj/fEZIhfvWjVzdHhfdaLUujo0+JCxnf29rDZFiCGry
 bjpb8cLH0NJuip0QvUTZ9SMBO/ZSN71AHElh/tp/xAi4AkeAnvy0gwK72LiW75Cq8xnB
 vfgd4KYKUwdhTEwBIoRLczX6SKwzAHtamI8fSRXcHOGh8qJAJZ5x9sYKMxEIB/n8eBht
 pnq/BJtft/T/pjtFFIEdEw8Kum1cvgV5jU5weIjZnIqTI+qSG9NW3tGzMCgrkgBQQfTf
 dJmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fKbF5F+lL4DqeIPChLuxkvk5yjk8okKY6prO7wsRG58T/1eRiw0x5N0l0fIUUYYjpoRaWVawcxNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynXlFCz/F11Qj8+Q4FHWqQJjtkbIiN49KXV5wY3gr1sAY203EC
 iyhFhL0LRIavf1mJL32Xf8K+7j21Gs+PD2qgwKU+n2TdqPCVoitsyR8+66iUuLMhkVuNkdw0WAM
 TmbDyzQGxVWZoNJ9gTd+9Dg+RJ01fQETewtxW9mN0BFbkHqv+2TroD5/WLx7HRL1po/gRSQ8=
X-Gm-Gg: Acq92OGB4FJRWJgChYULURKvqKmKj8u0tNe6/pHXN8aC898MInwxLJhpsKF6f45JMae
 tIzfAcYzLUQ10dbqHnb6xQwhTnl+Xnxku4eE7PP2WgqVT2APw3RS5a8uweuy3fmJIR+8z9KX9ii
 +nIJ6LEibn8IaAu9OUwnOphr/MrnWhXqBW1n8nczL0DAImjodqfPx8bUK27gfbtsBRtfU1a2tZj
 VfootmP8OR3lORVXCktWzqZHr0kbaEfYz63JMfRBABuG+nOEIOzfJe6RrXNOgJz5vkTtf+GPn7q
 Grt+eCrnf9PiQ9/HYzFZbw2OzMdLGYUkoaFyX01rdMSF81uxsiXFl2NQCmBanLuYTZ4c7vunJLP
 zFHNjm0HGFA0+m7FmyR+aYshbCZmAx7JWXz5AuWFE96D2fDrpmy16KhqoQUpwTnsnBkJCNAcaZX
 bAjOXBxbwu7UTvppIWi/LT+ACsb5kEWyMfHzQ=
X-Received: by 2002:a05:6102:f93:b0:638:944a:49a3 with SMTP id
 ada2fe7eead31-67c7cee347amr5566652137.11.1779618829398; 
 Sun, 24 May 2026 03:33:49 -0700 (PDT)
X-Received: by 2002:a05:6102:f93:b0:638:944a:49a3 with SMTP id
 ada2fe7eead31-67c7cee347amr5566644137.11.1779618828973; 
 Sun, 24 May 2026 03:33:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cba880sm1816148e87.32.2026.05.24.03.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:33:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 24 May 2026 13:33:34 +0300
Subject: [PATCH v6 06/10] drm/msm/dp: drop event data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-hpd-refactor-v6-6-cf3ab488dd7b@oss.qualcomm.com>
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
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6182;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UWF62YF1njzFgAwLsWekOdUgSvI5h2lxGM5sba8sWQ0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqEtP92iDfdpDrcDYF4JAsZbS+8VsS8TZ5XUdyp
 1eo8+oTo6WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahLT/QAKCRCLPIo+Aiko
 1SyxCACu7tMV+veq6oNBmCEE7nWglKG+gLAjLevEMXxN1MdKV5Z424wgHVirQBLcDa9uwDcJWPa
 uc5CZfB7OJnFTN9tp6COJHi7p45JHc85UPB9HyEV+fUckl/c6YKlBVeBqg8YZyZhH6RCdpQZqoP
 Kg//v/s5kikFOe+xU6Pm8ISWlHAVxKMWsGEyKrOx2pYp907V6eMzRWfsSAHMjjQaS1XO9fgSs5x
 1Kt20SxRvl8zifuGqQNn3gJQuMjmdDFZhMWulpNRUgbj6Nuk0Ts7B2+8j9ZJHNWQNsphTCTydf8
 1IXWXuajlSDFtc/5gCvNZPudtCP49qF4aLPqSACP39cDoP81
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: FDffrBLoCv7Ar9MMYQozGBmsAOBK0Nuz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX75Dc4Bgpe6wQ
 /9KoeBirtgViKZHNQceewgJkCwg8W1YmtQrXp+wBcWBVTRTnjCyoSx43Nv7MyuplwERcN05lVjv
 p0sdRnl1900rWtL2yqJ79Jv5DUl/XcgCZI+Nr4ZYoVtloZu/QKvT5XIMuwTiaxygMMIoXNT6rM5
 QPzjRwVUCgBmj6PaB/GwvH2DHyzLotKm+H4F/lzzlbyV3QuTbK8SHROAXJvvoxUrJcoQ0YqfkTY
 DVU4tMLURlxz6RCj+9lH73N7W4AjMyJcT7RiHaQbnQAsAecfVomUx//wnXWdig/CnD07SG2bpEi
 agye4kjZUv1bXqWpPx7QOBQTTgfNuCUfPRbaCWgVPH35HQJeWUacRQ4DKHuLZTPDsMD1s8C01JY
 O3bPg/xT9/XMzhSZCfTu+BbcnIRAjWFXoVdeW+aE3BtBeCmUlsUY5aIbMBW4/2lTP8N71n7TYKt
 YC5EsTL+dE1oqcntuFA==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a12d40e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=eCmuknkWlvIkWwm66DUA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: FDffrBLoCv7Ar9MMYQozGBmsAOBK0Nuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240107
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

With EV_USER_NOTIFICATION gone event's data is no longer useful. Drop
it, removing also the argument from event handlers.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 39 +++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6b76bff7c8d0..df79a6e84415 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -69,7 +69,6 @@ enum {
 
 struct msm_dp_event {
 	u32 event_id;
-	u32 data;
 	u32 delay;
 };
 
@@ -219,7 +218,7 @@ static struct msm_dp_display_private *dev_get_dp_display_private(struct device *
 }
 
 static int msm_dp_add_event(struct msm_dp_display_private *msm_dp_priv, u32 event,
-						u32 data, u32 delay)
+			    u32 delay)
 {
 	unsigned long flag;
 	struct msm_dp_event *todo;
@@ -237,7 +236,6 @@ static int msm_dp_add_event(struct msm_dp_display_private *msm_dp_priv, u32 even
 	todo = &msm_dp_priv->event_list[msm_dp_priv->event_pndx++];
 	msm_dp_priv->event_pndx %= DP_EVENT_Q_MAX;
 	todo->event_id = event;
-	todo->data = data;
 	todo->delay = delay;
 	wake_up(&msm_dp_priv->event_q);
 	spin_unlock_irqrestore(&msm_dp_priv->event_lock, flag);
@@ -577,7 +575,7 @@ static int msm_dp_display_usbpd_attention_cb(struct device *dev)
 	return rc;
 }
 
-static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
+static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 {
 	u32 state;
 	int ret;
@@ -603,7 +601,7 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 
 	if (state == ST_DISCONNECT_PENDING) {
 		/* wait until ST_DISCONNECTED */
-		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
+		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 1);
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	}
@@ -645,7 +643,7 @@ static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
 							plugged);
 }
 
-static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
+static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 {
 	u32 state;
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
@@ -707,7 +705,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	return 0;
 }
 
-static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
+static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 {
 	u32 state;
 
@@ -725,7 +723,7 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
 
 	if (state == ST_MAINLINK_READY || state == ST_DISCONNECT_PENDING) {
 		/* wait until ST_CONNECTED */
-		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 1); /* delay = 1 */
+		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 1);
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	}
@@ -1080,7 +1078,6 @@ static int hpd_event_thread(void *data)
 			todo_next = &msm_dp_priv->event_list[msm_dp_priv->event_pndx++];
 			msm_dp_priv->event_pndx %= DP_EVENT_Q_MAX;
 			todo_next->event_id = todo->event_id;
-			todo_next->data = todo->data;
 			todo_next->delay = todo->delay - 1;
 
 			/* clean up older event */
@@ -1106,13 +1103,13 @@ static int hpd_event_thread(void *data)
 
 		switch (todo->event_id) {
 		case EV_HPD_PLUG_INT:
-			msm_dp_hpd_plug_handle(msm_dp_priv, todo->data);
+			msm_dp_hpd_plug_handle(msm_dp_priv);
 			break;
 		case EV_HPD_UNPLUG_INT:
-			msm_dp_hpd_unplug_handle(msm_dp_priv, todo->data);
+			msm_dp_hpd_unplug_handle(msm_dp_priv);
 			break;
 		case EV_IRQ_HPD_INT:
-			msm_dp_irq_hpd_handle(msm_dp_priv, todo->data);
+			msm_dp_irq_hpd_handle(msm_dp_priv);
 			break;
 		default:
 			break;
@@ -1216,19 +1213,19 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 			dp->msm_dp_display.connector_type, hpd_isr_status);
 		/* hpd related interrupts */
 		if (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)
-			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
+			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0);
 
 		if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
-			msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 0);
+			msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0);
 		}
 
 		if (hpd_isr_status & DP_DP_HPD_REPLUG_INT_MASK) {
-			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
-			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 3);
+			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0);
+			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 3);
 		}
 
 		if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
-			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0);
 
 		ret = IRQ_HANDLED;
 	}
@@ -1653,7 +1650,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	}
 
 	if (dp->is_edp)
-		msm_dp_hpd_plug_handle(msm_dp_display, 0);
+		msm_dp_hpd_plug_handle(msm_dp_display);
 
 	mutex_lock(&msm_dp_display->event_mutex);
 	if (pm_runtime_resume_and_get(&dp->pdev->dev)) {
@@ -1727,7 +1724,7 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	if (dp->is_edp)
-		msm_dp_hpd_unplug_handle(msm_dp_display, 0);
+		msm_dp_hpd_unplug_handle(msm_dp_display);
 
 	mutex_lock(&msm_dp_display->event_mutex);
 
@@ -1849,7 +1846,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		return;
 
 	if (!msm_dp_display->link_ready && status == connector_status_connected)
-		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
+		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0);
 	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
-		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0);
 }

-- 
2.47.3


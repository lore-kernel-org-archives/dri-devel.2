Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED45C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C18710E926;
	Mon, 29 Jun 2026 14:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dKq2y0fM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZIdedJHN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4140410E92B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:24 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATDQH2647785
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wMuCUkGM/5ZuNYaTfCD+8LGq0IU6gFC3uoV0LKcWT8I=; b=dKq2y0fM49KcNTPG
 5Nz8JVF47d8ZirjOK7uaXIPcR5rnRX7zYn0s5+3Bjtesevx0GwQzFoDl+IgH6chp
 IQewS9XnacN9AJ2ATDBpnKojmLdyuXNcum2aiPRq7QuzvCYtjfV5mKTGX8lJd/QE
 r6Uhi66BoCUU9uAR1A46RvXKNYWRSTLAidhL/ftzni8qD4JjfkGhUJDT1aXFQ5aJ
 q8iyxMMsOC2bSxL+uEktOL05fuHphuqxXh5sBG6PscXPcHaOqMljfr5JNpASPJsZ
 lVLanWTL2ui5rMICWNMAhKwvtRkBZmg9qZ/zMtbZIKRvZPto5NJHNdytCYQX6gYc
 zFC8FA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhp1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5766dcb9so120018885a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742582; x=1783347382;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMuCUkGM/5ZuNYaTfCD+8LGq0IU6gFC3uoV0LKcWT8I=;
 b=ZIdedJHN3//zlhM+xUxLhzvvq1TNfUQkSIhPsC8LDziGdkGU0bHTDYlNClOv94rzc4
 pL1BhagfXlRN9GDO1zA9QVFSpibBi6Wy/3Lv5gvYVldACQRZA2FwjBmsxcqwpU4TOTbv
 nGtBCNocbiHnWiOExMf0qTVwI9YuDU9zudQ+hU8Fi6gADsY4CDWkfwFHVlK2kN0AALFV
 IAkkisVRB3uSYxZPOcwY239svkdsxAgzoDPdPSQOi7wyIP2Mvc5WRQ21Xr7cVIYgZsWq
 qpbK4gFaHtoCGkMkTxCPPSCl5Q/113PMKx9GL9lDjZ6KqfeN1yfXcNmknB2KGc5eEUvs
 pp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742582; x=1783347382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wMuCUkGM/5ZuNYaTfCD+8LGq0IU6gFC3uoV0LKcWT8I=;
 b=iQ5CmpCaSQ99VBUSXPhHSmr/IG7Ic8YSq3EAkd5DEYcs2cBTTDZNN0MOx7bAcy+kN+
 hXUttxh0oEibrCYPpc+VybxlcfwxWX0VaAvjU+It11nk14fQ8SKfQfzN++pATGSgKEf3
 SuKvcs32Th4MW2/kqVxOb0bTc0vKJTX4rImTb1ABJhI48f6dtb2We2+4tKq05EQZ3Nno
 VKX2haYKJjPLFBKon3rExFqJ8azm1O+m0cwnDJBDgEvMF5fkVwGWBYBuQXPOjPApJcHP
 L+Wk0QHlsTFY1eMM1cGcNzQEhJqLYCcqIU4pJk8jHT0/VEztmxKwRH90FPubKuT2xEFe
 akuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dUhqxqOiXy25t08oVzuW/hln9C3VUfk7qcp/T/qs2OLA56enBZzEzhE03r4HfKSQ2WHSaUmD2Aos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT9sOZHzQ0QfvCL5HWVnWWhvCdU8bEM2p7dq2CdpkrCdksxTSu
 AVXZEWPtp3FZH/+81PW3IDgq7+510UwZ1k5ZycdX1ulSvpwzehEjSO431SK5bF3d3HiRhZ0DYyB
 yLgG+O4aQQN5wsZtBwEq0EYwJcxNcn17atZQjE3zpRfyDmNhtTg99RgycC3vZKww4MgQ010w=
X-Gm-Gg: AfdE7cn7Im3zgu1u2mUJZ1WUgn4BEsJ3Bd7eNQf/99uhqd3bUmi9+PPk4wY68zPy0jx
 dKfAoOrazuQaXWjdgB2dddP08H3QgT1/8KbY3dtd+1DLr8HSV64yU8UYZAdTplo6PNy70jIG0qG
 7/GD54aGNWZWpdiHHPIVVNErgZWsX/NAO2/RqOOauN4Zr8WEel54ZLV9kIYtOkKU+ClTzRS5Fjy
 kRy8w/1sF4Hzgrn7DRfujo5Ap5J89F5vkfNaPdDXjcSxXK2p7V2rb9fFYOfRibwuPSS+PK/RTGD
 sBKZfkXoe5LFKxIZzd7jGdHWkpke9jYVK6QYzdvptSEP9Wl5OgKubNeVV5lJ7j8O2EmvBPTvz16
 msry9hC7v58XUjMPRN05toRkMZRr5Qrf5pzXpb4oaIaMR7DmqfYEHrO1vl8pozyp3EPfrGg==
X-Received: by 2002:a05:620a:8719:20b0:92e:44be:bbd2 with SMTP id
 af79cd13be357-92e44bec6a7mr688010085a.9.1782742582316; 
 Mon, 29 Jun 2026 07:16:22 -0700 (PDT)
X-Received: by 2002:a05:620a:8719:20b0:92e:44be:bbd2 with SMTP id
 af79cd13be357-92e44bec6a7mr688005585a.9.1782742581721; 
 Mon, 29 Jun 2026 07:16:21 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:21 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 15/25] drm/msm/dp: add an API to initialize MST on
 sink side
Date: Mon, 29 Jun 2026 22:14:36 +0800
Message-ID: <20260629-msm-dp-mst-v5-15-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=3085;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=rWGVRQL4yrr/+OcPJZsE2NbhmKlJWDJ86JwhFSr0tHA=;
 b=zp/0usdQR549mw+/NeCy7PT7dzFTuN9P/wjXLseMDCh/AeFJowZcElLpVJbjhgNu3r6hZsQRG
 HKc7XxlHUmqDGXWEc7sKzW7mjBNDpmrUJJL+n/QirG0QUBuWI1toBbn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SH8SbK5Ke8jl1hERT9xOkB2ATadXgpgz
X-Proofpoint-ORIG-GUID: SH8SbK5Ke8jl1hERT9xOkB2ATadXgpgz
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a427e37 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vCCEq3Mv4WXTdc8uXsoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXxZb1fs5m4CiR
 K4SG3c+IDV/W9D+6Gptm9PNugwE0Kp+37jyOt1UxOQiD8vfZB+ylp6UqNKOdfloIk/StLQlwvUo
 hbiNDAgZSwSjNkDq3NQy8wSV7odAjdg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX6Ob1jI1PN72o
 PFqbTRcCL8aE8sPqW1NORcL77TcLSoEUlPLsxDNqKcuq/U9j7RSp0vknSTTGp74iTFYufJA7UFw
 Wl+ncIXWjcB85N32YWErpzo9zihmrdzwPqQrT2l7wM/o09+FptcUSjC6l5fckAFKE1TFxAkSMs6
 aLciadctSfEV2x5LHfPt8U6JSViK8hxv9wc5FY6OlJAfhcXkBNYJ0v5JGA7biRWm7eYjd/qmq41
 faM68cMLdUem8+e9/qQug3hE3jEwlEof02knEpVbKGmc1kIiV6GwAdoNoTE3e5KtpD0skk9OXFG
 ugVCQ8D2m2gX5rta5pklaiEUS8xdLtL1t7o+wQTm/ZIiyJBOBt7+lecbJx7dF7DmkUcDoTi1Nal
 FzthwMNaywiZG010CV7NDunbonP2RPk4ccCRIxjhmk3zQ9VSoGkMINPfassUuWq1f1Igk0YSByX
 YVHMW2wVJYBvztvbEEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

If the DP controller is capable of supporting multiple streams
then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
DPCD register to enable MST mode.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5786e598a406..c3be656f10ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
 
 #include "msm_drv.h"
@@ -270,6 +271,31 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
 	return lttpr_count;
 }
 
+static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
+{
+	u8 old_mstm_ctrl;
+	struct msm_dp *msm_dp = &dp->msm_dp_display;
+	int ret;
+
+	/* clear sink MST state */
+	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
+
+	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
+	if (ret < 0) {
+		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
+		return;
+	}
+
+	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
+				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
+	if (ret < 0) {
+		DRM_ERROR("sink MST enablement failed\n");
+		return;
+	}
+
+	msm_dp->mst_active = true;
+}
+
 static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 {
 	struct drm_connector *connector = dp->msm_dp_display.connector;
@@ -288,14 +314,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (rc)
 		goto end;
 
-	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
-	drm_edid_connector_update(connector, drm_edid);
+	if (!(dp->max_stream > 1) || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
+		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
+		drm_edid_connector_update(connector, drm_edid);
 
-	if (!drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
-		/* check edid read fail is due to unplug */
-		if (!msm_dp_aux_is_link_connected(dp->aux))
-			return -ETIMEDOUT;
+		if (!drm_edid) {
+			DRM_ERROR("panel edid read failed\n");
+			/* check edid read fail is due to unplug */
+			if (!msm_dp_aux_is_link_connected(dp->aux))
+				return -ETIMEDOUT;
+		}
+
+		if (rc)
+			goto end;
 	}
 
 	msm_dp_link_process_request(dp->link);
@@ -317,6 +348,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	 */
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
+	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
+		msm_dp_display_mst_init(dp);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:

-- 
2.43.0


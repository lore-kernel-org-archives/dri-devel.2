Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BECC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593EA10E705;
	Mon, 31 Aug 2026 08:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJsDgQst";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZeLAJvT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5123410E6FB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xNUH3018234
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7QYANziB3W7iS2vd0t3/lz0aNl4eNqxjJE2aCx4lKWM=; b=GJsDgQstBx9XcDaA
 NS+sq+9YihX+WT9MLK5977kiJneMpDGyGRWKnRyx4bu0ZEJ86MCpCprGTFAcPs37
 eZ58iVY5kgDVhJIzIDcfRZMkOav8WZ9ZUqiGVCs8Rd/InEYQ2ZQVxSLwXh9zopZR
 VHiIOjTQ1/PIl490AYcaZcDbWlKiffP5Nb7qp6bTPv8J0+l41D4Iyx4LveLv/qWp
 hRvm3Jx/KWSkIHeqZJX7cJMBbSigzO6nIcsy8MCkqoYzdLmQahYtWtnMRvnZeB1j
 qp4LL1veN26K9LshOVCSRpe2KmttXacb0thqvHWCIPGWaGc8b/OouP0dSKzOQ28n
 98ldkA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqn2nck4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-938153538caso574991885a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164259; x=1788769059;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QYANziB3W7iS2vd0t3/lz0aNl4eNqxjJE2aCx4lKWM=;
 b=QZeLAJvTSkPxdMM1GzzpW0XIUKvVHOzydS5DtB77FpVTy8t2ALM9AU5HS8d22d6HuV
 +Qm+b47VmHAo/I3IFcxBe0RtNDxAoGgz93Y0IXvXndBDZVZZqyA+/F4JAtriAtUCvLpS
 TIDEsFCNU9rg8GKA3mzmwD8u0GqqHXvsFxleolBHZKKH81Nmd+lSiGTIxgcmW/0+cdXG
 GMyloUV4jARu0MWb/5FGTUOBNylqVrZLCVl+zMflUbm4kpnhSvviHNp+0Peqk6d3VXYi
 q+OrD3En8LWMLs6oqZeyi8uVKhCccebtUSQww4BWKmioLO17Ic01Y/AB6WpbD1ocLYxJ
 k8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164259; x=1788769059;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7QYANziB3W7iS2vd0t3/lz0aNl4eNqxjJE2aCx4lKWM=;
 b=EakdrZarcbbDRMIjtAGUpyGMHktxEnMpAueDAHc2dHdy+uMWjqSj62gU88k6cs+pT2
 48wpur7x1gLdFdb8vgGXd3M7TdO+drX+i6ucBN2pDoH44JeIRuv5ZoLWufBwfMV9nB3y
 ku3NYjgN+9RlURoo+CQR8l8xtNDa+aMJyHSVJs+TfYTxbySoSW8rIciZCpouM6qNo5Xo
 qVKx//tC8svCLqeHP5QeMX110Pd48BjwY+MBKzxfwMW6aGEbLzexNsCf4jKortpUNW45
 kmF20k4ALVHVNeqZmcGbtXjd0q63CC6Gx4eOy71oYm05aOYWRRi4yd8p/kqs1MRz5An5
 Q8Og==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8bp6RYXNtyMIdEpvuGw0gbxNitG7nA0qDZ0lCnuYFTd8BnvdiW6TKGYK9AdY+yHHcbuwHK4gHlFI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRrUu1WraWNI4WDiWfdorXhKRfxnpCOx6GrSa3s4q36sAcC3A3
 ytngb6Dz7IZzvhW9mGjA51mI+sj2NTbQP9bOxOCm3OxP+ZnfvTdHoHYWYsft95NfqT18gzQtu2c
 d9+2qPLX9lvCZW7U63RUeIjUFw0844LuOA77UXQv0IjZvXO1diIw3+EVW3nASfwM3OKxKljU=
X-Gm-Gg: AR+sD10a3pbZ1fIB9ZacrE+E9bCIJsMWtGYaA6Y2yU0Ahi0l6GPMTLhyJznoBDyJeOj
 Nl6bxZEppB3rtP+D3+Yh/dUwVeOC3dyFbIqDy5/PslF+tFAEb0iV2hHKfs5AaRkjY9DzBjt+v4H
 26Ou/DCideoAJyQgIu8slS5DJTtp16UE2Nthbdfx64K1lu1jlxB7At5aD7dibquPpQMf76dWpBE
 a33fEaS+B6iwh8trOvYUXH6iyUVT3f04tgNDHZXEsoSIK4rtc9Z5oJXg2MtTDakhdoVLumLfm/9
 IeSFEB7+8F0tX22ttPePS8UHOU/yx1tZgNIJLOa+iSaXGB7y9+4tsAlGKZcutDyRLihSEGbzbR+
 ZPVc83gS6eXhouiCqiB6rvbu0zzdFbypyFAv8s7FW4kwNPKGzzTwBT5n0kCtCk+8=
X-Received: by 2002:a05:620a:9362:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-939137b138emr2192439885a.1.1788164258823; 
 Mon, 31 Aug 2026 01:17:38 -0700 (PDT)
X-Received: by 2002:a05:620a:9362:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-939137b138emr2192437785a.1.1788164258418; 
 Mon, 31 Aug 2026 01:17:38 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:17:38 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:18 +0800
Subject: [PATCH v6 01/29] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-1-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=2701;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=qcRrf3REEES67vfWVVl9C/KGWotx0DutXL36uVlj3Wg=;
 b=wzu/q03Cgn+niwJ4swCE42LwrJHPsyifdwT7QnCxcc/uaRyQ8KOcoYRcyXpyzYw5m8bOLiC8s
 OKTp2I503j/BwmbbLj7MTIJUwjF3Q1gAkgr8xc2K4SjpGoD5FMyajce
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: G2ZKnzkiXaWqj7BHlJZez3eUP74o1g3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXwoR9/s0EVEP2
 NX/cgVyPmzSohMYZ0fLOG7ibgA0mFL2x8kZcPepTifRxBT0OkBlGZKy1Wdn0+cmC4cAfnhndDEM
 GICIlEIlI9zEjMA2uQz4dU2fzqx3/Y6vjVvUD94ZtQ6qKCifx3CGKPzM2cc7D/guscRgKEOKWUY
 LX/NxsPjL3hBY0n7MiinVjmJLRBF6RQz9P0vgtwFXDJirIV16uNkq8Y8862zoK5f5xPepY5Ad/j
 LMbaqgKZXG1/tjc664PD+EZKRprWRzsaCsbF6W9FCUWtUjvEXuxVR/ARIV56XNo+dFCNrp7dIDh
 Fq2bL4LMKWPqTKk4RCCaNeRR0ClsAjaC8026mRTxZdX7JX1Xpuzt4/7JElyVuINvI5W5YeiP5CP
 0mcksA1RO2QEslqphaZy6W3qxA1X+lJuhJPyAkN7F5tYjD15o0f6v1X9MqbaKjkMQQUK+SSwZHx
 wskmgvt63ILhnrXFhfQ==
X-Proofpoint-GUID: G2ZKnzkiXaWqj7BHlJZez3eUP74o1g3d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX90vNAsdZj1K5
 zURfo0IEFkExbposso/ydbTJ8p0PzsWfldNuUX3YnVjfgZg+LzTiq8F6O56h0kqcZwA3PpiGm/y
 6ObJJpPAJ+hS0ao1LT1qGo4Znh/AcEI=
X-Authority-Analysis: v=2.4 cv=a5kAM0SF c=1 sm=1 tr=0 ts=6a9538a3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a95-bzEMD9sxZBs1_CcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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

msm_dp_display_disable() currently mixes stream-level shutdown
(disable VSC SDP, off pixel clk, clear power_on) with link-level
teardown (PSM config when sink_count==0, off_link, PHY re-init or
host PHY exit).

For DP MST the same link is shared across multiple streams, so
disabling one stream must not tear down the link. Move the
link-level steps into msm_dp_display_unprepare() so that
display_disable() handles only the per-stream sequence, mirroring
the split already present on the prepare path
(display_prepare_link vs display_set_mode / display_enable).

SST behaviour is unchanged: atomic_post_disable() still calls
display_disable() followed by display_unprepare() in the same
order, and the cached dp->panel used inside unprepare is the same
panel that was previously passed in.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..a7b0196bb1c7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -722,20 +722,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
-
-	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
-
-	if (dp->link->sink_count == 0)
-		/* re-init the PHY so that we can listen to Dongle disconnect */
-		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	else
-		msm_dp_display_host_phy_exit(dp);
-
-	msm_dp_display->power_on = false;
-
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
 }
@@ -1465,6 +1451,20 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+
+	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	if (dp->link->sink_count == 0)
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
+	else
+		msm_dp_display_host_phy_exit(dp);
+
+	msm_dp_display->power_on = false;
+
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);

-- 
2.43.0


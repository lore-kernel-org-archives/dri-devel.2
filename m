Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47794C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D86F10E868;
	Tue, 28 Jul 2026 10:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YL4rRL56";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gpRJSx/g";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8959510E877
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S829CD3295005
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1K5NJ0UDJpMZcPK82qcAqYj66j6ZAI3MdGiW6v3Syac=; b=YL4rRL56JFJp0LnZ
 i+PftxX/FH7TxWvbC2uo6VXm5barGQXL9deN2M9em7CQqhTbuiOSmdDxrUUU5w9+
 3mEczzwtgbdYi/8uYg364Ndwpw/41E6uY/ljYKCOnO7HiMUAmCaaDnjvlmS1C0gF
 1MB/c7fIX89ulwYqn2ICmT2fbDQv7v4ZJrTXFUlGw2XT1CIYeaoX3t7ZJq37nM4v
 ZE50qd8eTVBulsoLpZhxQg95AGj5BsxgkFdFDdsy1sMo1sJVefqb5qNrMx0o6HMn
 eBxx2B/mF6gdSlBDBNfhxB4AXdvBp4lO5JcPPnCVwWxpN2cZzwf5KE32Gi3FMmOJ
 lk2lrg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5ks2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so53819061cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234158; x=1785838958;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1K5NJ0UDJpMZcPK82qcAqYj66j6ZAI3MdGiW6v3Syac=;
 b=gpRJSx/gsVJcTrh7Moq/F7vQWp77p/Z9zgv+NhDBrG5EEU3rIvNpqXl/lisqs1bQ1A
 4TYHen2ZcaGCfAP/aCXkiFOV1VOaYO/gLRkBHjKSq5PB6dJNUwEPV+afCzdzlKI1Jas+
 lDqyNQFG+rrnoSDz6pPyvfH3XMI0mgC+aTzqzcgzv7+kIM0cT0QBMfvHiz7R2Ql0pb0V
 xWx9vTbohQLb65+reAVEeRz01ZALu93jdzn65dChTn7NwlGlZDZjHc1XbRYGTvFmLFI8
 EqkKol6nE4O/LplnBLRYCAhf6BLuX3C4ZovkSdqTd9oq/qnjctU+VhqaJCInkW7ifV5U
 tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234158; x=1785838958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1K5NJ0UDJpMZcPK82qcAqYj66j6ZAI3MdGiW6v3Syac=;
 b=rKbGYvM/zbIc+kRZw4FsLaArI+lzNkHqySB73C/RVRXttwcz9pAJLYKSSYR/J/vMd7
 OjmgcZy5g7F2wUe+xT6mDL1e55CUJ6TQOrD6Jgp/EqDMBPsSNsLUWjlyuYhk1omfn+e5
 /ahN0OZnZr/W4v/2nqG/AWtXl/mTRUdaFKMWJEOre0cI4I7/WhYcVepF6YRDGzOyBTor
 gIDpzCgsb5WnqC5cDmISoyI2FlhA433FbQVzHN0AejUFCtwHsBb7v5VlXbymiLnTW9f7
 crdYiT7YUHkWk5ckwzYXBT4Af23GbxlNUUWssi1IPzJJ197IdvBk7DdFgq/TPr/1IWLF
 yJYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7vAvn6DGUmtPhPmWpTLbCTZOOjkhbrwHmkRKbTn46ADcSKgX//ZRTL6Ke1VWQngcGW8an9dJRL2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHps3WoPs+sLMVR1TaMTUvkxhBU5K2r7+bzgz+iuVnUP6v5Yyj
 Ox/Y9Z2s3VbMBOkfeFOsB9K4YxSZbCwdLiyPrLCVQ+RKbR4D70bENWhr1mILp2+MWOFH/U8bOVk
 EtpdLNDr0KMPIAz1JdguBnrPN/dSZ18U8JQzjUK21Xcgk7ovqSF4AHyaXJ0e20ORYFBFkqzw=
X-Gm-Gg: AR+sD10IhsP7HwmpC5yy9viG9kUXsqsAIXIitHzUVi+8mdG/vcU53Hl2Y19wB689Ce/
 nPMXMlvCHbuEJRvaBdxeVlCpgGdAwIHpfufvHSwTIvVeIcL9EwOLJfiExTm2IJVw+Nj6L0qHCk8
 1KCXMpAet6TKjK71rKKdvo2Uad9OL/76zGSDQqp+L/3JVSeSg9cRudePiApvGBOcjHskHZXFjL0
 8/9aA8oONFaPuINs4MoPSgFkhH8vTxkO5TyRj8D7TKFG/86dmq1ElEjsL7tQ4nAzT0nlSmWJ7Em
 WfXdw8g18TvOxaz0ioXd7Bs8EMy+TbaKmmWfCl4OIAm+0ZCqPVmhM44TzbKIzNsUbUSNSsK2yGq
 QTrTiClZEmuqGXe71sv4Dtpd/kRULEnpofIabeoe1HXeuQ6T3Wq7WH5dOSZHO5Oc=
X-Received: by 2002:a05:622a:251a:b0:51c:25da:903e with SMTP id
 d75a77b69052e-529d710ca25mr14459201cf.58.1785234158053; 
 Tue, 28 Jul 2026 03:22:38 -0700 (PDT)
X-Received: by 2002:a05:622a:251a:b0:51c:25da:903e with SMTP id
 d75a77b69052e-529d710ca25mr14458901cf.58.1785234157651; 
 Tue, 28 Jul 2026 03:22:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:41 +0800
Subject: [PATCH v9 12/14] drm/msm/dp: simplify link and clock disable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-12-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=1745;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=VWmAnmxPocxp/N21y6Mm1MO+341LxYxr0pAEH0t9M6I=;
 b=1z9dnZsJrUDb55gTj4iQ4ujjB4kdeKI/d+c0PVoSe65McIjp3ohSswUNJzTzjLMpOprj8/OB5
 RwqCdM5bST7AH0+f1RT9EcZuI1dCVptYS/iM/A4J4LFAIq0l9j9YAMC
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX020Y1ovrGSat
 JW8YaNkvHkfeaNlA30wf4G/VejglMt7bgnoi72TDshGIfqOiFs06puu4tME2juPnbO7q+kKjhXP
 AbFTX3+2wakjYXUqzhb6YAusl4G+Sy0=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a6882ef cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FrCxesj2aA1etRkkIm0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX4IDLhD1BtzLo
 n7Lb3MOznXFGRGBKzegqTS/C3Y9VXbshtu4PBTTbQLJ6hmWhX0qIu0VE+z0LjOiNyNPj5D6lUvd
 WwX03b4DUtWlKPqivDQskzd90nM32Ptca3q+q6Gis1Y/xUa/kWJSjRBc+tVAS5dL7ElnLHPUuC8
 nNssT7U6FSnU33cTGFy0g1A05G2zU0XMYKsGitetSGTB2aFUFGdAghjw1SDDS7w4HS0G6JJmkyC
 VFQgUEc5dkUlgps9UOLsqH20AD2p4YmdUGmADeq3P8pWOEVNxqqPy8FvZmgRUCQ+lBjwJ8eK9pZ
 9qZ1MaeDmkZguEPLsaTc9UFnuunjxxsVJbCBpga+7LV+DVLS4f6/KJ/5rqiI5186Cs+K8L6xzvS
 9925efudQzwKGcCxwXp5in2mZtLYVj3XV/c2RSLq0CpGOcHFqZi7zJc0x0GVrtM92seaUFlq0pl
 Es43hE69aQM7Shgq95A==
X-Proofpoint-ORIG-GUID: GEHPAk_3JY0h4yKiqs1ZK_kpJNnB8uoS
X-Proofpoint-GUID: GEHPAk_3JY0h4yKiqs1ZK_kpJNnB8uoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
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

Move the common disable steps out of the sink_count check to make the
flow easier to follow.

No functional change intended.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6e392a99438f..9b9e96b683c7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -718,27 +718,19 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
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


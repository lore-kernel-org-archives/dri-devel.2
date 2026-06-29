Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F32C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABBA10E925;
	Mon, 29 Jun 2026 14:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxvB5Qox";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gmHGTZfw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCD610E921
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEJd2579144
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jusjjSJwJFuIT3xoYc/Wmu34BYtQlfiUmQ5CnQZ7+xQ=; b=cxvB5QoxSgcrXltE
 7rm8q9solaabb8OY55XueCGR9zm+d2egTJIuILYpdhikWaJpyfqGDb6rGL0wvqto
 kc7f+2uKjpp0nmvKK0YJejvFMh1nITpUNxOyLYUWBHpotMcKgsDQc3BTeHouaT0O
 wzG11zqCNEOl52rYJzKafq8nBdW0kbyMw6yu75i67hJ1shjtR+CkkhWMjlXuj9UP
 O3YO3nSB2aHM9SFHizqa6XT+QiGBq7HGxRjIpf9mivlKkf6xKrlVlpC3swRy5NXI
 HlcJwavnFse+JwBBMZVsm+EDBGqW10eRTa2BNyJTOHcEyMogWQ9dNN6rdpeUz0Pt
 5N3zcA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hqv4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0408254aso12811941cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742562; x=1783347362;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jusjjSJwJFuIT3xoYc/Wmu34BYtQlfiUmQ5CnQZ7+xQ=;
 b=gmHGTZfwhFdgT8W4pqay89666WgmYfRQNuUqCT4SnW9sTNt5b67CR3pqV1bBdSbXGR
 Z4SQJzplm8cXwklD73iIB5IJOtOC+Cb6+uhLfNYka1Xg9ntu0lYjg/b9MXh0U8fz16r7
 3PM1I2AJLn2oIREM1l9zrMzIm4BVx1anSY3fJOiAVoW+996M99pSGYWoetC1UBtiIbhU
 Q6GErbHEKYecIwOuZWWVQwrisqMz6R6BVR/S0HX52SGCcpXxIp2OZ/Oc5lIPvq8u4HPp
 7qPNuftSnDJROKJhEtt6CzfN/2rFrvEacmZShgwHkwXjocH60SxPgtaA2kJ/Sh7n3miB
 SjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742562; x=1783347362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jusjjSJwJFuIT3xoYc/Wmu34BYtQlfiUmQ5CnQZ7+xQ=;
 b=HB9nAyjGD7svNIjdn/oP0lARH4vahgdN3ik10HrpZmzCCBtsO427CQezs7pgf65gps
 7sSfSt/IrtZsQoto6JdF/S20JRF2tX/hVy1RZK3wbCAaRHuUJMnJeuIH9Wh6LN12jCv8
 1XhzuNl9EnRskGDqa9SH3mTFiirkIWIcddL0UAraFIedzjJEdHqKHcc7mdbcSVWT4Qm+
 dm1NkkcLnTPK5JTrRDS6lyVdch09zLoYjNy3tc3imsX9p80MEzPdSryMGgtx0d+tdKw5
 bTPWveflfiyPeJb06mtd/0/t1+tzrEomGn3I3d5Ba4TIXCdVZiHiWkAXrWljh0wD2ZbY
 zVTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UxE8jqS1uyvqWDSPUnV8xmOejGx7rAyBXxjUTdE7BGqdGV3ULPblS9IkGP+rLMZBROiZCTmMpnyo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvC1tKXajCz6r+G3tCTi5wusr7bA/QUkYIxE4HfwV7cT6+iAuN
 P9F/1wfHkilWpBwvhI42TS7Ovp01OMPyORWCFNHFgfuIKWBmLZLdJo7sQB7vEYYMCVys3aq9bL1
 L+QN5dlQRqdxXNfYDhpDlUj1iCX1TaxxlqSwGBv4vgKVmpPOPuD653GdnRCzsC8TkDYH/EoE=
X-Gm-Gg: AfdE7cmX50FRvmhF/ka47HM0EdxNgDizjZv9564x1wF80kR80UCnDkarzFDCvItv4dM
 rCYv8tZLuPC1TAHD15H5VLmM6WNVKxTfeXSdjSfd2ZWGa35SDkxp28qO4jeqGWNuamUJl2xKckR
 HwkjFBD9LEspsTvAtXCFauHEPDlx94YE7x6nu1H+I+8IXUoPjCfG8r/0+3V1teAfA0Vx2wXSvQ6
 i8SM6K1a1Wc8iol21Y0GvTPGJqp3RWYkLxcc6s1EJjRJ7HPUSH+Bq8OheLEIps3DoXRuTvfxERz
 NA4+J+8cVZiAKsMZ56OJuIcTx/9DaO2Ws4u+q+s3pKymqXfOCAx6DIYgSMGTgc7E1QiB87PUZ5u
 SAKR1oSB8sti8dwoXi7lRNs7SDBAD+uiIezymii1vFnGn2T2p8C7LcSnesEj7tIzD/2LPzg==
X-Received: by 2002:a05:620a:298e:b0:916:1785:57bf with SMTP id
 af79cd13be357-929245f72cdmr2204617285a.6.1782742562255; 
 Mon, 29 Jun 2026 07:16:02 -0700 (PDT)
X-Received: by 2002:a05:620a:298e:b0:916:1785:57bf with SMTP id
 af79cd13be357-929245f72cdmr2204612685a.6.1782742561771; 
 Mon, 29 Jun 2026 07:16:01 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:01 -0700 (PDT)
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
Subject: [PATCH RESEND v5 11/25] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
Date: Mon, 29 Jun 2026 22:14:32 +0800
Message-ID: <20260629-msm-dp-mst-v5-11-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=2662;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=UZK+i8p/CNPfHLt8Mk2BsBISLw97recIVNrtzpulGWs=;
 b=I2VV7JlMyhcGJkCIjc/NlH/o7POr83aPjN3c+htVlrhxoHABnh2Ue1pf+4lkG+XDMmHnUl8rQ
 i0f9ctCuievBYGDG8uT3BWyNASZOjbfjlVjw3dKqmChTMXwbxIsbAPs
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX1Rlja4LXixxK
 u0FOfYUK5pcLEisY+2fr/WztI/h90sy6usxkRle6+n6xJlHkKjc1LVkBRZVCDYcHvla9hYye4BS
 kN4KyaLKPamcga5QTOmqsj/M8wkCsqA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX9r9tpMU/oCf8
 +scy5QJjxA6e8Lvn26c7XoHpAfh01KRnuals89fJEy6rpPwR1QTZ2LpXjdFk3dTvc8jX8l0Lo1n
 wvw1xlcCL/NVjctkdkf9rpQHDuwmCxBYrugoXXX+ghpLk/5wmGhWj3+uo5YhUVRAQ7SE3OmXDsG
 /V+yt7rGu6B7HOCBjnk+p3458Yr0e/iJCeeE8qVmbBbw86LmcWq+9XpCayhu176QoUTlg1/wh6u
 IVRLfTTXt+xXAHuLoLizk1SARzMLfndxUD3m+wIF9T0NwPx1vK7Cy4aAwHCWDfx/Q/4xmLQkafk
 8CHm0CzpeBWYXS/Acy/tniwNgqGuztMuhGTz3JlHbZfJKNkIKxEcc+1T9tTdDrxLCNo+96/feqZ
 z8iO0iF3XzE23+AydMTR0HgkMkNFvrVwP5k+6fU80cZAanAAD4/OvRKXhlKBpj7NSdy+5TWzAe2
 kMs8oE0EE7GHMpSd9lg==
X-Proofpoint-ORIG-GUID: JekKFSo2D3-I8pD95EpCU1RONtmHWvgs
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a427e23 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a95-bzEMD9sxZBs1_CcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JekKFSo2D3-I8pD95EpCU1RONtmHWvgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
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
 drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1af56c84b82e..1680a67284a7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -731,18 +731,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
-
-	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
-
-	if (dp->link->sink_count == 0)
-		/* re-init the PHY so that we can listen to Dongle disconnect */
-		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	else
-		msm_dp_display_host_phy_exit(dp);
-
 	msm_dp_display->power_on = false;
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
@@ -1533,6 +1521,18 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
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
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);

-- 
2.43.0


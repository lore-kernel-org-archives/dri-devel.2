Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE060A262E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KcDWHYmG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LhonD5E/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA9A10E136;
	Tue, 10 Nov 2026 04:55:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5F610ED92
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A1jt2294766
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WfpbcANzc7mAC2CZRQq/40TL4/ybnjc85bywIUfZUok=; b=KcDWHYmGxidiY0XM
 yk/pb68uA9h+1sodu+vD0Fy4wlDgEz0lhQL2wevJRURnw/XPNIzhN0QryMZEW5n7
 aYq7468RKsRgsh9nPLGGdv3tKI0kNlkOFsjKv7SHFEliKSi2MAQ4JC5HiASk/YZ6
 OLnRFF6HOF4oWWJ6IjN82w1OdeVBVnLeJK/Pmj+5Tmr/svhT9+Rh2RSkBKx9E6mP
 529bNm9mi7b+5n0Ljw88y58eUReeC1TWga2kVp6YBCEdHXszIQgUM8HipNrQNK0A
 BC6nEaEPGpn7k6xFJ7FIT4ewAbjb6Im15WWwNlwV+FzzbYj0P7WYj+LX5mBWzXln
 cKtF8Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5un6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f37c94ceeso315517485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286491; x=1794891291;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfpbcANzc7mAC2CZRQq/40TL4/ybnjc85bywIUfZUok=;
 b=LhonD5E/iwxr+lR7hTLmnw0dYgTW6nCcwuo68Vv2T3FRAI4ToxA0lyXxh0ZGpKTsmS
 jbQ2sHvvQh44LTLixnm9z6PHsTztf0dEKqMYR0XIFFAiv6+Kcf7nWp98vLcCdkQuvc4d
 DJETTg0RZ6vst2xMu7qfzVHIhHLuWpB6S+DbmB4K5I2Wpr5r0DoQs8ia6AazJY+LUl/z
 /gJSKTeAK9qSNEEEc/OFAGalwjWcqJR+QTq+bmI2ubs/gwSQdrD5ublCWw2PeMVlYYQe
 IEFDoRwWJ/SdDNw1elnDz74uGnCE3qlLCOHwNFPp2JFz/PDlKeCFHFPR0enSoEYP2Hos
 C2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286491; x=1794891291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WfpbcANzc7mAC2CZRQq/40TL4/ybnjc85bywIUfZUok=;
 b=Np5M31OP73vlOPlaPv4qWQvhgI+9QpbsZu7x/3M0LfIzMqV+TrkD8oGR/3zHZ92+oN
 6iuX48H8sTs1MGZidNcRz3x+VkNnoHtjbk+7fRF5oq2WpS4j3sV2NgBm1XNEATpOm8Iz
 xqdTVT0QGPtWiEO/SpZDoGFOqe8FwgSpyaR1lrAA122wEXaeAdMG9XP9MGOkZl4NxPBV
 s+EYPkVBGOaIe191lpDfuWc+cvGlzSMNUKgVCbnXoU0nLFsro+EdB5nPaWyEGMw+yZDj
 KczgETB5iDWOqDFTFmclyCJ0wLkPR3pWp9ZzvngqqOzokj37GpCVMet3HcssOLQ7ftJI
 V20A==
X-Forwarded-Encrypted: i=1;
 AL+hErGI6R/ieyOzSn9+iB0H2JRu8UpRn6ip7/e57oAdvaRQzmjuOO/kb+GDo3HQ1ai2ZHf/yGe+IaOEh+w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8pkZ7qmMxbGTcIEIuz78NsAwIrL2mAUlRxkau+nB16feuUpdN5
 tJ6SlcNpqyrvgGIp/ln+6lcpH0OKFpTS5lAnhFMcJwofbq7JQ//a8+vsUz+wpm/99HI5Dfyri2K
 1k3w9cbH5HuvqQPhR3EIt9x+s11NtXOHg9yjnMD3dUmS+6ONChodtXtLdr3rEoj12ivaBjMM=
X-Gm-Gg: AYBFou12SznIrfwL/GCtkGZXmibs4667h0TPqeGFruDTCKBdvdOSCHgKJ/lmaXDZ5wU
 y+zaDNlrQF0UpAoO3y+qutHMD/t7Zi7nvXrKpK5qVp7PlXUa4UumKnk6qsWQvuu5PpMvXYtUoIn
 gqGZ6xpzJsvgK7BtypkzpmwBphO7u4+c66Aua5o3joPpl8g1zrzCIrZ3Jx95KPWrteNbPsoV3vc
 30FwSjAhDfMyvjocQWp0WpAnaMDtpjoyhMX7REGZKh8M4Uuy5QBLMZ7E4291YXfICJjWdIb5K18
 JHW2yZTAzIykNycFNAjqBKMu9TROIkwGaBiVxdulllo7uligCdq85Zl/PAb0p8R7ZQRVK1BM6bG
 xqUWAZKzekfIM9ymkpM6SJHdDOghvfoWaE7CTQ1lRD7qR3an3DKQeK3AudRYOwCJe4+NhH/g4o/
 BA5IJNKAZqujljKIVFe+hS7Cbzvb3aZSneFAUk
X-Received: by 2002:a05:620a:4449:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-9479f1ac375mr261587885a.15.1794286491016; 
 Mon, 09 Nov 2026 20:54:51 -0800 (PST)
X-Received: by 2002:a05:620a:4449:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-9479f1ac375mr261586885a.15.1794286490609; 
 Mon, 09 Nov 2026 20:54:50 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:54:50 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:24 +0800
Subject: [PATCH v8 03/29] drm/msm/dp: add support to enable MST in mainlink
 control
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-3-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=2559;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=1R3kmWVAchrWxMW+GrgfYnJ3iT9s5hz9hnS0dykL1+g=;
 b=n5/USZ38RA+t7EKjG3ozYfbItnOm2eC3jTVm+gz4hsoE/z/pl2bi+5S18b0Fv+BfOANJWgAQW
 ZmqDnmIH4+EDGB2MtBgXlioX7u2QDf2QJ4xCWk5qtZe9DhHipWvAdS3
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXyzm7+dIVh+Rp
 ERHT5Q8Hnr+S6xGHsYYmvIFWjm/7SihTcYCHcqL/qWKlLjKCDqY3Yd2ejn9CE7EcejN/Pg/OfZ/
 MT+oBgFuBZ1G7s4m3TGVVlApBgX2e/o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX8K/6gqEC2Q7x
 dnz93qzXJlemExdUFtjuW1mm/UZvvR6QISt3pu1GD3O6ZyCFuhlpKqdW0SX9dC68L7SDW7z9L06
 4oIJKqN39ypBuNQbQmW3yfXO4z/YTMJG2pTES0ye/WmJQDZvoD0GEomkv9Z1D/+DNA96tbVNSYA
 dxdg5eiur2qxxrAnbE4cxF+ZtChT6M/gEvumCsF68+dalNgIeZZvFNz2wYTgZnvnreM7tnRj4wk
 vqyTWi2VbEiAMCxHeyGSDh87DOIRFOYcM5ce6sLe2nIget/NlNNYxmtbN6q28XePMj5v5BXoXhm
 JkoLHph3KNqswx/auo32juMoZfZom5zYrSJ3z+sx5O+vTp1kqNnkhwLA0SWxPxAQJq/ovVsppr7
 4QjaJtm5ikdX3U+0tO6f9JZa8knPARzS+F8H43iusP9sEaGOeYYVL5OaDC21Z6GhqUm1e8LdB4O
 PUYIrZ5jXKot0Uu0YIw==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af2a39b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KL5_yMluAVk3kcf92aLEQgiMEmKZhReF
X-Proofpoint-GUID: KL5_yMluAVk3kcf92aLEQgiMEmKZhReF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add support to program the MST enable bit in the mainlink control
register when an MST session is active or being disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 288f84c33275f..b6ff3d8caa2b1 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -276,6 +276,19 @@ int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 	return 0;
 }
 
+static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable)
+{
+	u32 mainlink_ctrl;
+
+	mainlink_ctrl = msm_dp_read_link(ctrl, REG_DP_MAINLINK_CTRL);
+	if (enable)
+		mainlink_ctrl |= DP_MAINLINK_CTRL_MST_EN;
+	else
+		mainlink_ctrl &= ~DP_MAINLINK_CTRL_MST_EN;
+
+	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2689,6 +2702,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_mode)
+		msm_dp_ctrl_mst_config(ctrl, true);
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
@@ -2739,6 +2754,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 9263e61c794c8..cc74b1ed628ec 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -128,6 +128,10 @@
 #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
 #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
 #define DP_MAINLINK_FB_BOUNDARY_SEL		(0x02000000)
+#define DP_MAINLINK_CTRL_ECF_MODE		BIT(26)
+#define DP_MAINLINK_CTRL_MST_ACTIVE		BIT(8)
+#define DP_MAINLINK_CTRL_MST_EN			(DP_MAINLINK_CTRL_ECF_MODE | \
+						DP_MAINLINK_CTRL_MST_ACTIVE)
 
 #define REG_DP_STATE_CTRL			(0x00000004)
 #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1	(0x00000001)

-- 
2.43.0


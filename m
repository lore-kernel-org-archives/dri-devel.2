Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8200F3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F9110E1D6;
	Sat, 11 Apr 2026 12:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPe2+g8+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNdlNitW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DC810E1E0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:12 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B3xoSN516234
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OE9S4otYnPCURYdf3I6lpBBdzkvE6LfA12oEggiwvlg=; b=MPe2+g8+t8v7jAJJ
 a10Fz2mphFP7aU01O0OXBMLtsKWzRDEhr60GZotclbwXXOftB4l21FfK0zGGZFzT
 cuuGm0+sE7dVzax53U/LAxYxF2o2BB1yR3UXkPDDgybCZf1bV4Wx6nxlQrr2yjxc
 28ILevAzBcIatHZxK7n9UZFhFuuWZToswR2GqXzDLZs4vE8utflHjXvNymPaEy+a
 4g691nAo0ebKb5HBgxcE/28GpldBycM1NlI/9eSdmzuBaBwtYUsOELkNBXSrYsDH
 cDXad/FKuo8EBAecThEUpHmiODKY6tNC95I7gprdvem/BVXpS5z1HOhipFRPqhlu
 rBowGA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtgnh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b274f94f8so62430301cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909470; x=1776514270;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OE9S4otYnPCURYdf3I6lpBBdzkvE6LfA12oEggiwvlg=;
 b=TNdlNitWnmhD1fCVZkZti+ICDuhvSAlWv9p++4ZZMpDkPuNs1KJKcfkCJufL3YB28z
 Nainvl8vBmMbMaV6TeNOELiZzJLsl/GQlrst21qZ7/7HMw05HNesr50wEAVPShLX9wRk
 Z/bv8/TAB0VYSopxPa7fcSDT/B21u3AHAQ8G08dMnhxZ1Tz+X87dOoFmms+OAXWawfel
 wlxa9x3LcFeRixHkP3LlcKOGU64qu7R3lPIifIorvRclC29rK2rygFoXuZq8B+ovkBYA
 OhwAkFH8Cxg2rhkTLwTPAgVFfzxRrSrdQc3NyxCdU+kMTXAXnksEg2QC12RAM/qh2gS0
 Wxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909470; x=1776514270;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OE9S4otYnPCURYdf3I6lpBBdzkvE6LfA12oEggiwvlg=;
 b=QguNaKpsFPECgBwyBh1zTWQaAeeDqfi2zkiFvH2vJ5II259rM2R12Suc3YAvjpfkPg
 fSBb6ENiRCuIf5n+gkSJz5F50COi/nTCTTzwrKIANU/5z4lPrImf7yWG4To/PWUkxJZx
 caYdU84NxmXu7GYX1UC657USm3xSMdLYB1SICXwieEXUw1t5UtG6Tj8wzxI9zASyN5KD
 my7vRNUuB1OVj7n4rjwo+NdQLmH/727Wv6A2Crr6ekoyOX9m03GG6EH/kHbN9vM0p4Ja
 xJWFsIERtfanyHs03HQS4ZV6iDacRofmpoIjaE9gzercpJwA8Qtv/AJxhCsNYJFYIdZQ
 ttlw==
X-Gm-Message-State: AOJu0YxA1Gma+12KC7kstT25QehWb3rZdgAklbRt/ufVAYfixoWQA4S4
 9dDTH/Wgue0KfZDLMuqVKW+eiW2AeeiIeFP2OVBQHRZSk4Iq2ENTlzW+GKE244WE+tavEnCEQHm
 wFKTT/h7Q/1uQhUnW5Flz1aBjJwgTO1Ae3XnxtNXX4gXs2XkYL2d9av+Y1x0Sg75s/iip2ho=
X-Gm-Gg: AeBDiesreG/l53TrZaHoOcXylJrt7ip9kanQhEQm7GwMXAuDOY4OdDz3+kIqCNmiCKJ
 Ab2D841SDJhnb+37rwOGo/hxx4KjxS3oc71F0cmYG9YLLjLVG3ytUASvx/TXaQasNCPUGfb65Ds
 On4YiRaZ3XtkcrL6SNGPF9m8+BGwMaIwTkQfgRsRB3ptIWAsztue9TsNbbbffUw3Defmx76JBHH
 rc8/tbJ9+byPzA9lgbHdW3cDwg+A6ViHiIeY/la8rd/7uRAebGNxpTlv49TVP8PitFebPSg3sbF
 OPLuo9PXCmHQfswQvYuIHm7Dm1gcu3It8de5gdQAAlPNx42tfyfTRhCKDMpIA8/fLyZyP3j2ix0
 7NYeFcUEvG51OIFQoplN9d27+9kwcHRG91W25zMvFFUOO6k1ZMhhmey96okOH7LpKsW8Kwg14V9
 42PCJgYdKNXTddtmrJCsVz7j49EEoWfDUtK2M=
X-Received: by 2002:a05:622a:512:b0:50d:8afe:6424 with SMTP id
 d75a77b69052e-50dd6bcc99fmr84557841cf.26.1775909470327; 
 Sat, 11 Apr 2026 05:11:10 -0700 (PDT)
X-Received: by 2002:a05:622a:512:b0:50d:8afe:6424 with SMTP id
 d75a77b69052e-50dd6bcc99fmr84557521cf.26.1775909469799; 
 Sat, 11 Apr 2026 05:11:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:30 +0300
Subject: [PATCH v2 10/21] drm/panel: himax-hx8394: support Waveshare DSI panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-10-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11490;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=I07ADQdGhA6Qq6Cx74/dBgFSnA/ZPawbvmK6jOC9m5A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpGRgkiOpJEsyGxxgIflBnhTVBM4I+XBxHAR
 77IGUFCGSWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RgAKCRCLPIo+Aiko
 1TApCACE00N2xcVg1AOmc2dNa6N0uv5TQjoCs7/gKucEqo2ljoz7bb35QgEpZx83id43YirJhpX
 CGK9s+9mEJtV9KdIsaX412r2Xdvo9YPaioMRoGTOo1ktvb0ygSOLGd8YOazI06bg2uvpxbA1jbI
 0Xs5NjxayosMfs5OcwqQdzFg2lPbFzh/+L81iTMIz904OIp8IKWS6RTp8h6WNbaO9I+pysT3MEm
 /ruxishbB9/XDReT7fHaClejCt9bd+jiZTfBXbm+sJq9o39382Z7KXixuJZQeGFXHn7cBotfDjV
 2TuZ2Fcv8ag/lY9Hdk+iyS/shO62GvfqZ8HgwLSmxLdoVIUR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69da3a5f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=8LC8iulc4pHAooHhkrkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ZTPDKNPC2J4WO_fSjTjGicZ4DPBWTMem
X-Proofpoint-ORIG-GUID: ZTPDKNPC2J4WO_fSjTjGicZ4DPBWTMem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX2LQgXn5+6kLJ
 YhfNWy1KrIPW+4dmEBkRs/ibiXtYcipqAx46RjmQdLz8wcUuAUrJCFUHFEdA7At7w4cFssC3r0t
 P5Am52CMBBpIqnwO8flMZMBQvc86P4eTf+YBcwmfmUk80AQrWuMMvF0DvLQMRs2gbsX6mWQRO0M
 baGynytPLmfCYvA8q60Gwph3CmhK40HDWoJaAZLpLclnJzYWB9UQwETPPalBsO5Ld7JY1OXbY/c
 dg/mfys6d+F6jPu+YAFWeM4CUTNt67T5zbKBSZMAci5pe+RaIK7r1BPEJMkFnO0JA9IM/shrvEd
 8PJ6W88LkShXDgbhSoFABjz/NCIqylslhAWxkEqDuH6mvLGS0laUV7+MruBtF7BUBZeZCX/XV6D
 SVsxnr6FZQQNe6l/vdg/EUhNUTQpe0/PMb/Hri9KJZwNBhDwCsiHXhFHd2G0VGKLkvVQZAp3unE
 ZsdRvqzODVZqcm56JgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110102
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

Enable support for Waveshare 5.0" and 5.5" DSI TOUCH-A panels.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 244 +++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 1f23c50b6661..bf80354567df 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -44,6 +44,7 @@
 #define HX8394_CMD_SETID	  0xc3
 #define HX8394_CMD_SETDDB	  0xc4
 #define HX8394_CMD_UNKNOWN2	  0xc6
+#define HX8394_CMD_UNKNOWN6	  0xc7
 #define HX8394_CMD_SETCABC	  0xc9
 #define HX8394_CMD_SETCABCGAIN	  0xca
 #define HX8394_CMD_SETPANEL	  0xcc
@@ -618,6 +619,247 @@ static const struct hx8394_panel_desc hl055fhav028c_desc = {
 	.init_sequence = hl055fhav028c_init_sequence,
 };
 
+static void waveshare_5_0_inch_a_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	/* 5.19.8 SETEXTC: Set extension command (B9h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETEXTC,
+				     0xff, 0x83, 0x94);
+
+	/* 5.19.2 SETPOWER: Set power (B1h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x48, 0x0a, 0x6a, 0x09, 0x33, 0x54, 0x71, 0x71, 0x2e, 0x45);
+
+	/* 5.19.9 SETMIPI: Set MIPI control (BAh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETMIPI,
+				     0x61, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+
+	/* 5.19.3 SETDISP: Set display related register (B2h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETDISP,
+				     0x00, 0x80, 0x64, 0x0c, 0x06, 0x2f);
+
+	/* 5.19.4 SETCYC: Set display waveform cycles (B4h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETCYC,
+				     0x1c, 0x78, 0x1c, 0x78, 0x1c, 0x78, 0x01, 0x0c, 0x86, 0x75,
+				     0x00, 0x3f, 0x1c, 0x78, 0x1c, 0x78, 0x1c, 0x78, 0x01, 0x0c,
+				     0x86);
+
+	/* 5.19.19 SETGIP0: Set GIP Option0 (D3h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP0,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x32, 0x10,
+				     0x05, 0x00, 0x05, 0x32, 0x13, 0xc1, 0x00, 0x01, 0x32, 0x10,
+				     0x08, 0x00, 0x00, 0x37, 0x03, 0x07, 0x07, 0x37, 0x05, 0x05,
+				     0x37, 0x0c, 0x40);
+
+	/* 5.19.20 Set GIP Option1 (D5h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP1,
+				     0x18, 0x18, 0x18, 0x18, 0x22, 0x23, 0x20, 0x21, 0x04, 0x05,
+				     0x06, 0x07, 0x00, 0x01, 0x02, 0x03, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x19, 0x19, 0x19, 0x19);
+
+	/* 5.19.21 Set GIP Option2 (D6h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP2,
+				     0x18, 0x18, 0x19, 0x19, 0x21, 0x20, 0x23, 0x22, 0x03, 0x02,
+				     0x01, 0x00, 0x07, 0x06, 0x05, 0x04, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x19, 0x19, 0x18, 0x18);
+
+	/* 5.19.25 SETGAMMA: Set gamma curve related setting (E0h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGAMMA,
+				     0x07, 0x08, 0x09, 0x0d, 0x10, 0x14, 0x16, 0x13, 0x24, 0x36,
+				     0x48, 0x4a, 0x58, 0x6f, 0x76, 0x80, 0x97, 0xa5, 0xa8, 0xb5,
+				     0xc6, 0x62, 0x63, 0x68, 0x6f, 0x72, 0x78, 0x7f, 0x7f, 0x00,
+				     0x02, 0x08, 0x0d, 0x0c, 0x0e, 0x0f, 0x10, 0x24, 0x36, 0x48,
+				     0x4a, 0x58, 0x6f, 0x78, 0x82, 0x99, 0xa4, 0xa0, 0xb1, 0xc0,
+				     0x5e, 0x5e, 0x64, 0x6b, 0x6c, 0x73, 0x7f, 0x7f);
+
+	/* 5.19.17 SETPANEL (CCh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPANEL,
+				     0x0b);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN1,
+				     0x1f, 0x73);
+
+	/* 5.19.5 SETVCOM: Set VCOM voltage (B6h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETVCOM,
+				     0x6b, 0x6b);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN3,
+				     0x02);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x01);
+
+	/* 5.19.2 SETPOWER: Set power (B1h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x00);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN5,
+				     0x40, 0x81, 0x50, 0x00, 0x1a, 0xfc, 0x01);
+};
+
+static const struct drm_display_mode waveshare_5_0_inch_a_mode = {
+	.clock = 70000,
+	.hdisplay = 720,
+	.hsync_start = 720 + 40,
+	.hsync_end = 720 + 40 + 20,
+	.htotal = 720 + 40 + 20 + 20,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 30,
+	.vsync_end = 1280 + 30 + 10,
+	.vtotal = 1280 + 30 + 10 + 4,
+	.width_mm = 62,
+	.height_mm = 110,
+};
+
+static const struct hx8394_panel_desc waveshare_5_0_inch_a_desc = {
+	.mode = &waveshare_5_0_inch_a_mode,
+	.lanes = 2,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = waveshare_5_0_inch_a_init_sequence,
+};
+
+static const struct drm_display_mode waveshare_5_5_inch_a_mode = {
+	.clock = 65000,
+	.hdisplay = 720,
+	.hsync_start = 720 + 50,
+	.hsync_end = 720 + 50 + 50,
+	.htotal = 720 + 50 + 50 + 10,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 15,
+	.vsync_end = 1280 + 15 + 12,
+	.vtotal = 1280 + 15 + 12 + 4,
+	.width_mm = 62,
+	.height_mm = 110,
+};
+
+static void waveshare_5_5_inch_a_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	/* 5.19.8 SETEXTC: Set extension command (B9h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETEXTC,
+				     0xff, 0x83, 0x94);
+
+	/* 5.19.9 SETMIPI: Set MIPI control (BAh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETMIPI,
+				     0x61, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+
+	/* 5.19.2 SETPOWER: Set power (B1h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x48, 0x12, 0x72, 0x09, 0x32, 0x54, 0x71, 0x71, 0x57, 0x47);
+
+	/* 5.19.3 SETDISP: Set display related register (B2h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETDISP,
+				     0x00, 0x80, 0x64, 0x0c, 0x0d, 0x2f);
+
+	/* 5.19.4 SETCYC: Set display waveform cycles (B4h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETCYC,
+				     0x73, 0x74, 0x73, 0x74, 0x73, 0x74, 0x01, 0x0c, 0x86, 0x75,
+				     0x00, 0x3f, 0x73, 0x74, 0x73, 0x74, 0x73, 0x74, 0x01, 0x0c,
+				     0x86);
+
+	/* 5.19.5 SETVCOM: Set VCOM voltage (B6h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETVCOM,
+				     0x86, 0x86);
+
+	/* 5.19.19 SETGIP0: Set GIP Option0 (D3h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP0,
+				     0x00, 0x00, 0x07, 0x07, 0x40, 0x07, 0x0c, 0x00, 0x08, 0x10,
+				     0x08, 0x00, 0x08, 0x54, 0x15, 0x0a, 0x05, 0x0a, 0x02, 0x15,
+				     0x06, 0x05, 0x06, 0x47, 0x44, 0x0a, 0x0a, 0x4b, 0x10, 0x07,
+				     0x07, 0x0c, 0x40);
+
+	/* 5.19.20 Set GIP Option1 (D5h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP1,
+				     0x1c, 0x1c, 0x1d, 0x1d, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
+				     0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x24, 0x25, 0x18, 0x18,
+				     0x26, 0x27, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x20, 0x21,
+				     0x18, 0x18, 0x18, 0x18);
+
+	/* 5.19.21 Set GIP Option2 (D6h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP2,
+				     0x1c, 0x1c, 0x1d, 0x1d, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
+				     0x01, 0x00, 0x0b, 0x0a, 0x09, 0x08, 0x21, 0x20, 0x18, 0x18,
+				     0x27, 0x26, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x25, 0x24,
+				     0x18, 0x18, 0x18, 0x18);
+
+	/* 5.19.25 SETGAMMA: Set gamma curve related setting (E0h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGAMMA,
+				     0x00, 0x13, 0x21, 0x28, 0x2b, 0x2e, 0x32, 0x2f, 0x61, 0x6e,
+				     0x7e, 0x7b, 0x80, 0x8f, 0x91, 0x93, 0x9d, 0x9d, 0x97, 0xa4,
+				     0xb1, 0x57, 0x55, 0x58, 0x5d, 0x60, 0x67, 0x74, 0x7f, 0x00,
+				     0x13, 0x21, 0x28, 0x2b, 0x2e, 0x32, 0x2f, 0x61, 0x6e, 0x7d,
+				     0x7b, 0x7f, 0x8e, 0x90, 0x93, 0x9c, 0x9d, 0x98, 0xa4, 0xb1,
+				     0x58, 0x55, 0x59, 0x5e, 0x61, 0x68, 0x76, 0x7f);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN1,
+				     0x1f, 0x31);
+
+	/* 5.19.17 SETPANEL (CCh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPANEL,
+				     0x07);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN3,
+				     0x02);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x02);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN4,
+				     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				     0xff, 0xff);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x01);
+
+	/* 5.19.2 SETPOWER: Set power (B1h) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x00);
+
+	/* 5.19.11 Set register bank (BDh) */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN2,
+				     0xed);
+
+	/* Unknown command, not listed in the HX8394-F datasheet */
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN6,
+				     0x00, 0xc0);
+};
+
+static const struct hx8394_panel_desc waveshare_5_5_inch_a_desc = {
+	.mode = &waveshare_5_5_inch_a_mode,
+	.lanes = 2,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = waveshare_5_5_inch_a_init_sequence,
+};
+
 static int hx8394_disable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
@@ -815,6 +1057,8 @@ static const struct of_device_id hx8394_of_match[] = {
 	{ .compatible = "huiling,hl055fhav028c", .data = &hl055fhav028c_desc },
 	{ .compatible = "powkiddy,x55-panel", .data = &powkiddy_x55_desc },
 	{ .compatible = "microchip,ac40t08a-mipi-panel", .data = &mchp_ac40t08a_desc },
+	{ .compatible = "waveshare,5.0-dsi-touch-a", .data = &waveshare_5_0_inch_a_desc },
+	{ .compatible = "waveshare,5.5-dsi-touch-a", .data = &waveshare_5_5_inch_a_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, hx8394_of_match);

-- 
2.47.3


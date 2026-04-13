Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1C2F34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2754F10E49D;
	Mon, 13 Apr 2026 14:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CwDHjlwN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVfjCHm0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FF510E4A3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DC7cmi2186212
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X8EtGzpSCzCfnODMqzIYtparaXQEVDZmnCBL+K33210=; b=CwDHjlwN6/e0fNBT
 IdYslY0Z9Tf1ElAMbnIRDy04fn3wW2as0dl4oEcrt38dO75LByfbVovW7y524fA7
 iyn10lN/SUD0uzGIzwSG97EWogVkyg5i8m7UDiCZM/Sg+K5dod/G10X6KQBK1cjd
 3Geo44LvbFdQ9BpxJD9yolQN8lDxo0IiwSv3fIEFdalqVt65qLBEHV48iUeE7dmv
 UUkiaG7725GQCt0ZUWub+qT+mDP28bS/9qOc/e2wnwdEBgwGmQ6L2gIx8dZULPHK
 0mw4VsoJJL1GRNnnXIpPTwydsSUsKbfIBGCwUguGuzXkpSPGlXDRaO9vDt7i7v/m
 4794qQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh07hgda9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:13 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-46ee4a74741so2812126b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089173; x=1776693973;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X8EtGzpSCzCfnODMqzIYtparaXQEVDZmnCBL+K33210=;
 b=cVfjCHm0pVwt52rkrQrIVYR/cWodNwR2x6phs49+CTVZWivFMKe653CDSyF1iNATrs
 hZdPok9Qni9uE9M8mpu7XksH899q6C8srewAZ8Y7nHIS36I4X4U5qlqTZrqvbx74vgp9
 iaWTPqSOtvAPTBdy6OkcQhqW8DcGdSXRWjS76zZ1fiJgBiw8SPUAIqVXOSaVe6kTloPh
 ik/xCWTr6Nkj9hlenC9TKkUn7RtNvvFVZlEKiJ23/wulkI2pYXwfIDDnez/jrsZCt+bu
 vhBWffi73V6hyS+/QtQIy0lq0WnSEwBDHyKQQmapVqB3wYF13f7sRUFgyW4bcKuik50B
 DDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089173; x=1776693973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X8EtGzpSCzCfnODMqzIYtparaXQEVDZmnCBL+K33210=;
 b=j7ThfXIhp4Q389TnMx5dEsIEO7LgES+EUzHNrfoaw6mS1J5+QkhcBhWDRWdvgaSXaI
 89ct8XGFOH1onCNDXuhUZegrQWkjC2qIhu/mz24Tp3V8YDHwubiucCTyNS96Skykwzvf
 GMXpEJ2RX8bw40BXFOb/7a21c2vSN3k03HmUJUws66uEvX3cSw5W/MubqZKz56HKaBhd
 Pmp+3ty9/cdHX5reSXgbzAwJJbrz2WZTc7UCfXRi2mR5t55vC8GpXa3mBrYQGEJlUplN
 ER3pgqqDZQJ8FJvvqrN6yFBt3h97q6cs5tiQ/L3X/qTEjtt2R7YH0bnJymxgWFtEqh2e
 eQow==
X-Gm-Message-State: AOJu0YyrzU7Z7eXc0wpZ/wvx2+qLrgQ6Zfz8EG+sziWKXOGwaLoM2IpP
 gsoT9cegzrB44JmQ0BR8nsYL+UxRYdq0mN3B1Ql/ZKYfSRzwHqDbel4WkZXC/JzeR0OGc5ylGiO
 nV7S46VYG8GPJFx4PC14Q/P4l+KqaLzneHqEg26GaI9xUtLbswafmXrWWTpXDsofKW80XOZ0=
X-Gm-Gg: AeBDievz7665D13zmpW8byjaiTUw44+fVF/LomA2/+c0ujpq+MYuVHP3fXAuSg8Aq97
 kdM31QG0kncEgLA7OhRmOklcutA6hCuu5WnkSkxshITc+lXto9HA/rZUNyOUkHko7GEY3sfS74c
 +XUCWubvHxDy32ZGrEgXzgm84v+ytsIfPOHgS35HLZyPIFdwMeRJoePvD2iS3/xpca9OAkfbpzS
 8eFU4CVT2itSTQxLh2K82/vwJxqBNBn1rBLYZKQT11+zoYf2RHU3Qhy9myx+d26ZJa1372FSz4u
 gqHwMCnHTUvYyULUok0rka4QTOiJyaRfYvaUz+ykQpu/eaE8vWcu0rsE0V6XT4hb5DqIR77E/I7
 Z/EWTVYH+N5D7+D75oF6cwff0tkBxNYOftHU4qLF5RJ43o9Ws1IX/Sq/fKkOL0hK2cu8I5GN6Hy
 sxvFU0t7eZQ/HQOtcX+E0cN5Oj19WJHGnhXAw=
X-Received: by 2002:a05:6808:344c:b0:467:bfa:bdb2 with SMTP id
 5614622812f47-478a0400607mr6863760b6e.25.1776089172668; 
 Mon, 13 Apr 2026 07:06:12 -0700 (PDT)
X-Received: by 2002:a05:6808:344c:b0:467:bfa:bdb2 with SMTP id
 5614622812f47-478a0400607mr6863706b6e.25.1776089171948; 
 Mon, 13 Apr 2026 07:06:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:38 +0300
Subject: [PATCH v3 15/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 WXGA DSI panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-15-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=27749;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JpdFVjFOA408Dyve5igXEKyXmePeVuQuHMaoR/cbAbE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgoKNPynlErXs4q5Z05hQZ+IWKSE9WfoBhNC
 2RLi1hwqaGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KAAKCRCLPIo+Aiko
 1SnAB/9yyEZ45QALzIXQlpL7s5VOSLneUWQ86B+cMqrLq6PvkcWKD2vhzlbADurkRC+J+Uilkq6
 wZLU4U0Hn5VzWd1PDL7C6t5nSEDT/NjfZRVdmjvqDH7VY6gbBPkz/gSMI6rgVOmAMarx+6nhbVq
 ScNA5BHxRuQOzEzNYi/1GNXVQ0EQ93d6ULiMtSMoulUzYksyiRlKndPAKcdpwD1YrfESibv4wN0
 NnmM7OTAsIpPHMWX3+WbuTANGpBtBmgFqxbUnFOfGFnrQXbzr63O/OMk48qFAcJScMQnPkgwa5b
 8mR2WMTxGMhWHZ3WwffHF7OIE3u+DvHRyEK/wHjhxoJYf8QD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: yb-35gGkL4pHR3BbDRiAdDszJCdWs1e_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX1TrdQcbp6B9h
 bh9fc+BKQqjmU5OLFniT/LL27gjWcYNOXlIvuZpzmXc5HV+deMCMpuCrpvepcMkivolQSV2TU0x
 FaOgrajNRV23gIOsCbSruNg+YCguLBu3F5zmT5Tso/V13wlK8aTDS2ZwM7EW11Aoj470Kpxg6Ss
 NNK52xWnMxhtJMslMmuvy5j0m4NGc43q2OlsMbkQQu/TlTRAkXZW4PUaZqIE3XIfHFWxL0D82Lg
 4r4pwHtLy4sZlmASw1VD9+UdsIes2c4pIxytp+UdPDjWEvp1FB/+SSkV1Z7e+hudk4HxMDsk3Bt
 1a4+ryGKnHkl2fyGqBH/6dk1AQI+b3Fcpd0Z7yRbt0wNN0Wloa/mQnx8jLlGWpDJ2yRNxrhRqkO
 7onHUag5+oiAAbZjuXKFXv+ucITW6C0o/1heL+sFcBtSwt3wJ39jKL+1z16CIY2HeaHUD8JC3JF
 BeWVjmYhOalSM+XVq7Q==
X-Proofpoint-GUID: yb-35gGkL4pHR3BbDRiAdDszJCdWs1e_
X-Authority-Analysis: v=2.4 cv=QtNuG1yd c=1 sm=1 tr=0 ts=69dcf856 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=apVvwWDxUfMmm3v5wtwA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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

Add configuration for several Waveshare 8.0" and 10.1" WXGA DSI panels
using JD9365 controller

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 568 +++++++++++++++++++++++
 1 file changed, 568 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 61d67efed379..7744c66514c9 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2067,6 +2067,566 @@ static const struct jadard_panel_desc waveshare_4_0_inch_c_desc = {
 		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
 };
 
+static int waveshare_8_0_a_init(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	if (jadard->dsi->lanes == 4)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x7e);
+	else
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xb7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xb7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x10);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x7b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xd5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x7b);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x59);
+	if (jadard->dsi->lanes != 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0f);
+	}
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	msleep(60);
+
+	return 0;
+}
+
+static const struct drm_display_mode waveshare_8_0_a_mode = {
+	.clock		= (800 + 40 + 20 + 20) * (1280 + 30 + 12 + 4) * 60 / 1000,
+
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 40,
+	.hsync_end	= 800 + 40 + 20,
+	.htotal		= 800 + 40 + 20 + 20,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 30,
+	.vsync_end	= 1280 + 30 + 12,
+	.vtotal		= 1280 + 30 + 12 + 4,
+
+	.width_mm	= 107,
+	.height_mm	= 172,
+	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct jadard_panel_desc waveshare_8_0_inch_a_desc = {
+	.mode_4ln = &waveshare_8_0_a_mode,
+	.mode_2ln = &waveshare_8_0_a_mode,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = waveshare_8_0_a_init,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+};
+
+static const struct drm_display_mode waveshare_10_1_a_mode = {
+	.clock		= (800 + 40 + 20 + 20) * (1280 + 20 + 20 + 4) * 60 / 1000,
+
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 40,
+	.hsync_end	= 800 + 40 + 20,
+	.htotal		= 800 + 40 + 20 + 20,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 20,
+	.vsync_end	= 1280 + 20 + 20,
+	.vtotal		= 1280 + 20 + 20 + 4,
+
+	.width_mm	= 135,
+	.height_mm	= 216,
+	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int waveshare_10_1_a_init(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	if (jadard->dsi->lanes == 4)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3b);
+	else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x38);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x38);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xaf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xaf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x81);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x14);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x23);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0d);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x69);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x6b);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x5c);
+	} else  {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x6a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x5b);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4f);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4d);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x42);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2b);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3d);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x41);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2a);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x43);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x63);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x44);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x52);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x5a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x4e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x20);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x0f);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x59);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4c);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x48);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x3a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x26);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6b);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5c);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5b);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4f);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4d);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x42);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2b);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3d);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x41);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2a);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x43);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x43);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x63);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x44);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x62);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x52);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x5a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x4e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x20);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0f);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x59);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4c);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x48);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x3a);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x26);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x02);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x02);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x00);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x1e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x1e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x17);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x17);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x37);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x37);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x42);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x42);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x40);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x40);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x57);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x57);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x77);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x77);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x49);
+	if (jadard->dsi->lanes == 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x01);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x01);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x00);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x1e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x1e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x1f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x17);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x17);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x37);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x37);
+	} else {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x41);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x41);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x40);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x40);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x5e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x5e);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x5f);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x57);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x57);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x77);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x77);
+	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x48);
+	if (jadard->dsi->lanes == 4)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x1f);
+	else
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
+	if (jadard->dsi->lanes == 4)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x16);
+	else
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	if (jadard->dsi->lanes == 4)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x1d);
+	else
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xdd);
+	if (jadard->dsi->lanes == 4)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3f);
+	else
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x82);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
+	if (jadard->dsi->lanes != 4) {
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0f);
+	}
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x0c);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	msleep(60);
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct jadard_panel_desc waveshare_10_1_inch_a_desc = {
+	.mode_4ln = &waveshare_10_1_a_mode,
+	.mode_2ln = &waveshare_10_1_a_mode,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = waveshare_10_1_a_init,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -2198,6 +2758,14 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "waveshare,4.0-dsi-touch-c",
 		.data = &waveshare_4_0_inch_c_desc
 	},
+	{
+		.compatible = "waveshare,8.0-dsi-touch-a",
+		.data = &waveshare_8_0_inch_a_desc
+	},
+	{
+		.compatible = "waveshare,10.1-dsi-touch-a",
+		.data = &waveshare_10_1_inch_a_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jadard_of_match);

-- 
2.47.3


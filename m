Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66A1CD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD1A10EBF1;
	Wed, 10 Jun 2026 21:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFjI0D3Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MOA7/mbV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E563610EBF1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYBHv2604341
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CK4Klk07/k4jSgiSHXB7ww53KV5gcUSDtrYkPkbQJw8=; b=DFjI0D3YeJCzsyuV
 YDJ/oScxBxVsKNCeSqlVvYtmQ+rt+tdPDz8RpeU6TSfQBG+mVbttxjgOF4y2MBo8
 9YSzZmhR4tP/g+Pwhsd+Uq2AVQsfK+k8yB15R9mGz3NVdBybXHSCTi50BVoe4/uK
 DbvGAHXWIPO6EFeQ+aEqBN5MAm0w7RSYmaW3UkwpoNHvOBMrUXQvd7fa0htfzpLB
 iU6cmAT/TLaRl3k6oOO56DwA68fjJjWU98pDcC/40Pr72cuk27ZvqM3G8TjWkdm9
 0yhu1Cfvidcu7AtMbZJLPwiKPDHdl3sKKOUESmfn/EWJ0gBdpLBNnYg2e9ZPQXO8
 fmUb1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u0brt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 21:15:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36bbdcf36f0so188702a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781126135; x=1781730935;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CK4Klk07/k4jSgiSHXB7ww53KV5gcUSDtrYkPkbQJw8=;
 b=MOA7/mbVjeVo+VYGpOk0M2O0y7oQK/wcv8FAkhDaTTdFxCnZt7ggE96680rYx+n9T3
 jC1Y2t4USOI6jwmt4KB2CGa1Qkn/vcfCq2IUritDEtT/3TDrhXBYBcDRiMTOmO9GPATt
 OK21drxGGDUnL5weEIDtqzLdE2m5PR9MpwCinh+60ZTESaCOwSPdkIK2nqy83OIAgENF
 5kCKaQ7Mtp1HtfkAixqnERsj9tMQrXmUE1HS6tc+U7TEOtrUNym7gut2vJDoS3TiYQNp
 GFNLWThko/0Td+gnMZIZrJwsjOQL3Y20vQiUkD+HjSgjNSvsl/FWpnBYtx6e8TSJaDiL
 6hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126135; x=1781730935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CK4Klk07/k4jSgiSHXB7ww53KV5gcUSDtrYkPkbQJw8=;
 b=GKUReg3j63eEIwRAOTUUiW+379d+L4hO35jWvOIa4IC8wHumGwsKzMGrlAQVezUj+o
 f/wkn0GZIVePNiqKXJvtZ11P8inJrno0CCYcOIsGHHA9xUuzQkBrg9cfsS8UTWp5kjqQ
 kkF+zDADTM7uKTJ53cwHFPgVRP6Oby7FYKvq2vq+/UbzV3FOlXtqcW3WA7GWjwmylYXI
 9U5TfAyha8En0l5IPRHTt3fn6X9PKzVjnJa7C0legzdVt6xFeSKbWRY4OkY0T1DM10S/
 Ekrp9JNEWFSU8xVZJrKbYVpZrrO6YCIuzLBEUrcNe1tRFBFWw3JnWLJoeWBaC2E/YqgQ
 kR4g==
X-Gm-Message-State: AOJu0YwR5wquRtY/6uHlYoYwf1UN63XF8XHRlmgpzr8jy721QK/pdD9P
 ALXQhzGYvG1Qv+gtniqOodGj9BqGthHDJFJ1nc2W9g+RjuaN/gvsUiJ4gCBpmxmNHSEEOx91Uzr
 DCs+lQBIzl25jF5KaIHpXEfiH5SXtMdJ9AZ9O7pijOKGVlV/1gzb6mfjBTK7yMQKkwYIxjbc=
X-Gm-Gg: Acq92OGBUM9TwQ+OTP9sJgK3iw+0FQUc/IykmBnO+6+4mrgT6X4gqiD+YBN70mFBceL
 +2+kC5Eqp8rSbqbuz6h7ehr8b+NCVCbviUuiq6xtYzWKCOpq8p2lwZBjf20kJswpcNx5MLbhvLq
 7ZtVd0CJadDDWExgZPYY3NQ/eqEYAhAuZ6BICCe6y4hEbumfDNbBWujs6Ss9VdxOwij5B3ZCgnY
 ipDJm0K3O+oGABBsw2zwpPS3pdgRNrNVYs3yUAHRMxrzfLP6UZ+iPR6d2DcNyS0HypUlBmVuWff
 lIXAeTOfjW2np0dTT/MpEfomtK2z6H4y+Gylb8hFaLmbFP9h4lp62T9GGOuvFTsLbZ78a2AFhs3
 wOjlfF/JhLWf1k9uWGLETQDSl6oGN7QxJqm97ZwBctc5z+WVn+RG7lanupw==
X-Received: by 2002:a17:90b:3804:b0:373:302d:3ce6 with SMTP id
 98e67ed59e1d1-3776a6cc810mr315527a91.8.1781126133072; 
 Wed, 10 Jun 2026 14:15:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3804:b0:373:302d:3ce6 with SMTP id
 98e67ed59e1d1-3776a6cc810mr315503a91.8.1781126132511; 
 Wed, 10 Jun 2026 14:15:32 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37753d01cc6sm309490a91.11.2026.06.10.14.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:15:32 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 02:44:59 +0530
Subject: [PATCH 4/4] drm/bridge: lontium-lt9611c: Add DSI port selection
 via DT property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-lt9611-b4-send-v1-4-42abbcd3bb1e@oss.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
In-Reply-To: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 boss@oss.qualcomm.com, qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a29d3f7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Xheu9sz8Ka-PZ7GlfuwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: dwlr0tESGg9rW9i4SWVHavBH1nr7tMqt
X-Proofpoint-GUID: dwlr0tESGg9rW9i4SWVHavBH1nr7tMqt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX2iK7xVXtcR5u
 J8dOF3RQUGI0e0saTVLpxnZFwZ9M2cJpXyYa6hYnozb7R6i+f62KyaccqOHhGgeNwOxCwqbWXcH
 gq3TimTG+9cf7aS3sBisVjzoFct4YL4DOP/EZBk95aNuHNxDwQTuZrvAPFqkxdfPPoaxyDU8iN4
 hHzhXVLjak8a6xu2wyh4zgc4wltRxvHxgbcxB+RZrff8KNNRY5RCjCBuHZk5gWK6UJKbCA/kFty
 bQ3LgVXvJTDpFVnOY2Sf3yQtcLmJF1au1d0vTZLn/17335RyUXq17kFqo2mGqFOuutv1EznPByP
 F3b02gVwpmrtFVU4mYriueQTA702DfNrQQyKd7yo9qRqyhciJ4/AEiuhJvxbjXPqWQ57H5AQdjU
 fQmMrgixyMOZf4qMvlJeq8NMHei0KM/Qgkkp02By8LnsOixHBP2BEa5mgatNhHHOeQQgQU/X6EO
 gJpoFTqbNTlZ0E17c6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNCBTYWx0ZWRfX4H95G4y7FmtS
 JQ7M3qVUF3F38IRiz3XrK35Peqq/gTai8zaT4eW8jp5Fw9qBaEt1pdqBEjYC9MjQULIxE6w7oFd
 R+bc7psLxIEfZaliriB6NodptCl6OLw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100204
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

Some board designs connect only DSI port B, or both DSI ports A and B,
to the LT9611C. Add support for a 'lontium,port-select' DT property that
allows the board DTS to specify which DSI port(s) the chip should use:

  0 = PORT_SELECT_A  (default, single DSI port A)
  1 = PORT_SELECT_B  (single DSI port B)
  2 = PORT_SELECT_AB (dual DSI ports A+B)

When the property is absent the driver defaults to PORT_SELECT_A (0),
preserving backward compatibility with existing DTS files.

The selected port is programmed into the chip via lt9611c_select_port()
during probe, after the chip ID has been verified.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index fe51f4978546..5d67bb7391fb 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -41,6 +41,12 @@ enum lt9611_chip_type {
 	CHIP_LT9611UXD,
 };
 
+enum lt9611c_PORT_SELECT {
+	PORT_SELECT_A  = 0,
+	PORT_SELECT_B  = 1,
+	PORT_SELECT_AB = 2,
+};
+
 struct lt9611c {
 	struct device *dev;
 	struct i2c_client *client;
@@ -60,6 +66,8 @@ struct lt9611c {
 	enum lt9611_chip_type chip_type;
 	 /* HDMI cable connection status */
 	bool hdmi_connected;
+	/* Selected DSI port configuration */
+	int selected_port;
 };
 
 DECLARE_CRC8_TABLE(lt9611c_crc8_table);
@@ -115,6 +123,34 @@ static int lt9611c_read_write_flow(struct lt9611c *lt9611c, u8 *params,
 				return_count);
 }
 
+static int lt9611c_select_port(struct lt9611c *lt9611c, int port_select)
+{
+	int ret;
+	u8 set_port_select_cmd[6] = {0x57, 0x4d, 0x31, 0x3a, 0x01, 0xc0};
+	u8 set_port_select_ret[5];
+
+	if (port_select == PORT_SELECT_B) {
+		set_port_select_cmd[5] = 0x40;
+	} else if (port_select == PORT_SELECT_AB) {
+		set_port_select_cmd[4] = 0x02;
+		set_port_select_cmd[5] = 0xd0;
+	} else if (port_select != PORT_SELECT_A) {
+		return -EINVAL;
+	}
+
+	/* MCU must be running (0xe0ee=0x00) for lt9611c_read_write_flow */
+	guard(mutex)(&lt9611c->ocm_lock);
+
+	ret = lt9611c_read_write_flow(lt9611c, set_port_select_cmd,
+			ARRAY_SIZE(set_port_select_cmd),
+			set_port_select_ret,
+			ARRAY_SIZE(set_port_select_ret));
+	if (ret < 0 || set_port_select_ret[4] == 0)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
 static void lt9611c_config_parameters(struct lt9611c *lt9611c)
 {
 	const struct reg_sequence seq_write_paras[] = {
@@ -924,6 +960,10 @@ static int lt9611c_parse_dt(struct device *dev,
 
 	lt9611c->dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
 
+	if (of_property_read_u32(dev->of_node, "lontium,port-select",
+				 &lt9611c->selected_port))
+		lt9611c->selected_port = 0;
+
 	return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c->bridge.next_bridge);
 }
 
@@ -1070,6 +1110,10 @@ static int lt9611c_probe(struct i2c_client *client)
 
 	lt9611c_reset(lt9611c);
 
+	ret = lt9611c_select_port(lt9611c, lt9611c->selected_port);
+	if (ret < 0)
+		dev_err(lt9611c->dev, "failed to select port %d\n", lt9611c->selected_port);
+
 	lt9611c_lock(lt9611c);
 
 	ret = lt9611c_read_chipid(lt9611c);

-- 
2.34.1


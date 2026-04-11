Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8314AF3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E393510E1E0;
	Sat, 11 Apr 2026 12:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BHwGzk9b";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h3TOSIXV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22FA10E1E5
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43UiG621326
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tW2wH1SEkwyRGozFeJLS/gOD0zhYYxjGM1wCbKw89bo=; b=BHwGzk9bMj+s/yJM
 HRydB9q4gqrY3mbh26PNRmjG2tv4Op4h2wzsv+pVObZ/Z1dtiAi5hvZ7q+eFa2ec
 zfwmvOLpprQwyt9dggAfkH9imsHwZzmk/v8KePtbM0ncx4c2w2nHM4mSSeb1KIkb
 AyModtMr9GXLeHvoLooj9ZDoA/ExwyFGa4Rd1nIVrkJAD/DSUnVwClR7nSVodCbB
 FJhNFW9XSm2JCmjPumZWFXwIHhCM6OMQJS/plTei0FybQ9c5tjjyw1VGQpb3h/0R
 nWt6dlnqqrpjfYY+a8WhS1Ssjjzuj4AjzZybMiGcFOO8tCVVwEKxliY5xdfgw769
 YP25lg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfrnc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b31cff27fso25699931cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909479; x=1776514279;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tW2wH1SEkwyRGozFeJLS/gOD0zhYYxjGM1wCbKw89bo=;
 b=h3TOSIXV7v7tYLk8DoGZ0PdjjZFOJOUPezV3CEGYEbIk6czU4LyI5LbBAgy+jbjCT3
 jidJ3/qgh9ONMG/jf1Je/v01y0B49OPtYNaUm9AalHI0uq2wUaXZtrsREmIUqvDAc9+x
 YMP3Z1bEHJwKdsjeV8lSIS8zVikUqfVh/Nw6pWairTXjhMM1XnxSt3G08Uxx+D98gjie
 ujaD7H4PabeH8w8A8IuY1WSoiyz5pgefG07W2lqixbe+vEq9drelhV05x4XY9QTn4AgF
 Rti1adPGGFUsMWgkcpPDcT9OQfJZHRUSMu2f7T5VT4RbP6412xTuapCeUgzT7GhEniHj
 BEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909479; x=1776514279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tW2wH1SEkwyRGozFeJLS/gOD0zhYYxjGM1wCbKw89bo=;
 b=qKo0MALu+zUYv2UC1IQc/iW1NcDEEtzUy/zNW0ZdPgWrLnkTiwwdmJEBc2/e8ddaS0
 xF2y0kKKBHcKEXVpZJZWEeNlAtIEAg4zavsh6fQYInhfMRbnIPudwvgznSqlJUUqOc5k
 fLIJuegZoj+HwQ8r0oYeUKdle9zZcdQ0SfRQiuXYFzZQgH7X0fMJLOtOlztYYl41/8DI
 /2F6HEZ8Azpoth4lkQ0UCdEDLrQ+bSr9U0WbwzrZF/QWNlIdEvuhm1SJgKV4oDN6C5Bw
 AVDyb5kA3GNX0bE/lV/tFP/tzmKb+nJ4NdPYP3/kb8XSzHRpgCyQHV0wCnTjBFHJyJxH
 bXFA==
X-Gm-Message-State: AOJu0YzpONkb1cqaTiQ7/A8/9QSiAGhD1NrAh5rFiazAIKV0Gldjmfft
 LRdVF3crDbMkLS8JfJ/O4Te7MiGniodPuYNmdsllfWu8H15IyMVVZ59e461Vc4kQlHhIi22cCIk
 TDGhHd4Mu2nib0/y+9flA543PvdcebbxY/+Sni16OxKqsdg3kCDI7L+mCtbCtI35rXmi6cV8=
X-Gm-Gg: AeBDieu8ViQ0JWncWof+xuJw/ZasGZb6WkwaJ6jzGl07Ogqv9X+rNCJyxpwRoPUIYqV
 P+IpssffDoOhYh8L/VPSCJW3J9P6p1JtlPkFXUs1DCKd+20NNkjCzNSplihbPJ7KOoFAIkjikRy
 Onlj+entNZcBuGbUWPr+fTjli4foGmbdIQAeS6LHZccDRHB0Z3FsHySKZNmd73N/hrfL5piJhQo
 hST9Tt+xhLYCOYS8MCnMCjxakIn14W9CXKJccZCL3z6fQ2tLE1+NCruyjvi1dU6y1ncLCl/8Dhb
 6HZn3i32GhBbvOYpk7P+cQt7BEMPcXZ2r4uw8e68BoHwCXXFJ2WkcCBrDBbvqgaidFF5O9urxoa
 ojTfSJZIss5i6EFryVf86mnnhz30sR5FHwbfKLiDQpdYZxz7uBgaHxZsdFxdRZW3giHhX2DxOGP
 9i5G5Jqgat4vJI3oGwpZWw1nlDdp5wwCDLfsE=
X-Received: by 2002:ac8:7e96:0:b0:50b:3e4d:7ffa with SMTP id
 d75a77b69052e-50dd5bdab51mr98801591cf.45.1775909478905; 
 Sat, 11 Apr 2026 05:11:18 -0700 (PDT)
X-Received: by 2002:ac8:7e96:0:b0:50b:3e4d:7ffa with SMTP id
 d75a77b69052e-50dd5bdab51mr98800971cf.45.1775909478293; 
 Sat, 11 Apr 2026 05:11:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:34 +0300
Subject: [PATCH v2 14/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 round DSI panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-14-75cdbeac5156@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=24423;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=01BqkhL4ltxf9UTBykYfGYIBjM3T5bEaoi2x2lYAC68=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpGRIi+aezur/PHYEf6WugXPNVuTy2fwMpct
 4T3einfuy6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RgAKCRCLPIo+Aiko
 1R5eB/wO0Q+ty+VaHHvXr/ZZIt2PS3F/0sGb2601A5c1fanbOvvOQIeOGu225gYLvdcfhBQAJP2
 oewie34HtRuG9Z6EmPj0eRKiH1vLxgrJXi3vu8vUnPWhI7yKXzaSW194qetqzq5YI9NXqD/97Ps
 XMiJ4FpP+WBLeTmuu8erVx4Dt4Hg2cPjScVJY5n4PetpYFfWzyVKmwlFeCIKg6q4sDBgT5hX4aF
 vaPLCu40teld3gYiwTIJ/g0lzWrjjkP9U3yPJRmpaOGkXBh1eZc82dqvKeVaI1U06G9YnXHJsFl
 UyDuspeZHe7VML9z91MbcegXkrOxAj2FKJVAfGyCVGWNCaOa
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ne5fiz03rLO_FW3EOXr-Ew9n1c_aM-bL
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69da3a67 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=sK-RQuhdBYdXSAti0wYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ne5fiz03rLO_FW3EOXr-Ew9n1c_aM-bL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX4G3ryBV4Tz/u
 hcr+ZNKyvZM8Nv15bfkZ0wGKb/t319NqxrCeT9A+QDAd8sd47j/yTtTJSzLF/0WmsX4nL4wZvbr
 ctl2ikyX3lBO8+8r7kjObxZLPTcL3kGuWEFTdZTAuxOonyzYVI8WYuVALYOMCiajf7x72snLtAU
 rrl2S+kMyMkVueN26VqksQEkZG6/gnuCUh3VufYfND/E3d9kpPQyt6c+LGbdzlcWFzUOgRaeZkR
 nPxdKv4+kRlnFAotUQ0qvxZkkVWeQzRoc2RVt9NXIi7L2pmYsNMXwUb27rip2wo6JxFAtZMezh6
 DWu7aqyz6Qm3bVZBBrR1IxjbCrG0xvszgwQTTOoNymWcqgG7/+TUMxE1ta/NwK5Xngb6t9lkKxe
 1BfFCSZ6Z7UaqJrfgvE92tgbX6W5CDPTrM1Zkt8T4ZBjfG99GznGAbDhC1e9ExaJfB+BkUfvFxC
 vjeyXp/94/c164uQcQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

Add configuration for Waveshare 3.4" and 4.0" round DSI panels using
JD9365 controller.

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 476 +++++++++++++++++++++++
 1 file changed, 476 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 11b7e07c1af8..aacb8968cd01 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -1599,6 +1599,474 @@ static const struct jadard_panel_desc taiguan_xti05101_01a_desc = {
 	.enter_sleep_to_reset_down_delay_ms = 100,
 };
 
+static int waveshare_3_4_c_init(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x64);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0xc7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x1b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x0f);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0xa6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	msleep(5);
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct jadard_panel_desc waveshare_3_4_inch_c_desc = {
+	.mode_2ln = &(const struct drm_display_mode) {
+		.clock		= (800 + 40 + 20 + 20) * (800 + 24 + 4 + 12) * 60 / 1000,
+
+		.hdisplay	= 800,
+		.hsync_start	= 800 + 40,
+		.hsync_end	= 800 + 40 + 20,
+		.htotal		= 800 + 40 + 20 + 20,
+
+		.vdisplay	= 800,
+		.vsync_start	= 800 + 24,
+		.vsync_end	= 800 + 24 + 4,
+		.vtotal		= 800 + 24 + 4 + 12,
+
+		.width_mm	= 88,
+		.height_mm	= 88,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.lanes = 2,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = waveshare_3_4_c_init,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+};
+
+static int waveshare_4_0_c_init(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x64);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0xc7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x1b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x0f);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0xa6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	msleep(5);
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct jadard_panel_desc waveshare_4_0_inch_c_desc = {
+	.mode_2ln = &(const struct drm_display_mode) {
+		.clock		= (720 + 40 + 20 + 20) * (720 + 24 + 4 + 12) * 60 / 1000,
+
+		.hdisplay	= 720,
+		.hsync_start	= 720 + 40,
+		.hsync_end	= 720 + 40 + 20,
+		.htotal		= 720 + 40 + 20 + 20,
+
+		.vdisplay	= 720,
+		.vsync_start	= 720 + 24,
+		.vsync_end	= 720 + 24 + 4,
+		.vtotal		= 720 + 24 + 4 + 12,
+
+		.width_mm	= 88,
+		.height_mm	= 88,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.lanes = 2,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = waveshare_4_0_c_init,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -1708,6 +2176,14 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "taiguanck,xti05101-01a",
 		.data = &taiguan_xti05101_01a_desc
 	},
+	{
+		.compatible = "waveshare,3.4-dsi-touch-c",
+		.data = &waveshare_3_4_inch_c_desc
+	},
+	{
+		.compatible = "waveshare,4.0-dsi-touch-c",
+		.data = &waveshare_4_0_inch_c_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jadard_of_match);

-- 
2.47.3


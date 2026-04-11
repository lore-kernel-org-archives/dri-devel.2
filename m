Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E03F3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B1210E1DA;
	Sat, 11 Apr 2026 12:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvEe87M6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VuFUwNLZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D54110E1D9
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4080V3909474
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EacYV252Ylxyrr9FQ/70zKkziBbfMroxAzrIkM+nfi0=; b=lvEe87M6jsa0fiQz
 EevMhv+vCjFZzcBpxS3nTLtWlAuloiN5msMh/997rSEatRWHi/pXInJFWz91F6vk
 nS93IpmnyUM+dnagzOc96LAGLqxKjukSRZwiZ8LDE5In6Vy20v26RDQFcvuPYV9L
 sojz9J7FJTit2DxkU50Br1DNriG1MpoEJdb3E3y67nroorq6WD8PujV4inA2AiSM
 N4zLggm1lHtXu4T50gZt3hLz9HfPao9gvvTMhBKWK68oRCGLJt2qb/xdz0Mbrmll
 6PiCm7CYNexqtlOhgkaMP7lvN8a9lV/dygGiYgX8MDeCA0rUOboNal0NHkXadNJC
 6mswyg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew00nbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b323c43fdso53419831cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909466; x=1776514266;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EacYV252Ylxyrr9FQ/70zKkziBbfMroxAzrIkM+nfi0=;
 b=VuFUwNLZY4oevP+2AUiKmd+Ygo7BRZsd8rkpNLznKOHCvEiEOC5lJvzIeSEgwoBl4W
 EEO3zPUah96lYkbVxnqptScP7DXJywmpu9WY0N4M8OFC/JAV1Q0RwNYAF41zt7kW74CD
 r1enk8Rk8oGCB8wX6RW0MdqGBIkgtJBtO39I+pa1YpN/sspcFZDXDcu4VWRf4VihiBCo
 tX8LYfT6Q6LE0PpE+wOiLNsS0lWXgTH0+ulM4bhFkSIaaOhxup458H/0ow7ILsIUTGHh
 UbS2l5ZwGbXRwlH30lr6CElRqtLtwtAYosM2/lJeqxgSe5MaXIRH3kslheWmbh+ZcyV3
 RRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909466; x=1776514266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EacYV252Ylxyrr9FQ/70zKkziBbfMroxAzrIkM+nfi0=;
 b=kuCVjCq72RijijHJ03NgwRmqpgFLiu4oQU3p4oO/uj+kEPw2aM90KJhiaaBwWM7rAx
 MGLVCYMhhaWPmn3PsIKHj9uybh3xWiAhPTtYKJbEdHUPhQWKBb8l7g6jN8PN+/wwLZrL
 jX7fadtyAa4/iFXtup+ecy8MUT8D65Zh2JlmJdVKhMs7SxcCY75Qr2O7ZJoDG4moHi1B
 HIX5g6hCX/0qsIoVacg8Iy+wDm4wfTHK5CZKTTN1U+cK+TuJdxDd7zK1IbadxvJaCwre
 u9rApCf/przvQve0A/ChtOiVLEq55BhTeNyqGOp6rpE/cPPM+BwiWF/f0xse8W/4Peoo
 7qVA==
X-Gm-Message-State: AOJu0YzNEd/wkcp9LHUxRl+45WIcejevm/EKlQiXc2/T/jJyizm6Jivy
 JtUPxHMJfaUvuIurrJPbJae4An6lT6YQVDTqtV/L/vxEk1KKkj3vzP0rkmpxXGNnBWpUJIZ+BYz
 IpsL1zbQi6B859uwJJulSwbib/CHHBHONhv+AnF8g0EKPAM7F/tvc3AS+3v8nmYydmvv22uM=
X-Gm-Gg: AeBDietz27raXB3KutgKWkffJLUWwYt87hi+fOY2sxLBFtETHXCWjuV7CQzYOiiePAt
 1IUaMjcyiDMWzamxmQRk2dyahK8gO8sUL9b93ebOArZPmk2IpsbLaa1+Czp09SDfsGmxTMz5JgX
 tqMQ5vFlUCvNm88w1269g9n55e8TanKN85B4OeNcdJ5s6lBnmgQhGy+rWb3Rvnpdk1Od8VAHPYs
 1F8gkrTB0M139ojyprNcA59+jUxfgkEoPGQxq6w5AhD3ZlbhcmqNWBCdqole3GNQRpoPOl+4kR6
 FlhYSfkm1tnWe8M4IgKhFEzq7rnozBo6pDU12nWH313zi+IQgEU0ZVfX2GPVlZ3eQWrr1IgYtVo
 nZgd+TB9w6GUcQc26DhNM6HiHCWnMmtO8Q7I/pDx+I8/hgReG8soPiaj6c/VaKLvrM4YfkiBNTX
 oVZZafMG5Ihl2BLbIkIYbxwzycEqeTarEoh6s=
X-Received: by 2002:a05:622a:1189:b0:50d:7504:b719 with SMTP id
 d75a77b69052e-50dd5bd1ef1mr100580391cf.52.1775909465964; 
 Sat, 11 Apr 2026 05:11:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1189:b0:50d:7504:b719 with SMTP id
 d75a77b69052e-50dd5bd1ef1mr100579891cf.52.1775909465528; 
 Sat, 11 Apr 2026 05:11:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:28 +0300
Subject: [PATCH v2 08/21] drm/panel: himax-hx8394: set prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-8-75cdbeac5156@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DoendjqYMNCpaNDLx5nJc92Y8UtuCTST95sXT4ei12s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpFW0vQ244JNcxKBxL5K1n8VoGz1ZRi3WrEQ
 5MkXyOolKCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RQAKCRCLPIo+Aiko
 1VKVB/4ix4mqEZIje288JrijjZjm+C+aALrGxc+Zgv/a4M8FE9MuOwcE/LLV2qNiMBQ2DBwcTM3
 Cv5q7Rbyi8yCqXWubKIsKGFzkrxWqqubVpIIRco4W2E7MrAOfqaBH8USgRdOSmYqJYx9gHqGANo
 FPZE8gnLR9Ytjnn12c0Rn4nsxOe3ksg4j3jwtBK4lpJSd9Ki+j7H8FqXQMzr6dVMP3ffuy/hOjB
 mlbQ9jyDfbJslkpyXU542botlevdq0Hxe73OcmwOgEYbdJLcj3wp9knZBh+l57zyfAcSwEPkdOU
 f7iBc+j3jB6DPyIMi0pEMOi7EQbPvpCRmoLJym+b4JBdYJN6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX9EST9TsCS+Xt
 n/pE6g/DAJHxoyg6UV1H/e58Hdz+L/sLuGzODsalsTkaETSTymDw+v5RxwmwYTMMnJpXIAqtPtz
 Fy0/TF/DQO4iwYoOZbcJ3FmTG40sBYpvz2DkJyHrl8/ncsA+XlFMFXe/8W9S83t8hCQ43RQRscB
 0jWGDm44MVUk+4j2UGNgDETKLRaOvXSe57ZZ7wWARyiRtEXvVf1GPIbFk4iwWPgujsApzpa0Ghg
 DJvfqcylBC82a60jdUtXN4x9CNUbz3wVoUd4/DQ3YCDoL1+1LfRps9apUD1OKVzXDU0wRL29u4V
 oS7ubWy77e52VEe/Efeq+FbEZcvTKwq61s/HFQpszADHhikPZRgNwUZqGJMsSv1NALlLfN2vx7c
 ieBnidtWSI4j/wjjUSuoNTMJ5jzJJMMwZCQVWyzLL4y7fE/IG4tY8VfcAifT6+5vFfZ5DyJ9QPp
 cmOj4Hy6efhZv371eEg==
X-Proofpoint-GUID: nssKkhp-1s6a_KXZff1QdKiyBPZ1zIF9
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69da3a5a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ic6V0yA_i5s2A4o5CdYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: nssKkhp-1s6a_KXZff1QdKiyBPZ1zIF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
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

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index c4d3e09a228d..d64f3521eb15 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -792,6 +792,8 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	ctx->panel.prepare_prev_first = true;
+
 	drm_panel_add(&ctx->panel);
 
 	ret = mipi_dsi_attach(dsi);

-- 
2.47.3


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C2CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4073510E838;
	Thu,  8 Oct 2026 13:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIlsv7Nb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGEkVVbF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD82B10E818
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:14:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK8ON2384045
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UB63N6HjCANQZ5jq0C7jY1yKL31IEX47Vb1BQuveQbE=; b=bIlsv7NbqLOCE5Qj
 Hz4ZY6LmMaLxesq8meiJByEhXEtX3aGv4G6Sw4DEzT4L9v9FLTvOz/a7Joe6WYhO
 3FPqesx9LKwz41BgHBuKYJ6om8iRMTqY60JGe2vNNm+t+oDMwsmvYXE0mSGH/9Ih
 OTVHzj2ZF4O+O1YuiO2KRHpSJOH4TgZlNlw4kXcej8se91o292CWbrZstURT3zeG
 RoXd4PUYXVz9w5pNd+lIDl2tvxbCBndr9IsnQhB0hiuGuKLeAFr1N9aWBj1DkgkS
 p/H3Nv+gbG3KObTw9LY5XjT180RpqJqHEBQbmcl43sbI7eyxHpJWcetLMMXiz3NY
 E9sNGg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3k3tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:14:55 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98f0cae5b9cso108892241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465295; x=1792070095;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UB63N6HjCANQZ5jq0C7jY1yKL31IEX47Vb1BQuveQbE=;
 b=aGEkVVbFewxThcJL0HNzLXdoP6wHvx6hzMK269KHZPfYzPRw8VDtuY2JVGTnHL/MhY
 d0YOw6F3bG74RkXM2xufrrZMOQPtlsUfzZZyFXHFAT8j4Sh1Vj+wnq6lgjQeKgDX9jAZ
 v1n3N6UcPcwjUkfPlY8836mSA8ysgEnyjjOzqx59cFYOzk4V4mmbTEy0z/grQoJGEs4V
 iqAgWc+nReZflPoARaoZ14VN6Sg8RKxR8dYh6JMKHfBx0O8xR6IeoWpXyocVjbIy0Xgg
 21TJ1V+2jZUnbWBEtoOxbhLZiFSdEyd0R+F/AoGeu9riuvHEU916u7y+mp6a1HoZPZ2y
 nh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465295; x=1792070095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UB63N6HjCANQZ5jq0C7jY1yKL31IEX47Vb1BQuveQbE=;
 b=0MAUNr1gMFn4NEY9W3DWjQO4Uv3YmBfNbeCARmhVN2lE6hl7HqLnrUch3RFzWbXh+b
 AwPYQUrbcXbWgXwOZfDGFrTsFg/0VZTalY3dU1HpNajqcHvbncMY8XHJty/uM4m6Apqn
 E3DL/ww6LJwZUyn/PYyAxeK95k1nY1a20uILKW0qe0qluy3oKH4oH1HdiP6iUoJlZcG+
 uqCL/NGSLmt8LcSmTtnp7JnMPedioTnwtEqqIPrLt9ORxptbGnfzjDFZkwrSTCxWLEq2
 bGeUW4RBrnmYCSQHYky/eqA0NMuA2ki7DbTn1LiAtPlS0esBxqwGeiKIAAsnM4nYw7OJ
 NjRg==
X-Gm-Message-State: AFq9FYJwwr+ayuBQrBYQ9WumrqwfzSK6g++3yC0vLx/Of9YxBRFnj1n6
 GcsCfs5mDVtTXQzH7iGn9YM3rIPywud7XAUhcroCOGxEIkGYq3eksDh74hiMCTFWgGGZTHjLCXQ
 kSXZQXpiX04V0qxHtv6N4/QGQ1Uwmwse89c+jdEMZU5UQDCtGurAK46GvZb+pNc/f66Bd5YU=
X-Gm-Gg: AYBFou3JNLmVZ7i0uUHQUyzlmncTX3+aobDWl08+mQUUBvch80AI0laxGcAHjIyplug
 b1/3KSO76YLZkMT0AxCMbs49T8zyLE354yoaxQa1Ytmk6gkMKgATuT0OGq++tbH0RY+gwk1TNZA
 fl+NWQWE+fLFfZ83HmMXYBsjMgimnJq4VguAGYsmUxTSoQQyUQlxzUDdRTLMpNi8KfsT2ykVOX9
 zg4eo8nUFig9M9QkDRkug8GC3KnGymmKyVhwEyHfLtNSe34o8h34/2dseje1iPDnT4TK5D5PjiM
 JtPV1WzSwjuPgyYLea3L4EYAGQ2QTJ6bJ7WrUaRL3S7l13lY3p3RpLz/inkt3+jfBKJVJIib3wx
 QxLUHG5l5bvnkRuba/PnhqRfa8+vcmwBFz6r020Mu5d2Y2ack2/Bbs6OhcFFIi0/ii736VHg3C/
 55ng4ZoJ51cl8D
X-Received: by 2002:a05:6102:162b:b0:7b5:1ca4:9df1 with SMTP id
 ada2fe7eead31-7ca36e3fc52mr1320963137.5.1791465294854; 
 Thu, 08 Oct 2026 06:14:54 -0700 (PDT)
X-Received: by 2002:a05:6102:162b:b0:7b5:1ca4:9df1 with SMTP id
 ada2fe7eead31-7ca36e3fc52mr1320952137.5.1791465294370; 
 Thu, 08 Oct 2026 06:14:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:14:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:24 +0300
Subject: [PATCH RFC 2/9] drm/bridge: add atomic_print_state callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-2-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MZGERy6Fpx88fF3L1FgQF/k3kPkrjYHnP54kpkXn0t4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dGgJs/eNkfeGan6xT5FkitBUDvoGTi3H0WE
 1JaURvLsfSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRgAKCRCLPIo+Aiko
 1SLzB/964+d9UkU5qtInoqgXCytUAqXZfOreqw2r1RZimxh/nfZn2O+3soJrUMduBuHwxM50noI
 TRRDH5HnMzHniVoyDd2DRVxQtHWH/ckRmLV4X5GvpyeANlgDAl14LeDgLaKy+UtjccoNjPQQogI
 IZlWpV47xRk4RZoG3S8Ka3LH2KvYP+gaeGgkl/wrcQky0jwx2+rlzBGk0oN+ON11hOcDp7uPg9h
 Us6qGr4IdNSHlbEwAGyfQ6EhpLModsgjcuWgMTuPxyj72BoZUvucxGlcoANtwPN0KJiHh2OcAdU
 CckjWOjgxFQXJbzxMavfR3OeshcpJVNqmLMTztG7AES2cESG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX+CKt3oB17AQJ
 luAPX9BX1mZhqtWkS/IfkPYbGhgsOqVA/2tWgdS+OZ1PFkNQmQVMI5qx2iCFmOhWAb5LbiF0fSa
 NsLFNg/lOdTe0borKLUnLEF2jCQ6Nj4=
X-Proofpoint-ORIG-GUID: dj6BEJMgFH4-BQWy_TXMs3c2ANjzMDUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX/5mZvGM0xHKn
 q331XDf5gxyDaEX2VJrn4bZNgsKW9oGQG2cnRjk5OwTRACyIk/iwSobrKD2EbT8ZG6nJmWN/+g2
 VkB7DlUVopF6TyQ7/dmS+aGqQUzNsDf7QiKXsp/v0nWYdnHqjc0u/KoILExi6DUswL/NKLuC7V8
 5w8ZBUL2d0Q3s9L5yJAc7Q2sf1M3Cl8D9yVG7yjVPc0FYaOqpU6KImbs6AEOfTbPUFn6m4oNa8c
 5x0IGfJROcMX/3WDw40tH7/xVvZOwYcqAYr7QjW93sail45ORfVG2AcbxRC1n4ZwXOJInTYaKw0
 Z+gNH5ZZ7lO7h9jUNIHOR7mBhAHgwluiCvpE8x4ZObyVsmaMtC2ZOmodt8/xOeZ8wkqQI9lI2N1
 w6Eu/ZFb3ssFMHVAVvliPJtFKBml/OfI+ZxpGuqVxWA9tZCJxqw7zJKT0wAZP6/JdoePebsO37d
 BNCE5j7BjBoyjzNZi4Q==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac7974f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=amLuN3caG5KOhUPOIKMA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: dj6BEJMgFH4-BQWy_TXMs3c2ANjzMDUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080052
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

Bridge drivers can subclass drm_bridge_state, but the state is printed
by the bridge core, which only knows about the bus configuration. The
driver-specific part of the state is thus missing from the state dumps,
making it hard to debug such drivers.

Add an optional atomic_print_state callback letting bridge drivers print
the rest of their state.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_bridge.c | 3 +++
 include/drm/drm_bridge.h     | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 0f37e3ade016..2b06171b122a 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -571,6 +571,9 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 	drm_printf_indent(p, 1, "output bus configuration:\n");
 	drm_printf_indent(p, 2, "code: %04x\n", state->output_bus_cfg.format);
 	drm_printf_indent(p, 2, "flags: %08x\n", state->output_bus_cfg.flags);
+
+	if (bridge->funcs->atomic_print_state)
+		bridge->funcs->atomic_print_state(p, state);
 }
 
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d..8b0c72d93d9b 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -312,6 +312,15 @@ struct drm_bridge_funcs {
 	void (*atomic_destroy_state)(struct drm_bridge *bridge,
 				     struct drm_bridge_state *state);
 
+	/**
+	 * @atomic_print_state:
+	 *
+	 * If driver subclasses &struct drm_bridge_state, it should implement
+	 * this optional hook for printing additional driver specific state.
+	 */
+	void (*atomic_print_state)(struct drm_printer *p,
+				   const struct drm_bridge_state *state);
+
 	/**
 	 * @atomic_get_output_bus_fmts:
 	 *

-- 
2.47.3


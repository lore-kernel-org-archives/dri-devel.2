Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AA7CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7C110E860;
	Thu,  8 Oct 2026 13:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="la2CDEXk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vrs/pAjC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B23910E890
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:15:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK1Pd3846921
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 csvfm07mHvVhHKbV5agBPH0uNXrDO4Yl/0BBvYmp7jE=; b=la2CDEXk2OvSLWVx
 anXfqjh3tzEhtm865n8TYn0mD3aBXk3YIyChQsL8DBO6blAvGCGe/gVK8YFW3/G2
 k7G/6Q+MtpL7wWHwxWRUHl+Jhu+NKP1vKy7nV8yFgtIfzkotB1V/FtrMIAh2fF2b
 Q7EyQcY4yOf+z6+KvbwVy/7/GBI8TN4Bq2cAiznSYRh0ZzOElGXpR33x6ofQODRM
 mf0Vda9GcvQrt0JCp+di8V4+/qesD04T5m1tdKKENRc1DxieeREsNt64jm4oXYWy
 scYtzdJSAsMvHXqdhHs/pVOxAyu+L1/lKi8UWVuwfR2/QkhKrmNfAfmeQG1Zp0Au
 +wv+Hg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sgak7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:15:08 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7bf45382794so5072420137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465307; x=1792070107;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csvfm07mHvVhHKbV5agBPH0uNXrDO4Yl/0BBvYmp7jE=;
 b=Vrs/pAjC/CgmfUvvngED8CiQrskQbj4AL94HwT81wUhhQZLhDjv1YNBZDGmR6Ky9K1
 aBfZ5J25KtUQPf2wta3SdZCl81bu+NItVTGyCrD2masPkglh34vlCMAOdLm1+tv+B8WK
 KuV/6ISiAhMdyFCezRNyxc+RU2/SWvUJ4Zn3W36iw1Br5PszsV5gH/+j1JoxdOVJI1SC
 +wxCn4348vSn06Hg3mrM7N364iRGCkZsrdd8/YBuSKVYu7MxP0D9JEa5/sdr/pwqEjjj
 w774C1DElGZA0M22/E0QcoKaW4iFtqTHFZXM0oBQ7b/oMd8/o4E488kutrgHq8CLV0lv
 2XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465307; x=1792070107;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csvfm07mHvVhHKbV5agBPH0uNXrDO4Yl/0BBvYmp7jE=;
 b=IZWb4TJSTo1y+33H669uMkhgS5Cy1ixs1DGRUpmlfMljOmoxqyM3BK3tuy9iwlLnf8
 lAze8SKarBpW0ldih3U9CgwGoqjEVGepWXSk4wHV/aIHtu9i6FgY+o8HbZm9y4GibFIC
 Qk8KLA1owCqH8owe7kUml4UOuvf44jMp7GBzvzqN2KOAXWbK/wR8Nz5335JX08nR+v5s
 ruJd3+/mRNIwBiDDZOKDFNNSdS57cobjqf1nxnWA0h5ZjgHgm8zJtNfuKdPdxfEjUHNQ
 vvzY7c9y3BCocrtym3ZlH6944caaHaViMdfLVOx2Db5H3gVzy3LryEF/OjGH9wAKmY73
 krjg==
X-Gm-Message-State: AFq9FYIHXU/B3WSRaNlSekkZ7dx9HTwBxZ57FZoGDw75XSbYLMyxsO/4
 4q3ai6cP7anl0K7jVeqZ19l9iP9QQMxmEsecugfQWaUBQPFBFlxRBWgK3P+eLv8CgBMLKJiQiMM
 lsFhQ20MKH4toig92TI6opmriGX0e81/Z1rvqAKGt4YOcQR3fDmzBOCHpUYZXk8O+lQcg69M=
X-Gm-Gg: AYBFou1Dso9SZwA/3Ig5kvv3rlpk/ExuwxMx035i9Saaojw+/NwN1SP8b8NTONdSXJw
 tOMsJezaCMg13Fc4Uf5jvsBSV9n32/Eh9SNogqPcreT3CsFvM1wTpcsFwMl5EYURUPe+Wft5r3F
 Kyu58RJfzTK2Wp+nE5UDOGOMb3lBi3NVDd3VwMrFmq9avp3o0ueO3fiwtWAQ/QZD4qpgWvHyhrz
 eraZi9WEiOrS6xkRBf/+BpamVY7CD2XYEoQQ9M03FOk3KcnXjY78bI5A3rskHLyJERfga0wO5Wm
 vSSeXEx+lvVabXsNeHQ7EtxnNYjLufpM3tKSwciMDNA68GwGMf1zXkmc8E0VNtsW7CMPCmoucYP
 dEvGlnrIgmR6SxCQ8bFNEnKRpeBeU8gShyFUwdflWVYQSXbwsVG9SGqYny3f8pwVfRWcOYoW2G4
 Fw4qf+hLWy8FGP
X-Received: by 2002:a05:6102:5124:b0:7c4:5129:8e17 with SMTP id
 ada2fe7eead31-7ca38f24bb3mr2010584137.31.1791465307347; 
 Thu, 08 Oct 2026 06:15:07 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:7c4:5129:8e17 with SMTP id
 ada2fe7eead31-7ca38f24bb3mr2010556137.31.1791465306755; 
 Thu, 08 Oct 2026 06:15:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:15:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:30 +0300
Subject: [PATCH RFC 8/9] drm/panel: add atomic_print_state callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-8-b157fddb8de1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8Vtfc5Vhy1+cySlmiGbXt3R0OZFZEbN5OOD72ntakHM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dHkhcl/dRf92UtqStXhuyjnMMpcO7OTegm/
 6IelH591c+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRwAKCRCLPIo+Aiko
 1c5lCACkvON31pjWuwjbQjdxOf7Mb2UoJz7PCeluWDNicQbjHqBg5RyMTSBfQzOjsD9lSrdMJAw
 0Xs7pTYCm+HS2D/mlwjV7f4UMReB+WK/O6HAkY5UGTuCZVcAJ0yU+Wd2IdrnQdT8oHYXuPfisvc
 VDXpP6PpiZI9px/CDDHDID/Ff7sn1xGPN7iia3tzlPJc84NH5S4aBfoaJ1PNUuXjhkCZzx3tuff
 9huScJAmaCo0jz/o341FauA3r/SgVRTamSPkZVdboi5OrQiMrQzzWB7hcyrykrpwsU307RlOQzP
 Cl2rxTuT3zBwhMscKeQ9xcz36NH6Z6xTNwemC1eaIz/84KxF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ERECBO_vSg0EitUqZ4eQv6RexluqOag4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX5T4PhEj0GwNe
 mvlwFHPicXaxOmPwmgpjBWR3KjOPfBMK15+iv+cJff+SpBYjtU24hQ6nk/o/eh/lJOeAFCcYGYr
 a9w/7Qs7i/HaXd8Q4b2B4kUvdsZqEa0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfXzbQ37+vC4nHx
 xMreGU8F83Rd0taMIqF5VjTvXJQu49oizUm5jWtnFYZlQjjodx7oTWT+0R+5snGnp8QTgQqWTII
 pJyhK+QtCjD4PUJv2QYFmdPky78uMNvIpYUQpyIcTvqYjygMrxWCjQwby1PBq7M238F2KsMSVWf
 HDUxUajFGTsLkdioWttdO4dtcWZ+DF1biQZpWRFiY77Shh00XEaC0NEg/X4063OMPFBMLpZaujs
 1zOBgzVJYNM/UrT2uutoyXyJFReronxI3GDj2vQXUqyj2C7ebvMn2BhLewpkXUTopfV8maUvoBf
 j/7wCMEoTahtverTzhaftJQQeWEHpOBOqPnheGfEwS4M4C74DIHpOiC/voJTjTQSKJvTC6HxVmN
 Rtu2eZ5eCj/ilVyU1Z73xz+hYGsUZzWfN6fdHoINr4CfGr+iQw7Z8yWmBvLVflWXvcgYWtlF3e3
 19d83e/kmNFBKlUNnZw==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac7975c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=10bbWnoWcBPEOdUi84sA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: ERECBO_vSg0EitUqZ4eQv6RexluqOag4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
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

Panel drivers subclassing drm_panel_state have no way to get their part
of the state into the atomic state dumps, as the state is printed
through the bridge embedded in the panel.

Add an optional atomic_print_state callback, called from the
atomic_print_state callback of the embedded bridge.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_panel.c | 14 +++++++++++++-
 include/drm/drm_panel.h     | 11 +++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index a2cd043fe146..9be36c5b1037 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -483,6 +483,17 @@ static void panel_bridge_atomic_destroy_state(struct drm_bridge *bridge,
 					   drm_bridge_state_to_panel_state(bridge_state));
 }
 
+static void panel_bridge_atomic_print_state(struct drm_printer *p,
+					    const struct drm_bridge_state *bridge_state)
+{
+	struct drm_bridge *bridge = drm_priv_to_bridge(bridge_state->base.obj);
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+
+	if (panel->funcs->atomic_print_state)
+		panel->funcs->atomic_print_state(p,
+						 drm_bridge_state_to_panel_state(bridge_state));
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
@@ -495,6 +506,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_create_state = panel_bridge_atomic_create_state,
 	.atomic_duplicate_state = panel_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = panel_bridge_atomic_destroy_state,
+	.atomic_print_state = panel_bridge_atomic_print_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.debugfs_init = panel_bridge_debugfs_init,
 };
@@ -853,7 +865,7 @@ static void drm_panel_init(struct drm_panel *panel, struct device *dev,
 		      !funcs->atomic_create_state &&
 		      (funcs->atomic_check || funcs->atomic_prepare ||
 		       funcs->atomic_enable || funcs->atomic_disable ||
-		       funcs->atomic_unprepare),
+		       funcs->atomic_unprepare || funcs->atomic_print_state),
 		      "Atomic callbacks require the panel state callbacks\n");
 
 	INIT_LIST_HEAD(&panel->list);
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index dedd792d2c52..20e5b1e5f50d 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -43,6 +43,7 @@ struct drm_crtc_state;
 struct drm_device;
 struct drm_panel_follower;
 struct drm_panel;
+struct drm_printer;
 struct display_timing;
 
 enum drm_panel_orientation;
@@ -301,6 +302,16 @@ struct drm_panel_funcs {
 	 */
 	void (*atomic_destroy_state)(struct drm_panel *panel,
 				     struct drm_panel_state *state);
+
+	/**
+	 * @atomic_print_state:
+	 *
+	 * If driver subclasses &struct drm_panel_state, it should implement
+	 * this optional hook for printing additional driver specific state.
+	 * It can only be implemented together with @atomic_create_state.
+	 */
+	void (*atomic_print_state)(struct drm_printer *p,
+				   const struct drm_panel_state *state);
 };
 
 struct drm_panel_follower_funcs {

-- 
2.47.3


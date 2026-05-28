Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E85BCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AC910ECDE;
	Thu, 28 May 2026 07:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fKgYbzC5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfrYUbPt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2463710ECDE
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S6cZD81974920
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=; b=fKgYbzC5CpKmUqWd
 s7XIxzYb1hUGvkCKRZ4W7hY3Sndz0TBo8qQn+8+0+gLO2Y/YILTTtpBqAEd2LV+N
 2ztBNFVXtqF1V8PuLuntECmwQRd4Wz7OUmfem0mm3nmMLzxFNQne7oR+KTreQ6Jx
 DyiIeXEUEoiHG6mKWsE6nL1uHxg41IpOaGuI/nGb2viLmoBxILAGyWZRFg3oE80/
 oH3DBCvCQPuxa3TwAoMfZ4mIHPsEtDZ6md45qn1yLhjJNwzlMAnjxs3u/+H/tJY4
 EYmL8iENxk6h2lYPhtD/sqBGxJxLOtJwgJbDLnJB/2/4re2bCKQhAPxNyv3vQijO
 pUXUJg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3sqk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:10:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50f13da9684so151458151cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779952257; x=1780557057;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=;
 b=VfrYUbPt5FtHAViUEASVjidtkPtodkHLwyGXKnSX76gYTAt9gjb56VHB1hmwakH5sU
 h56Orr0z+ZrET5mb9Zf923l91KO6qA8D7J0khMS3wDhb5h1LdgAp0NdWzuys1xSD46kO
 gM5e6rmiHiEeNHoZ8dcsjyTdub8HygUKUGw9VoJ9LNpXhU7LMRTStY3g9IbuPIIDVvpT
 xBC+fCB0f50SYb9yiXVpdIqL0RHfzYGn5SWoN9iqI+NsAN35VX8e2b9goHGqc4bq+gGH
 hkxu8fTdw0paKSQeJCvqooy66Uw37AdFt3sn+Ta4RgLSQUheRceHvBm/y7nuP3mtZVpn
 2ZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779952257; x=1780557057;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dnqi4A1Nw9iq1rCq6bx9iMLW6imbL+bAYQJUwKQDVEA=;
 b=PljB9dxGa78thwpwtyxpotejI+F7jx+Lr6rONzn80zoJrdLUKRPxn5SeFJybdqYKD7
 H6I55KzD5kYhlFWLcS/jieVixQBgtDuBF9BtOt0AGaQbQ53Nvc45ewT7Pd1GGT44RPQ8
 tvAFsj+uB7QK3eg08L7HUX2pDpA3vxaB3dhBQdNG5fQK0PdYHVBms/uZLaPHvNdRAk8r
 klD8HFC7IMEzMkvTaqA+Eq9thg6KzcCC7IRbFiIlSQfUu+c1SiqNpbjZKZqEcfLsQDcD
 rsdXsEzA6BAiXAu8GzQif9BavHOVmmlBNniXyrsWCLAFCLqGb2C7zNfilaUhltE5lKnX
 oPQw==
X-Gm-Message-State: AOJu0YxuLsTzcYoYm0SObv7o2sEg6poUpDyS+Jf7+DOH/soIA9pZw6TB
 OoEpAvjRwiZNvFVug0edkeUhJQH+WMx7yr9A4GUqsN7G8LAO5YPnixMxFoDlB+auoe81O6nkJPs
 mN9xO8HBdwVGqiE0mWjNXDGTDdcmi9Z58RMPuZsQB/MHee7UtCoXqjn9Z3X4kmgBI+J0uzz4=
X-Gm-Gg: Acq92OGDSO7OX2RFVMUGp6qDI35evKdHhksZtTmvZh7KBXsVq9vUPkkantI4wxTuBIf
 xd7OK+s6NbqYsDyb3WEXtcqDXBM11TetkiAucb/1Q23A6a1bR9cFnmQXY/gVhh7FhyIqjpX729G
 MEQ1l5e6G27dCkUpb0coBYwm1Urts8jlHIkh9GzilCKW45HLdd+g3+8URxUZPhb9v93tMZYXpNZ
 yhI8zv2UzgBCICRBamA7kjHrrHvLS2D3WS3XuTOqfHRPeQ9SLB7DsJYvlC54sO0OAfn2e4XTp/H
 nGcpKyPUEp7biywKFZqP4DF1ji7lfTd79CdpV/7H0tpoXt6zGDS5kt2awAe9naJ+FZP8NdSZhSG
 xi5+D1g0i5gtPyzPU00xQmdWbY2vbL/H3uo6aiFewKysIeeV1/lFH67eikhta6H/hYbjb4sDnVa
 LlSCtb3yGoAEOriSBN6OdNkmZ1NbMfUvHQwDPjtrDbq44iXQ==
X-Received: by 2002:a05:622a:1e90:b0:516:da42:43df with SMTP id
 d75a77b69052e-516da424757mr302438421cf.30.1779952256584; 
 Thu, 28 May 2026 00:10:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1e90:b0:516:da42:43df with SMTP id
 d75a77b69052e-516da424757mr302438141cf.30.1779952256114; 
 Thu, 28 May 2026 00:10:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc0a54fsm37416161fa.20.2026.05.28.00.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:10:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 28 May 2026 10:10:49 +0300
Subject: [PATCH v3 2/3] drm/bridge: display-connector: don't autoenable HPD IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp-connector-hpd-v3-2-d656eb1079b7@oss.qualcomm.com>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
In-Reply-To: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uaisOO81wUqXM57ZY+50E+vgpCZk+fmw3L+QuSoJRis=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5b4q8qq3JJW1qxqoaf3TG7M+vuw07FkuUXaQ71p5utv2
 0nxy1d1MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAib804GFoUpdRv7G37xRVT
 fMz9m7CV3nGJYBHt6x1uGX/+bXjx99nfxd0Rz6w1C906YqTeerdac9e+q2C9F1Azn8Op52aN0vb
 bL6uXWIip12t3K16+llj2eWeF4NL6vc/1t8acfMk7dUZ6pf2hPKuuGHvbmMNmLFN3yLvYWDM9/3
 zkiqDvRCXX/AzfaQvWLbCV62zolUl7/7RccIpyp/vHymWCV763aiVuq1Lq2mGuZLs5PLt4Z7Aes
 /xsjrC6oo8P3CKZ9rgU3/n7XL5u7YHQ0mNtm5Nb9t5hXNX/mkVr65qWp79XsRnl8x3yUeJKj5S/
 Fvz5+qpdErNnqocHcHrd1Ow0E960ZPP9Ek5u+1IrM34A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Ts4sXgp-WnBBqzGcwA_B3WlyDbl_FoEv
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a17ea81 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=n8oM3ScPHa2hF6C7bkkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Ts4sXgp-WnBBqzGcwA_B3WlyDbl_FoEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2OSBTYWx0ZWRfX1QV4YEHhY9NE
 3MK95jMtTXt8udzAUXAuSc0Q2O7Fht++9cwU3SrN76FnOTooXGaZptG+8pzOiAjxmUIFqbZt68f
 QP3SHMbQDjZsZI5Hh+L3fdoMHjR9rQKA3gqvCJD9zcNHxCNBD7JBremF/xpBi+Q8nCuo5an9IQ4
 it5ybE3V16HMoJBXv5am/9tUYBlzNXgzna83xKU3YwFDCucXD7Th3jz4myO1wXw9EClTo/IW4d/
 2x+b2TtgZIOIbB5zR2cOKSWzF3WwEuho/euq1DIPP0aX89SLgGo8XwfC7cL8PJ+tmcxsJHxcgH0
 6A4X3g5jHay6++EoaM2FoYQwKpOLXofvBCj5bSjxkmsXc9XzvgsfK+zT0fLFFc71XVq7niJw+bI
 ptBZwhd2nvfYtXA5tZxCoJ/NhMfsTKwLz9ioY/JUe6tnNm6IgUUqWOIRk+oV3SJowvUBN1qqedQ
 SKAvw6R73Q2Cw59kbLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280069
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

If HPD IRQ is enabled in the display_connector's probe, it can be
triggered too early, before the DRM connector is completely setup. Use
the enable_hpd / disable_hpd callbacks to control enablement of the HPD
IRQ.

Fixes: 0c275c30176b ("drm/bridge: Add bridge driver for display connectors")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..6bb1134f75c3 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -87,6 +87,20 @@ display_connector_bridge_detect(struct drm_bridge *bridge, struct drm_connector
 	return display_connector_detect(bridge);
 }
 
+static void display_connector_hpd_enable(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	enable_irq(conn->hpd_irq);
+}
+
+static void display_connector_hpd_disable(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	disable_irq(conn->hpd_irq);
+}
+
 static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bridge,
 							  struct drm_connector *connector)
 {
@@ -178,6 +192,8 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
 	.detect = display_connector_bridge_detect,
+	.hpd_enable = display_connector_hpd_enable,
+	.hpd_disable = display_connector_hpd_disable,
 	.edid_read = display_connector_edid_read,
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
@@ -307,6 +323,7 @@ static int display_connector_probe(struct platform_device *pdev)
 						NULL, display_connector_hpd_irq,
 						IRQF_TRIGGER_RISING |
 						IRQF_TRIGGER_FALLING |
+						IRQF_NO_AUTOEN |
 						IRQF_ONESHOT,
 						"HPD", conn);
 		if (ret) {

-- 
2.47.3


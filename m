Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0676C43602
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DFB10E515;
	Sat, 27 Jun 2026 20:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZO6WARh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F/Z3Igb+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E9510E512
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RJXibj1947116
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SQRuQ81Slpu
 6S/J14DvxvRlWrELKuYfDpyAlzE8xCAk=; b=oZO6WARhuG9xUw1P6qmtseIvpRj
 9fyyK01rKmEaE9jxoJ9EbmtsTjmWsa0lvSRqVL0iFw/Hj3UZeAPrJzOquExaJzjG
 wFWQ2lsU/PL4awyFZfNbMj+dg7XmbwyFSVsFOZqOE1YKlY+OXed2wH/HBVxSOj7s
 IVnD6X1KIDwwCSfHj+efYM1TTaC755qJutemCQrgyokhAAYsWIZ0ZWrDQEdEw0eX
 Rqe2Dky+bQvcC1R3rumG6RlpC3KNq9FMSDxkViBLEakf2lFeElVx+nZS1JIIdo2M
 pFrYdr5hVT4wJaJTy1tYbjRzcHoqkX7umg/KLCvDcMQQRoZcHuxtP+YdqCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuhnyc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso1289399eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782593046; x=1783197846;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQRuQ81Slpu6S/J14DvxvRlWrELKuYfDpyAlzE8xCAk=;
 b=F/Z3Igb+eQKooJ+l3gug181ZjutoHSK1bEFb5nyXnTG7dlxq9GiQEdOr7lSmOB//1U
 i8m6I+T8TSqkzrUnDFaeQv6itdcG8hsHOF/l62NL7wGeH4qGbYibb+U/eRAPOxj13BEz
 MuPBoxVXfpNX2lajF6hM47s6OF4BWa8KYshWoImKE3+nLTAPQtKY9W/yd3AV1rAr4mP1
 4oBE/so/afi5wwwjxIi16P2cwt/TcuU4R2QFuRmltDopEqdNCAQhn39gvlDuxpW+5VAw
 JmhFpYvNmyhKIvaKc22FllOVdpl5BAB4bRat3vDlfwCmIHAyeU3XHljs7wT+bQdThSbZ
 lnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782593046; x=1783197846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQRuQ81Slpu6S/J14DvxvRlWrELKuYfDpyAlzE8xCAk=;
 b=shPZpv1jbJXAQyf9hFEvKfzsLP/jHyQzRe6+Ga0bWEtrrxiKT8tW16bCMKuc9j/Y8O
 0Jsgn2dsu1dX/30sOz31bL/hkfxzOlKCcmv0SU0hgmumrkNjeBcSXH+mwOmMDFusZpdA
 IWVZwP//BSk4e4AZUX/iR4hosKOF1RVS/2Vx0UBrcbyjeWw917S9b23avrs/hLba/O/a
 54Uj3DBU6yt6n1Gs17YCAjT8R6NhFQ8n5iA0q2T1/6XZD5zd50YJCmJ8Gd/UR34YFPqP
 0X9amcTQ0NYgVtTnFoTu1HLxwNFtUrGyTN0/NqHP/D0MYIQaC/Nh0o+vaAFETDLE1GYk
 d4tw==
X-Gm-Message-State: AOJu0YyvtWtfLQgql8f9zsn4SvdFae70odrWBqBUjiLzFwXPyZYPopJ6
 0yc1YHE6oc0V96j34av4RUlvNz1mep3fpddeiczuU1Uks1+ocIyCfp6oUCLNQo3LEaJIleLc0A5
 LR/2OhCgBMT1u9QD5dGXafjRUdgmaV+l+8sP7Nvhv7MB1Ibg+iz6qszDAai6oxPxtVXeZHcFp10
 7b6sE=
X-Gm-Gg: AfdE7cmVV0HUrtPZAUtkEzmc++1ygYZoGw7sRAsY+SheUK3/5BvXmJCo9a8amqn17h8
 vUiHQGkbwmXUT56uaPSZkebH+I+aId2gOWNq7DKCenCj5R3WsYjjZRb8LUZYb5SYnnLRtbhNGJa
 wxN8877Npyzy42fE/FI4LbajwZMv3KB7EyhJG1UWpUGUO/K7c/b8SX4mpeIiNZqqoic/JB9bfll
 z6MiSAb+6jdsOhO2y510wE0O413cC82e+7rONV6m0PVtvzHWmwaMuKQS1ZfoLly9pyZRf4qTkcf
 22ZzfPts0ifNQlbAaRNBfFROxY26LUxuCxu3XbOPYetCRupppqQf1Nv5cnAyYXKhInoOv9/TPZc
 kE8fRl97GmsScZ9wPMAf1ABcgdMpXUre1VT88
X-Received: by 2002:a05:7301:fa04:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30c84b64e8cmr11092474eec.10.1782593046466; 
 Sat, 27 Jun 2026 13:44:06 -0700 (PDT)
X-Received: by 2002:a05:7301:fa04:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30c84b64e8cmr11092457eec.10.1782593045942; 
 Sat, 27 Jun 2026 13:44:05 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm16882963eec.6.2026.06.27.13.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:44:05 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 2/5] drm/bridge: lt9611c: implement hpd_enable callback
Date: Sun, 28 Jun 2026 02:13:54 +0530
Message-Id: <20260627204357.3336040-3-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
References: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9A6ZeC2tZnRYz7SY13zLk3p0VkQpLgeq
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a403617 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=_oZU6dHFf52f7Ag4h94A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 9A6ZeC2tZnRYz7SY13zLk3p0VkQpLgeq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX5eKFksz81yfy
 N44tuFt9nrNNZAJSUedpCMbhh6e5OxMl8s4R/rkPVw7dwLYdElsVtZXwXE+0oVDYBEl00Bv5gUs
 13/AjhPyQaJ3TrPA07HTyPeip11GNszO9tUE9+yguP4dlfvMaHH6PZkIMIvldVlIzsWAXLqwI4C
 MJ9/kaZpqmKfYH/eas+G9GsiDqogRh2ePoIhqbWZ0ujxDxQFqY6SnZ4dn9NrMh3rv87ZP6pgERp
 vJGxVIZn+U8CTG6mmYDJTHbIzI/HO56KroM+tUOqLMS85n2ImYhQj0A+mqvaXjMj2b/pch8ADdu
 B9uwn7buS1wLdmlsAj6gLWIDKdKAOBfOCpXSLzfFyjd6MMQSp2YHxXJER1SDo/tYJFhVHzFOoAT
 Lmm+BPaDkQK4ZZ9LNXRZ3ZcQaRuU7NyMxokLlsR6VC6cH7U06d/CmWcQt2J43dx7X0u2v7Uyat9
 Pt67O5wD0z1/ifONy7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfXy79M50Pfw7HA
 G5QxcYvAiX5psFafploKGnZ2iGpfdgc2gHK4gT+0lvR6Ep/UUiRcTjSUjCEjYE4mzcPHmy6eBaT
 seMUhfx6PsgtXjUzxwzQ6cRzFS8b800=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270183
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

From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

Implement the .hpd_enable callback to trigger HPD status update
and schedule event propagation.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 81ca9d62eae3..30a07e97626a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -923,6 +923,23 @@ static void lt9611c_hdmi_audio_shutdown(struct drm_bridge *bridge,
 	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 }
 
+static void lt9611c_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
+	u8 cmd[5] = {0x52, 0x48, 0x31, 0x3a, 0x00};
+	u8 data[5];
+	int ret;
+
+	mutex_lock(&lt9611c->ocm_lock);
+	ret = lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd),
+				      data, ARRAY_SIZE(data));
+	if (!ret)
+		lt9611c->hdmi_connected = (data[4] == 0x02);
+	mutex_unlock(&lt9611c->ocm_lock);
+
+	schedule_work(&lt9611c->work);
+}
+
 static int lt9611c_hdmi_audio_startup(struct drm_bridge *bridge,
 				      struct drm_connector *connector)
 {
@@ -939,6 +956,7 @@ static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.hpd_enable = lt9611c_bridge_hpd_enable,
 
 	.hdmi_tmds_char_rate_valid = lt9611c_hdmi_tmds_char_rate_valid,
 	.hdmi_write_avi_infoframe = lt9611c_hdmi_write_avi_infoframe,
-- 
2.34.1


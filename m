Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD7CCD98D6
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B5210F63C;
	Fri, 12 Jun 2026 18:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WR8zAQI1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gBNfqBPi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62E510F63E
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CGVere4112808
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TPWo467A1KtBfknXLUhzGM05jfJhVUBGDG8kt4+2Duw=; b=WR8zAQI1Ce48sbsQ
 iko4kevADzRuNsFys/yUaT2wA08EO8kntUazpR3SYgJ8qEQ1mCbCrkD4hWZ7nnet
 QfCrCERbHHPoErM3ZXgBgnCCnNGEM7pBbrXhpn/cghbYrkA5K8CRcHrbbRV6fLry
 HJ82D6zeU4RQJc8MeriCpWHeG0iZm4CscGQjMvXbE4fLGj1WNnffM6lrsBWfaWvi
 KTylmWw4szOJRozfVJ51Wfi+XQ87hv7dCUCOJ13ulkBrhsoOjurLWd/VhjbAV4dh
 CKIFwJkRM1ZOXusNS1w5n0T24KqXqhEoGpp8pv8qsaU3VCum5Ik7ZtCop5gh8sKk
 DoE0iA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gc2rc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:30:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9156ceb551eso193312585a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781289040; x=1781893840;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TPWo467A1KtBfknXLUhzGM05jfJhVUBGDG8kt4+2Duw=;
 b=gBNfqBPi/tPW5HoUMrdaD+M4OuNHjLc5iQJz6bkAhv3qh3lFU7vod83ZnkrvBODdjJ
 srysTPn+7/d3KxnpGwyr3gAAGEstpz0iCbbwFZk43BaFlISjrWlC8OyAudenTJeYRISQ
 W0D20WGrcAwMvHwJwDGJBcfGzhBEcknvd8kmBZwEPX/ZUd5Zzhug2461nMSMOrEp7hVN
 MyULdC/8tJCU7oqLT6d+R8nV0oUskDkc2dzcqKpYF/mTAdxPdcwUnTeTTRhOKmF0GJbQ
 NDZSwUrxaQo6CTgRW//g8ysAwbZeAtrlI4Rf9sGEbbkCoP0FJy5BShXAMwIKyKBXeY6z
 W8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289040; x=1781893840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TPWo467A1KtBfknXLUhzGM05jfJhVUBGDG8kt4+2Duw=;
 b=sNNHoua8OjXJhfzLns12dfPN4K0MXm+Abqzv3G+jVVNGA5+CGMznibopgDADhQN2i4
 dMcjS9pkn4RK4ry2H73KB0kPLVb1QUYGM0GqrWV3/D6n9I7v+nxVPwUn2tREfboyHO6J
 V3vO4NrDb4d3oqTT6rweg9MhTq9Q9YWwgkksBZrae/Fd31ZQI2wZ2f7VMSY3Ege7C21Q
 9NtoTNa1+1mRAxxaqa5RXaZRl/1q1J0xZYpW5pM5BSU19TSEVJm48ti9U9c9vrRBqatE
 Pn+BFC9dElp8xo4W98mKrdZbE4gbEgOrhIHvRXPUiBNr+p46rTBOnwJ0laGKIFCZsmyq
 /4Xg==
X-Gm-Message-State: AOJu0YyYk1/isYV48s+1wn2euy2/l6KfxbU1U7839iHMpZ22IkMgCAlh
 1/Xrrf5xHKYEXHil5DVfsWlDSsE2tcm0LfbDxXHeHwJGWs3Mg/Ow+Yj/tuwROtL0ZoFL/1d9N8f
 qI588FI6o6tTkrrhrY0mTMVhbZVj3sX9x2TcSdjMBgr6O8FH9WcHxaJNuImAXUjuxP4Ez3/g=
X-Gm-Gg: Acq92OFndFnDK0Gsc68lrSVMePGwiDt5Su4WG5anQOLgr5+iYaHrruc8JlRf7Ttswx0
 v1rqMnHOoinPmuhWew8tCqiiilOxiL5Hv16d60fgk1PrUBr3iXWHSf0A0UDUr386loLfaf5wBhi
 XjG9dePKTSNyQbwzcNFDqFOZiBgir4+95jesSmlARECktMTx0eOpk5Q11trfvbMeISf3o+lrsO8
 OdmZZVrhQikUqY95z+twn/DmPsQUGC9dxNqEgbwAmLQGSsQFX7NncmDeXY98nlyZCPdQBFGQLqo
 ZE4WkejYQh1fnkXX9XlcoGrHwouv4/drsvqtiV7MU3POy3kZJdVgLx8WLvXHPetF0YSRv/n1/kI
 CJwP5Fq3joH5yaOu3fSwKhz+7ND54X9fWdLV/seZng7V9HUBu9OhlGTAqrX0lkPOf9gRL9EQ9Tn
 xFR1oZ99vwB3VIpCNhIvY9BCA5Y+1m9Eo6+CA=
X-Received: by 2002:a05:620a:6cc3:b0:915:a5bd:d82b with SMTP id
 af79cd13be357-9161bab53d7mr621111685a.9.1781289037172; 
 Fri, 12 Jun 2026 11:30:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc3:b0:915:a5bd:d82b with SMTP id
 af79cd13be357-9161bab53d7mr621044285a.9.1781289033033; 
 Fri, 12 Jun 2026 11:30:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161fefsm742173e87.8.2026.06.12.11.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:30:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 21:30:17 +0300
Subject: [PATCH v6 7/9] drm/vc4: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-wb-drop-encoder-v6-7-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
In-Reply-To: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WHDRI+JhBcNuBgC+0OtPNMX06wOpYXQsdurLSHRrbWw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqLFA3w2eA8bVTfCfHWtbd+wRuk4WZ7UwSCELFb
 NxOkKpvyhmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaixQNwAKCRCLPIo+Aiko
 1Zs7B/9AUhF9TKQrWA7mEHSfv7WVuiuih1udWVrnH9RNj8QpmTWalWgAaq88xcqtqfZQ1rKIgyi
 0g9nwOMEU8kaWGhLFEbRXwS+0IEmVPcYdrtHtyILGIyAuThnCUQPQ85n5Pyko1tQY4J4AzY5gLx
 BO2pvW2aGpYAwpdiU5sipK7Wk6hcQnmS5tI7hYVq4utxYb761SSAMwC8E562cRt9Eodyi9aba5D
 xjvI7FKExDv/WlhOoJbXDAELkCQwM59yfhR2U+yn9b8sVAoGz9vceb5G8NgGI30BppAUwjAcJrU
 82zcn3Il4qxGFNUlheHmOwHsDcH96KoaQpAjKpqqd+4WzXud
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX89gL1JAjYkzx
 m8swQRxovkniN0bQSHMx711eSSB4NA8jLiNdJRWJihUB8PJKH88obDVyIufWgptBHHd7rsUcbM+
 6NTbewFVMU/CZoVUCb2Zr8YNq3PNXXo=
X-Proofpoint-GUID: oXgYWI8-nqLsd-ST8hLfuerf5berHPwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE3MyBTYWx0ZWRfX+U6C4wiucqUp
 ge/otUgeubTA6kmCdvCvjDoMQg8TunSNwRDuKCy2OziqsL44T+OaaMStQpPTkrv04hLfYKbOUfv
 Rr3rEt9iaBXnPvH5I3I/QXMtyGmX+ItlJBr6euvd+TKwto6zEMfAVDZG04T8w42WOelmrizzKyD
 qZAr2ieRyPRELl/wB7ia51bm2zErXl0xDGbzHE9jGJBRzlxOaT9I9PO62wX4RwHiVNNOWCykHOY
 5vJs/f/OY5Lcnyy5mME0TIGNNKEgEmizl840cJVflVt/x2NLufSIDz+ZC2ILGp8JabnduiooKxy
 nuJpLcCLxNga4z/b35iGE3af99eJIa1Gl040Q9idNiICCOYjJvvdZ7apr8oTlfSsWxVCslNIps0
 Jye846pCc4Akk8ttixBZZGhJeCzQGWBXCqDqlviJZEwuSkBpzEohQtE5hX0aob+de64gqSmP4jj
 pRqCtCakHe4HX9f47sg==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c5050 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=YDDQE0DzCl7hcZedIR8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: oXgYWI8-nqLsd-ST8hLfuerf5berHPwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120173
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/vc4/vc4_txp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 66b6f2acf862..3fd89fccfa10 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -378,7 +378,6 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -602,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drmm_writeback_connector_init(drm, &txp->connector,
+					    &vc4_txp_connector_funcs,
+					    encoder,
+					    drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 

-- 
2.47.3


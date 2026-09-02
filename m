Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF843C624DA
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D3010F33A;
	Wed,  2 Sep 2026 20:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ow90BtAB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e+tqQt3k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FB510F33A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:17:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHCWN2796917
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OK2sFiDhiyR
 A3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=; b=Ow90BtABdKWP8vEEbn7t954tODk
 ed5Gq2vRHg44uxceRgHe+MUJEVNrD99ap0s+2bZYF6XW4NoSCd8zgBNC5nAGSu4p
 BEjjuyFQtErp+hmYy3jBNHnfMce3vvAkcX+esB7Sb/tXiw2X9y4cjF6SKw3DLHZD
 LjpyC1/OTGudejH2Z3Clr5w1WRSCPAn61zsEKZHauIL3buq1FRd2S88QjK27Cv27
 QKMF5hjaKuQhKS+hftXVD8l5aYHH2MT/ANXSyoK6bRvttvI/SpMvtlbBDv7W1Df+
 7juJZTuSyv1yUuJ1cMkdiFnI+aJnGWEGzf5C9bKdKtLgWIthSu091fT0WCg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh9qbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:17:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so432092a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380263; x=1788985063;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OK2sFiDhiyRA3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=;
 b=e+tqQt3kD0XVL+LXgstwiVMtl4q/CoRPQPnwgQUVcQmLN5pzwEKSDOYaei54u3PrJ/
 UEyHdYmeWsv8V57EEvVuuPJnMMpenHpN7tunUI8CSN7yucDnwTodO5Fm0JM9DQkr8f+W
 ruk0CdrL3w/rrDTGOU6P2eBbFfnyLi2J3TzTFwd71ofU8w9FSjubuHtlqE5+/0cSb/U/
 iXJLfcwinpCcKzr6qJt4+quIJdU4E0If3Or2Q+Faxzr2wZrW6/Oiy8ih1dHjRJZ/NyxZ
 NiD4IlynYKvt8zEjz6i4+StaxCdfkQ4pY4XxdT6BwXSwypLrlUUCiD97us0iWxg2sDvb
 EJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380263; x=1788985063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OK2sFiDhiyRA3ApBDHP+/4IoRs1xWNu0WL+tMPWx2xw=;
 b=GLh1nOo3RKqqwgUoTerXDLMsWvMcZuRKyG49XDU48p9Zu4W11z8VFWKzZldrjqz4+X
 ntisI5LwJIbj45qeJVR1yr+lf7y7eISnfdVLamnVLGa36JfqtYS2MzGjLNT75k2KGXj6
 CjCqKAAqlMHcNATAZWqvP2DCJKGHWMiFxj+uW3rsZ7kL6KxJWGy6ChRXTPs0AEkjy3tG
 VLSyEEX1EXU/ZFoz8FZc/PWPbwm5cnLFDbPev9ThiMWG0jn05L8euiDSRrth6GwABJn5
 nHsVy0kr5HgWfh7X0eTBdwSMbUrGKTZQ/UTPHSJuIuv639bLskcUvu+Q1g7fQMNEpVVt
 2g3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiDD8+qmh8Lh0KOJua/Mjs039FvjoUhkIvsYoijHqA9N2sOEuDtAuzS8ob0hVhSOihrROybDICaBY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n58bhrzTTWyQLNa3hinhUsiLx1vU9DKsHadk53LJA58C8/MGEi
 A/7w0zIiIoU2u+o1pVhZ9eBiz/OjMYZgFWe/uV4QAhofgY0NGcTwm/KgI1RjhIZd135iGuP46AN
 WzRpI/kqqfnMytVVAG7fpad6UCSfJ0uLzrhSqINup5xUZl0XqATlvhvSfpYTqQAMNQNmqHag=
X-Gm-Gg: AYBFou1H7cg+806KUqqAgIywUKWWV6Xu5cZXgetiqPAUOdMRNshU8RofWtDDKfjsFkq
 vAA59mr+dwaYvufaanCIi+PGuybsQw1/3FGISACzXxS1uleF7DhEUvNa3tC2S5K2TN0i0QZPiJE
 2u91f3S1tgl/vTyMRM03D1X17vap9/28u6COEQHDi8wHQc0W0tLvZqRD9/qHTasXZVvl/0him3u
 VGjRnQiUqWwm/j/o1it7jT2FAUT1Phjb/OOYsfhiZ5nwlg/Cjqehx4zlxY8AXwtpIoEL6usLkRQ
 NZ136zK6YPX6lVjB5N37YowpsjVoLAZWW7AjtViEz+nspBkHH9GRLPVBsF7gRA0KDJLsS1mhmGd
 yRYwIr/fMQKls7vTo7/5qTyonWTA=
X-Received: by 2002:a17:90b:5804:b0:398:9beb:a2b6 with SMTP id
 98e67ed59e1d1-39b087e4c2fmr1678966a91.24.1788380262980; 
 Wed, 02 Sep 2026 13:17:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5804:b0:398:9beb:a2b6 with SMTP id
 98e67ed59e1d1-39b087e4c2fmr1678920a91.24.1788380262507; 
 Wed, 02 Sep 2026 13:17:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:17:42 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 6/11] drm: ingenic: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:35 +0530
Message-ID: <20260902201640.2024648-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EG3cVIWAI0BL-UzIRIoHCvgpq5X3MAVA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX1MIV40iZsUNo
 K0OQFAmg+Ws1LZd+aKLPMxCOq3rCa9g7+NU4q0JMYbkeC2VuUXEJlp6GpcMBeALbX7hPvmMw/8Z
 Lnb6DUf9G4V3oBUVGq4se3ZknUWXhFiaeNWvovqW/5qm7XBT+XZvNKo+SohiJUTqa1cjGt4DC1c
 g0OnVE9MvxE+W9uppiPBnTXqt66GKE6Btqb22G739rj+lFcnVgCP9hVPzwpAnNh9M5rrTHhHVPB
 RzI4ikVD5LDZW+SitauLsp8+9iT5xLRgPrc3LPytVIhwarEWxkN/6s/OdcvN+FTozWC2Fcj39c7
 up0kYH1Nda4EzesU+hipIhNSpvD8IMj3pdCcw5/yFhtfmdVh2JdjBloyTLrWrWL+Uad94iUeWg/
 e/jX5EeHd4gE+v0vS8JVFcS2UTuP8WN5EBgRj9izy/KA/GfUTj65vu8CSeS0ZjOZWg2kMHlmHEO
 d3RA9JyBQmHcnswQcdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX9NH46AhtD7ho
 ClFojyGh4u3kkJqWUurP7uHAXveRTwQZtdtXdOanweLGAweq0BPNin6alyOCvRf+gvQcsQ/9SLL
 lNmg83eLYbHx6HfQzdS9sY+6xFhpwRk=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a988468 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=ER_8r6IbAAAA:8
 a=EUspDBNiAAAA:8 a=iWCwWg-Lr60CcT_aNAIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=9LHmKk7ezEChjTCyhBa9:22
X-Proofpoint-ORIG-GUID: EG3cVIWAI0BL-UzIRIoHCvgpq5X3MAVA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179
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

Replace the hand-rolled devm wrapper (ingenic_drm_release_rmem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource
manager handle cleanup automatically.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 738a80b2550f..2c4dd6ed2d41 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1060,11 +1060,6 @@ static void ingenic_drm_unbind_all(void *d)
 	component_unbind_all(priv->dev, &priv->drm);
 }
 
-static void __maybe_unused ingenic_drm_release_rmem(void *d)
-{
-	of_reserved_mem_device_release(d);
-}
-
 static void ingenic_drm_configure_hwdesc(struct ingenic_drm *priv,
 					 unsigned int hwdesc,
 					 unsigned int next_hwdesc, u32 id)
@@ -1127,16 +1122,10 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	}
 
 	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 
 		if (ret && ret != -ENODEV)
 			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
-
-		if (!ret) {
-			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
-			if (ret)
-				return ret;
-		}
 	}
 
 	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
-- 
2.55.0


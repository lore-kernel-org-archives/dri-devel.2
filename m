Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F20C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3502410EF9C;
	Thu, 20 Aug 2026 10:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B247ZTZ4";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46BE910EF76
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:56:18 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1712100a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787216178; x=1787820978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yw9jNsYyc4cRvafqBjufXAIHcED5B6eFEUJV+Hv3PVA=;
 b=B247ZTZ48KyJMwAHk4Ixf7x35T3I9f2yQI1Hg9sIaTGX39h8dN660Ygeug9ZxD2oQe
 bBiVVHu4/CrpKVJ/7cedtObebJ4PfCNRacjxRdc8Lj1ZnvgsxlqNjceumThb0/XdS1TZ
 xbL74adPqncdg+ygyWoAA6oAL+yOFGP/T5E7yc/NFbmU3lU/NKE4HMAjMQhTzYWlGGKM
 MpJGXp3TzLaZhJl3pU1xEChcMsLMjPI0UGHqHI5BeLJUadXN5NpPjUx5EEToQYbxtuZQ
 vJxVUg5aUEhed0FpgWtlgiP1qehengQ6IG8Mb/MSK+PUEulBdgLHePNYudE85Ly6nnj1
 yOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787216178; x=1787820978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yw9jNsYyc4cRvafqBjufXAIHcED5B6eFEUJV+Hv3PVA=;
 b=NBlDsMkM+C9HU2VLMJGt0QlGPD2o16/rRol5mFowkqYnLSrPXuwgVRnGfYd2hRMMyH
 doh4lq8Qf709TZKfAeEM5Mf9FjeGLLbRzawBLzX3h5ABUD2Cvvah8FNkHQnjwxAExCDV
 B+QAdvKmWyAzZtMW2zqk87mmE6kfzgdSvS07Ow+Nu8O/25HaaZWgn8DGFzxOLMVnqXPG
 OJnRIU5A643247MyT3S1IeJc7oViwjzws1MWm7A0KpcroyVIZlBoR47KNr/FduAfOm2o
 fUi0u5ZPLoZGi/ytJL3XR5vwm6zvcv9XhMq+OfuirkrNFMsxP8mJYoRR9VEcfkbPD/ex
 SLhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RohkFmCQvnsWaeSXc+/BSTH7vE51cyPOVxeN4B5bSnsgd4dHcMz46l+Aoq8PhFB0g7c/WVqgcQBO98=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQPtLbSE8Auz2mDAon+9WuaIEK6PyNbzmS4F12N2+oOGnnVKGi
 JVCGl2HZ3Q5PbmPltYp0QKgV2BtSKxZYH51yu/ooAfjUDdnmbJvQdsg=
X-Gm-Gg: AR+sD10jZ1zwhdq4Lpc8eNOI+aG17wo2TstwNEV7x2iv2/Bl6HDPcRsGA5lsCDYBx9E
 LR3GPtlkoxFKiXbI60p8iA0DUJziNE1bACJyycuEfglwQpzP5GEQGUl9pihcp3P5I1/rZjW15IK
 f0ZHJKrcq6Gwa71npO/hLiBiO8Wr3zxQY/Dfw1rWf/InCcpUVB0RIxlFxSaKP6ScdOrcj7XRmgb
 dwjbuYvxecEalmS/eX0omIju+8+fW4xEiNTHXuWQm4xvU2eF6YJFi+PCX/9C8FTwjF1vWllLqDt
 8Tx2DmtegLjagXEMdXXqCRLNVFZaWmcgLTIIoLIhg1dg27ulCcLgiieJAUNY4gWoXrBB4A7vQyt
 PhwQovouJajccHt0L8Z8Wf7RJ7bJKPMO48SSdFbmBWN5rZBC1Fl3Lzkoh43bLfde+h5qFeawtiv
 9rC8BqixwQdjTDGUdSDPBtJP7x6I5KWug3dYrI4XaULNyN0D0NU74DK6oqi192FktuYM5wVN7tg
 w==
X-Received: by 2002:a17:90b:2d05:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39581470f03mr21556025a91.14.1787216177652; 
 Thu, 20 Aug 2026 01:56:17 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957faf6849sm5701831a91.10.2026.08.20.01.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:56:17 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/mediatek: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 15:56:09 +0700
Message-ID: <20260820085609.2103835-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 10:07:27 +0000
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

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index ffe456238a2b..a2acb2d9742e 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1412,7 +1412,7 @@ static const struct hdmi_codec_ops mtk_hdmi_v2_audio_codec_ops = {
 	.hook_plugged_cb = mtk_hdmi_v2_audio_hook_plugged_cb,
 };
 
-static __maybe_unused int mtk_hdmi_v2_suspend(struct device *dev)
+static int mtk_hdmi_v2_suspend(struct device *dev)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
@@ -1421,14 +1421,14 @@ static __maybe_unused int mtk_hdmi_v2_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int mtk_hdmi_v2_resume(struct device *dev)
+static int mtk_hdmi_v2_resume(struct device *dev)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
 
 	return mtk_hdmi_v2_enable(hdmi);
 }
 
-static SIMPLE_DEV_PM_OPS(mtk_hdmi_v2_pm_ops, mtk_hdmi_v2_suspend, mtk_hdmi_v2_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mtk_hdmi_v2_pm_ops, mtk_hdmi_v2_suspend, mtk_hdmi_v2_resume);
 
 static const struct mtk_hdmi_ver_conf mtk_hdmi_conf_v2 = {
 	.bridge_funcs = &mtk_v2_hdmi_bridge_funcs,
@@ -1511,7 +1511,7 @@ static struct platform_driver mtk_hdmi_v2_driver = {
 	.driver = {
 		.name = "mediatek-drm-hdmi-v2",
 		.of_match_table = mtk_drm_hdmi_v2_of_ids,
-		.pm = &mtk_hdmi_v2_pm_ops,
+		.pm = pm_sleep_ptr(&mtk_hdmi_v2_pm_ops),
 	},
 };
 module_platform_driver(mtk_hdmi_v2_driver);
-- 
2.53.0


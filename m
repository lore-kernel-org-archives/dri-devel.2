Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060060A2613
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QApUcuR+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CE010F243;
	Mon, 16 Nov 2026 15:10:52 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BB910EF82
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:44 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c50a2efbe1dso565655966b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841842; x=1795446642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mbvLcy9HUv2G6MMG8rNmvtC6ROCR4D1d+RS6v72Z6yA=;
 b=QApUcuR+LpJGEYASz21EGVv8gCzx/l/o6KVujrei+PraCM5oClSLpLrpsx3nZplUT6
 ZHZovKTtWoDErWiny9rN9KSQzZvDuPrGTD5VciMnJfsbcop/Ty5TxzdoMHNF/MNsNWFq
 J6g/oVbg7KSzYGw8FbQzv01VjQseMQe4vhW/NIEox9NSgm2VH9lG8P+LMW7OB2zE1/Bc
 vGBFauOSQ2hGxZ8Nrso0Lwb2yDb0+Idi4gTzH+UZdi+BjvF73VUHjB8cEmudGx78D0CF
 yAvWb8TMSaCa7FPssCtUm0MaF5UcHHskcGrcALlkeyrb+toF6UGXDf9kWmIs5ZpWqA0V
 SZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841842; x=1795446642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mbvLcy9HUv2G6MMG8rNmvtC6ROCR4D1d+RS6v72Z6yA=;
 b=AMtIJLg8vScmms+Sx8lyH9NCOBPQ+l65xwdPtsrG1LRP1uJR/2g9b+zdgVCiCYdkDU
 o72Xvr0Q18bbLJHqG2ODgtU2yR4OnjLEu4hrJzgPKfCQY+hZsv1EgYP9wi2kE2qEneEm
 TXjfl6AkFq+Z9ry9yI8QSE7nCeIu1DHuhnHDsvOdK4sGtvZsjE4uTCfr+6ziwTmhD18b
 T28LPDwQ9n8x6ZrPk4RZzYPtAfEnBwKSoLeZ99A8xBAoFHLpBB+5xAL72K68KzKiTYFq
 XvQJa0VkreuehO+2mGFj+gPCmh4QvRmweztSDsEQVq9bn8PEKjik30ZF3ek2+YjYu2to
 chig==
X-Gm-Message-State: APuU4Z8IcKU9DDhIZViKiBwjLfcrEV6VojhSWMQoLyuiC2Uf8Sol7vbx
 30Q/mXCAmBX+P60YE/Bz0PxNtTJJeq8O7zI1bG43x5ZPFkQv7tSUV28H
X-Gm-Gg: AYBFou2jKV78fMGoxD04b+zg4s14Bc9AtaAXV+l9wvaA0SI0YrCfsgQzxQ/3AlH51cd
 cHnt+mbYuU6GeWuWzmSGb655K1tJDXA409gNzhIKq6tNA9G45PA4X6ObiTuGpd7+weaWL8t8dAd
 oijDfNlT2phxpsOqHnQ9rzhvQAtAFNBW7RKod1IquNmSOX6A1uPh2ykdGJjIpHGBOmFUn83nQt4
 azeYK1CsDJbtPAMaaMC6uxYmOqx6VbvHhPMmSJghde0pkG++5nn49yVl02qKEft77msE+hEGBwQ
 RLSVBBzpvN6/e3vET1e1uPYpgmk31fB8Y0I7A50J7GHQDP6rJbpZVwyWZx+JaZVS9MbQNmGDQhg
 1UaMiZGDJQV8u/qxdaMtoy6kbWNODPo5GCd60S1RTT6GstuPuQXuSRRQa7XDpuvfa2qincdgzRR
 J9kFcg8jFpMmPNRWJpY2AJuWm7mJUfAQC5NgxACY3CmBBosW0vMMrv1xhbgfjv09aKRGrZJAq6V
 5xpretuWUq4+oRepMR2Cw7VIo+gLIBrShouKPVbrsC8l5KYPjRuBoOmmjOjPkICQ5THINxYcXy3
 CjHopVde4MRVSRyjuYXKLOhqO1jjkCXNRTvGFEv8/lvwxYJwApGtJBOTy+VtrlurYylQOChfJ/l
 1Z9rWmXycdvc=
X-Received: by 2002:a17:907:8686:b0:c40:b59:1b with SMTP id
 a640c23a62f3a-c5096389f41mr846550366b.44.1794841842225; 
 Mon, 16 Nov 2026 07:10:42 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:41 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/12] drm/panel: panel-lg-lh400wv3: Drop redundant
 disable() operation
Date: Mon, 16 Nov 2026 17:10:10 +0200
Message-ID: <20261116151017.274764-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116151017.274764-1-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Squash the disable() and unprepare() functions, since there is no need for
host adjustments between them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
index 63efeb434be13..c6834e5312089 100644
--- a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
+++ b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
@@ -115,7 +115,7 @@ static int lg_lh400wv3_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static int lg_lh400wv3_disable(struct drm_panel *panel)
+static int lg_lh400wv3_unprepare(struct drm_panel *panel)
 {
 	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
 
@@ -126,13 +126,6 @@ static int lg_lh400wv3_disable(struct drm_panel *panel)
 	panel_dbi_command(priv, 0xc1, 0x01);
 	usleep_range(10000, 11000);
 
-	return 0;
-}
-
-static int lg_lh400wv3_unprepare(struct drm_panel *panel)
-{
-	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
-
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(lg_lh400wv3_supplies), priv->supplies);
 
@@ -175,7 +168,6 @@ static int lg_lh400wv3_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs lg_lh400wv3_panel_funcs = {
 	.prepare = lg_lh400wv3_prepare,
 	.enable = lg_lh400wv3_enable,
-	.disable = lg_lh400wv3_disable,
 	.unprepare = lg_lh400wv3_unprepare,
 	.get_modes = lg_lh400wv3_get_modes,
 };
-- 
2.53.0


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2551606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgB3i4uQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C0610EDFF;
	Mon, 16 Nov 2026 10:32:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4B110ED7C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5D6E43BB3;
 Mon, 16 Nov 2026 10:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1761F000CB;
 Mon, 16 Nov 2026 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825112;
 bh=aySVLXyxIk33FwYFAk7LQLwzaVdzkKRtu2if9A/L9ok=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RgB3i4uQkJ3RQWm31pjW811nDPYI3cjVornEAv+sghs1J0ux++SAinOvLcap8QvnQ
 IKk2Rwlz7WSAuGm6YLjszH4qYAcEUgIbfljIu9d4KhYnCPU1qs2ooSVobO5TAiZxPB
 XjItr5MMCBsdV0wvaotGkalgfsp/IkR4Yof6aDr+kQhzC0xUjQVRn87nK3/9GfMt46
 yQW6LUCNAbdaDrv6ewYyEyn6MRctEXjhIonYCQmVo42mivukwNeSqWXYAGhOsQJkoZ
 bgzy5CTD0ZnWJ2NfE8O6Qf3dX0CErNwMva7+GnmI7d+ECwDdqg9tH8MMaTDpsrm09w
 Nj6LX4lY4s0IA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:33 +0100
Subject: [PATCH v2 17/64] drm/loongson: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-17-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dBkv84uwpX7o1nb3aIBi1Dlq1zvFc72jWkyIc0luvLo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brtfjG/c1P1r61pNW1H5PfMPX+7bfOQm1/3ElUoHL
 /jer/n9qGMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMpO4OY8PE6J8pLxTvzBG6
 /Drl9UyP40bb3m/3ls+xSr/REqWodu6Qqnjsn/SlLTvPG6hMjPyy7ypjfeL1ioAlhUFRyZkXVG/
 fb/oavv6p+b9W2Wab5Wsi56+YtXlPf+gpU36rL/mbjq/Id72lBwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Jianmin Lv <lvjianmin@loongson.cn>
Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Qianhai Wu <wuqianhai@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/loongson/lsdc_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 5a13df31eb90..fbb2658acce4 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -245,11 +245,13 @@ lsdc_create_device(struct pci_dev *pdev,
 	ret = lsdc_modeset_init(ldev, descp->num_of_crtc, descp->funcs,
 				loongson_vblank);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return ldev;
 }
 
 /* For multiple GPU driver instance co-exixt in the system */

-- 
2.56.1


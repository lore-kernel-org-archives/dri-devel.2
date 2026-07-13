Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE56C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D243810EB43;
	Mon, 13 Jul 2026 22:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.b="ZstIlkRU";
	dkim-atps=neutral
X-Greylist: delayed 544 seconds by postgrey-1.36 at gabe;
 Mon, 13 Jul 2026 18:02:04 UTC
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru
 [37.230.196.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CBF10E3E1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
 s=mail; t=1783965174;
 bh=qTFbrJO1EIURj5coHE7P8jfs+T3R57WvmR8hoGJitbA=;
 h=From:To:Cc:Subject:Date:From;
 b=ZstIlkRUUKnGElVKoX+VXKqW/ZCcdaYL9K0C8NptQI04CCWLg6skHvRWVwN4hvVxw
 AtXlTUkZjwuPyrLHyraOorUqq5fARQKq/PnNvJt9zSsZK2M+/aXVEVPJ0XoK6BGmut
 fbx4LSUyDm1xYXVuiOwgrtbR+3RM9zt10s92N8R12vO9qGClVWHBk9uepx9ePWDhaF
 alyGrQOA8GiThkO9E8ejQqkrAiSU9wKy6C1QuicS/Okg682M3/HKtz3Dr9MUIHofQm
 tDbUAzMe3NvxBo+RJH3Vyn8SiCy/Hx9Y4GYahgQCrGeNCJAKXnBvqsQm8bQh0iqnBn
 k+LoE3rhl85Mw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw01.astralinux.ru (Postfix) with ESMTP id 934B425596;
 Mon, 13 Jul 2026 20:52:54 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
 Mon, 13 Jul 2026 20:52:50 +0300 (MSK)
Received: from rbta-spb-lt-115149.astralinux.ru
 (rbta-spb-lt-115149.astralinux.ru [10.198.24.8])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gzVQT3vP9z4lNf;
 Mon, 13 Jul 2026 20:52:49 +0300 (MSK)
From: Elizaveta Tereshkina <etereshkina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizaveta Tereshkina <etereshkina@astralinux.ru>,
 Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 5.10/5.15] drm/sun4i: backend: fix error pointer dereference
Date: Mon, 13 Jul 2026 20:52:37 +0300
Message-Id: <20260713175238.715526-1-etereshkina@astralinux.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/07/13 17:19:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: etereshkina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 112 0.3.112
 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec, {Tracking_ml_letters},
 {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_internal2},
 {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;
 127.0.0.199:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 astralinux.ru:7.1.1; new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204404 [Jul 13 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2026/07/13 15:36:00 #28439953
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/07/13 17:19:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

From: Ethan Tidmore <ethantidmore06@gmail.com>

commit 06277983eca4a31d3c2114fa33d99a6e82484b11 upstream.

The function drm_atomic_get_plane_state() can return an error pointer
and is not checked for it. Add error pointer check.

Detected by Smatch:
drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
'plane_state' dereferencing possible ERR_PTR()

Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
---
Backport fix for CVE-2026-53066
 drivers/gpu/drm/sun4i/sun4i_backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index d935f36a24dd..b3741827c6c3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -507,6 +507,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
 		struct drm_plane_state *plane_state =
 			drm_atomic_get_plane_state(state, plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
 		struct sun4i_layer_state *layer_state =
 			state_to_sun4i_layer_state(plane_state);
 		struct drm_framebuffer *fb = plane_state->fb;
-- 
2.39.2


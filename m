Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADC7F013FA
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDBB10E195;
	Mon, 16 Mar 2026 21:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FhWRu9qz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3104010E195
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 21:59:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 14DB441910;
 Mon, 16 Mar 2026 21:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A186C19421;
 Mon, 16 Mar 2026 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773698366;
 bh=ZEi8YvdWHzQjH0SsQ2N40nefvfuZZe4kcpLiAZSqMyo=;
 h=From:To:Cc:Subject:Date:From;
 b=FhWRu9qzB2tH2AERKglm7h9vPaXpOtMXtQ0KSQrhGdW40UBcTgXEKjoeBKT8WhuV8
 fmjA9+qQ952MTLStnq6pOO5vkRRR+KDfUiIhLNis8aSz84BpSis7/7GV4ln+HhFYuU
 ryd3teJFq8Efz+JijTNmhZy67khoABN7ZEeNV9HVlYk2Fg/As3AVKrdREUCuvwBy7f
 DoYbkGMRttO+0eTeytO+Mdc+m8crPpWCAl6shd1YPg7jkRTcgtA7QrfXW6ZQlcVKWK
 drUj1OTiYoW9IQyVqNRw317ZiW6v4wy1NA29f7DtiNX4YzhbZwF0Rdu1a5mGghvErd
 I60Uhg8fraU0g==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: lt8713sx: avoid 64-bit division
Date: Mon, 16 Mar 2026 22:56:32 +0100
Message-Id: <20260316215920.1993390-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit kernels, 64-bit integers cannot be passed to the division operator:

ld.lld-22: error: undefined symbol: __aeabi_uldivmod
>>> referenced by lontium-lt8713sx.c
>>>               drivers/gpu/drm/bridge/lontium-lt8713sx.o:(lt8713sx_firmware_store) in archive vmlinux.a

Since this is a constant number used to divide a size_t, just change the type
to that as well.

Fixes: 4037c6adc1f9 ("drm/bridge: add support for lontium lt8713sx bridge driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/lontium-lt8713sx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8713sx.c b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
index a8ae38c84719..18fac6a46db4 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8713sx.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
@@ -100,7 +100,7 @@ static void lt8713sx_i2c_disable(struct lt8713sx *lt8713sx)
 static int lt8713sx_prepare_firmware_data(struct lt8713sx *lt8713sx)
 {
 	int ret = 0;
-	u64 sz_12k = 12 * SZ_1K;
+	size_t sz_12k = 12 * SZ_1K;
 
 	ret = request_firmware(&lt8713sx->fw, FW_FILE, lt8713sx->dev);
 	if (ret < 0) {
-- 
2.39.5


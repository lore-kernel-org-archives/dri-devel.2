Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6C606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpqZ0/XE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F0110E046;
	Sun, 15 Nov 2026 08:49:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF57010E046
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 08:49:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27D854392C;
 Sun, 15 Nov 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794732557;
 b=boqvfHsThvZVyYibacBhO1YrtuGRNyunVmpI1+GLV3N5leKZ86lg68/AVg0eBkE5EpOv
 oY4QBiKPCXrWBCdWy4TSsvGb42aOkgo4vkn7sT11ObCNa/KvJt8uuASLREqNQ63ST+S3l
 XGZaouhSWwsZfoy37cc61JmjYSreK/l3GhfgmRwdpsJCXFNDeMeDOFrXXDluEbBcqueZ1
 ZVfXPfV4trN9AlsUq6yBCuXvwk1GhYeOWsy/IjRr2OI6LracWqTDsIQHoo8WWMRG8ewnt
 z0guR2UQ76zPNyiNDFFLOBUN2xsgBaCph/dSi75XL0OTY1NwdjHpKS11CtrICtI0uaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794732557;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Th68mQt9KjboqzFUfG6n2gxnCDTInTK8JGxyN+AwcXo=;
 b=b3V+Q93mA9q+BkZDqJFPD03tdIXmALA1h6TwAr3inPCeAtMQ3b59XHIvbTzl4YWuIqoE
 FVBoo4hUGdyGleBkjKQHV1Ugma/29lDtcFbtWqelneUiWu60H48LLSXKZXb6tTWy7P4ZP
 +JLqyfeCSzWq8qZXqBA73PpZz2fhDZl9flLvmXS7bC3uS33iOJLEImaHQeWtjqoKwXPCm
 JvlwTACbJ837+Qz9zpoqRbYtXqXtmGJQSQ42h5TzP2LEeFCtijZ5ZUt85URGtTtxWWdHd
 B2SZ3D9xX3QgW6pJurNI6S862FO5l7OCa8j07XWrlCaJVk9EaV8UtRMnEwrywXCa1NQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4763C1F000C6;
 Sun, 15 Nov 2026 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794732557;
 bh=Th68mQt9KjboqzFUfG6n2gxnCDTInTK8JGxyN+AwcXo=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=dpqZ0/XE2eGod2aMDqwqkN1pvcqOdc0QN0Zab5xL+o4INHUYftGlvi+3Wu3HmTlyH
 r7Hs/5pcZyxjO+Otm+p0FbEzSgQ/oxzRC4pywXWhQt2R3lFYDVPykw0ha68pywsdpZ
 0ClKfvsj/8uBbEanGsNT9kzKLHvS3rqCBkW2aJ2ZgySQq/9t/oxYltSEvmNtTFNNeo
 XWbILPN2S2er9tiYnpDtXRCEhlgPc4tNl9DeR7BozPSHcB9hq93D9trWXOb0b6OoL/
 9+BVNftkdbzGtXkMwmv1ZQJiZtJ5eEGknyBKndGmkrRb6upDGsS9NFT+vP088NMTQj
 igXQMjWZoH7Pw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BC02149FEA;
 Sun, 15 Nov 2026 08:49:15 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:49:15 +0000
Subject: [PATCH v3] drm/bridge: Fail an unsatisfiable bus format
 negotiation with -EINVAL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-drm-bridge-busfmt-einval-v3-1-ab38616d6135@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Nyw6CMBBFf4V0bU2nrfhY+R/GBX0AYyiYFhoN4
 d9tccPKuDyZO+fMJFiPNpBLMRNvIwYc+gRiVxDdVn1jKZrEhDNeAgCjxjuqPJp0UVOo3Ugt9rH
 qKNf6pIQBJs+CpPentzW+VvXt/uUwqYfVY/blRYthHPx7bUfIuz8yEShQnSJSGS54Ka+Nq7Db6
 8GRnIl8K4IfIp5EtVJHeWaHEqTaipZl+QCHQoFpGwEAAA==
X-Change-ID: 20261110-drm-bridge-busfmt-einval-2cc8b3d10493
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794732555; l=2445;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=wDXeQt9euA8I+/3t45VeI1f/YvX4GBH9rBxqF2WJVaY=;
 b=DYQVDCJ5ppn7LVbkF62hmMtueR/ast2YyZseZIpyOAfxSFZ+ZZp/me3meaoXZI8p8lH7Sn9rg
 QUXTgKPXV3yDUEoOnrUNcQV4SCFb078jHL9BxsuAupqrTT7/s0tLsbi
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

If no bus format chain fits, drm_atomic_bridge_chain_check() passes
-ENOTSUPP from the negotiation to userspace. Return -EINVAL instead and
update the KUnit test that expects -ENOTSUPP.

Fixes: f32df58acc68 ("drm/bridge: Add the necessary bits to support bus format negotiation")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested with the drm KUnit tests (UML).
Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed it.
---
Changes in v3:
- Shorter commit message, without the DW DP example (Nicolas Frattaroli)
- Drop the code comment
- Link to v2: https://patch.msgid.link/20261111-drm-bridge-busfmt-einval-v2-1-fbb74905614b@gmail.com

Changes in v2:
- Make drm_test_bridge_rgb_yuv_no_path() expect -EINVAL (Sashiko)
- Add the Fixes tag (Sashiko)
- Cc Nicolas Frattaroli and Boris Brezillon
- Link to v1: https://patch.msgid.link/20261110-drm-bridge-busfmt-einval-v1-1-c0494bd23264@gmail.com
---
 drivers/gpu/drm/drm_bridge.c            | 6 ++++++
 drivers/gpu/drm/tests/drm_bridge_test.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8ae2f9b1db44..33120cc7f982 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1437,6 +1437,12 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 
 	ret = drm_atomic_bridge_chain_select_bus_fmts(bridge, crtc_state,
 						      conn_state);
+	if (ret == -ENOTSUPP) {
+		drm_dbg_atomic(bridge->dev,
+			       "[ENCODER:%d:%s] no bus format chain found\n",
+			       bridge->encoder->base.id, bridge->encoder->name);
+		return -EINVAL;
+	}
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..792dbd035501 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -1351,7 +1351,7 @@ static void drm_test_bridge_rgb_yuv_no_path(struct kunit *test)
 		drm_modeset_backoff(&ctx);
 		goto retry_commit;
 	}
-	KUNIT_EXPECT_EQ(test, ret, -ENOTSUPP);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);

---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-drm-bridge-busfmt-einval-2cc8b3d10493

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E16CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F16210F5B4;
	Fri, 19 Jun 2026 12:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OwxfFZ6A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF12910F5AF
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:28:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51189601F3;
 Fri, 19 Jun 2026 12:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D01F00A3A;
 Fri, 19 Jun 2026 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872094;
 bh=5iIJ6mvhTa5QGl929yvaZZruvKRKGYpwHp7xczJvC1M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OwxfFZ6ACV1ykLQ5g5oYt0A7l5Xb+gVETGx4uNWJ7LcRlDBytJGbatjC7py1+ingY
 GLhK7EXKSV9tzERtMG/wOmnqjY0TbdHZy8wVg2t09wJZzSjSnum8xOzEkiOawsdKFq
 6JOVzzf/3AvrssXUWDNO9wedfPjpBw77nSyg/KIdbMegOjbTFoWwqSa5eyuOQlmGxG
 hEoUGT+zSnQWoyHv/QlZZ++yc/qQyEz4kBp+MO9U4a2JnGa1MJqeQZhTznGDXcH+Qd
 Rg38NHeo4tDK5w6UKLNAp8ksLxNCq6I2dvfEcvEa4xkOH55KiOeSw8DUUoUsfCnc1e
 IosBuOrXb9N5w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:22 +0200
Subject: [PATCH v3 77/78] drm/bridge: cdns-mhdp8546: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-77-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pJiuAEhqIWfYCVUBPUSYONOAsKvXz/zc2HJ5Z5HZQC8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmptwKsttlfxxpT+p12zv7jMSF5l+VD1xYVYxUqzbKF
 55xkpvdMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYi9pex4bjM7OtznZvYtnvk
 Tfs3waticpeCrkVaaGTGh3msNav0lzwz7Db/O+/qyTDLfzqNC7iUGRtux74JZXyWeXk3y8c4J8M
 vFy/kLqnxXJOw8czbndcfisp+i5RZ1FcUcGzl/9rDGY6hLxkB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The cdns-mhdp8546 bridge atomic_reset implementation is semantically
an atomic_create_state: it allocates and initializes a pristine state
without side effects.

Switch to the atomic_create_state callback, and rename the function
accordingly.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index b9574289c247..504a3186ebb3 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1919,11 +1919,11 @@ cdns_mhdp_bridge_atomic_destroy_state(struct drm_bridge *bridge,
 
 	kfree(cdns_mhdp_state);
 }
 
 static struct drm_bridge_state *
-cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
+cdns_mhdp_bridge_atomic_create_state(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_bridge_state *cdns_mhdp_state;
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
@@ -2049,11 +2049,11 @@ static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
 	.atomic_check = cdns_mhdp_atomic_check,
 	.attach = cdns_mhdp_attach,
 	.detach = cdns_mhdp_detach,
 	.atomic_duplicate_state = cdns_mhdp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = cdns_mhdp_bridge_atomic_destroy_state,
-	.atomic_reset = cdns_mhdp_bridge_atomic_reset,
+	.atomic_create_state = cdns_mhdp_bridge_atomic_create_state,
 	.atomic_get_input_bus_fmts = cdns_mhdp_get_input_bus_fmts,
 	.detect = cdns_mhdp_bridge_detect,
 	.edid_read = cdns_mhdp_bridge_edid_read,
 	.hpd_enable = cdns_mhdp_bridge_hpd_enable,
 	.hpd_disable = cdns_mhdp_bridge_hpd_disable,

-- 
2.54.0


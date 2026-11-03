Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5C606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKAQ5ip9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5C910F813;
	Tue,  3 Nov 2026 20:03:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0371710F80D;
 Tue,  3 Nov 2026 20:02:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9E1F43FF0;
 Tue,  3 Nov 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793736174;
 b=Hr/QKtchQJ3tKQApmySCI92/Acwb/epx2HRgq3muHf6XnyX0hsUinBkSR/cGZz93D41J
 ZNsJfkk59LESMAR9/9T2EmsXpoZo7O1u6rnohadFW25gY2glOtyNO2fEyoby5fFu5LjF1
 LIfj4DfedisJSFBtm00vgAiRIh/lcXTq2Jl6GQl43Np0JjQQYArVkfg8+BEP1f3+yE2qD
 xK7Y8jYep0g/77E1hfVVs4hKkQ7pqFFemrHzW/3ccO5cvbk6nJWQXXtUmQWfpOvYj2P/V
 J1GMDZqsNaDsPHlLe2XBK5QUSXdjGPjzeYyoT+23mNgY0VeeNZCcaGRMFKp4hEsOUIA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793736174;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=5/pn7fTfQxc1qaaKnW5Xmu4Vd/rwN8kHgyZ0qJMPbMs=;
 b=Hdx7D1b5ZCWWnEV8KGObUXTZp7cuZ3G14HdKcYgChIgLmuWUTWR0j/2AQJXaUalPok3D
 WstOMceQLImsNunS0m/RvcewtVz6Wn3ED4bCEIlxi5kaJwLs63EvT3061KyF5QAef4UXW
 iwrf3Ib+5sYKIl3wxTWItVI6dvm8GOaugXdYC4Qb7rZmETn3tJqvKMczaeZ6SzGQY1QJn
 5FcHZF7IE6RWcanUnEW6IBouoI6i2N2OtwgrHtO0W4osmq/+jXYwkPku3ir2psT/mUkny
 Zrm6KcMW09+cVYjZr14l/uAiPbmaPC2gQPJmcNpd8SxHnvuKbGKh1wo8HKfg94CR7Mg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 753831F00A16;
 Tue,  3 Nov 2026 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793736174;
 bh=5/pn7fTfQxc1qaaKnW5Xmu4Vd/rwN8kHgyZ0qJMPbMs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=JKAQ5ip9FNKbtyszFmbkRTHOeF1DQ/n8ei/kL8ykgldqXL+ic50aRxTIPMxx3+JK7
 LTw9lbau0ugU5To42pOn9nuXqUNrCqXlR2/Tgg5OzzJ9PQu9R6L65RnXDL+Wy1QzNE
 tYPHMOWVMPOxZDzzB/ZoSuJUzDvolFeXbvOGqj9qb5rOrAWKr0hkykYVX3Rqg413/i
 l/H/YXIviXn1l1AhrfY06HfJamwjKLAdAsAYYqZrx+nwuuw4yRw8KHSo3efH24ml5S
 a4gNiyux9ERjm5JAlEdqrMenPCY3DfwJzqusZwGH74FD2UVyqF5lcDCnjWRaP13aDF
 4AjAJx5SMiLjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 07CFA46AED;
 Tue,  3 Nov 2026 20:02:52 +0000 (UTC)
From: "David R. Hedges via B4 Relay"
 <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 14:02:50 -0600
Subject: [PATCH 4/5] drm/nouveau/kms: cache the DP encoder after it has
 been attached
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nouveau-dp-relink-v1-4-7ee88c7f1e8a@thelittleman.net>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
In-Reply-To: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@intel.com>, Ben Skeggs <bskeggs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <me@dakr.org>, 
 "David R. Hedges" <linuxdev844@thelittleman.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793736171; l=3184;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=oxUnvWNMjr2Z6ZaQSslI9Xgy2BrHndjmNGwQkasaX3o=;
 b=Qp6JlCv2gZGBNz7xpy3nONrc81+mPG1Gr0q1jTZ8LlxSQXWfBIyaig2dPs1j6BC8ianfhaZSO
 Bq47JCpksfGBnxmUpMwf920vostAXMfJBFCBQjtFtBOkG7n7qVu8Ntk
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
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
Reply-To: linuxdev844@thelittleman.net
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "David R. Hedges" <linuxdev844@thelittleman.net>

nouveau_connector_create() caches the connector's DP encoder in
nv_connector->dp_encoder using find_encoder().  On nv50+ it's called
from nv50_display_create() before nv50_sor_create() has created the
encoder and attached it to the connector, so possible_encoders is
still empty, find_encoder() returns NULL, and dp_encoder is never set.
Two things depend on it:

 - nouveau_dp_link_check(), which the HPD worker calls on IRQ_HPD,
   reports the link as fine without looking at it when there's no DP
   encoder.  Until commit 633716501c94 ("drm/nouveau/disp: add dp
   train method") it looked the encoder up each time; since then, a
   sink that reports link loss with IRQ_HPD hasn't been retrained.

 - nouveau_connector_atomic_check() has never called
   drm_dp_mst_root_conn_atomic_check() for MST-capable root
   connectors.

Set dp_encoder in nv50_sor_create() right after the SOR is attached to
the connector, and drop the assignment that can't succeed.  This also
covers eDP, whose SOR is a DCB_OUTPUT_DP encoder too.  On a GA102 with
GSP-RM 570.144, an IRQ_HPD now leads to a read of the sink's link
status, where before it produced no AUX traffic at all.

This depends on "drm/nouveau/kms/nv50-: reject DP modesets the link
can't carry" and "drm/nouveau/dp: restart lost links with a modeset on
GSP-RM".  Without them, enabling the link check would have nouveau
retrain active links in place on GSP-RM, or restart them with a mode
the link can no longer carry, either of which can hang the display
engine.  The MST atomic check this enables hasn't been tested.

Fixes: 11d2738940eb ("drm/nouveau/kms: Cache DP encoders in nouveau_connector")
Fixes: 633716501c94 ("drm/nouveau/disp: add dp train method")
Link: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 7f55c016d846..583368914bf0 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1941,6 +1941,7 @@ nv50_sor_create(struct nouveau_encoder *nv_encoder)
 
 	if (dcbe->type == DCB_OUTPUT_DP) {
 		mutex_init(&nv_encoder->dp.hpd_irq_lock);
+		nv_connector->dp_encoder = nv_encoder;
 
 		if (disp->disp->object.oclass < GF110_DISP) {
 			/* HW has no support for address-only
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cae4e35c30aa..845f284f3a20 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1573,8 +1573,6 @@ nouveau_connector_create(struct drm_device *dev, int index)
 
 	switch (type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
-		nv_connector->dp_encoder = find_encoder(&nv_connector->base, DCB_OUTPUT_DP);
-		fallthrough;
 	case DRM_MODE_CONNECTOR_eDP:
 		drm_dp_cec_register_connector(&nv_connector->aux, connector);
 		break;

-- 
2.55.0



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D860A2615
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Go6ZSJOQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C4A1122E4;
	Thu, 29 Oct 2026 13:37:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4491122B0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4766419B6;
 Thu, 29 Oct 2026 13:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BE91F01825;
 Thu, 29 Oct 2026 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280994;
 bh=sRBKq+2Umg2Iw+/V4MgGP4abKYY9eE606qemJj7IMBo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Go6ZSJOQiXMndLMil//He+pO5uArn/CYu+U7vYiaIHm8LFvt24EEvdbeWmATwZnKc
 C/gS/qhTt2BC+Hf4iHd3VLpTZgKoDaUQTW4DYwlXYgKVwnXpRI8okajJbjpQvE5yrf
 QWj4rhoZZdRudz9YqN4VOPuzQ2ZsaFCE1Nzg05ADhkR5Lv0yilaV2AbTKxTnQxDVYy
 Da2ivuArRkhRbZxx97ndZF7UVIdficEQM470Qaqe+spwq2etwWGJPcDGeYKzJZj5VR
 h24mkIqKad09dNqvyqmpjajy3tf8OdPzqoorD+a0tY6ZneDopOyavNEOx88vfBWmk/
 +iJPMs9mN95Tw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:01 -0500
Subject: [PATCH v4 14/31] accel: ethosu: Move DMA mode to src/dst struct
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-14-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DMA mode setting is independent for source and destination, so it
should be part of the src/dst struct dma rather than the global DMA
state.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index c046aee42687..2b9c98251c94 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -110,6 +110,7 @@ int ethosu_gem_create_with_handle(struct drm_file *file,
 
 struct dma {
 	s8 region;
+	s8 mode;
 	u64 len;
 	u64 offset;
 	s64 stride[2];
@@ -118,7 +119,6 @@ struct dma {
 struct dma_state {
 	u16 size0;
 	u16 size1;
-	s8 mode;
 	struct dma src;
 	struct dma dst;
 };
@@ -171,7 +171,7 @@ static u64 cmd_to_addr(u32 *cmd)
 static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 		      struct dma_state *dma_st, struct dma *dma)
 {
-	s8 mode = dma_st->mode;
+	s8 mode = dma->mode;
 	u64 len = dma->len;
 
 	if (len == U64_MAX)
@@ -664,13 +664,14 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				st.dma.src.region = -1;
 			else
 				st.dma.src.region = param & 0x7;
-			st.dma.mode = (param >> 9) & 0x3;
+			st.dma.src.mode = (param >> 9) & 0x3;
 			break;
 		case NPU_SET_DMA0_DST_REGION:
 			if (param & 0x100)
 				st.dma.dst.region = -1;
 			else
 				st.dma.dst.region = param & 0x7;
+			st.dma.dst.mode = (param >> 9) & 0x3;
 			break;
 		case NPU_SET_DMA0_SIZE0:
 			st.dma.size0 = param;

-- 
2.53.0


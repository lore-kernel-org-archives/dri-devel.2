Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44060A2601
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8RTJFx9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B22112B64;
	Fri, 20 Nov 2026 14:58:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4356B112B5D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B377C60DF4;
 Fri, 20 Nov 2026 14:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5321F000CA;
 Fri, 20 Nov 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186688;
 bh=OsDmDSuXIeI4Gt+DPJ5jUIsjpvJ19K8lSFk9Nw4dHLE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L8RTJFx9SGYtOGuk/ZJOY1uvPzmlh/mAs66N6bYOyuCC1uyNnzMz2z4cBouCsgZZ2
 W9SPtUaddXqYPV7l1ytP2nxVAypCrzbGG51h6aO0io1Q6n3BqAMkfKicZrv82x1bMG
 GpBapWPylTU4wVx2XpOoscm7nedWJTdqKdjwthutJdYX80bvT0wCJq7870Zdy6hdFv
 0rm7/c3BkDu/aZAdDEtOT4uFvJSg2f1XL/+m+Z1q2Eg/LA+R+iF/ut0ozE7iArXtqw
 FwLnUG64se7yBQXoQLQs7Oyl3HBn/rgtJhkJdKtTXa5WsMf8ofEoO3uSMXXDGseM8b
 cQ1WPUkeaNUUw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:28 -0600
Subject: [PATCH v5 04/19] accel: ethosu: Factor buffer bounds checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-4-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
In-Reply-To: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the repeated command-stream buffer range validation into a
helper in preparation for validating all weight and scale streams.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - No changes.

v2:
 - Adjust due to previous patch
---
 drivers/accel/ethosu/ethosu_gem.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 75f6901d19e5..24f88696c18b 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -433,6 +433,25 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 	return addr;
 }
 
+static int buffer_size(struct ethosu_validated_cmdstream_info *info,
+		       struct cmd_state *st, struct buffer *buf, s8 region,
+		       u16 region_cmd, u16 base_cmd, u16 length_cmd)
+{
+	u64 end;
+
+	if (region < 0 || !cmd_state_reg_is_set(st, region_cmd) ||
+	    !cmd_state_reg_is_set(st, base_cmd) ||
+	    !cmd_state_reg_is_set(st, length_cmd))
+		return -EINVAL;
+
+	if (check_add_overflow(buf->base, (u64)buf->length, &end))
+		return -EINVAL;
+
+	info->region_size[region] = max(info->region_size[region], end);
+
+	return 0;
+}
+
 static int calc_sizes(struct drm_device *ddev,
 		      struct ethosu_validated_cmdstream_info *info,
 		      u16 op, struct cmd_state *st,
@@ -485,26 +504,20 @@ static int calc_sizes(struct drm_device *ddev,
 		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
 			op, st->weight[0].region, st->weight[0].base,
 			st->weight[0].base + st->weight[0].length - 1);
-		if (!cmd_state_reg_is_set(st, NPU_SET_WEIGHT_REGION) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_WEIGHT_BASE) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_WEIGHT_LENGTH))
+		if (buffer_size(info, st, &st->weight[0], st->weight[0].region,
+				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT_BASE,
+				NPU_SET_WEIGHT_LENGTH))
 			return -EINVAL;
-		info->region_size[st->weight[0].region] =
-			max(info->region_size[st->weight[0].region],
-			    st->weight[0].base + st->weight[0].length);
 	}
 
 	if (scale) {
 		dev_dbg(ddev->dev, "op %d: S:%d:0x%llx-0x%llx\n",
 			op, st->scale[0].region, st->scale[0].base,
 			st->scale[0].base + st->scale[0].length - 1);
-		if (!cmd_state_reg_is_set(st, NPU_SET_SCALE_REGION) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_SCALE_BASE) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_SCALE_LENGTH))
+		if (buffer_size(info, st, &st->scale[0], st->scale[0].region,
+				NPU_SET_SCALE_REGION, NPU_SET_SCALE_BASE,
+				NPU_SET_SCALE_LENGTH))
 			return -EINVAL;
-		info->region_size[st->scale[0].region] =
-			max(info->region_size[st->scale[0].region],
-			    st->scale[0].base + st->scale[0].length);
 	}
 
 	len = feat_matrix_length(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,

-- 
2.53.0


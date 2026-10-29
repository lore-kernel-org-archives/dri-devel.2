Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB8606C304
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlVH2VEe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9BF1122BC;
	Thu, 29 Oct 2026 13:36:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C7988BE3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 777A1605D6;
 Thu, 29 Oct 2026 13:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68191F01828;
 Thu, 29 Oct 2026 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280997;
 bh=ekO0d3X+6PaiUjIKMajvPpkg0Yr7OOFFbHuwyMP5If0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NlVH2VEe2W4/NzFHnI0dm1PDFysk+BWbf/GIE3EVJstS7naWBbKfJUTmPTHbfnlTa
 Jo49PnOB8VbVW0XNhNgD4elpYFRUmwPWvYhE+6akvLNtUzcTsZCbtWiSoAA8pMGcO8
 CU4rOz9cfqKrxk9ZsDd6XugxhV2IUZ5oL8ydJcW2CFOEeIA00iidnhiUE8ccihZe1z
 RJ2n4Q7VJt9nOQMQnZAX9Y22zfq8PxiU8ruMGMlVm+esmT+74g6174USYVMzoPGgLh
 MBIIYFlC9tbgjwHKCHshgAeLs1iYAhBfAN1dAxg+5y3Xqa5B3sjQYJ1NK+OmcFRcUN
 UJIZyjZ2hOGHg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:03 -0500
Subject: [PATCH v4 16/31] accel: ethosu: Factor buffer bounds checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-16-4aa25e22578e@kernel.org>
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

Move the repeated command-stream buffer range validation into a
helper in preparation for validating all weight and scale streams.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
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


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15860A2601
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+CeVaOz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C6A112B62;
	Fri, 20 Nov 2026 14:58:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D74112B5C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98C1961C5C;
 Fri, 20 Nov 2026 14:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC151F000C0;
 Fri, 20 Nov 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186693;
 bh=uZtGli3CkGrAhqKNwEKSISDtx01ePT5PWZSPVbc9OdE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=C+CeVaOz2nF9ABdQXaAIonS/gu8qKbpk0EUC2Wk21vaBYlBpQIf7mKhD2JkMHlMRb
 73dOG8OjXtRrVOjjxXWgWzDL00MUJhqnKI6XJ5wgOzHZ0wvwc/0UI6OgRQsdn/etrT
 PKb3xi2sOND62rvYkIjjjl6Akh6Wp/2DIOVVfudZdeVOm0UgJYvvWeRt5dWgm0WTlE
 uKcp3NwSYuDDT8BFroVyefhWXZktcvgNM/ODfrmQkWV/JSiqQq5YoeaLszjPoHV9MM
 oiTshH2UGd9l9q6zfBqplGccLJgNCPLS2V5qfcbCWj7T7Hc9H8HcFbbhssSIChmyMj
 wGDuug223WddA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:30 -0600
Subject: [PATCH v5 06/19] accel: ethosu: Validate secondary streams
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-6-52d459acdb84@kernel.org>
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

The command-stream validator records the additional U65 scale and
weight stream addresses and the U85 weight decoder addresses, but only
checked stream 0 against its region buffer.

Check every configured secondary stream against the matching weight or
scale region before accepting a kernel operation.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - No changes.

v2:
 - Adjust for register state tracking
---
 drivers/accel/ethosu/ethosu_gem.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 67c7cbbd39b8..af8a0c45039b 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -436,13 +436,17 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 
 static int buffer_size(struct ethosu_validated_cmdstream_info *info,
 		       struct cmd_state *st, struct buffer *buf, s8 region,
-		       u16 region_cmd, u16 base_cmd, u16 length_cmd)
+		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
 {
 	u64 end;
+	bool base_set = cmd_state_reg_is_set(st, base_cmd);
+	bool length_set = cmd_state_reg_is_set(st, length_cmd);
+
+	if (optional && !base_set && !length_set)
+		return 0;
 
 	if (region < 0 || !cmd_state_reg_is_set(st, region_cmd) ||
-	    !cmd_state_reg_is_set(st, base_cmd) ||
-	    !cmd_state_reg_is_set(st, length_cmd))
+	    !base_set || !length_set)
 		return -EINVAL;
 
 	if (check_add_overflow(buf->base, (u64)buf->length, &end))
@@ -507,7 +511,20 @@ static int calc_sizes(struct drm_device *ddev,
 			st->weight[0].base + st->weight[0].length - 1);
 		if (buffer_size(info, st, &st->weight[0], st->weight[0].region,
 				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT_BASE,
-				NPU_SET_WEIGHT_LENGTH))
+				NPU_SET_WEIGHT_LENGTH, false))
+			return -EINVAL;
+
+		if (buffer_size(info, st, &st->weight[1], st->weight[0].region,
+				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT1_BASE,
+				NPU_SET_WEIGHT1_LENGTH, true) ||
+		    buffer_size(info, st, &st->weight[3], st->weight[0].region,
+				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT3_BASE,
+				NPU_SET_WEIGHT3_LENGTH, true))
+			return -EINVAL;
+		if (!ethosu_is_u65(edev) &&
+		    buffer_size(info, st, &st->weight[2], st->weight[0].region,
+				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT2_BASE,
+				NPU_SET_WEIGHT2_LENGTH, true))
 			return -EINVAL;
 	}
 
@@ -517,7 +534,13 @@ static int calc_sizes(struct drm_device *ddev,
 			st->scale[0].base + st->scale[0].length - 1);
 		if (buffer_size(info, st, &st->scale[0], st->scale[0].region,
 				NPU_SET_SCALE_REGION, NPU_SET_SCALE_BASE,
-				NPU_SET_SCALE_LENGTH))
+				NPU_SET_SCALE_LENGTH, false))
+			return -EINVAL;
+
+		if (ethosu_is_u65(edev) &&
+		    buffer_size(info, st, &st->scale[1], st->scale[0].region,
+				NPU_SET_SCALE_REGION, NPU_SET_SCALE1_BASE,
+				NPU_SET_SCALE1_LENGTH, true))
 			return -EINVAL;
 	}
 

-- 
2.53.0


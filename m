Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6AEC61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FE810F1AF;
	Thu, 27 Aug 2026 20:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BKhvmget";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0263710F195
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7698D601F1;
 Thu, 27 Aug 2026 20:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33791F00ADB;
 Thu, 27 Aug 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862804;
 bh=soqnG960tBHGLpWSzIdlomnC6GrsL7rtWYMUTaVI+vo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BKhvmgetFhBeRwz1VwBKvv6FI+f8RZtJ8HFBshs8gmvWtMdUICqTgwWbPhgZeJLLV
 hieQOB3QAgu2zgfuGJZ8bAdJ6J4FIMgSUtJLirYXaio8+a1sGPFfLgPXU/uTjXJrb1
 Lr705/uq8Ob5YwR8RK7TxY0Y6ekiEwsvQgfslFiq8FaGy3wsqC9xSfvmpi4Dswidce
 tAR8vXoei/yUC0mx9LKqvhUNfvQy88lyJLisdLfBnFAsW97GhC6xO/y6ATLsKxs+OS
 PbmhOMix6M8gfO92uf/Ko/JO5zOKPHH/uCT8Aeux+foWyq3Q+093EvV2LQKGuQX4ix
 wduBSZGvniB1g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:07 -0500
Subject: [PATCH 08/11] accel: ethosu: Validate secondary streams
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-8-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
In-Reply-To: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

The command-stream validator records the additional U65 scale and
weight stream addresses and the U85 weight decoder addresses, but only
checked stream 0 against its region buffer.

Check every configured secondary stream against the matching weight or
scale region before accepting a kernel operation.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_gem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 9fce7caeeb9a..3d1f4121db4f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -321,6 +321,15 @@ static int calc_sizes(struct drm_device *ddev,
 			st->weight[0].base + st->weight[0].length - 1);
 		if (buffer_size(info, &st->weight[0], st->weight[0].region))
 			return -EINVAL;
+
+		for (int i = 1; i < ARRAY_SIZE(st->weight); i++) {
+			if (st->weight[i].base == U64_MAX &&
+			    st->weight[i].length == U32_MAX)
+				continue;
+
+			if (buffer_size(info, &st->weight[i], st->weight[0].region))
+				return -EINVAL;
+		}
 	}
 
 	if (scale) {
@@ -329,6 +338,12 @@ static int calc_sizes(struct drm_device *ddev,
 			st->scale[0].base + st->scale[0].length - 1);
 		if (buffer_size(info, &st->scale[0], st->scale[0].region))
 			return -EINVAL;
+
+		if (ethosu_is_u65(edev) &&
+		    (st->scale[1].base != U64_MAX ||
+		     st->scale[1].length != U32_MAX) &&
+		    buffer_size(info, &st->scale[1], st->scale[0].region))
+			return -EINVAL;
 	}
 
 	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,

-- 
2.53.0


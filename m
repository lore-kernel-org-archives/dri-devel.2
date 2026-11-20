Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CD60A262D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOY1pNTN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4401112B5F;
	Fri, 20 Nov 2026 14:58:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107FF112B5F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 895DA62641;
 Fri, 20 Nov 2026 14:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC6D1F000C6;
 Fri, 20 Nov 2026 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186691;
 bh=cbzB2LZxRa8KlJ7L448ZxVbc856NNpuuZnTJ2XHUAX4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JOY1pNTNYwmYbCn3T95tQ1G6rg9Gqsu7GBll229Z0x7uwIvgIg76x58M6muj85Ngt
 beYZGov1027RIvCDqmVUWnuKkhLrCwDksk5fAt3i9eOFjs2EFbV6YlPg5dSKDf6NwP
 qPG7uHd6ALc7WmJRZdZn7d0LhGYX3in+tgnVh7ok0I7Ix6zEsQr3DLkTTTCkFuuyJx
 GKA0XuhFp4Jrpjtp5v1A7v48025yGIQJJr7FwvHKMVVO9vRM+8NEO4+evfkz9KlpfB
 dhwei6jhtHftIQ+PxyO+CJStJhm9WBSVfdrtvML506cWfX7U/GCDKnqMrqqqnEHlRm
 WA2dvOj5xlfWg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:29 -0600
Subject: [PATCH v5 05/19] accel: ethosu: Fix NHCWB16 bounds calculation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-5-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
In-Reply-To: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 sashiko-bot@kernel.org
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

The Ethos-U NPU inherently processes NHCWB16 data in 16-channel bricks.
The NHCWB16 address calculation uses the final channel of the last
accessed brick. If the channel depth modulo 16 is less than 15, the
hardware will still read or write the full 16-element brick.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260905010523.866411F00A3D@smtp.kernel.org/
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - No changes.

v3:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 24f88696c18b..67c7cbbd39b8 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -415,9 +415,10 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 	case 1: //nhcwb16:
 		element_size = BIT((fm->precision >> (ofm ? 1 : 2)) & 0x3);
 
+		/* NHCWB16 accesses the complete final channel brick. */
 		if (check_mul_overflow(c / 16, (u64)fm->stride_c, &offset) ||
 		    check_add_overflow(addr, offset, &addr) ||
-		    check_mul_overflow(16 * x + (c & 0xf), element_size, &offset) ||
+		    check_mul_overflow(16 * x + 15, element_size, &offset) ||
 		    check_add_overflow(addr, offset, &addr))
 			return U64_MAX;
 		break;

-- 
2.53.0


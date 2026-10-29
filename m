Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DA606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQj1QmBm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119FC1122CC;
	Thu, 29 Oct 2026 13:37:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD8A10E7FC
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2601B409C7;
 Thu, 29 Oct 2026 13:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC111F01825;
 Thu, 29 Oct 2026 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281001;
 bh=77trVxyKnux39gneimvVW1eMxqF6fzx5+oISfaMgLYI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EQj1QmBmvTE4O9FQ44adDi+BQf3aK1lAqMTVEQT+y5uM9wF20LjvQZyrzGcDwVkYz
 fDUBX2Q9ZXRP5odtVEZmu4aKoaRj7qyiOdF1kXm5fG0BsIYAGMbK53LFJENoDj7y2k
 1sYJATcuOJb32i/c6MWAsJ4I5gUg6SVGErhaqM5lg426bpgcrRxuIwFSSYgqaaZjL5
 QmO9OD7snY2cx9YKmXcHVPCnbWa5FDCkxM210eR33nig/uPMgteQMRvh1eLPBXUJ7v
 r/NUfznSdoSKHhxJ8fukz4FQlD57JecdAa+AgQrhTdLdH0njQX/eUZ5AvR6qceyiUA
 HZWkjn2ov+FyQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:04 -0500
Subject: [PATCH v4 17/31] accel: ethosu: Fix NHCWB16 bounds calculation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-17-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Ethos-U NPU inherently processes NHCWB16 data in 16-channel bricks.
The NHCWB16 address calculation uses the final channel of the last
accessed brick. If the channel depth modulo 16 is less than 15, the
hardware will still read or write the full 16-element brick.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Reported-by: sashiko-bot@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
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


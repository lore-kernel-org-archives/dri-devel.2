Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5097BC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F2410EDC9;
	Tue,  8 Sep 2026 22:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HlbryeCT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8453110EDB7
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:05:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 646DC447AB;
 Tue,  8 Sep 2026 22:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1944B1F00A3E;
 Tue,  8 Sep 2026 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905105;
 bh=7lTXSTxsnG6cCBOxmONeX8M6z6q5cJvZx27kO/M+lUo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HlbryeCTMH+OOBxr4hM0n+6B8dQKDAwT7qzPE1TBHtwJGzWmWp5NZ8VC7FNvx1Zz7
 K4sxjEtWmEW87+VvXpnDQt0DYFZfXEJtKTLc1TZMZK3CLo9HdrMt/+yzWYPDh2Wm1W
 PER4ZVmhRzTc4pjx9RFlwTByoTqNpZV0mS6mEhI5ja27C3ScYbXI8krQTprkscS8Uk
 wlno/gv+tKbUpWGf92uR4yUQ5q/2jwQ5n+Tapk0yX9xcAQ5FJjSHSRxjKklcFAlxCn
 TVQWqmsRf28+Qgtw9AtLLoStCSvBIzwJnhjofaNYz7Z93f4mQlUNXtcWpb4/NdntYp
 F1GQbw6VrZtHw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:47 -0500
Subject: [PATCH v3 10/22] accel: ethosu: Fix NHCWB16 bounds calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-10-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The Ethos-U NPU inherently processes NHCWB16 data in 16-channel bricks.
The NHCWB16 address calculation uses the final channel of the last
accessed brick. If the channel depth modulo 16 is less than 15, the
hardware will still read or write the full 16-element brick.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 2707b7df5dbe..6f6712f4efd1 100644
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


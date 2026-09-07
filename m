Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E6C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF01A10EA40;
	Tue,  8 Sep 2026 07:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="cVKDzep1";
	dkim-atps=neutral
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3936910E20C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:31:51 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdjRC3vXqzLQV;
 Mon,  7 Sep 2026 12:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1788775623;
 bh=dBHS/oDA3Bq/MnKWT+8QzHHpzChtVCq42IiwJ53rpN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cVKDzep1CyQTvdc/Ii2VjkiffniujobOY2OpYIPLpohena7oY7zcrBlAtZkozWUqC
 flu1y0agAqOipngBYSClHrYRKCrxxEYrlnClbCDLfg18qROmxz+oDqEKGeTXndSZE7
 PC5QRQDMALZpT2GaSWNeDYWZcZEwkm/b+JrTQ7RvhR0L7LgUGD4wbHrbqivdTc6DXm
 aX6xShermTR1s5Lx16SfFssR8PIu1detKLzOp5y6dzwsSuA3jf8q5JI9wqsb5nO8VP
 dOvdrkn69gQR9ZbqIjAiSosE30DhPJsZlxCLpt3woG7a2S1YFhdnuOvHRG1e4ryjEt
 3NlEBy5czrtMw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hdjRB6NnrzYx7; Mon,  7 Sep 2026 12:07:02 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/amd/display: send the 3D_Ext_Data byte for
 top-and-bottom too
Date: Mon,  7 Sep 2026 12:06:25 +0200
Message-ID: <20260907100626.54465-3-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
References: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

HDMI 1.4b only requires the 3D_Ext_Data byte for the side-by-side
(half) structure, and the vendor infoframe for top-and-bottom is
built with a 5-byte payload accordingly. At least one sink family
ignores a top-and-bottom VSIF without the sixth byte: a JVC DLA-RS4100
(D-ILA, "ILAFPJ--X214A") stays in 2D on the 5-byte frame and engages
its 3D mode the moment the byte is present. Amlogic sources send the
6-byte form for top-and-bottom, which is why the same projector works
with them.

Send the extra byte, zero, for top-and-bottom as well. Sinks that do
not need it ignore a zero 3D_Ext_Data field.

Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
---
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 13478b8bd..3e41b33ea 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -574,6 +574,7 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 			case TIMING_3D_FORMAT_TOP_AND_BOTTOM:
 			case TIMING_3D_FORMAT_TB_SW_PACKED:
 				info_packet->sb[5] = (0x6 << 4);
+				length = 6;
 				break;
 
 			default:
-- 
2.43.0


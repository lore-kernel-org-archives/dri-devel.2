Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEB4C79FAC
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA75C10EA2C;
	Tue,  8 Sep 2026 07:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="LLUOPGoa";
	dkim-atps=neutral
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA10F10E7B5
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:53:01 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdlnS0bqRzcjH;
 Mon,  7 Sep 2026 13:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1788781979;
 bh=dBHS/oDA3Bq/MnKWT+8QzHHpzChtVCq42IiwJ53rpN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LLUOPGoa+1yTYjwReXd3sLFYM2bd9Ba8C+V+nZjYKtYEhiOZvd5osahH+orDZr49K
 d4nTyQea4C8zit4CurAfXWzpDzZ4q9bhzJiTJnwFSDOP6grS/JiA1X2SzdWP29rs6I
 x59D/ICIHRYbFdiVxhQvR0ETaJ17Ol8r9CJqfT8DiviGqAmBzzWIw5A7yhJBw92mOw
 URk1q5DBPZtn+1yyY5vp662Tyae0eOU0EpmnuwiCM4XIwlRFnPWPhqnxTjpaX61+NJ
 vrH13EkLKMi0eaM8ypd62T5oqFrQjwBvwHTiIfqjRHEOQ7TXgxn8UZf6oBcmT6AVIL
 mtPbXxoeOtxBg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hdlnR2cM7z1Tn; Mon,  7 Sep 2026 13:52:59 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/amd/display: send the 3D_Ext_Data byte for
 top-and-bottom too
Date: Mon,  7 Sep 2026 13:52:28 +0200
Message-ID: <20260907115229.64477-3-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907115229.64477-1-adrian.betschart@cinemaone.ch>
References: <20260907115229.64477-1-adrian.betschart@cinemaone.ch>
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


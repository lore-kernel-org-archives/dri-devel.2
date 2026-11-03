Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F5606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GveICwjq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F7310F3F9;
	Tue,  3 Nov 2026 07:40:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B8710F3F2
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9C70402DB;
 Tue,  3 Nov 2026 07:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815651F00919;
 Tue,  3 Nov 2026 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691630;
 bh=/OIKB0qjolP2ztLXi2lVLr/QNtGeznSTbUgzPs8K/nE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GveICwjqTpFSI4GIAK8W4j+6Af2X82KZMOzHaCGdPE9ZrBQmQbmC9uRKDQkhqN9Uz
 nzXDDUN2Ac/yr8Gr4l5LdeoCZ0OCcm7955gg8BE1/UqMIE76KoNn0ftiCrl8NDP6Wg
 W45BhAKi808/TVkWH4jrxUm/s07U/U+fh8IhwC27tpVSLcc19OYnSRMhXlUhsHxKKf
 NYv80k7tfKjCIkatFr91+v5Etk2psZL4IgvzL/gjvnhKM08+mn1pfQFd55fjBORzX3
 xbFJNRH+w39D2ljqaYH6a/5Ugo2EJ5Q9OinpW15zqIaGROHKB91Cd0yo8j0RNpTD3B
 5VPu9fpbh+WcQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv2 05/13] media: cec: extron-da-hd-4k-plus: call
 cec_s_phys_addr only if EDID is present
Date: Tue,  3 Nov 2026 08:31:56 +0100
Message-ID: <6ece814cc7e99bab9aaf57bb4fc7881fe3e47133.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If an EDID is present, then call cec_s_phys_addr. If not, then
call cec_phys_addr_invalidate. This helps the CEC framework differentiate
between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an EDID without
a Physical Address.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
index 1f8ed7ff31e5..ae3628767ac5 100644
--- a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
+++ b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
@@ -643,8 +643,12 @@ static void extron_irq_work_handler(struct work_struct *work)
 			extron_read_edid(port);
 		}
 	}
-	if (update_pa)
-		cec_s_phys_addr(port->adap, pa, false);
+	if (update_pa || update_has_edid) {
+		if (has_edid)
+			cec_s_phys_addr(port->adap, pa, false);
+		else
+			cec_phys_addr_invalidate(port->adap);
+	}
 }
 
 static void extron_process_received(struct extron_port *port, const char *data)
-- 
2.53.0


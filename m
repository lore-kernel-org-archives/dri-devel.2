Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA253606A33B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Thnqe7Pd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5B610ECF4;
	Mon,  2 Nov 2026 10:55:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE1710ECF0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9771A6110F;
 Mon,  2 Nov 2026 10:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3831F00A1B;
 Mon,  2 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616904;
 bh=lUIbwahwAMRQLzx+KlFvcws6g6RsvoBUBmMGB7qssW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Thnqe7PdkXVqPwEsthV5xhNYKyrNS/uhFhWWxFEg5jLMpkPhtfkv4kAtrRg45oHjZ
 I0WSgwf7FK+GJJzt63gVoF7yobmku4CIEoWP0ugyvvJyYwGUY7jlMvYWfrJ9o5sk/L
 GBofLi37su9pR5gqmOh7bxeh6blK4648hxnl//jO3yvoVGclCmJKs0MNUbDLNzaPMw
 S9nGG+YnL6+fGUiPFtL1O1zGctd1gIteGb9wMQiXZYTk+IKfH3pU/SaJXKsope0pXh
 Td5O+lCTvIbvngFPofbU8kzGNDhpkIVG9V5/sHsV5N/2ZQoTKOa95UObo6kr1Nq0rO
 KAq8/3+R0EMtQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 05/13] media: cec: extron-da-hd-4k-plus: call cec_s_phys_addr
 only if EDID is present
Date: Mon,  2 Nov 2026 11:36:56 +0100
Message-ID: <82d1f51d30ddccac1cda598e2873e49063801b9e.1793615824.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
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
index 1f8ed7ff31e5..0a0724fd89c0 100644
--- a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
+++ b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
@@ -643,8 +643,12 @@ static void extron_irq_work_handler(struct work_struct *work)
 			extron_read_edid(port);
 		}
 	}
-	if (update_pa)
-		cec_s_phys_addr(port->adap, pa, false);
+	if (update_pa) {
+		if (has_edid)
+			cec_s_phys_addr(port->adap, pa, false);
+		else
+			cec_phys_addr_invalidate(port->adap);
+	}
 }
 
 static void extron_process_received(struct extron_port *port, const char *data)
-- 
2.53.0


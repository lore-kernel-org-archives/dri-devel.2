Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A4606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcFaM3j+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4308D112185;
	Thu,  5 Nov 2026 07:27:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8311D112173
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6813F40B14;
 Thu,  5 Nov 2026 07:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129571F00A02;
 Thu,  5 Nov 2026 07:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863641;
 bh=cQ3r6pBuZpAi/+E99QReGdm/9gyeC7LgMKuYrG/jBBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dcFaM3j+pESi99lhnlzHt5ZYOBIykGl/55YCjx7gWDlZMVYtqKPA4unJ1qUa6sM0I
 D2QzLE6zNa2XSpu6wnHwQ+5mBHis00f8Is4Aw8/22XcRC0/xuMArHSzl6s8NvmAGOT
 9qJVhYbO6aQ2eaD7Uof/lCVClHapAqGiWtwdKDvS03gW4RE7mM/XSf3BGbNBO0rJjK
 dyL1PUUJZgUedYZz2vhiqFWL9aYhF4xm7Fg1M0yuaOlDbxvAOW1xTgpvUGrYOmErR3
 4GT7q1fgbiGjE6LnI/BnVoDphY2OyN91dtele8WI00W4Kz4Vj7sIlI5EcDoB3x+yJ6
 n2rIzNf20stlw==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 05/13] media: cec: extron-da-hd-4k-plus: call
 cec_s_phys_addr only if HPD is high
Date: Thu,  5 Nov 2026 08:22:19 +0100
Message-ID: <f8f9303c0356cf2697e2bc4caca400ae944be378.1793863347.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
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

If the HPD is high, then call cec_s_phys_addr. If not, then call
cec_phys_addr_invalidate. This helps the CEC framework differentiate
between CEC_PHYS_ADDR_INVALID due to no HPD/EDID, or due to an EDID without
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


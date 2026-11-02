Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B3606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6tQtiEC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2E710ED04;
	Mon,  2 Nov 2026 10:55:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A49C10ECE9
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB4016110A;
 Mon,  2 Nov 2026 10:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5745F1F00A16;
 Mon,  2 Nov 2026 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616916;
 bh=0uC1lw4qr5rkQj5pdgH8BUM79En1tPMCwDHsh7HKEYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D6tQtiECwkCpSN4Q3tG38NPQNWg52qzMDiQ+k4OoBUGPOdDwYCOJbmUI8KzcVeAU7
 ORcMpwNHWuqd5Q/a8YVRX/lAOM2FeU8QfZsaD8vstUMzjE9K736EUbi3iXDjeSwHYP
 lDksV9+f9POLC88Hz16ZEMML4S4ObCz/gT23+JqpmDGh18g4W6zQM+hSR11ZB5eW91
 c5qJmmqs+cGbAmxO3VTbAYrwpi0Pnk14VIEf2zF3MyTl2Bp6HiijqfWY7zMjnNXdLr
 WaiAhA3q1UMTV4+lLTolWzDTNemmQiMPntCGYdY1jY/7O+GB0iQJt+L0eCio2hWKtT
 BhrOluUo+sOfg==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 13/13] Documentation: media: document cec_phys_addr_invalidate
Date: Mon,  2 Nov 2026 11:37:04 +0100
Message-ID: <37bdf75bef53988d3cfdd2caebe9cbb8b6eeb59c.1793615824.git.hverkuil+cisco@kernel.org>
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

This function was not document, add it. Also clarify
cec_adap_s_phys_addr, explaining that the PA comes from the EDID.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 Documentation/driver-api/media/cec-core.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/cec-core.rst b/Documentation/driver-api/media/cec-core.rst
index f1ffdec388f3..10927833992c 100644
--- a/Documentation/driver-api/media/cec-core.rst
+++ b/Documentation/driver-api/media/cec-core.rst
@@ -437,7 +437,8 @@ transmitted, otherwise just queue it and return.
 .. c:function::
    void cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block);
 
-Change the physical address. This function will set adap->phys_addr and
+Change the physical address. Use cec_s_phys_addr() to set the Physical Address
+as read from an EDID. This function will set adap->phys_addr and
 send an event if it has changed. If cec_s_log_addrs() has been called and
 the physical address has become valid, then the CEC framework will start
 claiming the logical addresses. If block is true, then this function won't
@@ -449,6 +450,13 @@ then the CEC adapter will be disabled. If you change a valid physical address
 to another valid physical address, then this function will first set the
 address to CEC_PHYS_ADDR_INVALID before enabling the new physical address.
 
+.. c:function::
+   void cec_phys_addr_invalidate(struct cec_adapter *adap);
+
+Invalidates the Physical Address when the EDID was lost, e.g. if the HDMI
+cable was unplugged. Do not use this to report an invalid Physical Address
+that you read from an EDID, use cec_s_phys_addr() for that.
+
 .. c:function::
    void cec_s_phys_addr_from_edid(struct cec_adapter *adap, \
 				  const struct edid *edid);
-- 
2.53.0


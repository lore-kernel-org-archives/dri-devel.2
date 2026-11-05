Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D167606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdezJJ/1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85493112182;
	Thu,  5 Nov 2026 07:27:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DC3112193
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12E1E60F20;
 Thu,  5 Nov 2026 07:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24DA1F000C1;
 Thu,  5 Nov 2026 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863654;
 bh=0uC1lw4qr5rkQj5pdgH8BUM79En1tPMCwDHsh7HKEYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mdezJJ/1/LD4WSb1FM7EtL6dQsGocjEwRqdDvbf2ZtPgsa95F08XN6FJmVaVq5Uf0
 heMz0q8X/VJsNb0toW8sJAAhjuOj/8C4pAO0/sZCd3J0iWOYlfaMp1YLXI4z6bN8N5
 kZEiiFPp0K9qXwun/6jM4u+x1t6ZjekMzcx0UbFTEjtqiQm3WDdrKCzu1xLwZ1nI4W
 XCEjiynp9PhtT0ARbeenQii5Ni1D2GUsym9CujOf6/6bWKG0+Q6cPF/ak5dd1RZZmV
 h1+Jynq86mpEbThUF4m1QsTz9q/8MoqYxEcUSZhPHzHeqT4E45tGEyMC8kaYujil3h
 TX0FSENSHdYUw==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 13/13] Documentation: media: document
 cec_phys_addr_invalidate
Date: Thu,  5 Nov 2026 08:22:27 +0100
Message-ID: <728f2d90942941cdf349f4ac39f16d512ba690c9.1793863347.git.hverkuil+cisco@kernel.org>
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


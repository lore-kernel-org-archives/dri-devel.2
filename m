Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76970606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeA7nlh9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CE910ECF7;
	Mon,  2 Nov 2026 10:55:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB4A10ECEB
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0449343DDE;
 Mon,  2 Nov 2026 10:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C716D1F00A1C;
 Mon,  2 Nov 2026 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616914;
 bh=uIr8Q+u/xMDGvcYtw+4rXJj39qZiWFTAoKVdJbKlz2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DeA7nlh9nKn3AxA/TxulLpW4WNmGqUnkqcRUtBuE1lAmkiDotU1rha1k5fDh63vQP
 2Y+gAwCqr9qZnmSAiGtQktMItdnYoceDG0X7fLGgx6qjUyDA8AeCLXPVfhnkA1TAGN
 TqNcya+hKlLxBC0LTkOTMymGeD5RkrkflEnlOAmx+FF5YM3hrgXTOShZDzz3PlUidq
 iObRUZ4uV7A9nmfU6E7nRF6MUGDQdNnYyB08uhqfCU2oj1/oPR6hQf+XLcG+zCPCwn
 5AxTaggEaOvfQc4yQlhQHTw5h/99gU3i94RSXRD24KbdSH4bj7eeUxyClQF2Un927y
 fJX91iQSjQb0Q==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 12/13] media: cec: core: implement
 CEC_EVENT_FL_STATE_EDID_PRESENT
Date: Mon,  2 Nov 2026 11:37:03 +0100
Message-ID: <e5ad86f5e6a33e6b9c1b930a00c984f49eb316eb.1793615824.git.hverkuil+cisco@kernel.org>
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

Set CEC_EVENT_FL_STATE_EDID_PRESENT if needed when posting the state
change event.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 06a596a0ede3..c0de5835fea0 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -323,6 +323,8 @@ static void cec_post_state_event(struct cec_adapter *adap)
 	ev.state_change.log_addr_mask = adap->log_addrs.log_addr_mask;
 	ev.state_change.have_conn_info =
 		adap->conn_info.type != CEC_CONNECTOR_TYPE_NO_CONNECTOR;
+	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT)
+		ev.flags |= CEC_EVENT_FL_STATE_EDID_PRESENT;
 	cec_queue_event(adap, &ev);
 }
 
-- 
2.53.0


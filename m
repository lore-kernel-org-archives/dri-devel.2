Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA4606A335
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0dzZCbz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646BF10ECF2;
	Mon,  2 Nov 2026 10:55:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6975910ECF2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 644E840800;
 Mon,  2 Nov 2026 10:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A2F1F00A1B;
 Mon,  2 Nov 2026 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616907;
 bh=q5D6NcSVIATB1SU1kSC859+uaa0n8diQ4fmz2USuJuI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W0dzZCbzkn8EjKd3WjjdjOlgmbxw/iT8ok/RP7mASQ3gFv6LzXHHjqLzV6jmTEFIH
 GI1pdRCPFuTub/C62Wq50GHRHxkyQfbabp2D/DWw9OrPCdarA+4HoTemap/jj47L08
 QRC+wITTMb1Ja7mSZgbzrmNqfl8M591o6GIogomGwfbzKw7ShcBwiibZzZevN0gNfS
 vFZz+M6XV/e2Xzc0/oUPW8T0gR+rwnVYb1zO8PoD8YpTCw3wzSJ56gN5HAzNIkP6EE
 dQfWasTdowKLPkOZWYScu03hPgTApQHYIaareRff+827/CV+rjvnl4QEtmE4ueAuDZ
 6PmJDILxBz0ew==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 07/13] media: uapi: cec.h: add
 CEC_CAP_HAS_EDID_PRESENT/CEC_LOG_ADDRS_FL_EDID_PRESENT
Date: Mon,  2 Nov 2026 11:36:58 +0100
Message-ID: <399072ca2a74db139b50502ff644834ea79eb829.1793615824.git.hverkuil+cisco@kernel.org>
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

Add a capability and a new flag that is used to indicate if an
EDID is present.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 include/uapi/linux/cec.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index fdfc97a6e4ec..8f7c7a4cb505 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -325,27 +325,27 @@ static inline int cec_is_unconfigured(__u16 log_addr_mask)
 #define CEC_MODE_FOLLOWER_MSK		0xf0
 
 /* Userspace has to configure the physical address */
-#define CEC_CAP_PHYS_ADDR	(1 << 0)
+#define CEC_CAP_PHYS_ADDR		(1 << 0)
 /* Userspace has to configure the logical addresses */
-#define CEC_CAP_LOG_ADDRS	(1 << 1)
+#define CEC_CAP_LOG_ADDRS		(1 << 1)
 /* Userspace can transmit messages (and thus become follower as well) */
-#define CEC_CAP_TRANSMIT	(1 << 2)
-/*
- * Passthrough all messages instead of processing them.
- */
-#define CEC_CAP_PASSTHROUGH	(1 << 3)
+#define CEC_CAP_TRANSMIT		(1 << 2)
+/* Passthrough all messages instead of processing them. */
+#define CEC_CAP_PASSTHROUGH		(1 << 3)
 /* Supports remote control */
-#define CEC_CAP_RC		(1 << 4)
+#define CEC_CAP_RC			(1 << 4)
 /* Hardware can monitor all messages, not just directed and broadcast. */
-#define CEC_CAP_MONITOR_ALL	(1 << 5)
+#define CEC_CAP_MONITOR_ALL		(1 << 5)
 /* Hardware can use CEC only if the HDMI HPD pin is high. */
-#define CEC_CAP_NEEDS_HPD	(1 << 6)
+#define CEC_CAP_NEEDS_HPD		(1 << 6)
 /* Hardware can monitor CEC pin transitions */
-#define CEC_CAP_MONITOR_PIN	(1 << 7)
+#define CEC_CAP_MONITOR_PIN		(1 << 7)
 /* CEC_ADAP_G_CONNECTOR_INFO is available */
-#define CEC_CAP_CONNECTOR_INFO	(1 << 8)
+#define CEC_CAP_CONNECTOR_INFO		(1 << 8)
 /* CEC_MSG_FL_REPLY_VENDOR_ID is available */
-#define CEC_CAP_REPLY_VENDOR_ID	(1 << 9)
+#define CEC_CAP_REPLY_VENDOR_ID		(1 << 9)
+/* CEC_LOG_ADDRS_FL_EDID_PRESENT is available */
+#define CEC_CAP_HAS_EDID_PRESENT	(1 << 10)
 
 /**
  * struct cec_caps - CEC capabilities structure.
@@ -405,6 +405,8 @@ struct cec_log_addrs {
 #define CEC_LOG_ADDRS_FL_CDC_ONLY		(1 << 2)
 /* Configuration failed */
 #define CEC_LOG_ADDRS_FL_CONFIG_FAILED		(1 << 3)
+/* EDID is present */
+#define CEC_LOG_ADDRS_FL_EDID_PRESENT		(1 << 4)
 
 /**
  * struct cec_drm_connector_info - tells which drm connector is
-- 
2.53.0


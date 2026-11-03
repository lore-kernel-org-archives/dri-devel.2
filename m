Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE3606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1LWu+O4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38E210F3F3;
	Tue,  3 Nov 2026 07:40:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A63210F3E9
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB12F605CB;
 Tue,  3 Nov 2026 07:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8618F1F00A1B;
 Tue,  3 Nov 2026 07:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691633;
 bh=q5D6NcSVIATB1SU1kSC859+uaa0n8diQ4fmz2USuJuI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i1LWu+O4FR9gejshqQx8l6/Ks4sd1Sn1/foX7xym52VWCWYgkt0Bp09ZhX/L06n/K
 NaFm1MhYvKUMcTHLbdHrm6rDjcqAF2d2R52SyYGThYl9F1fLgTKta4fBHsmRvWxRoC
 lnA+/2+M6tVf/RZp9Z4X0cZ/mIq6uiI5u4BJM/66D7d9ayieyEtDLAZPGq2L7fncon
 wju4r7HoyHYyIhlvyK0oBMMowPRs9ELzib4TVPMQl5Pnt6yJw1heZDQ/QanPOcBdrp
 9mOS6lX12OTgLzfCnWk4M/UZqIe2DKJ3YYGdDNRKNo3BjS8eGuFlds83zW1svyuFV6
 lUQMlm3kHayUA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv2 07/13] media: uapi: cec.h: add
 CEC_CAP_HAS_EDID_PRESENT/CEC_LOG_ADDRS_FL_EDID_PRESENT
Date: Tue,  3 Nov 2026 08:31:58 +0100
Message-ID: <b168e5e844ef01f26cbf5aaba92761823df83ff1.1793691124.git.hverkuil+cisco@kernel.org>
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


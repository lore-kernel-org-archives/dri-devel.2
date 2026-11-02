Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE3606A337
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DyLJ/n5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8427310ECFB;
	Mon,  2 Nov 2026 10:55:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3F610ECF0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 689134142A;
 Mon,  2 Nov 2026 10:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415E01F00A18;
 Mon,  2 Nov 2026 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616910;
 bh=HiFGGsbLMoBcuWKUSj5l3EasDWO+HxUA4clEEH3f04A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DyLJ/n5w30YWfeFXrbFVp+jV2kaGHrWctr5eBPrvDMn5Nth+2OhL2pY4UuC7IfTzj
 yVFIWcq8EhVp/5jOx8NQSQNO+qnCt6qhhKYhoLA38073ZjJ+CMgka9Q1sFdV4fsIqk
 WZw4m+dtMzYD3/6K1Ea3d9uUSo4eEqvPtqZOGPTGZDv6Xb72vijrtao0ZruHfU0I4Q
 nJ78G08hAiHcPshi4PyuLCoPDE2JRct1m1jDz1w4RVF5Vet2TiiqmIMbJTgRUZ4s2m
 kHsuGmv2CzpSpaTYKLdF8QjiuRpzEwr/OTHrFFGpOGPFacQRjvhUKebZ3ZsT6PWEUN
 e0QOuSg7ZZLFA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 09/13] media: cec: core: add support for EDID_PRESENT
Date: Mon,  2 Nov 2026 11:37:00 +0100
Message-ID: <042cf83e3d25d6459fe7dcd35fa04f43dc617ba2.1793615824.git.hverkuil+cisco@kernel.org>
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

There can be two reasons for the CEC Physical Address to be invalid:
either there is no EDID, or there is an EDID, but it does not contain
a Physical Address, or the Physical Address is set to f.f.f.f in the EDID.

For debugging it is very useful to know why the PA is invalid.

Add support for reporting this to userspace by changing the behavior of
two CEC functions: cec_s_phys_addr is called with the PA read from the
EDID (or CEC_PHYS_ADDR_INVALID if the EDID has no PA or the PA is f.f.f.f),
and cec_phys_addr_invalidate is only called if the HPD goes low, so the
EDID is gone.

The first function sets the new CEC_LOG_ADDRS_FL_EDID_PRESENT flag, and
the second function removes it.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 47 ++++++++++++++++++++++++++-----
 drivers/media/cec/core/cec-api.c  |  3 +-
 drivers/media/cec/core/cec-core.c |  4 ++-
 drivers/media/cec/core/cec-priv.h |  3 +-
 include/media/cec.h               | 27 +++++++++---------
 5 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index ee8a200b9803..06a596a0ede3 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1727,18 +1727,33 @@ int cec_adap_enable(struct cec_adapter *adap)
  *
  * This function is called with adap->lock held.
  */
-void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block)
+void __cec_s_phys_addr(struct cec_adapter *adap, bool edid_present,
+		       u16 phys_addr, bool block)
 {
 	bool becomes_invalid = phys_addr == CEC_PHYS_ADDR_INVALID;
 	bool is_invalid = adap->phys_addr == CEC_PHYS_ADDR_INVALID;
+	bool edid_was_present =
+		adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT;
 
-	if (phys_addr == adap->phys_addr)
-		return;
+	if (adap->capabilities & CEC_CAP_HAS_EDID_PRESENT) {
+		if (edid_present)
+			adap->log_addrs.flags |= CEC_LOG_ADDRS_FL_EDID_PRESENT;
+		else
+			adap->log_addrs.flags &= ~CEC_LOG_ADDRS_FL_EDID_PRESENT;
+	}
 	if (!becomes_invalid && adap->devnode.unregistered)
 		return;
+	if (phys_addr == adap->phys_addr) {
+		if (edid_was_present != edid_present) {
+			dprintk(1, "EDID is %spresent\n",
+				edid_present ? "" : "not ");
+			cec_post_state_event(adap);
+		}
+		return;
+	}
 
-	dprintk(1, "new physical address %x.%x.%x.%x\n",
-		cec_phys_addr_exp(phys_addr));
+	dprintk(1, "new physical address %x.%x.%x.%x, EDID is %spresent\n",
+		cec_phys_addr_exp(phys_addr), edid_present ? "" : "not ");
 	if (becomes_invalid || !is_invalid) {
 		adap->phys_addr = CEC_PHYS_ADDR_INVALID;
 		cec_adap_unconfigure(adap);
@@ -1767,11 +1782,22 @@ void cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block)
 		return;
 
 	mutex_lock(&adap->lock);
-	__cec_s_phys_addr(adap, phys_addr, block);
+	__cec_s_phys_addr(adap, true, phys_addr, block);
 	mutex_unlock(&adap->lock);
 }
 EXPORT_SYMBOL_GPL(cec_s_phys_addr);
 
+void cec_phys_addr_invalidate(struct cec_adapter *adap)
+{
+	if (IS_ERR_OR_NULL(adap))
+		return;
+
+	mutex_lock(&adap->lock);
+	__cec_s_phys_addr(adap, false, CEC_PHYS_ADDR_INVALID, false);
+	mutex_unlock(&adap->lock);
+}
+EXPORT_SYMBOL_GPL(cec_phys_addr_invalidate);
+
 /*
  * Note: In the drm subsystem, prefer calling (if possible):
  *
@@ -1782,10 +1808,15 @@ void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
 {
 	u16 pa = CEC_PHYS_ADDR_INVALID;
 
+	if (IS_ERR_OR_NULL(adap))
+		return;
+
 	if (edid && edid->extensions)
 		pa = cec_get_edid_phys_addr((const u8 *)edid,
 				EDID_LENGTH * (edid->extensions + 1), NULL);
-	cec_s_phys_addr(adap, pa, false);
+	mutex_lock(&adap->lock);
+	__cec_s_phys_addr(adap, edid, pa, false);
+	mutex_unlock(&adap->lock);
 }
 EXPORT_SYMBOL_GPL(cec_s_phys_addr_from_edid);
 
@@ -1969,6 +2000,8 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 	}
 
 	log_addrs->log_addr_mask = adap->log_addrs.log_addr_mask;
+	log_addrs->flags |=
+		adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT;
 	adap->log_addrs = *log_addrs;
 	err = cec_adap_enable(adap);
 	if (!err && adap->phys_addr != CEC_PHYS_ADDR_INVALID)
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index a491d7fc8a71..1ba080d5a123 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -136,7 +136,8 @@ static long cec_adap_s_phys_addr(struct cec_adapter *adap, struct cec_fh *fh,
 	if (cec_is_busy(adap, fh))
 		err = -EBUSY;
 	else
-		__cec_s_phys_addr(adap, phys_addr, block);
+		__cec_s_phys_addr(adap, phys_addr != CEC_PHYS_ADDR_INVALID,
+				  phys_addr, block);
 	mutex_unlock(&adap->lock);
 	return err;
 }
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 230f8a413e74..9767f7c55b46 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -178,7 +178,7 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 	mutex_unlock(&devnode->lock);
 
 	mutex_lock(&adap->lock);
-	__cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false);
+	__cec_s_phys_addr(adap, false, CEC_PHYS_ADDR_INVALID, false);
 	__cec_s_log_addrs(adap, NULL, false);
 	// Disable the adapter (since adap->devnode.unregistered is true)
 	cec_adap_enable(adap);
@@ -279,6 +279,8 @@ struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
 	adap->log_addrs.cec_version = CEC_OP_CEC_VERSION_2_0;
 	adap->log_addrs.vendor_id = CEC_VENDOR_ID_NONE;
 	adap->capabilities = caps | CEC_CAP_REPLY_VENDOR_ID;
+	if (!(caps & CEC_CAP_PHYS_ADDR))
+		adap->capabilities |= CEC_CAP_HAS_EDID_PRESENT;
 	if (debug_phys_addr)
 		adap->capabilities |= CEC_CAP_PHYS_ADDR;
 	adap->needs_hpd = caps & CEC_CAP_NEEDS_HPD;
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index ce42a37c4ac0..8ccf9ac868ba 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -46,7 +46,8 @@ void cec_monitor_pin_cnt_dec(struct cec_adapter *adap);
 int cec_adap_status(struct seq_file *file, void *priv);
 int cec_thread_func(void *_adap);
 int cec_adap_enable(struct cec_adapter *adap);
-void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block);
+void __cec_s_phys_addr(struct cec_adapter *adap, bool edid_present,
+		       u16 phys_addr, bool block);
 int __cec_s_log_addrs(struct cec_adapter *adap,
 		      struct cec_log_addrs *log_addrs, bool block);
 int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
diff --git a/include/media/cec.h b/include/media/cec.h
index 4c8b0950b377..bfdc2987f7b1 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -381,6 +381,16 @@ void cec_s_conn_info(struct cec_adapter *adap,
 int cec_transmit_msg(struct cec_adapter *adap, struct cec_msg *msg,
 		     bool block);
 
+/**
+ * cec_phys_addr_invalidate() - set the physical address to INVALID
+ *
+ * @adap:	the CEC adapter
+ *
+ * This is a simple helper function to invalidate the physical
+ * address when the EDID is lost.
+ */
+void cec_phys_addr_invalidate(struct cec_adapter *adap);
+
 /* Called by the adapter */
 void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 			  u8 arb_lost_cnt, u8 nack_cnt, u8 low_drive_cnt,
@@ -491,6 +501,10 @@ static inline void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
 {
 }
 
+static inline void cec_phys_addr_invalidate(struct cec_adapter *adap)
+{
+}
+
 static inline u16 cec_get_edid_phys_addr(const u8 *edid, unsigned int size,
 					 unsigned int *offset)
 {
@@ -513,19 +527,6 @@ cec_fill_conn_info_from_drm(struct cec_connector_info *conn_info,
 
 #endif
 
-/**
- * cec_phys_addr_invalidate() - set the physical address to INVALID
- *
- * @adap:	the CEC adapter
- *
- * This is a simple helper function to invalidate the physical
- * address.
- */
-static inline void cec_phys_addr_invalidate(struct cec_adapter *adap)
-{
-	cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false);
-}
-
 /**
  * cec_get_edid_spa_location() - find location of the Source Physical Address
  *
-- 
2.53.0


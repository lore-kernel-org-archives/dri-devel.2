Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA745606A332
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dy7im1XX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567DA10F3EC;
	Tue,  3 Nov 2026 07:40:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BA310F3F3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ECD56062C;
 Tue,  3 Nov 2026 07:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097971F00A02;
 Tue,  3 Nov 2026 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691632;
 bh=Tk4nRbPLQTDD3Vxx5Td4+Sb0G3KcQ+agEAA/kRIvTS0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dy7im1XX1VJQ/tcbj04356aSPaqfdKnkjpqoN2u0blSHi8i3VZ7IMfqe7xLNdxAds
 3AuCXrtKpDaN8G11SMtz2w6XwbYbOJbElyk5mka8f+7pWyBfCk/ZlYiil6eGsbUb90
 2HtTWzMREfRUXAhfPKl5pg06+Kg/woNa4jHNYTJ7uL7LiGxTObDQZBL8rI2HVZ7h64
 lpyxEaV8Y0a4smVdef0Vv4SDUSONVBIHnexfQEdDbX8/7Nme5NpHAxI/qaYE7CRZF+
 yu0+sE/O9HBSB33Pwt2/496ccJKr83iQMuv0XW5KnOe0A79JhB8V1DD1TfT9vzA0U5
 UiCarpjyLQvUw==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv2 06/13] media: cec: core: improve
 cec_notifier_phys_addr_invalidate
Date: Tue,  3 Nov 2026 08:31:57 +0100
Message-ID: <395c54fe832fcf48626928f858a98ac0fbf1c308.1793691124.git.hverkuil+cisco@kernel.org>
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

cec_notifier_phys_addr_invalidate must call cec_phys_addr_invalidate
instead of cec_s_phys_addr. This ensures that the CEC framework knowns
that there is no EDID.

Also update cec_notifier_cec_adap_register(): it has to remember if
the last set physical address was from an EDID or because there was
a disconnect.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/cec/core/cec-notifier.c | 26 +++++++++++++++++++--
 include/media/cec-notifier.h          | 33 +++++++++++++++------------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/media/cec/core/cec-notifier.c b/drivers/media/cec/core/cec-notifier.c
index 8cf1474d0361..5a4588487ea3 100644
--- a/drivers/media/cec/core/cec-notifier.c
+++ b/drivers/media/cec/core/cec-notifier.c
@@ -29,6 +29,7 @@ struct cec_notifier {
 	struct cec_adapter *cec_adap;
 
 	u16 phys_addr;
+	bool edid_present;
 };
 
 static LIST_HEAD(cec_notifiers);
@@ -113,6 +114,7 @@ cec_notifier_conn_register(struct device *hdmi_dev, const char *port_name,
 
 	mutex_lock(&n->lock);
 	n->phys_addr = CEC_PHYS_ADDR_INVALID;
+	n->edid_present = false;
 	if (conn_info)
 		n->conn_info = *conn_info;
 	else
@@ -135,6 +137,7 @@ void cec_notifier_conn_unregister(struct cec_notifier *n)
 	mutex_lock(&n->lock);
 	memset(&n->conn_info, 0, sizeof(n->conn_info));
 	n->phys_addr = CEC_PHYS_ADDR_INVALID;
+	n->edid_present = false;
 	if (n->cec_adap) {
 		if (!n->cec_adap->adap_controls_phys_addr)
 			cec_phys_addr_invalidate(n->cec_adap);
@@ -162,8 +165,12 @@ cec_notifier_cec_adap_register(struct device *hdmi_dev, const char *port_name,
 	n->cec_adap = adap;
 	adap->conn_info = n->conn_info;
 	adap->notifier = n;
-	if (!adap->adap_controls_phys_addr)
-		cec_s_phys_addr(adap, n->phys_addr, false);
+	if (!adap->adap_controls_phys_addr) {
+		if (n->phys_addr == CEC_PHYS_ADDR_INVALID && !n->edid_present)
+			cec_phys_addr_invalidate(adap);
+		else
+			cec_s_phys_addr(adap, n->phys_addr, false);
+	}
 	mutex_unlock(&n->lock);
 	return n;
 }
@@ -190,6 +197,7 @@ void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa)
 
 	mutex_lock(&n->lock);
 	n->phys_addr = pa;
+	n->edid_present = true;
 	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
 		cec_s_phys_addr(n->cec_adap, n->phys_addr, false);
 	mutex_unlock(&n->lock);
@@ -216,6 +224,20 @@ void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 }
 EXPORT_SYMBOL_GPL(cec_notifier_set_phys_addr_from_edid);
 
+void cec_notifier_phys_addr_invalidate(struct cec_notifier *n)
+{
+	if (!n)
+		return;
+
+	mutex_lock(&n->lock);
+	n->phys_addr = CEC_PHYS_ADDR_INVALID;
+	n->edid_present = false;
+	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
+		cec_phys_addr_invalidate(n->cec_adap);
+	mutex_unlock(&n->lock);
+}
+EXPORT_SYMBOL_GPL(cec_notifier_phys_addr_invalidate);
+
 struct device *cec_notifier_parse_hdmi_phandle(struct device *dev)
 {
 	struct platform_device *hdmi_pdev;
diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
index b1c839734124..15e9bcb5b887 100644
--- a/include/media/cec-notifier.h
+++ b/include/media/cec-notifier.h
@@ -80,7 +80,10 @@ void cec_notifier_cec_adap_unregister(struct cec_notifier *n,
  * @n: the CEC notifier
  * @pa: the CEC physical address
  *
- * Set a new CEC physical address.
+ * Set a new CEC physical address. @pa may be f.f.f.f, indicating that
+ * the EDID does not contain a valid Physical Address.
+ * Use @cec_notifier_phys_addr_invalidate() when there is no EDID at all,
+ * i.e. there is no video sink connected.
  * Does nothing if @n == NULL.
  */
 void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa);
@@ -96,6 +99,17 @@ void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa);
 void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 					  const struct edid *edid);
 
+/**
+ * cec_notifier_phys_addr_invalidate() - set the physical address to INVALID
+ *
+ * @n: the CEC notifier
+ *
+ * This is a simple helper function to invalidate the physical
+ * address when the video sink disappears.
+ * Does nothing if @n == NULL.
+ */
+void cec_notifier_phys_addr_invalidate(struct cec_notifier *n);
+
 /**
  * cec_notifier_parse_hdmi_phandle - find the hdmi device from "hdmi-phandle"
  * @dev: the device with the "hdmi-phandle" device tree property
@@ -143,6 +157,10 @@ static inline void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 {
 }
 
+static inline void cec_notifier_phys_addr_invalidate(struct cec_notifier *n)
+{
+}
+
 static inline struct device *cec_notifier_parse_hdmi_phandle(struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
@@ -150,17 +168,4 @@ static inline struct device *cec_notifier_parse_hdmi_phandle(struct device *dev)
 
 #endif
 
-/**
- * cec_notifier_phys_addr_invalidate() - set the physical address to INVALID
- *
- * @n: the CEC notifier
- *
- * This is a simple helper function to invalidate the physical
- * address. Does nothing if @n == NULL.
- */
-static inline void cec_notifier_phys_addr_invalidate(struct cec_notifier *n)
-{
-	cec_notifier_set_phys_addr(n, CEC_PHYS_ADDR_INVALID);
-}
-
 #endif
-- 
2.53.0


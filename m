Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29339606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ayPV2/yc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B327710F89A;
	Tue, 24 Nov 2026 22:46:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4635310ED03;
 Tue, 24 Nov 2026 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795560391; x=1827096391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TUNjnnZKvidmdSxYD6YdV9fJLhPd7vG4OSoTHg6IpVk=;
 b=ayPV2/ycZJUxsDrLVRKUtUv5oCir5eytJyH2zJMmQqY1FQNvaAzNhw+g
 e2eijMmTmqDvk18G4H5dBF1OtMB13c/07HWNCyWjVRZlD4uW7SJfPeFTc
 jVNJWH68n5nfL0kapzFg4h4BxMhsttIyzGlM4TmnHRRwsqaPduCiQG89s
 44uY4o9TdLbeSUhSQJnnX7Dgo+KZfmFil4wTe8bOHmDsoUhjVU7uWTJqW
 l4dG7/Tutjqih6mzOt1KDrgs5Wk7FoyB3rUqteg7CVFYynsNnX9MEQBcs
 Qmk4LLwt/pAKK13mCdbGOCMoayDYDLunNe3TbWB/haXfG0zLCnaEDQ43j w==;
X-CSE-ConnectionGUID: dR2bHMHEQ+iXYvEArXbNVw==
X-CSE-MsgGUID: PLQNDCY0R6OexyDiw4QNuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4396174"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4396174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:46:31 -0800
X-CSE-ConnectionGUID: Y2Ot0SLZQBaCl0KX8ffQxA==
X-CSE-MsgGUID: 2j6xOC35QCCAdAghFWjI2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11484749"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.204])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 14:46:29 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 1/2] drm/edid: Introduce drm_edid_get_displayid_product_id()
Date: Wed, 25 Nov 2026 00:46:20 +0200
Message-ID: <20261124224621.6506-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Add drm_displayid_get_product_id() as the DisplayID based
counterpart to the already existing EDID base block based
drm_edid_get_product_id().

In DisplayID the information is stored in the "Product ID"
block (0x00 or 0x20). The layout is slightly different to the
EDID one as the vendor ID is a three byte OUI isntead of
the compressed ASCII EISA/PNPID of EDID. The "year of
manufacture" is now relative to the year 2000, as opposed
to 1990 for EDID.

There is also a product ID string, but I decided to leave that
out from the user visible struct because the variable length
would just complicate things.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_displayid_internal.h | 11 ++++++
 drivers/gpu/drm/drm_edid.c               | 49 ++++++++++++++++++++++++
 include/drm/drm_edid.h                   | 10 +++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index ef7e6c9bd4db..2177c19cae4c 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -103,6 +103,17 @@ struct displayid_block {
 	u8 num_bytes;
 } __packed;
 
+struct displayid_product_id_block {
+	struct displayid_block base;
+	u8 vendor_id[3];
+	__le16 product_code;
+	__le32 serial_number;
+	u8 week_of_manufacture;
+	u8 year_of_manufacture;
+	u8 size_of_product_id_string;
+	u8 product_id_string[];
+} __packed;
+
 struct displayid_tiled_block {
 	struct displayid_block base;
 	u8 tile_cap;
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index b8f882a17c8f..8bde2a9cebb4 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2791,6 +2791,55 @@ void drm_edid_get_product_id(const struct drm_edid *drm_edid,
 }
 EXPORT_SYMBOL(drm_edid_get_product_id);
 
+static bool displayid_is_product_id_block(const struct displayid_iter *iter,
+					  const struct displayid_block *block)
+{
+	return (displayid_version(iter) < DISPLAY_ID_STRUCTURE_VER_20 &&
+		block->tag == DATA_BLOCK_PRODUCT_ID) ||
+		(displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+		 block->tag == DATA_BLOCK_2_PRODUCT_ID);
+}
+
+/**
+ * drm_displayid_get_product_id - Get the vendor and product identification from DisplayID
+ * @drm_edid: EDID
+ * @id: Where to place the product id
+ */
+void drm_displayid_get_product_id(const struct drm_edid *drm_edid,
+				  struct drm_displayid_product_id *id)
+{
+	const struct displayid_block *block;
+	struct displayid_iter iter;
+
+	memset(id, 0, sizeof(*id));
+
+	if (!drm_edid)
+		return;
+
+	displayid_iter_edid_begin(drm_edid, &iter);
+	displayid_iter_for_each(block, &iter) {
+		const struct displayid_product_id_block *prod_id =
+			(struct displayid_product_id_block *)block;
+
+		if (!displayid_is_product_id_block(&iter, block))
+			continue;
+
+		if (block->num_bytes < sizeof(*prod_id) - sizeof(prod_id->base))
+			continue;
+
+		id->vendor_id[0] = prod_id->vendor_id[0];
+		id->vendor_id[1] = prod_id->vendor_id[1];
+		id->vendor_id[2] = prod_id->vendor_id[2];
+		id->product_code = prod_id->product_code;
+		id->serial_number = prod_id->serial_number;
+		id->week_of_manufacture = prod_id->week_of_manufacture;
+		id->year_of_manufacture = prod_id->year_of_manufacture;
+		break;
+	}
+	displayid_iter_end(&iter);
+}
+EXPORT_SYMBOL(drm_displayid_get_product_id);
+
 static void decode_date(struct seq_buf *s, const struct drm_edid_product_id *id)
 {
 	int week = id->week_of_manufacture;
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index a2617aa34edf..b44c26d42217 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -288,6 +288,14 @@ struct drm_edid_product_id {
 	u8 year_of_manufacture;
 } __packed;
 
+struct drm_displayid_product_id {
+	u8 vendor_id[3];
+	__le16 product_code;
+	__le32 serial_number;
+	u8 week_of_manufacture;
+	u8 year_of_manufacture;
+} __packed;
+
 struct edid {
 	u8 header[8];
 	/* Vendor & product info */
@@ -484,6 +492,8 @@ int drm_edid_connector_add_modes(struct drm_connector *connector);
 bool drm_edid_is_digital(const struct drm_edid *drm_edid);
 void drm_edid_get_product_id(const struct drm_edid *drm_edid,
 			     struct drm_edid_product_id *id);
+void drm_displayid_get_product_id(const struct drm_edid *drm_edid,
+				  struct drm_displayid_product_id *id);
 void drm_edid_print_product_id(struct drm_printer *p,
 			       const struct drm_edid_product_id *id, bool raw);
 u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
-- 
2.56.1


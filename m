Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B13CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 18:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783C910E002;
	Sun, 11 Oct 2026 18:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gtucker.io header.i=@gtucker.io header.b="cMPk/QHt";
	dkim-atps=neutral
X-Greylist: delayed 2599 seconds by postgrey-1.36 at gabe;
 Sun, 11 Oct 2026 18:47:37 UTC
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DA910E002;
 Sun, 11 Oct 2026 18:47:37 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 by mslow3.mail.gandi.net (Postfix) with ESMTP id 357CE58011F;
 Sun, 11 Oct 2026 17:47:04 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ACF63F0A4;
 Sun, 11 Oct 2026 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
 t=1791740821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X7VrsDvVsYsTaXUVkNX/JDkKURCHeNYcbgIz5JEwd38=;
 b=cMPk/QHt9fSefcMEopoPzBSFYm+ZiFvFYAdWWl+RQWp/c1qotyCUMSCjowxJumr2BznA7f
 CKEzShhv3GFgSXEXdUYyHjOjdTTwwEge4CsVsI/Digbq8h3YPmsRxKRPS1JsSiMECiDQnR
 hzfjAH1Ix1H+u86sVLMoGMb2vml6y4Nym+jNZJJSXV6NS9nfT37jM1AQHphlLb8G/9J47F
 lh/w7uTD1X50mWHo7raKlpuamaebzq/0iIA8meai60gF9hHaPRyqE898s1RIGuWv7P7hDv
 GqAZVplvDzzsLS+MeZVWaZXcPN1ySmnpq5+46xBgsqWCTIBZGyvufP2Y0WsIxw==
From: Guillaume Tucker <gtucker@gtucker.io>
To: Guillaume Tucker <gtucker@gtucker.io>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 Badal Nilawar <badal.nilawar@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 Stuart Summers <stuart.summers@intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe/log: fix documentation title levels
Date: Sun, 11 Oct 2026 19:46:53 +0200
Message-ID: <2320050536ca29afe69ecd163eb974a40df571fc.1791740369.git.gtucker@gtucker.io>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gtucker@gtucker.io
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGUXyJjU/OcpBuci7LmotG4qBy+yk9KsO+tzVjmIpjR/ykPYKbfVbxiRlrUf4AuIteDQwkg/es1YyJ+xTByrUjnU4XRZ/jqL6asUQ2iwOJt4gOYL6/lBE8BQwzxYfgidSoeGnSdRCrPChzQVWuIdsiDZ6Fis9zTOiOWewf6RSVS+jSwVwlDOIiPZGvz3gzYk/wI8HPEyTtzkog1ZfkMxdGyzomXwNmmHHEs9WjteNlegNe1/HShi8T7gBcgSU228XpiF9AhUhC2zhVGSEWI6S7OsALH175rbBYcSUYC5tqWS2jDjucVSEQ4NagjWWqyrjXCM+73PCwX0X1bJtrcnu8OtHhUurW8IcDAQmF+/VrgFRJgxDYsj4m8z7AFCEdbpjsUbWf8nBZPjvHINWdXYL9QC1LWXGt7i3N8IuFysvu985VG9SuXMGEKKG5K3LGAAuw/ZDCLTqjU+RS0M3bRBmLpNQK3vQgme66xiIyCcP4ZkAFgPj6n9Knhf+Ov6pvEBXSWg4HE0p0igI3spnJQOayc0BNrKdYUAv8yTOMgtY+YAXkG+hi6G3Lx+9I+VNd9dMGqECzF8HtCJ9qbbHiTM5LkkNDI+UQZereWPEcXm90r2ARGbLom/sAya3aNsG0tEnydalmvRVgQUeIqY8cuHBjkxYmmyJmEZR1Z3cbNdmvEuw
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Fix an htmldocs build error in the gpu/xe section by moving all the
titles one level higher in the Xe SIGID page to keep a consistent
hierarchy.  This is the error message:

    Documentation/gpu/xe/xe_sigid.rst:10: (SEVERE/4) Title level inconsistent:

All the other pages in the xe section use <h2> titles so follow the
same convention here as well.

Signed-off-by: Guillaume Tucker <gtucker@gtucker.io>
---
 drivers/gpu/drm/xe/abi/xe_sigid_abi.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/abi/xe_sigid_abi.h b/drivers/gpu/drm/xe/abi/xe_sigid_abi.h
index 2f3440505f69..277b15fce9cc 100644
--- a/drivers/gpu/drm/xe/abi/xe_sigid_abi.h
+++ b/drivers/gpu/drm/xe/abi/xe_sigid_abi.h
@@ -10,14 +10,14 @@
  * DOC: Xe Error Signatures (SIGID)
  *
  * What SIGID stands for
- * ---------------------
+ * =====================
  *
  * SIGID is short for *Signature Identifier*. It is a small, stable integer
  * that names one of the *recognised fault sites* -- nothing more. It is the
  * primary handle used for triage and maps directly to a specific report site.
  *
  * Numbering
- * ---------
+ * =========
  *
  * SIGIDs are a single flat list numbered sequentially within the assigned range,
  * in the order the fault sites were introduced. Values are stable: once assigned
@@ -25,7 +25,7 @@
  * SIGID value is deprecated in place, never re-purposed.
  *
  * Why this exists
- * ---------------
+ * ===============
  *
  * Today the driver reports faults with ad-hoc ``xe_err()`` / ``xe_gt_err()``
  * strings that have no stable shape. That is fine for a human reading dmesg,
@@ -37,7 +37,7 @@
  * firmware versions, and (eventually) across other Intel devices in a node.
  *
  * What a SIGID is not
- * -------------------
+ * ===================
  *
  * SIGID deliberately does not encode the detailed reason or the outcome. Those
  * are carried alongside it::
@@ -51,7 +51,7 @@
  * different severities depending on the instance and the recovery taken.
  *
  * When to use SIGID logging
- * -------------------------
+ * =========================
  *
  * The xe_log_*() helpers are for these recognised fault sites only --
  * important, operator-relevant faults and events. The driver's only job is to
@@ -63,7 +63,7 @@
  * those that correspond to a published fault site.
  *
  * SIGID log output (dmesg vs. the machine record)
- * -----------------------------------------------
+ * ===============================================
  *
  * The dmesg line stays close to a normal xe error message so it remains
  * readable for admins; the only stable, machine-matchable token on it is
@@ -74,7 +74,7 @@
  * carrying the same SIGID (generation is a planned follow-up).
  *
  * How to pick a SIGID (the uniqueness rule)
- * -----------------------------------------
+ * =========================================
  *
  * Pick per *report site*, not per incident. Each site emits the single most
  * specific recognised SIGID *for that site* -- so the question is never
@@ -95,7 +95,7 @@
  * after making significant changes to the site that emits this SIGID.
  *
  * Scope: software vs hardware emitted signatures
- * ----------------------------------------------
+ * ==============================================
  *
  * Some SIGID represents fault sites that the *driver itself* detects and
  * reports from the software POV: probe abort, wedged, survivability, driver-
-- 
2.47.3


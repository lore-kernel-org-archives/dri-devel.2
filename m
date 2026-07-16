Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDBAC44519
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF4510E398;
	Thu, 16 Jul 2026 17:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="jFoj39dy";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB6A10E312;
 Thu, 16 Jul 2026 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784221779;
 bh=GubTlQat6UlimM/bcLKvGJ1gJF4TTwUHaWco6h44H3Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jFoj39dycLqDhiZ/HE2WOecxEDywP3bgZ4iV95iXaFEZtXShQqiGJ/bYsYnE1bDrv
 jnDT/1cUrvnKZWESVk/8Hv78qoynxiqOjE3Vj+hS6LUrgqZMA7WARjHgun+iXgt3Ju
 P/UuUQ1C8vqoZdk33gTnGDKE5+KxNts3SVqDC1yU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:27 +0200
Subject: [PATCH 2/6] configfs: Constify is_visible/is_visible_bin in
 configfs_group_operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-2-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=3113;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GubTlQat6UlimM/bcLKvGJ1gJF4TTwUHaWco6h44H3Y=;
 b=+sEBU8Jt02gLhwZLB6K47bnC0/qyt/YKihbwKPC9VgN0n6o0EqABg+QnHDz6bwxVU5djJq9LB
 Lxa3CssRiovA2VWJwM69q10UwWQTZRJqxtJX4gZMHRnfgZ89T5XaxTL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
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

These callbacks are never meant to modify their configfs_attribute
structure. Enforce this in the type system.

As there are only two implementers of these callbacks, adapt them right
away, avoiding a phased transition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/xe/xe_configfs.c | 4 ++--
 drivers/virt/coco/guest/report.c | 4 ++--
 include/linux/configfs.h         | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_configfs.c
index 32102600a148..a5f696e7b329 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -843,7 +843,7 @@ static struct configfs_item_operations xe_config_device_ops = {
 };
 
 static bool xe_config_device_is_visible(struct config_item *item,
-					struct configfs_attribute *attr, int n)
+					const struct configfs_attribute *attr, int n)
 {
 	struct xe_config_group_device *dev = to_xe_config_group_device(item);
 
@@ -938,7 +938,7 @@ static struct configfs_attribute *xe_config_sriov_attrs[] = {
 };
 
 static bool xe_config_sriov_is_visible(struct config_item *item,
-				       struct configfs_attribute *attr, int n)
+				       const struct configfs_attribute *attr, int n)
 {
 	struct xe_config_group_device *dev = to_xe_config_group_device(item->ci_parent);
 
diff --git a/drivers/virt/coco/guest/report.c b/drivers/virt/coco/guest/report.c
index b254a1416286..96e89ddf4989 100644
--- a/drivers/virt/coco/guest/report.c
+++ b/drivers/virt/coco/guest/report.c
@@ -381,7 +381,7 @@ static struct configfs_item_operations tsm_report_item_ops = {
 };
 
 static bool tsm_report_is_visible(struct config_item *item,
-				  struct configfs_attribute *attr, int n)
+				  const struct configfs_attribute *attr, int n)
 {
 	guard(rwsem_read)(&tsm_rwsem);
 	if (!provider.ops)
@@ -394,7 +394,7 @@ static bool tsm_report_is_visible(struct config_item *item,
 }
 
 static bool tsm_report_is_bin_visible(struct config_item *item,
-				      struct configfs_bin_attribute *attr, int n)
+				      const struct configfs_bin_attribute *attr, int n)
 {
 	guard(rwsem_read)(&tsm_rwsem);
 	if (!provider.ops)
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ef65c75beeaa..5d3fc8822a1d 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -220,8 +220,8 @@ struct configfs_group_operations {
 	struct config_group *(*make_group)(struct config_group *group, const char *name);
 	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
 	void (*drop_item)(struct config_group *group, struct config_item *item);
-	bool (*is_visible)(struct config_item *item, struct configfs_attribute *attr, int n);
-	bool (*is_bin_visible)(struct config_item *item, struct configfs_bin_attribute *attr,
+	bool (*is_visible)(struct config_item *item, const struct configfs_attribute *attr, int n);
+	bool (*is_bin_visible)(struct config_item *item, const struct configfs_bin_attribute *attr,
 			       int n);
 };
 

-- 
2.55.0


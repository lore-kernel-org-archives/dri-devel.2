Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8001DC44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C39710E393;
	Thu, 16 Jul 2026 17:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="IuXGRLdz";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A6B10E393;
 Thu, 16 Jul 2026 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784221779;
 bh=dltgcbowZmeUaJ3uOqqeFmdJ7eim65T+5MLbFYQBbL0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IuXGRLdzw4f6EMx+bMUC8KURlIf+kmJmq86UCLM78bDQBG0BYevEr6YS6mtrSSRst
 f5CVc8ZwHa+A6EGy+OTgDkyqDwbyWEDGcqHOFsh46hQxOqn8Ab9T7bYKbay7wNeTkR
 d+DrDHcZqpg5YD4ziKtb9qbyDYmYBvJvHvv6pDNc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:29 +0200
Subject: [PATCH 4/6] configfs: Constify configfs_bin_attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-4-c545a4053cb5@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=5822;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dltgcbowZmeUaJ3uOqqeFmdJ7eim65T+5MLbFYQBbL0=;
 b=+ItfgbuT+kmF0PK8QxYS9YMhv1kJXQvCv+7X9O/FnYE5GBzFy57Xd/FFvla3WFPGRW6ZTXBY2
 mZhZlW6OC4LCJcZOrVCqjJRJGmRAdRINNctDxlyV0k/nDg8iQYPUi/b
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

The configfs_bin_attribute structures defined by driver are never
modified. Make them const.

As there are only two users of these attributes, adapt them in the same
commit to avoid a phased transition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/acpi_configfs.c     |  2 +-
 drivers/virt/coco/guest/report.c |  2 +-
 include/linux/configfs.h         | 64 ++++++++++++++++++++--------------------
 rust/kernel/configfs.rs          |  4 +--
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 12ffec795803..6071699c7165 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -91,7 +91,7 @@ static ssize_t acpi_table_aml_read(struct config_item *cfg,
 
 CONFIGFS_BIN_ATTR(acpi_table_, aml, NULL, MAX_ACPI_TABLE_SIZE);
 
-static struct configfs_bin_attribute *acpi_table_bin_attrs[] = {
+static const struct configfs_bin_attribute *const acpi_table_bin_attrs[] = {
 	&acpi_table_attr_aml,
 	NULL,
 };
diff --git a/drivers/virt/coco/guest/report.c b/drivers/virt/coco/guest/report.c
index 96e89ddf4989..ad400fbe53f0 100644
--- a/drivers/virt/coco/guest/report.c
+++ b/drivers/virt/coco/guest/report.c
@@ -356,7 +356,7 @@ static struct configfs_attribute *tsm_report_attrs[] = {
 	NULL,
 };
 
-static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
+static const struct configfs_bin_attribute *const tsm_report_bin_attrs[] = {
 	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
 	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
 	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 5d3fc8822a1d..eff2fb22ab70 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -67,7 +67,7 @@ struct config_item_type {
 	const struct configfs_item_operations	*ct_item_ops;
 	const struct configfs_group_operations	*ct_group_ops;
 	struct configfs_attribute		**ct_attrs;
-	struct configfs_bin_attribute		**ct_bin_attrs;
+	const struct configfs_bin_attribute	*const *ct_bin_attrs;
 };
 
 /**
@@ -160,41 +160,41 @@ struct configfs_bin_attribute {
 	ssize_t (*write)(struct config_item *, const void *, size_t);
 };
 
-#define CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz)		\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IRUGO | S_IWUSR,		\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.read		= _pfx##_name##_read,			\
-	.write		= _pfx##_name##_write,			\
+#define CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz)			\
+static const struct configfs_bin_attribute _pfx##attr_##_name = {	\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IRUGO | S_IWUSR,			\
+		.ca_owner	= THIS_MODULE,				\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.read		= _pfx##_name##_read,				\
+	.write		= _pfx##_name##_write,				\
 }
 
-#define CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz)	\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IRUGO,			\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.read		= _pfx##_name##_read,			\
+#define CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz)		\
+static const struct configfs_bin_attribute _pfx##attr_##_name = {	\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IRUGO,				\
+		.ca_owner	= THIS_MODULE,				\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.read		= _pfx##_name##_read,				\
 }
 
-#define CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz)	\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IWUSR,			\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.write		= _pfx##_name##_write,			\
+#define CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz)		\
+static const struct configfs_bin_attribute _pfx##attr_##_name = {	\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IWUSR,				\
+		.ca_owner	= THIS_MODULE,				\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.write		= _pfx##_name##_write,				\
 }
 
 /*
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index b33fb2e9adf1..f99a6e376fa3 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -757,7 +757,7 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
                         ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
-                        ct_bin_attrs: core::ptr::null_mut(),
+                        ct_bin_attrs: core::ptr::null(),
                     }),
                     _p: PhantomData,
                 }
@@ -774,7 +774,7 @@ pub const fn new<const N: usize>(
                         ct_group_ops: core::ptr::null(),
                         ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
-                        ct_bin_attrs: core::ptr::null_mut(),
+                        ct_bin_attrs: core::ptr::null(),
                     }),
                     _p: PhantomData,
                 }

-- 
2.55.0


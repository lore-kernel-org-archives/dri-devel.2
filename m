Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E77C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4116C10E38E;
	Thu, 16 Jul 2026 17:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="PGjNtLke";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B934010E38E;
 Thu, 16 Jul 2026 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784221779;
 bh=9YZesc5wcXlynZX+h2DL+YsI2VfvK0ZmkJiEnkQRKNY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PGjNtLke6YGPB964aaVBz4MAWVNniRPsAqXwlv8pVmFv9TChaWf2Gk/zVXB9DEyG1
 VZw3tihOZBwj+lTJ077L+4waZcGSDgZ4nMS1MxvlSsdPR0C7yCFNEuWi1QgOljhe1t
 01zc+/tPiDSfvQNVTmIed98XYxEyb5d7orrCtGE4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:28 +0200
Subject: [PATCH 3/6] configfs: Treat attribute structures as const internally
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-3-c545a4053cb5@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=3841;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9YZesc5wcXlynZX+h2DL+YsI2VfvK0ZmkJiEnkQRKNY=;
 b=n+mbJ+otyx8qMM6l8Vc3E+5CAxdDYeaMfR9dv5eIQzMk+XXKgH0vhEYfsIEgL6Q0umHcANnma
 BIkvWu9KfcHBrT9wRpU/i2Jcxjy5UMrgog7uvwZ8+AfffbtJssC83Fn
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

The configfs core never modifies the attribute structures defined in
driver core.

Reflect this in the types used internally in the configfs core.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/configfs/configfs_internal.h | 10 +++++-----
 fs/configfs/dir.c               |  6 +++---
 fs/configfs/file.c              |  6 +++---
 fs/configfs/inode.c             |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index acdeea8e2d69..4bc19cd8d666 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -104,17 +104,17 @@ static inline struct config_item * to_item(struct dentry * dentry)
 	return ((struct config_item *) sd->s_element);
 }
 
-static inline struct configfs_attribute * to_attr(struct dentry * dentry)
+static inline const struct configfs_attribute * to_attr(struct dentry * dentry)
 {
 	struct configfs_dirent * sd = dentry->d_fsdata;
-	return ((struct configfs_attribute *) sd->s_element);
+	return ((const struct configfs_attribute *) sd->s_element);
 }
 
-static inline struct configfs_bin_attribute *to_bin_attr(struct dentry *dentry)
+static inline const struct configfs_bin_attribute *to_bin_attr(struct dentry *dentry)
 {
-	struct configfs_attribute *attr = to_attr(dentry);
+	const struct configfs_attribute *attr = to_attr(dentry);
 
-	return container_of(attr, struct configfs_bin_attribute, cb_attr);
+	return container_of_const(attr, struct configfs_bin_attribute, cb_attr);
 }
 
 static inline struct config_item *configfs_get_config_item(struct dentry *dentry)
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 3c88f13f1ca2..9a5c2bc4065d 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -461,7 +461,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 		 */
 		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
 		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
-			struct configfs_attribute *attr = sd->s_element;
+			const struct configfs_attribute *attr = sd->s_element;
 			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 
 			dentry->d_fsdata = configfs_get(sd);
@@ -622,8 +622,8 @@ static int populate_attrs(struct config_item *item)
 {
 	const struct config_item_type *t = item->ci_type;
 	const struct configfs_group_operations *ops;
-	struct configfs_attribute *attr;
-	struct configfs_bin_attribute *bin_attr;
+	const struct configfs_attribute *attr;
+	const struct configfs_bin_attribute *bin_attr;
 	int error = 0;
 	int i;
 
diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index a48cece775a3..6460b000c593 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -41,8 +41,8 @@ struct configfs_buffer {
 	struct config_item	*item;
 	struct module		*owner;
 	union {
-		struct configfs_attribute	*attr;
-		struct configfs_bin_attribute	*bin_attr;
+		const struct configfs_attribute		*attr;
+		const struct configfs_bin_attribute	*bin_attr;
 	};
 };
 
@@ -291,7 +291,7 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct configfs_fragment *frag = to_frag(file);
-	struct configfs_attribute *attr;
+	const struct configfs_attribute *attr;
 	struct configfs_buffer *buffer;
 	int error;
 
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 68290fe0e374..69f1f24e890f 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -178,7 +178,7 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
  */
 const unsigned char * configfs_get_name(struct configfs_dirent *sd)
 {
-	struct configfs_attribute *attr;
+	const struct configfs_attribute *attr;
 
 	BUG_ON(!sd || !sd->s_element);
 

-- 
2.55.0


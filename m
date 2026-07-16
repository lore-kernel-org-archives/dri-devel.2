Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0007AC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B3F10E312;
	Thu, 16 Jul 2026 17:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="Zf7EijZL";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EC410E393;
 Thu, 16 Jul 2026 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784221779;
 bh=Jqeaf0RHmFHchKboHfe8TOAt/Yn8lf+aa6AK+WDbCKg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Zf7EijZLkQo1v/bOfZjO64Vgr+61+x6LOIbk2F2XVPt5NpNS+YOEfZVMKvO/LrAkw
 EBxR+ewG2SeKkW5VnXE7Sm+hZERYjnDJzC593yzsaMvY6Skp6clnL4wXYs4Zu0hpRW
 JONccwxIld905RKugoIEfKUTCnijiWpKNkeKYTho=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:31 +0200
Subject: [PATCH 6/6] samples: configfs: constify the configfs_attribute
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-6-c545a4053cb5@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=3081;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Jqeaf0RHmFHchKboHfe8TOAt/Yn8lf+aa6AK+WDbCKg=;
 b=7bDJtJqi2GwzcclrqO13otP/cHLvBoTe7MLJ8jjBiXrkkJXi3AfXGL9BGkA/sJ1Ohf1Di9KIa
 GwLutWLJ9x8AjIIoXiPjTXSpZ30RE48fGviKUafVk3UIuY78ChApoyH
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

To show that the transition machinery works, constify the sample code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 samples/configfs/configfs_sample.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index c1b108ec4ea0..9788ec9b8e30 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -84,7 +84,7 @@ CONFIGFS_ATTR_RO(childless_, showme);
 CONFIGFS_ATTR(childless_, storeme);
 CONFIGFS_ATTR_RO(childless_, description);
 
-static struct configfs_attribute *childless_attrs[] = {
+static const struct configfs_attribute *const childless_attrs[] = {
 	&childless_attr_showme,
 	&childless_attr_storeme,
 	&childless_attr_description,
@@ -92,7 +92,7 @@ static struct configfs_attribute *childless_attrs[] = {
 };
 
 static const struct config_item_type childless_type = {
-	.ct_attrs	= childless_attrs,
+	.ct_attrs_const	= childless_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -148,7 +148,7 @@ static ssize_t simple_child_storeme_store(struct config_item *item,
 
 CONFIGFS_ATTR(simple_child_, storeme);
 
-static struct configfs_attribute *simple_child_attrs[] = {
+static const struct configfs_attribute *const simple_child_attrs[] = {
 	&simple_child_attr_storeme,
 	NULL,
 };
@@ -164,7 +164,7 @@ static const struct configfs_item_operations simple_child_item_ops = {
 
 static const struct config_item_type simple_child_type = {
 	.ct_item_ops	= &simple_child_item_ops,
-	.ct_attrs	= simple_child_attrs,
+	.ct_attrs_const	= simple_child_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -205,7 +205,7 @@ static ssize_t simple_children_description_show(struct config_item *item,
 
 CONFIGFS_ATTR_RO(simple_children_, description);
 
-static struct configfs_attribute *simple_children_attrs[] = {
+static const struct configfs_attribute *const simple_children_attrs[] = {
 	&simple_children_attr_description,
 	NULL,
 };
@@ -230,7 +230,7 @@ static const struct configfs_group_operations simple_children_group_ops = {
 static const struct config_item_type simple_children_type = {
 	.ct_item_ops	= &simple_children_item_ops,
 	.ct_group_ops	= &simple_children_group_ops,
-	.ct_attrs	= simple_children_attrs,
+	.ct_attrs_const	= simple_children_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -283,7 +283,7 @@ static ssize_t group_children_description_show(struct config_item *item,
 
 CONFIGFS_ATTR_RO(group_children_, description);
 
-static struct configfs_attribute *group_children_attrs[] = {
+static const struct configfs_attribute *const group_children_attrs[] = {
 	&group_children_attr_description,
 	NULL,
 };
@@ -298,7 +298,7 @@ static const struct configfs_group_operations group_children_group_ops = {
 
 static const struct config_item_type group_children_type = {
 	.ct_group_ops	= &group_children_group_ops,
-	.ct_attrs	= group_children_attrs,
+	.ct_attrs_const	= group_children_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 

-- 
2.55.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD39AC5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95CF10EFFA;
	Thu, 30 Jul 2026 17:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="U0OgeggQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E9310EFF8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4105444E8C;
 Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03FBEC2BCFC;
 Thu, 30 Jul 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1785431151; bh=WZR8Y42ND9E/OAlX111HbpPcKsxTChsq0oOfQ3+9UZM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=U0OgeggQO9XAL00a0Lyi35OLQFTK+lgiPeKS4qmN72pWx387JkERQVbhaBtOVKxdJ
 sJd6YYGWsuOVxaSSQoYbyIEuRiRPoFytyPFKfSKxYw6JA5XO9HnFuJ6vYAEboU5uLI
 7IX0+x5h0g9equU+dLAiCNGM5Adka3vWJXdsZZfU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DCF18C55171;
 Thu, 30 Jul 2026 17:05:50 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Fri, 31 Jul 2026 01:05:42 +0800
Subject: [PATCH v2 4/9] drm: move debugfs_init after dev->registered is set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-tyr-debugfs-v2-v2-4-aea19eccb996@linux.dev>
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Wambui Karuga <wambui.karugax@gmail.com>, 
 Eric Anholt <eric@anholt.net>, Ben Gamari <bgamari@gmail.com>, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785431148; l=1502;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=WZR8Y42ND9E/OAlX111HbpPcKsxTChsq0oOfQ3+9UZM=;
 b=Nu6+7BcxiJjyRPpf2u+1b0iaiSQBOJe051oW2rzfFeF1mot84+/iQEuu/d+7bnherhoaUo22G
 PErAWGVIR6SCpdLLCp+QzHtk1b2X3Lol0rBTsYH8E7OtNJA4IEi52sW
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

The debugfs_init callback was invoked by drm_debugfs_register before
dev->registered is set to true. Moving it to drm_dev_register after
dev->registered = true fixes the Ioctl type invariant violation.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/drm_debugfs.c | 3 ---
 drivers/gpu/drm/drm_drv.c     | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index ae1c6126c2c59..38cf6ce387cc8 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -442,9 +442,6 @@ int drm_debugfs_register(struct drm_minor *minor, int minor_id)
 	/* TODO: Only for compatibility with drivers */
 	minor->debugfs_root = dev->debugfs_root;
 
-	if (dev->driver->debugfs_init && dev->render != minor)
-		dev->driver->debugfs_init(minor);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e890052061f30..15669764fe625 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1101,6 +1101,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	dev->registered = true;
 	dev->unplugged = false;
 
+	/* Call debugfs_init after the device is fully registered. */
+	if (dev->driver->debugfs_init && dev->primary &&
+	    dev->render != dev->primary)
+		dev->driver->debugfs_init(dev->primary);
+
 	if (driver->load) {
 		ret = driver->load(dev, flags);
 		if (ret)

-- 
2.43.0



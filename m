Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EC5C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090C510E107;
	Fri, 14 Aug 2026 23:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="klIwKAVc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884B110E107
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:09:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 499294013D;
 Fri, 14 Aug 2026 23:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6781F00A3A;
 Fri, 14 Aug 2026 23:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786748990;
 bh=duuk6GqeoZYD9b1T5EoO3ZVOSGx2xP5WwTkfsxIM2Mg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=klIwKAVcrqKEMzr6LEehcpxVD9MEoUPr+7yL8WGqi+/7zfwY0kgFdJYvmHvV/O10m
 vu2CgWIZSJdVXB8RN/HLDJt4wRidQQsTV6v5Jg17WlqLe4Qwbq3vGrY+ZLO1HT0YAi
 4MDStLbCXA/7Dgt8zBXWZzB16IbD72CVM7BqVVYrQnG23l5w43GgCPy3D2H4b0JGjN
 4fnCUIpkNtgE6oII7q799o1KjEm/TdfvqtTx7uWsN8cgyMrpA+Iy5E1z70H34Sbq2x
 6WzEMQm+L8V+CxmiuvlHseeaMv8CwiAR+Ezye0Gqwwvuuraj179cmtfQr5g51DfSie
 eZhExL+zBC2qA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] rust: fs: add iminor() helper
Date: Sat, 15 Aug 2026 01:09:02 +0200
Message-ID: <20260814230923.1292966-5-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814230923.1292966-1-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a Rust helper for iminor(), which extracts the minor number from a
struct inode. This is a static inline function in the C headers, so
bindgen does not generate a binding for it.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/helpers/fs.c b/rust/helpers/fs.c
index 789d60fb8908..d6f9782db178 100644
--- a/rust/helpers/fs.c
+++ b/rust/helpers/fs.c
@@ -10,3 +10,8 @@ __rust_helper struct file *rust_helper_get_file(struct file *f)
 {
 	return get_file(f);
 }
+
+__rust_helper unsigned int rust_helper_iminor(const struct inode *inode)
+{
+	return iminor(inode);
+}
-- 
2.55.0


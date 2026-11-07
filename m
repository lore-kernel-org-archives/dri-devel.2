Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2C606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2AhsUWp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D0F10E505;
	Sat,  7 Nov 2026 02:20:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E55010E505
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:20:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9664F60E19;
 Sat,  7 Nov 2026 02:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FE01F008A1;
 Sat,  7 Nov 2026 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794018040;
 bh=5VoGbSf2C7HTPR246+u5IEih5QCONxIm9Z0CKtvp4HM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m2AhsUWpRM0xHjF9CkxdDhF/XKO0y1+4ezuERQ2SB2gFQL181sJk96pFng5Q6SnEC
 6cLOyr/bt+CMwF+f513RGamDnZTgWtqlDEKFBcMt01S1l585Ps7V98kAciJd/LX7vw
 AKfwPuPzw/dzO+tkH7Vlf74yv2F6GMZaAeIc0bAPdLt96XtHArz6dO7NgEtUcBsWHn
 +S6HySksSO6AS4XoioOjl9Eu7p9y2r/BkdAeKBr+tOZRcWMBAvv/O5v17dsRDFZylH
 DuB1/PKUhjIYa2zsrsnL95EsuANm78HYcETO90xqXPJU4nruQRhjprxhQJSUzmlw8S
 J55s85+cdSbPA==
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
Subject: [PATCH v2 4/7] rust: fs: add iminor() helper
Date: Sat,  7 Nov 2026 03:03:22 +0100
Message-ID: <20261107021427.2105374-5-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107021427.2105374-1-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
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

Add a Rust helper for iminor(), which extracts the minor number from a
struct inode. This is a static inline function in the C headers, so
bindgen does not generate a binding for it.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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
2.56.0


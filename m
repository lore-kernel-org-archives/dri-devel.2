Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54E606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=lQde1zTu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6413610E1C3;
	Wed, 21 Oct 2026 00:07:01 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A175C10E1C3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 00:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792541210; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KLwsshecwBIRiNUzvkmJZWS79qPETJGW3p7jZLP1MVUMHFBLsEzuundAiVP0YzMisaun0VHALpjSELxNJ3F0LZ/xr/E7DeeIozdyVAC6OUYr0lr22vR5Q1vnyn93PiPgCSZVTNe8o56ZXg1kW9td+NSd1Hfhz5Sqc0a7h/Cb2K8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792541210;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yKA+rjO6S2yRbNZMtjsewu159Akak1qQqcaEuzo5K58=; 
 b=hrFK28teCbN2oRro6CYfmvayNOhSwHbgRQAZ/e0PmvT0y3IPd+ZSnoYo5LBvIz3q53vXkHQW2zxvisidrGZ/G5OobO/XGKuji75LTZbmu6/cIGX7BhRgtGuUKUnqDcr05ph1GJmrh1qL8fktrySwI8rbq/f1KvTc5uv8JXfQ75A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792541210; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=yKA+rjO6S2yRbNZMtjsewu159Akak1qQqcaEuzo5K58=;
 b=lQde1zTuHBY1gsZZb4ZWAawXFOBL7sVIk378pR7XUSMj7M29kQiw7KI6gJw2AMHe
 zkQqPe/JK8FKY/OKM9lCtVUWpHkZy7ycS4XyCdSdjnYL+R+2lHKEaBS7mrandheg5IN
 Mu085UYJdDmvU6alVm3oNqwS3nBoZTCxI666rkzQ=
Received: by smtp.zohomail.com with SMTPS id 1792541208950353.81731289226013; 
 Tue, 20 Oct 2026 17:06:48 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 20 Oct 2026 17:06:46 -0700
Subject: [PATCH v4 2/3] rust: uaccess: add method to get UserPtr from u64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-dev_query_fixes-v4-2-df66b4c98bc6@collabora.com>
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
In-Reply-To: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=WNaLWF3sjYdXQjRj645udU5OHS/SnUHc+mDrPyN+V1M=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFk3mES/Rm15pjdFQOJ60F1vvlUZHzxd1dbOvb3Trrl+n
 VRwVvnujlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACbido2R4d/PzHsHZ7FEPFiV
 sEvh6xSVK9vuz03qM7F0W8lvzDpfoYqR4W69fdvnpSvSlvlXvlo0ebH+4VOl7+Y4HJ8oYsItfy3
 pMDsA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently a UserPtr can be created from a usize integer representing a
userspace address. To create a UserPtr from a u64 integer, the u64 must
be cast to usize. On 32-bit systems, this cast will discard the upper 32
bits of the address.

Provide a new method to create a UserPtr from a u64 integer. This avoids
the caller having to cast before creating a UserPtr and also clarifies
that the truncation is intended. This is equivalent to the C-side
macro u64_to_user_ptr() that provides typechecking and casting to a __user
pointer.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/uaccess.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 8e18285ec44b..a6fd1af155b3 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -31,6 +31,15 @@ pub fn from_addr(addr: usize) -> Self {
         Self(addr as *mut c_void)
     }
 
+    /// Create a `UserPtr` from a u64 userspace address.
+    ///
+    /// Deliberately truncate upper bits for 32-bit systems.
+    #[doc(alias = "u64_to_user_ptr")]
+    #[inline]
+    pub fn from_u64(addr: u64) -> Self {
+        Self::from_addr(addr as usize)
+    }
+
     /// Create a `UserPtr` from a pointer representing the userspace address.
     #[inline]
     pub fn from_ptr(addr: *mut c_void) -> Self {

-- 
2.56.0


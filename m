Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BEE9D82C
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9042010E173;
	Sun,  5 Apr 2026 23:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CDWPhZSp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F90110E173;
 Sun,  5 Apr 2026 23:54:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 021EF600AC;
 Sun,  5 Apr 2026 23:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433ABC2BCB0;
 Sun,  5 Apr 2026 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775433286;
 bh=kAA62WBPcurVVrTXPGLQy+IyDPvmVjelJYdVSSg7Y/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CDWPhZSpnW+m2srqW9KnMzV7G9L1iRvIsEo8KP7CScPqG1Ifub79N4yj4T0IKrXc0
 4XmCbJ8zDasSdrjt7qHAlDp9GjyKU1PVePB9pLKwO1yYKuqMmE+zMzS3f8ObYOQMzG
 Sz8I1kSAf+/0TbbLJC2pKQ0kqL3IFyIPFzgAagHeEGUpcHcDj1c0A7xusZQz9bbfR1
 FSgviWf3M31Ti8M4qq5aJadgtYloCGN8lrF7uyJTBqns8a/qMIIobVXaSkE/6gLioK
 tJwkSLx6bxzgYU0l/ny8XpR3fIxVt28+VUtoLh3KPsIh2WOCgv/Dnw0iO3ictk7CMV
 QrQTXJ8QympQw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>,
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: [PATCH v2 07/33] rust: allow globally `clippy::incompatible_msrv`
Date: Mon,  6 Apr 2026 01:52:43 +0200
Message-ID: <20260405235309.418950-8-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
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

`clippy::incompatible_msrv` is not buying us much, and we discussed
allowing it several times in the past.

For instance, there was recently another patch sent to `allow` it where
needed [1]. While that particular case would not be needed after the
minimum version bump to 1.85.0, it is simpler to just allow it to prevent
future instances.

Thus do so, and remove the last instance of locally allowing it we have
in the tree (except the one in the vendored `proc_macro2` crate).

Note that we still keep the `msrv` config option in `clippy.toml` since
that affects other lints as well.

Link: https://lore.kernel.org/rust-for-linux/20260404212831.78971-4-jhubbard@nvidia.com/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile               | 1 +
 rust/macros/helpers.rs | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a63684c36d60..78f5ee173eda 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::as_underscore \
 			    -Wclippy::cast_lossless \
 			    -Wclippy::ignored_unit_patterns \
+			    -Aclippy::incompatible_msrv \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
 			    -Aclippy::needless_lifetimes \
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 37ef6a6f2c85..d18fbf4daa0a 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -49,7 +49,6 @@ pub(crate) fn file() -> String {
     }
 
     #[cfg(CONFIG_RUSTC_HAS_SPAN_FILE)]
-    #[allow(clippy::incompatible_msrv)]
     {
         proc_macro::Span::call_site().file()
     }
-- 
2.53.0


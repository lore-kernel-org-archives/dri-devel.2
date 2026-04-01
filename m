Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E918AD35162
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9B610ED41;
	Wed,  1 Apr 2026 11:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z6epqT/3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671B010ED41;
 Wed,  1 Apr 2026 11:50:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 415E540572;
 Wed,  1 Apr 2026 11:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3B0C2BCB3;
 Wed,  1 Apr 2026 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044235;
 bh=KXEoYDiY4tZg0azDFGHapuIK6YBUiFWm2HgKzXD3/qA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z6epqT/35SK/XW00qh/dGMEY8eQVcyHYx4INTRg3DGJwwZO2DEpfLPeoC6WbWMBWj
 fOBMfjA+2XvvlHd77JbpGAWDf4jvDSWUSLaonqCi4v/JbkT9B3AGle1XggFswn+a2w
 Ck4aCqW9LerCrHjefnrFVAcqf1Pvnb0JE9Mp4FXEvuvoBDMYEYvChLTBRxv5YFk+Yb
 XfA2+ROngYg8eVEzlQ/9BscCvvEDBa5fxhsFNA1Y29pdLbXSbNsilKjFii99Mi3RCN
 NKgUqcGQQxj72UVwLp60Qzyy8WMCyoqrtqAsDBb2a9muO/Ua87fRO8oi7B5V5/t/kE
 Bl6pQowZGrc8Q==
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
Subject: [PATCH 23/33] docs: rust: quick-start: update Ubuntu versioned
 packages
Date: Wed,  1 Apr 2026 13:45:30 +0200
Message-ID: <20260401114540.30108-24-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
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

Now that the minimum supported Rust version is bumped, bump the versioned
Rust packages [1][2][3][4] to that version for Ubuntu in the Quick
Start guide.

In addition, add "may" to the `RUST_LIB_SRC` line since it does not look
like it is needed from a quick test in a Ubuntu 24.04 LTS container.

Link: https://packages.ubuntu.com/search?suite=all&searchon=names&keywords=rustc [1]
Link: https://packages.ubuntu.com/search?suite=all&searchon=names&keywords=bindgen [2]
Link: https://launchpad.net/ubuntu/+source/rustc-1.85 [3]
Link: https://launchpad.net/ubuntu/+source/rust-bindgen-0.71 [4]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 642efce04ee8..54fe491deb7d 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -112,33 +112,33 @@ Though Ubuntu 24.04 LTS and older versions still provide recent Rust
 releases, they require some additional configuration to be set, using
 the versioned packages, e.g.::
 
-	apt install rustc-1.80 rust-1.80-src bindgen-0.65 rustfmt-1.80 \
-		rust-1.80-clippy
-	ln -s /usr/lib/rust-1.80/bin/rustfmt /usr/bin/rustfmt-1.80
-	ln -s /usr/lib/rust-1.80/bin/clippy-driver /usr/bin/clippy-driver-1.80
+	apt install rustc-1.85 rust-1.85-src bindgen-0.71 rustfmt-1.85 \
+		rust-1.85-clippy
+	ln -s /usr/lib/rust-1.85/bin/rustfmt /usr/bin/rustfmt-1.85
+	ln -s /usr/lib/rust-1.85/bin/clippy-driver /usr/bin/clippy-driver-1.85
 
 None of these packages set their tools as defaults; therefore they should be
 specified explicitly, e.g.::
 
-	make LLVM=1 RUSTC=rustc-1.80 RUSTDOC=rustdoc-1.80 RUSTFMT=rustfmt-1.80 \
-		CLIPPY_DRIVER=clippy-driver-1.80 BINDGEN=bindgen-0.65
+	make LLVM=1 RUSTC=rustc-1.85 RUSTDOC=rustdoc-1.85 RUSTFMT=rustfmt-1.85 \
+		CLIPPY_DRIVER=clippy-driver-1.85 BINDGEN=bindgen-0.71
 
-Alternatively, modify the ``PATH`` variable to place the Rust 1.80 binaries
+Alternatively, modify the ``PATH`` variable to place the Rust 1.85 binaries
 first and set ``bindgen`` as the default, e.g.::
 
-	PATH=/usr/lib/rust-1.80/bin:$PATH
+	PATH=/usr/lib/rust-1.85/bin:$PATH
 	update-alternatives --install /usr/bin/bindgen bindgen \
-		/usr/bin/bindgen-0.65 100
-	update-alternatives --set bindgen /usr/bin/bindgen-0.65
+		/usr/bin/bindgen-0.71 100
+	update-alternatives --set bindgen /usr/bin/bindgen-0.71
 
-``RUST_LIB_SRC`` needs to be set when using the versioned packages, e.g.::
+``RUST_LIB_SRC`` may need to be set when using the versioned packages, e.g.::
 
-	RUST_LIB_SRC=/usr/src/rustc-$(rustc-1.80 --version | cut -d' ' -f2)/library
+	RUST_LIB_SRC=/usr/src/rustc-$(rustc-1.85 --version | cut -d' ' -f2)/library
 
 For convenience, ``RUST_LIB_SRC`` can be exported to the global environment.
 
-In addition, ``bindgen-0.65`` is available in newer releases (24.04 LTS and
-24.10), but it may not be available in older ones (20.04 LTS and 22.04 LTS),
+In addition, ``bindgen-0.71`` is available in newer releases (24.04 LTS),
+but it may not be available in older ones (20.04 LTS and 22.04 LTS),
 thus ``bindgen`` may need to be built manually (please see below).
 
 
-- 
2.53.0


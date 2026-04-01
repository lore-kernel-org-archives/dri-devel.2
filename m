Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD659D3517B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E8B10F085;
	Wed,  1 Apr 2026 11:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qt9hgTLa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F4910F085;
 Wed,  1 Apr 2026 11:51:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 67CD4404D6;
 Wed,  1 Apr 2026 11:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D57C116C6;
 Wed,  1 Apr 2026 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044294;
 bh=yKvVVQSsm3ADeF9w4UcOYUs55+Yf5zunUU3xGxiWVJk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qt9hgTLa2Us6ZAkjaDuidhhjBEvQbNdulZHZKXQzC+eR8wTzSc77xJJ4dkBB9WzzC
 56So1K8x2lvFO5CwxaplRlWHIiDYAL2Mi584X4uRylEkZluCLgYJv7XA2Ib5lu3mp9
 /0rASa7YRY69ivi92iRCKMtbZ8gRaxDbRECSS/jsbMr266RSERosPt+9kyn9IYS6PO
 /jrkgOh8JThQ7n5bruoE5xHV1QuoewRsBnEwccKdY1YZRxh5s2PfRgQiU1MSTkVgtN
 rJ2E7yTdsHe1fmPWtL3F7NSZDISppgJS77qEymsIzNL65GsE84OdkUOCPCwIz7gUv8
 Z7Ygn1YR5NvuA==
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
Subject: [PATCH 28/33] docs: rust: quick-start: remove GDB/Binutils mention
Date: Wed,  1 Apr 2026 13:45:35 +0200
Message-ID: <20260401114540.30108-29-ojeda@kernel.org>
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

The versions provided nowadays by even a distribution like Debian Stable
(and Debian Old Stable) are newer than those mentioned [1].

Thus remove the workaround.

Note that the minimum binutils version in the kernel is still 2.30, so
one could argue part of the note is still relevant, but it is unlikely
a kernel developer using such an old binutils is enabling Rust on a
modern kernel, especially when using distribution toolchains, e.g. the
Rust minimum version is not satisfied by Debian Old Stable.

So we are at the point where keeping the docs short and relevant for
essentially everyone is probably the better trade-off.

Link: https://packages.debian.org/search?suite=all&searchon=names&keywords=binutils [1]
Link: https://lore.kernel.org/all/CANiq72mCpc9=2TN_zC4NeDMpFQtPXAFvyiP+gRApg2vzspPWmw@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 5bbe059a8fa3..a6ec3fa94d33 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -352,12 +352,3 @@ Hacking
 To dive deeper, take a look at the source code of the samples
 at ``samples/rust/``, the Rust support code under ``rust/`` and
 the ``Rust hacking`` menu under ``Kernel hacking``.
-
-If GDB/Binutils is used and Rust symbols are not getting demangled, the reason
-is the toolchain does not support Rust's new v0 mangling scheme yet.
-There are a few ways out:
-
-- Install a newer release (GDB >= 10.2, Binutils >= 2.36).
-
-- Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
-  the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).
-- 
2.53.0


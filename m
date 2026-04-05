Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190B1E9D827
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C67910E1C0;
	Sun,  5 Apr 2026 23:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SleieeVb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7233D10E1C0;
 Sun,  5 Apr 2026 23:59:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 372C043A4D;
 Sun,  5 Apr 2026 23:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A143C2BCB3;
 Sun,  5 Apr 2026 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775433543;
 bh=Ob0EURwaNkw6X3vyMiyVx5p4YA+R0YJVDz2zrJCrIDo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SleieeVbsMR48SE9BcctZ4YV0A0xEVGFjeoRP6GlHQMyvsnA+Z+eNY5M1nRYNvIZt
 7KJKQ1eAS0XN4P+7lZYxCRTlGoT4Yo6REAwIeZ15tntbQLU27l4ezJWgkxjeMMr/49
 LUF6GOW7Da3+WTlOzlrnKsKoO7exsEoWRh8TNQ1lC3JrAaPRLWxkbKeyJMdVY4AYOX
 aLQBpaVJsAIJR4zR+We0+w1ur56cpRNmQxQ438r8TqBp37meh5kqpX7pe1SRcsFYO+
 HWQOezfhNcBXwhtyS3rgo86owQzO6/Z9B0U3MGgKB0QRTYuSuZ7fERNWVNUOdSqPpM
 eiUz4x+u5NrLw==
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
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 30/33] docs: rust: general-information: use real example
Date: Mon,  6 Apr 2026 01:53:06 +0200
Message-ID: <20260405235309.418950-31-ojeda@kernel.org>
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

Currently the example in the documentation shows a version-based name
for the Kconfig example:

    RUSTC_VERSION_MIN_107900

The reason behind it was to possibly avoid repetition in case several
features used the same minimum.

However, we ended up preferring to give them a descriptive name for each
feature added even if that could lead to some repetition. In practice,
the repetition has not happened so far, and even if it does at some point,
it is not a big deal.

Thus replace the example in the documentation with one of our current
examples (after removing previous ones from the bump), to show how they
actually look like, and in case someone `grep`s for it.

In addition, it has the advantage that it shows the `RUSTC_HAS_*`
pattern we follow in `init/Kconfig`, similar to the C side.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/general-information.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
index 91535b2306ed..09234bed272c 100644
--- a/Documentation/rust/general-information.rst
+++ b/Documentation/rust/general-information.rst
@@ -157,5 +157,5 @@ numerical comparisons, one may define a new Kconfig symbol:
 
 .. code-block:: kconfig
 
-	config RUSTC_VERSION_MIN_107900
-		def_bool RUSTC_VERSION >= 107900
+	config RUSTC_HAS_SPAN_FILE
+		def_bool RUSTC_VERSION >= 108800
-- 
2.53.0


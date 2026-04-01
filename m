Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC2ED35162
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2EF10F065;
	Wed,  1 Apr 2026 11:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sl4V3Ob2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA5610F065;
 Wed,  1 Apr 2026 11:48:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F3E5D6015B;
 Wed,  1 Apr 2026 11:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A4EC4CEF7;
 Wed,  1 Apr 2026 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044128;
 bh=ARQPdLFNgLGMMD7Hlk1KS8FPcB6q/KuXKhlNKcpj/sM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sl4V3Ob2163+RRCKSkLp4ZUuMaSDTTdLiFNQWuFCXKv1Krlrxuela9RxhT+4wUwjt
 yhYttjDbZQxVHrAv8b/esKNF8VdheRCH3Oqdk/2NAgGn2nejx2h4jXPJbvv4jYQuaV
 TjMZ/sfmInsww6vddePv9CyGl3rBljLG5MSbIM1HplnFVuq2+FuvEOKtxe7XZRnNrz
 CMgzmsPy7rtZc6T52JJnndKutrM/pbY6DTPy3eV6rHBgOeGBKJj34eqEze+SU45zwb
 4y3EKNzMX7CayXffABQD13PIYCldiSPMdtIKe0RW2wa3PA3X1DcERUC8zGiKtwfVVr
 pDCwDzyZt9PIQ==
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
Subject: [PATCH 14/33] rust: bump `bindgen` minimum supported version to
 0.71.1 (Debian Trixie)
Date: Wed,  1 Apr 2026 13:45:21 +0200
Message-ID: <20260401114540.30108-15-ojeda@kernel.org>
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

As proposed in the past in e.g. LPC 2025 and the Maintainers Summit [1],
we are going to follow Debian Stable's `bindgen` versions as our minimum
supported version.

Debian Trixie was released with `bindgen` 0.71.1, which it still uses
to this day [2].

Debian Trixie's release happened on 2025-08-09 [3], which means that a
fair amount of time has passed since its release for kernel developers
to upgrade.

Thus bump the minimum to the new version.

Then, in later commits, clean up most of the workarounds and other bits
that this upgrade of the minimum allows us.

Ubuntu 25.10 also has a recent enough `bindgen` [4] (even the already
unsupported Ubuntu 25.04 had it), and they also provide versioned packages
with `bindgen` 0.71.1 back to Ubuntu 24.04 LTS [5].

Link: https://lwn.net/Articles/1050174/ [1]
Link: https://packages.debian.org/trixie/bindgen [2]
Link: https://www.debian.org/releases/trixie/ [3]
Link: https://packages.ubuntu.com/search?suite=all&searchon=names&keywords=bindgen [4]
Link: https://launchpad.net/ubuntu/+source/rust-bindgen-0.71 [5]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/process/changes.rst | 2 +-
 scripts/min-tool-version.sh       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 474594bd4831..84156d031365 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -32,7 +32,7 @@ you probably needn't concern yourself with pcmciautils.
 GNU C                  8.1              gcc --version
 Clang/LLVM (optional)  15.0.0           clang --version
 Rust (optional)        1.85.0           rustc --version
-bindgen (optional)     0.65.1           bindgen --version
+bindgen (optional)     0.71.1           bindgen --version
 GNU make               4.0              make --version
 bash                   4.2              bash --version
 binutils               2.30             ld -v
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index a270ec761f64..b96ec2d379b6 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -34,7 +34,7 @@ rustc)
 	echo 1.85.0
 	;;
 bindgen)
-	echo 0.65.1
+	echo 0.71.1
 	;;
 *)
 	echo "$1: unknown tool" >&2
-- 
2.53.0


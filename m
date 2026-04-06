Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47734F46C45
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887B410E209;
	Mon,  6 Apr 2026 14:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEGFx0eM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7801610E209;
 Mon,  6 Apr 2026 14:29:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 03131442C1;
 Mon,  6 Apr 2026 14:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D41C2BC9E;
 Mon,  6 Apr 2026 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775485747;
 bh=Afu6edQrG07FmuDjVQyAb8ZDzLTPehav0qOEe/kll58=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=KEGFx0eMh26d0L6gnM8sQm6vO80fCkCwajiEWq55DbYlf1lvyZikY7hGf8bC3i1EE
 k302EG2GK1WXDQcHj/HLGkwFDqslJy9pREO4nRcPO0BatO33X0yHG/0Mkdbjh5AxIg
 k0SYaELN2vI5FSxwwReIWB4GATx3hgTJlZnt54inETe7sUhtXT0C5upNzc+LzkEIlw
 MeV+a3ngtaPjEgPrW5LtZSPNx58BGdVoB4CxUpedE8lj4vD8SnEOvA//mYTsTa2TUZ
 kyFhwJuTYfdcjcJNItGjPngC5KwzQMjPtKsAvIrXQYH0j4dTgCP7PeGsz0f7nQSjSF
 laolM3ZjdZ4hw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/33] rust: kbuild: remove `--remap-path-prefix`
 workarounds
From: Tamir Duberstein <tamird@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
In-Reply-To: <20260405235309.418950-2-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-2-ojeda@kernel.org>
Date: Mon, 06 Apr 2026 10:28:56 -0400
Message-Id: <177548573694.95472.17010833225003318383.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=tamird@kernel.org;
 h=from:subject:message-id; bh=Afu6edQrG07FmuDjVQyAb8ZDzLTPehav0qOEe/kll58=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJmXD2sHr5YMVVzekrqso+prW+u9a5pLvk7vctlTu6z/s
 9e3kg8eHRNZGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKZaYg8jw/XnzZd/HDmgzR4a3br492lzx4Dlt4p0vORnHRU2Px5RfpGRYYnEHn+
 e3KpS/y3FR6VlmVw49dIFktac+dywjE2H584TNgA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380
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

On Mon, 06 Apr 2026 01:52:37 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Commit 8cf5b3f83614 ("Revert "kbuild, rust: use -fremap-path-prefix
> to make paths relative"") removed `--remap-path-prefix` from the build
> system, so the workarounds are not needed anymore.
> 
> Thus remove them.
> 
> Note that the flag has landed again in parallel in this cycle in
> commit dda135077ecc ("rust: build: remap path to avoid absolute path"),
> together with `--remap-path-scope=macro` [1]. However, they are gated on
> `rustc-option-yn, --remap-path-scope=macro`, which means they are both
> only passed starting with Rust 1.95.0 [2]:
> 
> [...]

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>

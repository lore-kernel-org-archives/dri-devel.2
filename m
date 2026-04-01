Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811661112242
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D958E10ED72;
	Wed,  1 Apr 2026 23:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rkTpKuHx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B6210EEA9;
 Wed,  1 Apr 2026 23:00:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB37C61340;
 Wed,  1 Apr 2026 23:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913FAC2BCB0;
 Wed,  1 Apr 2026 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775084440;
 bh=f7bNWvbCaip5KR3t+m8FlzJxucJCS9MuU3xmUxzRBQQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=rkTpKuHxraABNs1iEnA7t8UmKYzqxbWf+Jo7sSf786NUHHgtjfod4j1ucj9XE9rl/
 9L2/jfkoa9sm7RSunu0xi5wD33s9o6R5Jr/xSE0XcCGp8LMiSNCt8VUyEJhByOr8Su
 Vdfz7Y6rzEWt1SDHoLOQzOR9HviU2Pa5MdI9YtqtfyjbXSu1nFiVfCEpA0yqoWW0wh
 awJ2CSdVhDvszgoD8DH6+443tm0kOXKY6gyHD7Hqe1RPXs78e3MZDWh6U5iyfGDxW5
 epEyO1osOP/fc2tlGquwpEvdyUYd8XfAw3QX4Fssplgqh4uOpwBmJEt+O7STb5JnpK
 pFJtKQuy3rZ5g==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 16/33] rust: rust_is_available: remove warning for <
 0.69.5 && libclang >= 19.1
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
In-Reply-To: <20260401114540.30108-17-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-17-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434453.73816.10916207587615828409.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=376; i=tamird@kernel.org;
 h=from:subject:message-id; bh=f7bNWvbCaip5KR3t+m8FlzJxucJCS9MuU3xmUxzRBQQ=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnFztr6e84qpsT/++mRlR2t/qbE/usuXPUTVRyhJO7L
 BdHNqp3TGRhEONisBRTZEkUPbQ3PfX2HtnMd8dh5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix0DHWMGLk4BmGr9ewz/IyM+1b7K7069LKgepa47J1xv3pKIzifnphmXTnun9+l1HSPDGyHpEBf
 OuMe8frM3vXTbcFryepnsjdPfr2669ZRrgtlXZgA=
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

On Wed, 01 Apr 2026 13:45:23 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> It is not possible anymore to fall into the issue that this warning was
> alerting about given the `bindgen` version bump.
> 
> Thus simplify by removing the machinery behind it, including tests.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>

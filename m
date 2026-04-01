Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C311112242
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E77D10EF56;
	Wed,  1 Apr 2026 23:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dTmUdMFx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0E010EF59;
 Wed,  1 Apr 2026 23:01:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E5FA6184D;
 Wed,  1 Apr 2026 23:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C13C2BCAF;
 Wed,  1 Apr 2026 23:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775084461;
 bh=1OJuineu8PClHjPsG3fYTbGnqTeEga0zV2kTfSmawb4=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=dTmUdMFxsYkxPmis09F9SPtnKde28cmwByv3QEYGqto19XeOKoBzECtJ/lACxN34o
 88cXDP+3MbErZiAQc5mmtQiNg1UibFr5dZcsHtaVz7SACwXHa0Hz4qkUtgQ6Yj+mPJ
 na3+ajNfZzKUWCzK7omgbHWSsEQLkWDQzNS0oDSRq40Fkh/Q3f8cakwVWBCC/hkOMN
 lFx1nv4C5gF/8FZsKBZaRqQIaPHAqv/Ph8wIC9QGk4mAiJWsfqXJc5ra05aJUvmSG2
 HkdNeJ7zsD0cgvxHfL7v26+nTHRtEd/OY/QYivMFyvEYSqf6Eastw5n6akb7nFjP3+
 hpnbteA57SHZA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 20/33] rust: kbuild: remove unneeded old `allow`s for
 generated layout tests
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
In-Reply-To: <20260401114540.30108-21-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-21-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434460.73816.4231801886718165891.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=536; i=tamird@kernel.org;
 h=from:subject:message-id; bh=1OJuineu8PClHjPsG3fYTbGnqTeEga0zV2kTfSmawb4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7v8ELVZvm0Ot+b2nHSn4DXRbVG6lwIVBPeIfpVdF
 WNTtDGsYyILgxgXg6WYIkui6KG96am398hmvjsOM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6BgzcHEKwFTPOM7I8CSkokjo+uZ/i/c/aufXnXUv/2TrD5PYeo0MiXjP+Nj5kxgZ3u/emnr
 vtdKxsy1q5tqh4RX8Ap/yk8PKcre53zn59dIRPgA=
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

On Wed, 01 Apr 2026 13:45:27 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> The issue that required `allow`s for `cfg(test)` code generated by
> `bindgen` for layout testing was fixed back in `bindgen` 0.60.0 [1],
> so it could have been removed even before the version bump, but it does
> not hurt.

How about ordering this, the previous patch, and the next patch ahead of
the version bump to avoid the need to mention it here?

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>

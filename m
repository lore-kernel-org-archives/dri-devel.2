Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F681FF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEADA10E4B5;
	Tue,  7 Apr 2026 19:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nNUSwfNE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A604110E4B5;
 Tue,  7 Apr 2026 19:39:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D661E600CB;
 Tue,  7 Apr 2026 19:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EA9C19421;
 Tue,  7 Apr 2026 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775590797;
 bh=Sno46JhFI760NPkogQ116vAaZuCkAaZXDubMzxmwzfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nNUSwfNEZw9bDkNaJQHNj/OmlPYGhEuAmgwCiLbEq0YbJ35JTmIBAg41OgPiBiYW5
 y+tiiQMPtG6lsbLfrlATM0a/GEVzNZu7+XbUY6ZKWRjpygjgvqofNny9vnsMHC80lC
 w537C3CqDTW/2eTLBlAwgZXxHQ6pJYUcKTVcA+uvu5jRMPD4cvGe03Q7E8rCx6GMNM
 3vC7kC0gMiPq96BMfBQhmbRkgzlPnJUm6Etp+KGaBMKzReWQIOU/IJoMcbZY14NzUI
 E3fD8KE7um5EhWNYCiyZm/Lv3GZhsA7tNbobA3ck87xl50/FttLLv5rgqh67Hk7ENi
 CGofMKdTBZMpQ==
Date: Tue, 7 Apr 2026 21:37:54 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>,
 Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org,
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Tamir Duberstein <tamird@kernel.org>
Subject: Re: [PATCH v2 24/33] docs: rust: quick-start: update minimum Ubuntu
 version
Message-ID: <adVdEsZEJanbkec4@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>,
 Christian Brauner <christian@brauner.io>,
 Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org,
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Tamir Duberstein <tamird@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
 <20260405235309.418950-25-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405235309.418950-25-ojeda@kernel.org>
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

On Mon, Apr 06, 2026 at 01:53:00AM +0200, Miguel Ojeda wrote:
> Ubuntu 25.04 is out of support [1], and Ubuntu 25.10 is the latest
> supported one.
> 
> Moreover, Ubuntu 25.10 is the first that provides a recent enough Rust
> given the minimum bump -- they provide 1.85.1 [2].
> 
> Thus update it.
> 
> Link: https://ubuntu.com/about/release-cycle [1]
> Link: https://packages.ubuntu.com/search?keywords=rustc&searchon=names&exact=1&suite=all&section=all [2]
> Reviewed-by: Tamir Duberstein <tamird@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/rust/quick-start.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas

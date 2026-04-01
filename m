Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF4E1112243
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AED010EF85;
	Wed,  1 Apr 2026 23:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T9tdpUNm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29AAC10EF85;
 Wed,  1 Apr 2026 23:01:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 02CF041906;
 Wed,  1 Apr 2026 23:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC8C4CEF7;
 Wed,  1 Apr 2026 23:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775084486;
 bh=0QBnjOf/a1gNT5EM5ReEkFxjICqiOXo4W5NTsRTeKQo=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=T9tdpUNmBlbEPGldW4o1S6Lb7P25G/VI57Nx2JE9Q5s0svWpM92inyF0M8MT0RYGn
 N+PeMsBowJab3sCv7iLX7l4hN35w3nDCNNktZYg1Xd6ALCbMslxNiJffCMZC/NRVBq
 lQe9l9USpxDufqZqJNSIprajA9Pl6BVYg+GyMTm+nbxJTu9Ao4ExHvdLv/oASjIFyh
 KMZGbGkUquUwt874wqpiO9uR8tVSAcIfPriDDE/J44GxjDQAaF5lcadIyNPdzqQVY+
 1C0aSEbp72qTPwVzEumrnCaF8t5P49f5YewF/wGtKLell09jTNUCNOjr67/ACQupbL
 GNnxVHyDQa2Tg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 25/33] docs: rust: quick-start: add Ubuntu 26.04 LTS
 and remove subsection title
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
In-Reply-To: <20260401114540.30108-26-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-26-ojeda@kernel.org>
Date: Wed, 01 Apr 2026 18:59:04 -0400
Message-Id: <177508434467.73816.6022443418822181845.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=tamird@kernel.org;
 h=from:subject:message-id; bh=0QBnjOf/a1gNT5EM5ReEkFxjICqiOXo4W5NTsRTeKQo=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDJlnF7t4ZiUrZk18eGdl7RsWcZ1FEtweXba9+qtcXAW71
 aqtV0R0TGRhEONisBRTZEkUPbQ3PfX2HtnMd8dh5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix0DHWMGLk4BmOpb3xj+ClVkB248oqWpYGZ350GB8Pw/fFJBB2Oc1s1VUv/4aOGjWIa/gttXX7n
 0/VJT5cxF/REb12mFLYo22znnYJqx4L1dlTHJHAA=
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

On Wed, 01 Apr 2026 13:45:32 +0200, Miguel Ojeda <ojeda@kernel.org> wrote:
> Ubuntu 26.04 LTS (Resolute Raccoon) is scheduled to be released in a few
> weeks [1], and it has a recent enough Rust toolchain, just like Ubuntu
> 25.10 has [2][3].
> 
> We could update the title and the paragraph, but to simplify and to
> make it more consistent with the other distributions' sections, let's
> instead just remove that title. It will also reduce the differences
> later on to keep it updated. Eventually, when we remove the remaining
> subsection for older LTSs, Ubuntu should be a small section like the
> other distributions.
> 
> [...]

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>

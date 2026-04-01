Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DFDD35179
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1874810E14E;
	Wed,  1 Apr 2026 12:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="O0cib2iU";
	dkim-atps=neutral
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com
 [209.85.218.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4095B10E16B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:24:59 +0000 (UTC)
Received: by mail-ej1-f73.google.com with SMTP id
 a640c23a62f3a-b940da8ec09so583749266b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775046298; x=1775651098;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ycc6WMg7OLshR/yyfU2jpKKLPa+z0xOJ3hTWvecsxRM=;
 b=O0cib2iUns1i7aeALI3yM5HuCcMm9iAfsh4QTvG4hwHU7p16PPAqn9Ir23k3NDn1A2
 vdAM4Afuc0uVe8Kvx0nXpBsx/8TXk84DlAhcQ4Byj9dIYZHEpu5DmYkJNjAF5FwU39fJ
 85Rfjuqedxp1l3Q+bz95BSEsoQEIXpSI+cO9xRXYyJeNOLdQShw/jjmD3gu+cyMrxneA
 7JP7fKEzFFDGqFgbLf5uPO4acsSnLTdy83JLpsx8CGgqu/DGVd4o30QOa54SX7UBS5W4
 qoUpY32E2A18eQdwAk+47/nlQdfFXDe0yqNawflXUlhOzQL2L3Rtry0TRmu5R82V4DJs
 Ycug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775046298; x=1775651098;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ycc6WMg7OLshR/yyfU2jpKKLPa+z0xOJ3hTWvecsxRM=;
 b=Cc0xjYr6LxzRIGCA8r2nQu7Iz9kyQf79uFiCPgIT4Ui43ne8h9tNSO1qd/qSrS906x
 dyWWi6qEmtW4gRGK5ouz7gHpJnChWjNIrPght/THR8xVIwGyYxMXYlIoo4Ye+8/JvMpJ
 kg1v2WSilXUMVUD2vND2jdQN1+n5a1bWox1Y8QxNdk1pwl9dzSRuZw1wByGeMfXEBtcd
 QivNXr1skPruYnWQPBpHOuLR+PDrQo5kqw6ReY2sT8lm+Xc3Jr422SAKn4hadJ4X7L7z
 hZwz/ftVfHmnD1uKl0tht7JLZ9rG1PWbo3EMQMN8KSrW6fT2p2wb0fwyHARE8vIUJvKY
 POEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY1ooNc3Rz1a8XCIAHY/pFV+Euitcm3gcTmYWlYf+YXod5J/SJcmHzu9EwpTtSDZKqHPSKmL+EpjI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywfv0rTjU4JawmEpPoZ2AVpa/WhtphHjtR9Uhlo7MNUEYOFLibl
 UifjN0AZzvhcwqhP+g5TyrCXTgCje8TFl5H2augQS/XQSaeFW9TUyJC7EeQh5nOZsFfVkCB260G
 Ox+AokXSyEurS9acKxg==
X-Received: from ejcbp3.prod.google.com ([2002:a17:907:26c3:b0:b9b:54ac:688a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c448:b0:b99:5f69:9ee2 with SMTP id
 a640c23a62f3a-b9c13cf93e8mr221111666b.52.1775046297024; 
 Wed, 01 Apr 2026 05:24:57 -0700 (PDT)
Date: Wed, 1 Apr 2026 12:24:55 +0000
In-Reply-To: <20260401114540.30108-2-ojeda@kernel.org>
Mime-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-2-ojeda@kernel.org>
Message-ID: <ac0Ol1PaRTWNK6O9@google.com>
Subject: Re: [PATCH 01/33] rust: bump Rust minimum supported version to 1.85.0
 (Debian Trixie)
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>,
 Todd Kjos <tkjos@android.com>, 
 Christian Brauner <christian@brauner.io>, Carlos Llamas <cmllamas@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Wed, Apr 01, 2026 at 01:45:08PM +0200, Miguel Ojeda wrote:
> As proposed in the past in e.g. LPC 2025 and the Maintainers Summit [1],
> we are going to follow Debian Stable's Rust versions as our minimum
> supported version.
> 
> Debian Trixie was released with a Rust 1.85.0 toolchain [2], which it
> still uses to this day [3] (i.e. no update to Rust 1.85.1).

Debian really *should* pick up 1.85.1. It contains bugfixes serious
enough that the Rust team decided it was reasonble to release a point
release.

> Debian Trixie's release happened on 2025-08-09 [4], which means that a
> fair amount of time has passed since its release for kernel developers
> to upgrade.
> 
> Thus bump the minimum to the new version.
> 
> Then, in later commits, clean up most of the workarounds and other bits
> that this upgrade of the minimum allows us.
> 
> pin-init was left as-is since the patches come from upstream. And the
> vendored crates are unmodified, since we do not want to change those.
> 
> Note that the minimum LLVM major version for Rust 1.85.0 is LLVM 18 (the
> Rust upstream binaries use LLVM 19.1.7), thus e.g. `RUSTC_LLVM_VERSION`
> tests can also be updated, but there are no suitable ones to simplify.
> 
> Ubuntu 25.10 also has a recent enough Rust toolchain [5], and they also
> provide versioned packages with a Rust 1.85.1 toolchain even back to
> Ubuntu 22.04 LTS [6].
> 
> Link: https://lwn.net/Articles/1050174/ [1]
> Link: https://www.debian.org/releases/trixie/release-notes/whats-new.en.html#desktops-and-well-known-packages [2]
> Link: https://packages.debian.org/trixie/rustc [3]
> Link: https://www.debian.org/releases/trixie/ [4]
> Link: https://packages.ubuntu.com/search?suite=all&searchon=names&keywords=rustc [5]
> Link: https://launchpad.net/ubuntu/+source/rustc-1.85 [6]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Alice Ryhl <aliceryhl@google.com>


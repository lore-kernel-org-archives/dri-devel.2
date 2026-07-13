Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC895C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4112210E494;
	Mon, 13 Jul 2026 08:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AlOjzO1s";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA96710E2B6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:16:43 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-493e94719e7so18673905e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783930602; x=1784535402;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gq7CBsOOfXmcQmDqY44O8+unztSFjXGh8YCUzgZnM2I=;
 b=AlOjzO1saDutbzRmgb42EFVtduOk4mcLtMk57awPWL3bShxksdP+ln4Bu4gz4SBk8k
 t63I8qlFsC6F/dRTRnZLwhU3mwCQqN8AE1iqWclBUoJwYGthsvmgNu0jV+7fkekkB3GU
 Rd6lcA3f25QF27mGn47mMMziByoQIPazUNaTUiE2LUx7ku5PUjpRzlF0iC99yEwJgqSt
 QXa0XsLdS6iA9AvhOujYxRn+NkeA6vJL9swcEKYleCY6+vPClrCn2vAoK7CvJY+QtX+4
 RLHvEtukc1wLtto6bvCz5Kp8U7RhuHTouuZNw6zCL7ERecXQhy1jf5PNORupbGYg/pA8
 QTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783930602; x=1784535402;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gq7CBsOOfXmcQmDqY44O8+unztSFjXGh8YCUzgZnM2I=;
 b=el4rOqmvyYm6ID0xkajnc4vy0jkTv9op3TN/om3w+I3gpC1wG/w8ITtBj1GGCi8XPk
 2+GJJS2m8e/miP34HFwG/Z6pxIEB1CilBRUsYBLKPdhsjQWo3N2MKoxs6BPLIPj8j8yD
 wVdzuseMz54oQrqKbQ6wERKcGHXOpL0vWAzA8Enhf/HF9nhQxnpFIHTp/YffbFd3p+0x
 7dw0wp4uAzkeK9y+b8DKD7/AkQWr0BSfjwHRlVCNoTlXyy0z70sFcEPxWytXKiLYskxZ
 jAbUIOIllWJktvlAvaScLCvESfAhobqTw78BHUMNwQ+PpJdPLPP+nVPak6WnFhq4d5oy
 Pfiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6IiqVd3oj6HwBYuU1ekEOMqMa5x1q7dpV+KsRZGWG7foZFf0Tk83nlysvAecN6kFMOuDGI5SUkB8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxqct0rstd6GR6bvvWmn+N7Fu7qdyRrrlVLAydX4b7MqS2raIK3
 gBG/QKzONjlxl8/ISjer727Xwp6HiXuvGSib89FkdmZufboAh0DT7UyMJkOCjepD3spZTm+W8ta
 7EgTTlD8bzJeDuup1Fg==
X-Received: from wmrn16.prod.google.com ([2002:a05:600c:5010:b0:493:d1b8:3df5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:464a:b0:492:7083:e5a with SMTP id
 5b1f17b1804b1-493f882b117mr52089545e9.31.1783930601636; 
 Mon, 13 Jul 2026 01:16:41 -0700 (PDT)
Date: Mon, 13 Jul 2026 08:16:40 +0000
In-Reply-To: <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev>
Mime-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev>
Message-ID: <alSe6PsvdrSYP_Z0@google.com>
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover
 module.rs
From: Alice Ryhl <aliceryhl@google.com>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, 
 "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>,
 Todd Kjos <tkjos@android.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
> Module types now live in `rust/kernel/module.rs` alongside
> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> files are covered.
> 
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Assisted-by: opencode:glm-5.2
> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c4..74733de3e41ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>  F:	kernel/module/
>  F:	lib/test_kmod.c
>  F:	lib/tests/module/
> -F:	rust/kernel/module_param.rs
> +F:	rust/kernel/module*.rs
>  F:	rust/macros/module.rs
>  F:	scripts/module*
>  F:	tools/testing/selftests/kmod/

Is there a reason why this is a separate commit from the commit that
introduces rust/kernel/module.rs file?

Alice

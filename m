Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759E0FF886C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D128610E8A1;
	Mon, 27 Apr 2026 18:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MDstamMX";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D9810E8A1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:07:31 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-43d7757463eso7008215f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777313250; x=1777918050;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
 b=MDstamMXoYtgZM+AIHetO15cwSAKNTGBy0XR0YK+RWA3oNdUV92KDBznEzW3pQA9D6
 51p1VOzgujlP6NFjHtZ5oZYxuhzPxqAJNH7MC2LuoQ/r7Nw7L15dVO95jh1lEZFbgKEr
 9LklWwrt5dJn8RwFmpkhqxEfDu001+QvWLN4irp20qgosEvJPUbqEr9EzPGr2vdixe/X
 TwBEWTwyYfD5iZXup+8lql4BqpxI1kQJerObeFDpkSykU7Q7XH6lu2MXo2C8lpzJciu8
 ccXB1uYOQsjOIutmU3rfJHtuHeudZMeTIrNldTXTZ2nWQ26QoqMZmzJbxWFwUy29L+W+
 W8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777313250; x=1777918050;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
 b=A9vObiDw0K1+MRnd3PSMfGPUcb7yq82TmfzHymQX2nEkts4n8feZIWk2wQuDa/f+su
 WsRjefwtHq7XXrS457aEG5htIM7+7DOLhbDTvmZbVtkuoC2HhGjZy++ij8ND/vKxCf7Y
 laRM61KROsQXHzHn3l0elOkPGXOkoG+lPLkO4+IAZ4zklxgREn7rum0TeKWmxl/UW4HP
 IT3d1t/K79k8yoJ5ZzEPhM7EfVFxMjIlSMJPwe2Psukgmiwa1OwgafCMub//a9gEpD3L
 u2M27U20iAVig+YlCuduYHbFany+CHr3jAfNABCNJfYAgYqL4GoK1XgJT9nTXGe2AWUU
 TxuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ESLqxRd/WgkblRZ2ddGH6otUlohdNoa4ctBEJJ5JzGn0EbDpE9raEAK4CL16YUdKUkVSMS7cLbmk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2qggW7eyL8VKcv1Np6QLWD2c4BDplyOTravxdDqSD5oqmF+pC
 DU/R1Z6YnKSNNX5B0j2Ekhi4MXYyIkNVv8G2OGcUErxfHd8nJ9UFJ8xZlXm59qzsxMLEL9NgLct
 teRofA3zwCVtc+yU/ng==
X-Received: from wrmd3.prod.google.com ([2002:adf:e883:0:b0:43d:7940:a11b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c7:b0:43d:799c:b2cb with SMTP id
 ffacd0b85a97d-44636a393e7mr256856f8f.24.1777313249648; 
 Mon, 27 Apr 2026 11:07:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:07:28 +0000
In-Reply-To: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Mime-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Message-ID: <ae-l4FGDPLwBuDXM@google.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to
 copy_{to/from}_user_partial() when relevant
From: Alice Ryhl <aliceryhl@google.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
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

On Mon, Apr 27, 2026 at 07:13:46PM +0200, Christophe Leroy (CS GROUP) wrote:
> diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
> index 01de4fbbcc84..710e07cd60ae 100644
> --- a/rust/helpers/uaccess.c
> +++ b/rust/helpers/uaccess.c
> @@ -5,13 +5,13 @@
>  __rust_helper unsigned long
>  rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	return copy_from_user(to, from, n);
> +	return copy_from_user_partial(to, from, n);
>  }
>  
>  __rust_helper unsigned long
>  rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	return copy_to_user(to, from, n);
> +	return copy_to_user_partial(to, from, n);
>  }

No Rust code uses the return value for anything other than comparing it
with zero, so you can keep these as copy_[from|to]_user() without
issues.

Thanks, Alice

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB40606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADE21122D3;
	Thu,  5 Nov 2026 10:02:03 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C191122D3
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:02:02 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-85c1135c286so1048625a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 02:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872921; x=1794477721;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+mKdlgKO27T7zaM0EZirUNSUHhSIV/TKUV4SSUSBbFc=;
 b=Mme8Dm6qnHrBXpQSKgJq1ZVLNgYZk+KzLH0by2aT8ZsgfNJ+G5jvScOfCr2yj7ZOyk
 a3q5m0HE0E/6tqIkd9wLP41tA8NTUq06jH4zq+q4MPl22EbETc48Rpr733pl1TAH4CD0
 dQQVHSyWVG7tru8i5RTcWLgVIHFD4HvpZU3GM2tFw8G5n5opuwGn4jeXC6LXxYD/KO8P
 oruKHOxzmPKceJDeohmDcgWqDZugIKYHVEXD4B4w65VkLyS4gtalcdCMKahclobsFrOs
 n+NWytID3KEIIjsugaF3dWJu9Xn60Ity3cxkYByh8O2UEz1uSxyQi2FX1dBdMmfjuYqh
 Cmew==
X-Forwarded-Encrypted: i=1;
 AKwUvBypSxDwlfPAEEIH0WGsPK9Qkdm+hm6zZHvpfHziLeeUMxZj3fdvD5vXFqbnWbi8ok2KzTzyHUT3aM0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8chNGGSLVJftyTptr2De+N6Z+BpgPbdXwuzvQKe5vKMZxWNUtZ
 tBnXkcNrV7+MXPsmOgwu0hRBpk//u+U6riwPVHMDgL5kfVkdelnSU7e4Hd22G6WPQpU=
X-Gm-Gg: AYBFou2uAjMliQW3a8n2uzkBSNRTDye2sOHRzEN80biM7mpUI03m8jB94xsZPvi7uyd
 i3TSkSPoEg6GXMbDkLncbkUBDjzG2PxdddWiruKkw1DUc481a24+0Mpl/KCIODjJ3B5jWnjZh00
 O+dCw2HOykEVgd3MbMow6Hh8/zqcqmwYOKCWOTlE5nhFFtJrUPo5oRduIMijCcXPb5ip9IcpcoT
 /g0Upwee5hk7OiyIzuLPanlhINsZqib5atVAwRBF07WpaNfkax+AnC/VGwCwFgzIs5KaZlUz6lU
 dpLcrHKLtlfIQRVFQi5ySElwTDKo+jnZ8Sow/DUFpjKij5MunU4GskwkqAypGTWDt0Tz9nvrljq
 MBrkS+cmrppVKA3xviMhwTo3/W0jsyiwN+l7HR4KxsnOOyWz4KjTZ6+z+82IVgTSimdAqGZPJkh
 LuEP2zRzt9bYrqyvcbJwdCEJfu0B8n4UhMDmttl6BsTwL57jX7DwrX3wBzmv22CpUm48vA3v/WK
 Y03ntsWOP/U3JB7HyHLBqqyBLng0/yrucnNll5mGVjCHlvs83rpr79rC/UA43a18fdp6R4blWqu
 UtnNL5kAgyvahu4aj0leqOQBD7GoUiG3PRdo+n2bp+xAjdJE8prRjINby/sNq6Wr/1Jdhg==
X-Received: by 2002:a05:6830:3e03:b0:80c:d30f:974 with SMTP id
 46e09a7af769-85d365ac10cmr14496507a34.21.1793872921151; 
 Thu, 05 Nov 2026 02:02:01 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com.
 [209.85.167.178]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3eb127asm4170334a34.24.2026.11.05.02.01.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:02:00 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4f55a53898cso904036b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 02:01:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBwQrpWCKf6lW3FRIuEITeRhiw0+fJNghUJjpwoq1678Eh57CydTCRofzacTRPL8SsWdjCT4nWgWtBM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr8218716137.13.1793872596997; Thu, 05 Nov 2026
 01:56:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-cleanup-v2-0-1e6687e226b1@kernel.org>
 <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
In-Reply-To: <20261104-work-procfs-cleanup-v2-5-1e6687e226b1@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:56:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
X-Gm-Features: AclHuK_YSG69l_UQ8CXymziWm2hhXR-Ce9gvdG6ZGXmuBEE26IV_RBgt33sxH_I
Message-ID: <CAMuHMdWkL=-oCgLA3HB0_Js_TdJ+P9FDBPF-u2z7uHrL+m7g-g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 5/6] proc: drop the _buf suffix from the new
 methods
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
 kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 22:16, Christian Brauner <brauner@kernel.org> wrote:
> The _buf suffix told them apart from ->proc_write(), ->proc_read() and
> ->proc_ioctl(), which copied to and from userspace themselves. Those
> are gone now. So drop the suffix. ->proc_write(), ->proc_read() and
> ->proc_ioctl() are the methods that work on procfs' buffers from now
> on, which is what kernfs calls its read and write as well.
>
> Done with sed. The flags and helpers in fs/proc that go with them are
> renamed to match.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

>  arch/m68k/kernel/bootinfo_proc.c                   |  2 +-
>  drivers/zorro/proc.c                               |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k/zorro

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

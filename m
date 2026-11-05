Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360E606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173401122CE;
	Thu,  5 Nov 2026 10:01:48 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B0C1122CE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:01:46 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-53644b28706so24641511cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 02:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872905; x=1794477705;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
 b=J95E35zcJ/GoYUoP1xQ7bAR4+WESGh19SJnXaPlesO7q4JZH5arDND3vyD0sGMBeP0
 oMIDlrb+Gg/faSR19g3xBNoB2mP9iGa1oC9SdUvakADSvHkYZzX5EEwStoGA/qYqfUcZ
 7rdQaGoTS4SYogwM+cCs3aAaEtmnME6qPR5NiD4Jj6BvKgNQxQpKnnXHXyKEb+68ZYBT
 4v/Ep1iTBLjd3wxfEVf+ywA/E61PU0ZIhWrroLI5f4d2VscvThpE3ElaThVn2j4vQclz
 mVVP31oaXl/TvbFlztZs1tkitwbGZqa1JnZN63TLwHHcCTFKVwekY8dobwYWzotCiBh7
 HEQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7TsAHza3iN/QCzUh2soAxK2vCvfjxXzqR8Kf76O+dDn7m2UtHnyVjCNVj/QPspwtvYABbnoIWcAo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+1It3b81MRLUeR2d4NXdyQFbgpiRAaC8YZ90UedF2O5EJ7EFE6
 7MWhZ4Zs3gr4fNW54Ous30ezxB8o0/fjC8f1Eq+1OBunUbUrfzR503erh9clbDhXwI0=
X-Gm-Gg: AYBFou2NqkXoYPUbMUuMXVE7e9v5aF6I8hP42J43lgkYBeM9DACenFpADxsNgad3T07
 rnKGRuGRS7CztfU+Q9d2NmMLijR9sDL4YZFPUD37lykofKntWLe6zIx3F35f9SjOsjVeyKgv+vY
 uXznrEJWLlp7yHaTQsZtp97FigGOUv7s1Zh2rPgYQ3Z7P+TOEPtwzsgLpnDKJHaHCw2kXfyD5B8
 Z8SdMF7U9/L6Q/EQAvUm/Q58yywm+TQDXoTMDjSqMqk76YroRQhnUAKVYjk4WLgCG78Q8In6Gd7
 atsoNmTFNWLyTtArAMk3Jx11doN/O0nshLHQuuiYG4pEl2xqkFJGV6SrO0uLFOfyo3m2SnWdohG
 uYYnTIqT46yz5Xc/XsxN1N9DwZVz314y+GGNwkGPXlNRC/HEpUfZPHcxGMD3KQDhSaph9z73252
 troFIUau8lF0RYdMMJ0CAdmu6rgjSO8pHYVVW3I5+7Re2RV2ynG6BQoP6zoBxz6vQbb5qbDOXVD
 Os8th20fq/wXBDU5AdOkw/BFMIchq1MA/ZfeeTFtBpwr2NwnVY/vMZnlJc6cOiKZ0GNBkjozmxf
 O9nkyF8ACHnzwy/HGkrKjmjXDW1gRD7Bk1pt1I1HFb2HASk4vuBpiwADEOVO8UlsfvN8Bg==
X-Received: by 2002:a05:622b:1d2:20b0:536:620e:90f7 with SMTP id
 d75a77b69052e-54cdbe57383mr15499351cf.39.1793872905267; 
 Thu, 05 Nov 2026 02:01:45 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com.
 [209.85.160.173]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b10c48836sm47833991cf.21.2026.11.05.02.01.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:01:44 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-5364d86f7f0so19472391cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 02:01:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ35B3j48ODKGAxrQVSnkIJE8kmMAmrvMD6FbI2QMGlg2hPjrZsrp0um9cNHhk8wb/rHk7GPNYuxo=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

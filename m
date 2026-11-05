Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D9606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96D4112306;
	Thu,  5 Nov 2026 10:07:46 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C59D112306
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:07:45 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-7ce77f98658so526656137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 02:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793873264; x=1794478064;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
 b=yu3XfdF8WZfJJG1cugvq7FD2OOtclTtwOkDuQddAg40Tb8lLk2pm7m2+wxyImVe90y
 tQ5aIF1fMH8PgrmHFlc5QmmBii5HKxBmFclZLKiWWCwOTPQw6o9R+Ih6Fpu748TIcJbY
 eUzg2kiZFQ0eXdwJ6S9glHnZNynLf12AXzuO0fbuac4dz4kSNmMN6bxBgG9cFXA3Ktnn
 g9FU++as6toYZ9UskPB5gyA4AbFkRXZiryUxpxCmQ1GHBvSGLStajGyvLaZMrhQrZHy6
 iM/2KuJoOOzYGJK3LdzXL7KUqx6w989naZP6eM4IWm9PcDh6woLV962PdLzeKURmn48K
 +dng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXdbbwLEvqMn6kjzGnc6GzdIJ+UnvXY1JJnxYhNSmc4/OeucN4tEXdCsUoJyZpIR6EM3U6V/geXZc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/JcJJYN9joU0lWFcL7Bv8JaxXk/rBKJ6Pip5OdnVOCyKtm/oEY
 7X9s+Pckye353to9A97U/DrrqEE8GJ6osyvUmNo9QmGCpDDRzDRyLclUjPTApK7ZMEE=
X-Gm-Gg: AYBFou2ri++Z/044wP+zru9ENPMxxKn2fCZWSmSBDylREJOMHCq2MlTdIRbNR+SgBvm
 PwQeC6gT9Na+hRsOieYfrTUZZzjgqJ2H41h/dUZqNiaNOxV8lwd2KKWzdeBRPqy4Ntyytacaeek
 oSuly5Jjv6q9a7i2/XwZnTV3g+4wyxRkp/B1DA/zTlwWNEo9Qrn1RIaBG8pMEP6RlwOx4ugYgRA
 i3XBbFMSncHz7wrB31gRT22lY1VuhUUpJ6Iwi046Cy+298RHczAnn9B/A/Nsw6xxR3V/hleH1bt
 YosQ+5iCTb7a0z+bmDLC/HCm7WIUHd+vcFGGPgBH8pkvzAhKpn6XxlDJAljXHsOVzUOKSgUnfri
 l4ZX6VMiOKebHieWFqxoTjIVvjS4W6lJK+3m5SaOpUbw12u5W5y0amZlieWEbUp016MPLRC/z0M
 oZGINGxq5NyU/48bZZgUo42NKRpoF7sySksLQttRsOlOooA3KbJvCa8jvIrm7UaoLm3jmYpCSv6
 0Dqe6Xu68+xFE9PuYa9SrsEIL1PqvUe01XVU4ue+RaR6sFJ7/UpgXIgWf9SuQSHRI4UtvTkW9/Z
 u4O3ckHOxYCfqcOTZRWuIcxw5Cz9yxFjjOg1key1bHMZ79/EyDkmtqLXEb8Y7sv1DXo=
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060735137.5.1793873264112; 
 Thu, 05 Nov 2026 02:07:44 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d2829d28d0sm2305552137.2.2026.11.05.02.07.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:07:43 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-7ce77f98658so526649137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 02:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvByhXkk7bWzGGz9z1wVQticL35sRQj5g4JYD0Y8N8+/OQWoTe6meNrEnufpXmDWpP6Ggxb+Uxxq8jSQ=@lists.freedesktop.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

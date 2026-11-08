Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E174606A321
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q/nluvsv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE4310E04E;
	Sun,  8 Nov 2026 19:00:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4C410E04E
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso1791565e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
 b=q/nluvsvopgD2V3ZMrUDYo6XYIYjRWzDbpVq2/Ru7zmZtfcGcRewYFkq1GR7rh0A3H
 Z9VZUnuHSaC7m92xju3LXKGpui95MidHJwkTXmh/AIxPHz+b5hXEhzfQFav1lPRMoFf6
 4QrZfu8WQ78JZrUMdg//0L8RCukLG0RYOrCgYsX02/qX1KcF9oWgmt2ajW182oXFbKM5
 zJobmuanD625v3XhoX6ha73msKzYNsgEwg6L1nQOOaUGcEz0qFOIIjv0XGrUooFwMmbz
 PsE5b+br0rXDp/hIL2ZrNId16n2bDYhyVNRiNsh6i6XI0AYt68FxEAl5MbiOF2bNKC3q
 Qi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794164397; x=1794769197;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
 b=gY0yZrTdwNuTb6uozQnOLgGg3frUvnygplNyqEYATK+2+8RUuj3CO45xe8aM6R0zaK
 2SSg4JxJZ7hEBmhrVVH4NGjPo3m7mMGOQl4E1etrT5Uet3rRso1d1zLnXqoU6jwQaUKK
 KqmpacWDfT09Vagf2+2zUolKyOzcr5sf34Z6pMhWT3tkGG8A9YLxOzMRTiE8R7Mf0FXw
 aNyl6pjImAhw+xFkru5AWB8PvnuL8exmvrlgeeuOq5Am2naA+JhZ/eIymVvyPEqf136x
 RWkiA4qfLyzScJm6/Y3ET+ZMNC3lFdWEi84aYPKRLN94iWWTjGGLNDCaJUG8JV8KIMec
 LZ4A==
X-Forwarded-Encrypted: i=1;
 AL+hErH9Fp93o2sp21m58i4+RXbjHaBh+eNBEuuHY5mHn9Ji7GI2WQM130aCzdyT9mNDL2DV3sy63kT6q68=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90swGirYIZaoNEdEHcKhwCcg2SUcnddWPwJ96P3FONr0W9qE3/
 jh1uHgeRYwhpufJjKo+C7nLO6Yl/HXMl776yveSSdRMoq92v6OjLS0xp
X-Gm-Gg: AYBFou2M+8jARknE91IcyupfwqIAFm44/ao7ReYk/e/Qx49Sj3ighpV4mR5s0NkdWYf
 0yOPKt9DIB2/Bo4ECcQc/XchOIVeYDAJHQGIjoPkglTDKojOzn/IHC7jUmYbYmEJWIHeDa7/kTW
 m5PP8q2YFTmzTfn1hXnGvS6sMfvEPOG6zUiSOJvZtZ5Fr/mPpyJ+vy54vb2yAzHdihaxL/CXrq0
 ZNGesl6B+D6Y9qvIUFQLwnw5fCTCKqPcGT9EsXYBv+d7iH8NLYgnDWTaQMHoM/dmbhR2IaLMxvA
 R4yhXNI0jPbWzqeTj19mNS6M1QTMm3r+Rf6us44Y5P7RKqSTQnzOxBhgDn2zIy3DEVfT0BQua94
 w5cVtRQYok2RLrashEBgLjWyQLVzwNCGkQEalJK3BWmEEY291eFw/YUTdh5hQ+9su7ns7IgYo9J
 2fQMzEAcEhYAVbohVUbgdrLGTfae3O5Csce9SZQMkjEFgV7+xRkUsGx/XDndOqcFHra0LwZc524
 Zo5kOvpB7T+B4oMZA+Jn5n7hIjxFjt4xu4rzr8oEcNej3q+hAut+faC1m5XAtEeimE+6SAPZqtS
 rqc3To1VTxVM4F3LVK9wkDsf2yYGElU+XI6ecJzUwc1245nx7aQBi2MAciMq9s6x
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406; 
 Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David

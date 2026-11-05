Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C5606D802
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457811122BB;
	Thu,  5 Nov 2026 09:50:48 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDC71122BB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:50:46 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-93f269e335eso195716185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 01:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793872246; x=1794477046;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
 b=tm2izgfeh/mXmCyBQgYx0iXzyDUyKJOXucYnGzyE7IMhrpcQH2DhYPWhLaWnK21A7X
 V5Iz6JEaYEpJC/1vhkBfwEtiXxitxwNesGajxMhYjpwNow1YfR436fpoq01O6qllt/14
 zCsOjp9sWzyyDEslbqF/fHeLeHNiHEDSO1zXiCF+kLrmM7VFKgRDp/JGDPLgjyuHlxbg
 ujKdlCDvV3jkxeTXcfn78plZPlUG50ik3XtbShrVrlKOhJgEvfX7MI+pl6loRYCQk8Zf
 2x1dSNuyJn8m7k1cZ8XxFzf/+xGqfHHDywmUXpM3wk5KE/ZcM0jI4h425ttbpLqL/WWA
 pxVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLZyH/rmSxIv48Stz0M/MQUC6qW0Q1nRx2kBbXtv6agSZZCdrh4ibLY1rAAYHGZlBWIlyMbbubBso=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Rui1erDcJeNu0FwfbrKnNYCnDEHjbPodHpKPO8G05yobh0Clt
 pO8iLZLLh1PfZm6UqjhTN4RlGhcWhYsydRDpG6wnz0VrxS0NCrk3PEE1VEWMdZFwvp4=
X-Gm-Gg: AYBFou232WkvQQf5iACf/mgdhn95L5tgfIOO28RWLR4UllwT8jI5xpA5TcFIKtZtpbM
 0LPqsnDpMJl84H3e5pFxPEUpFKmz/r/k7ZLt7+zj0XCM+LN5GEnPE/Gsdv2KYqapb7AKFoAe9hZ
 xB4J7R5ajwJMzJAZ6ivCbBiwAEzvaAoEHK0KUGTQKrYUMFN+CmvXE0DDMI6gQ+LVFPy++pu1kMs
 l4mEgv6O9FsqYD1ODzaWUzfpgwQOV2xlJfHhDKSNU4qinf9L/NeIOwjjgk0kObrUDPwJA/Du1Zm
 KA+CVtHZW+C0tTWR6SI4FSYxmXLP6qmrMQfYo0o+wd2tF11U4Z6+F0T4VuscfW+sgWqQau2cQaQ
 Ngd1+vw0xvWqxeiJOJ3pa8rhNAz1ISFuehwS3S4a0Lpp4ZoOFdUhvyq0yctvgC7mJcvE5DwJZjZ
 n60T0Kpka4ihwXUUHUsQx4oTSaXPz2/s/GFz3eMePJpjRPkWAnJd1b7I6UrgJAKg32ZO0qVV0bY
 DhV6LchqID4zSNdd6e8W7UyD+cj7APb/ux3mj+zzHHdsSn2EyNmywrEU1dgAb+TdL3lmGQlFzXi
 ZSjewfugkYJwyBOtOuOd4acTybHOBjuV5UHpNpOxGgsfrdRonOu7KMMNm6uwpDOnYVm1mw==
X-Received: by 2002:a05:620a:6082:b0:93f:3829:8492 with SMTP id
 af79cd13be357-94421744f2bmr2907357185a.78.1793872245690; 
 Thu, 05 Nov 2026 01:50:45 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com.
 [209.85.160.180]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7e013a5dsm43833016d6.27.2026.11.05.01.50.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 01:50:45 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-5365f9a04c5so23451951cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 01:50:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBygre+HGYEdMoUe2jQX6gG5/jq0OFH2Y5xpv8KoYA0KHJcGauaZ31O6kQYIrJbRzJEUxgbSGSMAuuE=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they
 serve
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

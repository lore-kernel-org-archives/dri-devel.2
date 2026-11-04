Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C9606EEAF
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=PYn0ckOe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC4410FED1;
	Wed,  4 Nov 2026 20:05:34 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE4410FED1
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:05:27 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6b579003f29so73894a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1793822726; x=1794427526;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
 b=PYn0ckOeh0x9Ej5F7APXYYV4KLF4frrq93XgeFYRf5/H+i9GblCY3Typu1XU0JafHT
 LftmNTd0Vq5QktXwPEOPnvDEgh1Xo/L4KuEV0+8okhAQriAMvaft4dtrD5g4wXg4AVfi
 GgHkCN8yWJ8eilwiolim769HHuE8E2b511jSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793822726; x=1794427526;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
 b=1Du5ZNZVoTwtgqM08x+43I18ztRnnT5k3MOn22HeKFE9iI9Wp3Zvx2vjYu4+8KT67w
 CRElTt5h3z4Th6/jBoNWK6zPZqP0CkQnur2/G3LAnKeJgPAoAbE5n3sVHuwc7Att9NxE
 NrbcYtAMKIuAxUAsOjr6FLNhj7VbuWyotJxpno+urmZU/oioyjMk3vvixqYZUqKK+afW
 eMDMPdqITOzaZKSSPFxdlusx+Fj1pPCG/Gsc920gH6TRuXXQuydxe07ay0JZE+wjDEjO
 +ErVZjC7V0dpjXg6PAy3dHushOpo0l+UwNfSDl2ePpLNBcf3aiGkR+yUjQtgVgRiDCuF
 uXxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJdu/K3qU2GvTenPnClheRAZogqc7O0SWMsAVfK/UMb0OtFAD5gin/JT9flxiJGhzFkGKqtkFIQJU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+bRTxBl7zIlMEpSTkDTjkST2omK/IZJ7rpdEvw1rJXRyQ2VPj1
 6ruUaUo4T3laxikEfXmAUe7jZnJa1NRLg6zVvQatOvA6DJCLqW7xBcHua8pPAlvSM5DvYlbkXIv
 7cZSLwCPTuw==
X-Gm-Gg: AYBFou2nFsLGZz49fUEufaCxRTc4g5W8OqXszW2Du8na35jlxf5b1GZpsfbU3zu7GRl
 5l759YHv2y+Fp++BVxbLn+JcbgXZ5b9tldxWOmUR/9kR6m20nPsjg50iK2IVswtTS/TAciRaAKe
 PE8ua5V9co1N3zvKCzRel0JH0OfvOFgRGymkHQOZlPWjA3qDAKxHaYP5bPMrE/7JyWl2Q1Y8/Il
 R+tozXA5mfN8jZ6SbDWSneBx3vsZf/CvFhOIcEfP04GBTGjpaxe0XZkD69j6o168TrjiPpdr+ru
 kTrUtL7fki+VYOhH8EasuRZhyTjxTQPSFbzrg6VX0HzlQysqByhR/8vee7M5RjHZC/bpmTnG/L4
 XUrnHAPOItud4tDOBDcSbtDnAQxZPFA8tLbgqnh8FfUqX1UqMkYrYbdlXs76uDH4bxT5ujjFN3+
 stJLDJGxlxu0MteGp/gCSVMts2GKgLM3gRF0aHc6HCuz7Fo6bZfg3AQSko44KASR02fkyZMnnet
 /FR4yVHcRGUr/3nzuhwFIUAdAf9NyN5PyoegPUhKRMLGOpxp3CUjhdBf3YlNoAUKG3VpEqVgYCM
 fxd62gImrYoNGkLnG5ZuwllfsXzvmg+piWuay2DBY40Qo7I+1H9/4xxnCJqcfrJn+z1nhaIjDiB
 9Aw==
X-Received: by 2002:aa7:d901:0:b0:6b3:8456:e891 with SMTP id
 4fb4d7f45d1cf-6b4d339252cmr10177510a12.6.1793822725767; 
 Wed, 04 Nov 2026 12:05:25 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com.
 [209.85.218.46]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55ac442bcsm1135202a12.6.2026.11.04.12.05.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 12:05:25 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c418e215671so166821666b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 12:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBz82IG+r4coQM2FudLhV0CSKxMVXveKTO3Hqm5R0avKQoV19YFx3SvUr+wrpKrS1OIDAgN7hwNNy84=@lists.freedesktop.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner>
 <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C32606A337
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fvqIhbuq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B3C10E284;
	Tue, 10 Nov 2026 01:21:26 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2084D10E284
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 01:21:19 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c4d2b741ed9so242363666b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1794273678; x=1794878478;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
 b=fvqIhbuqegVFytS28STXllEaPlYIZnSV9ZjB9SdQNeNCNsmF/1GpDabdbki0JrDdJT
 VOjGUYGfW0KuBmqSy4yzVUB3G5H4f92WZQU4AXjE5yWguVKPTT7d0XaZT4pJn/SQWrgy
 YE/P/YgyRvrcmFYCc7L4KncrHeXo3CkKQpIBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794273678; x=1794878478;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
 b=qCaw7gARqKH2NlznIRiQcvdiZT19tBLp3zbYqopeHl4iEu17/mmI3M3/7WYJAOrMjq
 Lfl6HK2HCYoLeUApcgtp9WPLW1mbCGuqWN4221GJ67X/naVPGCp4Thp6dOq+ZxnkJza2
 DssSCXsjMb5yMWZ9J4gntizn0maiBfCRxvKHn+sz2+AN8a1wb0ReaoeOQF73ClmTx8c4
 T9fxSSrga7IcsHnukm2Dx6tgFed8lCP5bSsy1GlKM/PNZ8J87z0vDK1te5XwsfyjNl7s
 +Oxl6vMX79ihpJWbWNXeVFxj3JcxhMU7gLPvSg1Z64X9t62G29ICxuUBcnZyRJZXute3
 F8Og==
X-Forwarded-Encrypted: i=1;
 AL+hErEKls101sbz9bs38UvIYW/PE5iplMi3X2lfXKosYix6M1Vc4JHddcYNp6gonrwwHIe/fZ/A+iceaM4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+cZBejKzHMidvxGXsK02ShnTl692RH5iQqs788dE2OygugiEEG
 7gh09zJXIS+1hjCthQzVGPLZ4RMVlBvFSnAJHaF/mA3TCCIl7RUcifdSJNcRVB0Ff2LgWFHWBGG
 sCK9EN4vBNw==
X-Gm-Gg: AYBFou03B2PkFk1rLCTXvrafZKHTpB2M86YmLpeaeUBQ9Jn5iaTQf4B0+EqFB8ADHrQ
 jj5RBlMUSiwLvq1WtbWyZMk/IdMXbJBiEO4on9BAEY9SWy5wTiNd7hwxhdMqCqN71AdvPj1SVQ5
 GNh5n/mPCJGX6aPqLrqpXf0x0SWrKqB0960sra120KQcanY2USWp9S3+aOnSXoqBg8+IwBoCoOX
 i04Tw6TJ0DRaW61mD/GgvqEZcYwQckR2gAsjVyOBnApwh1vdqhr2LLbfCyA0O0KGvPzkPVinlsF
 fwWhkaKqkviFpLw5vheHzDNwOF9BWjJ7U5TU7hqRuJFg90HtTo+SFCEkbAXgHdrK7VI2VVuUCdW
 cUqxfoRiNOL35o4CyijILldZ9/gVJcxEFGfkGE0mWPvKMieRcvpHLDywfFvicj1EPdB4009D2Ts
 eHlR+R/Tti/PzZJ/eDAmC7QKh8lnR9TrhAiVbviZVaCsmN7/6Y/+VQWL/ytZ7KmJ8zfpaQ9JXN9
 /gv4Ei6F7yDcRfRzMjABkaUY5nMUPZP5CODjjlh+XU5tQnuE6C2Z5E+QcBaz268lgvywUs+aF2x
 uADf2QrkW/ej3AEvD874ukrE6Qxh7Eb4vH66LnZS8pPOmHThJwad8yRqri6jDSZy4OlxStq+r4P
 kyA==
X-Received: by 2002:a17:907:9342:b0:c25:504a:1e25 with SMTP id
 a640c23a62f3a-c50495dfb3dmr71940866b.13.1794273678304; 
 Mon, 09 Nov 2026 17:21:18 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com.
 [209.85.218.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a685f99sm40216866b.82.2026.11.09.17.21.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 17:21:18 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so217241566b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 17:21:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErE5k5L9MwwOUkbuqc++0ooWn6NhmzxIX/wJMLNe0WzoGu7yayV16rPOuTucfS43pFt/rsjv3T2KgYs=@lists.freedesktop.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
 <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
 <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Christian Brauner <brauner@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <mason@kernel.org>, 
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

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus

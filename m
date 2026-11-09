Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66B606A33A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FrFUbdbP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC6510E8CC;
	Mon,  9 Nov 2026 21:46:09 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D6D10E8CC
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 21:46:02 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e47347279so893308f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
 b=FrFUbdbPTjKQz0vslwCWHBAwdcnqstas3UX13sNbe22dBI3q+nuda5zwD5GTGyuZcJ
 QjDW9ZflNzP4XRnc2+lWhVc6kI3J4ojGQ10NuIgu5R+GH8pBtDxVsFCWoa7VI+0+04q0
 LUuSWMr02V4PR1exkQ6FPUBAuuY/cV4Lz5dt4UGF8vq9V1OszRb3AsYDxmqW2DyHv389
 9mDKAPNazmj8lJ9W9E1UyBasqiNeXZiZ3lp9noNdcck2OpMdYWv+O+/+iTgOnSpKHYWw
 Dw8jT94yBZLbi/IDNKpguVXPEEE6Ivn8/0UM0o1MqSr4ojlWYIxPlHQ1YCjceAc9U4Uf
 d2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260761; x=1794865561;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
 b=cXiF7RLXVb7iffLxscUBOkmgqJ9l2MISARBljNDcbw/Nji6hp/BDBTCzkUFCsis2wz
 /iZKzkRhJTvoilU1Yr37iPJ+X3QohYI1ZFhR0sdtrcvYV5F5x+mcjamnKHCxPkCvLVwO
 YuYEN08rowHzuYHOJSqwAMHj8xIQF4LCVdlUWMMvyY5HfiRiLi+oEpxny8+APvcb2g3k
 ntTMWSohm4PtWSMSAcrV0oRJJzoLwGMwOzfgGTu0/rEb/tFqaZp8LP4fJPu0QQaHQNoK
 GAdpT1r5zQkhi6jeLT+EJezi7N2Ns3o4t122DkEGeVzcKehXbhkBXTXnLIHVXtHW6m1h
 nq8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGjHZGIANi1R6GU+m72sGWR8tOEA4P/UKK9lFa4Je11ovumf3LLoideBnoiCUJt4SdZCKa2ugVy+7I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9d9Tz54RxIrIrXru2+mXXdabU3iEqJryWQY/GpsvHFPw1MMeeS
 ZsG86pCNzJp3SFFUH3r3FtocyJBNrEBS+BYhn7+S7kJxppCS2hObAJmt
X-Gm-Gg: AYBFou1cRMldzJzkj8NyUfiwldOsa3LRzzPt9DBTXimL+6Gy8ZrBzZzC0ILICy9zZXM
 8i5QYa7qrRAneJsAGhhAJXR/wH2viLoCgjNdS0X9qfb4jcOLtPgX9rLEKimkjs89VDGC5wuIw++
 Ts18mmpUQNrncp1dfCheTQYY0ovP5j16oO9+SVxeicsL6DkEzu8WxTE12Rr/jQk0B36rj18gumd
 zEzDBpd63ELY/LTLmqq3sB5//j+4gHieKmvDv3p8wuR80RgCAIzFjaP0e3L6oZqtNddkUf6DtWI
 /NnQ4cgB7GkakgMDHk46eo1SWV3R8gY9pkLUTrk6jsgX8USiuCWcz1SaM3zIZgHgyNGoKTiWalU
 D8s1bQhKz+/AtOB03EleEtWxs1rfc0jns6duhg7zNW7/JHdBe3GcD/KkzMdZ/JL0AVcHgZ56E+b
 lK/x8K15fjFWtAx3sg4OTuX6lLH8v8r7tVbaNk5E0E8dWVYMmTnqB718mfoKC/fn29VFOtQDAhq
 RL8lqSoDYNbXrYFZ7/30YIXXxkXdX/McSqZ5RrIHgk1oTsPsvcvaFYTktyg+DbIImDSUPNgB3To
 63MU0B2Y2FEUMXkYd0gCNqmL/Kb0Q/kCcSEVQORLqkILeWxZ+cH0Tcf+rIP20Jwg7A==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id
 ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763; 
 Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
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
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
 <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
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

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1F606A58B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=L/QwZfF+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE69210E61D;
	Mon,  2 Nov 2026 17:59:19 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1523D10E61D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:59:13 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c434376dbebso693434366b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1793642351; x=1794247151;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
 b=L/QwZfF+AwqVSBhoJvzKWd7xLTHUZwxH6K7Ng+MyiMjF23E3uHoW0gK8ilsfVg57rb
 TeMNNyy7K9mPuVII5E6ARoh5kt5N2YErdIQCBEoqIGZqJisMODyN/COWgr8ZQwDCMYQj
 nsWM5SnrqqjdXv64Fdoe9jPVG8Z2NY9FiLfhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793642351; x=1794247151;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
 b=RfuuXloSYnfWlsLCd7S/endfJuozbrONoRFvckiCev1U8rsEJJ9xPiDY4F03rPzbmJ
 ImaqCqtxXQHU+Gn9zzafpzRVsQFG94c0zm3aliqI5y2LuzKT6AoAWoqr9sbVytXoJWRQ
 HaQX6zWdI33H3LiBlEK4bTOiAamsOtAEbB/dMW+aP47dRhkRndvkCSx1kAzbn7pocHuI
 OA6aJjScqSz9kxssWshnpFhSaLrv33xyqJxbx466iKrl0UiC4Z3JKFN9WC2bfNWYaA0y
 IHGStvLol2luLqNn+v5mHC912U4pyEbpdkClwuWnt6wrK4TU20x0w/baEX4lHuwXLRz+
 d1PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9/FpM7tLNtcJmOWDS+Zh29ToQndnUzCO3GzCvbeXhwnORnzio8z9n3ryIGS7vVXnVA49+BS1sVQQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJm3+2cCioVNIdoxO7EHOrRMl8cuvDH9kvMN6RcmMOh/0R9zVoM
 32ZLxlRyupQ+uvikanmJRibhiTMCb7nIovs6qkNW9OKHtn4sOLl8PsrM9p31wqoF1u2KFZ3n71P
 ZCbfe9Yc=
X-Gm-Gg: AYBFou2PhRvyhqou5QtNSYflTnVgRSM6WsUvDx3pynqKGFAd4zOJXkd3z8EcPeVww3W
 OZgi2IdcLo3MjnhAN/gpV4NzbEXLG4IKTQTvauP0XXUWBjKM2GD7/MQ7WKIa+WCKv5np5cu3C9g
 q+srJX4fsLBvI8tHQBFrlx8SO0lJ5ebmf/LDGJQPqtLhNTdkIIxqnGyUkmA3GY+9NJ7qEFH6JUY
 SegpeQvwkHgAL0JGO9bSMYNCEsCaevFORwPXW1A4c40HC5rq/nheAN75Q+0h08EV3Nyix6fEhPB
 ZUm0y0xogOby4lsHh9Fm28YhSoJySIdaH6FGFwJHcxsxPO8Yk1OYm3+TNXuQ49XWRX5sbK5X2xO
 vcJgJTWq5xVBbU/UOwtMazHofTOLGqwWa2NN/3rlEZWzOWwO7Gb8c+8cDfmC93nDAQ0CKKV6+RR
 iIRRauZQ/Qyu3YgRNIj3OYfRwCgDuko/RlGRfhtOgtzIhOQCYXPehbqtIypfjBJYl0JUgvWC+Ai
 4PBcXOhLYaqc7VxtQKCsg8g+BBw1D8Y1jmjCtPCzThhzhoM7h4AY3Skn2gywvHhKK/KrOG8TXHK
 pw/Y11cg62OsER4r9ri8OHvDwptZRC5DVpyWEBo2WFamAcyG5XmM0UEKBdldGE8CXtgtER69b18
 73RjDjk6C0O4yOZiHwn8LfvA=
X-Received: by 2002:a17:907:d308:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c49d13b7f8amr1166861166b.19.1793642351326; 
 Mon, 02 Nov 2026 09:59:11 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com.
 [209.85.208.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebefdee4sm12370866b.38.2026.11.02.09.59.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 09:59:09 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa27963eso7716050a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBy7JF9UZXDkGmth6SneC/5iPGQc2f6lRvXOIna5onY5FBSA7Zou8jOmb5ZI5oyTZnU2E4vEbq32SFs=@lists.freedesktop.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
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
 linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>,
 stable@vger.kernel.org
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

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

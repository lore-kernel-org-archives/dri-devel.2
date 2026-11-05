Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370E6079C3A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW/11WUL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC1E10E543;
	Thu,  5 Nov 2026 19:35:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D0910E543
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:35:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D071C41B33;
 Thu,  5 Nov 2026 19:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CEB1F0089E;
 Thu,  5 Nov 2026 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793907343;
 bh=alsXUfuEo/F1zePFVRl45Ndme/OflhiQcp41SPItDb0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dW/11WULePWBsogqlKJCGC7JYPbCbnYXRV+C/X7JOVxLXj5zOAba52zQpFTgNc3SU
 VqxLxyGyN/7wF0BTtfNixYDyxmB3E86QX9Ux9RGZ1zXR/EzZ2ZJyrhkPfunyxJJIZl
 un+xpBbQSiFaF0jJ6u/VW8rXe40ajptsRa6PjrbVxC7gTAonFrr3x4gk/kvpjOE5P1
 HarizfUM9JcPoR6EP40r+AaFcc6yhKBRuZw/KiwaBzFcWGsYWpC0CK/E6jNjHZpgDM
 EXhNA7+mREaW+iD5ECYOta1cjbh7H74x/1uUayMthsMGSyY9SbGLuxXinygzr+5A4r
 a3NkeRuyCBiAg==
Message-ID: <sashiko-outbox-199944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>,
 "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, tytso@mit.edu, dmitry.torokhov@gmail.com, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Anna Schumaker" <anna@kernel.org>,
 yukuai@fygo.io, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:41 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] proc: split __free(kvfree) declaration and initialization in pde_wr=
ite_buf()
--

commit e52627c4b4d80d32822781f143a8c1245bd64a2c
Author: Christian Brauner <brauner@kernel.org>

proc: let procfs copy in writes before pinning the entry

This commit introduces a ->proc_write_buf() callback in struct proc_ops so
that procfs can copy write data from userspace into a NUL-terminated kernel
buffer before pinning the proc_dir_entry. This prevents userspace page
faults during write copies from blocking remove_proc_entry().

> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index d51ab7548b117..df1caa0f238df 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -417,11 +417,44 @@ static ssize_t pde_write(struct proc_dir_entry *pde=
, struct file *file, const ch
>  	return -EIO;
>  }
> =20
> +/*
> + * procfs copies in what is written before it pins the entry. A writer t=
hat
> + * faults on its buffer then doesn't hold up remove_proc_entry().
> + */
> +static ssize_t pde_write_buf(struct proc_dir_entry *pde, struct file *fi=
le,
> +			     const char __user *ubuf, size_t count, loff_t *ppos)
> +{
> +	char *buf __free(kvfree) =3D NULL;
> +	size_t size;
> +	ssize_t rv;
> +
> +	size =3D pde->write_size;
> +	if (count > size) {
> +		if (!pde_has_short_writes(pde))
> +			return -EINVAL;
> +		count =3D size;
> +	}
> +	buf =3D kvmalloc(count + 1, GFP_KERNEL);

[Severity: Low]
As reported by Sashiko on RFC [1], this isn't a bug, but in pde_write_buf()
(called from proc_reg_write()), buf is declared with __free(kvfree) =3D NULL
at the top of the function and assigned later with kvmalloc() after the
count > size check.

Per the Cleanup API conventions in include/linux/cleanup.h, should buf be
defined and initialized in a single statement at the allocation site:

	char *buf __free(kvfree) =3D kvmalloc(count + 1, GFP_KERNEL);

after validating count?

[1] https://lore.kernel.org/r/sashiko-outbox-195538@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D14

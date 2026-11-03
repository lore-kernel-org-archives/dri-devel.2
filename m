Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F7606E6C3
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8388qAE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFFD10F62D;
	Tue,  3 Nov 2026 14:48:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E387310F62D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:48:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CACDD43EAF;
 Tue,  3 Nov 2026 14:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50781F00A15;
 Tue,  3 Nov 2026 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793717320;
 bh=J+QUSKIVrA74rzAH7akStvTDUKp4zBmOX5t72t47ioY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y8388qAEXoSoSnJ99ly3ntDqriooIcB6cnw6MNJ/yOOiH88LDGJTlMspoU5Ad11YT
 z/mugIdWyVXdjyoUsWzGoJ0ywU/6brdvaRbfO/nyQj3gSY3dM7VjmNfptad7dz9akX
 FyK7DM21XYX2hL3y2Nq3ILwqXoYqpAuC8nbTAsYSrp0wtMI4/hQUQ8qelVhhTr4jiu
 6XbsAJWj3Y6hOoR2Jdq4vWUlAg+Ce5I73KxXZdKxAeDXcW4bhWnfBuB/edbw4bSx8w
 YxwXRR/8oOQWDl5xekw8uxGrq1ZsGNUbUeP2tIxr/xvQ2GhYLNIp2bMzDzxqa4EA3i
 8JZm2cjxnWDJA==
Message-ID: <sashiko-outbox-195507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 35/38] proc: sysctl: don't hold the tables while
 readdir copies to userspace
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-35-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-35-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:38 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] proc: sysctl: premature EOF and lost errors in proc_sys_readdir()
- [Low] proc: sysctl: unused mode field in struct sysctl_dirent
--

commit 35a95ac245f1b380541472c3423535528d1bbf7d
Author: Christian Brauner <brauner@kernel.org>

proc: sysctl: don't hold the tables while readdir copies to userspace

This commit changes proc_sys_readdir() to avoid taking sysctl tables into u=
se
during directory iteration, pinning only the header memory of the current
entry while dropping sysctl_lock before instantiating dentries and copying
entries to userspace.

> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index a1242247f4929..0b7a1e487ed6c 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c

[ ... ]

> @@ -367,86 +369,97 @@ static const struct ctl_table *lookup_entry(struct =
ctl_table_header **phead,
>  	return entry;
>  }
> =20
> -static struct ctl_node *first_usable_entry(struct rb_node *node)
> -{
> -	struct ctl_node *ctl_node;
> +/*
> + * What readdir takes along for an entry between the trips through
> + * sysctl_lock: the header pinned, which keeps its memory and nothing el=
se,
> + * the entry, its name and mode. For a link the header and entry are the
> + * ones it stands for in the caller's set.
> + */
> +struct sysctl_dirent {
> +	struct ctl_table_header *head;
> +	const struct ctl_table *table;
> +	struct ctl_node *node;		/* the entry's node in the directory, NULL for =
a link */
> +	ino_t ino;
> +	unsigned int type;
> +	umode_t mode;
> +	bool skip;
> +	int len;
> +	char name[NAME_MAX + 1];
> +};

[ ... ]

> @@ -454,15 +467,56 @@ static int entry_after(struct ctl_dir *dir, const c=
har *name, int namelen,
>  			node =3D node->rb_right;
>  		}
>  	}
> -	ctl_node =3D first_usable_entry(after);
> -	spin_unlock(&sysctl_lock);
> -	if (ctl_node) {
> -		head =3D ctl_node->header;
> -		entry =3D &head->ctl_table[ctl_node - head->node];
> +	ctl_node =3D first_live_entry(after);
> +	if (!ctl_node)
> +		goto out;
> +	head =3D ctl_node->header;
> +	entry =3D &head->ctl_table[ctl_node - head->node];
> +
> +	d->len =3D strlen(entry->procname);
> +	if (d->len > NAME_MAX) {
> +		ret =3D -ENAMETOOLONG;
> +		goto out;
>  	}
> -	*phead =3D head;
> -	*pentry =3D entry;
> -	return 0;
> +	memcpy(d->name, entry->procname, d->len);
> +	d->mode =3D entry->mode;

[Severity: Low]
This isn't a bug, but is d->mode in struct sysctl_dirent needed?

sysctl_dir_next() stores entry->mode into d->mode here, but neither
proc_sys_fill_dirent() nor proc_sys_readdir() ever reads d->mode, as
proc_sys_make_inode() reads table->mode under sysctl_lock and
proc_sys_fill_dirent() derives d->type from inode->i_mode.

[ ... ]

> @@ -875,21 +891,30 @@ static int proc_sys_readdir(struct file *file, stru=
ct dir_context *ctx)
>  	 * seeking to an arbitrary position always did.
>  	 */
>  	if (cursor && cursor->pos =3D=3D ctx->pos) {
> -		entry_after(ctl_dir, cursor->name, cursor->len, &h, &entry);
> -		pos =3D ctx->pos;
> +		err =3D sysctl_dir_next(ctl_dir, &d, cursor->name, cursor->len);
>  	} else {
> -		first_entry(ctl_dir, &h, &entry);
> -		pos =3D 2;
> -	}
> +		loff_t pos =3D 2;
> =20
> -	for (; h; next_entry(&h, &entry)) {
> -		if (!scan(h, entry, &pos, file, ctx)) {
> -			sysctl_head_finish(h);
> -			break;
> +		err =3D sysctl_dir_next(ctl_dir, &d, NULL, 0);
> +		while (err > 0 && pos++ < ctx->pos)
> +			err =3D sysctl_dir_next(ctl_dir, &d, d.name, d.len);
> +	}
> +	if (err < 0)
> +		return err;
> +
> +	while (err > 0) {
> +		if (!d.skip) {
> +			err =3D proc_sys_fill_dirent(file, &d);
> +			if (err)
> +				break;
> +			if (!dir_emit(ctx, d.name, d.len, d.ino, d.type))
> +				break;
>  		}
> +		ctx->pos++;
> +		sysctl_cursor_set(file, d.name, d.len, ctx->pos);
> +		err =3D sysctl_dir_next(ctl_dir, &d, d.name, d.len);
>  	}
> -out:
> -	sysctl_head_finish(head);
> +	sysctl_dir_done(&d);
>  	return 0;
>  }

[Severity: Medium]
Can a concurrent unregister_sysctl_table() or error during the loop in
proc_sys_readdir() cause premature EOF or drop error codes?

Because sysctl_dir_next() only pins d->head->count via sysctl_pin() and does
not increment d->head->used, a concurrent unregister_sysctl_table() does not
wait in start_unregistering() and can set d->head->unregistering as soon as
sysctl_dir_next() releases sysctl_lock.

When proc_sys_readdir() then calls proc_sys_fill_dirent() ->
proc_sys_make_inode(), proc_sys_make_inode() checks head->unregistering und=
er
sysctl_lock:

    spin_lock(&sysctl_lock);
    if (unlikely(head->unregistering)) {
        spin_unlock(&sysctl_lock);
        iput(inode);
        return ERR_PTR(-ENOENT);
    }

proc_sys_fill_dirent() propagates this -ENOENT back to proc_sys_readdir(),
which breaks out of the while (err > 0) loop and returns 0. If no entries
have been emitted yet in the current getdents64() call (for example on a
subsequent getdents64() call where ctx->pos >=3D 2), returning 0 causes
getdents64() to report EOF to userspace and omit all remaining live entries
in the directory.

Similarly, if proc_sys_fill_dirent() fails with -ENOMEM, or if the in-loop
sysctl_dir_next() call returns a negative error such as -ENOENT (when
ctl_dir itself is unregistered after a skipped link) or -ENAMETOOLONG,
proc_sys_readdir() still returns 0 instead of err.

Should proc_sys_readdir() skip entries when proc_sys_fill_dirent() returns
-ENOENT and continue to the next entry, and return a negative err at the end
if failed before emitting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D35

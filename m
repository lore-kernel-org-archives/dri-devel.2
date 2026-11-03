Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C9606F62D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEcq0ggu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B65610F653;
	Tue,  3 Nov 2026 15:01:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE67D10F653
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:01:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FCE2609FA;
 Tue,  3 Nov 2026 15:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD2F1F000C1;
 Tue,  3 Nov 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793718068;
 bh=BEajqQ35phGWaUcr3y1eTDvwsu33+Nn0Y7Ck4F/8MEY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VEcq0gguO6/NoWa+wL6fwqCLqkldJUUFWXaU48FgopqIQWVInov4USQPNMlWECfku
 tjmmYgoSxJFwLb8AMyTRkOEe9RIAgKCTxUsnF6zQuC56KDIfRvxTZM6B4OGZ+0RxLb
 mh81fLroJS4nyQyOkcaBszjAOxkYEOtX3GkPZMu84uutLjUi79KxQ0Ta6LswLb4aME
 +9R/WJkvVhkvygnNcEPN9DxaCT6J3JtUHgSP8vKYwTs6rh6No+CNqGd39rP3s8vdpa
 CSPispydKapyfU9yanW1YMZNTbAP3BOy5UszvDaukMX2hst4qdOs00Vyn/j4PbSImA
 6uri+styQIxoQ==
Message-ID: <sashiko-outbox-195531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/16] proc: let procfs own the seq_file of seq_file
 entries
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
In-Reply-To: <20261102-work-procfs-core-v1-4-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-4-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:06 +0000
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
- [High] proc: unpinned dereference of pde->seq_ops->next in pde_seq_next()
--

commit ae41131fe28a1e7fcf9c3b743e2a30697e315fe9
Author: Christian Brauner <brauner@kernel.org>

proc: let procfs own the seq_file of seq_file entries

This commit allows procfs to own the seq_file for seq_file and single-show
entries by wrapping their seq_operations and pinning the proc_dir_entry
only around start, next, show, and stop callbacks rather than across
userspace copies in seq_read_iter().

> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 66a3688757dd7..8425465aae5d7 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -218,6 +218,110 @@ static void pde_unpin(struct proc_dir_entry *pde)
>  		unuse_pde(pde);
>  }
> =20

[ ... ]

> +static void pde_seq_stop_pinned(struct seq_file *m, void *v)
> +{
> +	struct proc_dir_entry *pde =3D seq_pde(m);
> +
> +	if (pde_has_proc_seq_ops(pde))
> +		pde->seq_ops->stop(m, v);
> +	pde_unpin(pde);
> +}
> +
> +static void *pde_seq_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct proc_dir_entry *pde =3D seq_pde(m);
> +	void *v;
> +
> +	if (!pde_pin(pde))
> +		return ERR_PTR(-EIO);
> +	if (!pde_has_proc_seq_ops(pde))
> +		return single_start(m, pos);
> +	v =3D pde->seq_ops->start(m, pos);
> +	if (v =3D=3D ERR_PTR(-EIO))
> +		pde_seq_stop_pinned(m, v);
> +	return v;
> +}
> +
> +static void *pde_seq_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct proc_dir_entry *pde =3D seq_pde(m);
> +	loff_t old =3D *pos;
> +
> +	if (!pde_has_proc_seq_ops(pde)) {
> +		++*pos;
> +		return NULL;
> +	}
> +	v =3D pde->seq_ops->next(m, v, pos);
> +	if (v =3D=3D ERR_PTR(-EIO))
> +		pde_seq_stop_pinned(m, v);
> +	/* seq_file would blame these seq_operations, blame the entry's */
> +	if (*pos =3D=3D old) {
> +		pr_info_ratelimited("buggy .next function %ps did not update position =
index\n",
> +				    pde->seq_ops->next);
> +		++*pos;
> +	}
> +	return v;
> +}

[Severity: High]
In pde_seq_next(), if pde->seq_ops->next(m, v, pos) returns ERR_PTR(-EIO)
without advancing *pos, pde_seq_stop_pinned(m, v) is called before the
if (*pos =3D=3D old) check.

Since pde_seq_stop_pinned() calls pde_unpin(pde), which decrements
pde->in_use and can complete pde->pde_unload_completion, a concurrent
remove_proc_entry() waiting in proc_entry_rundown() can finish and allow a
module to unload or free the memory backing pde->seq_ops before
pr_info_ratelimited() dereferences pde->seq_ops->next and formats it with
%ps. In addition, pde->seq_ops->stop(m, v) in pde_seq_stop_pinned() will
observe the unincremented *pos value.

Could the if (*pos =3D=3D old) check be moved ahead of the
if (v =3D=3D ERR_PTR(-EIO)) check so that pde->seq_ops->next is only access=
ed
while the entry is still pinned and *pos is updated before ->stop() is
called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D4

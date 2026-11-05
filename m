Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1342607B953
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMGngCoO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFFF10EE08;
	Thu,  5 Nov 2026 19:36:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E64E10E978
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:36:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B0E3601EC;
 Thu,  5 Nov 2026 19:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E9A1F008A3;
 Thu,  5 Nov 2026 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793907359;
 bh=f7pbLgB+bOANV7ZH7bSfet1egKll+CXGNKYzJQU3Yrk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iMGngCoOl/U4CYIB1rTzS3RguQRqLRp2sKfBp3odJCcMgrP4Y2V8PmtfZZo1x5Xkv
 FLC9VNWmdujwFQtrFCf8Mg1QUR9V0cBoPIZOnqaamHivU1nhWiKlmj37JQBwx8Nw4V
 gnJGb6AJHKNc0HghHI9fJU1uQS16q3fA1JPSybQgU9VxlezkJg9W+I3Lt4LPHuBS+G
 M91zjKny9mmSeWhknnqhOUNYocrnIZ20lXgBv1WbhSSK7LtbVS4MpUGhBLakgtch3v
 NiR+5uPctDAbSjOlOz7BSSMrEU1NCpxJBHKCCILKG0ymIlPQ81348+1c7a3Gat7yd+
 kdKHITt2fXI3g==
Message-ID: <sashiko-outbox-199951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 21/23] proc: let lockdep check the pin
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
In-Reply-To: <20261104-work-procfs-core-v2-21-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-21-76ace653a773@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:35:57 +0000
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
- [Low] proc: kernel-doc mismatch on __proc_create_net_single_write()
--

commit 095fce4c95ecbe25e644f1a3fe90061f695e9271
Author: Christian Brauner <brauner@kernel.org>

proc: let lockdep check the pin

This commit adds lockdep tracking to proc_dir_entry pinning so lockdep can
detect deadlocks between proc entry methods and removal under held locks.
Entries created via proc_create_single() and related helpers receive a
per-registration-site lock_class_key via wrapper macros.

> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index b78d627b024f8..9ddd7c323dfcd 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c

[ ... ]

> @@ -232,11 +233,12 @@ EXPORT_SYMBOL_GPL(proc_create_net_single);
>   * pde_data() on the file inode.  The network namespace must be accessed=
 by
>   * calling seq_file_single_net() on the seq_file struct.
>   */
> -struct proc_dir_entry *proc_create_net_single_write(const char *name, um=
ode_t mode,
> -						    struct proc_dir_entry *parent,
> -						    int (*show)(struct seq_file *, void *),
> -						    proc_write_t write,
> -						    void *data)
> +struct proc_dir_entry *__proc_create_net_single_write(const char *name, =
umode_t mode,
> +						      struct proc_dir_entry *parent,
> +						      int (*show)(struct seq_file *, void *),
> +						      proc_write_t write,
> +						      void *data,
> +						      struct lock_class_key *key)

[Severity: Low]
When proc_create_net_single_write() in fs/proc/proc_net.c is renamed to
__proc_create_net_single_write() and given the new key parameter, the
preceding kernel-doc block still documents the old name and omits @key:

/**
 * proc_create_net_single_write - Create a writable net_ns-specific proc fi=
le
 * @name: The name of the file.
 * @mode: The file's access mode.
 * @parent: The parent directory in which to create.
 * @show: The seqfile show method with which to read the file.
 * @write: The write method with which to 'modify' the file.
 * @data: Data for retrieval by pde_data().

Should this kernel-doc comment be updated to match
__proc_create_net_single_write() and document @key (or moved to the
proc_create_net_single_write() macro in include/linux/proc_fs.h) to avoid
scripts/kernel-doc warnings when building with W=3D1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-core-v2-0-76ace653a773@kernel.org?part=3D21

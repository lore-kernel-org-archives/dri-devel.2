Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF2A606C85E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqxUBmmI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B1810F625;
	Tue,  3 Nov 2026 14:48:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2225710F62B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:48:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23DA8609F6;
 Tue,  3 Nov 2026 14:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29171F000C1;
 Tue,  3 Nov 2026 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793717304;
 bh=c0x/bwvUTy91TeSNlshE2x6EC5UWF1SAOxo9ylrayLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bqxUBmmIruc8WVpdDnTaZKZMybp6tbdqSNtX5Vxb8SbRLH8Zr2JWwBPY98aQ3hFcO
 mF4KERe0Pl6zVdX7ZTe2YfvSwUDpjVOk0tXjo8nokMnupOaJWZpwf9x3s1jjDqLc7o
 D8x2o27+nwq7964W+Sy/E0e8KLqKLtVO62ftCwu5g7mpOe3sE4UYTyU1eKEd9wvkG6
 9ziGsoyYsjc+8FEQzGARNtSKo/GIQynC+oiEc7kqzm/+yyy218WWaRIIGwPjaGFK1d
 0aiHWvAjGKyvLg2SLb3ZdKLVkElsDVk3YwkpAFqEpwcF1NBvaDa6WRGXNTZsB/rjMv
 m/ZkDBbjhFEUA==
Message-ID: <sashiko-outbox-195500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 28/38] scsi: esas2r: bound the lengths of the HBA,
 SMP and firmware ioctls
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-28-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-28-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:48:22 +0000
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
- [High] scsi: esas2r: TOCTOU race on data_length in handle_hba_ioctl() via=
 read_hw()
--

commit 8af21917bc01e9991b2ab872e7a4c38c91a6e388
Author: Christian Brauner <brauner@kernel.org>

scsi: esas2r: bound the lengths of the HBA, SMP and firmware ioctls

This commit adds bounds checks on user-supplied lengths for the HBA, SMP,
and firmware ioctls in esas2r to prevent out-of-bounds reads and writes past
the end of struct atto_express_ioctl and a->local_atto_ioctl.

> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esa=
s2r_ioctl.c
> index 3f7c1d131ec34..f99318f61c934 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c

[ ... ]

> @@ -1221,11 +1231,16 @@ static void hba_ioctl_done_callback(struct esas2r=
_adapter *a,
>  	}
>  }
> =20
> +/* @room is the size of the buffer that starts with @ioctl_hba. */
>  u8 handle_hba_ioctl(struct esas2r_adapter *a,
> -		    struct atto_ioctl *ioctl_hba)
> +		    struct atto_ioctl *ioctl_hba, size_t room)
>  {
>  	struct esas2r_buffered_ioctl bi;
> =20
> +	/* The data follows @ioctl_hba in the same buffer. */
> +	if (ioctl_hba->data_length > room - sizeof(struct atto_ioctl))
> +		return IOCTL_INVALID_PARAM;
> +
>  	memset(&bi, 0, sizeof(bi));
> =20
>  	bi.a =3D a;

[Severity: High]
Can a concurrent write_hw() bypass this bounds check when handle_hba_ioctl()
is called from read_hw()?

In drivers/scsi/esas2r/esas2r_main.c, read_hw() and write_hw() both operate
on the shared a->local_atto_ioctl buffer without holding a driver lock (and
kernfs only serializes per open file description via of->mutex, not across
separate file descriptors):

drivers/scsi/esas2r/esas2r_main.c:read_hw() {
	...
	if (handle_hba_ioctl(a, a->local_atto_ioctl,
			     sizeof(struct atto_ioctl)) !=3D IOCTL_SUCCESS)
		return -ENOMEM;
	...
}

drivers/scsi/esas2r/esas2r_main.c:write_hw() {
	...
	memset(a->local_atto_ioctl, 0, sizeof(struct atto_ioctl));
	memcpy(a->local_atto_ioctl, buf, length);
	...
}

Inside handle_hba_ioctl(), ioctl_hba->data_length is read twice without
synchronization:

drivers/scsi/esas2r/esas2r_ioctl.c:handle_hba_ioctl() {
	if (ioctl_hba->data_length > room - sizeof(struct atto_ioctl))
		return IOCTL_INVALID_PARAM;

	memset(&bi, 0, sizeof(bi));

	bi.a =3D a;
	bi.ioctl =3D ioctl_hba;
	bi.length =3D sizeof(struct atto_ioctl) + ioctl_hba->data_length;
	...
	return handle_buffered_ioctl(&bi);
}

If write_hw() overwrites a->local_atto_ioctl->data_length with a non-zero
value between the bounds check and the assignment to bi.length, wouldn't
handle_buffered_ioctl() still read and write bi.length bytes past the end of
a->local_atto_ioctl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D28

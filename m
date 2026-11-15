Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E1606A329
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETF5Z0WA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7833910E3C9;
	Sun, 15 Nov 2026 20:28:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB0610E419;
 Sun, 15 Nov 2026 20:28:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 034B441AB6;
 Sun, 15 Nov 2026 20:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DCB1F000C4;
 Sun, 15 Nov 2026 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794774484;
 bh=iL9gs0hHi938yh2WI7Rig0yplwSjqvzkRGjQ5uPboKU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ETF5Z0WAqh95BGpkVJKfpqGcs9JI8RAoRt4nI+73Jvpwec+3LLtpvx5oLIOpOfGsT
 GOEPDW9rPmVNyvWKj75N4qe/uuqYO9Ct+c+rkqTJy8JuSRXz8Cd8ame+5r1JLvG/3A
 reDElin5T7+X5Y7q3072wbnRv3MkRD1vWKJ66eWwdYKSqePxhpqdkT13QWNUnnpmGY
 uWWkItczjTLp6aObld3Ovht8ffOQ/ZvRuyPp7S9k0+Fw6T0VXIdNJKdR58ItUCYtae
 UkRrFmwjS4VMsil7spiRSB/64XxcHyS+/KBT36lH7fuE9R+NdOThy0hIAK8YBBEQQ1
 KRVyv4dQidmtA==
Message-ID: <sashiko-outbox-215810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] docs: ioctl-number: update FS entries
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
 linux-mm@kvack.org, "Jaroslav
 Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 linux-sound@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, "Marcel Holtmann" <marcel@holtmann.org>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, "Jason
 Wang" <jasowangio@gmail.com>, "David Heidelberg" <david@ixit.cz>, "Chas
 Williams" <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Helge Deller" <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, MPT-FusionLinux.pdl@broadcom.com, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K.
 Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Neill
 Kapron" <nkapron@google.com>, "Andrey Konovalov" <andreyknvl@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Hans
 de Goede" <hansg@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, "Michael S.
 Tsirkin" <mst@redhat.com>,
 =?utf-8?b?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, "Jan
 Kara" <jack@suse.cz>, =?utf-8?b?VGhlb2RvcmUgVHMnbw==?= <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, "Mike
 Marshall" <hubcap@omnibond.com>, devel@lists.orangefs.org,
 "Paulo Alcantara" <pc@manguebit.org>, "Namjae
 Jeon" <linkinjeon@kernel.org>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>,
 "Tzung-Bi Shih" <tzungbi@kernel.org>, "Benson
 Leung" <bleung@chromium.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261114202653.3113381-11-rdunlap@infradead.org>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-11-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:27:54 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: ioctl-number: ext4 00-2F ioctl range points to
  fs/ext4/ext4.h instead of uapi/linux/ext4.h
--

commit 9072a8199d2be085dc5ab2567392180faf810c6d
Author: Randy Dunlap <rdunlap@infradead.org>

docs: ioctl-number: update FS entries

This commit updates the header file paths and sequence number ranges for
filesystem ioctls in Documentation/userspace-api/ioctl/ioctl-number.rst.

> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index 87e547be9e2ac..abc89b6288ba3 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst

[ ... ]

> @@ -275,7 +276,7 @@ Code  Seq#    Include File                           =
                  Comments
>  'f'   00-1F  linux/ext2_fs.h                                           c=
onflict!
>  'f'   00-1F  linux/ext3_fs.h                                           c=
onflict!
>  'f'   00-0F  fs/jfs/jfs_dinode.h                                       c=
onflict!
> -'f'   00-0F  fs/ext4/ext4.h                                            c=
onflict!
> +'f'   00-2F  fs/ext4/ext4.h                                            c=
onflict!

[Severity: Low]
Should this entry point to uapi/linux/ext4.h (or both headers) instead of
only fs/ext4/ext4.h?

Commit 519fe1bae7e2 ("ext4: Add a uapi header for ext4 userspace APIs")
moved the EXT4_IOC_* definitions spanning 0x03 through 0x2E into
include/uapi/linux/ext4.h, leaving only the compat EXT4_IOC32_* definitions
(0x03 through 0x08) in fs/ext4/ext4.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114202653.3113=
381-1-rdunlap@infradead.org?part=3D10

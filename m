Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F8606A893
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQQaKT6Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7311910E0D9;
	Sun, 15 Nov 2026 20:27:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD9B10E0D9;
 Sun, 15 Nov 2026 20:27:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 559EF41E74;
 Sun, 15 Nov 2026 20:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAB51F000C4;
 Sun, 15 Nov 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794774467;
 bh=8gu33mrYXMzWB1guqs3vj2T3i7/kLEK1yfs/DV8sZmU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eQQaKT6QNia4M5fkN9vM/bS1Y/kK95Wo46QLhfi33KjcOH3lSRaIkcpl/SLpHMFrw
 X11TMh2ra+V6g5NZEdBHr2So5k+ffsdxljUpW2UMZowoER6RAEkHJt0oc6nNYZHgio
 OIZh2f8aULqySK74+IyVCP0a7rZpkLLcMDZn9Cs+JVVmYWVBaCNkzBO5O2JsN4cT2b
 mVuRyIGfepUrdagbltdNOutkz4F+8m7mXRld5fg+/MwG9xiVPu3FYKoDZVNxB8e5pF
 oUjJpYPMxLdqf3ESWBNQ2Z+E6J37XbR7aZTaJuq3dUdBkvCUkgV+gArRjgwg7l8a7a
 ZyoDGdiR4Rfag==
Message-ID: <sashiko-outbox-215804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] docs: ioctl-number: update networking entries
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
In-Reply-To: <20261114202653.3113381-5-rdunlap@infradead.org>
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-5-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:27:43 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: ioctl-number: duplicate bnep.h entry and missing conflict
  marker
--

commit acf95c4d46bf87ab8fab382911993f6e83864afc
Author: Randy Dunlap <rdunlap@infradead.org>

docs: ioctl-number: update networking entries

This commit updates the networking ioctl file paths and function number
ranges in Documentation/userspace-api/ioctl/ioctl-number.rst.

> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index 2b2d3fd317158..cd4f0bf6db66a 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -132,6 +132,7 @@ Code  Seq#    Include File                           =
                  Comments
>  'B'   00-0F  include/linux/pmu.h                                       c=
onflict!
>  'B'   C0-FF  advanced bbus                                             <=
mailto:maassen@uni-freiburg.de>
>  'B'   00-0F  xen/xenbus_dev.h                                          c=
onflict!
> +'B'   C8-D4  net/bluetooth/bnep/bnep.h                                 <=
mailto:linux-bluetooth@vger.kernel.org>
>  'C'   all    linux/soundcard.h                                         c=
onflict!
>  'C'   00-68  sound/compress_offload.h                                  c=
onflict!
>  'C'   01-2F  linux/capi.h                                              c=
onflict!
> @@ -173,7 +174,7 @@ Code  Seq#    Include File                           =
                  Comments
>  'H'   FC     sound/pci/asihpi/hpios.h                                  c=
onflict!
>  'H'   00-0F  uapi/misc/habanalabs.h                                    c=
onflict!
>  'H'   A0     uapi/linux/usb/cdc-wdm.h
> -'H'   C0-F0  net/bluetooth/hci.h                                       c=
onflict!
> +'H'   C0-F0  net/bluetooth/hci_sock.h                                  c=
onflict!
>  'H'   C0-DF  net/bluetooth/hidp/hidp.h                                 c=
onflict!
>  'H'   C0-DF  net/bluetooth/cmtp/cmtp.h                                 c=
onflict!
>  'H'   C0-DF  net/bluetooth/bnep/bnep.h                                 c=
onflict!

[Severity: Low]
Should the 'H' C0-DF entry for net/bluetooth/bnep/bnep.h be removed now
that 'B' C8-D4 is added, and should the 'B' C0-FF and 'B' C8-D4 entries
be marked with conflict!?

net/bluetooth/bnep/bnep.h only defines 'B' ioctls (BNEPCONNADD through
BNEPGETSUPPFEAT, 200-212) and none with code 'H', while 'B' C8-D4
overlaps with the 'B' C0-FF range for advanced bbus.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114202653.3113=
381-1-rdunlap@infradead.org?part=3D4

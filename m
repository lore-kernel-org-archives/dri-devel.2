Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFF606A33C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o0fjg03K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D5F10FF54;
	Wed, 25 Nov 2026 19:24:25 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B65210FF46
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:24:16 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8b3577deeb0so2858005b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795634656; x=1796239456;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
 b=o0fjg03K99xbeglX8vH1Gk0O2zFJETttzyb/RmXWAYYAfkY6TFW29W79BEPeJkvCc7
 f2p+oMFidfUQijGKPrra0LGlteoLxGjG+XOzb0bxkH4fE9yv7HKPStIrLVPe3opilhp7
 cygLxqvJc1kQfH6Mj/Em/stQGJBmm+kLcnSBUNWrQ3MSnJtoYZ4du+VektMEZRagjqkN
 HG3L9CgJVpQEmZ6PXtXuUIRUrGEB8dlhiZHzM14M3xa2+x3ds1GoIDIsY8qlQVlFq0WQ
 N+MyCsIqB7kvO7w1T6UcqE2Qti22w10Usm4F4y6BDFJHs+GaKoaNAk8dIfThEE9KxC53
 Q//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634656; x=1796239456;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
 b=Bjy3USwCmoWg/R4CmwvFJdumWforCDMlN52Iwg/Fv+QZlQhnpOcNVTDGr1Mg5J6Na0
 fGTkEd+8wduYEa/ms7f1x0gvDuzu6ndDBgVVtQD1UO0VQdUw8HEzaW+XSAkCg7TYuxKT
 wXubuoXf7eD24IGN2Sp+w9X5DvYEZ6pPoLVs/vwySLy0ug5AYpCulKJGTSRiHPkgFrqh
 iqTgAgQl/jN1kOqPWkM1iEKBxg4hXz7ME/43E+ODbMrbTbAYDus0aDcWKLXJcO79u34m
 z20xmwFYkBbiZWqBix520unwSH0HCkyCzdsrahJ3zSw665ON1SYZYtFiHftUfci80fnT
 Ve7A==
X-Forwarded-Encrypted: i=1;
 AL+hErHj5L7N6kAOr3EOb17MgKojJgDiNai0BY2Jv3qRBHLKuLJ3e9joohRin8kLaZQr6tKe1L4xG5/czPQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z92RvwS4rzdrL7ts8+YmSxcWRQeQslrsbtgwNKcqks3eiFsxlwJ
 XUI7C7REDyFo/UY4fDoLWTLycQCknS+eTJfapi2Sp/YEZdIzryCeOI7Kbc0kmbo8Jw==
X-Gm-Gg: AZFdTZedI4ZXfYN5tXMZqg/nkdnOUCYKtZ9rbcHIGiXLsGs4PLszms3zL0aKhGjeEOC
 OTMmbOWhrTuUU/aiKHaT5IzrXfpuW2aPK1W7NkZxWxiImzVi+KvbY/wrR9tfMY314qFVU0dcflZ
 zXYAowYZAxmx2xD0RpihcZSrHQO6xC/YegMYyNGzhE+5IB7kbLDUFE6k9nZenM87vbltLaZe1xI
 0YUOb/zJjqb+oBktL/pYaLaf6A5gBx4XzoM4euD6sHGeQlh4dtqKYVXdDHXlYAXgITDytMcIlXg
 +W1mQvL2hti7ZVXI23+YvCKlkUbELrYGjhIbYEMvAsrOWt0sRWwvRtvhgEK6LhARl8GIDd0GdxY
 chSZhgoyZ2gwaJmLyuiBryDZub+t23Z/waxlSeSNmTy6HUkAFW8ilETnYhEPF9Kp347Z2rcVSq9
 Yz2M6KAg6vEvJS0BmipqUm9iDE9060xiAAr746nGo9Zb3DpwvEdu7npKsY5gybAcGmb7b+h3QLh
 EajhsCC9ojpSwYKuqp9boXaGECIwF+zoOwOcKVtBPD9smlLWf316wI2tfmyqprnkzopWa1tyQ+5
 +QK7sRChU1iPApX5KvvOQz0Iij19XEPivweCf2hNjceaXYh/LE35JFguq9KgVzjlmIqzlIDSXFf
 vawLuVk69fdD0L+NfCBkBT2kd6GsrhNsxGbslzuVkNyGkMJjl5w8fae1NtkJLfw/KFT90yFfgfe
 0PvkjoilDO/A==
X-Received: by 2002:a05:6a00:a908:b0:886:773d:a6a with SMTP id
 d2e1a72fcca58-8c87c199463mr15925448b3a.28.1795634654761; 
 Wed, 25 Nov 2026 11:24:14 -0800 (PST)
Received: from google.com (196.126.197.35.bc.googleusercontent.com.
 [35.197.126.196]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077bc47sm9717494b3a.6.2026.11.25.11.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:24:13 -0800 (PST)
Date: Wed, 25 Nov 2026 11:24:10 -0800
From: Benson Leung <bleung@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, David Heidelberg <david@ixit.cz>,
 oe-linux-nfc@lists.linux.dev, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 MPT-FusionLinux.pdl@broadcom.com,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 linux-mtd@lists.infradead.org, Neill Kapron <nkapron@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Hans de Goede <hansg@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
 devel@lists.orangefs.org, Paulo Alcantara <pc@manguebit.org>,
 Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v3 11/12] docs: ioctl-number: update platform entries
Message-ID: <awc12oWB5WDJi8XZ@google.com>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
 <20261125061340.3402300-12-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kk3dCghKBQNrocaf"
Content-Disposition: inline
In-Reply-To: <20261125061340.3402300-12-rdunlap@infradead.org>
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Kk3dCghKBQNrocaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:13:38PM -0800, Randy Dunlap wrote:
> Update the list of platform/ files where ioctls are defined and update
> the ranges of function numbers that are used.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org> # cros_ec

For cros_ec as well:

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
> v2: no change
> v3: rebase
>=20
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
>=20
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- linux-next-20261123.orig/Documentation/userspace-api/ioctl/ioctl-numb=
er.rst
> +++ linux-next-20261123/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -434,6 +434,7 @@ Code  Seq#    Include File
>  0xBA  00-0F  uapi/linux/liveupdate.h                                   P=
asha Tatashin
>                                                                         <=
mailto:pasha.tatashin@soleen.com>
>  0xC0  00-0F  linux/usb/iowarrior.h
> +0xC4  00-1F  platform/raspberrypi/vchiq-interface/vchiq_ioctl.h
>  0xCA  00-0F  uapi/misc/cxl.h                                           D=
ead since 6.15
>  0xCA  10-2F  uapi/misc/ocxl.h
>  0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h                                D=
ead since 6.15
> @@ -446,7 +447,7 @@ Code  Seq#    Include File
>  0xDD  00-3F                                                            Z=
FCP device driver see drivers/s390/scsi/
>                                                                         <=
mailto:aherrman@de.ibm.com>
>  0xE5  00-3F  linux/fuse.h
> -0xEC  00-01  linux/platform_data/cros_ec_chardev.h                     C=
hromeOS EC driver
> +0xEC  00-02  linux/platform_data/cros_ec_chardev.h                     C=
hromeOS EC driver
>  0xEE  00-09  uapi/linux/pfrut.h                                        P=
latform Firmware Runtime Update and Telemetry
>  0xEF  00-0F  uapi/linux/ntfs.h                                         N=
TFS
>  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       s=
isfb

--Kk3dCghKBQNrocaf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCawc12gAKCRBzbaomhzOw
wuvSAP9FFr45oXAv5Psc3n5xsSYyPFouusI/XwRnWy3tYxQspAD+KIeOTWQfcOeC
TWeqyAANog5rg68r7xNPxeH8I/R6xAQ=
=Fk2v
-----END PGP SIGNATURE-----

--Kk3dCghKBQNrocaf--

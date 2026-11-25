Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=Au1x/Qfi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC8A112132;
	Thu, 26 Nov 2026 08:11:08 +0000 (UTC)
X-Greylist: delayed 1073 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 16:38:43 UTC
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9E010FA1E;
 Wed, 25 Nov 2026 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
 In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MFjp1Epxvbzt1A9g4t7Y/jDE3CxQAavGU4RMdlNgNPA=; b=Au1x/Qfixdt8Oeg5ELWQmTzZ7d
 wr1MiZso849kQQI90RjKYgtWlHvOsL4sUODQa+yJU/QJtei3+nwrCl8XPzyxSYVWxD0jEkv9ZHfHG
 OmNUZEcDaNBk4Nn1E9cP7BuRGcZNEM6J6xtS4Ket7/m79g97o7hU8kn2wKyFBLeu8gwPpXcQdviQ+
 Hln2JCas14QUSmhfJsWIjqhstDco/PUWJlhmY/+248fQXkeCIGO5O9nEwcb7Q1W2v+0HrcyzdyrIT
 XwITUgiGSX5J7ehQY0B1lclNs46kSXv1DsiPlzDA2AP0RSCXykcJrKqmOyVKoOLO8j21CyIPiZYaT
 T4+/q8fw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.100.1)
 id 1xWFjN-00000000vNZ-3XTu; Wed, 25 Nov 2026 13:20:25 -0300
Message-ID: <9afd33b0951849b9a48c5a0783d76fde@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, David
 Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-mm@kvack.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, linux-sound@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 David Heidelberg <david@ixit.cz>, oe-linux-nfc@lists.linux.dev, Chas
 Williams <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, MPT-FusionLinux.pdl@broadcom.com, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K.
 Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Zhihao Cheng <chengzhihao1@huawei.com>,
 linux-mtd@lists.infradead.org, Neill Kapron <nkapron@google.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Hans de Goede <hansg@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Sean Christopherson
 <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
 devel@lists.orangefs.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
 <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Tzung-Bi Shih
 <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gfx@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2 10/12] docs: ioctl-number: update FS entries
In-Reply-To: <20261119053514.255348-11-rdunlap@infradead.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
 <20261119053514.255348-11-rdunlap@infradead.org>
Date: Wed, 25 Nov 2026 13:20:25 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Randy Dunlap <rdunlap@infradead.org> writes:

> Update the list of files where filesystem ioctls are defined and update
> the ranges of function numbers that are used.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: address sashiko review comment (ext4 00-2F range referred to
>     the wrong file name)

Reviewed-by: Paulo Alcantara <pc@manguebit.org>

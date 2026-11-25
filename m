Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9B606A6B1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=gYew8w2z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DB410FDA3;
	Wed, 25 Nov 2026 16:45:42 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745A910FDA3;
 Wed, 25 Nov 2026 16:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 164CF410D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1795625135; bh=11zt4OupvieQqDw22Q2ubqyLm0TwPHTf9uDp8UQ/aNg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=gYew8w2zbH6+bi/mBbqli+h0aBDamw00BioPDCMMC4Es4g+qCaaIw8gBYOLhfGAsU
 9mfNHzR2Wjt3eb5ezNkPplfVvqDZB4yLXc7H/uIjYl6k/R0SNrt0O4pqewchTPc4H+
 DoPRzU4+fJgJOU7hPx03jLkV4HVaXJMTTjxyrWRVyiE+GFkUio915W5ZUB0L5VMnbm
 Z5AtjEERksNhEMgjG3ZSm0ynjzhzYrKmQP0JaqQq4T6DitPDhHE0cz5cUJ9ItE/n9j
 Ip9FDRPDTnpXpMfA3rcqvq+BtjVyvtC+AdbQzNra/9WErFSqw5foLA7PdpN6n18WG/
 9pepodyHhS3sA==
Received: from localhost (unknown [205.220.129.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 164CF410D0;
 Wed, 25 Nov 2026 16:45:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, David Hildenbrand
 <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
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
 devel@lists.orangefs.org, Paulo Alcantara <pc@manguebit.org>, Namjae Jeon
 <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, Jaegeuk Kim
 <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Tzung-Bi Shih
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
Subject: Re: [PATCH v3 00/12] docs: ioctl-number: update entries
In-Reply-To: <20261125061340.3402300-1-rdunlap@infradead.org>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
Date: Wed, 25 Nov 2026 09:45:27 -0700
Message-ID: <875wxkx3ko.fsf@trenco.lwn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Randy Dunlap <rdunlap@infradead.org> writes:

> Update file names that define ioctls and update the range of
> ioctl function numbers that are used where they have changed.
>
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]
>
>  [PATCH 01/12 v2] docs: ioctl-number: update MM entries
>  [PATCH 02/12 v2] docs: ioctl-number: update sound entries
>  [PATCH 03/12 v2] docs: ioctl-number: update block entries
>  [PATCH 04/12 v2] docs: ioctl-number: update networking entries
>  [PATCH 05/12 v2] docs: ioctl-number: update video/fbdev entries
>  [PATCH 06/12 v2] docs: ioctl-number: update SCSI entries
>  [PATCH 07/12 v2] docs: ioctl-number: update MTD entries
>  [PATCH 08/12 v2] docs: ioctl-number: update USB entries
>  [PATCH 09/12 v2] docs: ioctl-number: update virtualization entries
>  [PATCH 10/12 v2] docs: ioctl-number: update FS entries
>  [PATCH 11/12 v2] docs: ioctl-number: update platform entries
>  [PATCH 12/12 v2] docs: ioctl-number: update DRM entries
>
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   91 ++++++++---
>  1 file changed, 72 insertions(+), 19 deletions(-)

I've applied the series, thanks.

jon

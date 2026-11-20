Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EB606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dq2Owl4T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A0410EBAE;
	Fri, 20 Nov 2026 02:34:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE41310EB7F;
 Fri, 20 Nov 2026 02:34:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1BBF601C9;
 Fri, 20 Nov 2026 02:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6D31F000C6;
 Fri, 20 Nov 2026 02:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795142079;
 bh=yLxaIFgMgiNdJ6EvHj90KmNsd7UyUa4rOHQt8MkQ4o8=;
 h=To:Cc:Subject:From:In-Reply-To:References:Date;
 b=dq2Owl4TQH5i1O8lPJeqrs/bhVJe74UawaV8WZGOjcpXryG9VX5bBPEuofmjMl6C8
 KEMZUEWUmofCrIT9kL1mF9sqs29c0Cyil2oxP83BwPsBQxJM3XbOQHwaj2x7OkBm3R
 Ubt4udGPNHycSNftWKTVPyy9zKiSLnNOhFSlFIOPsiCL9/KFgmw/r+jfOmYYUs/VC/
 SAI+QguGa/5ffH3iaZeehgrULZs3TCS3y0wcIRBQ7+1cYjuY8NOZbiPkIC9OoceHPS
 +R5fZniZZazVx2uAAw4qgmr08ft+ySZxWB+NNVSP3BxvosYlgijyZSgy8PCf4WR5j7
 gqEvBh4+Qs7GQ==
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,  Jonathan Corbet <corbet@lwn.net>,  Shuah
 Khan <skhan@linuxfoundation.org>,  linux-doc@vger.kernel.org,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Gunthorpe <jgg@nvidia.com>,  Leon
 Romanovsky <leonro@nvidia.com>,  linux-mm@kvack.org,  Jaroslav Kysela
 <perex@perex.cz>,  Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org,  Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,  Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Jason Wang <jasowangio@gmail.com>,
 David Heidelberg <david@ixit.cz>,  oe-linux-nfc@lists.linux.dev,  Chas
 Williams <3chas3@gmail.com>,  "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,  Helge Deller
 <deller@gmx.de>,  linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  MPT-FusionLinux.pdl@broadcom.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,  "Martin
 K. Petersen" <mkp@kernel.org>,  linux-scsi@vger.kernel.org,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>,  Zhihao Cheng
 <chengzhihao1@huawei.com>,  linux-mtd@lists.infradead.org,  Neill Kapron
 <nkapron@google.com>,  Andrey Konovalov <andreyknvl@gmail.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-usb@vger.kernel.org,
 Juergen Gross <jgross@suse.com>,  Stefano Stabellini
 <sstabellini@kernel.org>,  xen-devel@lists.xenproject.org,  Hans de Goede
 <hansg@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
 Sean
 Christopherson <seanjc@google.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org,  virtualization@lists.linux.dev,  Jan Kara
 <jack@suse.cz>,  linux-fsdevel@vger.kernel.org,  "Theodore Ts'o"
 <tytso@mit.edu>,  linux-ext4@vger.kernel.org,  Mike Marshall
 <hubcap@omnibond.com>,  devel@lists.orangefs.org,  Paulo Alcantara
 <pc@manguebit.org>,  Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org,  Jaegeuk Kim <jaegeuk@kernel.org>,  Chao Yu
 <chao@kernel.org>,  linux-f2fs-devel@lists.sourceforge.net,  Florian
 Fainelli <florian.fainelli@broadcom.com>,  Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>,  Tzung-Bi Shih
 <tzungbi@kernel.org>,  Benson Leung <bleung@chromium.org>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,  Jani Nikula
 <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,  intel-gfx@lists.freedesktop.org,
 Matthew Brost <matthew.brost@intel.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6?=
 =?utf-8?Q?m?=
 <thomas.hellstrom@linux.intel.com>,  intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2 06/12] docs: ioctl-number: update SCSI entries
From: "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <20261119053514.255348-7-rdunlap@infradead.org>
Message-ID: <yq1eccgqlhr.fsf@mail.kernel.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
 <20261119053514.255348-7-rdunlap@infradead.org>
Date: Thu, 19 Nov 2026 21:34:38 -0500
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Randy,

> Update the list of files where SCSI ioctls are defined and update the
> ranges of function numbers that are used.

Reviewed-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

-- 
Martin K. Petersen

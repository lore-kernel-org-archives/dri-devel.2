Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C6606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ds41J1Y9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCB510ED54;
	Thu, 19 Nov 2026 05:36:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5519A10ED1A;
 Thu, 19 Nov 2026 05:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=zaTgPA2ioXn8bej2IOl4WB8n/Qq2lc7VcV2P19XHg1w=; b=Ds41J1Y94G5phu/yjrxMx4KYs0
 fd3xEflO7koDu9fjKtT0RrT6JXtuJE3ZGa/b7tv14vHbrsGtLa9cBI8rWCSO9JxiwR/EzHbJ4YyWH
 8z4Lfo2FA3XkU/tifbzr7MvY35pYR9hWGECyuQjjenBjpJMzarej8UBGlp6AB5Cl5B9wZl2ct2hlr
 yP4GZiRBHQWZ0GJWk0TzDbpYf/RtAtr+lznKLzz5QUj256D7TrUxLU7g8UYM2iIVWUk5ZdrVUV65b
 sNHHYVEKZzdr+lQMzW/6WDGqL5WcSfqNg5neQakCI513B5k5l1uBxRkTPLb31FzLHo0nl7cBnoUgi
 7Q0sWVXw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTuoJ-0000000Aufu-00YY; Thu, 19 Nov 2026 05:35:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-mm@kvack.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, David Heidelberg <david@ixit.cz>,
 oe-linux-nfc@lists.linux.dev, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, MPT-FusionLinux.pdl@broadcom.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org,
 Neill Kapron <nkapron@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Hans de Goede <hansg@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Subject: [PATCH v2 12/12] docs: ioctl-number: update DRM entries
Date: Wed, 18 Nov 2026 21:35:13 -0800
Message-ID: <20261119053514.255348-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119053514.255348-1-rdunlap@infradead.org>
References: <20261119053514.255348-1-rdunlap@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the list of files where DRM ioctls are defined.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no change

[Since having multiple maintainers trying to merge these would
cause some conflicts, it would be more manageable for Jon to
take all of these through the docs-next tree.]

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org

 Documentation/userspace-api/ioctl/ioctl-number.rst |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-next-20261116.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ linux-next-20261116/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -98,6 +98,7 @@ Code  Seq#    Include File
 0x1b  all                                                              InfiniBand Subsystem
                                                                        <http://infiniband.sourceforge.net/>
 0x20  all    drivers/cdrom/cm206.h
+0x20  00-01  drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
 0x22  all    scsi/sg.h
 0x3E  00-0F  linux/counter.h                                           <mailto:linux-iio@vger.kernel.org>
 '!'   00-1F  uapi/linux/seccomp.h
@@ -268,7 +269,7 @@ Code  Seq#    Include File
 'c'   08     drivers/scsi/ch.c                                         conflict!
 'c'   80-9F  arch/s390/include/asm/chsc.h                              conflict!
 'c'   A0-AF  arch/x86/include/asm/msr.h conflict!
-'d'   00-FF  linux/char/drm/drm.h                                      conflict!
+'d'   00-FF  drm/drm.h                                                 conflict!
 'd'   02-40  pcmcia/ds.h                                               conflict!
 'd'   F0-FF  linux/digi1.h
 'e'   all    linux/digi1.h                                             conflict!
@@ -292,6 +293,8 @@ Code  Seq#    Include File
                                                                        <mailto:zapman@interlan.net>
 'h'   00-1F  linux/hpet.h                                              conflict!
 'h'   80-8F  fs/hfsplus/ioctl.c
+'i'   00-02  drm/i915_drm.h
+'i'   00-04  drm/xe_drm.h
 'i'   00-3F  linux/i2o-dev.h                                           conflict!
 'i'   0B-1F  linux/ipmi.h                                              conflict!
 'i'   80-8F  linux/i8k.h

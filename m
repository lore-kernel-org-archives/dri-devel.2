Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5570606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YiH3SH7m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E6610FA38;
	Wed, 18 Nov 2026 00:45:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5685F10FA32;
 Wed, 18 Nov 2026 00:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=pp+O9nVlY7Dd0pOoy4hVzFxCRF9cebkPW+ntWvA2M+c=; b=YiH3SH7mZh5azRjC5DVpuglYwP
 /iKE255VuIjZF8p8SUpvd+bDJi2Cbn9khM0+oh9gBkflB2X1NqwyWI7MDuZCtzN/EUiOf9ycfFb2z
 5xa6Y6leZvRCTkpPvaCO2gAGzMEnY4iuX5rAZ5iVP5TcNu5h/eq5W7oTx3KIxOrav0Swq70hRxUww
 y1dSP7oBViduGAbqBSvX6ZAkCQE6JbkGp30JRe2cikCtYqkgQ8BLnVrSXlZE7LQBsJoAZW/4cfak7
 oYHI3MtzPU5sXcifFGxWnjUZXedMZZXxQU/inZtKP1oiBda9awbGV712RoGVaCj9n6uY6jnuLXdvs
 CesOVeHw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTTna-00000007Ovq-2LYg; Wed, 18 Nov 2026 00:45:18 +0000
Message-ID: <2566e84f-314c-49a7-b342-0d0880aa8416@infradead.org>
Date: Tue, 17 Nov 2026 16:45:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] docs: ioctl-number: update MTD entries
To: sashiko-reviews@lists.linux.dev
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, David Heidelberg <david@ixit.cz>,
 Chas Williams <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, MPT-FusionLinux.pdl@broadcom.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org,
 Neill Kapron <nkapron@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
 devel@lists.orangefs.org, Paulo Alcantara <pc@manguebit.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Benson Leung <bleung@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
References: <20261114202653.3113381-1-rdunlap@infradead.org>
 <20261114202653.3113381-8-rdunlap@infradead.org>
 <sashiko-outbox-215807@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <sashiko-outbox-215807@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/15/26 12:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] docs: ioctl-number: missing update of 'O' range for
>   mtd/ubi-user.h to 00-08
> --
> 
> commit ccf1b77b46484d55fbc7ee02d93a71ebab16f010
> Author: Randy Dunlap <rdunlap@infradead.org>
> 
> docs: ioctl-number: update MTD entries
> 
> This commit updates the sequence number ranges and file entries for MTD
> and UBI ioctls in Documentation/userspace-api/ioctl/ioctl-number.rst.
> 
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index d47f817335666..1ff4fd4bf9b5c 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> 
> [ ... ]
> 
>> @@ -306,7 +306,7 @@ Code  Seq#    Include File                                             Comments
>>  'n'   E0-FF  linux/matroxfb.h                                          matroxfb
>>  'n'   F8-FA  video/sisfb.h                                             sisfb
>>  'o'   00-1F  fs/ocfs2/ocfs2_fs.h                                       OCFS2
>> -'o'   00-03  mtd/ubi-user.h                                            conflict! (OCFS2 and UBI overlaps)
>> +'o'   00-06  mtd/ubi-user.h                                            conflict! (OCFS2 and UBI overlap)
> 
> [Severity: Low]
> Should the 'O' entry for mtd/ubi-user.h also be updated from 00-06 to
> 00-08?  include/uapi/mtd/ubi-user.h defines UBI_VOL_IOC_MAGIC ('O')
> ioctls up to 8 (UBI_IOCVOLCRBLK at 7 and UBI_IOCVOLRMBLK at 8).

Done.

-- 
~Randy


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F2606A883
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=igCqbrdM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF97110FA35;
	Wed, 18 Nov 2026 00:42:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD9110EBD3;
 Wed, 18 Nov 2026 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZkGYeIrryqDq+inQbLWkmmEr1dkiBjnSvcr/8PVZk+Y=; b=igCqbrdMvYdH2Ll7yuVQgiWBLt
 /GjOlBhkNv3Atf058oFTC35r7J1y0Dn+izVMR4B7NTJEgzYPHyNBT/yjDLM3vKgbn4EFnLL1HvfM2
 G8HTUE2iRUo+Ako4z/l/tGbDtgdpSVnn3+sjWev4F279cv0k0FF8It0l+2omvAOvX90nrKkVMHldR
 y4SubNJLjheuSGQXijcB5uH5+COAZ+CInyJl5sc9OV63iS8Y4FJBagg/Ml+jigC5FfWN8akPbdtOp
 IW55/TtVzpAhYfHqN4Q+3n+P1FyoIpvl7F9FFouhH/iKFh+WdtjvK3wQHam39CoLFXiHmYbfepuXX
 RGWrdOyg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xTTks-00000007Onb-3pzj; Wed, 18 Nov 2026 00:42:30 +0000
Message-ID: <8d287ebe-56cd-4429-89c7-d89c295efeca@infradead.org>
Date: Tue, 17 Nov 2026 16:42:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] docs: ioctl-number: update networking entries
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
 <20261114202653.3113381-5-rdunlap@infradead.org>
 <sashiko-outbox-215804@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <sashiko-outbox-215804@kernel.org>
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
> - [Low] docs: ioctl-number: duplicate bnep.h entry and missing conflict
>   marker
> --
> 
> commit acf95c4d46bf87ab8fab382911993f6e83864afc
> Author: Randy Dunlap <rdunlap@infradead.org>
> 
> docs: ioctl-number: update networking entries
> 
> This commit updates the networking ioctl file paths and function number
> ranges in Documentation/userspace-api/ioctl/ioctl-number.rst.
> 
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 2b2d3fd317158..cd4f0bf6db66a 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -132,6 +132,7 @@ Code  Seq#    Include File                                             Comments
>>  'B'   00-0F  include/linux/pmu.h                                       conflict!
>>  'B'   C0-FF  advanced bbus                                             <mailto:maassen@uni-freiburg.de>
>>  'B'   00-0F  xen/xenbus_dev.h                                          conflict!
>> +'B'   C8-D4  net/bluetooth/bnep/bnep.h                                 <mailto:linux-bluetooth@vger.kernel.org>
>>  'C'   all    linux/soundcard.h                                         conflict!
>>  'C'   00-68  sound/compress_offload.h                                  conflict!
>>  'C'   01-2F  linux/capi.h                                              conflict!
>> @@ -173,7 +174,7 @@ Code  Seq#    Include File                                             Comments
>>  'H'   FC     sound/pci/asihpi/hpios.h                                  conflict!
>>  'H'   00-0F  uapi/misc/habanalabs.h                                    conflict!
>>  'H'   A0     uapi/linux/usb/cdc-wdm.h
>> -'H'   C0-F0  net/bluetooth/hci.h                                       conflict!
>> +'H'   C0-F0  net/bluetooth/hci_sock.h                                  conflict!
>>  'H'   C0-DF  net/bluetooth/hidp/hidp.h                                 conflict!
>>  'H'   C0-DF  net/bluetooth/cmtp/cmtp.h                                 conflict!
>>  'H'   C0-DF  net/bluetooth/bnep/bnep.h                                 conflict!
> 
> [Severity: Low]
> Should the 'H' C0-DF entry for net/bluetooth/bnep/bnep.h be removed now
> that 'B' C8-D4 is added, and should the 'B' C0-FF and 'B' C8-D4 entries
> be marked with conflict!?
> 
> net/bluetooth/bnep/bnep.h only defines 'B' ioctls (BNEPCONNADD through
> BNEPGETSUPPFEAT, 200-212) and none with code 'H', while 'B' C8-D4
> overlaps with the 'B' C0-FF range for advanced bbus.

All done (whatever advanced bbus is).

-- 
~Randy


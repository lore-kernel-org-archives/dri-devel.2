Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9D606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p+9zIYqe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C498F10F38B;
	Mon, 16 Nov 2026 18:25:09 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1668F10F38B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:25:03 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2ee254f6eefso6665ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794853502; x=1795458302;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
 b=p+9zIYqe+8fwLzsgUbjjh+M/l/Wrv3nSNDudgv6Vh6DvWY3TTG9bOgwy/RqlOW0bIp
 wWQngDNZXcKlUJwQ5gKqnaf0ZTeeTJXnTxIHT++y0mgqaRjJa3ZBbDUTXkmRQOFWeiX7
 hjnhKQPzRdasR1DunTh78QWKa2V+EBJhurv80oIKceiYEJ1s/VjzIJi/vm2pHbzwOhCF
 wHBMa/I/w3KE7T2TUdzPc9U+hD0Ce3mcHLb2KiCiP+vmobzVqO0UBp426TtWZJ8KYpil
 QaB/dr5/XqOIKM0PThG2LXO7AF4jUY4aw1/3BrhuecDTIkut+n7JlQbAw9BqFky+PIhB
 Cprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853502; x=1795458302;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
 b=Nc4AEioTxRfkl1BPvESPYDnOi+leeFphrgBWm5XkcDnU5AZvuRgLKn9FaCDW73LWQp
 udOK2CkX9o4X7EA9chGHBqf7n3oWIIoBnvr2a+b2Dy8CHPuwsfPDPNY9hwZ/fuBQknVg
 0tsM42Kc4vZfmM2NT6QVmHoFb9C/cNQubGV4Qk65BA8BWydgLh2SpLhy6j0FGLA0zkUc
 3vp6XpS3nDKYAU9k0Vv6rI4GGcJX2YYyJCFe3ajnhiSlrpunq4u5+/hmtsm7HCQiKimM
 KwECr65qOzd880FzdFmtDtaZfJ4n7aQwfAPCPiYLSdYoOVQFiolLitomoVku+myKw1CM
 c/zQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF6UHfR33CzV4ngrceyVThi9qHk29ez3/BgRibLx1gB3lEcnr8goaJnt+47YF0GGBO+eGyijWGAvEc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8THpqv5tG+ZGOA7lmhQ1z9wsw9U23ojEQkiY6IV+zYDi78GcQl
 hiMVI0+iGfIrPBJQSGKrZMeSsHniSxMqsMXK6VUDOBEywNwrxHQp33pPe1Inf9Oy2g==
X-Gm-Gg: AZFdTZfITS31GvcIB+QxKAe9ztxvz/eOvd3n+oIXMx9a0rasKX/7pxbw8nK/K3TUQvf
 eLHCopHoRvuHYoES0FDBgIIWYdz7yQI2sKxinXTSxyGpE8gUWCZ4gYa06M5KZtMJiVbS7X4zK4q
 5UdW7gYVkwWsbbwVw2sfTOUzha+eUE5VcvnhQ6tKTO3c6O1MEQyBwPKByVx+FsLDJ4Uoxb/Yq1G
 4Xjt3L+reAvGgQ5XUHExfIibfVIe9EKK1hlahyvXZ306mlSfttULclD3X7UWde8LozpMDJDCNQG
 10OP4abJHOT5Chen7+L4lVUvWcGSrjgsuLLzKgHCZ/pN0zl1kheyog+Hx1hgVcFrO/hrKE1qoZI
 Ox0N4jzR2RIp7guahtGKFamcG3LxmHSp7+fX5cc6giOwjDMkmIfUou1lj8TlcMhxxzohroVM8u2
 jmnP2wYlN01ZLWXpguLOVHY8jHHGfIfJLIxqd14AX3Pzc+JCRlewuf/cTfz0AqjV6rcZRi4KNil
 GqHHz8QKPxceyBmDEvitLaTuH7LcgJSl96kPy+h5l3UQ21Fn40n8fj8qJWJM8oq6e+hEQ+QrwLI
 zFGkDEqHSugDsPAAgFtEgYGJFUpOUZLx0sFkzYYfdDufO1s2G7ufK3/f/2xvx+8qSQoRu9FSXNT
 hcStp630S1QxxgD10meCCqw==
X-Received: by 2002:a17:902:f68e:b0:2e9:73e0:2a6e with SMTP id
 d9443c01a7336-2ee2b19e019mr7765275ad.17.1794853502041; 
 Mon, 16 Nov 2026 10:25:02 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com.
 [34.145.75.25]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac70ea45sm296668a91.17.2026.11.16.10.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:25:01 -0800 (PST)
Date: Mon, 16 Nov 2026 18:24:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, 
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
 Matt Evans <mattev@meta.com>, Matt Evans <matt@ozlabs.org>, 
 Mina Almasry <almasrymina@google.com>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <avtI--OIZu5E5sma@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>On Sun, Nov 15, 2026 at 3:19 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
>> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
>> > > Hey David,
>> > >
>> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
>> > >
>> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>> > >>     uAPI behavior?
>>
>> Yes. Even if we wanted to the locking is doesn't allow trying to do it
>> automatically.
>>
>> > The way I designed the P2P selftest support requires 2 things:
>> >
>> >  (A) initiator: A device that has a VFIO selftests driver.
>> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar()).
>> >
>> > So far I haven't found a single device that can do both. But you are
>> > right that theoretically a single device could satisfy both
>> > requirements.
>>
>> mlx5 can do both
>
>Looks like GPUs and NVMe can do both as well.

AFAIU the memory BARs for GPUs would need initialization. The internal
VRAM needs to be exposed (mapped) to the BARs.

Do you think we should have a P2P device "setup" step that can be
implemented for various types of devices?

Thanks,
Sami

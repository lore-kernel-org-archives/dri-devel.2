Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA01C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA2710EB71;
	Wed, 29 Jul 2026 10:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPAshUBs";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B959810EB71
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:40:59 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-69ffbd2a277so1212890a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785321658; x=1785926458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
 b=dPAshUBsUWDZ7hrdLHiTXFbphwv4w9C2LweDSC8sACkWCA/0t59qrNTAh2wGvUoHQV
 4izCpupyW+3unYvTSbZe1OTUz987BWeehuT95hRRZGVe6FsyH/kL3sdmiMjEj4txVLlP
 Gj31q1FDpb9n6VBO2B2Q3JcTOX5xJJDUUYXaKSs1pSBYIwyIERH7KVgKB2R9LUum1yN8
 i0n6EGLRajhFp+dKgA2sbDns3ZDIjUIVkkqPRG+xnSxbIIdp4GlJRLAd30I31p0wWAaB
 2YuLU/MMwwIvRPh94XQlICW2wQZsoermoh4IFFZinQl7+mrH9dSF93WxYgmflgrNxIRl
 40DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785321658; x=1785926458;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
 b=fNx4QlP3Hlt7mX8phbHejQM/iTqk9DMOnXsxkCH1Re3akVLimcYskSbSdzOY68JpZ7
 8NWNA5f4Y6iBJwy0agd+6SSH/nMyE5QF99FJRcTLDHkWMPfp8IKE8xJ9gCHEcBIZKVu0
 hlCQf6xx+IsnQCxRrd6l1dTVgKPsMMYPbYlmzrj18PNXbOuhY6i7NLZ3lUIpFzJHv3uZ
 yJAvfb3kMz/zIWeIy1XtLa3SGdTbayS5+LldFpBCsiv9M3n6uAoyW5pMEmjZ/hPu9MGQ
 Fl/BYAxwq6ct1n1q7pHCTsuP7HEA2nrqf/RTt02pYBoVFx/0m/1PSt1nEcqvg+onMnEJ
 XnCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwSwLlpAcAr1cDvhFEkmgCyZwZ8FcHhLCWikEqVy3fxQ72dF7d6B3MbOtcS0gV8ndUH8NsSYozxAY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywho35mU5rwX9740UXHQN0vAq9Ba2cyJnaWX6wTR7qO2j65ZV6e
 IPn1g6k3zAM2hjyjE4JOyrpguLNjGhP79Ju2xJpl72amDCoO+NdtSbC3
X-Gm-Gg: AR+sD12N06GA6zwWi7lNAjc6QqJsPCPsitE5qVoXnMVRC6BFApUw7TAM3WAhMQrDSZn
 vibTmFDlY3FIJ1JfXc2VA8vh8tps0eyfYkqU4JjJS9hs2P+35BY1XaVa+vfk01jSMfGpSRWgibf
 bmU9xztQgwqQHo2gkJ2ka3s9rseoFC+0yWpTfWE5sD9ehK8P4rj+oAdhpr7/icao0gJsmG7mTT7
 DuOzY9bUEIj/67AYsG2z6h9T9xV8CrSfGIlP0oN69BdyWRESpy6oVNctDMIr+YVx0Wstn3plBsC
 77OhCLEX0h+YkXufs6Yv/duoS/CC8n/FkwyyQ9e6BbfAryJzEj6Pnic5Fw+Ee1BHYePfl2thLYP
 lskmPPobEbTJ5u9rLvhO1lADfiT9VWt11/AqgmDJMbFFlod/oVWtQdHD0xc/eU/r2dRRnjSg0Hy
 VSskhTo1OTo9DREaUfVZhFXDv+9czISpKaH1hYDN7weFKcHQaaGhZk+mB1ObcX0PFj4c5LwOj2s
 Pby7YarS/cl4HFzf33qGuDX8BOJfmeYHY/+Fh3hreyMG9ukjtU7a3M54x0IsTWCOmMFBi6k2h27
 rPQl3/Vp/RwKCDjFtrc=
X-Received: by 2002:a05:6402:548e:b0:69a:596f:ba0d with SMTP id
 4fb4d7f45d1cf-6a034a7f6camr3086746a12.33.1785321658080; 
 Wed, 29 Jul 2026 03:40:58 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c5cf0bsm661299a12.23.2026.07.29.03.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 03:40:57 -0700 (PDT)
Message-ID: <7217c204-786f-4fb1-9c09-fc1ac7c8a249@gmail.com>
Date: Wed, 29 Jul 2026 11:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] iov_iter: add iterator type for dmabuf maps
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <132442812a40277a5904cb2a8ca1e02f4f6e82a2.1785274111.git.asml.silence@gmail.com>
 <20260729065953.GB9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065953.GB9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/29/26 07:59, Christoph Hellwig wrote:
> On Tue, Jul 28, 2026 at 10:29:14PM +0100, Pavel Begunkov wrote:
>> Introduce a new iterator type for dmabuf maps. The map in an opaque
>> object with internals and format specific to the subsystem / driver, and
>> only it can use that subsystem / driver for issuing IO. The task of the
>> middle layers is to pass the map / iterator further down, maybe doing
>> basic splitting and length checking. The iterator can only be used by
>> operations of the file the associated map was created for.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

> I'm also pretty sure I reviewed this and vairous other patches
> before..

There was a lot of shuffling, so I dropped the tag after a 10th
amendment to the patch as I didn't know whether you want to keep it.
I'll keep it all for v5 unless anything conceptual changes.

-- 
Pavel Begunkov


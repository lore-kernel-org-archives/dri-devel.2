Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C7EC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E090E10E04F;
	Wed, 29 Jul 2026 13:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6lJQU6V";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F9410E04F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:39:13 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso128509966b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785332352; x=1785937152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
 b=P6lJQU6V4U2CMxT1CO4ueWRbtIcftr3VmoJ00FkbqQj+p4DnLGI3EXZSYJNC6l8uYk
 1WPRxDfhqLjBd+yRTfJhMN2ndNtKcbT05m54Dqa7z7M7EGvHtLku9oPYD5Tfa0i/A3DQ
 a+hYl3oztfFiqt7OrpNkGdvvDOdVWpykUpPa0Km1LVM0U5A5fWXViWQ/t1wdh6VqTcN4
 ZgwYXs8qm/Mvth+Qj+Q7/sp3XaoEqa16MbTMS4u8KatUZ9lxW+G1KgqOiLvC9UTdlOKK
 +jqauKxnMLpQgGm92CiszCSBaIyEHPYlbQD4c+MWnT2syF0HajyLbZW+ARVh8efFuxAq
 jP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332352; x=1785937152;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
 b=kAjF5mVOOnwUKKFILQ+3xcJZypZiOo2uGHQeJgABEdf56fk/g6iaODU+NxvIWRtP9L
 Zd3gVOHEA8qXEg9h/gKzrbOMUAbOwPqU0ETxtCYQvKCQP5Pnn+y6wmN5zIyBjCL2H+K8
 Emwtue/fgmR0tUUKe/wBBLmw7O+VySJVo5+DB8yjBsXO8ubucMse6W3mAVfdVn8qJz4t
 Vky+ItaGMUBal/DecXq8F0uNZoW7axy/WWmbRRfp3dMbyORBpxp5dqK5qRZhyJbnce/K
 NLuMfh4FbzpCuUXaXY/nCxofqHIiu7d5o73wzvBUZ4k2hkp+BcIAloYtMBQmT2XQGADv
 NQyw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd7TQ4o/eDLqdEivmJnUiDUaRZnqUxLgF4WmCm3mb+OIq9bxg+6Rz9QhbKuqfwMdMxhQWARqIyRcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytpKzXF80iKXgpj/Ga3En2Xm8DHSYuROLthRLYBxGmXfCFdXpL
 VZHyn1OHH+mD/7amSLfB8hLSnWuiQVnkdKnkgcYkn6ewM5L1F9nFLNbW
X-Gm-Gg: AR+sD13KXHkfmIJb3o7kTqWWBbXcUhw/zfbdcBVmvXxxYtLYsFt54BoVzCwdr5udVtr
 jjclGzdUBONEZ4t65U2D7uyV20QvT9cxWsXiFMA7zd76jtuCImiKkFbBXzwCe2fDS8QQkkQfI9Y
 kb8PwP6te3EATx/ANBcIf99pQP7PU7shUvNUs9vMGs0ixHkBwAK6CXzO+mrut6PQZV/nvfDQ5yH
 E83llPvoMWsLvw88hv80dyLqGTPjVpC7Cw86jLfIke3CW3ZfcIXIf3R8Ao4XG1hozRkhkKTc/D5
 nLiWarytcmWmFAjADHIy7Tgf5KSsPZVPfVpzLDSDJ/1hgLZpXNTMX00QMGoSLK47tsh86UqZIKp
 UkuB64KbuWhTonmg5W+0ksoCciJhqUXb1tvHoV3B90g2FgqdjQV6TlxqAd/ITCl3al33hzqvcB0
 YNPUJoD2DuqqpmlmbugiOXZSh4sfwNod4LTNHSlnm40VkWYeJuF1FSJUzkWcfVsfXBmsztSjWNr
 tp6oVM5C1R0MiXQNKf7CztXQsTSkq9FEJ6BQgh8ef1aB2WM0kdKdS305dxXroi1/6l+W8zgwXwk
 JZfsmiTedF2FYFoG/gA=
X-Received: by 2002:a17:906:f598:b0:c16:7b66:4932 with SMTP id
 a640c23a62f3a-c1f721bf58emr374209166b.64.1785332351629; 
 Wed, 29 Jul 2026 06:39:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83f4de5bsm118685466b.29.2026.07.29.06.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 06:39:10 -0700 (PDT)
Message-ID: <dc72d46b-7b45-4beb-8e36-d810d2a94c28@gmail.com>
Date: Wed, 29 Jul 2026 14:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
 <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
 <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
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

On 7/29/26 14:31, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>>    	struct io_imu_folio_data data;
>>    	bool coalesced = false;
>>    
>> -	if (!uaddr) {
>> -		if (size)
>> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
>> +		return ERR_PTR(-EINVAL);
>> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
>> +		return ERR_PTR(-EINVAL);
> 
> desc->flags  isn't validated here, unlike __resv. nonzero flags should
> be rejected too?

good catch

-- 
Pavel Begunkov


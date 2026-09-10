Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF26C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC6210E33F;
	Thu, 10 Sep 2026 20:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="U2LEXUaK";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F8A10E33F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:58:41 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-478c01da5cbso93804fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073919; x=1789678719;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
 b=U2LEXUaKv4q5PjRpeC0a7peHudhksLDoYm1FjvmDLyQN8Ukdu365whkWj8cg4AbZCQ
 YQtESb5LehXdO1rHPY+rMlsxFf6Og+JF5kftu1u8zFFteQcTfja6+dQWooHuglqBJuyr
 lfT5natucf4imxA83GiZoZespSdWWPbvioFVtSHC6gKHaLeltfY519PUNQ3jvpoV2QJu
 q9EoGaYmzp4y1V5a75/5d19LD8xylaBR3PElXq/qJdcV8fYpdRFu9KxK8YgtLYg3Yn0Y
 2s72pOeh6DgMqdSgywOMBvoMo9cBiDBeHJ+7ZLYcK4Ks2hZwY7x1EOFbuaYTVfLtk/pV
 dDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789073919; x=1789678719;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
 b=JRr9K0omlqQ60y3K4c/3lHjz7F0a6iMf8d1cTJy2rpSjo+AZNtLPnJBoXJNq8ZMjZ/
 RXywmMOcgscXdmI0tY7DVZ6okzhGoHqQlYlNX1+QpXVy85pyXIT/o6HWxMMjyQc+9BZL
 1KDBTFZa/wOIZxfKzcZYPMIX4/XlfYMZR6nrUuA7+GVg3O03ec6xQiME3mp0cnWR5bLj
 5NbxEubHVybTWKANMx3bMukSKsjkVi0k0mwLtSplJMIrnUbzG92g1KdYB/X4uyXjYlQF
 So9w7F8ImRPALM0Su9achY659N6VljzAW5J616PPYU59eg1lrbfSnA9NalGXnLw6lBcV
 mZ/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcJ/gwu+rkGO1Ni2X3lvFqpzLRJYj/3RDA14LmJQhvEDUcURchCP0xLZzK0h6iL8X8huWiSDCoeMk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHyvebyaP9+iJtvpesc9RlidhfZYz99WBpfUKddgktDS6DIN29
 8b+mx5YDwR3TxknYFFY28do+eTlw2vPYepQ3+HcxfSkuFAjlnqACiqON8SbNQqITbsQ=
X-Gm-Gg: AYBFou2bVMF6N0pPDKK2Q0+y79aPZwYE6xeUGfAVfy1XzLfDcF+9HZKTVo5bGa1EXK0
 zxiDullVZSoqO9gdix1ykWPCsYHGsj5ArtvOw3Os8xGiIPkXSGpkO7npI9kjine4mhJ106w4pNV
 suPRAmnNTAYVXJW8N240rEmd0+4+lpoZZNTHvknRf8VNVZ4vUh5WCuMQzsozj3A2jPaWFPjjbCa
 31jjlIbXtC5V/kzXyEHrLSqrJhQFmZh9WHlqn1TdKnxkkgSJ2a5vArVBNUTFLAjYP3KQpFFGaeM
 cKHaFN226UtSMc6WBueFRQgSmVl2hv1ac/T0NdqZ2FiGVNMpiKtl9gUr53LiWgkvJR8W6gTInza
 Mnq8IUIQmdW7/4EjhpXnLfOD/QKuO1G0rugUeLBeRwOZ9LQ9V43eUeh843+gI2ZDlLijlAj7pTl
 BiYvmKjQqMQQ1jhe2iF9XHLrBzyQgbJAyxDc+qDU5k30k0YTqMsDObHuGHylEQHJJE7WS3zu7qB
 7F4kyKk70B2YrJD0XKKOGVdsvGSn46uCCU6vG08q8tFp9D635PwVuGF
X-Received: by 2002:a05:6820:3411:20b0:6c0:5630:bdef with SMTP id
 006d021491bc7-6c0bd97850emr353461eaf.67.1789073919642; 
 Thu, 10 Sep 2026 13:58:39 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09a122443sm1108879eaf.9.2026.09.10.13.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 13:58:38 -0700 (PDT)
Message-ID: <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Date: Thu, 10 Sep 2026 14:58:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1785596451.git.asml.silence@gmail.com>
 <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Language: en-US
In-Reply-To: <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
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

On 9/10/26 2:55 PM, Jens Axboe wrote:
> 
> On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
>> The patch set allows to register a dmabuf to an io_uring instance for
>> a specified file and use it with io_uring read / write requests. The
>> infrastructure is not tied to io_uring and there could be more users
>> in the future. A similar idea was attempted some years ago by Keith [1]
>> (from where I borrowed a good number of changes). Later it was brough
>> back up to life by Tushar and Vishal.
>>
>> [...]
> 
> Applied, thanks!

Eh no it is not applied, was just looking at the series locally and I
guess it got added to the b4 ty pile.

I am, however, wondering if we'll see a v6 of this soon? I had some
comments on the nvme dma mapping, that can be improved, but I'd rather
defer that to post getting this included.

If the series is dormant, just let us know, and we can pick up the bits
and pieces.

-- 
Jens Axboe

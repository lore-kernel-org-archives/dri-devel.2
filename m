Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92B6C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA3B10E4AC;
	Sat, 12 Sep 2026 12:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U5FKpkHp";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9BE710E4AC
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:57:44 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so2131475e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789217863; x=1789822663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fAOw7eoVc0zYvL/f6e+XZRwdegk97u7KcjQYPN92otE=;
 b=U5FKpkHpFuga9I1uh8d7YvJwmDnDWwuwmUlJuKiXP+785ruVpUmGfULiWog9UZKVXE
 ZE8gSdoBgYePLUc/jxufCe+kAn6zfLGI145MST6yCztV/YwCgMZGcTlVu8F22w/vGMrL
 ViYyoLrU9Tn3m8ObUxnpDcz+66lMydOou4kzTXUfenZsGlX5dmA2H1OmPx+oynHLB6F0
 gloGAUHpHbAgRlYWSftMla4wsuXbWpN4XCbMUY2moFDh3CJHlpc6pW9RoR6cLXBTaK4k
 pMl35yvJHv4FnshEk7c66qdSUUtKRqbN5NrdE5O5evw+pX0RKqA2Y550GWUJw6RE/YQI
 /r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217863; x=1789822663;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fAOw7eoVc0zYvL/f6e+XZRwdegk97u7KcjQYPN92otE=;
 b=L1mxg1eAPJMMaiGm5Y7CyAGhnWXWT6LmSLJLmW3y67A4CfUeGiVBMEpDBfE2Zs+W2p
 pQd4rzbjclkymSYYq3KB3qcZGkJ4i85GcU/RFi5RDStXYLgIIpQi/GgUGozdCd9NMB3X
 aTetLSjbZ2v5WsMAanx1wVVMWbKn3+fzKmGw3sgG2JkapKvAried+I40gnTgB49b0pec
 rMxdDwGIvLrQrN4zw0MrN9GCcWny7WYd1darQuWQEl9mKdq1KC+vepBz1RwwvZqvG3I8
 EkIyY764qyFYORFgBcWdvpwUmwIQMqYLbcy1Fi5+j7stII7DPxv5n1PObl5MH7nKsrXw
 tz4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqkVq8jxy00dUuilOQ2f7LrMocNl0bWM+522zIRqq4PKTrlgV0sfbCn04o9dbmpp++TMwOW8U15Jk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nxYW4tUR0adTea1n2d18B7DNivqaAherRSxIp3cNOLYVJKCnqg
 ZW5bneJQxqel3uhB3zObfYe515mvxg8DiGXaZ5Ls6kLweN9a2rxE9Enf
X-Gm-Gg: AYBFou2Rdv8LH7Gz8PPdTrgBFnejVmnVMNhwoBE349G4LSKvnmm7Mb5Z1zBspMfCkgi
 JVPgi9oQtRnBBw978v/JHf9TbCnPoVZ/VZA3Y06n3TgLqALZlVgBozE29HSAJPYbd3a591IIicl
 v+kOxzRcw6VOnt1DqzAo6OHFnVv4gnNOZv3sADXgHAXwtbFg4zraHuc3AqPlu6VhnHOvFiERO5o
 Gzo1WgyC1nQYPngvJrGFnzjqi4VrrSsGivXriSsToh84JqUf83evgJ3ft7JzlAVBHHtPJm1xVx1
 9ydc1hYNrW/Qe3NsauyD/FyJ4PingxHISGfgYdfLv7BRcqXHLqZkVTpJmj+RFR7F82pBb0pF2iM
 VIbGUIKLkWg/cGzrfM3d8hmeJHz1QFBZtE5y7rpJh+JJeXCZ5GdFyPDLaTD2sQCZ5hT9xAoiZIq
 cQdbl0T4bFvmyCsxP3tqlPF/A65UVPVSUSR5ukBgjYJOpt4/2RiXTWcsjHQbQteRjDQYeafGie4
 CNICl2u4c5LiMo59rabTtA45/Jc/l6uQR1118jjYJfinGwsNxshP/v0W8flTCtNG80LFwjG3bUn
 VcpGdiG64HrEGo+5pBNX21Bgetc=
X-Received: by 2002:a05:600c:6812:b0:49d:1d7e:4085 with SMTP id
 5b1f17b1804b1-49e6cbec30dmr21535245e9.22.1789217862965; 
 Sat, 12 Sep 2026 05:57:42 -0700 (PDT)
Received: from [10.192.161.217] (82-132-213-27.dab.02.net. [82.132.213.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm12751635f8f.9.2026.09.12.05.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 05:57:42 -0700 (PDT)
Message-ID: <0c787163-dd07-4389-b9d5-916b8753f388@gmail.com>
Date: Sat, 12 Sep 2026 13:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
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
 <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
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

On 9/10/26 21:58, Jens Axboe wrote:
> On 9/10/26 2:55 PM, Jens Axboe wrote:
>>
>> On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
>>> The patch set allows to register a dmabuf to an io_uring instance for
>>> a specified file and use it with io_uring read / write requests. The
>>> infrastructure is not tied to io_uring and there could be more users
>>> in the future. A similar idea was attempted some years ago by Keith [1]
>>> (from where I borrowed a good number of changes). Later it was brough
>>> back up to life by Tushar and Vishal.
>>>
>>> [...]
>>
>> Applied, thanks!
> 
> Eh no it is not applied, was just looking at the series locally and I
> guess it got added to the b4 ty pile.
> 
> I am, however, wondering if we'll see a v6 of this soon? I had some
> comments on the nvme dma mapping, that can be improved, but I'd rather
> defer that to post getting this included.

Working on it

-- 
Pavel Begunkov


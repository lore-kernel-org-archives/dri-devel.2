Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1254AC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEE610F689;
	Thu, 24 Sep 2026 15:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LGh1KzZ0";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A9710F666
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:53:50 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso1978673a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790265228; x=1790870028; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
 b=LGh1KzZ0GlwlkKB7tEAuRopmRWO9M4wSD7Wbbl69X8bl6uYVJrRFmXC7l9h2kCpKnC
 DOZzsd6J+HZX90O2gaVr/nzeKcloDxHVoIvc7DtXXZZ7aGc2IGTbIvGoiZCiJGovCQNC
 Zb1EZMvoGwkIKm797SbMUrs66UFLGCJOjB9HaheVHDys0hyvkfzOR/HkN3GXvrLs0PUT
 YS1Y0UpHEKxuNvB2k537X/cpaq/t0eaqU6aITttHxazEAnV75hmkMS46D6FQbrXqc5jR
 yXTwm/OS8pxgeRlkA9sZdpNJuw/s/fUpEjFuQVqVQvuoO8ywezyjhbPQbwpYIjQAn0AC
 kXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790265228; x=1790870028;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
 b=UOQGSRqLP+lArDnEryjP9vorXHegI4HZzgLYpCH2gR5SSi1f0bMyKV9jVPoiLQvgLz
 P5orBT/ePuMT9NbLsm0bnobpisdcvjG/Khmq/Whtd1tUZ4NlqmEzQToKdCWL0ePl+MPE
 fURuOeD9WCuAd4fOJlKGhG1mx3Id1CgZ0UGYmQlfTQMULHRGEI1j6JpWI1Lrbn0pR51K
 fPiHbhQ3b4FDEwyI9LDbACsK1H9/vsrHGy4eKIS5Mnysk/nKersskP9c7PMa201kxUXQ
 vqGgOleBIrgtr1vfHTfu0dmy73qpzKT51UaEvTKuipaePv6C8iwESDGTHldiDqxUcYIs
 2VSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvjrI5Y+oVyGcQ+cUa8HV0CfcF8l+Mcjtd+FoCOkNNDVgBs+w7p3LCpQQMzciTt1Mt+wQ8QIo2cV0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNZ6opEAPDqSGNfM6iPjBkaI5+71CTEbAwLKHsxfCkewa3apgr
 fqeVVG+fWyWE1umOLf+/5JCPHKOi8acubRwVCQYfg/+GhJHxR6WgyuQ3
X-Gm-Gg: AYBFou2Li3KoWv+vdzhNU1QYu9H1Tpm24Jtfkxp6UG0IyDbj0rU1ViPtge1CfbkxQ+T
 TVrA1Zz4aWzWEKDH+XYRiqNhcTfYkfOHtVC7T/JmCSyC6sZcbcRZXCqMKCHZZHhRhc3qG5KUlzI
 KO0XturgzKcEIcmbyMl2v04nVLRjZpRd/I+N9GK249dftO5bWsa6oO0mqFIlMgfVv5mBEvBAdC5
 wy0Sk1raATr/LYrwKMonoQyb2YuoCwgosjeb3Cun1RQzU03R+73id5tkUVADgf5dHUPYimQ2hjf
 rDD0FENkUhvnKH0BD4reQreQ27ENLIiztDjV8QDIx8c1blbPeqrj0uFTEqRg7r99Xs3Zjwvytup
 AxtZAsKrXQKLmVbFZpJ7j5CXENfvCTy7Jps7cQL5hXw6iAqpYeik75w3Pw9TN5ppF+kSCfUWeqJ
 Se594d+8DZCHARDlSU/NZxUVWn/99SzCp9zvbDMGFn9QppaUe77j5oSEENWqQcgvc3sbIf2G529
 ZPcJsRzLojjOCupjJurAdvrFQEtG5VcQobm287XmA2GAoA3yQmw1d54MbIZht5llfolEAb5YOsx
 COQMVmoouqYmCKTIrPWTCg2saaT4WHh2FpQt8NfV238WQvhpoQ==
X-Received: by 2002:aa7:d94b:0:b0:6a9:c9d8:b3b6 with SMTP id
 4fb4d7f45d1cf-6aac8f0ae7emr1949690a12.6.1790265228473; 
 Thu, 24 Sep 2026 08:53:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab38b2fc5sm3815784a12.27.2026.09.24.08.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 08:53:45 -0700 (PDT)
Message-ID: <6d538f3d-dd83-4dfb-b091-9b84acf47c62@gmail.com>
Date: Thu, 24 Sep 2026 16:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
 <20260922132016.GA30684@lst.de>
 <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
 <20260923045505.GB26231@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260923045505.GB26231@lst.de>
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

On 9/23/26 05:55, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 02:37:08PM +0100, Pavel Begunkov wrote:
>>> Sashiko had a few comments, which I think are correct - if we use
>>> dma_map_sg to map the data, we need to use the sync_sg APIs to
>>> transfer ownership.  That only matters on non-coherent architectures
>>> with MMU, but we need to get it right.
>>
>> I've seen that and fixed everything locally that should be fixed,
>> apart from the sync. I wonder what we can do about that? I can
>> somehow replace it with the sg variant for now, but sync'ing the
>> entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
>> not wise.
> 
> If we'd want to fix this for real we'd need to add an offset to the
> sync by sg methods.  Or move away from scatterlists in dma-buf, given
> that they are a horrible API.  All of these are bigger projects,
> though.  So for now I think you'd want to do the sync all, and have
> the people who run high-performance io_uring code on non-coherent
> platforms suffer.
> 
>> And I can think of another place that does mix sync_single
>> with sgs.
> 
> Which one?

All the recent networking zero-copy / dma-buf apis.

-- 
Pavel Begunkov


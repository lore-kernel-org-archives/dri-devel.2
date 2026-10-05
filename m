Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997F5CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD19A10E8C2;
	Mon,  5 Oct 2026 11:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oU64JPYK";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4300B10E8C2
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:45:01 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso1479460f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791200699; x=1791805499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZTSRnK/72f03OAFyRZNcD9D1Hs2QM4XwAkI8vZWB3T4=;
 b=oU64JPYKX53nACzqJdQhxT4K4zdfZMLcslBfZ4ehLW5CaAOSUgWoissCOtzUlhqnPk
 ygAhowYY+sozXuHeiTmFHmaPQHw5Bw1Gny1Q1UNm4hFG2Z8feilGVqQsaL4m5KN7hMbu
 1VbTjRKxx31WojolpVg0cZV+4i0sqwT2fO4JqggJPraGCqFggmmbQq1jZMnRT8S/eOPg
 gGQwEPtHYZOw5Uc572xoyd8rUevyncdEiO9OGxtnngXOHtntQfeCmKH1YiFBVY/AR1vU
 pTG5pjxf/Fp3B3TMFfTXgLdMgriLeNJhRGVsDfibffpvEBLGjUfBa3fYN34ngc1eKvy+
 BGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791200699; x=1791805499;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZTSRnK/72f03OAFyRZNcD9D1Hs2QM4XwAkI8vZWB3T4=;
 b=jM+QW7ZR6wOwUPoQFH9gAS1IrLGycj9w0gxyYY9aaQPasK5PncATbZnke972B5HJqA
 IV40W+Xd4fso013rTCwxNsIuKpQs7bKfokQVqRQOQJzp8+iDgc2jGaY5TJ3ZzaAEHHR2
 MDeJmFV8WZ65gcmYN7Uh5ACcHYeGy3mvS8a4EQNJWNvTC+lEPwHr9a7Pf1KkyqzP+qB/
 fyP71n+i8XwCgcITtQvWAznPRLEMwgWI/gThC8TNFYEq019EeqFzhfXx//HZYk0W/R53
 OXF6BNm3rPhtfFt+42KuhiyqaC1YSBVTNHBSNAS/i1cFAe3c7fW7XSVF5kNh2ORq0820
 w9AQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjGdkRArwfidEaeFb0ssCYOhwW9SmMrlqgMdrEqsDuORPLQ1vPQyOVNJOEQoKaRIoA0quem911pMo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/Q3ecJOBPwIFkWqMo1c931fS/jjFHvFR/tUZUNRUruwnIGOWQ
 cFBT7oX6PGqeP/Q7CdgqneMBfrmMwALN3sbVUcGeQ39lxhsSE5P+aMk8
X-Gm-Gg: AYBFou1jct6Kek3g8CN980R/cjwICztJmY20FxmsPc2mHhT26tuFLFaXe6zcBIjjte6
 6kaiRKUz3vuZsCuWBxL+tolCmRnZ3pat1HZ0CR+Ec3qUFgk5w+GLiusfWyxRif7PtTQ3IJq6wcP
 68si7uATzr7ibbwQnsaGnixU9gJvhlTW3RJtHZyXy8n58HzlqUIaaDrIJh+vQ5+JgmaHVdIwkc1
 zRnGl/dObn1QTkzaqwl15a5TUOa+S5RQof3r/yqAC6CpQHq1tR2Je+CwybXVrFC1I9aGjEgk2Tx
 OtD9TWfkzOmy0l4/NCbhmdO+YvbxUwym/WrOpl97tbn/C5NMf9jSzk5M+2btc8/1J2fv7Sn3R+T
 nWpNIEjzS39wSmnDfQYGsSUmJH0RxP0yM0/g6XhI2ccZyfQNjhCso+UqZ7K1waZBKHC6HUAZy2g
 V4sRNcuHN9S1y78EAU3ijFxyVStN3inz/KiczCdEEhCbnY/0E7Cq7+0r79TsEdbxP6Vc5MrVHZx
 c3dnKFmRR0wLfjxlNZU20iAVFWYC04dggbyyj5hFRTSrBCSSNBNynRi3PL4kIV2uTu7/ds0xb0=
X-Received: by 2002:a05:6000:186a:b0:48b:6bd:1af6 with SMTP id
 ffacd0b85a97d-48c48000099mr10478688f8f.40.1791200699411; 
 Mon, 05 Oct 2026 04:44:59 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62270751sm3087877f8f.13.2026.10.05.04.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 04:44:58 -0700 (PDT)
Message-ID: <fb0ec34e-deca-4365-8802-23d5688612e6@gmail.com>
Date: Mon, 5 Oct 2026 12:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/13] iov_iter: add iterator type for dmabuf maps
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
References: <cover.1790602223.git.asml.silence@gmail.com>
 <74a9d65f5c4f9acce5f57ad5921a9fadc6eda712.1790602223.git.asml.silence@gmail.com>
 <20261005091008.GA10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091008.GA10727@lst.de>
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

On 10/5/26 10:10, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:18PM +0100, Pavel Begunkov wrote:
>> Introduce a new iterator type for dmabuf maps. The map in an opaque
>> object with internals and format specific to the subsystem / driver, and
>> only it can use that subsystem / driver for issuing IO. The task of the
>> middle layers is to pass the map / iterator further down, maybe doing
>> basic splitting and length checking. The iterator can only be used by
>> operations of the file the associated map was created for.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> FYI, I think the Sashiko complaint about iterate_and_advance2
> is correct here.  We don't really hit that in the series, but leaving
> iov_iter methods partially implemented and fall through to others
> seems dangerous.  At minimum that needs a WARN_ON to catch that case.

v7 already covers iterate_and_advance2(). It complains about
iterate_and_advance_kernel() but there are many types this one
doesn't support.

-- 
Pavel Begunkov


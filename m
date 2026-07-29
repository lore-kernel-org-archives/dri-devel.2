Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13688C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE63710E00D;
	Wed, 29 Jul 2026 13:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YMH0j/8m";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B4510E00D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:11:31 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so9691085e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785330690; x=1785935490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=;
 b=YMH0j/8m8+Y812KkHwWQtGrbALj1Y9PXbBNpr2/AuYDkaakbt/g+8zh2Hj5lsy3jqL
 I+U2CS4rWwesiOZFMJWv/FZ0Olc8PMV/2LMVLpry1RNeRDixfpUJo9pQA0ZTC8l0NyNM
 KsCQrf0bEbiSTPQxGRPtbbYzCWi8T9XmGHQ3DuGiHJxfzpofZVZPIxhMLtJMfGb8RHec
 swj67eAVdnN48mjE3EPzoWGuU9YowwY1daV98saF3aAeUWvxkuLy9ew8aamQ1U/7Mr6f
 XWCovCZrligjaDkt+OhQIiBvZmC65iOAj4hB5A1vUQW5dsQH9t3rCewN9+FgMRk8APU9
 Ev/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785330690; x=1785935490;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QlPatibx3g8XfK6S5eprVRseiFbSJCNNQ3hXCye36cc=;
 b=ZsplRELHrlk29HKamZIGkMz1kTSNmG8EIFgEtg+WZG3nhV10nGU0BgLNPfH/4h3vAV
 5UhoXykRvEnmEIZ7qYqbLRJXNJPiI8XsYigqoaHlcOdSYoI1C8YFbJaOMKvfmFGaT9qS
 FbRawlinep0q+gMD3Zi+WbSojVt2uuodQUXsUbNtFNAIxnVtn7kwrlWnR3CmwccgSMtU
 mBEP8ubPA8I4zZxwUtcy/JLChxHGXfbkRx1bf3WkYUotHuPWfqYB3AIB1R8ICespGQVY
 qemcNBapRb1oRb0x1vdTNrNxjXyypXXN3ugbxOWPGYy64p1cW26QHsK87PrwukVKdsIr
 8Qjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd7nTp/nWUtVp8wQ3/HEfa0dn1FG7iT1XZSQrJLR6Is+Ui8sl6xFya7qgWP46ww7tjsm68bezswzM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHEjQdOL/5QZPy+uNIeUR7d/8cimephbtIk+09yNudGDtfdwkl
 F3dZEN4P5/OjnW0SsG9gzopD57RYa7BHbUJZvkrPWbU84kxfKAoMtc8T
X-Gm-Gg: AR+sD12vDirM8I2Wt+ocb+cgIWVUqhiDPPxifuXX2O/QEdiQLbcgask17ulXOFBljaK
 NcWY4FYGmLoDyKKhjItTCM/85sGrW1StdxOYDpyNnBR8eey+3d6XShVxSXmqET+XAmXY4MzmvRO
 mtEir72UzQd4x97F1xnbsk1+Qg1tX+i0Ks2HS8+sJBeSA1/3ftgB5asa89Hj1klty0ISy6jRR+4
 ofh4h6IJU9WFLZ2s+80QnqJNHQkjKBpwDDUuRdtKDjD3Xl6M0JQcvyBxp6I1IA+zzD75y3WRwcY
 IrdVHnfgGIKxdvq22xxhkubg2xpuEPQM4dqETqPuKfn7jdQiM4G11YywZ5zDOrZRVMnezk1/ghp
 1aYFja/mnjMiOpjWeSMskyWymMLhCOQJ3o3j+uIYvG07Og+26TqLGECGLwBgrivmZSzP1otSblP
 He/0L1Da2glZvQ/VzBQY8vPWZ6baBmbVYVqmaxMfiOisEqt7O1bJ+SuJ+f5GYX7bhejLilyUu4w
 EMSe/5/sMEFfBOiIOJX4USOEjNfUel9ghY96sA0ZsH440XQyBxmCfv8x0hWm9SFbUfNSwZhR2zz
 kLGYYyLXNZ6oRawjtqg=
X-Received: by 2002:a05:600c:3485:b0:493:b243:8ffc with SMTP id
 5b1f17b1804b1-496c6586bbcmr69846215e9.35.1785330689440; 
 Wed, 29 Jul 2026 06:11:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c338fsm157280305e9.8.2026.07.29.06.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 06:11:28 -0700 (PDT)
Message-ID: <60df6af0-3bf0-4954-8181-a0acca7c21c4@gmail.com>
Date: Wed, 29 Jul 2026 14:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
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
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
 <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
 <20260729112808.GA30851@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729112808.GA30851@lst.de>
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

On 7/29/26 12:28, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 11:37:19AM +0100, Pavel Begunkov wrote:
>> On 7/29/26 07:59, Christoph Hellwig wrote:
>>> The method name feels a bit convoluted, but given all the
>>> previous discussions I don't care too strongly.  I'll leave
>>> the dma-buf side review to those who understand it.
>>
>> I assume you mean this:
> 
> Yes.
> 
>>
>> +	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);
>>
>> I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
>> see what I can drop out of the name. Suggestions? Maybe I at least
>> should make the fs op sth like "register_dma_buf".
> 
> I just remember scares from the last discussion :)
> 
> register_dma_buf sounds fine to be, but unless I misremember there
> were objections to that before.
I'm going to respin the set in a couple of days, just going to
leave it as is unless we find better options.

-- 
Pavel Begunkov


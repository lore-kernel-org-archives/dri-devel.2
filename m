Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F33CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1824810E137;
	Tue, 13 Oct 2026 20:20:37 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D742E10E137
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:20:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so27445465e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922829; x=1792527629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
 b=tGNJS2fUqiL2WA8P3XhBA+mLpaoN1EHdZCLTUZFl7W4zkWaaFV6TDAFCD6QBviohA1
 B2gj+9Y09U/gALkAz7+M1kox1hIlK+KN4HY4FFk0iM4bpWz9ET+QpXWgyAeXMdlEZubj
 /yOL3dpj5Vf8zwxfUzgS6co/T7jWNV7OC8H9ceua/0q14hOYXRz2j0yr9pdyc3cgpDtg
 RFM4xmQ8yHOTxYzeiLASN1y1grAWdrEKvo68OnM9a2uh3UwvwsHSsGX785euEZeqfuI5
 gBXUZmBWq5NDbXeBknyejp8VM/r/EBXR6GVIJw4TvpAtyED/B+roE56ZkwvynZsI5dRH
 2yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922829; x=1792527629;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
 b=pYlGp1aTziI5rwA9Ys8NIX3g5aE0E7zCzo0KctSF4xx2NsuqeF+Eaixb3nwNJTNom9
 1gPMLCm6ZBMbT/MMJC/OwJwJna3XoUNbQ2gGK25kF3EVhLc3DMEb3zsUbk6sRRuGzMZY
 KHCgTaDt6KZKhKJGgTS0iT3+/dznc0j/ebNcChBUoINyIFhT1er0yKjnQn0dCTD9aZmZ
 LAyA75zhkbuuozDOoIpdTIWUqB4oRwHee9bGxo7YRQ3Szz3XLD2LmPJneFnJdvmc38/d
 Jh3kyasJ1ivtAdx6kJgwGyThiz9aFdlcxcg2Ou4c+qS5zTghiVDg2YwybXvd0dLlQDCE
 kt4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxAKlsxuety2TNgJLiriFxgWG1wCQbXsisCMis6DOxTeOwTZ9vIyjXKnL/xFlUAIGMghjvUM/PeNs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLS9HXx3DkWbQ1ZuvE9WzstHoaT3fYK5FXHp3UqKaRByVdMNz3F
 mXeiTlkRA48QU6i3eK6Kz/YmPc43ZN9RbNDR5cNP7ykQ+sk3Q5vkVY5J
X-Gm-Gg: AYBFou3PYunW0/GpCTkPqwGkg2TkV9gbTa87HY/Zop+Fn2hvINaXBVIKKWO3/SPzdeG
 Zj7GbBG9e+ukBTnlc3Rn8S24igLfixhoicg3aMX4VW6hol5kNjhf2WuRty5NHcmvWylU8x/xNgi
 raGE+e9V+7/e10IiKyzV5obbBidON3db3smfkUzgP3emSthfCsO3pvELI7BXmdEDSi0SyH8dJj7
 OEDdk3RA3bFuOd9Sxvv82cqvaUajMHETlhv0hYChXNJkHoqDVbfUZsXp/r1Tl4bNdX9/jJ4MLl4
 +RPaEzmt8tP0XMBkhjBF4Q1/OsrPG6khF30K9jlMUs2RiMm+ImGCbVbOJ3Se9YzPMpjy2rVByRY
 Fj6vsHZZhA9c7WvZXz6JokoJXQrD3z8OvhwVEY0Yrqe59OjdT92cRcNYYYQdTdCv/+HYl1zjg3D
 GUE2prswj1ivUQfFiQ4u6X5UdJSxn7Mh5IRC/9iaJ3Ow03OzPOJEqxzpu3hxbHfkhPwGUCBwuAv
 DFgZwDbxrbAFtDTgiSoG/AGZ8CCI4S3YdpGZM6enp9dOAORs/oRBRRxCFoq0Vf2Azr3x22jpdZI
 B2MIIY/1LxGQi6fIQ0AK/AmUySOnkAnRs4CAoF0gMtGK4Zmy
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4a18e4d6ac3mr267044135e9.26.1791922829049; 
 Tue, 13 Oct 2026 13:20:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm426025355e9.10.2026.10.13.13.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:20:28 -0700 (PDT)
Message-ID: <32a70bda-de28-416c-84d8-a56c261063dc@gmail.com>
Date: Tue, 13 Oct 2026 21:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261013141046.GA12680@lst.de>
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

On 10/13/26 15:10, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,

The nvme array out-of-bounds one is sashiko getting confused, we
check all sg chunks on alignment, and seems like sashiko ignores
it.

> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.

Should be false positives as well.

   So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix

I was going to repost, I guess Jens staged it before. I'll send
v10 anyway, should be less confusing this way.

> from Anuj, although making the combination work would of course be
> even better.

-- 
Pavel Begunkov


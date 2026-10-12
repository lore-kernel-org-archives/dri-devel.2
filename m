Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6AACA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C5110E672;
	Mon, 12 Oct 2026 20:21:54 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2D410E672
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:21:47 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-8266c388b67so1981205a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836507; x=1792441307;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
 b=H0H3LjAE3/V8TMxfIO5K1+xAS+OBIsocS5uoURntTxZFGGUC5PdkJoMULKMakI9VCm
 GIQMD/iwxOmAXr5/aPoslWH10nkirYgMeMv/FvRlZ//jUGhpi9QHQaz8zd6RbzpJ5TzR
 1dqLe73htKY3fE+QHMDNaoilgNoQKZ/FQQr9KGLUDToyxKXdfz4jUfYzL2Rsxb6XBBN6
 fxp5VFl/JHHhkKOEeZO4WUZaJYrFfCEGToN0HIJ+P298j90rXLI4TloC/fA73Mtu5ddn
 YJiucPeWDM4nihLhV2EYCdMe/Qv/Q4T/uVLdJOtCS8v5LJ6ZAIKJxTgknWkf9zgs21ux
 LgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836507; x=1792441307;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
 b=1aqv2Cuy54w9ERrEiE8oybaliZB4tv0L1ZX2IFxaUddSR2tQHR9wl5+rAiLN2ancro
 Ugw2cyIUQgbDHs+gfVDLOI2Zf6aS53IwFp6+N8E2BZn5lx23xE81W/Lk3HBHCJevnV4e
 NwyFqubtFdpJxHdfWAhbFzQT38qtHidyS8Hb7OF7kLOV5aTagj1CUYLP7bEFGXmmYrOL
 05j6INBFkjQouAdX+Wp2ateSi19METBwPB8VOg5JOYctlYfI/1BvNnqmIXQyi5f7Uq56
 nY5RFX42jBeKZ8+T6mYqng57a1e9aZXXX2Z+0K8YK5C+j9DK9bJbA6qvaEi3BwAxdZ5b
 Cddw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQSzMGMayT4HaJx7/Q7mWyugQ9fmiuinPe/dBDCZ02M2FMW67ODDO/GgtBWJv0E3/rbYl7C0jNMLo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJCEpFcx2KI9GHYiT87lLEYCVjhBmLHdGeY+KPgS8hzBLd3vPvD
 z3GwB757y75BlDaYNwkYhuCVyueOkrAKhGaWi5UodkAsQns9/MLffcADH2iqNOP8exc=
X-Gm-Gg: AYBFou39yaHUXDSLmCFWx6z0F/wNLUHmmk03VYl52V/NzSNetKkQtfd+8HU20yHMDtp
 3eZm0V3iIySGpTqC8j1De17+B/j9I5CxQDOmwBv2ufeu8EwmnRVYRQ78RaBmXHeuO5h2AAEJV3z
 6QDuuVBuYbP8gGh40Kui6a07SsQtBlG5IB1wqL7hWq2b3FVyeiDEKcbOOjRouvI1IoPcRPhqVpn
 rQMlLPtddjchz6cTtMKmx1ISnIHbz4TM5c5iu6vTx9GPMDDC6wg+JdXfGTO8OModzKRrpP0oEwy
 B15IZiQYKaAFD1KnvpS7ThwpCqSdKhG3w3JgB+ijpd2RsKLwFjONRCjSc1XRz+52wy0RNUp5ViX
 IePZcmUUsBqFFHzlYdFyZtJauLriSLW6VwnXH7ntZ1BV3wDiRB4ysSRXKLNI346MiZ5dWmKlC2V
 OCM5AN1G7W5R/C5qvYJKwoWNTqsgCTej5r93eja0xc8/1NvN+Md2cHr6NqI1Sy7MI83aP9J0HZl
 mF9+15IcU1+4+9/i/VAGqNS6JkJqROtI+UfnWf1zbwdBHdyGOVtYTQWNg==
X-Received: by 2002:a05:6808:f88:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-50c40a3e034mr9500602b6e.9.1791836506735; 
 Mon, 12 Oct 2026 13:21:46 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c167544b5sm12396143b6e.3.2026.10.12.13.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 13:21:45 -0700 (PDT)
Message-ID: <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
Date: Mon, 12 Oct 2026 14:21:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
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

On 10/6/26 7:42 PM, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to glue it together, count requests, manage
> lifetime and implement invalidation.

I've queued this series up for some testing, in a separate branch. JFYI.

-- 
Jens Axboe

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1083EC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F30210E437;
	Tue, 22 Sep 2026 13:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sfU4IZyv";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B2610E437
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:37:17 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f56039dso546918566b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790084236; x=1790689036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=;
 b=sfU4IZyvnauKOFssQN+MCKsag/LFUXhcjlBTCldxE2odJK3rtWjEBbvs9hr7JdH7Mo
 AhAXc7kZbEUVZBzfiu7GSI6HEfi67bINtOQwTm2jZ0kvtd8IxgnB3IAiqHKHoScYF0om
 gYu75pvvi8YUvngetPqsT0t/T3EannKA/e+QD4C1pBzy5hj/zik3C5aB6PUOYUPawOrD
 6POgVclEdCtYHnmtc70G3a1VJSGdOpja62D0NFkXL/pQQo/C7o/N2imHYKfHIQnJxQ5O
 /usmkW0eApcNJau8Wkt5AySm2yeIeN4KQEaqUY0t5ZXXl7orpuTup4XOs/UeTFhPW7nu
 hlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084236; x=1790689036;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=;
 b=yZHOcrBHtTW2Fp2+LvnDT4FKxRRl7f4sW7hpQPIUfX2cU6IUe/w0lPkd56/X5+sNyz
 ihQ+zGGD4SFoHdoxQ0EsV2jY/Ar1Wtdi/XElUIk1Zjlk5RYvZ3NEDhFeP8htDFiCgmrs
 4Pw5KvIWzlKbW/sRGtfluc/5w+heu9XyfQhu2h/BNhNKNT3AW8jM4eBFVAPXAlN55tXj
 hlxuvoZ5ZL3vD+Bk+tuHJkvST4BO5Ubnc0s/FH5bu8SZKniGw9Gd5nH2oBZLadQUS+BX
 i7TFIWDuxgwbfC4+wQwRCi3hrvfzPJzH2xiTlEMcD1eicIm2SmwI9j3E+nH7tVSYGUrp
 gK2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqhuQKup2Hquega7yLdxS441uctHsZ6LIfNO1+dg66VP5gDD7zUjnNWESc155OZi+E6ZuZoSlaAlQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n22fv8/jJTYrvOTnQS3yq6NIJShrQ1C/43399OOEDNDVZ7MsON
 dyQjBbn6jiikPdtt5vxeb5iWHbOXR7/DbnfUAeUPC95X7NSn1cFzsZEg
X-Gm-Gg: AYBFou2x2p2zkVCP4ShPFAYbzdlNjxBHiIf0VWW/ygyj74e9iCOk6k+xD0nIwGW2UqP
 vnQIRFGQmOBgHb9psnpZukVBiOxmFAgqIKotfzaEE/bedOlBQKsMgdx6+++KQKIQG5BYpaUNLww
 +uFlD7wYyUQF3c1RJVSIo8WwxKN+HKqTcA8/6ioCU8xKd+WcZNrtUCLJr1VL2SqXDIBJ01MXEPV
 8DInwXZlwjJ6DCkNizdvGMJfq3SBLByBldsoFN536G2FKswOAFp9o33nYRex43H1joVz1cTMtPw
 Yw+AQQ6+yy3cPRil+gf/Lu7mnVk6gtHvIIySjES1Ji0k/9f6fShzX/CEw155m0W5aQhA9m3VcKY
 Eh6VVyph7th3Lv7BRVAVOtEorZkqAsUWKJ0gvixirXLlT7E/J9IBENrhpgAxOyHum+JnYoxBrOg
 9UVh9t2LQ+y/6vnlgLG3RHER+ZIXlmihvS9h0kzbDAcWuOLLuPRMjJP87Fp2lz7AtwB2yq21ycw
 MoIoRiW8hLsSqMo7xx/9NsMkt5tK411o/76FoCxreknRFXW4D/c1EuzT3ZV7nyrBIH5sYzHtHDe
 yg9Im3Wbvqkjql45xYWMXyKcWqgW
X-Received: by 2002:a17:907:6d18:b0:c29:448b:f5d0 with SMTP id
 a640c23a62f3a-c2a15b86ed4mr1180156066b.33.1790084235477; 
 Tue, 22 Sep 2026 06:37:15 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-196.dab.02.net. [82.132.213.196])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aa9b14925sm14081966b.19.2026.09.22.06.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 06:37:14 -0700 (PDT)
Message-ID: <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
Date: Tue, 22 Sep 2026 14:37:08 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922132016.GA30684@lst.de>
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

Hi Christoph,

On 9/22/26 14:20, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 02:38:50PM +0100, Pavel Begunkov wrote:
>> Enable BIO_DMABUF_MAP backed requests. On registration we map the
> 
> This is now REQ_DMABUF.

Will change

> Sashiko had a few comments, which I think are correct - if we use
> dma_map_sg to map the data, we need to use the sync_sg APIs to
> transfer ownership.  That only matters on non-coherent architectures
> with MMU, but we need to get it right.

I've seen that and fixed everything locally that should be fixed,
apart from the sync. I wonder what we can do about that? I can
somehow replace it with the sg variant for now, but sync'ing the
entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
not wise. And I can think of another place that does mix sync_single
with sgs.

> And the reset deadlock also looks plausible.
-- 
Pavel Begunkov


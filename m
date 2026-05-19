Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08510CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DF610E3AC;
	Tue, 19 May 2026 09:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U8yrWKUV";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8B510E3AC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:21:52 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so36429185e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779182511; x=1779787311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=;
 b=U8yrWKUV8fn2CfSIL8DJn6dL7TQjwQ8vlkxdjF5beVcnfIXJDZUTc2la2PWPqM/2rm
 ymNd0fIHyCwi/qu/VLRYaAV94eaPCeSDWlZ5S7JhSa0N4QaGENXZ6Ltjb/ov3JV5Xw8N
 AVlPArOa15zrDG0ltH73YgXF8L/QfUH5dnt8zc363tBHlmpZ9mH8ZkSK3rZYMxFNas/w
 f4V/3LCQROsrnoGr1pPPcBrJt18oCNZ9rT6zN/eOsipqXRfF/YkgdCniFx/fwyoxK5mn
 iB/KmBkTyF3ekBu0olOHVEXlZDHUqDl0LFIs2aVxpwlrVi+8zXqAd9/wHbxnsg3nx/cE
 YYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779182511; x=1779787311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QoHvwM4p61ukSgPZjfDBcRJdrzaBcrrvLVu02xCIKiI=;
 b=AgFwQr5r0peUrh8u9HvLBst28OoS+/qbWZm9Yot4YMPDgq4y3fPJ/utsjdmeP6Y8dL
 TX2W42Xv8M/gGGO4IHGonJ0oynxN2r4FlslXM1eJEE5TOpEUhUz/xMfcH6gM2wFF6gsZ
 lN4zbX+iw9dbG2rJ9kqUC5FMULD6wiUE2/gKfuEX2UwzLbxpMjl6wvajO4BeakuwDdmz
 ilxPQMqqffRreGhOBbdOi9Yfmn3DVrM9AxRzB/K5m3nfg3xz+vqC+yee8giv/ZLj8auv
 dWFswgQI6Z8m9/e7x17228YHr+bGx5TIYDJDuXh5vR6cbBKWsczh+ZrPX1xbhZJdJeDE
 x82Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QzEXiXAVLreAycorjLFU2R9nQ4Wle6Pm1XXntRjToRPUSxaa6xncqY4fxO2AJvUdelKR6WdR6TzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyugKJdS260IoGXAvdIpOd4aYZysV7KGs43qCWTc54R3sCv9SpF
 +1InbZxiIzwITtc70u05FgEHdETetYbGzJNk07iyTbsx61cvzHOLslJq
X-Gm-Gg: Acq92OHaP1D2V/uu2ZU+U2PZxf1xV3YibUSCuX8sk2SKLM92rijwyEPULCy1VdUNHhY
 QQle9XcOlEqnZ0VnAKUpkmtcbkUDoAMgjp1vmK9vEurm1FPg0TTTPy/jnU1FFAv2bEunx4vTrks
 C50WZy8CxMUCuFDpPHRcPh0/6tceC+74wqeuKv6FGFUHM4jI6z5ql8Zqgh3nhzL2/gnOHJRwN2R
 UV1pXcV+3JvQl/cD+MZAI1Opwl3XO1aMndVL6I2TDEhvbqg507X7e0aYYEVKJnv9BfFS5EpkVhU
 vUKDLlET2XORDSrz6bn7n281Agk5LTqX7C5G6/qdCh4RWrZ7xSoywtJREkNZlhVShqIVcOIwDjb
 Y7Bitbu5038sZo0zy1aUWcHZLf8+okXH2rOqIqg4ekt0lcseevoE94z4/JAeCdO2CnjHWPckFjS
 JctTn2GxrqI/8tQDtgqP5qaOtIsUWh7UnoW0zAbX7nRp6qIPmcGcwctQYk1rQ7uQJu8xavOGaut
 +U=
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fe6328bb7mr321111245e9.21.1779182510799; 
 Tue, 19 May 2026 02:21:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab2a23dsm102576065e9.5.2026.05.19.02.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 02:21:50 -0700 (PDT)
Date: Tue, 19 May 2026 10:21:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260519102148.21d42afc@pumpkin>
In-Reply-To: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 18 May 2026 11:29:54 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 5/13/26 09:19, Christoph Hellwig wrote:
> >> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> >> +		bio->bi_io_vec = bio_src->bi_io_vec;
> >> +	} else {
> >> +		bio->dmabuf_map = bio_src->dmabuf_map;
> >> +		bio_set_flag(bio, BIO_DMABUF_MAP);
> >> +	}  
> > 
> > This is backwards, please avoid pointless negations:  
> 
> I can flip it, but compilers tend to prefer the true branch. E.g. this
> 
> if (cond) A; else B;
> C;
> 
> can get compiled into:
> 
> jmpcc cond B
> A: ...
> C:
> return;
> B: ...
> jmp C;

I'm pretty sure gcc completely ignores the order.
Some very old compilers didn't - to the extreme of generating a short
conditional branch around a long unconditional branch to get past a
large 'true' code block.

likely() and unlikely() can change things, they are definitely useful
comments to a human (or Human) reader.

I'm not sure you can rely on the branch predictor to do anything sensible
outside of a loop.

-- David

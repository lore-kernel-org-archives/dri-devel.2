Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495A8CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A5E10EA05;
	Tue, 23 Jun 2026 08:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZK9gVy7";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC5210EA05
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:44:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso54899895e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782204289; x=1782809089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd5zggzn9YY/eKp5MGwYc/7RumCc5LCFsD9dus6MWn0=;
 b=hZK9gVy7dOMkuBhuvxextWjncYEoK2gKMJTExqg6tzFioDaUW72vnRXqZOZzbe0Aui
 /PskyZLnE8CZH5U2WWUIrj6M0lRuqOOK3FTON4Kj/5yvIezzArRP+v+Aw/AdEXhB1H3l
 uZuLtUa/CwbvtbQjGpVgEqe0a+mw29rx/5WqKbAn+bT3NFDSrvmAd0D3ZTEhoBrGzcfT
 BS+dqmFLi6neZAZwyUpwgQFN7l/Zs5u6dTQEFTUkY1gpp6+/r7nVAgLyP7o0Z99MppaH
 271gsIVuy/lNWvn2x7L/UzgzU6Q1bGmpp/A7pHFx1E446hWYHC6NK7AiA29bTPkLtcSw
 L40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204289; x=1782809089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cd5zggzn9YY/eKp5MGwYc/7RumCc5LCFsD9dus6MWn0=;
 b=GiL0GvMfd03RGAM3PwoEAZSW/arMhPuiuNRLWcVyWT50WyJBvj/SAvE0wQt1pWr8i7
 dZu5zy4EnzrxYa/+YKxRrqH4cYvn2Rbn+SExqv1Q81e2TatRRSeja8FX0wz1E4BgtVdL
 J4ph8PiXsZ6+PascKN+/1WfruA2VX5a2nqadFdIFC0F0fQHyeaCiwAjyKFe3p8p8yUh6
 1gMDdShXDtKse/QBX32qtAsPEKT/deTNMr7SjWe2w9WWCDZTgxn7LUoIRHhDOk6a7HCu
 xsqnuMDGcRAjAYaYjM3+OfPTvxxGtkdS5mAa5dIMUhh9lDp9vP//U0qxD/wiyGVvqL6E
 4YUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ86PEIrmoPG9y4N+8l/rMjPOwL9LEa0YAatPearnvW7GvDF4a1G3lEmTWSXSBfo9c9MXUq8jauO+38=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuHLM68ArsfmVsV7MlaISRbjohYI0f1zwUftWaQlGK48IaXoPY
 x/KVsE7zaHN86i6A9/+6RUpzIJmIsR2MNJQJW5PdP61qkms5YQgjYd6C
X-Gm-Gg: AfdE7cluu8zGURVs41n8IrAEtRx7tsvvaqLVo5wA24eElFrEqSjoytMLj3qRPdoHDki
 TV0LH5oJrHQ+1HzoAT/NaQ73bQBP7NQDXPf57ksatU6ZtB9/RvcowDXuMsMzxkiogVUd8z2yQWt
 bxRCE+lh91sZed9dLnZwFuNgHB71/xN41NjuZFHegt/vHdqj/iZz7ptJHvkokJsA6QTcbQoIyky
 uRW1AOUUQrJWt6W1UtBjiQr2L6mPHPlGYFT4uIkiOMCmwcX/VLbJC/FF7CLBf0o7CizCgd1ot1H
 H34+B20k9gpQ0Y92nfD7g2fRvyJRa/fmapnW/eyTigD1XVLXmhHr8WZXzEZZQVymQzXCVp8Du/4
 G1iQ+bavq8wQ/h6rm02vPe0O5oxDc9WKnOBTXW4iHVE5aaT3Fk9+RSip1Q/IxxFzXYjrYRBiFEA
 D28iOBBinr2RstbaXSXjde5/fDL658COISYMRJ6U1NlUztMd56mw==
X-Received: by 2002:a05:600d:640f:20b0:492:408b:d267 with SMTP id
 5b1f17b1804b1-4925b394574mr18459465e9.13.1782204289054; 
 Tue, 23 Jun 2026 01:44:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923392dsm530639635e9.2.2026.06.23.01.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 01:44:48 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:44:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, chriscli@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260623094446.4a8fc2ed@pumpkin>
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
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

On Tue, 23 Jun 2026 01:54:59 +0000
David Hu <xuehaohu@google.com> wrote:

> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

There is a separate issue of whether this code is even needed at all.
Where can transfers over 2G (never mind 4G) actually come from.

The read, write and similar system calls limit transfers to INT_MAX
(even on 64bit) and a lot of driver code will need fixing it longer
lengths are allowed though.
io_uring better enforce the same limits.
So the transfers can come directly from userspace.

Not only that but you also need a single physically contiguous buffer.
Good luck allocating that!

Now maybe there are some peer-to-peer places where the large buffer
is device memory, but they will be unusual and probably need
special treatment anyway.

	David

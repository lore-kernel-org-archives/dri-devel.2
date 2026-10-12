Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC5CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA7610E4B7;
	Mon, 12 Oct 2026 18:51:43 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB1C10E4B7
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:51:37 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso19341975e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791831095; x=1792435895; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ky+Mh+cO5xMBG7Bn/5pO6nl62hMlLNRWkoqZnT1lz8o=;
 b=P5Mt4Md+karwRxbl7Z8sYS/Qa5RpSDgDpL56IDRuJWFEcRnpJF9bXg+IE2xu4aiQ74
 1gY7XnAe0s0+dZtQtFvGwv/EmovYzUjAPP8UlqtyIf3fmS9Ouk8EPF5W8vROJ1zDukoh
 Z2RmjQwGL0ws1PXAEnI6hR33vyn5VFwtaVFnTXhdEzy5QJO6XmK7mY6gbSPF0XkQSyC5
 ASmsglj2HLu6nzOZ/E6CRo5mSILsVttevgSl6jWcZxOf6wCyX+fGonSDThqbLJyNAhWN
 x0WIPH+mxyUFMYeJNCNBuyi0ng7twEbjHcIqmttOoOFyTQgNrPOpvoj/KOveJd3Heg/R
 qOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791831095; x=1792435895;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ky+Mh+cO5xMBG7Bn/5pO6nl62hMlLNRWkoqZnT1lz8o=;
 b=RNLhRHitc73JQp5Xod6Vyp8HjLk7DxCxSlFlFXHrYTylDHL9DX3LzzBiNqjE2DtsB7
 bKANvc1Be7J2qE6fFCXB/IQnR+lJQhzXvzhk3x4IJPSJkvMPDx32vPoc2O0WdP6xVSx8
 JWQos0rvW/tbwzuwK3AIbjpleR3eYyWMI3WUo5z5Lo4i/Jv6mQt/gZIjFG+nH2zPzmsB
 0mLLJ1xbReVPkR+0DsQ33/954co5lkxHU+bUfqeCJBpptr3Wmo2AV4D0vuJZVrYv+0gc
 h6x1tHJhS5w1J2JepZO7yU2nHc20aKObHv9YdI3h0vpb7aS/fZX9hxGGtpklS/UelA1I
 7QQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlye6vdfDSCpVnOu6lJAerKzumSu1LXZv6fPbmJQYQ3ds9UZ4skzC0JE19m0ZibIOQhEDgtro8dTo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIutAEMB7/zOG0dxM1oTeB5BP1GnoDBZZHlnkemjXCJ1sfjZI31
 w+SjpwPK0+SI9yt7e5N3JZy++SFD1r3m8kdTwRYEnKy5i/Q+ZBlRfSIp
X-Gm-Gg: AYBFou2RCUle6+lzo5lVxs5sopACMHa5XffIIOT/uftXmAr88t0r3+2dxixdA47tNtN
 rfGetNMSL2OfajUOm1fb8oDhfUw+dIuTH6pKh31uHI4MO59L8p6yUnAxXPxxYFApzvsLHMn97T5
 0mgHSxBwLLu86WHGMNGMz1w7FE46G3i3cRf0zN0W8cCnETz4aV7Eq8+ZKc25DEueE7gKzvXWTKY
 6Mu59RmfuW9rqv4y9NS99V4sTindQm46E7c/sdK6EUhbQw+lmO0+6Gck3hKuxeQcCCEcC8tS9pr
 PqyKpD+M9ZcRXdreBCJ6yEg65sY3meudhXsSZpqjCBY+vRPzp0BdbYxPLbcYPpJrpQpLOcWR6wc
 xZc/5ukfBrFx2qFsSAAu+W5aGCrgZrzxu56thPL5euuuoMJXb6lAzcJEG9kn3vhw/IbIYzpgPd+
 XggQnHS+txoWPwAI3DW9mm/60KRl7njsivqAw/KeRujigd9wZi9v2CBf2JOVRO/XAf50XdkUMxr
 ks8GteIJqFJL5ZN+zKdwXrrYaEJyF4S+7fb2lO67GDsyvQagl0n4PUY24mhZ/UcCbElUlkS/fCF
 B9zqAq0iMBWfeLea31B/KeSp5ytFOEJvFZgkOEy/+e6dRor1b8SUZgtuFo7v/SXyKrOYjIhlxoi
 QwWfNUIk=
X-Received: by 2002:a05:600c:6297:b0:4a0:62d:4424 with SMTP id
 5b1f17b1804b1-4a18e4a1756mr196491005e9.8.1791831095315; 
 Mon, 12 Oct 2026 11:51:35 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-a8ab-0f01-016a-c770-797f-eaee.310.pool.telefonica.de.
 [2a02:3100:a8ab:f01:16a:c770:797f:eaee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bb68abfsm336946215e9.0.2026.10.12.11.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:51:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 20:51:33 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <rob.clark@oss.qualcomm.com>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [RFC PATCH 0/3] dma-buf: warn-only mode for DMABUF_DEBUG
Message-ID: <as0r7Q4dHt9gQm_8@gmail.com>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <d1ef135e-1b5d-4656-9229-348c7029efbb@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ef135e-1b5d-4656-9229-348c7029efbb@leemhuis.info>
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

On Mon, Oct 12, 2026 at 10:12:02AM +0100, Thorsten Leemhuis wrote:
> 
> What's the status here given that 7.3 will likely be released in a few
> days? Note, I can see from the discussion that this is a complex problem
> that can't be quickly solved. That's how it is sometimes. But I wonder
> if the current state of things is the best compromise for now or if
> Rob's revert or some other option would be better.
> 

I think reverting my commit 143755bdabaa ("dma-buf: Make DMABUF_DEBUG
default to y on DEBUG_KERNEL kernels") is the best interim solution for
v7.3.

Christian, Sumit, could one of you apply Jianfeng's revert before the
final release?

https://lore.kernel.org/r/20260926022026.10539-1-liujianfeng1994@gmail.com/

Thanks,
Karl

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F57C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A777310F1F2;
	Thu, 16 Jul 2026 08:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBaqPSt5";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BE910E168
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 09:33:28 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-455ca262ccbso2129547fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784108008; x=1784712808; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qpKE0Ztd8LwTs3URtxw/L1Mr92CYYHr0Elkx6ZybgOo=;
 b=QBaqPSt5q23JSyeY32Ko5Ev/0XqLoSGUwR1KoNQBGUseHNUfvvP+sLrd1M1E0l225r
 VTdRwKALGIOpfyzkgLv+ZZCSXlqrAPvO9WcnsxAcutWd0HuMjeMdJLBZ7VUgaacuLHtN
 lq2yHo5PaLy1izhSMhTfblEwc+/B1cPA6TxRd87qlpPLfUKvBkEIYufENgcGy870kblu
 ZKvbsDk9IASyOJRdZ6LxIJRlEPJNsYjHdorRBtULYSaF8djMwwmO6zzyYuSG/pgnsfw9
 9byIBGxA/iOUBZZhYwOXrAoE9eBCLV6bdumwenAydAEM+utUxeNyU0ReBecAqarIdLWI
 nBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784108008; x=1784712808;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpKE0Ztd8LwTs3URtxw/L1Mr92CYYHr0Elkx6ZybgOo=;
 b=dlEaIXSqCz8LUNjsDYX+aruCoiMUQMOdPIm6sknP7ERCDwehwUFp/+K7se7WIsFURD
 7dPxdCGsTon0UVSbAFn+kbdGBYAtNX2/AscNxxjmU3K/ra7NZMzG8zRlar9wqO/OV7bF
 oLUTDlyLyttL6vDQ399+mbPqxKyo4ADTHlMIW1/Sv3xl8fnyyHoqWViXAmAKerfFpbhh
 CaDebtmryo6tEp9TP8n5tUTE4kVSAAVYD95IeyCujJUtuakp3aBIz6oFUgJ2v6wt2Qyy
 5cYwJrCw5iXdogxIdluOnzIQJXAengzVGovOt/PCog6FpuxBqZBCgz6ebVVZ/p8QuCK2
 lv6Q==
X-Gm-Message-State: AOJu0YwMEG7gtctSzVzPAaimmUUL+fESzCZJUWXdPd8x9anBYK45VMor
 fcybh+DVo3hrlp6guQrb5J8iikKmVY3xYRRAFZnIX6adOw0XHvZH0fuB
X-Gm-Gg: AfdE7cnMQZMnFC2XalMPqN6+D8ZrFccu9KHIUamLkkKp8rvjvL9zAu/nHA4expZmfkM
 4UMmWZ46hFFh/UcrG4PO2Mq2UpKVbM6UmS7O/xJMuVwna6ZEUBxLJAIYvTw4NRbwoA0zLWjqXeF
 S2Y7BVifjsBml11sBx1ITNNQwb6OT65pBxylFmO/Wx9YWGu+NZZDJvkV8Qo3UahIRTwot9xo1oT
 h+w1oOJvea/CcPyKctGMhyt3uHnSpUKJJw/chgZtSDKBHUKZWQNfZnr3/dVeYl7rrojmprXgFtP
 nsfOn47axO0jQ/L/wgDVMHkHT2GgljcZRI4kx4i9pUplbnIIJoEoEgcfSq3h5kIj+YAtfyhmIe0
 2pqU3usQ/RUgW4p0AlFIW0ExFDk/bc+VnAK2peyhDo6TW8vyaWda8c58tZdhdZnz4EjNHgxj4Zo
 3VltNJsB60NdQ/WracEgXwbymJJR05sedtOQLjwu+6YkM=
X-Received: by 2002:a05:6870:d32b:b0:448:6ba8:be6f with SMTP id
 586e51a60fabf-4562b4c48f0mr1353839fac.19.1784108007743; 
 Wed, 15 Jul 2026 02:33:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:6::])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-455ad91df9esm9770592fac.9.2026.07.15.02.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 02:33:27 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:33:24 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <aldT5PnKUFHTlCkg@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260710072712.0F50B1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710072712.0F50B1F000E9@smtp.kernel.org>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

On Fri, Jul 10, 2026 at 07:27:11AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unhandled Python exception in selftests when hugepages are disabled or sysctl is read-only.
> --
> 
> --- Patch [3]: [PATCH net-next v5 3/3] selftests/net: devmem.py: add check_rx_large_niov ---
> commit c6680f91b9c04fa78f7d8b9d5f92ce1bee9816c1
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> selftests/net: devmem.py: add check_rx_large_niov
> 
> This commit adds a new devmem test case for binding a dmabuf with a 16K
> rx-buf-size. It also sweeps various RX payload sizes across the niov boundary
> to exercise the sub-niov, exact-niov, and multi-niov RX paths.
> 
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> > --- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> 
> [ ... ]
> 
> > +def run_rx_large_niov(cfg):
> > +    """Run the devmem RX test with a large niov (rx-buf-size > PAGE_SIZE).
> > +
> > +    Sweep payload sizes that straddle the niov boundary: below, equal to,
> > +    and above rx_buf_size, to exercise sub-niov, exact-niov, and multi-niov
> > +    RX paths.
> > +    """
> > +    hp_file = "/proc/sys/vm/nr_hugepages"
> > +    with open(hp_file, 'r+', encoding='utf-8') as f:
> 
> [Severity: Medium]
> Will this crash with an unhandled exception on systems without hugepages
> enabled or when run without write permissions to /proc/sys?
> 
> If the system was compiled without CONFIG_HUGETLB_PAGE=y, opening this file
> will throw a FileNotFoundError, causing the kselftest framework to report a
> test failure rather than gracefully skipping. 
> 
> Could this be wrapped in a try/except block to catch these exceptions and
> raise KsftSkipEx instead?

Do we usually defend against kernels not using the config (in this case,
selftests/drivers/net/hw/config)? Maybe should be a skip? We do already
use this pattern in iou-zcrx.py and nk_qlease.py.

Best,
Bobby

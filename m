Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49591CDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA94710E210;
	Thu, 25 Jun 2026 12:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiimZTk7";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8606010E210
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:00:58 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-44793168d3bso1645677fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782388857; x=1782993657; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cxsefe/wUailqJDNAQGtmAmRQTu3ij9uN6odmHme2Dc=;
 b=UiimZTk7RZxX/g4dxDF73K7FAQVU+vQIbntIOO5tUEbPFhvxwisiOaPauduq4VT/Dw
 8BMsOU5yAxj81cJDfdCVB9IP0CfaCoNSonM6zh4Ixw+MCPsCXVhX6Qxt3Oe/mdq3Ru5U
 3SMNqyCDAa4stvlOraCySRZ3KN1irmmIvFjtpITCyy52MM76tSTbVyzE1mi0upd5duGs
 qmTfAG5vsdcVJGe4pRp8ElPEl5ZVUrfsAA5RVm/TA1fONQlDRGkTeUkaDZLapbapb1a0
 q9s022rPM9+okc0uJl+BxhR/GxJ1qD/ncaO+smHAjCnVwy8F8ObTx6gnnS/nCUhCim+P
 fiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782388857; x=1782993657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxsefe/wUailqJDNAQGtmAmRQTu3ij9uN6odmHme2Dc=;
 b=eDGMpHvzWvFz2WOW2HJYpkB0iDPUAZqfIaYEoCu/tLXrje9btuKNcKxa1ZNBZdnTuW
 3MarFuVOTwTqyfXAVzBV+weVdlRYlQFjGrLf66nzlC/1s93p2xza5ye/BoXr78udJfTd
 4RacxjQ0cZ4H+Y+edeCIhnbn+YFTtGKWLuuVMd9OomWKcq6lpwkqq1jfDduTErOUqMdV
 ZPBjZP/P6vMl42RVDa+C2s8sO68UrFnuywZ5cMiJQCT/Q92X6V9Ns5ae3BocIqTBAPI6
 6McJ6q/HNOYgoICwH3RUrVml/hi0nx16ePdb0ztokZX4iNzl77KXPYkTUHtpYkVQxPyw
 f4zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hnVQp7nolNODFr2j0tjlekMWNzT+XQbzsWHNjgD1Rn0k8NL5Bs8eJ3LRTsNJ5pLOhwvKprxwWkHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXe1X1b3BRPReRfQkyB1K4tJB3EwZo7wThgTlNen9qHe33VIwo
 qG1dx2U1P1GLgj+KLBk2JbpWCEQsvRBeYUbUVUZFIBOWOxIV+mX/3A2o
X-Gm-Gg: AfdE7cn3z1HjmPHfOEHErpwmEmK8mFnEr9LkJoepooEVpuvY5qXxYw4/l60HG+Bztdc
 dBN+980aOHKQFXKqlpbC3BGaJbUQIgwmHPs5IFJxg3brYWeTIm6avNkw6qxtXHAPxo+To+Qn5JG
 8Ml1iOAcAuGXAyNp1cIwyO4xnFXmT70iKm2vyPL+jUil5ANauTjAyhg2dOkq6w50yadkIvay57V
 KXUen7o6+OhKKY5r82w//XXN0aroDgkkN/H+ThcMd/TrN94nlB30YYy5wo5Q1+z06um9m1iDYzc
 +51R+Y3l3W2BHmOicfhxGRSD3W06pZMldmmWdJT4vgdKZgYq2RuEjuvbE32yoMFfqheJYNCNG4v
 8LcY7lQ827Ewhh/zfqhhZLJIOdTOnf9nyBp4SPto7tXzM0VPCPa+LR+x59HfmhXSnd0n8jNvvYa
 4np/ld
X-Received: by 2002:a05:6820:82c:b0:6a0:e2d3:8659 with SMTP id
 006d021491bc7-6a1351969f5mr1724499eaf.15.1782388857443; 
 Thu, 25 Jun 2026 05:00:57 -0700 (PDT)
Received: from localhost ([74.80.182.98]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472e79af8fsm11115403fac.0.2026.06.25.05.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:00:54 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:00:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and txbuf safety
 issues
Message-ID: <aj0YbygQwhlga4Om@stanley.mountain>
References: <20260625111602.438761F000E9@smtp.kernel.org>
 <20260625114215.325973-1-suryasaimadhu369@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625114215.325973-1-suryasaimadhu369@gmail.com>
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

On Thu, Jun 25, 2026 at 07:42:15PM +0800, suryasaimadhu wrote:
> This patch addresses several pre-existing issues in the fbtft driver:
> 
> 1. define_fbtft_write_reg(): when par->startbyte is set, buf is
>    advanced by one byte creating a misaligned pointer for 16-bit types.
>    Use put_unaligned() for register writes and fix the SPI transfer
>    size from len * (sizeof(data_type) + offset) to
>    len * sizeof(data_type) + offset.
> 
> 2. fbtft_write_vmem16_bus8() and fb_ra8875 write_vmem16_bus8(): same
>    unaligned 16-bit stores when txbuf is byte-offset for a start
>    prefix. Use put_unaligned() for pixel data copies.
> 
> 3. tx_array_size underflow: both vmem helpers subtract 2 from
>    tx_array_size when a startbyte prefix is used. A small txbuflen
>    device property causes unsigned underflow and out-of-bounds heap
>    writes. Fall back to the non-buffered write path when the buffer
>    is too small.
> 
> 4. fb_ra8875 write_vmem16_bus8(): missing NULL check for
>    par->txbuf.buf, which remains NULL on big-endian when txbuflen is
>    0 because the PAGE_SIZE fallback is little-endian only. Fall back
>    to direct write when the buffer is missing.
> 
> Also replace empty modifier arguments in define_fbtft_write_reg() with
> a no-op macro to fix checkpatch warnings.
> 
> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>

Is this how you would sign a legal document?

This patch does too many things at once.  Split it up.  Also please
a delay between sending us patches.  Otherwise it's overwhelming to
deal with.  Bunch them together in a patchset instead of sending them
one by one.

regards,
dan carpenter


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97294CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F183F10E71A;
	Mon, 18 May 2026 08:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EY1mnc9D";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A578C10E71A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:39:31 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso1058175f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779093570; x=1779698370; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uFA4mzL4/eCvcVikR8txf+gyD7FhtLXC1uhqrGNm/08=;
 b=EY1mnc9DpN4XHrkFy41Sbw57IfmK2AUnZF3ghF1RM03gTqF7sX/Pd8uM3xTsCWOCTY
 QbpdSSBLYqW2sxqhwrI7JGaE0Pkckg0kC2bkxFisL4QtEsskFYcMA7QPrLP0fQsYk2ai
 bwDZCGelXszTtRhSn7aGtQiZQu0bp2IN5/iiAAArefBhE30GigF29qYMCcpd94JI5xOR
 WqnhJNsbauBb0DDmwS1OtedSf2njlCCpYMgQV0VOLVnzkRqYg1oROmracVzZvaDfQl9C
 7SwLFFITLtvqIkLErlP04gq6mOJTeEspWUOYf44GFNZl26amWVTRxaMlDQk1xNXNPgdE
 MhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779093570; x=1779698370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFA4mzL4/eCvcVikR8txf+gyD7FhtLXC1uhqrGNm/08=;
 b=HqMSzJd7LpSbrDnzq4PDYRN0loNUioAmdS1DbEPQepNLqBRLlN3/D0t3HjqY52gHMe
 NXXqCKRbY6GAs2LQtKFb56iLEE+XiHURcoI8NMdEkGeEemT0P1ec1MZYrTayV9vE6+a8
 kFOahfuhWMhZPBfqhCj16WjSHSCAO/nU0HZRy4vVTDUvd0/OXNu3Xmue0wniBWwgwS8Q
 nIFSyorisaupT6ALGSdF+kjl4LiDSnSLnonPQEOQhEFaf4JNEqEC3k2O8/iU6PsL46Qv
 NICxFZ4mgeLCuJFsAepSLMIpef/y+YakIojEmrJXmHI6Me6SJTH6ELY+meCsapW5MmHP
 Ph8A==
X-Gm-Message-State: AOJu0YyOoMuilE3Ks19L5YkBuvINc3KBJ8qY1D+wsDz7m+2gJJRVQHns
 qTT5hqSlj2txS3hzZOjkdkuiF+AXI6+XLWFxnM3Nu9f/WgTYtes7oHV7d+xxRg==
X-Gm-Gg: Acq92OHK11QDjRklXQOJ4+PbFywY7Qs5D2pB7pSb47H3JRaVQ8NYlo1Ja092/mHx7Ws
 YHLmZK4OZYDfDSU5uq5snFkIwI92HdqdZdB4lZiLICwV5IEXDaxRarRQzrfLtVogpf4fHtDvMzp
 MlvVifJrckOkDZQ4+kfjNfK1Zq/VzNWPat7kJBjjjYKfkggO8aAaCTn8+iXysuWHWXejbZjFLPb
 ZmroN23zwe+pfVnjCl1gKQl3H5CaxHGu3um5W+iLKH7GZGybcHvZm0fX0zscNcYVbJUOsdurFfA
 fVZX5uM4YdyWgvj0lEb5OlfP0T5XBLujN/C7Xh+z4FRSORQ+H3NqY0fUoEgsqbEmVF07KbVRNKO
 rDKVSFVuN3ycmGo9CDINB60V76tcaDS6TcTlbsQRO9IT/AZYyqcWygjFpSKWReVvB5AFbkPJaDZ
 ud7TohpeCaSS8e1dHAv3I=
X-Received: by 2002:a5d:4fd2:0:b0:44b:ad5a:cd33 with SMTP id
 ffacd0b85a97d-45e5c5db12amr15503607f8f.40.1779093569764; 
 Mon, 18 May 2026 01:39:29 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm32902941f8f.0.2026.05.18.01.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 01:39:29 -0700 (PDT)
Date: Mon, 18 May 2026 11:39:26 +0300
From: Dan Carpenter <error27@gmail.com>
To: Oded Gabbay <oded.gabbay@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [bug report] habanalabs: add gaudi asic-dependent code
Message-ID: <agrQPi0hUPM3TOlV@stanley.mountain>
References: <agrP8NT6DN8iX7sV@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agrP8NT6DN8iX7sV@stanley.mountain>
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

On Mon, May 18, 2026 at 11:38:08AM +0300, Dan Carpenter wrote:
> Hello Oded Gabbay,
> 
> Commit ac0ae6a96aa5 ("habanalabs: add gaudi asic-dependent code")
> from May 11, 2020 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/accel/habanalabs/gaudi/gaudi.c:1036 _gaudi_init_tpc_mem()
> 	error: dereferencing freed memory 'cb->buf' (line 1035)

Actually there are four instances of this:

drivers/accel/habanalabs/gaudi/gaudi.c:1036 _gaudi_init_tpc_mem() error: dereferencing freed memory 'cb->buf' (line 1035)
drivers/accel/habanalabs/gaudi/gaudi.c:5654 gaudi_memset_device_memory() error: dereferencing freed memory 'cb->buf' (line 5653)
drivers/accel/habanalabs/gaudi/gaudi.c:5717 gaudi_memset_registers() error: dereferencing freed memory 'cb->buf' (line 5716)
drivers/accel/habanalabs/goya/goya.c:4820 goya_memset_device_memory() error: dereferencing freed memory 'cb->buf' (line 4819)

regards,
dan carpenter


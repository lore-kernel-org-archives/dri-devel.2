Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA3CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036AB10FD52;
	Wed,  3 Jun 2026 12:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NaZt7JwT";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1784C10FD50
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 12:48:10 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso115394845e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780490888; x=1781095688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVsxgh2ujbRwP+s61o1Lj96pnFL7ang79UkYU7JexyA=;
 b=NaZt7JwTPc5cDaZsWGFodJ6BtUGKbcjO12z/BiyPHtBZmJffC9cuWu0WylotAho88V
 t0MkWKcaLq1+KLFwMQofFmicMPiACscjFdeckxSC3YxMjKKaRK0dQ7/lgBmfXpckqcQ2
 vD9+WFFs+5e6bLyONimxv2BKWM1JPi5PT6pigHjUR3UaCehaNvlA07c3jPzSeM3EsiF8
 ZZNEvNW59A5i8KGIyFAqr9SP/nmYpddPkavHh7jlJWHMI/0fX3mlL5QXqWrRHkms6U45
 ZHXh+wKUf3fuLPHNurjShn+chxSDBOuDGsa0TjgCeROwcAbn4HXfc7c6NTfAzUbGKEDr
 FteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780490888; x=1781095688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVsxgh2ujbRwP+s61o1Lj96pnFL7ang79UkYU7JexyA=;
 b=PPZYbKGQqwV8zGsHHPuqy+t9+FwlRYOZoADqnyNdV5ALlPhNfvyMWtykrLHPLp+AwI
 HYEdXfSoKMX3hsxIlhfDpuG4Vl1C3ZMKUi57RZcV6v4TVBZajWksYQe0DMpi3e7Gxlgx
 eGpNZeJtpBgaYCt+WrVHbijX86z+NfrOgPP6EA+b+PF9feT78IeTlfZv5LNHaXtIEcfQ
 uFETgVSY6DZ1xFvcH64SMBxYLVb7O2W4kHGB7n8vxFv5VJn6USHWDESvBiLtRoKwZFE3
 Yq6JlLqA8I2WT7LWK+Yc6MY67FOWRv5EKUtWOF9JjCSxNnek//LZ3SHXiGuCQqWb3QZS
 jTEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YlXa7g1gqPcDCHZcYvSPqVF1gXP0iofl46E2gllU0qVX6866ZlwYdtbCb5nys9IvMm7tF219UJt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG1t4mcD9uV4J1caMr2pIJdkbaD4ofk9WT+w6FXAuWkpZWpjz5
 BOmP2SNuQE8JK6cjqshWLsXN0ivIqGwVo9XFhbBrPDwTmNViAwJwAAZV
X-Gm-Gg: Acq92OHWQ9Lpk//F3z944WkxZiMay3YEM/OCKToW8e9OUTbSCKEzmWR2QnX8JYwPc47
 RqS5LJui3IM9dEq9fIn4LlNpNkz8y1Yqh9zimsAbGqU8Ty6fjU1aCEPppSAnIAwZQtGbMSdGXE2
 /7tQToMB9j7lfJj1TP/5REen6iGVdrKWleWdRo38nzv7UP5xcB3iKeRCcWtznJZi8ytr0PKb2/D
 +NN10J3814fApXbI5qTKB/uolGGJc5gTR0Unl0pybNxc+so53VprJSpf47OPN93k5G14iBe9OzG
 kvQZGceWjXo35GXD6LR/y62SHn4AxsoCosjK8dlzgm3U7FWrwMeADK2Jdmcg3d0jyyj7FhB/3vu
 NBib+D49reMBbucA/28hXdPut9wbzW7MVa3nTHL2A+wckrKCJiImbpAQjXCmjIGQ1cbakuQYBxx
 nFcOfW5+SerbczWXOYp267rq+T9vInIJ6vOpAAUXi1iekI2ckwfrRBtB1c2RcjXwXa5p5Qr+o=
X-Received: by 2002:a05:600c:8b2e:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-490b5e73ed4mr48400975e9.2.1780490888332; 
 Wed, 03 Jun 2026 05:48:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b6d16f0csm59311625e9.15.2026.06.03.05.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 05:48:08 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:48:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <error27@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller
 <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Chintan Patel
 <chintanlike@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use sysfs_emit_at() to print to sysfs file
Message-ID: <20260603134806.69df0b01@pumpkin>
In-Reply-To: <ah_cd9Ax4fzOhBp7@ashevche-desk.local>
References: <ah_Y_Y2RtqeGxchF@stanley.mountain>
 <ah_cd9Ax4fzOhBp7@ashevche-desk.local>
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

On Wed, 3 Jun 2026 10:49:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 03, 2026 at 10:34:21AM +0300, Dan Carpenter wrote:
> > This scnprintf() uses the wrong limit.  It should be "PAGE_SIZE - len"
> > instead of just PAGE_SIZE.  We're not going to hit the limit in real
> > life since we are printing at most FBTFT_GAMMA_MAX_VALUES_TOTAL (128)
> > u32 values, however, it's still worth fixing.
> > 
> > Use sysfs_emit_at() to fix this since this is a sysfs file.  
> 
> OK,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  	for (i = 0; i < par->gamma.num_curves; i++) {
> >  		for (j = 0; j < par->gamma.num_values; j++)
> > -			len += scnprintf(&buf[len], PAGE_SIZE,
> > +			len += sysfs_emit_at(buf, len,
> >  			     "%04x ", curves[i * par->gamma.num_values + j]);  
> 
> Can we switch to use hex_dump_to_buffer() at some point?
> 

That gets hard when you really want to aim for something nearer seq_printf().

Oh, the way the loops in the code are written doesn't look like
it gives the compiler much chance of optimising it very well.
This is probably equivalent:
	for (i = par->gamma.num_curves; i--;) {
		for (j = par->gamma.num_values; j--;)
			len += sysfs_emit_at(buf, len, "%04x ", *curves++);
		buf[len - 1] = '\n';
	}
and will generate much better code.
(Although most of the cost inside the snprintf() function - which is horrid.)
num_values better be non-zero.

-- David

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A8ACD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F4110FB05;
	Wed,  3 Jun 2026 09:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SDwBWkM8";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E2B10FB05
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 09:00:20 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-bec449cf976so406257866b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 02:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780477218; cv=none;
 d=google.com; s=arc-20240605;
 b=ThjZEYwo6y7FsoFfAImaLsZUE5OW6GNOs7wi2Ea2SaMb/Hld7JOAQjqoEZ/R7ilcR5
 +autD2lYA/rwritEIx2nd+BGu+zJnWY+mrW1hsRPa/ebJb5yHe0KS9u60lj1AQJz8smH
 Xdkd20MrW/EoWW2fONDiLThXAzTgRZBu/bXvASyg+RwADm7hE2Wh9hmyKkkk2iMZo0Xu
 8IDyxsILgiu3mxgHR87BJli57EybAjgZTZiM0WPEZp/trP+J9wGUv6ZMzFsr5uLwSpay
 TI6wS2cwaz7Ok5TzJ+E1KUPsCQlBkexjZsD4S7/7ni6zRcDQ2rY4BLZ3mHfIh9HTq1FW
 vkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jzuby2umJ58JZM+JS4EAdHZjjbUUQ/puGed5+FBLJt0=;
 fh=qJNEmQhRkqSQpWjNDKRZpG7HCyVTMv7vHG97XmPbcNw=;
 b=VtH+dK+1YtFoW2k1WbWFSRhEfNnjmpGVbJmc63lfDCyBjBKvhwa8F2aSOXBAmlraDu
 9caYEFXGfuvWMHVRancS2B9FsRmV6+j6KuZ3tdUMcuUKWGTC3E2LncRDgul92P6La2wb
 /wqwRuoCnty3J8Z5p3iQYAMExp1z4yLzs28V9tFrkVm8nw0xBX57y+9LXd4WUoi+gmzh
 PvTq05fbcUy3A4ZkUxzF/NEF2AI0ugVbrpXjHz3Ue1oVOy3jRBHMEq3V6eUzSSBC14Li
 kxEWDntqWtkQwT9dJlnA9RHVB/u9krsn4JyrfgD/9RD5h0ZFDt0FpohweRm/9QY4yXjF
 ynEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780477218; x=1781082018; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jzuby2umJ58JZM+JS4EAdHZjjbUUQ/puGed5+FBLJt0=;
 b=SDwBWkM8OErpDYZxr2pJBAN3w5p/w1Y0/FbxiOshHzrf12hNwR2B/GUqK9KD3WQALU
 Tn6wI4rnVb8z873TeopOOlQEwK9QGx5bcxOJhNAOI61//lsK/HjI9B4DNUWzU8uY5hTR
 /jcqS2sYSBOz3ZJt5C2NQbaTJgAFccgj+I60E6oxvh4S6fAWL6Wyn7qoLuob+/UoK7mY
 7zMWniqQIWCGGXVFYp98TLJUSXB7a9YpRAJfsYQitau4B882EHEKemqCNDK1GzCIYGwt
 Y7fYQcaJXScdOK6uBSl3XEe9VPilTWmhh3NbKt9k30ox1KFwkm+O3LUGJvNI+QLw6yOX
 HHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780477218; x=1781082018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jzuby2umJ58JZM+JS4EAdHZjjbUUQ/puGed5+FBLJt0=;
 b=Q1NKdDuoumvsUC/IUXuA3zyvhRsNxb8m7YZFHqWpBi/l2k9Ck+J7g2EG9GH+9ixivD
 7UjlM8FHN1hkfKBshJYg4pZjDFtfUxPxppOe9gVWHxd5hA0F/wkedqIvMn42VNhjuCGC
 a9dBygbfv1ulWHMOhRMpjIFAiHi7WK572ltgewWRXEubUFw7f6WZ5LL8KjFAv9VX1HHZ
 nOAXVcBalJCBiOnGa7qVpZSLY3CPhIm4W9aqI60Y4LxH8juOs7mzW9mggCcNSL2UEYvn
 Y/Kbdb4kqJ03u/WWQBqHO/Xk1GGl7Ta2w5Bk9545EkU99Veii9k1IVYmGiAhd52wd2LG
 3KWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FJugCioAkBvGjY/ldjKhdt2sWVvIXW68GY0tgqHmvx9lw08yMX7zJKMtFL32rFpA3L9BhhtCjQLM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyF9oH6MobrlXbgT6++bwJKYQEhUlmFo8ChTgoTGvRlRGPOxL2k
 Zy6wdnf56geMMixTB/MKSZlGKwzE9vsYTjsyL4fCgsZFdxrgAmMFZKj15X/7UlGV9DoE7Sq4m20
 YNihDhnIrvtBBq7Rayhv5IG8pQLjqzisfR7emVpXGfA==
X-Gm-Gg: Acq92OEQj7kt/YNO5ZEzEBAKwlYM+REG5HWgNjb5udtEBDXaijSNNey9IehSMF58vbN
 KP+YHzNHmM/Rovy2poCsSPIdYYnEDiPN9CcqF9tm+Gc24Qr0pQ+jEDwdOIdVLEVUhLy0Z9/JVIm
 wWgZ/jWKZXXeoxYf1MEEkvQ0C11WD3jIYoJ1McArg1UQqTLc8IkUQYiq/krgOPXBSmO/w9fI1E3
 DiQjr8HhVjXr8IwwnxnpKGBQTMIrHrQTNOap0rtmgLI4OimrWg0nCAMR69OdRjasW3YHvJ3iOUi
 K7eizV8CfzUWKCfORP0cqJeIfXKAAFMa4FzRcjNG05SFMRDR+IC7eIQb3Q==
X-Received: by 2002:a17:907:86ac:b0:bb8:fd88:f400 with SMTP id
 a640c23a62f3a-bf0a97083b9mr124305866b.21.1780477218276; Wed, 03 Jun 2026
 02:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260517172352.3615-2-thorsten.blum@linux.dev>
 <ah9cwXA2CO5VB6Kf@linux.dev>
In-Reply-To: <ah9cwXA2CO5VB6Kf@linux.dev>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 3 Jun 2026 14:30:06 +0530
X-Gm-Features: AVHnY4KggjhwnZqqk9ax1UCTzRTZe5T2OHJLulQOs1YKwvmbLelqVZK9U3zAOh0
Message-ID: <CAO_48GFrqMzqPJrXU8wKZNUKX083n1ef8163Yx0mkjS86DcJcw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] dma-buf: heaps: use max3 in dma_heap_ioctl
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hello Thorsten,

On Wed, 3 Jun 2026 at 04:14, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Gentle ping?
>
> On Sun, May 17, 2026 at 07:23:53PM +0200, Thorsten Blum wrote:
> > Replace two nested max() calls with a single max3() in dma_heap_ioctl().
> >
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Apologies for the delay; its now pushed to drm-misc-next.

> > ---
> > Changes in v2:
> > - Include minmax.h as suggested by T.J. Mercier
> > - v1: https://lore.kernel.org/lkml/20260427172519.417333-3-thorsten.blum@linux.dev/
> > ---
> >  drivers/dma-buf/dma-heap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index ac5f8685a649..d49188893608 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/list.h>
> > +#include <linux/minmax.h>
> >  #include <linux/nospec.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/uaccess.h>
> > @@ -153,7 +154,7 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
> >               in_size = 0;
> >       if ((ucmd & kcmd & IOC_OUT) == 0)
> >               out_size = 0;
> > -     ksize = max(max(in_size, out_size), drv_size);
> > +     ksize = max3(in_size, out_size, drv_size);
> >
> >       /* If necessary, allocate buffer for ioctl argument */
> >       if (ksize > sizeof(stack_kdata)) {


Best,
Sumit.

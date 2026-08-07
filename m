Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D2BC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D8010E66B;
	Mon, 10 Aug 2026 06:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="C1FycP04";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F3510E41B
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hG
 MfnqBLVIUJm1+g9zdl8Uve5KpSNGj2V+fdypTnTCc=; b=C1FycP04icqhTL+P3w
 uRA19WLEZCZVauddTw8QM8PsfVk0awerC/aI6WCvBzEDinb4fkRFfHjJweWUo+ti
 Mch7GO+mbrswtcwTjWvEC6fboP75WIamfP58FT6q0USOVJ9bpTrPvxYGkF4b1UaI
 FEb9QzV9GcCRkfEhjHl/keiSY=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDnMU0N7nVqQeHpMg--.24288S2; 
 Fri, 07 Aug 2026 22:39:10 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: namcao@linutronix.de
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 notro@tronnes.org, sh_def@163.com, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH] staging: fbtft: make dirty_lock IRQ-safe
Date: Fri,  7 Aug 2026 22:37:42 +0800
Message-ID: <20260807143740.2775738-3-sh_def@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87pkzu852x.fsf@yellow.woof>
References: <87pkzu852x.fsf@yellow.woof>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnMU0N7nVqQeHpMg--.24288S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1DGF4DGFW5JrW3ZFy3twb_yoW5Gr1Dpa
 17t345AFW8Xa109w43urWDZF4a939FgF4qkryxK3WxAa43uFyfWFykAF9Yqr4vyrZayF1r
 AFyrC3s3Jw4DGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUtPEhUUUUU=
X-Originating-IP: [183.192.100.171]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQ62Fmp17g45MAAA3Z
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

From: sh_def <sh_def@163.com>

> sh_def@163.com writes:
> > diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> > index ca0c38221c16..193643d0329d 100644
> > --- a/drivers/staging/fbtft/fbtft-core.c
> > +++ b/drivers/staging/fbtft/fbtft-core.c
> > @@ -298,14 +298,20 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
> >  {
> >      struct fbtft_par *par = info->par;
> >      struct fb_deferred_io *fbdefio = info->fbdefio;
> > +    unsigned long flags;
> >
> >      /* Mark display lines/area as dirty */
> > -    spin_lock(&par->dirty_lock);
> > +    /*
> > +     * fbcon takes dirty_lock while holding console_owner. Disable local
> > +     * interrupts here so a printk hardirq cannot acquire console_owner
> > +     * while dirty_lock is held and create the inverse lock ordering.
> > +     */
>
> Beside that reason, we also need spin_lock_irqsave() because
> fbtft_mkdirty() can be called in both task context and hardirq
> context. And this reason alone suffices and usually is why
> spin_lock_irqsave() is used, so I think a comment is not necessary.
>

Thanks.
I will drop it in v2.

> But I am fine with it either way.
>
> >      spin_lock_irqsave(&par->dirty_lock, flags);
> >      if (y < par->dirty_lines_start)
> >          par->dirty_lines_start = y;
> >      if (y + height - 1 > par->dirty_lines_end)
> >          par->dirty_lines_end = y + height - 1;
> > -    spin_unlock(&par->dirty_lock);
> > +    spin_unlock_irqrestore(&par->dirty_lock, flags);
> >
> >      /* Schedule deferred_io to update display (no-op if already on queue)*/
> >      schedule_delayed_work(&info->deferred_work, fbdefio->delay);
> > @@ -317,14 +323,15 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
> >      unsigned int dirty_lines_start, dirty_lines_end;
> >      struct fb_deferred_io_pageref *pageref;
> >      unsigned int y_low = 0, y_high = 0;
> > +    unsigned long flags;
> >
> > -    spin_lock(&par->dirty_lock);
> > +    spin_lock_irqsave(&par->dirty_lock, flags);
> >      dirty_lines_start = par->dirty_lines_start;
> >      dirty_lines_end = par->dirty_lines_end;
> >      /* set display line markers as clean */
> >      par->dirty_lines_start = par->info->var.yres - 1;
> >      par->dirty_lines_end = 0;
> > -    spin_unlock(&par->dirty_lock);
> > +    spin_unlock_irqrestore(&par->dirty_lock, flags);
>
> fbtft_deferred_io() is executed in workqueue with interrupt enabled. So
> it can use spin_lock_irq() instead of spin_lock_irqsave(), right?

Yes, agreed. I will use spin_lock_irq() here in v2.

Thanks for the review.

>
> Nam


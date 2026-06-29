Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D91C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E149410E9C2;
	Mon, 29 Jun 2026 16:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="8x49n/wy";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB87A10E9B1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=Wl6VBPyNkT9JR6XDXNkycx4Te2988DvHWTjdeEBLZvA=; t=1782752382; x=1783961982; 
 b=8x49n/wyagOlwyL0GDDeHGbMFHRBm3QNEA+YfpyXD8YwLq9ZJmwKahsjlHLq8jurWwfSfood/8C
 ZzBX8VdtxkACDahZxxGR+gnYxDqXGNY2/4g6qXU9ldbclf+afQfNbN6PV5dByinh1Ykuqorv11PED
 tnbxvKNpuTkj9h1b86imQ3czN1Arox2GYboSkCccMvHnjCigXJSsoZDTqBlhPs5W6u50qlolLBrVr
 CEQmHOo1eoFWgvKalpu9nYwWKgwuhpY3OZzH2APJNyNHLsp5QHoRLQen6Z8hdZsmkEBDuNfGEl/hj
 55C5eXxkgkk/DuxJBm43xYGFsO+e7ZJoUl7A==;
Date: Mon, 29 Jun 2026 18:59:40 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time
 in writes
Message-ID: <20260629185940.283b101d@kemnade.info>
In-Reply-To: <20260629160448.13D001F000E9@smtp.kernel.org>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <20260629160448.13D001F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
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

On Mon, 29 Jun 2026 16:04:47 +0000
sashiko-bot@kernel.org wrote:

> > -	if (r < 0)
> > +	if ((!r) && wait_for_completion_timeout(&completion,
> > +				msecs_to_jiffies(500)) == 0)
> > +		r = -EIO;
> > +
> > +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> > +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> > +	if (r)
> >  		return r;  
> 
> [Severity: High]
> Could this lead to a stack use-after-free if the timeout is reached?
> 
> The wait_for_completion_timeout() can return 0 (timeout), after which
> dsi_unregister_isr_vc() unregisters the ISR and the function returns,
> destroying the on-stack completion. 
> 
> However, dsi_unregister_isr_vc() doesn't appear to synchronize with the IRQ
> handler. If the hardware IRQ fires right after the timeout and the handler
> executes from its lockless copy of the ISR table, could it call
> dsi_completion_handler() with a dangling pointer to the destroyed stack
> frame?

There are several places in this file having that problem. So it is not new.
I have sent a fix here:

https://lore.kernel.org/lkml/20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info/T/#u

Regards,
Andreas

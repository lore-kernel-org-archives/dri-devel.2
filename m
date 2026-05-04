Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9698DFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 11:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E1F10E21D;
	Mon,  4 May 2026 11:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d0k7a8+N";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C7D10E21D
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777892540;
 bh=YIIRoU83Rvr3BCz4suh5d1PWHieSo4Fl6v6kR4sQ0xY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=d0k7a8+NIU0ryK+11CcaVuBa37YTL3cIu2yOxFfg6a3c/mkvUhUabWhh2YMtA4CfJ
 Rgd4SwQeLlsh8FbuKZoV1HhaPv9lIo+hz5LWtnWSubjQ1iPOV0l4wCEvD+c2VoAfl+
 JkRk6Wjc8CsQ/EDE0gTJwXYa6/XHBOYaobaP5OibB84E0vFffwfYdP1knodfhN7FUo
 AmLNsTAL9On7DsyOCHPQxbTr6IvEOAn5xkmc9NUmu3G2Pi0pRsaSVonw/rtER9UVkl
 0Vr7SHWcxcK7tGbdzl9VP6jwTFsSWH5NgSfDiXBSiD/eVAxOmWjwwBGsSBrng36YPw
 9sB5TKbMNPhVA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5477017E124B;
 Mon,  4 May 2026 13:02:20 +0200 (CEST)
Date: Mon, 4 May 2026 13:02:15 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
Message-ID: <20260504130215.0222b3bd@fedora>
In-Reply-To: <446e9d1f-b6be-42fa-bd2b-f4fcbc130f70@arm.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-8-4b92ae4142d2@collabora.com>
 <446e9d1f-b6be-42fa-bd2b-f4fcbc130f70@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Fri, 1 May 2026 15:20:17 +0100
Steven Price <steven.price@arm.com> wrote:

> On 29/04/2026 10:38, Boris Brezillon wrote:
> > Rather than assuming an interrupt is always expected for request
> > acks, temporarily enable the relevant interrupts when the polling-wait
> > failed. This should hopefully reduce the number of interrupts the CPU
> > has to process.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> It seems to work, although I'm lightly uneasy about this because I'm not
> entirely sure whether the FW will immediately see the updates to
> ack_irq_mask and therefore whether there's a possibility to miss an
> event and be stuck waiting for the timeout.
> 
> Memory models are not my strong point, OpenAI tells me the sequence
> should be something like:
> 
>   scoped_guard(spinlock_irqsave, lock) {
>   	u32 ack_irq_mask = READ_ONCE(*ack_irq_mask_ptr);
> 
>   	WRITE_ONCE(*ack_irq_mask_ptr, ack_irq_mask | req_mask);
>   }

Is this really needed? In which situation would the compiler/CPU decide
to re-order this read_update_modify sequence?

> 
>   /*
>    * The FW interface can be mapped write-combine/Normal-NC.

I'm not too sure I see what the non-cached property has to do with it.
If it was cached we would still need this memory barrier, and in
addition, we'd need a cache flush if the FW is not IO-coherent.

>Make sure the
>    * IRQ mask update is visible to the FW before sleeping waiting for
> the IRQ.
>    */
>   wmb();
> 
> Which seems plausible. But I've long ago learnt that plausible doesn't
> mean much when dealing with memory models!

Yeah, I'm not too sure. I was honestly expecting the spinlock guard to
act as a memory barrier already, but maybe it's not enough.

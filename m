Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21572CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A04210E5D9;
	Wed, 13 May 2026 15:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oT1F7vIf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D687F10E5D9
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778686947;
 bh=eea/uowj4M+4awWH6ZUpMckb+dBzLbzfqxg+D+KHOp0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oT1F7vIfiVt4/eQ1tEzNe7Fkx5GcBKIdlujVoCyFJNJiRo3S+j3hRFz4MYmHMcf6y
 9KrSaKjAWlvYY29YJd9E8wNYTnjTy5IBOZNqznpSg16W0bIRDrNzAmS1UYnyPOwXzA
 qaBTXh1lT1tCL6BObVyyyXyblgNOAhP6jY3sfzpGQYrjkyB/VD9wso6Up0m3IAFJWp
 RCXy6IGEXMCW/WO5WznyxCUeJZreRd0XRd6fTA+2XtRnCSIgpEZZMzeyzdcdlZj5w2
 Nf3g8goRzWqr7r65oIsWoKVdFv28AQSdBAbq1tWCHIsU8fgme/VKWJbtFi0zutbhVM
 2xBrTDLaWRdRw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0886617E13A8;
 Wed, 13 May 2026 17:42:26 +0200 (CEST)
Date: Wed, 13 May 2026 17:42:22 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
Message-ID: <20260513174222.70b6d2a2@fedora>
In-Reply-To: <3c721f22-d1a7-474e-8276-f0afc7cd9a0b@arm.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-8-4b92ae4142d2@collabora.com>
 <446e9d1f-b6be-42fa-bd2b-f4fcbc130f70@arm.com>
 <20260504130215.0222b3bd@fedora>
 <687ecf58-3602-46ef-a76e-94f7b1852dce@arm.com>
 <20260506180854.61ae7d62@fedora>
 <3c721f22-d1a7-474e-8276-f0afc7cd9a0b@arm.com>
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

On Wed, 13 May 2026 16:02:11 +0100
Steven Price <steven.price@arm.com> wrote:

> >>>> It seems to work, although I'm lightly uneasy about this because I'm not
> >>>> entirely sure whether the FW will immediately see the updates to
> >>>> ack_irq_mask and therefore whether there's a possibility to miss an
> >>>> event and be stuck waiting for the timeout.
> >>>>
> >>>> Memory models are not my strong point, OpenAI tells me the sequence
> >>>> should be something like:
> >>>>
> >>>>   scoped_guard(spinlock_irqsave, lock) {
> >>>>   	u32 ack_irq_mask = READ_ONCE(*ack_irq_mask_ptr);
> >>>>
> >>>>   	WRITE_ONCE(*ack_irq_mask_ptr, ack_irq_mask | req_mask);
> >>>>   }    
> >>>
> >>> Is this really needed? In which situation would the compiler/CPU decide
> >>> to re-order this read_update_modify sequence?    
> >>
> >> I think that's the AI being a bit overzealous, but in general WRITE_ONCE
> >> is necessary to avoid some surprising effects. In theory the compiler
> >> can decide to perform multiple writes if it's non-volatile. I.e. a
> >> sequence like:
> >>
> >> 	u32 old_mask = *ack_irq_mask_ptr;
> >> 	if (condition)
> >> 		*ack_irq_mask_ptr = 0;
> >> 	else
> >> 		*ack_irq_mask_ptr |= req_mask;
> >>
> >> Can be 'optimised' to:
> >>
> >> 	u32 old_mask = *ack_irq_mask_ptr;
> >> 	*ack_irq_mask_ptr = 0;
> >> 	if (!condition)
> >> 		*ack_irq_mask_ptr = old_mask | req_mask;
> >>
> >> In which the compiler has changed the (!condition) path to do two writes
> >> one of which "should never be seen".
> >>
> >> Given that the compiler shouldn't be able to move any of the effects
> >> outside of the scoped_guard(), and since there's only one operation then
> >> I can't see how a compiler would screw it up - but the compiler is
> >> technically free to do so.  
> > 
> > Sure, I'm not saying read_modify_write is atomic per-se (even though
> > I'd be surprised if the compiler wasn't generating instructions that
> > are atomic in the end), but it is thread-safe because of the spinlock
> > covering the read_modify_write op.  
> 
> But one of the "threads" is the MCU which isn't using the spinlock -
> which is why it's a problem if the compiler left the value in a 'random'
> state even if it's all fixed up by the time the spinlock is released.

Okay, I see what you mean. I truly hope it's not random values, but if
it goes

	X -> 0 -> X | Y

or

	X -> 0 -> X & ~Y

that's already problematic, because we'd lose events.

> 
> Like you say I would be very surprised if a compiler messed it up in
> this case.

I'll add the READ/WRITE_ONCE() and add a comment to make sure we don't
forget why they are needed (in theory).

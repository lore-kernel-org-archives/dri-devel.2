Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3DFCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071E410E864;
	Tue, 19 May 2026 14:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qn+BcsoS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E695A10E864
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779200389;
 bh=mdBbzjNI/cEnhs+9shTezmkc6qwa3DXnypjDBGjWzV8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qn+BcsoSl1ORad3e/LA/M9iuf8rP/z/n9c8SoKAYpF8ow35GLCwHnUqlJ6EAKQjvU
 LPB2QI1CVFfQleH+S6b8OS5hs+jyU7RphdbbwOOEVq5tVdiLIxRuJlK2BGeKVLbc/B
 ogLY/ivPvgUVFGYctsEojYFt14vaYpYy2lBsNNYlcu/rMU1oG0RpD7aNYR4T7a2T31
 PUSuNqfAlJXzkKseTuZNHXEIR+ZBVoUcNmYXoHn6PfIXQzznkbBtlL+PIUUIS3OQH+
 Qip63sSooZrH2VqEsHN3QjITbR7xlT1IMVSyPmNPH+jDlyOMWbX8PtK4Mn7La/NEBj
 h+NqvfZkifJww==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2BD3717E02A3;
 Tue, 19 May 2026 16:19:49 +0200 (CEST)
Date: Tue, 19 May 2026 16:19:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] drm/panthor: Automatically enable interrupts
 in panthor_fw_wait_acks()
Message-ID: <20260519161944.285178c6@fedora>
In-Reply-To: <20260518101656.6426fb18@fedora>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
 <44d8b158-76bd-4ad5-9fd5-616afd432155@arm.com>
 <20260518101656.6426fb18@fedora>
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

On Mon, 18 May 2026 10:16:56 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu, 14 May 2026 15:25:07 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
> > On 12/05/2026 12:37, Boris Brezillon wrote:  
> > > Rather than assuming an interrupt is always expected for request
> > > acks, temporarily enable the relevant interrupts when the polling-wait
> > > failed. This should hopefully reduce the number of interrupts the CPU
> > > has to process.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>    
> > 
> > As mentioned in the other thread[1] it turns out this won't work with
> > the current firmware.
> > 
> > The firmware checks the interrupt mask before signalling the ACK - so
> > enabling the bit in the mask just before waiting for it is problematic -
> > the firmware may not see the addition in the mask and will not trigger
> > the interrupt.  
> 
> Is it a problem though? wait_event_timeout() will evaluate the
> condition before going to sleep, so, if the FW raced with the
> input->ack_irq_mask update, I assume the condition will evaluate to
> true and wait_event_timeout() would return immediately. The only issue
> is if the FW updates the output->ack register after reading
> input->ack_irq_mask, but that would be weird, since the output->ack
> update doesn't depend on input->ack_irq_mask, and raising an interrupt
> before updating output->ack would be racy anyway.
> 
> Am I missing something?
> 

Quoting your reply to v1, for the context, because I missed it when
replying here:

> So I've looked at the firmware implementation and I can say that there's
> a race condition on the firmware side if we change the mask after
> sending the START/RESUME request. The firmware currently samples the
> mask before triggering the update to CSG_ACK and then uses the sampled
> value to decide whether to trigger an interrupt.

So, the race is:

CPU						MCU

CSG_REQ.STATE = START
atomic_poll(CSG_ACK & STATE_MASK)
						process_state_change()
							...
 							mask = CSG_ACK_IRQ_MASK
							...
							// done
CSG_ACK_IRQ_MASK |= STATE_MASK
wait(CSG_ACK & STATE_MASK)
							CSG_ACK = (CSG_ACK & STATE_MASK) | CSG_REQ.STATE
							if (mask & STATE_MASK) // evaluates to false
								raise_int()


It's a bit unfortunate, because conditionally enabling IRQs
only after the polling period expires reduces the number of
interrupts directly caused by requests initiated by the CPU
since it's assumed those requests will complete relatively
quickly and avoid a sleep+interrupt+wake-up round-trip. We
could of course update CSG_ACK_IRQ_MASK at the time we update
CSG_REQ, but that means we'll still get an interrupt, so I
guess we should stick to what exists now if there's no other
option. Oh well.

>
> This is all fine if the mask is set before the request (so nothing
> broken with the current code), but we'd need a firmware change before we
> can safely do what this patch was proposing. And of course we'd have to
> get our heads round the barriers needed! ;)

:-(

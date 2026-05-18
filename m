Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0244CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E0810E6F7;
	Mon, 18 May 2026 08:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eEE7zizW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AAC10E6F7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779092220;
 bh=hmo7xAisfGDuO9lHtx2j6W0/MRRC5RDwpKNc3RaE4u8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eEE7zizWS9T3Ox5T2mnIhSGj7sgbuBAlPsM2FZHoYTVWZic1h4CMf0vq3mP7YG75x
 7gJKJr6Rtr9kdy9Ut2f6vuWF7o2lACoH+VReVLNbuEl26o93pDGGcXl8WLL7Jj0R6t
 2lmr9jU9tNPUXfgVoCBGZ1HgOM/TLjkEynJVayPXBWQz72JIg+Ku+jCuYJCWi514FE
 W1Dz5KMLmYU0DpLgZhoiNf8C9zQFgMiCh3+22Nls0huOqAOfgqnxgXw5DKL6T8wbPG
 SkzHTY2DoWXt+6fDfI9hPKszRCMXS5egV+9hQPNQ9t5S/ohU1F38HZBSO4rxYZNoNd
 q7gJIfp2HuSuw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F73717E0566;
 Mon, 18 May 2026 10:17:00 +0200 (CEST)
Date: Mon, 18 May 2026 10:16:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] drm/panthor: Automatically enable interrupts
 in panthor_fw_wait_acks()
Message-ID: <20260518101656.6426fb18@fedora>
In-Reply-To: <44d8b158-76bd-4ad5-9fd5-616afd432155@arm.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
 <44d8b158-76bd-4ad5-9fd5-616afd432155@arm.com>
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

On Thu, 14 May 2026 15:25:07 +0100
Steven Price <steven.price@arm.com> wrote:

> On 12/05/2026 12:37, Boris Brezillon wrote:
> > Rather than assuming an interrupt is always expected for request
> > acks, temporarily enable the relevant interrupts when the polling-wait
> > failed. This should hopefully reduce the number of interrupts the CPU
> > has to process.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> As mentioned in the other thread[1] it turns out this won't work with
> the current firmware.
> 
> The firmware checks the interrupt mask before signalling the ACK - so
> enabling the bit in the mask just before waiting for it is problematic -
> the firmware may not see the addition in the mask and will not trigger
> the interrupt.

Is it a problem though? wait_event_timeout() will evaluate the
condition before going to sleep, so, if the FW raced with the
input->ack_irq_mask update, I assume the condition will evaluate to
true and wait_event_timeout() would return immediately. The only issue
is if the FW updates the output->ack register after reading
input->ack_irq_mask, but that would be weird, since the output->ack
update doesn't depend on input->ack_irq_mask, and raising an interrupt
before updating output->ack would be racy anyway.

Am I missing something?


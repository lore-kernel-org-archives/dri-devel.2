Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BEAFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8AE10F2DB;
	Thu, 30 Apr 2026 10:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Z/cGE1WT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AE310F2DB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777545534;
 bh=edj1vQfHdZh/dQCJki2Vkoqqtj1Bq5iFNVI6Sude1PA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z/cGE1WTHHtI8p3dsjKI7Mym9K89i06+i2hYEg0BfiwExnImG/3QF1V0IWqEcCDoE
 JZVvb9lic+0VNCg1yXoW3oetDymeI0ppwQWfGNUSOXcM68GgCljdrsYU5de2iGzb7h
 6D1Cd6rvz517UW8MH9R+xb1ckTfsetUapEv0t0mgnnZnFNEn5inyGP1dm5Nf1DwwIK
 BYINQGB+54+h+FvFKZYFOrhXNvSeJhAjv65U15f6WRkqe/rtOWET3cAgAYdt13wvmW
 mAyJNH7o9s7JDtiaEsXRdFyJLEMZEMFoPgwp+4kLC04TVOGieWbu532y6yI2D9BQ8p
 /Mb6ZzKwBcObA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 18A7D17E0610;
 Thu, 30 Apr 2026 12:38:54 +0200 (CEST)
Date: Thu, 30 Apr 2026 12:38:49 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
Message-ID: <20260430123849.2a9cefa8@fedora>
In-Reply-To: <5d6f4531-7359-4d58-9c00-4d6bbc4b739a@arm.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-3-4b92ae4142d2@collabora.com>
 <5d6f4531-7359-4d58-9c00-4d6bbc4b739a@arm.com>
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

On Thu, 30 Apr 2026 10:40:32 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> > +
> > +static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
> > +{
> > +	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
> > +}
> >    
> 
> Hello,
> 
> Maybe we can consider embedding the slow_handler into struct panthor_irq?
> You can then always use a default threaded IRQ handler here and call
> pirq->slow_handler when needed.

The idea here was that the compiler can basically inline
panthor_irq_default_threaded_handler() and turn
panthor_job_irq_handler() into a direct call. If we make it a true
function pointer stored in panthor_irq level this optimization
can't happen.

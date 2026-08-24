Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9998AC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11DA10E671;
	Mon, 24 Aug 2026 07:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="E2yHCKXa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3058410E529
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787558082;
 bh=oWAQb9cEuPErH543ngx2n2rVFJYJcJ9yLaplp7vKq74=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E2yHCKXaZ/0s9MZQ2lAS3NsQF5AtAP5AYbO+9MP4uyyvdQfGju6MmGoWE+UxnnImm
 h+8VneoSy904nJAonTPwwZW/gcZqxuU29Kudn1Z4KZVRM2Vvf2WIi38ibv149DjGFQ
 ErzD8jWxbkvLpz4OE+ppvfBfycpgyviRLJnm3VXiTV4mVI/AC5DMwKcGxnTPUvSxmf
 tz7toV3VIMz3hjVV3nwECKdtXpVzHb07GH2KK66beak4PdbSIZK0IVNcwxZudsHz9r
 Kvr4/X4et8tSNpCp0eMZTxUg7R+/fzFXa1vcarvgDZtirVY3uNpOpFXPy8B6RPRlLO
 gw76tU452FGQA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1C75517E00E9;
 Mon, 24 Aug 2026 09:54:42 +0200 (CEST)
Date: Mon, 24 Aug 2026 09:54:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/9] drm/panthor: Get rid of panthor_group::fatal_lock
Message-ID: <20260824095437.268a849e@fedora-21.home>
In-Reply-To: <44deb321-aa09-44f1-beb9-86a4d7eea1f4@arm.com>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-5-12f2ab53d735@collabora.com>
 <44deb321-aa09-44f1-beb9-86a4d7eea1f4@arm.com>
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

On Mon, 17 Aug 2026 16:12:22 +0100
Steven Price <steven.price@arm.com> wrote:

> On 11/08/2026 12:23, Boris Brezillon wrote:
> > This lock is never used, and we're about to make fatal_queues an
> > atomic to cope with concurrent updates.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Although it does make me wonder if there's a fix that needs backporting...

I've audited all places where this field is accessed, and I think we're
covered by the panthor_scheduler::lock. The only place where this is
not the case is group_term_post_processing(), and I believe the
fatal_queues value is frozen at this point (can't be updated by IRQ
logic because the group has left its CSG slot).

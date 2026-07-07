Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A677C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F1810ECA1;
	Tue,  7 Jul 2026 12:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="qVK9edx5";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6F710ECA1
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=WhKnRiGBppKNpN86Hrh1BNfq/F8SUBk6UDvxQS7rtwE=; t=1783427578; x=1784637178; 
 b=qVK9edx5ck1YksN9qQrNnR8LvYCipzVBlxR6AAdcwCjiO0qjL6n2iqFhHkyQkWyyRs2Yp5YE5U8
 OfghYkIdpMI1pdIhqfjC4czT1iZMHn+edRLgkk5DSUnsqJ392nLKT8vJp8pPgVi9urJeo32fFt1wE
 ASzczGTcCJ1uf8hCoC2YMSMXC82CDR3+6CCOJblNjt4kUCHEm+PCXGCfSX+HSnrwR09XA/Rbro5QV
 3AdFLwBRN5th7oIQNXg95txFtuYgmzWH8q+CKSMZFpC8ET/1voDVOMRkKhSRN4TotkDgSWS7X1zus
 ddojAOqGYBTB7S8/siMUW7sCECiiLgU8Lryw==;
Date: Tue, 7 Jul 2026 14:32:54 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: sashiko-bot@kernel.org, Helge Deller <deller@gmx.de>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] fb: omap2: dsi: do not copy isr table
Message-ID: <20260707143254.76bbb791@kemnade.info>
In-Reply-To: <20260702160541.340B11F000E9@smtp.kernel.org>
References: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
 <20260702160541.340B11F000E9@smtp.kernel.org>
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

On Thu, 02 Jul 2026 16:05:40 +0000
sashiko-bot@kernel.org wrote:

> [Severity: High]
> This isn't a bug introduced by this patch, but it appears the identical
> use-after-free vulnerability you are fixing here remains unpatched in the
> equivalent DRM driver.
> 
> Does drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_irq_handler() need the same
> fix? It still copies the table and drops the lock:
> 
> drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_irq_handler() {
>     ...
>     memcpy(&dsi->isr_tables_copy, &dsi->isr_tables, sizeof(dsi->isr_tables));
>     spin_unlock(&dsi->irq_lock);
>     dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
>     ...
> }
> 
> This could still race with a timeout in dsi_sync_vc_vp(), which creates a
> completion on the stack:
> 
> drivers/gpu/drm/omapdrm/dss/dsi.c:dsi_sync_vc_vp() {
>     DECLARE_COMPLETION_ONSTACK(completion);
>     ...
> }

Enitities with access to cerebral richness can find the link in the patch
to the version for the drm driver.

Regards,
Andreas

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5450F3383D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D01310E411;
	Tue, 17 Mar 2026 14:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kx4Ab0+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC90B10E132;
 Tue, 17 Mar 2026 14:52:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DB7A43B84;
 Tue, 17 Mar 2026 14:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803F4C4CEF7;
 Tue, 17 Mar 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1773759162;
 bh=nRmUAUhg90W/Bh2gvuQ9Vw7WYNE1iqA/N00wuni7oqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2kx4Ab0+ASxYNCv07G6xhzwnPkx8l2gj4JBh3JHXmbMfP9LBwFCDICZh2u2vLPSrP
 08TIQQZKaqMZ3ZHZpuV79iqYQsgzc52iz77YPWmS5HdMP5hfHSoaVOvxISE2IuEiDW
 PK4uKeUvwSisEITiwek40IuNNXL/4a8nIrCdeMoE=
Date: Tue, 17 Mar 2026 15:52:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/xe: allow request_irq on GSC interrupt
Message-ID: <2026031723-ridden-prevent-f005@gregkh>
References: <20260317134741.3420-1-Simon.Richter@hogyros.de>
 <20260317134741.3420-2-Simon.Richter@hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317134741.3420-2-Simon.Richter@hogyros.de>
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

On Tue, Mar 17, 2026 at 10:47:17PM +0900, Simon Richter wrote:
> The default flags for freshly allocated interrupts are platform dependent,
> and apparently powerpc and arm set IRQ_NOREQUEST by default.
> 
> The normal path is to clear this flag from irq_domain_associate_locked(),
> which wraps the irq domain's "map" function, but the xe driver does not
> define an irq domain and instead allocates the irq descriptor directly, so
> the flags need to be set up manually as well.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6468
> Fixes: 87a4c85d3a3ed579c86fd2612715ccb94c4001ff

Didn't checkpatch complain about this?  Please use the documented format
for this.

thanks,

greg k-h

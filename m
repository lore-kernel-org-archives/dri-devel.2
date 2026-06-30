Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A83C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3655810EBCE;
	Tue, 30 Jun 2026 09:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQMZz+Rn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0D510EBCE
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:21:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 041CE41699;
 Tue, 30 Jun 2026 09:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D51F000E9;
 Tue, 30 Jun 2026 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1782811314;
 bh=8UVj/xbCgEWxRoJHuLmtaRwcHH6P04xVZjzmRYgd69w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZQMZz+RnUAGPb7y8VDGwbYpRXk8/gR7jpxdyA7xypKYocm0TfU3xtlGEvgsHFHbXy
 Ne66zYC08qAlefoIOXkpEH5HbelIW5u8IquK60mFLkBAebdxiiGHnOAnc/EPl9UD00
 DzCnihP4oakIUiw90A5Qp4T5AE89R5LA7puEYxNU=
Date: Tue, 30 Jun 2026 11:21:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Andi Kleen <ak@linux.intel.com>,
 Alexander Martyniuk <alexevgmart@gmail.com>, stable@vger.kernel.org,
 David Airlie <airlied@redhat.com>, Sasha Levin <sashal@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 5.10/5.15/6.1/6.6/6.12] agp/amd64: Fix broken error
 propagation in agp_amd64_probe()
Message-ID: <2026063021-ripple-uranium-f24e@gregkh>
References: <20260629102124.252403-1-alexevgmart@gmail.com>
 <akKR2bNYFokN43Sk@tassilo>
 <5fbd827c-4c4d-4364-882c-41d2fe666fde@stu.xidian.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbd827c-4c4d-4364-882c-41d2fe666fde@stu.xidian.edu.cn>
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

On Tue, Jun 30, 2026 at 09:23:50AM +0800, Mingyu Wang wrote:
> 
> > What is special about this virtual environment? Nobody else
> > seems to have seen that in 20+ years.
> > 
> > Or maybe the Fixes tag is not quite correct and something else more
> > recent has caused it.
> 
> Hi Andi,
> 
> 
> You are right that normal users will not see this crash in the wild.
> 
> The environment is a QEMU-based driver fuzzing framework. Rather than
> functionally emulating specific hardware, the framework extracts device
> matching information from the driver and synthesizes a mock PCI device just
> to trigger the driver's binding and initialization paths.
> 
> In this case, the synthesized PCI device matched the AGP bridge's IDs,
> forcing `agp_amd64_probe()` to run. However, because this is a synthetic
> fuzzing environment, there was no physical or emulated AMD Northbridge
> present in the system.

Which means this is a contrivied environment that no one will actually
use, so there is no need to backport this change anywhere.

thanks,

greg k-h

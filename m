Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D71CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA6610E184;
	Thu, 25 Jun 2026 09:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9zAFidS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4287610E184
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E001341A09;
 Thu, 25 Jun 2026 09:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA151F000E9;
 Thu, 25 Jun 2026 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1782380999;
 bh=UYYq+KoBekpGqtmApm0mDvu1qJsMHG5Kl14VoGf11Fg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=x9zAFidSX67wqXQoP/ZDpcQjer5o4KaCIZzPrQyCI1oGax9GhWrxmkErsD2ggGxai
 +T1QKLbNJNhVVY5d5P6/Y/x6mLeD1NTKeKTpNz3atKKbRtyMcqBvh+nzy92VUAYGcC
 /Fgg/uI2vjNP+60CMWgz+URRD/wjrLu3IWdf6PFY=
Date: Thu, 25 Jun 2026 10:48:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] misc: fastrpc: reject oversized DMA allocations
Message-ID: <2026062536-protrude-cufflink-9026@gregkh>
References: <20260625085659.4469-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625085659.4469-1-alhouseenyousef@gmail.com>
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

On Thu, Jun 25, 2026 at 10:56:57AM +0200, Yousef Alhouseen wrote:
> FastRPC keeps invoke and mmap buffer sizes in u64 fields, but coherent
> DMA allocation takes a size_t. On 32-bit builds, a size above SIZE_MAX
> can be truncated before allocation while the larger value is still used
> in the message sent to the DSP.
> 
> Reject sizes that cannot fit in size_t before allocating the DMA buffer.
> Also make the inline payload alignment step overflow-aware so a
> near-U64_MAX accumulator cannot wrap before the later bounds checks.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Are you forgetting to include the tool information that you used to
find/fix all of these issues?  And how are they being tested?

thanks,

greg k-h

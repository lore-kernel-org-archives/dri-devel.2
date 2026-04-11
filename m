Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C28F3ED50
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 16:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B138110EA28;
	Sat, 11 Apr 2026 16:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c8OIozop";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA76010EA28
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 16:11:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8552243C6B;
 Sat, 11 Apr 2026 16:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAAFC4CEF7;
 Sat, 11 Apr 2026 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775923908;
 bh=1DPOozjF3PkSt8DaiDKpW7A2kEoqNIhWphiiXCSIYXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c8OIozopHkeJ98qDQjw3doukz2qiCoV9BoR39Z3BYGewhnZub3n7r317UMaKNZryw
 kkIh0/ewWAEFD5SROVi0zXEbhBTuSjGHUb1DjtwVnTVQKCe+zMgwoRqwkKOplrmR6D
 cr2CUn1/Q8i1IEF4kyU+RpdqnES9EAemnIvNL0Sc=
Date: Sat, 11 Apr 2026 18:11:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chandra Mouli Baskaran <bcmouli2006@gmail.com>
Cc: andy@kernel.org, linux-staging@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: improve TODO comment clarity
Message-ID: <2026041127-cabbie-sandbag-48f5@gregkh>
References: <20260411152220.89174-1-bcmouli2006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411152220.89174-1-bcmouli2006@gmail.com>
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

On Sat, Apr 11, 2026 at 08:52:20PM +0530, Chandra Mouli Baskaran wrote:
> From: Chandra Mouli <bcmouli2006@gmail.com>
> 
> Clarify the TODO comment in fbtft_ops_damage_range() to
> better describe that the current implementation updates
> the entire displayinstead of only the modified region.

That does not match what this patch actually does :(


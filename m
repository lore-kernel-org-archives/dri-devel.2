Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4081AC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 23:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7961210E869;
	Sat, 19 Sep 2026 23:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXIrIXkf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2502C10E869
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 23:03:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C09BC4069E;
 Sat, 19 Sep 2026 23:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCF21F000FF;
 Sat, 19 Sep 2026 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789859029;
 bh=MvGhrMJk8sYCvFwzsPgKj9IOEWofxy9gNm3301617hw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bXIrIXkfIReFA5AgHq7kIMWVLFAgZAHE4EAUNWrkS8j/XrkLnwH5OtWWw8q8ZLluw
 Gr0/QeE0mpPMcyk0V2YgrrFoW1qazN6QnigAwckuEjWz3XPZXp8YbPK4F3LsMIIG3N
 AsrbKEItwSL48UrUKaPLH4mruNtr9YOJdIU3HjJs148N4mofOdpkcdM6PK5eIrRwBE
 jfiJegL+hIYwQ5nkiiupXXxp9QmZJLaNa0fQDZGH1K5bSpmdnn2Xq5jSpUMgpyRr4e
 dtg7kdd7cHPsctHTKHe+fxy5gEJNc3ZIvUzdSmpbmiWR75PO7tFOrReI9HoAfEqldj
 /cMXC4JXOjRTA==
Date: Sat, 19 Sep 2026 16:03:48 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, ssengar@linux.microsoft.com,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove myself from the Hyper-V entries
Message-ID: <20260919230348.GC1008213@liuwe-devbox-debian-v2.local>
References: <20260915043150.10521-1-longli@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915043150.10521-1-longli@kernel.org>
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

On Mon, Sep 14, 2026 at 09:31:50PM -0700, Long Li wrote:
> I am no longer maintaining the Hyper-V/Azure core and drivers, or the
> Hyper-V synthetic video DRM driver.
> 
> Signed-off-by: Long Li <longli@kernel.org>

Applied. Thanks!

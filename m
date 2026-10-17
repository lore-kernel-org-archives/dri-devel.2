Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A585ACCA463
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 05:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7D010E0FF;
	Sat, 17 Oct 2026 05:45:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BA610E0FF
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 05:45:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2763660A99;
 Sat, 17 Oct 2026 05:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462281F000C4;
 Sat, 17 Oct 2026 05:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1792215944;
 bh=Irp1w6YXigrOn5sn/xl8Ctx0KqHC6GO3GLBC0DMTFEI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dUC9L9BmOL1ZbQE0YeH2r8jpJLJ/DKNZqHL5iYclhHbp7v58ECvF196Pq+3UVVR3/
 O3iuCbjqs4lWd0oTwCbfNXmCeUyix1Nw4VYdAR80B2BwjhUy4kLACJfV+6HA0VKHt4
 WYc2EO0EiWwrvWaM+aZ4ePwsttjQIjL8MWYU7/aU=
Date: Sat, 17 Oct 2026 07:45:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
 skainsworth@gmail.com
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
Message-ID: <2026101737-broker-output-d845@gregkh>
References: <2026092253-dimness-unethical-2515@gregkh>
 <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh>
 <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
 <2026092332-alkaline-overthrow-494f@gregkh>
 <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
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

On Sat, Oct 17, 2026 at 08:19:46AM +1000, Dave Airlie wrote:
> So I got a report that
> 
> "the backport of "drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
> swapout failure" to yesterday's 6.18 missed "drm/ttm: fix swapped-out
> resources never leaving their bulk_move range",
> 
> So can we make sure this patch is in the stable branches the other one
> went into?

Sure, any hint as to what git id that is?

thanks,

greg k-h

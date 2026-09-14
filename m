Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DC9C88E66
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C1C10E4CE;
	Mon, 14 Sep 2026 09:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOsNHGwg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD1210E4CE
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:33:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B843F409CB;
 Mon, 14 Sep 2026 09:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188F21F000FF;
 Mon, 14 Sep 2026 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1789378425;
 bh=QHBv43bKUeXfOEgkXZvi20WRU/bSrjEFSZCrzLi8H7I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fOsNHGwg2HUqkjWekRiEq+9vvDRPXg3aRTW2MVsTfyfE8tR6C26RTcAVoVfKSvXJc
 PO3Q6GZTn2Fjq8H/aJqICaPwJ3RXyJkoBy8+ohDbvgsJNEiI2Y5SMt76Yq2iwHF2jN
 z0SOxACOZJ54i+yXA++te80BbqSGXOXf25dvnlS4=
Date: Mon, 14 Sep 2026 11:33:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Andy Shevchenko <andy@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: sort includes
Message-ID: <2026091405-headfirst-disarray-5893@gregkh>
References: <20260914090732.9712-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914090732.9712-2-manuelebnerli@mailbox.org>
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

On Mon, Sep 14, 2026 at 11:07:32AM +0200, Manuel Ebner wrote:
> Sort header files alphabetically.

Why?  You need to describe why something is needed or being done, not
just what you are doing.  Please go re-read the kernel documentation for
how to write a good changelog entry to get more examples.

thanks,

greg k-h

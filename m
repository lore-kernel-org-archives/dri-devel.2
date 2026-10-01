Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FB0CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F8410E144;
	Thu,  1 Oct 2026 13:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Clya+pBX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8C110E144
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:02:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 674A54191E;
 Thu,  1 Oct 2026 13:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499B21F000FF;
 Thu,  1 Oct 2026 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859735;
 bh=Eob7zzZfDEAxmFc2bmXm9vuF8tzUFFiSjg5xt3lkBag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Clya+pBX3URzVI8t53yWg72i2FYQIIHOBZ3IhJWsCAqJKSTT6XQYq1rDt4F3aMBba
 r2JKUxADyaCLk93dlq93kR0Ii1+XgaR67kog+ODNq8C20K6baDKqRcS643dIssE9ZR
 wcPO4ra5VnkFcuVlKDOprWFcg4pB6ygHrph7hAViDzf9cCuaTphdCk6Q92wkFdM1R7
 scjlMHbQa/h3S1rMDhg4j5m11eN+37j5ZLJOGYdsQNX7QZm226rUyWLoPh2RlhOFFy
 Wn+Z1gDIfYyX8oI1oP8IM4vwK73/Pa18tikQZLGHhjL8E99ls55cfQsPiHS938gO8P
 GCyHCDCmKW8wg==
Received: from johan by xi.lan with local (Exim 4.99.5)
 (envelope-from <johan@kernel.org>) id 1xCGQP-00000008QoG-0bNQ;
 Thu, 01 Oct 2026 15:02:13 +0200
Date: Thu, 1 Oct 2026 15:02:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx/tve: take i2c adapter module reference
Message-ID: <ar5Z1TjIceCl-EdS@hovoldconsulting.com>
References: <20260716131937.1564892-1-johan@kernel.org>
 <anx_aEJGbFM6Xosx@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anx_aEJGbFM6Xosx@hovoldconsulting.com>
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

On Wed, Aug 12, 2026 at 04:12:56PM +0200, Johan Hovold wrote:
> On Thu, Jul 16, 2026 at 03:19:37PM +0200, Johan Hovold wrote:
> > The i2c subsystem currently blocks during adapter deregistration
> > whenever there are consumers holding a reference.
> > 
> > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > reference to the adapter module so that an attempt to unload the module
> > while in use fails gracefully instead of blocking uninterruptibly.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Can this one be picked up for 7.3-rc1?

Again, can someone please pick this one up?

Johan

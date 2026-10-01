Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FB3CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB68010E2F9;
	Thu,  1 Oct 2026 13:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fx/OO9Pq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A377D10E2F9
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:01:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B62243C38;
 Thu,  1 Oct 2026 13:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0841F00898;
 Thu,  1 Oct 2026 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859702;
 bh=qsG459SeAnIYQeFjgHWg4kx9TumJ/vcmHPElH3Y18uY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fx/OO9PqfpUUewoq3irvS3bQJbplJwC+e/h0a7O5QQcdI6zVmb648EFULIQFRnejm
 6tNtbDz4jwXcCVfjVGeRRj3P7W4p/NHP2wFeAbXUJ6xdM5FhQBEPosSvgl6lsOcZRZ
 B5oaJM/XcDoY0W0c6ZQn3sp/mmr1MnrOPoXvM5A0/jiH8f5bYTVSgfdD4lMARtRLOU
 KUfyCtAMkfXZTUEoTWrzUcw0qM9QWUHTR8xAP9mVoFVMGXRMhG91uJWVyGpctblNeN
 k3+IKg9i6BaI5yayt8OEAQ++BVG3B+Q/LPQWN7rFPtJjfh+vbApmDZFt5IgYgGUwxF
 RHTmg+5YMc9GQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
 (envelope-from <johan@kernel.org>) id 1xCGPs-00000008Qnf-1XIG;
 Thu, 01 Oct 2026 15:01:40 +0200
Date: Thu, 1 Oct 2026 15:01:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
Message-ID: <ar5ZtMgav9YM6ciE@hovoldconsulting.com>
References: <20260716132334.1565183-1-johan@kernel.org>
 <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
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

On Wed, Aug 12, 2026 at 04:12:00PM +0200, Johan Hovold wrote:
> On Thu, Jul 16, 2026 at 03:23:34PM +0200, Johan Hovold wrote:
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

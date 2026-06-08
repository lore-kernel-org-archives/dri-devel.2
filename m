Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA4CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC5810F3EA;
	Mon,  8 Jun 2026 13:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hrvE/h6Z";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4028610F3EA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780926075;
 bh=hyDWsynSVBRtilr2H+1tPwAl4HIuL+CLETu8CEJKbzo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hrvE/h6ZYOFBJ1cv8hNMy2gnfB++EurkblbweqakrDfcBVEqV0uRNEymZ5V51wpgQ
 98vyXoVoVVQRGu3JnFZYTjP7JyiStgYGKz/ZoiDabKRzWce6Miogqd7vJtaMxvG37A
 wSCpAgxHEj8hQvviWnpOYczigmwnsnootg5c4io/x1DaLymuQLDZgUhWAuRkJ/GNw0
 Ll5B/2l+CphLn5O+zcrzo2Y8fp1Etw4Lswlrg4ZxgWHaAc4j2jhT7zPWHpevcDG7r4
 fDkaOtIIaC5RzB4c1YhryzWpBpZIZ/UkzU7cEd1oFq2J8CtjbeU9+AikEKEZAoh+6C
 bf4Bxgb6hmbzQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BDAD17E062B;
 Mon,  8 Jun 2026 15:41:15 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:41:01 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/18] drm/panthor: Move register base offsets to
 the HW description
Message-ID: <20260608154101.2460796f@fedora-2.home>
In-Reply-To: <20260608153246.5fdbea05@fedora-2.home>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-6-karunika.choo@arm.com>
 <20260608153246.5fdbea05@fedora-2.home>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Mon, 8 Jun 2026 15:32:46 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu, 28 May 2026 16:05:33 +0100
> Karunika Choo <karunika.choo@arm.com> wrote:
> 
> >  /**
> >   * struct panthor_hw - GPU specific register mapping and functions
> >   */
> >  struct panthor_hw {
> > -	/** @features: Bitmap containing panthor_hw_feature */
> > -
> >  	/** @ops: Panthor HW specific operations */
> >  	struct panthor_hw_ops ops;
> > +
> > +	/** @map: Panthor HW-specific register base addresses */
> > +	struct panthor_hw_regmap map;  
> 
> map is a bit too vague. Can we rename this regbank_offsets or something
> along those lines? If we do that, we can drop the _base in the field
> names, because it'd be obvious that these are offsets when the field is
> used:
> 
> 	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regbank_offsets.gpu_control;

Actually, MMU ranges need a stride, so I'd go for:

	struct panthor_regbank {
		u32 offset;
		u32 stride;
	};

	struct panthor_regs_layout {
		struct panthor_regbank gpu_control;
		struct panthor_regbank pwr_control;
		..
	};


	struct panthor_hw {
		struct panthor_regs_layout regs_layout;
	};

> 
> >  };
> >    


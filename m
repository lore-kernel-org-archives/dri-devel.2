Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F708CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6695E10F3D0;
	Mon,  8 Jun 2026 13:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="alTgc3IJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704AF10F3D0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780925571;
 bh=qcxaRvl4I1a8Mo0iiXNigHYsU7ODQZ9ywjgz5bodr6w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=alTgc3IJBVuI8iwVkVIZSWcP65Fhi0H1RopWa+2OrPm0WtG1pmc2tGpT8ciH9qwXb
 GDwPwJ1oVN+N48OV3cMUKfAgT+mDiogicULq6iB3T0xSsvU2haOnA4M2ASt5A+77BX
 sL9LTfNaIC1mCR0lmWZR7wQg4M5lRLVfUI4fWs6l1/zV4WQfRKgBoYL/zZfP+IrbMZ
 oeQ/0tGPRh7EDjG+v9K3cIrs/t+6RiH/v5hxSni0bwbXQTyh7iu+tyU7psM7tahSQ0
 CI/XhqGfTpD/SFjfA5FiCnFtKyjNyNFJrFfUUO02xbL3s94T4tgU4AlVu5LT4FTGZO
 T+3UelkHS5dNQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B269E17E0191;
 Mon,  8 Jun 2026 15:32:50 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:32:46 +0200
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
Message-ID: <20260608153246.5fdbea05@fedora-2.home>
In-Reply-To: <20260528150546.3168527-6-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-6-karunika.choo@arm.com>
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

On Thu, 28 May 2026 16:05:33 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

>  /**
>   * struct panthor_hw - GPU specific register mapping and functions
>   */
>  struct panthor_hw {
> -	/** @features: Bitmap containing panthor_hw_feature */
> -
>  	/** @ops: Panthor HW specific operations */
>  	struct panthor_hw_ops ops;
> +
> +	/** @map: Panthor HW-specific register base addresses */
> +	struct panthor_hw_regmap map;

map is a bit too vague. Can we rename this regbank_offsets or something
along those lines? If we do that, we can drop the _base in the field
names, because it'd be obvious that these are offsets when the field is
used:

	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regbank_offsets.gpu_control;

>  };
>  

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF6606EEB2
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mthzq1VV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672E110E07E;
	Thu,  5 Nov 2026 15:57:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F5B10E2A6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E73D742E75;
 Thu,  5 Nov 2026 15:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC51F000C1;
 Thu,  5 Nov 2026 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793894217;
 bh=fwV/2B3TkwHJXgDq9v3y31qZQLcW8rg2jXVX7Q/BYBs=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=mthzq1VV++GovyrOsvOve2PzrK1e2YnD6/5c8e6w07xQfL/JkNSOIh4XMpcPdniwm
 diC7wRhV0Z3jTwQrjoOlGsHxGokLGE/x/ccHqoEEELTm9qyWnPJO2gTQAruanN9+qX
 tZIHss3uEEY8N6rKhVA3TzbEdfu3fweQ6qgFVUFMQJAeCjo9ODpAqSMZyXMbc9xvgQ
 SOhUaTSR/mlnqtLkvxTqOfWV1bzVHsMZ+X2P4NhNKgZ86elbsCEAjtkTppZN0E7X7T
 YHIVctkIVzOQOiQs+W9fCNmU0kh63/NwOPKTg0BbSlhnrs40ou9Hvtby/Rfi8dIDM4
 Yv1MzOmCbVxiA==
Message-ID: <654ec450bfe86c60279a352014ead93c@kernel.org>
Date: Thu, 05 Nov 2026 15:56:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Sebastian Wick" <sebastian.wick@redhat.com>
Subject: Re: [PATCH 2/2] drm/vkms: Use drm_dev_unplug() for ConfigFS device
 removal
In-Reply-To: <20261031225901.3200167-2-sebastian.wick@redhat.com>
References: <20261031225901.3200167-2-sebastian.wick@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Haneen Mohammed" <hamohammed.sa@gmail.com>,
 "Louis Chauvet" <louis.chauvet@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Melissa Wen" <melissa.srw@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On Sat, 31 Oct 2026 23:58:59 +0100, Sebastian Wick wrote:
> VKMS ConfigFS devices can be disabled while userspace still holds open
> file descriptors. Using drm_dev_unregister() leaves the device in a
> state where ioctls are still accepted but internal locks can contend
> with the teardown path. Specifically, drmModeGetConnector() triggers
> fill_modes which acquires mode_config locks that contend with
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

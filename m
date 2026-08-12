Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBFAC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C9910E424;
	Wed, 12 Aug 2026 15:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PTFnkSxm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830EF10E424
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:54:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97F2460A7D;
 Wed, 12 Aug 2026 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0551F000E9;
 Wed, 12 Aug 2026 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786550086;
 bh=JkcD/2eDWSdNSRbxebDp220oH8c6M5J5gDR4uLmishM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=PTFnkSxmWwllmBacdl70CAzZk1gpzfU3spfkZ4u7biNEvDINyDn386cxTKs6Tixqh
 6ubD+0E4e1SNMJR86MY6yP+w6Fvc/ZSkGFhcAt6URB2BwcSrbpl+wB4urscD5iDfos
 S4wRhCHCKd7vmcnG11zuB2u+evcibjXcceEQKY2cMTkMtXcI8GGf9CZ+aiY7UmA7Rg
 kgHfw9BuWbwTMqcIobFFsrFjR+bAasxyc22KM5Kas5Uz2QhWFrYYSNd2/j5CU/hdkY
 FoZD9hm7/EMbJ14silyjkZ5fKDwROsTWvgwc2CfvVfMbGD1wQWf1lSQDgH9jJ25HeQ
 bljntta1YOCXg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 17:54:43 +0200
Message-Id: <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
Subject: Re: [PATCH 0/2] gpu: nova-core: retain the GSP-RM log buffers
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
In-Reply-To: <20260812113752.532537-1-vladazaharova2018@gmail.com>
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

On Wed Aug 12, 2026 at 1:37 PM CEST, Vladislav Zaharov wrote:
> The testing was done on top of e6c2c6265521 ("rust: firmware: add
> request_into_buf()"), that is, before the TLV firmware series, because
> the nvidia/*/gsp/*.tlv images are not in linux-firmware yet and the
> driver therefore cannot load firmware at the current tip. The series
> applies and builds unchanged on top of drm-rust-next.

Unless you already know and decided against it, a firmware archive containi=
ng
the compatible firmware for the current tip can be found in [1].

[1] https://github.com/ttabi/linux-firmware-nova

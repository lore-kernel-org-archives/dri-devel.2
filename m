Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991176082BC1
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad3K59ZV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C73810FD97;
	Wed,  4 Nov 2026 17:29:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B746310FD95
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:29:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AD6860A7F;
 Wed,  4 Nov 2026 17:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3244B1F00A16;
 Wed,  4 Nov 2026 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793813368;
 bh=yDbkb1XED6qncOAadzXW360XIzlZHMnFZRPOUhpQgSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ad3K59ZVwey0zN+ISekqtJdevUXZTFq9kr5r6K9gxSakjrzb9VFhME1mvJWxZZCbR
 C3okzBzlhkWouCNkouGn0AwWpmtcPyuK0AlxNRavWXvZ0Wh5UHW424pQYEpfBinoXr
 ZyMZSDhubMTw/4GQN4BLOV2yPY8j+Vs6GZOs/n1hKOn7MS0BWjtc6GdGGlAYue1k9O
 Wnd5QnSlC+APeAjd5WL8RVORlBTdbO/bcWky9AkIo+6M8q02hod5kE5bNH+N01lIP/
 AV53S+B/1sNH08KkjMMsMcRBMj2rureyOC4U6CAvXRhBpXdmkpGRUa341Hqn7KZHv2
 8Yg5aTzE07zcg==
Date: Wed, 4 Nov 2026 18:29:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 12/14] MAINTAINERS: Add entry for Solomon SSD16xx DRM
 driver
Message-ID: <20261104-shrewd-traditional-goose-a382db@quoll>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-13-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019213726.4145532-13-devarsht@ti.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 03:07:24AM +0530, Devarsh Thakkar wrote:

> +DRM DRIVER FOR SOLOMON SSD16XX E-PAPER DISPLAY CONTROLLERS
> +M:	Devarsh Thakkar <devarsht@ti.com>
> +R:	LiangCheng Wang <zaq14760@gmail.com>
> +S:	Maintained

> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Drop, you do not commit there.

Best regards,
Krzysztof


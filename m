Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81917606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIe5oxYF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18FA10FAF8;
	Wed, 11 Nov 2026 11:15:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F1B10FB00
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:15:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7E2345AE9;
 Wed, 11 Nov 2026 11:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91D21F00A06;
 Wed, 11 Nov 2026 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794395741;
 bh=6Digdi0J69cdmnfNAOroK/JVKXGvxIlZsj5otBtYtXY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=AIe5oxYF2M19g+llfNnhDDGdQRy3FrvfWXZvepwbD96kg94cj31gHfc/mQkehNC39
 u1qedVzZq7ryZrxNj86XQJf1e/FOmy5/uZskKNAc3QwrY3aiLTr8mLzAgQ2guvRVpe
 jGRMILKY0Qp5ShY8tiHwHmLDN0+o7sV5xrHlVdlFogIkeQfsO2668xHmt+yG6pU/fF
 rti6Eyg4YJ1NbBhKwZwWFow7ZPOsjYjv9MLLFH0A5C66NLj2Or28ANMMmIZprER9ZH
 u/57iG8h8ael69x1YzsGCp7zOzC1sxC5bH0JYMfbixAXhAnoEM+Q4P/CNadv1GVOJu
 7ttqE+zpUltEQ==
Message-ID: <ae6f7b88-ea9a-49f7-a3ad-ba90185528c2@kernel.org>
Date: Wed, 11 Nov 2026 12:15:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add monochrome framebuffer support to
 simple-framebuffer
To: Sebastian Raase <linux@sraa.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <cover.1793758480.git.linux@sraa.de>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <cover.1793758480.git.linux@sraa.de>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sebastian,

On 4-Nov-26 03:34, Sebastian Raase wrote:
> This patch series adds support for monochrome framebuffers (1 bpp, packed-pixel)
> to simple-framebuffer.
> 
> Monochrome framebuffers require far less video memory and bandwidth than
> 16bpp or 32bpp framebuffers, making them useful for small devices or FPGA
> implementations.

Thank you for your patch-series and I see that Helge has just
applied this to the fbdev tree.

Have you considered also extending the simpledrm driver to also
support these monochrome formats there ?

Most Linux distributions now a days have switched from using simplefb
to using simpledrm.

But I must admit I've no idea how well the drm subsys / kernel-mode-
setting API handles monochrome formats.

Regards,

Hans



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05217606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTEegIdj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C56410E0FF;
	Thu, 26 Nov 2026 12:54:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17348112199;
 Thu, 26 Nov 2026 12:53:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3359406F5;
 Thu, 26 Nov 2026 12:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDBD1F000C4;
 Thu, 26 Nov 2026 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697634;
 bh=O+d5676T5CMcSy/94TsW5KMv0BgyZ1tcN/EjPiQ8WdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fTEegIdje0HvM2qaftMcVv2uLKABRroZ03kJ9XkK3T/hbWBTyB8VuriZGtZlekyPs
 jNX3hzvZrkFe4yK8iTXBxn4tJHhAX9amXLpa4x8QSjvIO4M+VnhIYOOGQy2MsKGfqv
 y9qTWIXFWA9qDoDRnXmnCQt1WPJY1av60tKgCpbVjJfqux/laPrY3qrcMuMpROQVf9
 mjL4VlrO5viC9+dbpDD/CsjmTAkB9wZOPVcYWIEnyWdjywwrL0/8Y1t4KbXnFbcphm
 FaHjP3c37mfU+rTGFPy/fs7Gs+FduZa+fdtfsf5ZSjGyxTfvDUV8FVgPyqaXaQfkQt
 lENMWEMyEiLDA==
Date: Thu, 26 Nov 2026 12:53:51 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
Message-ID: <20261126125351-GKA2398@kernel.org>
References: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Iker,

On 19:59 Wed 18 Nov     , Iker Pedrosa wrote:
> Add PowerVR Rogue GPU device node for SpacemiT K1 SoC.
> 
> The GPU is integrated within the SoC and enabled by default.
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)

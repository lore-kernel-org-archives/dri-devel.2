Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40454606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5rcT0Zl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93C410ECD2;
	Thu, 19 Nov 2026 01:27:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783DA10ECD2;
 Thu, 19 Nov 2026 01:27:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69306645CA;
 Thu, 19 Nov 2026 01:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3471F000C5;
 Thu, 19 Nov 2026 01:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795051628;
 bh=OprzOyo9+JassEd1TEvafiLmaglW2JAX08bz3qXzH+M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=n5rcT0Zl/SE9jHWi65HwpiTbSdysgFWjql0ekarf62v72raja8OOgMi+64tXtTKOa
 M5ygoG/bvHgzz8ZIeXIs2ivMgUwHgIEgn7GOBgW3ty0l2awMnvQY9owfOlmYKZD2uU
 2IaJgO1zVeoXLDsLzuDkE2VXP7vdpkj0WzaTyH9BUuFigeLVhYz3ZCFE4AeDGyxyAR
 U67BOybTOTaQp+T1SaHwEyeHtKvyxjFWydFbtpqNlmTQHU1xt3xlJ8+WoBg8WNChOH
 xTcGI0Ji3/zNwyOnhcai3ZPaEx93fKbvlJNQHZs67FMZkQmqfPD+REcBrIBi9qpXuS
 REEkUUwWsOnzw==
Date: Thu, 19 Nov 2026 01:27:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri
 <sunil.khatri@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike
 Liang <Prike.Liang@amd.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, David Rosca <david.rosca@amd.com>, Timur
 =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel
 Maintenance <kernel-list@raspberrypi.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, imagination@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-usb@vger.kernel.org,
 rust-for-linux@vger.kernel.or
Subject: Re: [PATCH v2 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
Message-ID: <20261119012700.2980cbe3@jic23-hlaptop>
In-Reply-To: <20261118134522.1646892-3-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
 <20261118134522.1646892-3-phasta@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 14:45:21 +0100
Philipp Stanner <phasta@kernel.org> wrote:

> Currently, there are two init functions for dma_fence, dma_fence_init()
> and dma_fence_init64().
>=20
> Since more future user options for dma_fence initialization would
> require distinct init functions, too, it is better to do this in a
> unified way.
>=20
> Add a flags field to dma_fence_init(). Adjust all affected drivers,
> preserving the old behavior.
>=20
> Support the SEQNO64 flag, and add a check-function so that the user only
> sets valid bits.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
For IIO,

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

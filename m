Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78F606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wrFrTipr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96ACD112264;
	Thu, 19 Nov 2026 10:20:29 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E93310E680;
 Thu, 19 Nov 2026 10:20:22 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jVZGq6rjlzMm1S;
 Thu, 19 Nov 2026 11:20:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795083620; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMLYuvKF8dKdiwmDA59a1qSto363i7DFLCqovWncpVM=;
 b=wrFrTiprp0Ygwj7fisQqKLfMWazzJwQS8HPNFqbCcn3xMC23c+XlYnmWGpPY6OwTsCFYcG
 pjdBV2XlPMgXizD5IHA860ywzUkD+zPnBEGC3P1iYty0h7dFnuiza4M6w6o0En4MdrFa29
 +z8/8pstoFJyzCxAaLcosYSfYnFvqRobT36nmnUt0/xlqfaGVRZ2fcD0Ifm0zgDEtu/5+n
 P8Q5PrjWKULrK0PMh7Putf64gTqx4d0cgQar9yKkwd/OUN6051FoFULV5Tr2btX33lJYti
 3up4UWipIuXn1wiDtyGvTg7fYqQDSjJUVFutoAn1IjQz0zTDogOUfQ0NPiL7ZQ==
Message-ID: <11c1451c97fa27ec3379965d13a6eea64e386cc3.camel@mailbox.org>
Subject: Re: [PATCH v2 0/3] dma-buf: dma-fence: Remove dma_fence_init64()
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri
 <sunil.khatri@amd.com>,  Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike
 Liang <Prike.Liang@amd.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	
 <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  David Rosca <david.rosca@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal	 <mcanal@igalia.com>, Raspberry Pi Kernel
 Maintenance	 <kernel-list@raspberrypi.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Thu, 19 Nov 2026 11:20:14 +0100
In-Reply-To: <20261118134522.1646892-2-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: e0df46cc69f1b87359b
X-MBO-RS-META: 4qqptwxqro4tns8nyafutn165yabqokk
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-18 at 14:45 +0100, Philipp Stanner wrote:
> Philipp Stanner (3):
> =C2=A0 dma-buf: dma-fence: Add flags parameter to dma_fence_init()
> =C2=A0 dma-buf: Port users of dma_fence_init64()
> =C2=A0 dma-buf: dma-fence: Remove dma_fence_init64()

Applied to drm-misc-next with the Rbs.

Thx guys.

P.

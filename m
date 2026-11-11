Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B6606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=td12n49U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7312C10FA43;
	Wed, 11 Nov 2026 09:37:18 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD74710F99A;
 Wed, 11 Nov 2026 08:53:42 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jPckV706vzKsYn;
 Wed, 11 Nov 2026 09:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794387219; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRiZhzrsDkrLspAml0XRBl5rak3lI4bTzhSsupMJ/y8=;
 b=td12n49UKDo56vCxSTn09U/FbdYGCk/hjrgkPwsYYmfR0Gs5QBppPCBDtVxxLchIEUwdQb
 qOgaQ7bu4TKe2ydp1VVhzS3MjouOIvhK3svhqAqL4/zeXX6snq3K7vPx9e14jLpaWSPfrN
 CC8kqaWegcbNN3dhGKGxAUSh8tFn4cT6u0zUeVOhFHv7yRgcI2X3Hx2TJKeot6Qlqt1EwC
 lXHAwJBaYus+xC2WzZaQgsfOSySsNxfufDkkyksnvgI5eJB6EDfy5i8Q8e6p4IJt1EIvEW
 KDNGmFpUTrOi351V8lzioglBOuHpSOovM/WIAIwzWjYiS+xktKSPpS25dn1MEg==
Message-ID: <a2e7519ab463dec876aa806d91961456f31a725a.camel@mailbox.org>
Subject: Re: [PATCH 0/3] dma-buf: dma-fence: Remove dma_fence_init64()
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Min Ma <mamin506@gmail.com>, Lizhi
 Hou	 <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>, "Rob Herring
 (Arm)"	 <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Karol
 Wachowski	 <karol.wachowski@linux.intel.com>, Andrzej Kacprowski	
 <andrzej.kacprowski@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Felix Kuehling <Felix.Kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lucas Stach
 <l.stach@pengutronix.de>, Russell King	 <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,  Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Alessio Belle	
 <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Qiang Yu <yuq825@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov	 <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang	 <jesszhan0024@gmail.com>, Sean
 Paul <sean@poorly.run>, Marijn Suijten	 <marijn.suijten@somainline.org>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Boris
 Brezillon <boris.brezillon@collabora.com>, Steven Price	
 <steven.price@arm.com>, =?ISO-8859-1?Q?Adri=E1n?= Larumbe	
 <adrian.larumbe@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, Dave
 Airlie	 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Matthew
 Brost	 <matthew.brost@intel.com>, Natalie Vock <nat@pixelcluster.dev>, Arun
 Pravin	 <arunpravin.paneerselvam@amd.com>, Matthew Auld
 <matthew.auld@intel.com>,  Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	
 <thomas.hellstrom@linux.intel.com>, Melissa Wen <mwen@igalia.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal	 <mcanal@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>,  Raspberry Pi Kernel Maintenance	
 <kernel-list@raspberrypi.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
 <zack.rusin@broadcom.com>,  Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding	
 <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Neill Kapron	 <nkapron@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alice Ryhl
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>,  Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>, Alexandre Courbot	 <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,  Sunil Khatri
 <sunil.khatri@amd.com>, Prike Liang <Prike.Liang@amd.com>, Vitaly Prosyak	
 <vitaly.prosyak@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?=	 <timur.kristof@gmail.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>,  David Rosca <david.rosca@amd.com>, Marco
 Crivellari <marco.crivellari@suse.com>, Krzysztof Karas	
 <krzysztof.karas@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Shixiong Ou
 <oushixiong@kylinos.cn>, Jouni =?ISO-8859-1?Q?H=F6gander?=	
 <jouni.hogander@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, Thadeu
 Lima de Souza Cascardo	 <cascardo@igalia.com>, Pierre-Eric Pelloux-Prayer	
 <pierre-eric.pelloux-prayer@amd.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Michael Bommarito <michael.bommarito@gmail.com>, Sam Day <me@samcday.com>,
 Gabriel Prostitis	 <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-usb@vger.kernel.org
Date: Wed, 11 Nov 2026 09:53:25 +0100
In-Reply-To: <20261105113529.1989375-2-phasta@kernel.org>
References: <20261105113529.1989375-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: bc6accce8d8b9e73737
X-MBO-RS-META: pdph9mgme6uj6kihqyt55uq9zqcpmeni
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:37:13 +0000
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

On Thu, 2026-11-05 at 12:35 +0100, Philipp Stanner wrote:
> We recently had a discussion about reworking dma_fence init to close a
> race-window [1].
>=20
> The community agreement seems to have been that we can get rid of
> dma_fence_init64(), so let's do that already. In the meantime we can
> continue our discussions regarding the race in [1].
>=20
> This also touches the Rust dma_fence, which actually should use 64-bit
> seqnos (was forgotten so far). Rust fence has no users currently, so
> needs no backporting, so I would like to address that in a distinct
> patch.
>=20
> Tested on Nouveau with and without the SEQNO64 flag. Nouveau also uses
> the USER flag, so I hope we're fine.
>=20
>=20
> P.
>=20
> [1] https://lore.kernel.org/dri-devel/20261029095542.1526750-3-phasta@ker=
nel.org/
>=20
>=20
> Philipp Stanner (3):
> =C2=A0 dma-buf: dma-fence: Add flags parameter to dma_fence_init()
> =C2=A0 dma-buf: Port users of dma_fence_init64()
> =C2=A0 dma-buf: dma-fence: Remove dma_fence_init64()

@Christian, what do you think, shall we go on with this one?


P.

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BE606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqNn2ZPS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1B7112F0A;
	Fri,  6 Nov 2026 16:37:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74C5112F0D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:37:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C50CA409B9;
 Fri,  6 Nov 2026 16:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D491F0089F;
 Fri,  6 Nov 2026 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793983072;
 bh=vLjr3aN3svtfAg+boMWqs422HvhByANgbsByJPhijUM=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=PqNn2ZPSbtV+aliQY+qri8OzTkVFhHX/RcF49t9kMRpCsmPtKLGAl0ofmvvRDZC1Q
 fb1ipwVXN1A4Hc8z4lDPpyFl3WE1mN4JFnsoGy/qYfl20qH+Ck7uk3eg4l5zXL6MYf
 Pr+TxompeaQ8TKyJuTx//wd6WZaHngdB155MKoKHABCivkcdlDFl/UTxAlvyIe4Ifi
 bT37UmUYBvXd103eTyacBfHfGkarkpKeQ47YiQr2PGsTBfXIiuO5NA/aC1Od04JWdQ
 Z+LIwjb2VR0o8jyq5nS7FbefvW398n1HhNvy3a/AdTFwIVpcA5X+MalQJ7AelTbhjM
 nGHTloIhjADYA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 17:37:47 +0100
Message-Id: <DMO9X7V4K1MQ.2PSHDUJKA9Z2B@kernel.org>
To: "Jani Nikula" <jani.nikula@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Cc: "Dave Airlie" <airlied@gmail.com>, "Rodrigo Vivi"
 <rodrigo.vivi@intel.com>, "Alex Deucher" <alexdeucher@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>,
 "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, "Mark Brown"
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
References: <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <629d19bcd0f61974f3e1c94c90b4052216d2a967@intel.com>
 <DMNL1MG0A8P4.1VPON40R8BX2U@kernel.org>
 <3678ff00381a70148d6abafcf20ba3726bff2fc7@intel.com>
In-Reply-To: <3678ff00381a70148d6abafcf20ba3726bff2fc7@intel.com>
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

On Fri Nov 6, 2026 at 12:08 PM CET, Jani Nikula wrote:
> Anyway, how about just *prompting* "Is this expected to be the final
> pull request for the development cycle?", and if yes, update
> drm-*-next-fixes while at it, and have the automation handle the rest.

I think that's a good idea! So what about just git request-pull prompts:

	 Close this tree for the upcoming merge window?

and in addition have --close-tree / --keep-tree-open options that bypass th=
e
prompt.

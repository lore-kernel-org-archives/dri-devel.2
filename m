Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18A606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=fXxf8NhR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D3A10E336;
	Thu,  5 Nov 2026 19:05:40 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1068410E336
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=1PmTV1YjmPPFpTx+P+HNfLiKEIkEPn2yau3dwP6izoc=; b=fXxf8NhRuHh4GeEyagf8lKlBmV
 fkhdA1h99e5cxhcyvVtPNZv2kqZGmvJMW/BUpUjMM0jqsRotxiX1LDma4A3xCAiEoMmYyJHhMswSc
 RyTigzG9nPuoBljd3oJ4MWo7rNnwi17AsKG5Q2DQFSthFagHeFjqyUwrZjdGbgj/Exi2KStDJzRH/
 VlUPptYlrs/AfA4nCNnlbGdH++ooiEjrJTaqsGpNX6ybNQQDNo5YdCfKb6fEYUHj879DaKaYdtVzD
 ICWvxobFpzODczdprcAw7k40ZFMlB8y5m77iT4vfBdBbiIeFBbtSNaXfUPbLox1nF5YqqRrAXrb1j
 Ltr9fk5g==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Sandy Huang <hjc@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Andy Yan <andyshrk@163.com>
Subject: Re: [PATCH RESEND 38/83] drm/rockchip: Switch to
 drm_mode_config_create_initial_state
Date: Thu, 05 Nov 2026 20:05:20 +0100
Message-ID: <4981299.mvXUDI8C0e@diego>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-38-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-38-1f58d1e33380@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Donnerstag, 5. November 2026, 16:29:47 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Maxime Ripard:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Heiko Stuebner <heiko@sntech.de>



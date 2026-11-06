Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E0606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RO+9x91A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE9710E0C4;
	Fri,  6 Nov 2026 05:17:37 +0000 (UTC)
X-Greylist: delayed 504 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 05:17:30 UTC
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F9710E81E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1793941740;
 bh=Pd1mVthAVfnwz8gxFWpFDjOJnH+tGVWYkmg1KcXE9mo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=RO+9x91AXrMuBqnetZZZJ7e/HhDYizl642SXU9SJrerlwfvKAHib5oAXbQR0NBOsy
 OmG2sNdmMRebcgRTcuJ2Te0TydzEOPGDPAwPI9wXH+MJTF99z9UawzgYETF82cOSti
 ZkA/u+xW5Mbm9Eh+i86MgIdeknGmNH1NHA+9IIW8rYXoQJS6hs4k7E3KxLeeez1fnO
 E4WbaLCv92PBdEgXIa5HDsHvwDVnexCMJB3iZpKFDVuTiklsuUqWs7+FcybZUWW8vn
 BeddazAg7nsWl//aKWq+k6q6inCmSLwLQtpzIyU7Vk4aAkN8zUYxWhsfhdBbNIFNuR
 N83GfCWKuOKmQ==
Received: from [192.168.68.117] (unknown [180.150.112.139])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8086164952;
 Fri,  6 Nov 2026 13:08:59 +0800 (AWST)
Message-ID: <a076f0034df88fb019962616554c36ca78ca4ac1.camel@codeconstruct.com.au>
Subject: Re: [PATCH RESEND 08/83] drm/aspeed: Switch to
 drm_mode_config_create_initial_state
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann	 <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 06 Nov 2026 15:38:59 +1030
In-Reply-To: <20261105-drm-no-more-config-reset-v1-8-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-8-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

On Thu, 2026-11-05 at 16:29 +0100, Maxime Ripard wrote:
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

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

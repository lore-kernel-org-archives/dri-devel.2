Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5D606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qUzQmsz0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E69112F21;
	Fri,  6 Nov 2026 16:48:43 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FAB112F22
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:48:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 83523C69169
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:48:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CE8FB5FFBC;
 Fri,  6 Nov 2026 16:48:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1AC4103291BA; Fri,  6 Nov 2026 17:48:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793983710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Y8RHb1CfLtWSMwWuWLOraHpFqxPeL8G+wZwgLGf7N9E=;
 b=qUzQmsz0d2Ruw1AEvHRBCM6BqbLlBirANyZbJZhH5UCMmroQKt8ux4U5yrHguJyy2mwmS2
 T6hnRhD62dryt3BeJMMMww/aeVKq8LTme+CYkYuHnSZYrE0hw5R3NsNJLRlqCdfFUFk7la
 7qvmaDf0jQgb//keb3vqou8pPTRAtYOiBHZ0LoWQqdfuaIAiCtGVXX8C+Da3y14mNlMCN4
 UBzeUB/ko/QvbdoILgKKtrSzjjwMlT+4kEhtxUBxuUf/ktNDFdhApidVMmOBJagy806Me0
 YBQZpCqkoc/UaeXEHZgs+7PxBvp0+ZN21kL7hzzS8F6HdSL0YxtmHfTpZZ7yOw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 17:48:28 +0100
Message-Id: <DMOA5EDDS1AS.39CGS8Y3PNPMW@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 2/3] drm/panel: remove drmm_of_get_bridge()
Cc: <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
 <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-2-c0ea3382b798@bootlin.com>
 <sashiko-outbox-201829@kernel.org>
In-Reply-To: <sashiko-outbox-201829@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 6, 2026 at 5:35 PM CET, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/panel: build failure in vc4 driver after removing
>   drmm_of_get_bridge()
> --
>
> commit 4e516e61e060977ea843a480424ba4b15e3d19c9
> Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> drm/panel: remove drmm_of_get_bridge()
>
> This commit removes the deprecated drmm_of_get_bridge() helper and its
> header declarations.

[...]

> [Severity: High]
> Does removing drmm_of_get_bridge() break building the vc4 driver?
> vc4_dpi_init_bridge() in drivers/gpu/drm/vc4/vc4_dpi.c and vc4_dsi_bind()
> in drivers/gpu/drm/vc4/vc4_dsi.c still call
> drmm_of_get_bridge(drm, dev->of_node, 0, 0).

Nope, the calls in drivers/gpu/drm/vc4/ have been removed, committed
earlied today on drm-misc-next:

https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/5c18e4b11829d922851=
0d9580027598b54d382e7
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4a38a538775e072fee7=
07aa28aea5ccd50941796

So patch 1 of this seris removes the only remaining user in drm-misc-next.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

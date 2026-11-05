Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146BC606A33A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ai/RxjNu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686D510E1C9;
	Thu,  5 Nov 2026 14:55:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840AB10E1C9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:54:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 55E65C6915B;
 Thu,  5 Nov 2026 14:54:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3043A5FF85;
 Thu,  5 Nov 2026 14:54:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AAE8103292A9; Thu,  5 Nov 2026 15:54:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793890492; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=15ip0tiydeBr/7zuZhLF4o4ZWghgka5SIoL8soaeHm8=;
 b=Ai/RxjNuLII6omeyZPNrYQokNrTXJqRgpqgiumUmstIVX29j7kdoLRg58OnsK65SInSuVw
 ZzriBj3VeyPPyZj3oCwdKOnkoVB0/B1lvHk0XwEmhhZ57uQl9yex018BqDE0GDLZVJLbN/
 QcWbFV4Q7mXK+wmoUGHZ2yON+hyKPf5G4pwd9IKxBrOD7F9v+Of+awu5HrGgn2hxUtJ1Kf
 ZT6seJJWiC7ye2xC6iqGNSboIYNCBCqgj4EnmqT0/4NBgFtmbpU7SvunqQ7vuuyMzPQ+YY
 UNeHfz9Sl1HCcWG8rhbTZfmhBfNThqGuisGTXTeg0HnOTbJlNX3fOuQ0fw8nLg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] MAINTAINERS: Move Keem Bay DRM under drm-misc
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>
In-Reply-To: <20261105142127.708219-2-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
 <20261105142127.708219-2-mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:54:39 +0100
Message-Id: <179389047997.1070495.363087327564554303.b4-review@b4>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 15:21:22 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> The Intel Keem Bay DRM driver is excluded from drm-misc in MAINTAINERS,
> implying it is maintained through a separate tree. However, no dedicated
> tree is documented in the MAINTAINERS entry, no pull request has ever
> been sent, and around 60 patches have been merged through drm-misc. The
> driver is de facto maintained through drm-misc already.
> 
> Remove the drm-misc exclusion for kmb to reflect the actual maintenance
> path.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


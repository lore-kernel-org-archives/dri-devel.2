Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E31606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VriqKx3y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A3310E253;
	Thu,  5 Nov 2026 14:55:11 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1EA10E253
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:55:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2053B4E40405;
 Thu,  5 Nov 2026 14:55:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EA9425FF85;
 Thu,  5 Nov 2026 14:55:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F364D10329267; Thu,  5 Nov 2026 15:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793890498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=k75bFaL76mXVrPIIqob1RCQf29RzQlJAwohB6NiNDRs=;
 b=VriqKx3yMj0pOdlL+IQUAr28U3eKYxeRFw8Yf3KtuzUXoyla0/AWwDS8cZ+O6CBPZFbMfB
 mH4xeDpjL/QA3aTEGGZgJ3LupxCOScjiiWO/u3DFBVuGJybFtCMr9hK3y5pj/EBLSCXpPd
 DguNFKeN0TsNdggajW2+YJNnp8vXImhCu1pqcL0NU9sNbe2YHOg/WX84mWIsZoSt2tOrCm
 rDyxfIYQ3mtxZFpk/j43u9Dt4ouz6E2Od+VsKcOcPOAcMEztbxTaNYyDFDhRsQxWZCwG0w
 trkPxgMWqANV7W4/BIq6jxH9zUrrHN1DAqPBRKmKC6DyA0A8Kk+1fDQYu0SjfA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/7] MAINTAINERS: Move Tegra DRM under drm-misc
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>
In-Reply-To: <20261105142127.708219-3-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
 <20261105142127.708219-3-mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:54:39 +0100
Message-Id: <179389047998.1070495.11643972363762516859.b4-review@b4>
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

On Thu, 05 Nov 2026 15:21:23 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> The Tegra DRM driver is excluded from drm-misc in MAINTAINERS, with a
> dedicated tree at gitlab.freedesktop.org/drm/tegra.git.
> 
> However, the last pull request from that tree was sent in April 2023,
> and about 150 patches have been merged through drm-misc since, most of
> them applied by the maintainers directly. The driver is de facto
> maintained through drm-misc already.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


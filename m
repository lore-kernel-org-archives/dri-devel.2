Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B83606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CZN4Wi7C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9284810EE91;
	Mon, 23 Nov 2026 14:45:57 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E53BB10E7DD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:45:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1CFDA4E41631;
 Mon, 23 Nov 2026 14:45:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D764E601E1;
 Mon, 23 Nov 2026 14:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F8FE11E6A2B6; Mon, 23 Nov 2026 15:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795445143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=i7/HPF1Cxm7oWTLlVBdlvJlynM4y5VdJj8Z3P3dxC+g=;
 b=CZN4Wi7CykBfhjv/s5DwbZ+P3nOxN9r07Ld8QW+bptZH045lNdndvxOTZPtF/YHTEdIhFD
 Q8rAg56SaEIpvKqFhJdwCrJmxz3p5PP5DAEIeUypiZ2X3eZv2SfVsHPOD+9BOA9PFSuevP
 t0k8eGFnDdPssIhTAI088XIjnqNLPt/JwATH61PdNZKFH/z8ml1AbeJW85RIrc+omxC1x3
 AGOpSRWMry49+1Y9AFJXGm4HRuezbrqM9SFN4QF4pJm3Rzgy15D9C4tMwyD8OGByx1jxTs
 yF96rSujmUS12truLDHx93TYYJF7lmaJ92xiA//slsTOsbWrZUeUcdSVjvsAdw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito@redhat.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
Subject: Re: (subset) [PATCH v6 00/43] VKMS: Introduce multiple configFS
 attributes
Message-Id: <179544513429.3984754.11135719755911260525.b4-ty@b4>
Date: Mon, 23 Nov 2026 15:45:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 20 Nov 2026 18:58:42 +0100, Louis Chauvet wrote:
> VKMS have a wide range of options. The aim of this series is to introduce
> many configfs attribute so VKMS can be used to test a wide range of
> configurations.
> 
> PATCH 1-3 fix display and locking of the configfs attributes
> PATCH 4-9 expose human readable strings from drm core
> PATCH 10 is a fix for the default rotation value
> PATCH 11 is ABI documentation
> PATCH 12 introduce reference counting for vkms_config
> PATCH 13 add a KUnit test for the device lifecycle
> PATCH 14 added some error checks in plane configuration
> PATCH 15 cleanup in plane_release
> PATCH 16-17 change the display in configfs to be more readable
> PATCH 18,19 plane name
> PATCH 20,21 plane rotation
> PATCH 22,23 plane color encoding
> PATCH 24,25 plane color range
> PATCH 26,27 plane format
> PATCH 28 properly use zpos
> PATCH 29,30 plane zpos
> PATCH 31 back pointer to connector
> PATCH 32,33 connector type
> PATCH 34 preparation in connector initialization
> PATCH 35,36 connector supported colorspace
> PATCH 37,38 connector EDID
> PATCH 39-41 dynamic connectors
> PATCH 42,43 PATH property
> 
> [...]

Applied, thanks!

[01/43] drm/vkms: Explicitly display connector status
        commit: fd0c30bdfde7fbc4c6f5f9b49ae859f460ced00c
[03/43] drm/vkms: Add new lines for configfs attributes
        commit: be587c4f863d07215726820156c77bbf86ed466e

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


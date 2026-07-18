Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FE4C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE3E10E618;
	Sat, 18 Jul 2026 23:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FgSZz3sX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3769610E618
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:51:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E65C60008;
 Sat, 18 Jul 2026 23:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66121F000E9;
 Sat, 18 Jul 2026 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784418685;
 bh=4OVsQf/yiuG67ARP6+Rl9z4GLpfAIYz6W7pHbzFxoRU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FgSZz3sXBEyoc4ZJPqe6zXYKq7KFDW6SjfP6hN3kTqIG/6AhnzVeXH+ZtOPmnIAv6
 Ef2XmFgYqEFgLICSlNXfLI1GfECIMVvxwfVf+6xoz3tSGGVxGwhURkMcvm9iScM9jS
 +vvp38J5I2UxJYxfS9WhBrdEEmF8yv9ObZo2SzmTsdDdiWFvg1xci6/PlMXxAkWG7u
 oQbAMBOHcf7nt2lTbIA8CPs3q5DKGnmfA+Mk5rk4Tk0yOhAmvU1DBwqGTHcd6BHgMB
 TFHfM7ZEUrLyeeWStrBOzceTrCtUHvl6/DYwGUBtieb1G077Zed9lyxQRoAiS3Wk2b
 w28Jde70pzdCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] drm/drm_simple: remove deprecated
 drm_simple_encoder_init function
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 wsa+renesas@sang-engineering.com, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260719-drm_simple_encoder_init-v1-14-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-14-a78c509e3062@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 23:51:24 +0000
Message-Id: <20260718235124.C66121F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch successfully removes `drm_simple_encoder_init()` but fail=
s to remove its corresponding completed task from the GPU TODO list.
--

--- Patch [14]: [PATCH 14/15] drm/drm_simple: remove deprecated drm_simple_=
encoder_init function ---
commit 7fd5be63f48ba2540ec1b5b7dc137c54a85997f8
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/drm_simple: remove deprecated drm_simple_encoder_init function

This patch removes the deprecated drm_simple_encoder_init() helper since all
driver users have been converted to drm_encoder_init(). It also open-codes
the remaining internal use to prevent any new users.

> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/dr=
m_simple_kms_helper.c
> index 8e1d07b9f1e30..7878b9d7d5248 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c

[ ... ]

> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple=
_kms_helper.h
> index cb672ce0e856d..c95f86ff355ff 100644
> --- a/include/drm/drm_simple_kms_helper.h
> +++ b/include/drm/drm_simple_kms_helper.h
> @@ -68,10 +68,6 @@ int drm_simple_display_pipe_init(struct drm_device *de=
v,
>  			const uint64_t *format_modifiers,
>  			struct drm_connector *connector);
> =20
> -int drm_simple_encoder_init(struct drm_device *dev,
> -			    struct drm_encoder *encoder,
> -			    int encoder_type);
> -
>  void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
>  				  size_t offset, int encoder_type);
> =20

[Severity: Low]
This isn't a bug, but since this patch successfully removes the
drm_simple_encoder_init() helper, should it also remove the corresponding
completed task from Documentation/gpu/todo.rst?

Leaving the item in the TODO list might confuse future contributors since t=
he
refactoring effort is now complete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719-drm_simple=
_encoder_init-v1-0-a78c509e3062@gmail.com?part=3D14

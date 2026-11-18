Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89314606A74C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zY75EQo2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D282C10FCA9;
	Wed, 18 Nov 2026 18:41:10 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9099810FCA9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:41:04 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cdab9e9761cso953408a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795027264; cv=none;
 d=google.com; s=arc-20260327;
 b=FNXoowuQPPp1Li88ImoZhPx0wUESPROOQ3RNCj1Ht1zLOXUvvPuHRpBs7P057WeT8e
 EDt92dkQvpe65KVEDF7oMxI3vAPO8ihZ9L6dKnQcOp+LYaD0YaYgMALrbTc+cWBSzfOv
 mJI0iYVfkFb/4G0xloNYkVKyyHWHFmDIW/sNyLzu7Lw4831F8mDPrKjlKL+TCo1BjyuE
 gxtaP3pmIwvZtO1WDS9/0TvtHpes4YQWm4TtaGZ4sKY3aKqyX6rKVXsD9yLJJOEEnPh3
 IIDJPSualKkiTnhLaWpj5VPFPDlt7HXybjcHe4yBYwu5o8lDKbovtJsKgF1O8WPmUSQJ
 eyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G/i6BgZIIK1rSOJ3+PYlJo2sxPMt/IcZiiVN4y2+TfU=;
 fh=gpRnH9Sr3iQYDNSqxYsrS0bY7Vjck+ctleM8IgVUNg4=;
 b=ID5YPseoycygfliH471NRMT3xXgn8bYvKnf9M40v2p51SC1KAGiGavzf9hezg62x0o
 42dS6cbp0RoHZa8GM4HQksZJw+SOSz/qBISuBrmxtmSYeKrY3Iuy7PbCpSQE4rzE2RT+
 kzvf9FoLyXkxySVZ2PVY0weZxWHXiHOsuuwxtIraYDbBJvwcBE7bqkePrC0FirT6IqR9
 M1rrlDIFCugC/+DOBBJfGTcHmiTK8lf5sOkKkqSFUN7duIoYvgCz9t5bYLZzSAM7uwYq
 JMf4yc+BayPXrPkVIAuTiCVI5dPT7oU8wW050naEmTbBDIXL6D6EFDL8OrIVAFKq+SQ5
 1a1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795027264; x=1795632064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G/i6BgZIIK1rSOJ3+PYlJo2sxPMt/IcZiiVN4y2+TfU=;
 b=zY75EQo2XYG6Ta0faB2YO73qCabDvq90qw1hItww3L4mUKey+PGSHLgC9mq7qDyB2O
 LsQVHy39Go1WAq0jpOCMsAUZ2An9Q1tdB+1Grrq2uYewBrdy3mUxfI7lN1MaPYq7untA
 csbfBeViZIoqzFHZIV9tmUpwN13SuiHmI5kqQ8i3kIPX4Vh+gT/WTEA8HjNCvzahawWj
 QSjXF3b/niq5v1inULuG1hYgHJVkYWeRXSI1BFv7vH9v9PkryfLguR+qaGyGyGzfwNM/
 aopIQysHpaxCqkscFdSwFmdzoxjjqUW1s/2o79VzoyWtA2DhsRtr3zGgF+EUA6SvHC3v
 PrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027264; x=1795632064;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G/i6BgZIIK1rSOJ3+PYlJo2sxPMt/IcZiiVN4y2+TfU=;
 b=capKRek+c2keCoGu3HEOSetYtjSuLdAivuPwMzUK3jqN7hwS/GZpXCdjPBEGomB2vh
 AOVp1VBwS2eKAFWxivf+CS5j5gFfs6j6RRUqWwYjtYxtt7QlIlTHYNwyWCQwIWHuCQkR
 OSQz94xqfnYJTDbejmcO71p2Ty0N5Q470+IbF0joaV0VMFfK2OTbOtu/woa+wcSJT+Pz
 8U9bxQ3u8TDlxqcXnuoUuz+VthgEQUI2sDNGotkBxt7dlI/iUXfEgGZ33t3oAG62rK2G
 4Alvm6qPt1viKRNOVf1g5DAsHzQ2S/t7eVu8L6peQeQS24KIG/CGOV1RjE70W+ohe+RP
 LNWA==
X-Forwarded-Encrypted: i=1;
 AL+hErE4kWuUbU8/bEOCJczjojOW/p8pcYVR3cGE22am9VMwI5ovVUpMEnMA0T2I0TuF6FcpIp6isHdfgL0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/gn9uKwlgZQ0pd5mTWkNgjQMZ6c4rtg+cVFtvEsfK+47Jz+uBY
 5SwmkcjZpn7Igewc8TiyfoGtcE0K4VWDfNILjbo8uuFTFC+Bccp8NhjTkSdYnmheCtRWXhteC8q
 9NDbQX3SBMSrC5RIRmUTXAgeApip9DNU=
X-Gm-Gg: AZFdTZdohZ33Hb/bPFZN8B7lR/Q6EYLXUDzkshaxGpKKbpK9CEo4aVY7cft1Htn6527
 y2f3MDzPYdKJnT73wqRSQ7KTkVJkFkOPfVdwsXC3HrI3COvXPY+7GQmiJB3l9cUC+P5QLkSd5HT
 qbqfMle/cATRG04cSBAcRVIvchXZiVRqDa08YCUPOxupwQMwjHUIYgTZ5jDkuRoHISPIjennwPv
 5ZSAvt3lhCnhSjBXmWKC7O/oXQtL36Tp0ZslJ/rKbxYUCXj4xE2FSvGl7LZ8LT5j4atK8AiRkQT
 G3CtU3OvmhmOZaoGPAxTzd9y0FLsWdn/KQank20tgYj/cBaKnU/pKFBokUyyRfI/tTYllPWHYRp
 wnLt/sIURI9U2vXbfR3AHy29sUDlN2Iy/FBEOrg==
X-Received: by 2002:a17:903:234e:b0:2e9:4d9f:a65b with SMTP id
 d9443c01a7336-2eff75424cbmr35815375ad.53.1795027263931; Wed, 18 Nov 2026
 10:41:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-31-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-31-0bb471f4d1e0@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 18 Nov 2026 19:41:00 +0100
X-Gm-Features: AclHuK-cPeRUfXFPCNpoPmGpgyemnlwhy9ru1g4By96l8JpK0Ex7CrwgDz58eaE
Message-ID: <CABdCQ=N1=+btSfX3LPKHzshem+3V4OqrE+b=yMmH4GT6K6pP1Q@mail.gmail.com>
Subject: Re: [PATCH v2 31/64] drm/st7920: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

The ST7920 driver changes look correct to me.

Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>

El lun, 16 nov 2026 a las 11:32, Maxime Ripard (<mripard@kernel.org>) escri=
bi=C3=B3:
>
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/gpu/drm/sitronix/st7920.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix=
/st7920.c
> index 2f2c808e783b..616d83387d31 100644
> --- a/drivers/gpu/drm/sitronix/st7920.c
> +++ b/drivers/gpu/drm/sitronix/st7920.c
> @@ -782,13 +782,11 @@ static int st7920_init_modeset(struct st7920_device=
 *st7920)
>         if (ret) {
>                 drm_err(drm, "DRM attach connector to encoder failed: %d\=
n", ret);
>                 return ret;
>         }
>
> -       drm_mode_config_reset(drm);
> -
> -       return 0;
> +       return drm_mode_config_create_initial_state(drm);
>  }
>
>  static int st7920_probe(struct spi_device *spi)
>  {
>         struct st7920_device *st7920;
>
> --
> 2.56.1
>

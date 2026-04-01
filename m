Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D56D35162
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59D710EDB0;
	Wed,  1 Apr 2026 11:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GBldqoMH";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85A710EDB0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:42:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8C796C5996B;
 Wed,  1 Apr 2026 11:43:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7D8AD602BF;
 Wed,  1 Apr 2026 11:42:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2518F104500F4; 
 Wed,  1 Apr 2026 13:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775043761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/SDde3CKjIl9YJ6WkA/ImrWM14npMrUWklnYCvT6vC0=;
 b=GBldqoMHViCaqIISYy/aWfO6VMXU4aZhApUcSqJWWVoZ5lNMtB+eU1iyo/S/OfZJy3Bqm0
 4/dQiY8PP8KY1+7dKGsij0dNk92x4pgFyjwWukFPgUXs2qyiCRnGx0Qj1CtYV1rKeCXV5v
 u51L5w0uYvVMg8Y3Lw5C2jtnxreFgHFyum1N2KCAvUZ2jE8C+A4LuJCuv0RZ1zfd4gjepm
 RZqB9vZQ3oRhag6gB+uib8gfhsym+oSy8YbGZniR26HyQQJChykVB3PvmirNmZgm6Bn8o7
 9tox4i6sCYGyvdVDVpBxMdj330TPj73/Q+V2qR3t7cwAdppfVJgIySvgo+cP6g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 13:42:34 +0200
Message-Id: <DHHSHVCVVHRF.2IH5N8N15OAU3@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm: Rename drm_atomic_state
Cc: "Jani Nikula" <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Rob Clark" <robin.clark@oss.qualcomm.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>, "Simona Vetter" <simona.vetter@ffwll.ch>
To: "Maxime Ripard" <mripard@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Jonathan Corbet" <corbet@lwn.net>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260331-drm-drm-atomic-update-v2-0-7e8fe6ddcd32@kernel.org>
 <20260331-drm-drm-atomic-update-v2-1-7e8fe6ddcd32@kernel.org>
In-Reply-To: <20260331-drm-drm-atomic-update-v2-1-7e8fe6ddcd32@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Maxime,

On Tue Mar 31, 2026 at 4:41 PM CEST, Maxime Ripard wrote:
> The KMS framework uses two slightly different definitions for the state
> concept. For a given object (plane, CRTC, encoder, etc., so
> drm_$OBJECT_state), the state is the entire state of that object.
> However, at the device level, drm_atomic_state refers to a state update
> for a limited number of objects.
>
> Thus, drm_atomic_state isn't the entire device state, but only the full
> state of some objects in that device. This has been an endless source of
> confusion and thus bugs.
>
> We can rename drm_atomic_state to drm_atomic_commit to make it less
> confusing.
>
> This patch was created using:
>
> rg -l drm_atomic_state | \
> 	xargs sed -i 's/drm_atomic_state/drm_atomic_commit/g; s/drm_atomic_commi=
t_helper/drm_atomic_state_helper/g'
> mv drivers/gpu/drm/tests/drm_atomic_state_test.c drivers/gpu/drm/tests/dr=
m_atomic_commit_test.c
>
> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

And with a couple minor tweaks to apply on my work branch based on
v7.0-rc6:
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

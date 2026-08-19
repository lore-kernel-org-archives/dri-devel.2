Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55847C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7798B10E177;
	Wed, 19 Aug 2026 17:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RBHx1zGa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3204910E177
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:27:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC30B43429;
 Wed, 19 Aug 2026 17:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AC71F000E9;
 Wed, 19 Aug 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787160458;
 bh=wXq6SKt+FtBNsYMZsNTqkqfjgrn7ufwQngSo6UuU9w4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RBHx1zGaA52GzIBmoxadXVh2AfXxGESEjJgjFORRDblng+e1DuFAuCVHBx1wlYccI
 q6GphQHa85OrSnxeCZ8FXWpGgg7fpOHP0rNw1PWZSyLCRskydP/Hfr1DGTOGWS98me
 0fm+7CGVM+fwg7l6OrkjFbPTM4/UgzvtFX7FjU8ZUDxFQnGolD+xDxU3D2QeCVGDeS
 /xZ9koTYiQOE4zE+w0lRCvzKyxjwelxOFbX/GlwEFld8Y1kZEtJl84UQftc+uH5UEw
 0/5IBQYgpNDkNlbfvW+sZeaGM2udJlTcET+g4QVo2tyeRr7WOg4q7aeX3JiukVp9il
 CRk/3py00Z8Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC
 HDMI codec
To: "Ivaylo Dimitrov" <ivo.g.dimitrov.75@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
References: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 17:27:38 +0000
Message-Id: <20260819172738.90AC71F000E9@smtp.kernel.org>
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
- [High] Manual driver unbinding via sysfs causes a data race and potential=
 use-after-free because `omap_hdmi_audio_remove()` modifies `ha->audio_hpd`=
 without `audio_lock` synchronization.
--

--- Patch [1]: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC =
HDMI codec ---
commit c1e30662f9b8ea5c3f0c3b715617c1dbc5447474
Author: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

This commit adds an optional HPD callback to omap_hdmi_audio_pdata to
report HDMI cable hotplug events to ASoC. It updates the DRM HDMI bridge
to invoke this callback when the connector status changes, allowing user
space to detect audio availability.

> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index e60f5b483fc57..90ce12a812468 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c
[ ... ]
> @@ -371,28 +402,44 @@ static int omap_hdmi_audio_probe(struct platform_de=
vice *pdev)
[ ... ]
> +static void omap_hdmi_audio_remove(struct platform_device *pdev)
> +{
> +	struct omap_hdmi_audio_pdata *ha =3D pdev->dev.platform_data;
> +
> +	/*
> +	 * hdmi4_unbind() holds audio lock across platform_device_unregister(),
> +	 * so audio_hpd() cannot run concurrently with this callback.
> +	 */
> +	ha->audio_hpd =3D NULL;
> +}

[Severity: High]
Can a manual driver unbind via sysfs cause a data race and potential
use-after-free here?

While the comment notes that hdmi4_unbind() holds the audio_lock, an
administrator can unbind the driver directly via sysfs
(/sys/bus/platform/drivers/omap-hdmi-audio/unbind). If this happens,
omap_hdmi_audio_remove() will execute without holding the audio_lock.

Concurrently, if an HDMI hotplug event triggers hdmi_audio_hpd_notify(), it
could read a valid ha->audio_hpd pointer because the lock isn't held here.
Once omap_hdmi_audio_remove() completes, devres frees the driver data,
and the racing hdmi_audio_hpd_notify() would execute the callback using that
freed memory.

Should ha->audio_hpd be cleared under the protection of audio_lock, or is
there another mechanism to prevent this sysfs unbind race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819171935.2339=
46-1-ivo.g.dimitrov.75@gmail.com?part=3D1

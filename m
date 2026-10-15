Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9543CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6F710E206;
	Thu, 15 Oct 2026 17:09:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A6B10E206
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:09:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C80C043A6D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8194E1F000C4;
 Thu, 15 Oct 2026 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792084162;
 bh=bVQ8ZiVD1I6xqJsGEc5htz7FtE5EOVqrJSaCNSt3GKA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A/1p6Dg7t9YmXSyAQ4LSVOrpDUTRX/S5+mz17u54dI09Fc70G7lZpJy1wmhcVoOM1
 AmAvJmNgB++OupdqBpxPaMu4Uyp9h2G1aSiAc0WxIuTIoOcD3UMXGde3PQO0IhhiWy
 CgVem3IPTf7MSzGbpwz5IQN9ndqOKlLf+HPuvRwCQqrdR3LA41kRgn2vgRNbyvUj9b
 BDRHWhEj3e2tYv1jf4U6N6QnRd2LkL6nt3AxAdwtvwQ6MzGCNlIqAhBNQGHlwjD/7e
 ZAjElF0HPcQtukMT9wSrgSRNNTioWpUJKXtYYmGjYfDW+fNC57eTcTNRSDwQW5Gisc
 8KCE3U2MbRduA==
Message-ID: <sashiko-outbox-173241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/28] drm/tidss: Implement hw_reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-25-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-25-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:09:22 +0000
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
- [High] drm/tidss: Missing hw_reset invocation and PM runtime API violation
--

commit 03dacf0e68abfb247fcee4bcb84fa7f48104c834
Author: Maxime Ripard <mripard@kernel.org>
drm/tidss: Implement hw_reset

This commit renames dispc_init_hw() to dispc_reset_hw() and removes its
unconditional call from dispc_init(), instead implementing a hw_reset hook
in drm_mode_config_funcs.

> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/ti=
dss_kms.c
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
[ ... ]
> @@ -116,10 +117,23 @@ static int tidss_atomic_check(struct drm_device *dd=
ev,
>  	return 0;
>  }
> =20
> +static void tidss_hw_reset(struct drm_device *dev)
> +{
> +	struct tidss_device *tidss =3D to_tidss(dev);
> +	int ret;
> +
> +	ret =3D dispc_reset_hw(tidss->dispc);

[Severity: High]
Will this hw_reset hook actually get called during initialization?

Looking at the driver's probe sequence in tidss_probe(), the driver calls
drm_mode_config_reset(). This function ignores the mode_config_funcs.hw_res=
et
hook. Because the patch removes the unconditional call to the hardware reset
function in dispc_init(), does this leave the display controller in an
unknown state without ever resetting it?

Additionally, if the hook were invoked, would pm_runtime_set_active() fail?

In the probe path, runtime PM is enabled before the DRM state is fully
initialized:

drivers/gpu/drm/tidss/tidss_drv.c:tidss_probe() {
    ...
    pm_runtime_enable(dev);
    ...
    drm_mode_config_reset(ddev);
    ...
}

If dispc_reset_hw() runs while runtime PM is enabled, its internal call to
pm_runtime_set_active(dev) will return -EAGAIN because the disable_depth is
zero. This failure would cause dispc_reset_hw() to return early before call=
ing
dispc_softreset(). Can this bypass the actual hardware soft reset completely
even if the hook is reached?

> +	if (ret)
> +		drm_warn(dev, "Couldn't reset dispc");
> +
> +	drm_mode_config_helper_hw_reset(dev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D25

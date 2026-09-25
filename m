Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04401C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6169210E263;
	Fri, 25 Sep 2026 18:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bDWUf+n/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D3F10E263
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:58:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0003F41A59;
 Fri, 25 Sep 2026 18:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2BC1F000FF;
 Fri, 25 Sep 2026 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790362706;
 bh=q5XMxNdY+REj7PrmhtYfhajhEUp16XWJ54A4LubCZkk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bDWUf+n/1Yf5W2HNJfa44t5s2KGta+7e2sZREmqrhlqu4iwBU8xzjhNBARH/Sgzdk
 ABQykmAIyR+O/ICHo+lJVt95dVJ33kGu1qm3ECOMlr+3ro1ViF55Bt+aJ7St1fY4kg
 ON48htxICcPT/jzddeksKFoxB0wSDDgNakHtujlNetoBWLwRFQd+x3IjhQUmIaMzkA
 gWUcNmllmo8hexW/KwK59VGpVP6nX3SczP49hG3twRq3LuJeTcAEMpP0XGwVJQAzWD
 G2916M66aAB3iKvHsgHNzv/uOJVSBVBz0g2YDOJQzopkCi5LOnRK4gHyyAS68Y9ySR
 4J5seINqauuxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/15] drm/panfrost: Move all DRM device
 initialisation into device_init()
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260925-claude-fixes-v11-8-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
 <20260925-claude-fixes-v11-8-0dbf5a58e7ce@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:58:26 +0000
Message-Id: <20260925185826.AD2BC1F000FF@smtp.kernel.org>
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
- [High] pm_runtime: usage_count corruption on early probe failure
--

commit 83a4c1b15f0bb7a999d8fbc11545b9b267d7fbdf
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move all DRM device initialisation into device_init()

This commit moves DRM device registration and runtime PM setup from
panfrost_probe() into panfrost_device_init(), and consolidates the
cleanup path into panfrost_device_fini().

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 9f2b1967a3984..b8094c0d12528 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> @@ -311,11 +343,22 @@ int panfrost_device_init(struct panfrost_device *pf=
dev)
>  	panfrost_reset_fini(pfdev);
>  out_pm_domain:
>  	panfrost_pm_domain_fini(pfdev);
> +
> +	if (pm_runtime_active(pfdev->base.dev)) {
> +		pm_runtime_set_suspended(pfdev->base.dev);
> +		pm_runtime_put_noidle(pfdev->base.dev);
> +	}
> +

[Severity: High]
Can this catch-all conditional block cause a PM runtime usage_count corrupt=
ion
on early probe failures?

If sysfs power/control is set to 'on' (e.g., via udev rules before probe),
pm_runtime_forbid() increments the usage_count to 1.

If the driver then fails early in panfrost_device_init() (such as a probe
deferral during panfrost_clk_init()), pm_runtime_enable() has not been call=
ed
yet. This leaves dev->power.disable_depth at 1, which inherently causes
pm_runtime_active() to return true.

This would cause the error path to incorrectly assume the driver acquired t=
he
PM reference, calling pm_runtime_put_noidle() and erroneously decrementing
the usage_count to 0.

When userspace later sets power/control to 'auto', pm_runtime_allow() would
decrement the usage_count again, underflowing it to -1 and permanently brea=
king
runtime PM for the device.

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-claude-fix=
es-v11-0-0dbf5a58e7ce@collabora.com?part=3D8

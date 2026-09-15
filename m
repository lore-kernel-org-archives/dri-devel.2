Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FF8C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48C810ED9D;
	Tue, 15 Sep 2026 15:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CyllVRyV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C766310ED9D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:44:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC4E0600D1;
 Tue, 15 Sep 2026 15:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DE91F000FF;
 Tue, 15 Sep 2026 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789487061;
 bh=WgCqCrUZSkqdjRCU1o3q/FLPXpvAuImoRHsybLFffg0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CyllVRyVxXF7DxuPZckfjzCPBAB9QayLE187PkFja5TRn0szrz/k7lA0tYtszFOmh
 DVyFikJWXGgsLb0E3IBxMK6kK/pMkrwIl6Rp3347La2RpONTaoRorC5/sQjeLmyHLN
 cFrobng9CQE0y7oaTRW4Yq77NSDqeceZlN/scE4HQN8AL8N738tak8hmXPuEYU51V/
 mUvHUvowYPNlcU9PVECM0TxuHxcp04y2uSOWUI92ADvclAZacFmXQYY8J46jHGASJR
 xppWyWbtuxPWgREx8LxZmhVNa87UzDs6LqxmMTOXEeSjyk/wJdB0P7gEwt+0YIVZVQ
 KmCMu9R9VX2Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/20] drm/bridge: inno-hdmi: Split probe out of bind
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: conor+dt@kernel.org, neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org,
 vkoul@kernel.org, lee@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-7-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153226eucas1p1d69e9e853b4b5cfb1d42c2c585b57f95@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-7-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:44:20 +0000
Message-Id: <20260915154420.95DE91F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/bridge: inno-hdmi: Meaningful code and commit message mismat=
ch for inno_hdmi_remove()
- [Medium] drm/bridge: inno-hdmi: TOCTOU race on hdmi->bridge.dev leading t=
o potential NULL pointer dereference
--

commit 619d70bf74f8f0e498489e8aa8a7c0c9e4e2d3fb
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Split probe out of bind

This commit splits the bridge setup into a new exported inno_hdmi_probe()
function and reduces inno_hdmi_bind() to a wrapper around it. This
decoupling allows a platform device to register its own bridge without
attaching it to the DRM encoder immediately.

>     Move the setup into a new exported inno_hdmi_probe(), with a matching
>     inno_hdmi_remove(), and reduce inno_hdmi_bind() to a wrapper around i=
t.

[Severity: Medium]
Is the commit message description accurate regarding the removal function?

The commit message explicitly claims to introduce a matching
inno_hdmi_remove() function for teardown alongside inno_hdmi_probe(), but
this function appears to be missing from the patch. Does this break the
expected API contract described for external decoupled drivers?

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index dd35f5a875d3d..840f1c7bc2029 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -929,7 +929,14 @@ static irqreturn_t inno_hdmi_irq(int irq, void *dev_=
id)
>  {
>  	struct inno_hdmi *hdmi =3D dev_id;
> =20
> -	drm_helper_hpd_irq_event(hdmi->bridge.dev);
> +	/*
> +	 * The interrupt is requested in probe, but bridge.dev is only set once
> +	 * the DRM master binds and attaches the bridge, which may never happen.
> +	 * Drop hotplug events that arrive before then rather than dereference a
> +	 * NULL drm_device.
> +	 */
> +	if (hdmi->bridge.dev)
> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);

[Severity: Medium]
Can this lockless check of hdmi->bridge.dev lead to a NULL pointer
dereference?

Without READ_ONCE(), the compiler might double-fetch the pointer. If the
pointer is cleared concurrently (for example, during a failed
drm_bridge_attach() or a teardown path) after the check but before it is
passed to drm_helper_hpd_irq_event(), it could result in a NULL pointer
dereference.

Could we use READ_ONCE() and a local variable to prevent a potential race
condition in inno_hdmi_irq()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D7

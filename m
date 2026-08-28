Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308DAC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4B010E1D7;
	Fri, 28 Aug 2026 09:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RlQf1rLJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6710B10E1D7
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:25:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5AAD43796;
 Fri, 28 Aug 2026 09:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7720A1F000E9;
 Fri, 28 Aug 2026 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787909128;
 bh=c2kvSh2/ELWEywx8INAdI2eJCL/7HoLQC3vS4clKbWw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RlQf1rLJ7iXC+ka+iY74uY81662HIYeAvymaCiTic9hE2E6gjxTfJK5rTbfrDaZMR
 eavnktkiT20cTzhKFbq0nLiU2rAKN6Nu/rWHm944u3sfTJoNLMPn8IpXNwF+dd2R/J
 s1GKnSMQtVqghjSsNott2WRtyWn6rFH2g4Zz/Xnby4D/UQfEJell4heHOGhs63zMWa
 nChmBgTvAZ7R4dq+GE2fM1GQZwwmDyVmxk8lp1+lDpSl+xxs0Jpk5VUmKF/jRS5UGX
 5dLeQKcr8G3VU2bG5rexMWsUXvOgcldBDGKD/YHd5lObAQvo0gCMhM79FyaT6gTS8t
 ukH+Ld19XysHw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/meson: dw-hdmi: Propagate reset failures during
 initialization
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260828091424.6375-1-pengpeng@iscas.ac.cn>
References: <20260828091424.6375-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:25:28 +0000
Message-Id: <20260828092528.7720A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The shared IRQ handler is registered before the hardware is fully =
initialized, risking a NULL pointer dereference if initialization fails.
- [High] Component bind error paths permanently leak `devm_` allocated reso=
urces.
--

commit f74bf01d3ded8b1822f2278b49d5f000e0d72a6b
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/meson: dw-hdmi: Propagate reset failures during initialization

This commit updates meson_dw_hdmi_init() to propagate reset errors instead
of ignoring them. It also updates the bind and resume paths to abort if
initialization fails.

> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meso=
n/meson_dw_hdmi.c
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c

[ ... ]

> @@ -754,7 +764,9 @@ static int meson_dw_hdmi_bind(struct device *dev, str=
uct device *master,
>  		return ret;
>  	}
> =20
> -	meson_dw_hdmi_init(meson_dw_hdmi);
> +	ret =3D meson_dw_hdmi_init(meson_dw_hdmi);
> +	if (ret)
> +		return ret;

[Severity: High]
This is a pre-existing issue, but does this new error path expose us to a
NULL pointer dereference from the shared IRQ?

Earlier in meson_dw_hdmi_bind(), a shared IRQ is requested using a devm_
function:

	ret =3D devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
					dw_hdmi_top_thread_irq, IRQF_SHARED,
					"dw_hdmi_top_irq", meson_dw_hdmi);

If meson_dw_hdmi_init() fails and returns early here, the IRQ remains active
because its lifetime is tied to the platform device, not the bind lifecycle.
If the shared IRQ fires, dw_hdmi_top_thread_irq() unconditionally=20
dereferences dw_hdmi->hdmi and dw_hdmi->bridge, which will be NULL since
dw_hdmi_probe() was skipped.

[Severity: High]
This isn't a bug introduced by this patch, but does returning early here
also cause unbounded resource leaks?

Because meson_dw_hdmi_bind() is a component bind function, it runs
repeatedly on deferred probe or unbind/bind cycles. It allocates resources
using devm_ allocation functions, such as:

	meson_dw_hdmi =3D devm_kzalloc(dev, sizeof(*meson_dw_hdmi),
				     GFP_KERNEL);

If this bind operation fails at meson_dw_hdmi_init(), these devm_ resources
are not automatically freed since the underlying platform device is not
destroyed. Can this lead to memory and IRQ exhaustion over time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828091424.6375=
-1-pengpeng@iscas.ac.cn?part=3D1

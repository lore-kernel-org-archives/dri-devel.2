Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AC3C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741A910ED75;
	Tue, 15 Sep 2026 15:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FWoFG9h8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC38F10ED75
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:43:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B573D40183;
 Tue, 15 Sep 2026 15:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07CD1F000FF;
 Tue, 15 Sep 2026 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486983;
 bh=/Q+TKB0dTqPeN8L0VQL0IxsQ2XnGw89/lImhUA0TRIc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FWoFG9h81W+EkeK6xWljLNGhi+4q24AllFDgLT9ezExiwRZj9G8qbHkRePJo+7VL+
 YTbDGrwWdrikTHq6JsHf9EAERMMq6nazGfDxgx9UPbk/OvyJ7qaNpwon+330J+G67h
 UgU00QlM4ZwrbAjfZtwwpzsDAk3gSk+oS6dlx67YrMZDPLHs7eGby3nUIOhvtzsSmP
 mRyQ9RVjZ3tKQwrMLOQGQXpRqJgCRIDnrdDCJwy3Mx/TMJI6WPvuROLSRrnkatSeVW
 SEREuibAJD8pc607CF+dQ0o/8oPZJcpELssrY1oQYmI4/T/oeuCtmnpPRcsDRHl6Sq
 PG8Z8Do4o3nwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/20] drm/bridge: inno-hdmi: Add .disable platform
 operation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org,
 olteanv@gmail.com, robh@kernel.org, mfd@lists.linux.dev,
 linux-phy@lists.infradead.org, vkoul@kernel.org, linux-clk@vger.kernel.org,
 neil.armstrong@linaro.org, conor+dt@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-9-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153229eucas1p2d1b02b6f3871d6b536f678b9ea293c1c@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-9-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:43:02 +0000
Message-Id: <20260915154302.F07CD1F000FF@smtp.kernel.org>
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
- [High] drm/bridge: inno-hdmi: sleep in atomic context via .disable hook
- [Medium] drm/bridge: inno-hdmi: hardware teardown LIFO ordering violation
--

commit f7201b9edd5364bfbb0fe7f6dfc6706a0f43adf3
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Add .disable platform operation

This commit introduces a new .disable platform operation to the Innosilicon
HDMI driver and invokes it in inno_hdmi_bridge_atomic_disable(). It allows
platform-specific drivers to implement power down sequences for PHYs and
clocks.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 1264152fb1434..06917e83c5e53 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -886,6 +886,10 @@ static void inno_hdmi_bridge_atomic_disable(struct d=
rm_bridge *bridge,
>  					    struct drm_atomic_commit *state)
>  {
>  	struct inno_hdmi *hdmi =3D bridge_to_inno_hdmi(bridge);
> +	const struct inno_hdmi_plat_ops *plat_ops =3D hdmi->plat_data->ops;
> +
> +	if (plat_ops && plat_ops->disable)
> +		plat_ops->disable(hdmi->dev);

[Severity: High]
Does this code introduce a sleep in atomic context? The
inno_hdmi_bridge_atomic_disable() function runs from
drm_atomic_helper_commit_tail(), which is an atomic context where sleeping =
is
strictly forbidden. However, the commit message mentions this hook is meant
for calling phy_power_off() and clk_disable_unprepare(), which can sleep.

[Severity: Medium]
Will this break LIFO teardown ordering? Disabling the platform PHY and cloc=
ks
via plat_ops->disable() before calling inno_hdmi_standby() leaves the inter=
nal
HDMI controller configured while its underlying hardware is powered down. To
maintain proper LIFO ordering, shouldn't inno_hdmi_standby() be called first
to put the internal PHY registers in standby before disabling the platform
clocks and PHY?

> =20
>  	inno_hdmi_standby(hdmi);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D9

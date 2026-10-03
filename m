Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA55CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5853F10E04A;
	Sat,  3 Oct 2026 08:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lKxnvOI7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3D410E04A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 08:20:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07F7F4388F;
 Sat,  3 Oct 2026 08:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A21F0089B;
 Sat,  3 Oct 2026 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791015651;
 bh=xEP0HGuLEdqvHIz7JX+OumibFSBPQsMdFACoja808uU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lKxnvOI72cNHHCz1wIGkV85yHffu9cg1AboBTXbg83h+ixW+4ykW5DgX3FPre+PpQ
 dRqNXT+4FPCBDwCavbWQMp6Vab3ZbF+kn+lJbmsz8pQMnHIpApP6Nk+J0QbnlGQHN8
 PMZ+aA4a/Z7b+Ko3o2KMNc9J2oQHEkn3MVg3ACFPVoe7KyLchu+e5zVEqM137Htlle
 5j6qnIGVlhqC73jTxTogEnO4Eh6kWdcL4q+HlSlm8jGvIQzPDQ1EqfT27rtNav13q5
 Z+g8lvrQ++Ea1k8/lMBjuB0T+akWtx+E/hTWCr604B2ZZ7in9fML/2jSVwJOhoXJUS
 CjUHDhYBW1G7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/hdmi: handle runtime resume failure during
 power on
To: "Jiale Yao" <yaojiale02@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003081109.432470-1-yaojiale02@163.com>
References: <20261003081109.432470-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:20:51 +0000
Message-Id: <20261003082051.B36A21F0089B@smtp.kernel.org>
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
- [High] drm/msm/hdmi: system crash in post_disable on unclocked MMIO due t=
o pre_enable error path
--

commit 15a43ff6d8f2324644d0916454344e0a91654014
Author: Jiale Yao <yaojiale02@163.com>

drm/msm/hdmi: handle runtime resume failure during power on

This commit attempts to handle runtime PM failures in msm_hdmi_power_on() by
returning errors to msm_hdmi_bridge_atomic_pre_enable(). It unwinds the PHY
resources and aborts the sequence early if power-on or PHY resource enablem=
ent
fails.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> index 157f19bd90b4e..7d88657be0473 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
[ ... ]
> @@ -289,8 +294,16 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct=
 drm_bridge *bridge,
> =20
>  	mutex_lock(&hdmi->state_mutex);
>  	if (!hdmi->power_on) {
> -		msm_hdmi_phy_resource_enable(phy);
> -		msm_hdmi_power_on(bridge);
> +		ret =3D msm_hdmi_phy_resource_enable(phy);
> +		if (ret)
> +			goto unlock;
> +
> +		ret =3D msm_hdmi_power_on(bridge);
> +		if (ret) {
> +			msm_hdmi_phy_resource_disable(phy);
> +			goto unlock;
> +		}
> +

[Severity: High]
Does this error path lead to a system crash later during teardown?

If msm_hdmi_power_on() fails, this new path turns off the PHY resources and
jumps to the unlock label, leaving hdmi->power_on =3D false. However,
msm_hdmi_bridge_atomic_pre_enable() returns void, so the DRM core is unaware
of the failure and assumes the display pipeline was successfully enabled.

When the DRM core later tears down the pipeline, it will call
msm_hdmi_bridge_atomic_post_disable(). Looking at that function:

drivers/gpu/drm/msm/hdmi/hdmi_bridge.c:msm_hdmi_bridge_atomic_post_disable(=
) {
	...
	/* Keep the HDMI enabled if the HPD is enabled */
	mutex_lock(&hdmi->state_mutex);
	msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);

	msm_hdmi_phy_powerdown(phy);

	if (hdmi->power_on) {
	...
}

These MMIO writes in msm_hdmi_set_mode() and msm_hdmi_phy_powerdown() are
executed unconditionally, before the hdmi->power_on check.

Because the clocks were never enabled (or were disabled during this error
unwind), will these unconditional MMIO writes cause a system crash
(Synchronous External Abort) by accessing unclocked hardware?

>  		hdmi->power_on =3D true;
>  	}
>  	mutex_unlock(&hdmi->state_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003081109.4324=
70-1-yaojiale02@163.com?part=3D1

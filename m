Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8678C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DFF10E0D5;
	Wed, 16 Sep 2026 10:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ok3MbPof";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BE610E0D5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:29:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2A7143DEF;
 Wed, 16 Sep 2026 10:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A821F00899;
 Wed, 16 Sep 2026 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789554587;
 bh=EERVotOWiM+ZUuTAtSVUx9c8lfIv/u6Z0yalyr+fIHQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ok3MbPofYCoMmnadLYg0SQP9TzBHmhAFDoMeXfRt0S+SpF7z4jayqqJTLviR+kiVe
 gBVoqaq5MY5JUZkXWZXbUYBOO+nxYIGIdw/eL/k4NS7dM6yh/3z7uO/QoZCTbSGBdr
 CB9w6O/UzkR/358tNImOkFgiqUAtNLVf6huI1SUlAfiVduKxHxh+aXeO5biViLLf1T
 5/7HFnky7XADtJElZUbMb2JRAP+/+rGMzt/0TMNgYBEYCYwEBpWyH/Iu5xOKeODSIj
 Mg3wFCdcKY5whWW0MnIIiBpWOAK9OJ0fumRoI1L5FmCuQds//qST8TokidQWEwKH2X
 WH6qi3URfmzpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mali-dp: Fix runtime PM leak in
 malidp_crtc_atomic_enable()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916102112.2018372-1-vulab@iscas.ac.cn>
References: <20260916102112.2018372-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:29:47 +0000
Message-Id: <20260916102947.C1A821F00899@smtp.kernel.org>
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
- [High] drm/malidp: runtime PM usage counter underflow in malidp_crtc_atom=
ic_disable()
--

commit 3492dcc2c28d3962cf4a64dc34d1fb164aaf6580
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/mali-dp: Fix runtime PM leak in malidp_crtc_atomic_enable()

This patch drops the runtime PM reference with pm_runtime_put_noidle() on
the resume failure path in malidp_crtc_atomic_enable(). This is intended
to fix a reference leak when pm_runtime_get_sync() fails.

> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/mali=
dp_crtc.c
> index 157ff148efe7a..ec7b9db8b0b45 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -56,6 +56,7 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *=
crtc,
> =20
>  	if (err < 0) {
>  		DRM_DEBUG_DRIVER("Failed to enable runtime power management: %d\n", er=
r);
> +		pm_runtime_put_noidle(crtc->dev->dev);

[Severity: High]
Could this addition cause a runtime PM usage counter underflow when the CRTC
is later disabled?

Because malidp_crtc_atomic_enable() returns void, the DRM core still
considers the CRTC active even if it returns early on error here. When the
CRTC is later disabled, malidp_crtc_atomic_disable() will be unconditionally
called, which executes its own pm_runtime_put():

drivers/gpu/drm/arm/malidp_crtc.c:malidp_crtc_atomic_disable() {
	...
	clk_disable_unprepare(hwdev->pxlclk);

	pm_runtime_put(crtc->dev->dev);
}

If we drop the PM reference here on the error path, wouldn't the later call
to pm_runtime_put() in malidp_crtc_atomic_disable() result in a double-put
and underflow the PM usage counter?

>  		return;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916102112.2018=
372-1-vulab@iscas.ac.cn?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB501C43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E7810E071;
	Mon, 29 Jun 2026 13:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VlqwNP7J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0274410E071
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:26:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DBAF2416D2;
 Mon, 29 Jun 2026 13:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0421F00AC4;
 Mon, 29 Jun 2026 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782739614;
 bh=pxyRC56075cSAcyK9bTuWIDaAiS0X8JfUkQ0T7vGOQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VlqwNP7JVA+zH4teZG5zy7ZshyEI8lJUqLlFkRWXZ0kJF1zyPgePkPAkyuEnGDJ5V
 zgNHJOZVyU62+dWJ2IjTwHaxkf+Q3h6GrZOBmoMmIDO6jMXl9WwuZNBn4KlU2bXj5h
 kasMD2aTbI6wxhT/Re9i1kQ9H5/bTx4/t1lSLzu/PtBa5DxwS30ucoqScWaPnJHnYZ
 2ULMFtLH5N+DYztVIiAdFyX7eTQ2Ez26xORDEHg2U+xMnZta0jSFRiqsMIsd3J+JPe
 fXbtCS3WxwjrYKesI8xBo7Yx3/MgIlwgZEt53VpAsKeMv7MkqgVBLApzB2GLDggYMk
 T1AYaBfTLld/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/powerplay: add NULL check for vega10_ps
To: "Markov Gleb" <markov.gi@npc-ksb.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629130951.763-1-markov.gi@npc-ksb.ru>
References: <20260629130951.763-1-markov.gi@npc-ksb.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:26:54 +0000
Message-Id: <20260629132654.AB0421F00AC4@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch adds NULL checks for the Vega10 hardware manager but mis=
ses identical vulnerabilities in the SMU7 and SMU8 hardware managers.
--

commit 3281774cdb4d49d848f2310e1feaba91d2dc6884
Author: Gleb Markov <markov.gi@npc-ksb.ru>

drm/amd/powerplay: add NULL check for vega10_ps

This patch addresses SVACE static analyzer findings by adding NULL checks f=
or
the return value of cast_phw_vega10_power_state() in the Vega10 hardware
manager to prevent potential NULL pointer dereferences.

> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 076e10f265463..c81aa245b8a41 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3892,6 +3892,8 @@ static uint32_t vega10_dpm_get_sclk(struct pp_hwmgr=
 *hwmgr, bool low)
>  		return -EINVAL;
> =20
>  	vega10_ps =3D cast_phw_vega10_power_state(&ps->hardware);
> +	if (vega10_ps =3D=3D NULL)
> +		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but while you are addressing this
SVACE warning for Vega10, does the exact same missing NULL check pattern ex=
ist=20
in the SMU7 and SMU8 hardware managers?

For example, in drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c:smu7_dp=
m_get_sclk():

	smu7_ps =3D cast_phw_smu7_power_state(&ps->hardware);

	if (low)
		return smu7_ps->performance_levels[0].engine_clock;

And in drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c:smu8_dpm_get_scl=
k():

	smu8_ps =3D cast_smu8_power_state(&ps->hardware);

	if (low)
		return smu8_ps->levels[0].engineClock;

Should identical NULL checks be added to smu7_dpm_get_sclk(),
smu7_dpm_get_mclk(), smu8_dpm_get_sclk(), and smu8_dpm_patch_boot_state()
to ensure a complete fix across the subsystem and avoid kernel panics if
the power state magic number check fails?

> =20
>  	if (low)
>  		return vega10_ps->performance_levels[0].gfx_clock;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130951.763-=
1-markov.gi@npc-ksb.ru?part=3D1

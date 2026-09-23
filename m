Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6618AC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B735210E0C8;
	Wed, 23 Sep 2026 10:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyFqyums";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA5F10E0C8
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5AC4601FB;
 Wed, 23 Sep 2026 10:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410EA1F000FF;
 Wed, 23 Sep 2026 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790159684;
 bh=kZsyvIHTW1NuOG+YD2r/2d/LxsWBEQ6BZaMhmTAt/Tg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WyFqyumsmOUNk8sI1uxPb8K2aB6NJCCX5luXooAtw+yGeGb7btjICd/hv+GsHrOyz
 VI6TR2oZqw4wXLqeqyCYVTai/3IdKQngpOLffPM7y4Hg6iBArOBxxcnANyxhnjqbbR
 /HNDWrppCuQWZ7cc/HPlkodrEMKkOMufQAeHGTC3Yp7A7yhmFCw+YabeOeFy5ei4Yi
 EXkmfrRuPEJDP+EqozMiVeq9FtmBzfZIHlwVegTbJ3uZtKQFXGJMlHSRRz5Tuh36AM
 f+RlP8gi0TCLcxG8mdYoCO8WBPYvHJrKAMDC1zxCDXeFu/DjFe4pc95v+ZiuhXnDH8
 MBuWcQEyAxwxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/display/dsc: Add YCbCr 4:2:2 and 4:2:0 computation
 for DSC 1.2 RC parameters
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923102616.215-1-kernel@airkyi.com>
References: <20260923102616.215-1-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:34:43 +0000
Message-Id: <20260923103444.410EA1F000FF@smtp.kernel.org>
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
- [High] drm/dsc: incorrect second line BPG offset accumulation
--

commit b83356cde3094c64861089db4359f0b624aad6bd
Author: Chaoyi Chen <kernel@airkyi.com>

drm/display/dsc: Add YCbCr 4:2:2 and 4:2:0 computation for DSC 1.2 RC param=
eters

This commit updates drm_dsc_compute_rc_parameters() to compute rate control
parameters for DSC 1.2 in native 4:2:0 and 4:2:2 modes. It also introduces
__drm_dsc_compute_buffer_offset() to optimize the calculation of rbsMin
using the DSC 1.2 reference C model.

> diff --git a/drivers/gpu/drm/display/drm_dsc_helper.c b/drivers/gpu/drm/d=
isplay/drm_dsc_helper.c
> --- a/drivers/gpu/drm/display/drm_dsc_helper.c
> +++ b/drivers/gpu/drm/display/drm_dsc_helper.c
> @@ -1300,6 +1300,59 @@ int drm_dsc_setup_rc_params(struct drm_dsc_config =
*vdsc_cfg, enum drm_dsc_params
[ ... ]
> +static long
> +__drm_dsc_compute_buffer_offset(const struct drm_dsc_config *vdsc_cfg,
> +				unsigned long groups_per_line,
> +				unsigned long grpcnt)
> +{
[ ... ]
> +	if (vdsc_cfg->native_420) {
> +		if (grpcnt <=3D groups_per_line)
> +			offset -=3D (grpcnt * vdsc_cfg->nsl_bpg_offset) >> 11;
> +		else if (grpcnt <=3D 2 * groups_per_line)
> +			offset +=3D (grpcnt - groups_per_line) *
> +				   vdsc_cfg->second_line_bpg_offset -
> +				 ((groups_per_line *
> +				   vdsc_cfg->nsl_bpg_offset) >> 11);
> +		else
> +			offset +=3D (grpcnt - groups_per_line) *
> +				   vdsc_cfg->second_line_bpg_offset -
> +				 (((grpcnt - groups_per_line) *
> +				   vdsc_cfg->nsl_bpg_offset) >> 11);

[Severity: High]
Does this code inflate the accumulated offset for groups beyond the second
line?

In the branch where grpcnt > 2 * groups_per_line, the calculation multiplies
(grpcnt - groups_per_line) by vdsc_cfg->second_line_bpg_offset. Should this
be capped to groups_per_line * vdsc_cfg->second_line_bpg_offset instead?

When grpcnt_id is large (which is common for narrow slices), this unbounded
linear growth could significantly inflate the rate buffer size minimum
(rbs_min). This might result in invalid rate control parameters (rc_bits,
initial_dec_delay) and cause display configuration failures or corrupted
output when a 4:2:0 DSC-capable sink is connected.

> +	}
> +
> +	return offset;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923102616.215-=
1-kernel@airkyi.com?part=3D1

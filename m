Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE87C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5943010EDCF;
	Tue,  8 Sep 2026 22:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gT0lTUDL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C3B10EDCF
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:14:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1412E601F7
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FB61F00A3A;
 Tue,  8 Sep 2026 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905690;
 bh=d0YrgEDlrW8xLVuPxOAZ0aB85xwbZNwLQ69azGGfefI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gT0lTUDL+dcPGMob7eg/OJsjWVqSdK9ycF5is5TEQM5FbDfNnLOSjkpZXFgXbkmxl
 IHsmwb41Y9ZHlSwoCyAWdK2hmM7pytj/c7I5KtEReZ6mXKiG1/EtcFty1kNsw9gvk0
 ABq/2XzJ4bspxQGLTLZiyb5higGLnZ6MAFPQ7Pni5vFQWxlEejWcs5fEdn1CwtiCCO
 8lPuW3mjm5vauTPgshkJUNFtALd4vAXxeyKmUpGq2PmlsZJdUIZxHwEZHFWOduhkT0
 dTK87yOUWdW+ek9DASAhr/UYccUFaRFuLG0buMOKVAOQsqKj9Qc7YPdmA3F3o2zYzX
 BBFxvEBDnnOZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/22] accel: ethosu: Account for kernel dilation in
 IFM size
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-16-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-16-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:14:50 +0000
Message-Id: <20260908221450.94FB61F00A3A@smtp.kernel.org>
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
- [High] The driver under-estimates the required IFM memory bounds by impro=
perly subtracting padding (such as pad_right and pad_bottom), allowing a ma=
liciously crafted command stream to read out of bounds.
--

commit 07909a86c51957cbbafa4aac05851fba1d3dae6d
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Account for kernel dilation in IFM size

The commit updates calc_sizes() in the Arm Ethos-U NPU driver to account
for kernel dilation settings when calculating the required input feature-map
bounds. It extracts x and y dilation from the kernel stride and multiplies
them with the IFM dimensions to prevent a command stream using dilation
from accessing IFM memory past the driver-validated range.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 9c86f9062f55e..578d1b5b955cf 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -567,10 +567,16 @@ static int calc_sizes(struct drm_device *ddev,
[ ... ]
>  		s32 ifm_height =3D st->ofm.height[2] * stride_y +
> -			st->ifm.height[2] - (st->ifm.pad_top + st->ifm.pad_bottom);
> +			st->ifm.height[2] * dilation_y -
> +			(st->ifm.pad_top + st->ifm.pad_bottom);
>  		s32 ifm_width =3D st->ofm.width * stride_x +
> -			st->ifm.width - (st->ifm.pad_left + st->ifm.pad_right);
> +			st->ifm.width * dilation_x -
> +			(st->ifm.pad_left + st->ifm.pad_right);

[Severity: High]
This is a pre-existing issue, but does this calculation under-estimate the
required IFM memory bounds by improperly subtracting padding parameters?

Since pad_top, pad_bottom, pad_left, and pad_right are user-provided
values (potentially up to 255), subtracting them here artificially reduces
ifm_height and ifm_width.

When feat_matrix_size() later validates the memory up to
min(ifm_width, fm->width0), this smaller ifm_width could allow a maliciously
crafted command stream to pass validation on a small buffer.

Meanwhile, the NPU hardware might access out of bounds up to the true
coordinate bounded by fm->width0. Could this lead to NPU crashes, page
faults, or information leaks from reading outside the allocated buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D16

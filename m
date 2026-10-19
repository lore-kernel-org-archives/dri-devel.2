Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD960AF795
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkL/REYz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873910E915;
	Mon, 19 Oct 2026 15:24:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD7110E915
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:24:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 893BC60261
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AF81F000C4;
 Mon, 19 Oct 2026 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423474;
 bh=yJDxX48q7inOlm6q3xK3W02w/kV9CNfSDlyGEVdxRAk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nkL/REYzhIZAYdSdWLBa1TftYzwsiXcfFN2zcyQ++Ox/nhBhHQ9H6YoQV18CQ1vhJ
 KWZlKApUhuLBcUB7rMO6m98P7VVEXNGU+/TaqlfO/jU+102fjh4e5agMAMdY/iFK3i
 KGKvlFHDlItM86xlJ5iGH7YQHBL0hkcN7boDshDoQvNzYGuLsWfY1n+/+AIqecfLoz
 B32FidtH/CYVRUOdCcYazVJhbxMJ/0wq2kYHhX+QebO2pye5wj7n/j+LD6qCsCON1r
 8QOBxsFTB6YczzljRQRHf/yWaSq1+ILB8Equ4S3ayxzSq05Lk3tu9FdTlWUjbchOnb
 UCHzmpd8jYWFg==
Message-ID: <sashiko-outbox-177709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/amdgpu/atomfirmware: WARN() rather
 than BUG()
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-461-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-461-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:24:33 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: missing error return in amdgpu_atomfirmware_get_cloc=
k_info()
--

commit 26bf4f616a4482a2f511b593f7d62e14678802b1
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/atomfirmware: WARN() rather than BUG()

This commit removes the BUG() call in amdgpu_atomfirmware_get_clock_info()
when encountering an unhandled VBIOS gfx_info table revision on CHIP_NAVI10
and newer ASICs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index c7d32fb216e4e..ce2a4a15d5ecb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -806,8 +806,6 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_=
device *adev)
>  				   (crev !=3D 6)) {
>  				spll->reference_freq =3D le32_to_cpu(gfx_info->v22.rlc_gpu_timer_ref=
clk);
>  				ret =3D 0;
> -			} else {
> -				BUG();
>  			}
>  		}
>  	}

[Severity: Medium]
The commit subject says "WARN() rather than BUG()" and the commit message
states "Just return an error", but simply removing the else branch neither
emits a warning nor returns an error.

Earlier in amdgpu_atomfirmware_get_clock_info(), parsing any of the
preceding VBIOS tables (firmwareinfo, smu_info, or umc_info) overwrites ret
from -EINVAL to 0:

drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c:amdgpu_atomfirmware_get_cl=
ock_info() {
	...
	if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
				   &frev, &crev, &data_offset)) {
		...
		adev->pm.current_sclk =3D adev->clock.default_sclk;
		adev->pm.current_mclk =3D adev->clock.default_mclk;

		ret =3D 0;
	}
	...
}

When amdgpu_device_init() -> amdgpu_atomfirmware_get_clock_info() runs on an
ASIC with adev->asic_type >=3D CHIP_NAVI10 and the VBIOS gfx_info table has=
 an
(frev, crev) combination other than frev =3D=3D 3 or frev =3D=3D 2 with cre=
v >=3D 2,
won't this now silently return 0 to amdgpu_device_init() while leaving
adev->clock.spll.reference_freq unupdated from gfx_info?

Should the else branch be kept to call WARN() and set ret =3D -EINVAL (or
return -EINVAL) so amdgpu_device_init() detects the failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-461-sashal@kernel.org?part=3D1

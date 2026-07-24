Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8BAC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6AB10F2E1;
	Fri, 24 Jul 2026 10:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PQpIp0sS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D23B10F2E1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:16:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49D5F600AA;
 Fri, 24 Jul 2026 10:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34371F000E9;
 Fri, 24 Jul 2026 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784888198;
 bh=/NT7JhmXr0FX7l64FBh4kHsGMm0jxLSlttVmo9QBrtA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PQpIp0sS9BCnxACCzpUS8o0NoVFo3m8nOglrvRmpM74Bbacn3aCHgFNI27r5IqsrB
 TOgwA0A+cEztBOIStYeB01JrsSSZ2Xcuof0FAajHzYvXvfR0yxz+GEVI/g08OcoAxM
 VGPOOiFaV6WfPMr6ir01bw9zR3E+I+eRcBKz90mHJGG9bU37zdwutbjapfaqabpox2
 cM4JbSLtdL7RvwR6pLF/q9geHnhcV+JmAec0zrkwuQogyHihsEEMPssBK6SESFfcMM
 om32WdkRuItLEU25wpeB/o9Lvq5YFb6hH1mj3Lf5ryKOgScqBAZzuvXgQLmgRn4AtM
 Jv/++7kNglUlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724100302.706685-7-mallesh.koujalagi@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-7-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:16:37 +0000
Message-Id: <20260724101637.C34371F000E9@smtp.kernel.org>
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
- [Medium] The newly added `DRM_WEDGE_RECOVERY_COLD_RESET` recovery method =
is not documented in the UAPI documentation.
--

--- Patch [1]: [PATCH v12 1/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recov=
ery method ---
commit 1acdd09ef42a2d7b1fde40c873937c144a20b544
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method

This commit introduces a new recovery method, DRM_WEDGE_RECOVERY_COLD_RESET,
to handle scenarios requiring a device power cycle. It adds the "cold-reset"
string mapping and the corresponding bit flag.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6aa..94abe7a811a52 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -537,6 +537,8 @@ static const char *drm_get_wedge_recovery(unsigned in=
t opt)
>  		return "bus-reset";
>  	case DRM_WEDGE_RECOVERY_VENDOR:
>  		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";

[Severity: Medium]
Should this new recovery method be documented in Documentation/gpu/drm-uapi=
.rst?

Looking at Documentation/gpu/drm-uapi.rst, there is a table mapping recovery
methods to consumer expectations:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
    Recovery method Consumer expectations
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
    none            optional telemetry collection
    rebind          unbind + bind driver
    bus-reset       unbind + bus reset/re-enumeration + bind
    vendor-specific vendor specific recovery method
    unknown         consumer policy
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Could "cold-reset" be missing from this UAPI documentation, leaving userspa=
ce
developers without a canonical reference for its expected consumer policies?

>  	default:
>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724100302.7066=
85-6-mallesh.koujalagi@intel.com?part=3D1

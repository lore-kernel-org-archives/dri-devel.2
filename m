Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710B7C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A257A10E292;
	Sat,  5 Sep 2026 18:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jv7gvk2t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051E610E292
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:19:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1436560258;
 Sat,  5 Sep 2026 18:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758761F00A3A;
 Sat,  5 Sep 2026 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632344;
 bh=GZnoa/Ltua/puirNwSlJjC0WN0HUAibpbFRq6VDz2GY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jv7gvk2tzOd/viTpG0auNWyGoV0MYIOscK9RcgllmzveM6gOzNTDApAquoZOdsObS
 MdDVY2kE5IEGXeyeFeQFT9AdEmI3/ZTefBzp18cw3PLaFKUJF7HjORN0iS209yr5DV
 DrWWlJGd8HHh29CxnEXo1Njdi5wsnzGDCZzNbjbDscFur3d4QveI8Z/6G4Jy5fm6Yh
 EBPR4+SSteAAW74GTfPNnOp/ZXv7FYVKPmXZWLfSV2fs0OuHH1Oi5IJSi6HpEj4MB9
 hoWtjIgaXxuj83js9wShJgQ16jVoBp3cppM3qiSXcD3THxozQjEGA9DQ/WkD5G4Tbl
 KmOD8EVhBRbyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/43] drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as
 unBROKEN
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-4-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-4-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:19:03 +0000
Message-Id: <20260905181904.758761F00A3A@smtp.kernel.org>
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
- [Medium] Undocumented behavior change: CONFIG_DRM_USE_DYNAMIC_DEBUG defau=
lt changed from 'n' to 'y'
--

commit 953ce8d396d765b26b3da8e90da715679595b8c2
Author: Jim Cromie <jim.cromie@gmail.com>

drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as unBROKEN

This commit removes the BROKEN dependency on CONFIG_DRM_USE_DYNAMIC_DEBUG,
allowing the configuration to be enabled for testing dynamic-debug-enabled
DRM drivers.

> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 1f4c98cbf0906..2f05bab1a7965 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -1,7 +1,6 @@
>  config DRM_USE_DYNAMIC_DEBUG
>  	bool "use dynamic debug to implement drm.debug"
> -	default n
> -	depends on BROKEN
> +	default y

[Severity: Medium]
The commit message mentions removing the BROKEN mark to allow enabling the
config, but it does not mention changing the default behavior to 'y'.

Since enabling this option introduces substantial .data overhead (~56 bytes
per callsite, resulting in hundreds of kilobytes of memory overhead for lar=
ge
drivers like amdgpu), could changing the default to 'y' cause unintended
memory footprint regressions for any default kernel build with DRM and
DYNAMIC_DEBUG enabled?

Should this remain 'default n' so that developers can opt-in, or should the
justification for 'default y' be added to the commit message?

>  	depends on DRM
>  	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
>  	depends on JUMP_LABEL

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D4

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE40C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3843F10F2F9;
	Fri, 28 Aug 2026 08:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qf92CfQI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120ED10E0E1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:56:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34C63601F7;
 Fri, 28 Aug 2026 08:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922FD1F000E9;
 Fri, 28 Aug 2026 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787907394;
 bh=K91hK6EiEK54KMzCCrvx+T2/sDYj5zsj9Wh5luVu3vQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qf92CfQI1MjPl2FTOwyAR8uJbIR2Y7jlIQvMF1b8uMQtTfUz+rXRTfL8EVG9HWCjN
 TPlGNC7ebh03xFoWpW5eCihHXmjM3jjVhpszRtNOpwCp0EzyStLXBDXiLCbLe2mBnZ
 CYnz5wP25pbnvb9X4l2rpPIEQ8edANFUprWoy25+i7KYHREo29K7iBFmExkQLsssWY
 kNMSs33n8hI3ZElRiItPnrz3GKFI2LHOv6/fP0g4vrVcgkz08Hbl9WgHCXuAXSMRpb
 ukPxPFywPH1J3DjoscpHMRsXOlWE+zLVzEGWSI0h5VTLSnxyp4LCDxcgESsJTlX+1C
 77rZv4cZMk4wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/7] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20260828084737.565-4-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
 <20260828084737.565-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:56:34 +0000
Message-Id: <20260828085634.922FD1F000E9@smtp.kernel.org>
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
- [Medium] Dependency inversion unconditionally loads USB Type-C subsystem =
on all DP-capable systems
--

commit 18e75df5599eb3c3479dc1002547dcf5f6a1593b
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/display: Add soft depend for aux-hpd-typec-dp-bridge module

This commit adds a soft dependency in the drm_display_helper module for the
aux-hpd-typec-dp-bridge module. This ensures the bridge module is loaded
early, as it serves as a generic Type-C DisplayPort HPD bridge that isn't
directly required by any other module.

> diff --git a/drivers/gpu/drm/display/drm_display_helper_mod.c b/drivers/g=
pu/drm/display/drm_display_helper_mod.c
> index d8a6e62287736..f0152d6b0b2d7 100644
> --- a/drivers/gpu/drm/display/drm_display_helper_mod.c
> +++ b/drivers/gpu/drm/display/drm_display_helper_mod.c
> @@ -18,5 +18,6 @@ static void __exit drm_display_helper_module_exit(void)
>  	drm_dp_aux_dev_exit();
>  }
> =20
> +MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge");

[Severity: Medium]
Does adding a soft dependency on aux-hpd-typec-dp-bridge to the core
drm_display_helper module create an architectural dependency inversion?

The leaf bridge driver (aux-hpd-typec-dp-bridge) has a hard dependency on t=
he
typec core subsystem because it registers a bus notifier on typec_bus. As a
result, when a system loads a DRM driver that utilizes generic display help=
ers
(such as amdgpu, i915, or nouveau), won't this unconditionally pull the ent=
ire
USB Type-C subsystem into memory?

This seems like it might waste memory resources on systems without Type-C
hardware by automatically loading aux-hpd-typec-dp-bridge.ko (and consequen=
tly
typec.ko) upon loading any standard DRM driver. Is there a better way to
handle this without burdening all generic display helper users?

>  module_init(drm_display_helper_module_init);
>  module_exit(drm_display_helper_module_exit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.565-=
1-kernel@airkyi.com?part=3D3

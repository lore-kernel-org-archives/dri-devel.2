Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA6606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuqdiLnZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DED1120F5;
	Fri, 27 Nov 2026 06:11:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D021120F5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:10:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46F2E43B75;
 Fri, 27 Nov 2026 06:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9F41F00898;
 Fri, 27 Nov 2026 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795759856;
 bh=LJzV9SjNCDoNpYW2PABHFxsWCmU54MLMVw2eXG57V+c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AuqdiLnZXFniQVcZcq41yu/VO06SIIuvFXQdNlVR/1CtxsSxsJ+w7GlYLpuOj0lyy
 olE/xz62jFF+055lgiDuSFv+Mm1hMsNf/HdzQ2fcctaqa958UUaLaO5XHrFSkkhPCx
 gdBXhUVuOSbbzx2wBfULSrr11beCxG6ZayL2wfUGWwNpLtgJGVnEOYP0mCjcyaFd0a
 o7t50I5zJUi8CQjSPwcTYWec8P915BbfI8elfv/dq+BkSlUMQXNFLFpnfEDY0yFN2T
 x6UVcJN9Oy+x1DQyzUEA0PQedIdYeIEABw7sRcst0xsu2edJGLR2SHYrZmNqRUSMhx
 5CO0QXzYnui1g==
Message-ID: <sashiko-outbox-236687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261127055807.109667-2-Luo.Liu@cixtech.com>
References: <20261127055807.109667-1-Luo.Liu@cixtech.com>
 <20261127055807.109667-2-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:10:55 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] MAINTAINERS: unexpected devicetree list and missing F: paths in
  cix dptx
--

commit a925e6ee61fd293f46e99dd02a193ee54a3f3d96
Author: Luo Liu <Luo.Liu@cixtech.com>

dt-bindings: display: add CIX Sky1 DisplayPort transmitter

This commit adds the Device Tree binding schema and MAINTAINERS entry for
the CIX Sky1 Trilinear DisplayPort transmitter.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index bcade5bfbafe9..b71e46f6fe323 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6527,6 +6527,18 @@ M:	Satish Kharat <satishkh@cisco.com>
>  S:	Supported
>  F:	drivers/infiniband/hw/usnic/
> =20
> +CIX SKY1 DISPLAYPORT TRANSMITTER DRIVER
> +M:	Luo Liu <Luo.Liu@cixtech.com>
> +M:	Wuyi Shen <wuyi.shen@cixtech.com>
> +R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
> +L:	devicetree@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
> +F:	drivers/gpu/drm/bridge/trilinear/
> +F:	drivers/gpu/drm/cix/dptx/
> +F:	include/drm/bridge/trilinear_dp.h

[Severity: Low]
Should L: devicetree@vger.kernel.org be dropped from this driver entry,
and the three driver F: lines moved to the patches that create those
paths?

Documentation/devicetree/ is already covered by OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS, so listing devicetree@vger.kernel.org here
causes scripts/get_maintainer.pl to route non-DT driver patches to the DT
list.  Also, drivers/gpu/drm/bridge/trilinear/, drivers/gpu/drm/cix/dptx/
and include/drm/bridge/trilinear_dp.h do not exist at this commit, causing
scripts/get_maintainer.pl --self-test=3Dpatterns to warn about unmatched F:
patterns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127055807.1096=
67-1-Luo.Liu@cixtech.com?part=3D1

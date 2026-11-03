Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B63606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhgCriqA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1413D10E1E7;
	Tue,  3 Nov 2026 06:33:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B22B10E1E7
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:32:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41941406E6;
 Tue,  3 Nov 2026 06:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C698B1F000C1;
 Tue,  3 Nov 2026 06:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793687574;
 bh=YiVTmPDWNkxPi0DGwzvarOc7hSTcBicLTW8ltICNVIE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YhgCriqAhhl3hxzprWdZiG9gx4WWTKzQq454zFgMjfKYv9FoeVSjgHGW57yKpeY/f
 bcXbRXpikYJQne7FoyZ5S9tyfYeMD/raqO03yQd0ff0sNQyCBfC+SSg7Mpo1Qh/XCQ
 U4gDT/h0xug49uN3xfgWcYjTK4MwQCHfsqJSFcKRvqIJXaskmHGRnfEU1j/SlWIgwG
 T0ShvdJwFkZC7W1tu1ElBSsyYr210VL6dInVEpJwFYXxDQR6l5M1fiISDPOBqVWcx8
 OGqVY4x8lkYkkpmwzuRWPO4dCJO4OoPUh7b+WtSQ4Zk2hFWOPbSUPZXrR5oXG2WAjP
 GBbnAttHHrg2w==
Message-ID: <sashiko-outbox-194636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/16] drm/imx: dc: Flag CRTC status in
 GENERALPURPOSE register
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-imx8-dc-prefetch-v9-6-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-6-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:32:53 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/imx: dc: commit message mismatch for dc_drv_set_crtc_{enable,di=
sable}()
--

commit 1bad6b1819c8236cf47f95cfccc89fe8559ef3c8
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Flag CRTC status in GENERALPURPOSE register

This commit maps the Display Controller's GENERALPURPOSE register via an
MMIO regmap and adds helpers to set, clear, and query the CRTC enablement
status bits.

>     drm/imx: dc: Flag CRTC status in GENERALPURPOSE register
>    =20
>     Map Display Controller's register GENERALPURPOSE at offset 0x100 and
>     create an MMIO regmap to access the register.  Create helpers
>     dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the regist=
er
>     to flag the CRTC enablement/disablement status.  Also, create a helper
>     dc_drv_crtc_is_enabled() so that the CRTC driver can use it to check
>     if the CRTC is enabled by a previous boot or not.  This is a preparat=
ion
>     for an upcoming patch to disable display controller at boot if the CR=
TC
>     was enabled by the driver during a previous boot instead of a bootloa=
der.
>    =20
>     Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>     Signed-off-by: Liu Ying <victor.liu@nxp.com>

[Severity: Low]
As reported by Sashiko on v8 [1], the commit message states that helpers
dc_drv_flag_crtc_{enable,disable}() are created, whereas
drivers/gpu/drm/imx/dc/dc-drv.c and drivers/gpu/drm/imx/dc/dc-drv.h define
and declare dc_drv_set_crtc_enable() and dc_drv_set_crtc_disable(). Should
the commit message be updated to reference
dc_drv_set_crtc_{enable,disable}()?

[1] https://lore.kernel.org/r/sashiko-outbox-190808@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-imx8-dc-pr=
efetch-v9-0-3b985e7636e2@nxp.com?part=3D6

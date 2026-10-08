Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA91CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BAB10FC71;
	Thu,  8 Oct 2026 06:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S4dvYXrk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D6110FC71
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:36:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82FC460252;
 Thu,  8 Oct 2026 06:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1021F000FF;
 Thu,  8 Oct 2026 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791441375;
 bh=YH22pCnTtKMj7m5yA4ghJiiKrBeYb6m5MLi14H3ncEM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S4dvYXrk2zP86jmHlzXfQCQ+B5Y2QWwYCI9DvcVz3xTu62GWo4aXCo2oTVjI8O7Pz
 uBQ0V8z/9tW042V8GWJauK/WDQu/gdt9SoXGB+nu11p/ntXSRZARrPyp6MmlcbPyhB
 PsFl5QSFsB69BMWDwdj3yP82PYf87J0TY1fwos2Qb35w+ztlnYaKMXrXxsmNoBdo0B
 rCyN2qvVRca7lAHeX42Ez2FPexCzkzuutuBxDy+9jljnWxcAr8OkFuTv7lmMmaJan2
 BKt+VO7ZJS/WLu8Cm7dFxHBZJvUSto/iiYz6k2BRjfCi+xwj+TMkSQAaKypeLVceyZ
 t2l6fs/OoL5EQ==
Message-ID: <sashiko-outbox-163700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-2-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
 <20261008-sahara_protocol_new_v2-v7-2-90d278bd7414@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:36:14 +0000
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
- [Medium] kconfig: MHI_SAHARA missing select WANT_DEV_COREDUMP
--

commit cc1e20cb4bdaa51fb38cee82d4db3c559fb1e1d9
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Move Sahara protocol driver under MHI host client drivers

This patch moves the Sahara protocol driver from the QAIC accelerator
subsystem to the MHI host client drivers to allow reuse. It sets up a new
Kconfig hierarchy and converts the driver to use module_mhi_driver().

> diff --git a/drivers/bus/mhi/host/clients/sahara/Kconfig b/drivers/bus/mh=
i/host/clients/sahara/Kconfig
> new file mode 100644
> index 0000000000000..f1fc7013a2dee
> --- /dev/null
> +++ b/drivers/bus/mhi/host/clients/sahara/Kconfig
> @@ -0,0 +1,15 @@
> +config MHI_SAHARA
> +	tristate "Sahara protocol driver"
> +	depends on MHI_BUS

[Severity: Medium]
Does this new Kconfig entry also need to select WANT_DEV_COREDUMP?

Since the Sahara driver is now an independent module, if it is built in a
configuration where DRM_ACCEL_QAIC is disabled, DEV_COREDUMP may not be
selected.

When DEV_COREDUMP is not set, the dev_coredumpv() call in
sahara_parse_dump_image() falls back to an inline stub that silently frees
the memory dump without exposing it.

Adding select WANT_DEV_COREDUMP here would ensure the diagnostic features
advertised in the help text remain functional regardless of whether other
drivers happen to enable the core dump framework.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-sahara_pro=
tocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com?part=3D2

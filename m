Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBFCC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D3410E4EA;
	Tue,  7 Jul 2026 13:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="koed4iua";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB7210E4BB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2826443B22;
 Tue,  7 Jul 2026 13:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8451F000E9;
 Tue,  7 Jul 2026 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430690;
 bh=GlqHFrjdlNIErYROMXfKwasPGQ6xm8o4zGv6nz9nAoc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=koed4iuakklkKmsiiqhNDsLCOwb/Quq11U+L37U6sTMJfSCom3+qSW7/d9xGprUhc
 ZK7DvEai/7MvcIkAtYPqC3zc4xuiVMW/qCIkChly7j2fa7LAkhJPc+IKtNgImpj0L+
 MsEiG9jNTK9pEAjmmTZwYd3c75EqM4Yacbq4P4NCMCHn83l2fUfSOiklpFuVc39KWA
 wnBROUs4U6K5V//0l4oGrgtJ9jUwynEU0pZ+8uFUTZg0nyW8kGuup0C/Fa7+nrCM54
 EL89VoCPmkoJPwwJJTbuSH9B10aS7qZEvUM89471qTHse4iSPRbMbPBd4UFCxeESmn
 3Yd7W6GSxzFsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/20] driver core: platform: provide
 platform_device_set_fwnode()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-3-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-3-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:49 +0000
Message-Id: <20260707132449.AD8451F000E9@smtp.kernel.org>
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

> Provide a helper function encapsulating the logic of assigning firmware
> nodes to platform devices created with platform_device_alloc(). Make the
> kerneldoc state that this is the proper interface for assigning firmware
> nodes to dynamically allocated platform devices. This will allow us to
> switch to counting the references of the device's firmware nodes in the
> future, not only the OF nodes.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D3


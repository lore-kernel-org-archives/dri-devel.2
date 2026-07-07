Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC310C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1677D10ECF2;
	Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JcARvHiN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA8110E4D0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64295601DE;
 Tue,  7 Jul 2026 13:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933861F000E9;
 Tue,  7 Jul 2026 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430695;
 bh=ttpy10rWjk+gG9dm34IWLNXlQeh+ehFO5FGYraY1S2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JcARvHiNl1Ija2xEh7DzufqfDIPHSL4wvOTk1MhvH4DYTIgjoyXgmsDUDPV8sL9Lc
 AywVyBl10X7ZANRVw6TqMdjJZ3ZJns6ixefJD8ZmXyEiwAmuTcTayiQ4dnMz6XWLW3
 +TgAomGldo/KfuvcOgeYT73JEll4TQM2+I77z2tle1CtMrDqbbAbq9sKyoOL/aiJFP
 ps2XHrNWUvRnqZ8r4fAL8onERk9wkSHOrLVnG2J/Kd0ykbH+R1p1AeT6kxdJjiQmE0
 xGBj47EGUAXcMIZ3mW4q97uu0q5YbTsxlEGw8++pYpUetVcedznVAu/jnmZ54m1U5C
 /p2uFMSQ9v0wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/20] powerpc/powermac: use
 platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, mfd@lists.linux.dev,
 conor+dt@kernel.org, Frank.Li@kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, lee@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-7-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-7-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:53 +0000
Message-Id: <20260707132454.933861F000E9@smtp.kernel.org>
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

> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D7


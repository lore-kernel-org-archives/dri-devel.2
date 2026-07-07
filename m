Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13132C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488E410ED06;
	Tue,  7 Jul 2026 13:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SmwZaa1c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A78510ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE7AC618BE;
 Tue,  7 Jul 2026 13:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A68E1F00A3E;
 Tue,  7 Jul 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430704;
 bh=PUva2vPwPVB3jHpmu0LICuALUIh3K0XLJ8i1qkuIXPo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SmwZaa1cRdA3bWQTHAX/0WmlBGFu019DkG/Kg9iMRxm86JZNGGBfEOvd/HkblNSO6
 CHrDO/gFWJB1/32XjJ0KSZFRhi9QmUUyqsN5OVJPFh+qID6ZnQnQKfEsv9tRhiGpCl
 SA1fxWZnKYMh7fbtdAYCJpmHI+6F9VCykGvJafRR13sUaFWbJNsAfUjljOzF9b3oaY
 H8t4TIfmz3PKxQbOTzSBjfxB+N1JkWJhgljgM00rJfSRt6E10J2ppfpl9bEatqFPbq
 M+swcrGmwqSnEQtdRYZXk7/HeShPru7waFnyQTn+oba1ViuCMFcnMt+fBgC4uZ9TFi
 tDYQejSPzpXaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/20] platform/surface: gpe: use
 platform_device_set_fwnode()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, mfd@lists.linux.dev, lee@kernel.org,
 imx@lists.linux.dev, robh@kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-16-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-16-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:03 +0000
Message-Id: <20260707132504.3A68E1F00A3E@smtp.kernel.org>
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
> encapsulate the assignment of the firmware node for dynamically allocated
> platform devices with the provided helper.
>=20
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D16


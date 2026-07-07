Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16F6C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C6610ECFF;
	Tue,  7 Jul 2026 13:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXn3BDny";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BD210ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC7CC601DE;
 Tue,  7 Jul 2026 13:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E75B1F00A3D;
 Tue,  7 Jul 2026 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430706;
 bh=4CASNmAXohnTPsJYPMGP6uwhkCLVlpmof8tPI1UAjjU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bXn3BDnywSp55a/ybkxG8YD6kLaOR9ZGtgm/yLrV0YCfZOmZVRSYRiSSdDQBIPwXT
 dTy6qAyTgRJ9AkaoS/TJJPmoNK8tQ247Jg+Fidjg576QuRveSbiLNVLAbvlTxmmUF1
 Fp32dQ6nDGvUMtkS/VNTejJbDa1r/xgBz0mX8O3mgrsz0bvqLylDv0YpCIO2Iz4vy8
 JZpFgojF1G6GI1CQR9l+5KOdM8WhruUHEjGSZ0e2zozimSQydtdvMcIXQYXFpVMEdW
 M4PJ/NKR80uOmv1j+eMRXvqSBwSycSrIx1vo9lyh37T7V0wzF8unJeZyqU7ATKjaIJ
 gnfGVJpBivaUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/20] usb: chipidea: use
 platform_device_set_of_node_from_dev()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, lee@kernel.org,
 mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-17-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-17-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:04 +0000
Message-Id: <20260707132505.1E75B1F00A3D@smtp.kernel.org>
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
> encapsulate the assignment of the OF node from another device for
> dynamically allocated platform devices with the provided helper.
>=20
> Acked-by: Peter Chen <peter.chen@kernel.org>
> Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D17


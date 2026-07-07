Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64B6C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B14C10ED07;
	Tue,  7 Jul 2026 13:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GbbrUXeU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2D810ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C23A0618C7;
 Tue,  7 Jul 2026 13:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F163E1F00A3A;
 Tue,  7 Jul 2026 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430708;
 bh=HmZ94qK61PEAudCnvJmh5eY4NTcDxkVDw0FZWy8z+Gw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GbbrUXeUh3T40x8CYijabCI9guhMaqxyqhKCXVMGnRAWxkITAle8EfeSwMC+M9IFi
 PHp3HDztxSyQU6lB+pbZOiciw+L08XPLbhpESXY2/JrF9r1blI2EWFlzzASRtMlghv
 dh0rkx+ll7Q+Ne23CQEa0SE7GkPG22vO7BHagrbm8WxaX+YkWpL2GFIDc2+kIehzzK
 5V9zjXz9NqI3RJcqbQb2HLXe+8NeTVJ03WSHfB8aB9To6FGkxvcBOHTSlNIzfPdf4R
 W7r1i58YTdto2DtgbMAL6+zQeFlXK9nZfqV0Bf0ZaB7Tl20e2xOcZvALbGCHIbwAmq
 rEwuX36dD1pNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/20] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 imx@lists.linux.dev, robh@kernel.org, mfd@lists.linux.dev, lee@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-19-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-19-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:07 +0000
Message-Id: <20260707132507.F163E1F00A3A@smtp.kernel.org>
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
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D19


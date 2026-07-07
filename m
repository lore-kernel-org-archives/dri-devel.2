Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F4DC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543B010E4BB;
	Tue,  7 Jul 2026 13:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NvRdOfs4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8385310E4A9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55B6F43DF0;
 Tue,  7 Jul 2026 13:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4BF1F00A3D;
 Tue,  7 Jul 2026 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430689;
 bh=iUuoqtahVUZr9OtTw0u0P6Wm/yDgfyTDFGsMt14kEdA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NvRdOfs4wzM0kGTNel6tjmaLPbiGFmqF/iaqJd0xENPKQoyevcKAye1gmUi0MypqM
 n+2hGkd8iIN1MatIZj8+hAXS9YbMEygzAAZEPCZJA9Tshjit+kK0/fLfoW/PbefLdC
 OJXYWxlkBiGiZghv9el/GUgKLeZgoBM8t2IWzGchoSw9gZqhp3lo2QYksZ+S9LA4VT
 se/jp4Y2bmI9gMqj1+8U22ZNMpMvp1dHF1u33FFZJRXkvRMwrM0L1HKzSoSw1kHELh
 r/YXDhAL9dVYvzcOSRbe1GXERAiHPjwHyzU/PFri9GzBUZlt+AQydMdY9WheDTxVce
 Gc907xhqKkgQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: robh@kernel.org, imx@lists.linux.dev, lee@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank.Li@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:47 +0000
Message-Id: <20260707132448.BA4BF1F00A3D@smtp.kernel.org>
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

> Encapsulate the reference counting logic for OF nodes assigned to
> platform devices created with platform_device_alloc() in a helper
> function. Make the kerneldoc state that this is the proper interface for
> assigning OF nodes to dynamically allocated platform devices. This will
> allow us to switch to counting the references of the device's firmware
> nodes, not only the OF nodes.
>=20
> Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D2


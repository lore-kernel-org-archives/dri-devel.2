Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED89B10E4A9;
	Tue,  7 Jul 2026 13:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dUclSUJ5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C6510E4BB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C630B600BB;
 Tue,  7 Jul 2026 13:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259641F000E9;
 Tue,  7 Jul 2026 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430687;
 bh=LztXDVMDysWrCfGtOMkXJIwXxCaxxrx0VHigrWpYLVI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dUclSUJ593XXWlQv2s53b8xTtV2CvZysUhfHcHcVRg0VnMfL4FmbuL9HBp1FEZf3Y
 0ug6wg4fcM3fMojMTBh/LlqUp3Dd5078mz4ohARrINN/8c0hXZpOR+sT0UU3Me1p2G
 iWhEUA+vNUrbN4g7gTg0TmPnrRQnDoI2CZH9bSolWW/FLOThBQQl3VA+lgkfJ1269Z
 exZh3nOAUofz4WvnpXKdX7mSRCP/bs1aj0P2OKyOlV96ICNJZcEPhAkUkffORnI2MH
 G1dhagk5XcnDU6o0K3OKH8J7TPEKyRd7ZLS3Um1r71avKftuevhONWsacV79mDZq+D
 S8Pl8rbWiDV0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/20] powerpc/powermac: fix OF node refcount
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 robh@kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260706-pdev-fwnode-ref-v3-1-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-1-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:46 +0000
Message-Id: <20260707132447.259641F000E9@smtp.kernel.org>
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

> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().
>=20
> Cc: stable@vger.kernel.org
> Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree=
")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D1


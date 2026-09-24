Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3A7C98324
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0690F10F747;
	Thu, 24 Sep 2026 18:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="czfQwS3u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BF110F753
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:57:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E24424039D;
 Thu, 24 Sep 2026 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFA61F00893;
 Thu, 24 Sep 2026 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790276245;
 bh=sXsWY802IT/mUjdeInyyctx51ucpkOBrmabp4R608HY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=czfQwS3uCUtlwaOkfRKEA5ExvJyUUGtkY4ZxLH+CfGC54/cE4ifC2umgcbnRWkEz7
 g/7q0XxLrmzY8+r/e78q6qlu5SZnB/CV2kmLBK+bnCHUUDLJDf0XpH9ZLpz6VeHBTb
 LranwMxgJFi/c8PzLC6Sm8fvqymI0WXuZWogoWuTPRghfBwOvYFFZaP2JlOtqQ8qCj
 9XzETIaSg/R+8uiPZv3yXFjDau8fOeNk0ifztaCA/r5Z6wUqL63vQ/7zbRLYoJ0lyb
 t5N3Agpy+7MiebbSKn4veJv8pBaWrT5orOQAVxoTFNC0uPxt51qOrXGQpr2fy9Gw74
 IyT4GKJCD/WsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/14] drm/bridge: it6505: unregister DP AUX adapter
 on bridge detach
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1bbe09fb84d2cdeb5ff2179749a8769ac79ce77a.1790275151.git.daniel@makrotopia.org>
References: <cover.1790275151.git.daniel@makrotopia.org>
 <1bbe09fb84d2cdeb5ff2179749a8769ac79ce77a.1790275151.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:57:25 +0000
Message-Id: <20260924185725.9BFA61F00893@smtp.kernel.org>
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
- [High] drm/bridge: it6505: regmap UAF on DP AUX access after driver unbind
--

commit 258ee9e0d0d476579fb9e6be277ae45cea6d1cde
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: unregister DP AUX adapter on bridge detach

The DP AUX adapter is registered in .attach() but only unregistered
in i2c remove(), causing registration failure on rebind. This commit
moves the unregistration to .detach() and adds it to the .attach() error pa=
th.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 9c4aae383c1c5..19bab8d65e222 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
[ ... ]
> @@ -3655,7 +3657,6 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  	struct it6505 *it6505 =3D i2c_get_clientdata(client);
> =20
>  	drm_bridge_remove(&it6505->bridge);
> -	drm_dp_aux_unregister(&it6505->aux);

[Severity: High]
Does removing drm_dp_aux_unregister() from the I2C remove path leave the DP
AUX character device and I2C adapter registered when the driver is unbound?

If the I2C driver is unbound via sysfs (e.g., /sys/bus/i2c/drivers/it6505/u=
nbind)
while the DRM display pipeline remains attached, it6505_i2c_remove() execut=
es
and returns. The driver core then automatically executes devres cleanup,
which destroys it6505->regmap.

Because the DP AUX adapter and its /dev/drm_dp_auxN character device are no
longer unregistered in this path, they remain fully registered and exposed =
to
userspace.

Any subsequent I/O on the char device will invoke it6505_aux_transfer(),
which calls it6505_aux_do_transfer(). This function unconditionally accesses
the it6505->regmap pointer that was just freed by devres during I2C unbind.

Similarly, any DRM atomic commit triggered by userspace will traverse the
still-attached bridge chain and call bridge callbacks that access the freed
regmap.

Can this lifetime mismatch lead to a use-after-free and memory corruption?

>  	it6505_debugfs_remove(it6505);
>  	it6505_remove_notifier_module(it6505);
>  	disable_irq(it6505->irq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790275151.gi=
t.daniel@makrotopia.org?part=3D4

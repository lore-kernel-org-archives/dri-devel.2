Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7346C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA0110E2AF;
	Mon,  6 Jul 2026 02:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TFE9/9s7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDDB10E2AF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:10:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A83C360018;
 Mon,  6 Jul 2026 02:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233D21F000E9;
 Mon,  6 Jul 2026 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783303824;
 bh=eVXMOWCTVtGo3cqU8YuLsxqSpzTH7AQxYO/x1e+sRs0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TFE9/9s7hgYkug/KEEG9thYIZLavxAI6xt/1xycOAnNgLrrL52J2vYx6eojDcKXQi
 451Cj25FfzsFBAUvcPCEMo4D4TpCZvdLDJJ+WLamjzupFtUQa8BoNnNtLbIoRNHX+A
 wRatziu8kAVHJmOE+fnGeBjMIHsfSmVcNsXknVYZnXfteCJroZUxb6CGN457IY529G
 KKZ1n/hqBh+IKRFyqvj5FnU9TroNrKxgutG16DiO5WEy8Tmlfr3RcatQ2Nt7IWH448
 3v7MhJw39FwxARFcCW8pRUseBMRg3gX0Q6B0Yh9AVm352ICHHXtKbKnwJ4215HyfkL
 mMpxJ4je+3fRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/mediatek: mtk_hdmi: Fix DDC adapter double put
 in v2
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706015507.453222-1-lgs201920130244@gmail.com>
References: <20260706015507.453222-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:10:21 +0000
Message-Id: <20260706021024.233D21F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The HDMI driver acquires the DDC I2C adapter using `of_find_i2c_ad=
apter_by_node()`, which takes a device reference but not a module reference=
. This allows a privileged user to unload the I2C adapter module while it i=
s still in use, leading to a deadlock during module removal.
--

commit c9e2f0cee6fea92e4b3c20dab0df7308240a2d76
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2

This commit removes the extra i2c_put_adapter() call in the HDMI v2
remove callback to prevent a double put of the DDC adapter device
reference. The reference is managed by a devm action set up during probe.

> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().
>=20
> The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
> adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
> the adapter device reference before the devm action drops it again, and
> it also puts a module reference that was never taken.

[Severity: High]
This is a pre-existing issue, but does using of_find_i2c_adapter_by_node()
leave the driver vulnerable to a deadlock?

Since of_find_i2c_adapter_by_node() takes a device reference but not a
module reference, it seems a privileged user could unload the I2C adapter
module (e.g., rmmod i2c_mt65xx) or unbind it via sysfs while the mtk_hdmi
driver is still using it.

If that happens, will the I2C core's i2c_del_adapter() wait indefinitely for
the device reference to reach zero, causing a deadlock and hanging the
unload process?

Code snippet for reference from drivers/gpu/drm/mediatek/mtk_hdmi_common.c:

mtk_hdmi_dt_parse_pdata() {
    ...
    hdmi->ddc_adpt =3D of_find_i2c_adapter_by_node(i2c_np);
    ...
}

Would it be safer to migrate this to of_get_i2c_adapter_by_node() and
pair it with i2c_put_adapter() in the devm cleanup action, so that the
module reference is properly held?

> Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
> remove callback. The common devm action releases the adapter device
> reference.
>
> Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT81=
88")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_v2.c
> index 7bbf463056c95..ffe456238a2bf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
[ ... ]
> @@ -1499,13 +1499,6 @@ static int mtk_hdmi_v2_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static void mtk_hdmi_v2_remove(struct platform_device *pdev)
> -{
> -	struct mtk_hdmi *hdmi =3D platform_get_drvdata(pdev);
> -
> -	i2c_put_adapter(hdmi->ddc_adpt);
> -}
> -

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015507.4532=
22-1-lgs201920130244@gmail.com?part=3D1

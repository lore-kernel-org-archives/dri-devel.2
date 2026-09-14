Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2938DC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BCB10F11B;
	Mon, 14 Sep 2026 18:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VUkIgc0a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA26C10F11B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:26:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66292438E7;
 Mon, 14 Sep 2026 18:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE13A1F000FF;
 Mon, 14 Sep 2026 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789410363;
 bh=V2LUiw/M2ArVLS4+UhUXDcOFMiyUVl9XfgooJZVvOGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VUkIgc0a16YFxbrvM7683BrAxpoMQhngg3272KkgNrkvHmfpFez10hjX6aUFMSS1l
 +JoWTum5NCXKg5xOKznANhSSfx89fSfiKJV0Jg9r9f4aVTfzsq1ibc+AzMwTFYFu7J
 47m+aoWOY4CVCIhiS3Q9Yuk/yfaulm43YkmpBntrO812QhnKv+ACzD+xaBjByy43Yk
 NGR3s0HDbFKRlBYiSSO9efJWoXHrtG2P0brJfVB5PPt1DTIWjIGCK4y45ZG88w5MP2
 QgnqHCDod6VuZYE13zU/bJdRVHPzPOsQhH5wFnv1H4p52sXw29LldnKjdw4ky/Q/W+
 sPPRGZpLgse3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] backlight: qcom-wled: Fix NULL pointer
 dereference in PM callbacks
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:26:02 +0000
Message-Id: <20260914182602.BE13A1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Type confusion in wled_probe() and wled_remove() leading to me=
mory corruption

Pre-existing issues:
- [High] Use-After-Free due to devres teardown order in wled_remove()
--

commit a2bfdd5e4b8eca63712840cdae737878170273a7
Author: David Heidelberg <david@ixit.cz>
Subject: backlight: qcom-wled: Fix NULL pointer dereference in PM callbacks

This patch attempts to fix a NULL pointer dereference during PM callbacks
by setting the platform device driver data in wled_probe().

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 650dd95f06ef5..a76158a298335 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1752,6 +1752,7 @@ static int wled_probe(struct platform_device *pdev)
>  	bl =3D devm_backlight_device_register(&pdev->dev, wled->name,
>  					    &pdev->dev, wled,
>  					    &wled_ops, &props);

[Severity: High]
This is a pre-existing issue, but can using devres to register the backlight
device lead to a use-after-free regression during driver unbind?

Because the backlight device remains registered and accessible via sysfs
during and immediately after wled_remove() completes, could a concurrent
userspace write trigger wled_update_status() which calls
wled_module_enable()?

If this happens, it could re-schedule ovp_work after wled_remove() has
already canceled it:

wled_module_enable()
    schedule_delayed_work(&wled->ovp_work, HZ / 100);

Will this pending timer later execute on freed memory once devres cleans up
the wled structure?

> +	platform_set_drvdata(pdev, bl);

[Severity: Critical]
Does this code introduce a type mismatch regression?

wled_remove() expects the driver data to be a struct wled pointer:

wled_remove()
    struct wled *wled =3D platform_get_drvdata(pdev);

If we set it to the backlight_device pointer here, will wled_remove()
operate on invalid memory offsets when it later calls
mutex_destroy(&wled->lock) and cancel_delayed_work_sync(&wled->ovp_work)?

>  	return PTR_ERR_OR_ZERO(bl);
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-qcom-wled-=
backlight-v3-0-d69fe9843841@ixit.cz?part=3D1

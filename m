Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27240CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A6910E23A;
	Thu, 15 Oct 2026 09:17:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FB910E23A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:17:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83F01601F0;
 Thu, 15 Oct 2026 09:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E941F000C4;
 Thu, 15 Oct 2026 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792055834;
 bh=bsgyq6SJmuWHW13x2MS16fRrAjvt0BKEE9uYIGkU3ic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YRE+uNg6iUTRt9iHFhOG8cuKGXW0XCiJfa2dl6ubu0jLUqvC1eYVtHTf6IX98dFrj
 5SFkwaOAbnAJjFi5I8LOHCa7iE61xI0jZqmhpylp9Q3KqmY6A+QD+oWl6uBFNXTJXT
 Ko7nVAMs8m26Ryr/w1hEUn91KxVcTYi1HWd5Z4XMKatKwhHwY5df/hLm5gf6+N3uLs
 Hqu5JlA4ET9bHj3HLTfbD5dP0fhXIEAaulW6Jf6db3T7OwCIFvrQkUVmYI1jJe9Z/C
 fhrzTgA50qeaU6lfyZCeOqG5SpUbxMcUiYQ6MjJRY7m2RJMouAl0JIB8F5B+C8S5Bc
 ibIWb522zpu0w==
Message-ID: <sashiko-outbox-172555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] backlight: qcom-wled: fix string detection
 brightness on WLED5
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:17:13 +0000
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
- [Medium] qcom-wled: missing brightness sync toggle for WLED4
--

commit 80c30ca9ff45480f825b4f3ca26c694d9fa71acf
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

backlight: qcom-wled: fix string detection brightness on WLED5

This patch updates the auto string detection logic to properly latch new
brightness values for WLED5. It introduces a helper function to set the
brightness and apply the version-specific sync toggle.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index f2e0430cccbca..6fbac6a4c29b8 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -577,6 +577,17 @@ static irqreturn_t wled_short_irq_handler(int irq, v=
oid *_wled)
> =20
>  #define AUTO_DETECT_BRIGHTNESS		200
> =20
> +static int wled_auto_detect_set_brightness(struct wled *wled, u16 bright=
ness)
> +{
> +	int rc;
> +
> +	rc =3D wled->wled_set_brightness(wled, brightness);
> +	if (rc < 0 || wled->version < 5)
> +		return rc;

[Severity: Medium]
Does this code introduce a regression for WLED4 devices by missing the
brightness sync toggle?

During WLED4 auto string detection, the code updates the brightness to a low
test value, but it appears to return without latching it. Looking at the
standard brightness update path in wled_update_status(), WLED4 hardware
requires a sync toggle to apply brightness changes:

drivers/video/backlight/qcom-wled.c:wled_update_status() {
	...
	if (wled->version < 5) {
		rc =3D wled->wled_sync_toggle(wled);
	...
}

Without syncing the auto-detect test brightness, WLED4 might run the
detection with stale, potentially high brightness. Could this trigger false
over-voltage (OVP) faults and incorrectly mark valid LED strings as
disconnected?

> +
> +	return wled5_mod_sync_toggle(wled);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-sm8150-dis=
play-card-v1-0-5c14928cef29@oss.qualcomm.com?part=3D2

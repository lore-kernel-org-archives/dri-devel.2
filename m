Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5477CC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DF210E4B4;
	Mon,  7 Sep 2026 20:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Igt9Yc37";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCFD10E4B4
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7185601FB;
 Mon,  7 Sep 2026 20:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9DF1F00A3A;
 Mon,  7 Sep 2026 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788812898;
 bh=rZEoGTF/5hm4ljg3ITSKhYcqOICMkncOAB1utoDj0V8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Igt9Yc37YVXxzQZgfrS+DqbtVXc1U1s38XTwmRq8pc+E1iB9YtZp+Nsw6l9DltDdh
 CeCMnYSij7hYCccl4q/57KXkeEfR8dpkhtDXwUJRObQuu1GivELSnAzrGCv2uJsi/s
 zr6S3kVn1UVQcEw8l/mK6mFXDbhLdThFW7r/98DLnOyJyUKGhQH6DNI7CKZUeoMlw3
 TespeOFFHX0Cfk+dEoXKf70hgrA2VOBgErtiy5LW7md0kqog+q8BzvFyIXAS78wbNG
 HigkXZxrke5N0c43vlJvNd7/4gTNr0jfH9J29H0ekZARzRIpE02zV/slgREzQqpbD7
 3rr9/L04RMjuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-10-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-10-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:28:17 +0000
Message-Id: <20260907202818.3B9DF1F00A3A@smtp.kernel.org>
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
- [High] Incorrect error handling of pm_runtime_get_if_active() leads to un=
safe hardware access when runtime PM is disabled.
--

commit 8d990169095e4c032a10ab3f7f2aa29eb0345717
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This commit introduces a new debugfs file to manually schedule a GPU reset.
It is intended to help test potential race conditions between the reset
sequence and other hardware register accesses.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index f0fae6fa1e248..f171abe26f80d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +	int ret =3D pm_runtime_get_if_active(pfdev->base.dev);
> +
> +	if (ret) {

[Severity: High]
Can this cause a kernel panic if runtime PM is disabled?

pm_runtime_get_if_active() returns a negative error code (like -EINVAL)
when runtime PM is disabled, such as during system suspend. Because this
condition checks if (ret) instead of if (ret > 0), a negative error return
evaluates to true.

This would cause panfrost_device_schedule_reset() to execute and flush the
work queue while the device is potentially powered down, which may lead to
unclocked register accesses and a synchronous external abort (bus fault).

Should this condition be if (ret > 0) to ensure the device is genuinely
active before proceeding with the hardware reset?

> +		panfrost_device_schedule_reset(pfdev);
> +		flush_work(&pfdev->reset.work);
> +		if (ret > 0)
> +			pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D10

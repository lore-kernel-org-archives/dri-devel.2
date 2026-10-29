Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E73606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+mFHjfM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C48410E808;
	Thu, 29 Oct 2026 14:01:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D901B112329
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:01:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D71BC60202
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851761F01825;
 Thu, 29 Oct 2026 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793282498;
 bh=LEdkfF7/tu3TnAnpaPnPl6sdnLNhZBw4UWuTqcGyBcQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W+mFHjfMFMfe+Q1EZKXJ36CHrV5QcCkATUGCsZnmkF0wRk3W95KiYKXux2MJB6YyH
 vs/Zr/AAkwFPm59ydU8y+iKhOG8kWqftcCwtcsMTIm34mXMP5QHNGC3+D9AelB5gym
 z0+dNQ+i3WPozZqIa9fWre2I5vm8X6FcTboyS4R34jQoTute66dlbqhSFRdPlSlXVq
 xXdmzV6Z9ak8Ytl03txvU/3PgRUzqZzIeNBw+smmxnq5OOvD7ncWCGSJU4ydiF5o/r
 2rcLuvVvt92uzkuASI+Lr6l1HX5WfC3ajaYWLSU91BfKcrWLiD1vUQYFaJhhsh5aOw
 IjeNX8l5V2W5Q==
Message-ID: <sashiko-outbox-189459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/31] accel: ethosu: Disable clocks on PM setup failure
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-4-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-4-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:01:38 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] accel: ethosu: double clock disable in ethosu_init() on PM enabl=
e failure
--

commit f5f434ba4c9847ae5b3231ccf71531bf3ccbd16b
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Disable clocks on PM setup failure

This commit calls ethosu_device_suspend() on the error path when
devm_pm_runtime_set_active_enabled() fails in ethosu_init(), aiming to
disable the clocks that were enabled earlier by ethosu_device_resume().

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 9ee144c41550c..1a65e9eef562f 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -311,8 +311,10 @@ static int ethosu_init(struct ethosu_device *ethosud=
ev)
>  	pm_runtime_set_autosuspend_delay(ethosudev->base.dev, 50);
>  	pm_runtime_use_autosuspend(ethosudev->base.dev);
>  	ret =3D devm_pm_runtime_set_active_enabled(ethosudev->base.dev);
> -	if (ret)
> +	if (ret) {
> +		ethosu_device_suspend(ethosudev->base.dev);
>  		return ret;
> +	}

[Severity: Medium]
Can this cause a double call to clk_bulk_disable_unprepare() on
ethosudev->clks if devm_pm_runtime_set_active_enabled() fails inside
devm_pm_runtime_enable()?

In drivers/accel/ethosu/ethosu_drv.c:ethosu_init(),
pm_runtime_use_autosuspend() is called and then
devm_pm_runtime_set_active_enabled() runs while dev->power.usage_count is
still 0, because pm_runtime_get_noresume() is only called after
devm_pm_runtime_set_active_enabled() succeeds.

Inside drivers/base/power/runtime.c:devm_pm_runtime_set_active_enabled():

int devm_pm_runtime_set_active_enabled(struct device *dev)
{
	int err;

	err =3D pm_runtime_set_active(dev);
	if (err)
		return err;

	err =3D devm_add_action_or_reset(dev, pm_runtime_set_suspended_action, dev=
);
	if (err)
		return err;

	return devm_pm_runtime_enable(dev);
}

And in drivers/base/power/runtime.c:devm_pm_runtime_enable():

static void pm_runtime_disable_action(void *data)
{
	pm_runtime_dont_use_autosuspend(data);
	pm_runtime_disable(data);
}

int devm_pm_runtime_enable(struct device *dev)
{
	pm_runtime_enable(dev);

	return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
}

If the devm_add_action_or_reset() allocation in devm_pm_runtime_enable()
fails, it invokes pm_runtime_disable_action() while runtime PM is still
enabled, runtime_status is RPM_ACTIVE, and usage_count is 0.

pm_runtime_dont_use_autosuspend() clears use_autosuspend and calls
update_autosuspend() -> rpm_idle() -> rpm_suspend(), which synchronously
executes the runtime_suspend callback (ethosu_device_suspend()) and disables
ethosudev->clks. When devm_pm_runtime_set_active_enabled() then returns the
error to ethosu_init(), calling ethosu_device_suspend() unconditionally in
the error path will disable and unprepare ethosudev->clks a second time.

Would calling pm_runtime_get_noresume() before
devm_pm_runtime_set_active_enabled() (and pairing it with
pm_runtime_put_noidle() on error) prevent runtime PM from suspending the
device during failure cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D4

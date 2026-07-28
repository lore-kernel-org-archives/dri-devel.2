Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164F3C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797C510E8F8;
	Tue, 28 Jul 2026 13:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X964kWtL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99F310E8F8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:34:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACE68410CF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7941F00A3A;
 Tue, 28 Jul 2026 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785245692;
 bh=lqutoZvLmcaetsb4FI5xQY3Nq1BA3DPwOZ6J34eQOx8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X964kWtLKKdc0RHgz9OvJVNY8fk1/UJdCW8XxXs89PKM7YbH67/qoRjewDdKDlQwe
 rIuD+mzremrJPxFsJ6NZPyf62eTdDY9pL4AyEvp6iiWGyxmGmoaCUh3rbqQwBP4BYI
 eFyoxRPTW/8FW5pUppV9ajhM4jeWLEGQeJjCoVI/l+16uSWF3q/svAl7Oj1XdtO7xc
 LbjvpHDq8z6xfamc32naBqOx15B8sy+ZZYs8aBDhDKeFoY8zXzDO3rvJLKX91tTnka
 4lfDnDrd3BgxSiFWL5rYI53kl7AMqTnWhspqmfv9H1RweFdqz/hxikZ2Etsjp9YV9s
 DPMLkqmpSpq3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/msm/dsi: Drop dev_pm_opp_set_rate(0)
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-topic-dpu_power-v1-3-e7783b859a70@oss.qualcomm.com>
References: <20260728-topic-dpu_power-v1-0-e7783b859a70@oss.qualcomm.com>
 <20260728-topic-dpu_power-v1-3-e7783b859a70@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:34:51 +0000
Message-Id: <20260728133452.5C7941F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() in power-off path races with device =
teardown, leaking bus clocks.
- [High] Ignored return values for clock enablement in msm_dsi_host_xfer_pr=
epare() leading to unclocked register access.
- [High] Unclocked register access crash due to missing cancel_work_sync() =
for err_work.
- [High] Double put_device() on the PHY device when dsi_get_phy() defers pr=
obe.
- [High] Asynchronous pm_runtime_put() causes hardware sequencing violation=
 by disabling regulators while bus clocks are still running.
--

--- Patch [3]: [PATCH 3/3] drm/msm/dsi: Drop dev_pm_opp_set_rate(0) ---
commit 9d791038937d59c654ef91edf07d2b7ff4432725
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

This commit removes the dev_pm_opp_set_rate(0) call from
dsi_link_clk_disable_6g() because it removes the power vote without
parking the clock. It relies on the subsequent pm_runtime_put() to rescind
the power vote.

>     Every call site of ops->link_clk_disable() is followed by
>     pm_runtime_put(), so the power vote will be rescinded if deemed safe.

[Severity: High]
This isn't a bug introduced by this patch, but does relying on the
asynchronous pm_runtime_put() cause a resource leak during teardown?

In msm_dsi_host_power_off(), pm_runtime_put() is called to queue an async
suspend. However, if the device is immediately torn down,
msm_dsi_host_destroy() cancels any pending async work:

drivers/gpu/drm/msm/dsi/dsi_host.c:msm_dsi_host_destroy() {
    ...
    pm_runtime_disable(&msm_host->pdev->dev);
    ...
}

Because the async suspend is canceled, does this leave the device in the
RPM_ACTIVE state and permanently leak the bus clocks? Should
pm_runtime_put_sync() be used instead?


[Severity: High]
This is a pre-existing issue, but does this asynchronous pm_runtime_put() a=
lso
cause a hardware power-sequencing violation?

In msm_dsi_host_power_off(), the regulators are disabled immediately after
the async put:

drivers/gpu/drm/msm/dsi/dsi_host.c:msm_dsi_host_power_off() {
    ...
    pm_runtime_put(&msm_host->pdev->dev);

    regulator_bulk_disable(msm_host->cfg_hnd->cfg->num_regulators,
                           msm_host->supplies);
    ...
}

Since pm_runtime_put() returns immediately while bus clocks are still runni=
ng,
does this remove power before the clocks are actually disabled by the
asynchronous suspend?


[Severity: High]
This is a pre-existing issue, but is there a risk of an unclocked register
access crash during power off?

When the display is turned off in msm_dsi_host_power_off(), hardware clocks
are disabled but there is no call to cancel_work_sync() for err_work:

drivers/gpu/drm/msm/dsi/dsi_host.c:msm_dsi_host_power_off() {
    ...
    cfg_hnd->ops->link_clk_disable(msm_host);
    pm_runtime_put(&msm_host->pdev->dev);
    ...
}

If err_work executes after clocks are disabled or is flushed during driver
teardown:

drivers/gpu/drm/msm/dsi/dsi_host.c:dsi_err_worker() {
    ...
        dsi_sw_reset(msm_host);
    ...
}

Will this unconditional hardware access cause a synchronous external abort?


> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index 59125d342fcb6..7e4e3718b536c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -550,8 +550,6 @@ int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_h=
ost)
> =20
>  void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host)
>  {
> -	/* Drop the performance state vote */
> -	dev_pm_opp_set_rate(&msm_host->pdev->dev, 0);

[Severity: High]
This is a pre-existing issue, but is it possible for a similar sequence to
cause a kernel panic due to ignored return values when enabling clocks?

In msm_dsi_host_xfer_prepare(), the return values for enablement are ignore=
d:

drivers/gpu/drm/msm/dsi/dsi_host.c:msm_dsi_host_xfer_prepare() {
    ...
    pm_runtime_get_sync(&msm_host->pdev->dev);
    cfg_hnd->ops->link_clk_set_rate(msm_host);
    cfg_hnd->ops->link_clk_enable(msm_host);
    ...
    msm_host->dma_cmd_ctrl_restore =3D dsi_read(msm_host, REG_DSI_CTRL);
    ...
}

If clock enablement fails, will the unconditional dsi_read() to an unclocked
register cause a synchronous external abort?


[Severity: High]
This isn't a bug introduced by this patch, but does dsi_get_phy() double fr=
ee
the PHY device on probe deferral?

If the PHY driver is not ready, dsi_get_phy() drops the reference but leave=
s a
dangling pointer in msm_dsi->phy_dev:

drivers/gpu/drm/msm/dsi/dsi.c:dsi_get_phy() {
    ...
        put_device(&phy_pdev->dev);
        DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__=
);
        return -EPROBE_DEFER;
    ...
}

When the error is handled during dsi_init(), it calls dsi_destroy() which
drops the reference a second time:

drivers/gpu/drm/msm/dsi/dsi.c:dsi_destroy() {
    ...
    if (msm_dsi->phy_dev) {
        put_device(msm_dsi->phy_dev);
    ...
}

Could this lead to a reference count underflow?

>  	clk_disable_unprepare(msm_host->esc_clk);
>  	clk_disable_unprepare(msm_host->pixel_clk);
>  	clk_disable_unprepare(msm_host->byte_intf_clk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-topic-dpu_=
power-v1-0-e7783b859a70@oss.qualcomm.com?part=3D3

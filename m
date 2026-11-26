Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE1606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HULvbksb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C104310E13E;
	Thu, 26 Nov 2026 06:22:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D7310E13E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:22:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA0E8408E4;
 Thu, 26 Nov 2026 06:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C04F1F000CA;
 Thu, 26 Nov 2026 06:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795674119;
 bh=GM6UNY+GwZw8xMMv6ebOCpntbx9WB/b+5G12sLyDfUU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HULvbksbgWWkpTyZ/OSYww9TCzFU5y2kvo8ypCXaJt/45heaocJ0FJHxBqPPzmeZi
 zY5bWNseMxKxO1NZJgEO2LogHLe2qM3HuEvcOvmeNJIYimfLgK9+dRjGHu7Fecp5aZ
 HnL6apCfcNt0+uuf1Br0sKSUgLo8sTQaNnd6hsHQ9pqb8Q4bvaHBiSoox/L1/mWkvR
 WpvYVtz+5qYVyUL9ltEVaXI+QqJCB3/rBuhtra+/phNJglAmPnh44tdCyrWTdJ+4WO
 12f4JVw0e4apP/wWHyrvcLNODORieHr5Dai/kCSGgQk58aI1w346i7y/lpbxE30vY+
 +3DHUtfFU6zWw==
Message-ID: <sashiko-outbox-234835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/bridge: cdns-mhdp8546: Add suspend resume
 support to the bridge driver
To: "Abhash Kumar Jha" <a-kumar2@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126060532.2379444-1-a-kumar2@ti.com>
References: <20261126060532.2379444-1-a-kumar2@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:21:57 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/bridge: cdns-mhdp8546: build failure on mhdp->no_hpd in
  cdns_mhdp_resume()
- [High] drm/bridge: cdns-mhdp8546: unbalanced phy_power_off() and
  phy_power_on()
- [High] drm/bridge: cdns-mhdp8546: uncanceled async fw load on
  cdns_mhdp_resume() error
- [High] drm/bridge: cdns-mhdp8546: unmasked HPD IRQ race in
  cdns_mhdp_suspend()
- [Medium] drm/bridge: cdns-mhdp8546: double clk and phy teardown after
  failed resume
--

commit 8f4412907134191fa8e20db994148c5d7ad2f2b4
Author: Abhash Kumar Jha <a-kumar2@ti.com>

drm/bridge: cdns-mhdp8546: Add suspend resume support to the bridge driver

This commit adds system suspend and resume hooks to the cdns-mhdp8546
bridge driver, checking the KEEP_ALIVE register on resume to either
reload the firmware or reactivate it if the device did not lose power.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index f47717bd10798..5c481562203b0 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
[ ... ]
> @@ -2258,6 +2257,125 @@ static void cdns_mhdp_hpd_work(struct work_struct=
 *work)
>  	drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
>  }
> =20
> +static int cdns_mhdp_resume(struct device *dev)
> +{
> +	struct cdns_mhdp_device *mhdp =3D dev_get_drvdata(dev);
> +	unsigned int keep_alive, keep_alive_inc;
> +	unsigned long rate;
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(mhdp->clk);
> +	if (ret)
> +		return ret;
> +
> +	rate =3D clk_get_rate(mhdp->clk);
> +	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
> +	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
> +	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
> +
> +	ret =3D phy_init(mhdp->phy);
> +	if (ret) {
> +		dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
> +		goto disable_clk;
> +	}
> +	ret =3D phy_power_on(mhdp->phy);
> +	if (ret < 0) {
> +		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
> +		goto phy_exit;
> +	}
> +
> +	/*
> +	 * The KEEP_ALIVE register is incremented at every scheduler loop of the
> +	 * firmware. If it changes between reads, the firmware is still running
> +	 * (e.g. the suspend was aborted) and only needs to be activated. If it
> +	 * does not change, the bridge lost power and the firmware must be load=
ed
> +	 * again.
> +	 */
> +	keep_alive =3D readl(mhdp->regs + CDNS_KEEP_ALIVE) & CDNS_KEEP_ALIVE_MA=
SK;
> +	ret =3D readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, keep_alive_inc,
> +				 (keep_alive_inc & CDNS_KEEP_ALIVE_MASK) !=3D keep_alive,
> +				 2000, 2 * CDNS_KEEP_ALIVE_TIMEOUT);
> +	if (ret) {
> +		ret =3D cdns_mhdp_load_firmware(mhdp);
> +		if (ret)
> +			goto phy_off;
> +
> +		ret =3D wait_event_timeout(mhdp->fw_load_wq,
> +					 mhdp->hw_state =3D=3D MHDP_HW_READY,
> +					 msecs_to_jiffies(1000));
> +		if (ret =3D=3D 0) {
> +			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
> +				__func__);
> +			ret =3D -ETIMEDOUT;
> +			goto phy_off;
> +		}

[Severity: High]
Can a timeout here leave the asynchronous cdns_mhdp_fw_cb() callback running
after mhdp->clk is disabled?

cdns_mhdp_load_firmware() schedules cdns_mhdp_fw_cb() via
request_firmware_nowait().  If wait_event_timeout() times out after 1000 ms,
jumping to phy_off disables mhdp->clk without cancelling or synchronizing w=
ith
the pending callback:

CPU0                              kworker
cdns_mhdp_resume()
  cdns_mhdp_load_firmware()
    request_firmware_nowait(...)
  wait_event_timeout(...) =3D=3D 0
  ...
  clk_disable_unprepare(mhdp->clk)
                                  cdns_mhdp_fw_cb()
                                    cdns_mhdp_fw_activate()
                                      writel(..., mhdp->regs + CDNS_APB_CTR=
L)
                                        <-- unclocked MMIO access

cdns_mhdp_fw_activate() then writes to mhdp->regs and copies the firmware
image to CDNS_MHDP_IMEM while the clock is disabled, which triggers a
synchronous external abort on ARM64 SoCs.

> +	} else {
> +		ret =3D cdns_mhdp_set_firmware_active(mhdp, true);
> +		if (ret) {
> +			dev_err(mhdp->dev, "Failed to activate firmware (%pe)\n",
> +				ERR_PTR(ret));
> +			goto phy_off;
> +		}
> +
> +		spin_lock(&mhdp->start_lock);
> +		mhdp->hw_state =3D MHDP_HW_READY;
> +		if (!mhdp->no_hpd)
> +			cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
> +		spin_unlock(&mhdp->start_lock);
> +	}

[Severity: High]
Does this compile when CONFIG_DRM_CDNS_MHDP8546 is enabled?  struct
cdns_mhdp_device has no no_hpd member.

> +
> +	return 0;
> +
> +phy_off:
> +	phy_power_off(mhdp->phy);
> +phy_exit:
> +	phy_exit(mhdp->phy);
> +disable_clk:
> +	clk_disable_unprepare(mhdp->clk);
> +
> +	return ret;
> +}

[Severity: Medium]
If cdns_mhdp_resume() fails, won't driver removal later double-exit mhdp->p=
hy
and double-disable mhdp->clk?

cdns_mhdp_probe() enables mhdp->clk with devm_clk_get_enabled() and calls
phy_init(mhdp->phy), and cdns_mhdp_remove() unconditionally calls
phy_exit(mhdp->phy) before devres disables and unprepares mhdp->clk.  When
cdns_mhdp_resume() fails, mhdp->phy and mhdp->clk are left torn down, so
unbinding the driver underflows phy->init_count and triggers clk framework
WARN_ON splats.

> +
> +static int cdns_mhdp_suspend(struct device *dev)
> +{
> +	struct cdns_mhdp_device *mhdp =3D dev_get_drvdata(dev);
> +	unsigned long timeout =3D msecs_to_jiffies(100);
> +	int ret;
> +
> +	cancel_work_sync(&mhdp->hpd_work);

[Severity: High]
Can an HPD interrupt fire after cancel_work_sync(&mhdp->hpd_work) and access
mhdp->regs after mhdp->clk is disabled?

cdns_mhdp_suspend() runs in .suspend_late while device IRQs are still
enabled, and it never masks CDNS_APB_INT_MASK.  Because cdns_mhdp_irq_handl=
er()
only checks mhdp->bridge_attached before scheduling mhdp->hpd_work, an HPD
interrupt after cancel_work_sync() re-queues the work while suspend proceeds
to disable the clock:

CPU0                              CPU1
cdns_mhdp_suspend()
  cancel_work_sync(&mhdp->hpd_work)
                                  cdns_mhdp_irq_handler()
                                    schedule_work(&mhdp->hpd_work)
  ...
  clk_disable_unprepare(mhdp->clk)
                                  cdns_mhdp_hpd_work()
                                    cdns_mhdp_update_link_status()
                                      <-- unclocked MMIO/mailbox access

Masking CDNS_APB_INT_MASK (or calling cdns_mhdp_bridge_hpd_disable()) and
synchronizing with the IRQ before cancelling mhdp->hpd_work would prevent it
from being re-queued.

> +
> +	ret =3D wait_event_timeout(mhdp->fw_load_wq,
> +				 mhdp->hw_state =3D=3D MHDP_HW_READY,
> +				 timeout);
> +	if (ret =3D=3D 0) {
> +		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	spin_lock(&mhdp->start_lock);
> +	mhdp->hw_state =3D MHDP_HW_STOPPED;
> +	spin_unlock(&mhdp->start_lock);
> +
> +	ret =3D cdns_mhdp_set_firmware_active(mhdp, false);
> +	if (ret) {
> +		dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", ERR_PTR(ret));
> +		spin_lock(&mhdp->start_lock);
> +		mhdp->hw_state =3D MHDP_HW_READY;
> +		spin_unlock(&mhdp->start_lock);
> +		return ret;
> +	}
> +
> +	phy_power_off(mhdp->phy);
> +	phy_exit(mhdp->phy);
> +	clk_disable_unprepare(mhdp->clk);
> +
> +	return 0;
> +}

[Severity: High]
Are phy_power_off() here and phy_power_on() in cdns_mhdp_resume() balanced
with cdns_mhdp_probe()?

cdns_mhdp_probe() only calls phy_init(mhdp->phy) and never calls
phy_power_on(mhdp->phy) (phy_power_on() is only called in
cdns_mhdp_connector_enable() / cdns_mhdp_atomic_enable() and balanced in the
corresponding disable hooks).  When the bridge is not actively enabled,
mhdp->phy->power_count is 0, so calling phy_power_off() here underflows
power_count to -1, performs an unbalanced runtime PM put and regulator
disable on the PHY, and causes both phy_power_off() and the subsequent
phy_power_on() in cdns_mhdp_resume() to skip the PHY driver's callbacks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126060532.2379=
444-1-a-kumar2@ti.com?part=3D1

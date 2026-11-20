Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAC606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=vYBXbJye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A0A112C5E;
	Fri, 20 Nov 2026 17:53:30 +0000 (UTC)
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F61E10E02C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:53:24 +0000 (UTC)
Message-ID: <ef1b7465-9639-4d11-9b10-4b0c9da21bd5@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
 s=courrier-s1; t=1795197201;
 bh=V8tpS6gdtCA8ZbK1QEzTWT9dOlqALvACzeGN4IBIn60=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=vYBXbJyeFCDtVKTZkks5hS0kKXgmajx0a9aGeWOoL6LRhNYO0O1MO2QARIZQDEbki
 ezb0rth3CwzPZpsK6kXyuX92iK0FDNFUbi2O3bjhrJgqn4rOtuRJaiEuf4sQG3B6Sm
 eZmcENqezW7RZGDTK3ggXRmbK6y/wimX1gYVvpM8=
Date: Fri, 20 Nov 2026 18:52:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH 07/10] drm/meson: dw-hdmi: Use the generic PHY framework
 for the HDMI TX PHY
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-7-9e0ac931381c@aliel.fr>
 <sashiko-outbox-219549@kernel.org>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219549@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 21:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] drm/meson: dw-hdmi: suspend/resume order breaks PHY state and
>   HDMI output
> - [Medium] drm/meson: dw-hdmi: missing phy_exit() on dw_hdmi_probe()
>   failure
> - [Medium] drm/meson: dw-hdmi: premature PHY teardown in
>   meson_dw_hdmi_unbind()
> --
> 
> commit 91e31ad4e0b36171e791e7c0487c9a4c66b12b31
> Author: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY
> 
> This commit converts meson_dw_hdmi from direct HHI_HDMI_PHY_CNTL0..5
> register writes to the generic PHY API, with a legacy fallback when the
> device tree lacks a "phys" property.
> 
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> index 20a821936b3af..f28cc1e6ee1df 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> 
> 
> [Severity: Medium]
> Does meson_dw_hdmi_bind() leak a phy_init() reference if dw_hdmi_probe()
> fails later in this function (for example with -EPROBE_DEFER when the DDC
> I2C bus is not ready)?
> 
> When the PHY comes from the external PHY provider, devres cleanup on a
> failed component bind only calls phy_put(), leaving phy->init_count at 1.
> On the next bind attempt, meson_dw_hdmi_init() resets hdmitx_phy and calls
> phy_init(), which sees init_count > 0 and skips phy->ops->init(), leaving
> HHI_HDMI_PHY_CNTL0 and HHI_HDMI_PHY_CNTL1 uninitialized after the hardware
> reset.
> 

I will move revert this change.

> [Severity: Medium]
> Can tearing down meson_dw_hdmi->phy before devm_free_irq() and
> dw_hdmi_unbind() cause a use-after-free in dw_hdmi_top_thread_irq()?
> 
> CPU0                                    CPU1
> meson_dw_hdmi_unbind()
>   phy_exit(meson_dw_hdmi->phy)
>   devm_phy_destroy(..., meson_dw_hdmi->phy)
>                                         dw_hdmi_top_thread_irq()
>                                           dw_hdmi_setup_rx_sense()
>                                             ...
>                                               dw_hdmi_phy_init()
>                                                 phy_configure(dw_hdmi->phy, ...)
>                                                   <-- use-after-free
>   devm_free_irq(...)
>   dw_hdmi_unbind(...)
> 
> In the legacy PHY path, devm_phy_destroy() immediately unregisters and
> frees meson_dw_hdmi->phy while the threaded HPD interrupt handler is still
> active and can invoke dw_hdmi_phy_init() or dw_hdmi_phy_disable().  Even
> with a DT PHY, HPD handling or dw_hdmi_unbind() can access the PHY after
> phy_exit().  Should phy_exit() and devm_phy_destroy() run after
> devm_free_irq() and dw_hdmi_unbind()?
> 

I will move the phy_destroy after unbind, phy_exit will be on
phy_disable only.

> [Severity: High]
> Does calling phy_exit() in meson_dw_hdmi_pm_suspend() and phy_init() in
> meson_dw_hdmi_pm_resume() break HDMI output across system suspend/resume?
> 
> Because the HDMI TX platform device sits after the VPU master device on
> dpm_list (both from DT node order and because devm_phy_optional_get() adds
> a stateless device link to the PHY that reorders the consumer to the tail
> of dpm_list), system suspend runs meson_dw_hdmi_pm_suspend() before
> meson_drv_pm_suspend(), and system resume runs meson_drv_pm_resume()
> before meson_dw_hdmi_pm_resume().
> 
> On suspend, meson_dw_hdmi_pm_suspend() calls phy_exit() while the PHY is
> still powered on, before meson_drv_pm_suspend() ->
> drm_mode_config_helper_suspend() -> dw_hdmi_phy_disable() calls
> phy_power_off().
> 
> On resume, meson_drv_pm_resume() -> drm_mode_config_helper_resume() ->
> dw_hdmi_phy_init() calls phy_configure() and phy_power_on() while
> phy->init_count is still 0.  Then meson_dw_hdmi_pm_resume() runs
> meson_dw_hdmi_init(), which resets hdmitx_phy and calls phy_init(); since
> phy->power_count > phy->init_count, phy_init() warns ("phy_power_on was
> called before phy_init") and runs meson_hdmi_phy_init(), overwriting
> HHI_HDMI_PHY_CNTL0 and HHI_HDMI_PHY_CNTL1 with cntl0_init and cntl1_init
> and clobbering the mode that meson_drv_pm_resume() just configured and
> powered on.
> 

I will put phy_init in dw_hdmi_phy_init and phy_exit in
dw_hdmi_phy_disable for v2.

-- 
Best regards,
Ronald

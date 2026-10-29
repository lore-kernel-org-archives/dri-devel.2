Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE7606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKLvXNsL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB291123C7;
	Thu, 29 Oct 2026 15:24:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958C71123C7;
 Thu, 29 Oct 2026 15:24:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BA6A4308B;
 Thu, 29 Oct 2026 15:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A261F01816;
 Thu, 29 Oct 2026 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793287452;
 bh=Lgd8fgwbirjHQ+5iAWJuOW0Yf9aVXUfWyvj9lr8cQT0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kKLvXNsLO+fE5J0zqkf7bh1q34h/uaracZrMOO0K3Nnd4XGSdqCb674H9nak9UqR1
 f2+k+3yMnnw26oi4TIXUVgKiUAbM6rJVTtL+rQZlNQyIEAPv6BmrtA/IOtvNzIKrLf
 +UjYNgck5WIMGxfWcS4Bl+nnPwnuuQvYVFaYEQIVtw9CLC6o2D6+YweQUPFIN34tmw
 q231QBUuz9HvEfC0DE4+hsyd2wjaz+RNihWTtjKHofxaWFVsJiF5tpM4HAsR7KYGzv
 1aafBlUMu0Eea93KWYMHvJ1lFokNIuf+mHx2f1r3eOGhCz+9jStDYXCF1GUoiJkeUM
 BjS7UdqmI3n1A==
Message-ID: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
Date: Thu, 29 Oct 2026 10:24:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261029151422.56791-1-mike@fireburn.co.uk>
 <20261029151422.56791-3-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261029151422.56791-3-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Rafael

On 10/29/26 10:14, Mike Lothian wrote:
> The AMD CPM D3cold table on the G513QY (BIOS 335) handles the dGPU
> hotplug GPE with:
> 
>    Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }
> 
> On this board the Navi 22 sits behind its on-package PCIe switch, so
> the dGPU node is \_SB.PCI0.GPP0.SWUS.SWDS.VGA_ and every hotplug on the
> USB-C DP alt mode port while the dGPU is in D3cold logs:
> 
>    ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP0.VGA], AE_NOT_FOUND
>    ACPI Error: Aborting method \_GPE._L05 due to previous error (AE_NOT_FOUND)
>    ACPI Error: AE_NOT_FOUND, while evaluating GPE method [_L05]
> 
> The notify is lost, the dGPU stays powered off and the external
> displays stay dark. Masking the GPE (acpi_mask_gpe=0x05), the usual
> workaround, removes the errors but also the hotplug.
> 
> On boards listed in a DMI table, and only when the notify target does
> not resolve, install a handler for the GPE in place of the _Lxx method.
> It requests a runtime resume of the dGPU, which re-detects all links and
> sends a hotplug event, and re-arms the level-triggered GPE from a
> delayed work so it cannot storm while the dGPU powers up. If the
> firmware is fixed, or the path is supplied by an SSDT override, the
> firmware method is left in charge.
> 
> Other boards using the same CPM table may need adding to the list.
> 
> Link: https://forum.endeavouros.com/t/boots-into-black-screen-unresponsive-amd/49430
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>

Can you please post an acpidump to a kernel bugzilla or drm bug 
associated with this issue?

This generally feels like an ACPI interpreter issue to me.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 103 ++++++++++++++++++++++-
>   2 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index deb63122828d..d8a7fea8be9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -642,6 +642,9 @@ struct amdgpu_device {
>   	bool				accel_working;
>   	struct notifier_block		acpi_nb;
>   	bool				acpi_dgpu_notify;
> +	bool				acpi_hpd_gpe_installed;
> +	u32				acpi_hpd_gpe;
> +	struct delayed_work		acpi_hpd_gpe_work;
>   	struct notifier_block		pm_nb;
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct debugfs_blob_wrapper debugfs_vbios_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index a4041f90b374..182791f4cc86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -25,6 +25,7 @@
>   #include <linux/pci.h>
>   #include <linux/acpi.h>
>   #include <linux/backlight.h>
> +#include <linux/dmi.h>
>   #include <linux/slab.h>
>   #include <linux/xarray.h>
>   #include <linux/power_supply.h>
> @@ -1297,6 +1298,103 @@ static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, void *data)
>   	pm_request_resume(adev->dev);
>   }
>   
> +/*
> + * Some AMD CPM D3cold tables handle the dGPU hotplug GPE with
> + * Notify(\_SB.PCI0.GPP0.VGA, 0x81), but on boards where the dGPU sits behind
> + * an on-package PCIe switch the node is \_SB.PCI0.GPP0.SWUS.SWDS.VGA_, so the
> + * _Lxx method aborts with AE_NOT_FOUND and the dGPU is never woken. On those
> + * boards take over the GPE and do what the notify would have done.
> + */
> +struct amdgpu_acpi_hpd_gpe_quirk {
> +	const char *notify_path;
> +	u32 gpe;
> +};
> +
> +static const struct amdgpu_acpi_hpd_gpe_quirk g513qy_hpd_gpe = {
> +	.notify_path = "\\_SB.PCI0.GPP0.VGA",
> +	.gpe = 0x05,
> +};
> +
> +static const struct dmi_system_id amdgpu_acpi_hpd_gpe_quirks[] = {
> +	{
> +		.ident = "ASUS ROG Strix G513QY",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "G513QY"),
> +		},
> +		.driver_data = (void *)&g513qy_hpd_gpe,
> +	},
> +	{}
> +};
> +
> +/* GPE handlers run in interrupt context; the GPE stays disabled until the work re-arms it */
> +static u32 amdgpu_acpi_hpd_gpe_handler(acpi_handle gpe_device, u32 gpe, void *data)
> +{
> +	struct amdgpu_device *adev = data;
> +
> +	pm_request_resume(adev->dev);
> +	schedule_delayed_work(&adev->acpi_hpd_gpe_work, msecs_to_jiffies(500));
> +
> +	return 0;
> +}
> +
> +/*
> + * Re-arm after a delay: the GPE is level triggered and may stay asserted
> + * while the dGPU powers up, so this bounds the rate at which it refires.
> + */
> +static void amdgpu_acpi_hpd_gpe_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device, acpi_hpd_gpe_work.work);
> +
> +	acpi_finish_gpe(NULL, adev->acpi_hpd_gpe);
> +}
> +
> +static void amdgpu_acpi_hpd_gpe_init(struct amdgpu_device *adev)
> +{
> +	const struct amdgpu_acpi_hpd_gpe_quirk *quirk;
> +	const struct dmi_system_id *id;
> +	acpi_handle handle;
> +
> +	id = dmi_first_match(amdgpu_acpi_hpd_gpe_quirks);
> +	if (!id)
> +		return;
> +	quirk = id->driver_data;
> +
> +	/* Firmware (or a table override) already provides the notify target */
> +	if (ACPI_SUCCESS(acpi_get_handle(NULL, quirk->notify_path, &handle)))
> +		return;
> +
> +	adev->acpi_hpd_gpe = quirk->gpe;
> +	INIT_DELAYED_WORK(&adev->acpi_hpd_gpe_work, amdgpu_acpi_hpd_gpe_work);
> +	if (ACPI_FAILURE(acpi_install_gpe_handler(NULL, quirk->gpe,
> +						  ACPI_GPE_LEVEL_TRIGGERED,
> +						  amdgpu_acpi_hpd_gpe_handler,
> +						  adev)))
> +		return;
> +	if (ACPI_FAILURE(acpi_enable_gpe(NULL, quirk->gpe))) {
> +		acpi_remove_gpe_handler(NULL, quirk->gpe,
> +					amdgpu_acpi_hpd_gpe_handler);
> +		return;
> +	}
> +
> +	adev->acpi_hpd_gpe_installed = true;
> +	dev_info(adev->dev, "handling dGPU hotplug GPE 0x%02x (%s missing)\n",
> +		 quirk->gpe, quirk->notify_path);
> +}
> +
> +static void amdgpu_acpi_hpd_gpe_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->acpi_hpd_gpe_installed)
> +		return;
> +
> +	acpi_disable_gpe(NULL, adev->acpi_hpd_gpe);
> +	cancel_delayed_work_sync(&adev->acpi_hpd_gpe_work);
> +	acpi_remove_gpe_handler(NULL, adev->acpi_hpd_gpe,
> +				amdgpu_acpi_hpd_gpe_handler);
> +	adev->acpi_hpd_gpe_installed = false;
> +}
> +
>   /* Call all ACPI methods here */
>   /**
>    * amdgpu_acpi_init - init driver acpi support
> @@ -1343,12 +1441,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   	register_acpi_notifier(&adev->acpi_nb);
>   
>   	if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
> -	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
> +	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>   		adev->acpi_dgpu_notify =
>   			!acpi_dev_install_notify_handler(ACPI_COMPANION(adev->dev),
>   							 ACPI_DEVICE_NOTIFY,
>   							 amdgpu_acpi_dgpu_notify,
>   							 adev);
> +		amdgpu_acpi_hpd_gpe_init(adev);
> +	}
>   
>   	return 0;
>   }
> @@ -1369,6 +1469,7 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
>    */
>   void amdgpu_acpi_fini(struct amdgpu_device *adev)
>   {
> +	amdgpu_acpi_hpd_gpe_fini(adev);
>   	if (adev->acpi_dgpu_notify) {
>   		acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
>   					       ACPI_DEVICE_NOTIFY,


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89521CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D437510F2F8;
	Thu, 30 Apr 2026 10:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XDpIxR2h";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45B710F2F8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777545866;
 bh=5xvj1SNVMa7yEJR1pV7LBGSCEdcQVwemlXk7p/XswTM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XDpIxR2h49UKMOOe6UEGo8iJ5TyvTQKJO97aUgF41H7bdGkRSqO7aGMHnJJ5xwtUJ
 Ue5zzDLkEHyIhPrZ3QNWK55ZnduaufJjPQlV0hYOdFRiESLsrLSkgZj1QLm3OwPhfo
 ceJmsdwP9/76DQZTa7g5MQUCs6GY/lxRQSH3XhjlEwAY/pK+k1nuGV9kjoo3niF2F8
 XxlsblBh5SlcBzmRVUgUIDzWcuxWNOe1ldpOj815FdYZbD6y1WiUq9byiT1MtOljnK
 yofD3S51EkT4vm8YPs6sHwsjSL+IOcRGluRTWRaR3qpYLrd+xpkmNERy5grNqqOOD5
 In/ByLaawUZEQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B7E517E0EBB;
 Thu, 30 Apr 2026 12:44:26 +0200 (CEST)
Date: Thu, 30 Apr 2026 12:44:22 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] drm/panthor: Use a local iomem base for firmware
 control registers
Message-ID: <20260430124422.1ccdd482@fedora>
In-Reply-To: <20260427155934.416502-8-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
 <20260427155934.416502-8-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 27 Apr 2026 16:59:33 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> Add an MCU_CONTROL-local iomem pointer to struct panthor_fw and use it
> for firmware control and status register accesses.
> 
> Job interrupt accesses continue to go through the IRQ-local base, while
> doorbell writes stay on the device-wide mapping because they live
> outside the MCU control window. This keeps firmware register accesses
> scoped to the component that owns them.
> 
> No functional change intended.
> 
> v3:
> - Pick up R-bs from Liviu and Steve
> v2:
> - Pick up Ack from Boris.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Tested-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c      | 20 +++++++++++++-------
>  drivers/gpu/drm/panthor/panthor_fw_regs.h | 11 ++++-------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 73ef07a37e22..986151681b24 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -234,6 +234,9 @@ struct panthor_fw_iface {
>   * struct panthor_fw - Firmware management
>   */
>  struct panthor_fw {
> +	/** @iomem: CPU mapping of MCU_CONTROL iomem region */
> +	void __iomem *iomem;
> +
>  	/** @vm: MCU VM. */
>  	struct panthor_vm *vm;
>  
> @@ -1069,7 +1072,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
>  	if (tracepoint_enabled(gpu_job_irq))
>  		start = ktime_get_ns();
>  
> -	gpu_write(ptdev->iomem, JOB_INT_CLEAR, status);
> +	gpu_write(ptdev->fw->irq.iomem, INT_CLEAR, status);
>  
>  	if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
>  		ptdev->fw->booted = true;
> @@ -1092,18 +1095,19 @@ PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
>  
>  static int panthor_fw_start(struct panthor_device *ptdev)
>  {
> +	struct panthor_fw *fw = ptdev->fw;
>  	bool timedout = false;
>  
>  	ptdev->fw->booted = false;
>  	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
>  	panthor_job_irq_resume(&ptdev->fw->irq);
> -	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
> +	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
>  
>  	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
>  				ptdev->fw->booted,
>  				msecs_to_jiffies(1000))) {
>  		if (!ptdev->fw->booted &&
> -		    !(gpu_read(ptdev->iomem, JOB_INT_STAT) & JOB_INT_GLOBAL_IF))
> +		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
>  			timedout = true;
>  	}
>  
> @@ -1114,7 +1118,7 @@ static int panthor_fw_start(struct panthor_device *ptdev)
>  			[MCU_STATUS_HALT] = "halt",
>  			[MCU_STATUS_FATAL] = "fatal",
>  		};
> -		u32 status = gpu_read(ptdev->iomem, MCU_STATUS);
> +		u32 status = gpu_read(fw->iomem, MCU_STATUS);
>  
>  		drm_err(&ptdev->base, "Failed to boot MCU (status=%s)",
>  			status < ARRAY_SIZE(status_str) ? status_str[status] : "unknown");
> @@ -1126,10 +1130,11 @@ static int panthor_fw_start(struct panthor_device *ptdev)
>  
>  static void panthor_fw_stop(struct panthor_device *ptdev)
>  {
> +	struct panthor_fw *fw = ptdev->fw;
>  	u32 status;
>  
> -	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
> -	if (gpu_read_poll_timeout(ptdev->iomem, MCU_STATUS, status,
> +	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
> +	if (gpu_read_poll_timeout(fw->iomem, MCU_STATUS, status,
>  				  status == MCU_STATUS_DISABLED, 10, 100000))
>  		drm_err(&ptdev->base, "Failed to stop MCU");
>  }
> @@ -1139,7 +1144,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
>  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  	bool halted;
>  
> -	halted = gpu_read(ptdev->iomem, MCU_STATUS) == MCU_STATUS_HALT;
> +	halted = gpu_read(ptdev->fw->iomem, MCU_STATUS) == MCU_STATUS_HALT;
>  
>  	if (panthor_fw_has_glb_state(ptdev))
>  		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
> @@ -1461,6 +1466,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (!fw)
>  		return -ENOMEM;
>  
> +	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
>  	ptdev->fw = fw;
>  	init_waitqueue_head(&fw->req_waitqueue);
>  	INIT_LIST_HEAD(&fw->sections);
> diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
> index eeb41aff249b..b2e59cfc22b0 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
> @@ -4,23 +4,20 @@
>  #ifndef __PANTHOR_FW_REGS_H__
>  #define __PANTHOR_FW_REGS_H__
>  
> -#define MCU_CONTROL					0x700
> +#define MCU_CONTROL_BASE				0x700
> +
> +#define MCU_CONTROL					0x0
>  #define   MCU_CONTROL_ENABLE				1
>  #define   MCU_CONTROL_AUTO				2
>  #define   MCU_CONTROL_DISABLE				0
>  
> -#define MCU_STATUS					0x704
> +#define MCU_STATUS					0x4
>  #define   MCU_STATUS_DISABLED				0
>  #define   MCU_STATUS_ENABLED				1
>  #define   MCU_STATUS_HALT				2
>  #define   MCU_STATUS_FATAL				3
>  
>  #define JOB_INT_BASE					0x1000
> -
> -#define JOB_INT_RAWSTAT					0x1000
> -#define JOB_INT_CLEAR					0x1004
> -#define JOB_INT_MASK					0x1008
> -#define JOB_INT_STAT					0x100c
>  #define   JOB_INT_GLOBAL_IF				BIT(31)
>  #define   JOB_INT_CSG_IF(x)				BIT(x)
>  


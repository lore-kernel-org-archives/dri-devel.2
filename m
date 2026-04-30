Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A4CFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF70410E117;
	Thu, 30 Apr 2026 09:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KuOvwCyH";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id EAC1410E117
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:21:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A9913316;
 Thu, 30 Apr 2026 02:21:28 -0700 (PDT)
Received: from [10.1.25.33] (e122027.cambridge.arm.com [10.1.25.33])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A967F3F7B4;
 Thu, 30 Apr 2026 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777540893; bh=11FhL6oHcdizqfzSgKcgXuLVlmCpRGWAf0wR5upL72Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KuOvwCyH2xdDBPFT95GrCNrt+nahdUyvCWkSPIZSX9uaIGFPZjr/PZy4ysdpOzfJ8
 uZdQ6Vp3EPo7z7I1GGDN0/hcN1bTLuUbXdW6YQIkexHwmLysqfHOiWJAYgUGqFPkrh
 yYxyxoMzZIMwknf9/N/FIUHBBvhWnEcmKMIrvAo4=
Message-ID: <b8cef969-2882-4415-9e94-2edec431217f@arm.com>
Date: Thu, 30 Apr 2026 10:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] drm/panthor: Use a local iomem base for PWR
 registers
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260427155934.416502-1-karunika.choo@arm.com>
 <20260427155934.416502-7-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260427155934.416502-7-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 27/04/2026 16:59, Karunika Choo wrote:
> Add a PWR_CONTROL-local iomem pointer to struct panthor_pwr and switch
> power controller register accesses to that base.
> 
> Update IRQ-local iomem base to use PWR_CONTROl-local iomem and update
> the register definitions so the PWR block can be addressed relative to
> its local base. This removes the remaining dependence on the global
> device MMIO mapping for PWR register accesses. Update
> panthor_gpu_info_init() to also use the correct PWR_CONTROL iomem for
> the *_PRESENT registers.
> 
> No functional change intended.
> 
> v3:
> - Clean up definitions for pwr->iomem and pwr->irq.iomem.
> - Update PWR_INT_BASE to be relative to pwr->iomem.
> v2:
> - Update panthor_gpu_info_init() to use block-local iomem pointer.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++-
>  drivers/gpu/drm/panthor/panthor_pwr.c      | 79 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_pwr_regs.h | 50 +++++++-------
>  3 files changed, 79 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 80aa151d5936..7e315708ca7c 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -221,10 +221,12 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
>  
>  	if (panthor_hw_has_pwr_ctrl(ptdev)) {
> +		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
> +
>  		/* Introduced in arch 14.x */
> -		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, PWR_L2_PRESENT);
> -		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
> -		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
> +		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
> +		ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
> +		ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
>  	} else {
>  		ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
>  		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 705d998447b5..7c7f424a1436 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -40,6 +40,9 @@
>   * struct panthor_pwr - PWR_CONTROL block management data.
>   */
>  struct panthor_pwr {
> +	/** @iomem: CPU mapping of PWR_CONTROL iomem region */
> +	void __iomem *iomem;
> +
>  	/** @irq: PWR irq. */
>  	struct panthor_irq irq;
>  
> @@ -55,8 +58,10 @@ struct panthor_pwr {
>  
>  static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +
>  	spin_lock(&ptdev->pwr->reqs_lock);
> -	gpu_write(ptdev->iomem, PWR_INT_CLEAR, status);
> +	gpu_write(pwr->irq.iomem, INT_CLEAR, status);
>  
>  	if (unlikely(status & PWR_IRQ_COMMAND_NOT_ALLOWED))
>  		drm_err(&ptdev->base, "PWR_IRQ: COMMAND_NOT_ALLOWED");
> @@ -74,15 +79,19 @@ PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>  
>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +
>  	if (args)
> -		gpu_write64(ptdev->iomem, PWR_CMDARG, args);
> +		gpu_write64(pwr->iomem, PWR_CMDARG, args);
>  
> -	gpu_write(ptdev->iomem, PWR_COMMAND, command);
> +	gpu_write(pwr->iomem, PWR_COMMAND, command);
>  }
>  
>  static bool reset_irq_raised(struct panthor_device *ptdev)
>  {
> -	return gpu_read(ptdev->iomem, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +
> +	return gpu_read(pwr->irq.iomem, INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
>  }
>  
>  static bool reset_pending(struct panthor_device *ptdev)
> @@ -92,12 +101,14 @@ static bool reset_pending(struct panthor_device *ptdev)
>  
>  static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +
>  	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock) {
>  		if (reset_pending(ptdev)) {
>  			drm_WARN(&ptdev->base, 1, "Reset already pending");
>  		} else {
>  			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
> -			gpu_write(ptdev->iomem, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
> +			gpu_write(pwr->irq.iomem, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
>  			panthor_pwr_write_command(ptdev, reset_cmd, 0);
>  		}
>  	}
> @@ -182,11 +193,12 @@ static u8 get_domain_subdomain(struct panthor_device *ptdev, u32 domain)
>  static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32 domain,
>  					      u32 timeout_us)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
>  	u32 pwrtrans_reg = get_domain_pwrtrans_reg(domain);
>  	u64 val;
>  	int ret = 0;
>  
> -	ret = gpu_read64_poll_timeout(ptdev->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
> +	ret = gpu_read64_poll_timeout(pwr->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
>  				      timeout_us);
>  	if (ret) {
>  		drm_err(&ptdev->base, "%s domain power in transition, pwrtrans(0x%llx)",
> @@ -199,22 +211,25 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
>  
>  static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +
>  	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
> -	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
> -	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
> -	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
> -	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_READY));
> -	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PRESENT));
> -	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PWRTRANS));
> -	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_READY));
> -	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT));
> -	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PWRTRANS));
> -	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_READY));
> +	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(pwr->iomem, PWR_STATUS));
> +	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PRESENT));
> +	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PWRTRANS));
> +	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(pwr->iomem, PWR_L2_READY));
> +	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PRESENT));
> +	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PWRTRANS));
> +	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_READY));
> +	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PRESENT));
> +	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PWRTRANS));
> +	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_READY));
>  }
>  
>  static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
>  					 u64 mask, u32 timeout_us)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
>  	u32 ready_reg = get_domain_ready_reg(domain);
>  	u32 pwr_cmd = PWR_COMMAND_DEF(cmd, domain, get_domain_subdomain(ptdev, domain));
>  	u64 expected_val = 0;
> @@ -241,12 +256,12 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
>  		return ret;
>  
>  	/* domain already in target state, return early */
> -	if ((gpu_read64(ptdev->iomem, ready_reg) & mask) == expected_val)
> +	if ((gpu_read64(pwr->iomem, ready_reg) & mask) == expected_val)
>  		return 0;
>  
>  	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
>  
> -	ret = gpu_read64_poll_timeout(ptdev->iomem, ready_reg, val, (mask & val) == expected_val,
> +	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
>  				      100, timeout_us);
>  	if (ret) {
>  		drm_err(&ptdev->base,
> @@ -279,8 +294,9 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
>   */
>  static int retract_domain(struct panthor_device *ptdev, u32 domain)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
>  	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_RETRACT, domain, 0);
> -	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
> +	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
>  	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
>  	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
>  	u64 val;
> @@ -289,7 +305,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
>  	if (drm_WARN_ON(&ptdev->base, domain == PWR_COMMAND_DOMAIN_L2))
>  		return -EPERM;
>  
> -	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
> +	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
>  				      !(PWR_STATUS_RETRACT_PENDING & val), 0,
>  				      PWR_RETRACT_TIMEOUT_US);
>  	if (ret) {
> @@ -308,7 +324,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
>  	 * On successful retraction
>  	 * allow-flag will be set with delegated-flag being cleared.
>  	 */
> -	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
> +	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
>  				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
>  				      PWR_TRANSITION_TIMEOUT_US);
>  	if (ret) {
> @@ -334,8 +350,9 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
>   */
>  static int delegate_domain(struct panthor_device *ptdev, u32 domain)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
>  	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_DELEGATE, domain, 0);
> -	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
> +	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
>  	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
>  	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
>  	u64 val;
> @@ -364,7 +381,7 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
>  	 * On successful delegation
>  	 * allow-flag will be cleared with delegated-flag being set.
>  	 */
> -	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
> +	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
>  				      ((delegated_mask | allow_mask) & val) == delegated_mask,
>  				      10, PWR_TRANSITION_TIMEOUT_US);
>  	if (ret) {
> @@ -412,7 +429,8 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
>   */
>  static int panthor_pwr_domain_force_off(struct panthor_device *ptdev, u32 domain)
>  {
> -	const u64 domain_ready = gpu_read64(ptdev->iomem, get_domain_ready_reg(domain));
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +	const u64 domain_ready = gpu_read64(pwr->iomem, get_domain_ready_reg(domain));
>  	int ret;
>  
>  	/* Domain already powered down, early exit. */
> @@ -456,6 +474,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (!pwr)
>  		return -ENOMEM;
>  
> +	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
>  	spin_lock_init(&pwr->reqs_lock);
>  	init_waitqueue_head(&pwr->reqs_acked);
>  	ptdev->pwr = pwr;
> @@ -466,7 +485,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  
>  	err = panthor_request_pwr_irq(
>  		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
> -		ptdev->iomem + PWR_CONTROL_BASE);
> +		pwr->iomem + PWR_INT_BASE);
>  	if (err)
>  		return err;
>  
> @@ -475,7 +494,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  
>  int panthor_pwr_reset_soft(struct panthor_device *ptdev)
>  {
> -	if (!(gpu_read64(ptdev->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +
> +	if (!(gpu_read64(pwr->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
>  		drm_err(&ptdev->base, "RESET_SOFT not allowed");
>  		return -EOPNOTSUPP;
>  	}
> @@ -485,8 +506,9 @@ int panthor_pwr_reset_soft(struct panthor_device *ptdev)
>  
>  void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
>  {
> +	struct panthor_pwr *pwr = ptdev->pwr;
>  	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
> -	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
> +	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
>  
>  	/* Abort if L2 power off constraints are not satisfied */
>  	if (!(pwr_status & l2_allow_mask)) {
> @@ -512,7 +534,8 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
>  
>  int panthor_pwr_l2_power_on(struct panthor_device *ptdev)
>  {
> -	const u32 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
> +	struct panthor_pwr *pwr = ptdev->pwr;
> +	const u32 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
>  	const u32 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
>  	int ret;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> index ad3e446971db..9cf7a715066f 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> @@ -5,12 +5,8 @@
>  #define __PANTHOR_PWR_REGS_H__
>  
>  #define PWR_CONTROL_BASE				0x800
> -#define PWR_CTRL_REG(x)					(PWR_CONTROL_BASE + (x))
>  
> -#define PWR_INT_RAWSTAT					PWR_CTRL_REG(0x0)
> -#define PWR_INT_CLEAR					PWR_CTRL_REG(0x4)
> -#define PWR_INT_MASK					PWR_CTRL_REG(0x8)
> -#define PWR_INT_STAT					PWR_CTRL_REG(0xc)
> +#define PWR_INT_BASE					0x0
>  #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
>  #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
>  #define   PWR_IRQ_DELEGATION_CHANGED			BIT(2)
> @@ -20,7 +16,7 @@
>  #define   PWR_IRQ_COMMAND_NOT_ALLOWED			BIT(30)
>  #define   PWR_IRQ_COMMAND_INVALID			BIT(31)
>  
> -#define PWR_STATUS					PWR_CTRL_REG(0x20)
> +#define PWR_STATUS					0x20
>  #define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
>  #define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
>  #define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
> @@ -41,7 +37,7 @@
>  #define   PWR_STATUS_RETRACT_PENDING			BIT_U64(43)
>  #define   PWR_STATUS_INSPECT_PENDING			BIT_U64(44)
>  
> -#define PWR_COMMAND					PWR_CTRL_REG(0x28)
> +#define PWR_COMMAND					0x28
>  #define   PWR_COMMAND_POWER_UP				0x10
>  #define   PWR_COMMAND_POWER_DOWN			0x11
>  #define   PWR_COMMAND_DELEGATE				0x20
> @@ -58,26 +54,26 @@
>  #define   PWR_COMMAND_DEF(cmd, domain, subdomain)	\
>  	(((subdomain) << 16) | ((domain) << 8) | (cmd))
>  
> -#define PWR_CMDARG					PWR_CTRL_REG(0x30)
> +#define PWR_CMDARG					0x30
>  
> -#define PWR_L2_PRESENT					PWR_CTRL_REG(0x100)
> -#define PWR_L2_READY					PWR_CTRL_REG(0x108)
> -#define PWR_L2_PWRTRANS					PWR_CTRL_REG(0x110)
> -#define PWR_L2_PWRACTIVE				PWR_CTRL_REG(0x118)
> -#define PWR_TILER_PRESENT				PWR_CTRL_REG(0x140)
> -#define PWR_TILER_READY					PWR_CTRL_REG(0x148)
> -#define PWR_TILER_PWRTRANS				PWR_CTRL_REG(0x150)
> -#define PWR_TILER_PWRACTIVE				PWR_CTRL_REG(0x158)
> -#define PWR_SHADER_PRESENT				PWR_CTRL_REG(0x200)
> -#define PWR_SHADER_READY				PWR_CTRL_REG(0x208)
> -#define PWR_SHADER_PWRTRANS				PWR_CTRL_REG(0x210)
> -#define PWR_SHADER_PWRACTIVE				PWR_CTRL_REG(0x218)
> -#define PWR_BASE_PRESENT				PWR_CTRL_REG(0x380)
> -#define PWR_BASE_READY					PWR_CTRL_REG(0x388)
> -#define PWR_BASE_PWRTRANS				PWR_CTRL_REG(0x390)
> -#define PWR_BASE_PWRACTIVE				PWR_CTRL_REG(0x398)
> -#define PWR_STACK_PRESENT				PWR_CTRL_REG(0x3c0)
> -#define PWR_STACK_READY					PWR_CTRL_REG(0x3c8)
> -#define PWR_STACK_PWRTRANS				PWR_CTRL_REG(0x3d0)
> +#define PWR_L2_PRESENT					0x100
> +#define PWR_L2_READY					0x108
> +#define PWR_L2_PWRTRANS					0x110
> +#define PWR_L2_PWRACTIVE				0x118
> +#define PWR_TILER_PRESENT				0x140
> +#define PWR_TILER_READY					0x148
> +#define PWR_TILER_PWRTRANS				0x150
> +#define PWR_TILER_PWRACTIVE				0x158
> +#define PWR_SHADER_PRESENT				0x200
> +#define PWR_SHADER_READY				0x208
> +#define PWR_SHADER_PWRTRANS				0x210
> +#define PWR_SHADER_PWRACTIVE				0x218
> +#define PWR_BASE_PRESENT				0x380
> +#define PWR_BASE_READY					0x388
> +#define PWR_BASE_PWRTRANS				0x390
> +#define PWR_BASE_PWRACTIVE				0x398
> +#define PWR_STACK_PRESENT				0x3c0
> +#define PWR_STACK_READY					0x3c8
> +#define PWR_STACK_PWRTRANS				0x3d0
>  
>  #endif /* __PANTHOR_PWR_REGS_H__ */


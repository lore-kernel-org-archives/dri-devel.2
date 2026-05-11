Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793CCCD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 11:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA4C10E6C4;
	Mon, 11 May 2026 11:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dAPGuwAn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3DC10E6B5
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778500605;
 bh=fsOMd3pIJyzdcD6eb14sTb92heg+iH0DK3F2bWrh/iM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dAPGuwAnq54gGUAaaQDw9ra3LuxEizSVory7RYnraXCgamEJaB39zNAsh/qGkE8Ri
 FcV3QiwKF0khsQaJxUd4Jf2DXMV0aMDtcz5dsHiCUUfejASS9oP+BQ6lJ+ML3si5iy
 2oWBM3dP4Il0H9uXdHgUUfkDpDUGCtprKgb+uZI4lnm/lY7aTYQ+MX0Dw5e+E3/gTt
 XirU3tbXQ74fiEVtGL82x4akt8AEpHAJeuuf59sGXfgewvDnWlNiLDhuOq+XsSZSj6
 VifV4pP3674T9QR0Ry6XuVazqA7m2YS094mWWr4x3Gk1F46OdCreG1Jy3nF9cTPyPP
 /gIVIC0uGrY2g==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F1C017E1004;
 Mon, 11 May 2026 13:56:45 +0200 (CEST)
Date: Mon, 11 May 2026 13:56:41 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Wrap register accessor helpers for type
 safety
Message-ID: <20260511135641.790f797d@fedora>
In-Reply-To: <20260508-panthor-gpu-read-type-v1-1-733a9d8b3a11@collabora.com>
References: <20260508-panthor-gpu-read-type-v1-1-733a9d8b3a11@collabora.com>
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

Hi Nicolas,

On Fri, 08 May 2026 20:00:54 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> In Commit a8f5738779a9 ("drm/panthor: Pass an iomem pointer to GPU
> register access helpers"), the gpu register access helpers were changed
> from taking a pointer to a struct panthor_device in their first
> argument, to taking a void pointer.
> 
> This can cause problems, as patches based on panthor before this change
> will still compile fine after it. struct panthor_device * implicitly
> casts to a void pointer, resulting in completely wrong semantics.
> 
> Prevent this problem by wrapping the affected functions with macros that
> specifically check for and reject the struct panthor_device * type as
> the first argument.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 68 +++++++++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4e4607bca7cc..91e9f499bf69 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -630,49 +630,87 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
>  
>  extern struct workqueue_struct *panthor_cleanup_wq;
>  
> -static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> +static inline void _gpu_write(void __iomem *iomem, u32 reg, u32 data)
>  {
>  	writel(data, iomem + reg);
>  }
>  
> -static inline u32 gpu_read(void __iomem *iomem, u32 reg)
> +static inline u32 _gpu_read(void __iomem *iomem, u32 reg)
>  {
>  	return readl(iomem + reg);
>  }
>  
> -static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
> +static inline u32 _gpu_read_relaxed(void __iomem *iomem, u32 reg)

First off, I'm not a huge fan of these _ prefixes to convey the "internal,
don't use directly" information. If we're going to have macros around these
helpers (meaning these helpers won't be used directly), I'd rather have a
fully descriptive name like gpu_{write,read}_iomem[_relaxed]() and a comment
stating that they should never be used.

>  {
>  	return readl_relaxed(iomem + reg);
>  }
>  
> -static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> +/*
> + * The function signature of gpu_read/gpu_write/gpu_read_relaxed/... used to
> + * take a &struct panthor_device* as the first parameter. During the split of
> + * iomem ranges into individual sub-components, this was changed to take a
> + * void __iomem* instead. These wrappers exists Tto avoid situations wherein
> + * pre-refactor patches are applied in error, as they'd compile fine. That's
> + * because the old calling convention's first parameter implicitly casts to a
> + * void pointer.
> + */
> +
> +#define gpu_write(iomem, reg, data) ({					\
> +	static_assert(!__same_type((iomem), struct panthor_device *));	\

Hm, this only covers ptdev being passed as an iomem pointer. I know it's
the only case we had so far, but if we're going to add type enforcement,
I think I'd prefer if we were covered for more than just ptdev.

One way of doing that would be to wrap the `void __iomem *iomem` in an
explicit type like:

struct panthor_reg_bank {
	void __iomem *iomem;
};

which then gets passed to gpu_{read,write} helpers (see the diff below).

The other way would be to pass the component, and have the macro
do the <component>->iomem deref, but there's a few places where reg banks
are accessed outside of the components that own them (panthor_hw.c).

Regards,

Boris

--->8---
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index cc5720312fa9..0db674dd5f75 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -73,6 +73,10 @@ enum panthor_irq_state {
        PANTHOR_IRQ_STATE_SUSPENDING,
 };
 
+struct panthor_reg_bank {
+       void __iomem *iomem;
+};
+
 /**
  * struct panthor_irq - IRQ data
  *
@@ -82,8 +86,8 @@ struct panthor_irq {
        /** @ptdev: Panthor device */
        struct panthor_device *ptdev;
 
-       /** @iomem: CPU mapping of IRQ base address */
-       void __iomem *iomem;
+       /** @regs: CPU mapping of IRQ base address */
+       struct panthor_reg_bank regs;
 
        /** @irq: IRQ number. */
        int irq;
@@ -519,7 +523,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
        struct panthor_irq *pirq = data;                                                        \
        enum panthor_irq_state old_state;                                                       \
                                                                                                \
-       if (!gpu_read(pirq->iomem, INT_STAT))                                                   \
+       if (!gpu_read(pirq->regs, INT_STAT))                                                    \
                return IRQ_NONE;                                                                \
                                                                                                \
        guard(spinlock_irqsave)(&pirq->mask_lock);                                              \
@@ -529,7 +533,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
        if (old_state != PANTHOR_IRQ_STATE_ACTIVE)                                              \
                return IRQ_NONE;                                                                \
                                                                                                \
-       gpu_write(pirq->iomem, INT_MASK, 0);                                                    \
+       gpu_write(pirq->regs, INT_MASK, 0);                                                     \
        return IRQ_WAKE_THREAD;                                                                 \
 }                                                                                              \
                                                                                                \
@@ -548,7 +552,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
                 * right before the HW event kicks in. TLDR; it's all expected races we're      \
                 * covered for.                                                                 \
                 */                                                                             \
-               u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;                   \
+               u32 status = gpu_read(pirq->regs, INT_RAWSTAT) & pirq->mask;                    \
                                                                                                \
                if (!status)                                                                    \
                        break;                                                                  \
@@ -564,7 +568,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
                                           PANTHOR_IRQ_STATE_PROCESSING,                        \
                                           PANTHOR_IRQ_STATE_ACTIVE);                           \
                if (old_state == PANTHOR_IRQ_STATE_PROCESSING)                                  \
-                       gpu_write(pirq->iomem, INT_MASK, pirq->mask);                           \
+                       gpu_write(pirq->regs, INT_MASK, pirq->mask);                            \
        }                                                                                       \
                                                                                                \
        return ret;                                                                             \
@@ -574,7 +578,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
 {                                                                                              \
        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {                                      \
                atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);                         \
-               gpu_write(pirq->iomem, INT_MASK, 0);                                            \
+               gpu_write(pirq->regs, INT_MASK, 0);                                             \
        }                                                                                       \
        synchronize_irq(pirq->irq);                                                             \
        atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);                                  \
@@ -585,8 +589,8 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
        guard(spinlock_irqsave)(&pirq->mask_lock);                                              \
                                                                                                \
        atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);                                     \
-       gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);                                          \
-       gpu_write(pirq->iomem, INT_MASK, pirq->mask);                                           \
+       gpu_write(pirq->regs, INT_CLEAR, pirq->mask);                                           \
+       gpu_write(pirq->regs, INT_MASK, pirq->mask);                                            \
 }                                                                                              \
                                                                                                \
 static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,                    \
@@ -596,7 +600,7 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,                 \
        pirq->ptdev = ptdev;                                                                    \
        pirq->irq = irq;                                                                        \
        pirq->mask = mask;                                                                      \
-       pirq->iomem = iomem;                                                                    \
+       pirq->regs.iomem = iomem;                                                               \
        spin_lock_init(&pirq->mask_lock);                                                       \
        panthor_ ## __name ## _irq_resume(pirq);                                                \
                                                                                                \
@@ -618,7 +622,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
         * If the IRQ is suspended/suspending, the mask is restored at resume time.             \
         */                                                                                     \
        if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)                              \
-               gpu_write(pirq->iomem, INT_MASK, pirq->mask);                                   \
+               gpu_write(pirq->regs, INT_MASK, pirq->mask);                                    \
 }                                                                                              \
                                                                                                \
 static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
@@ -632,80 +636,80 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
         * If the IRQ is suspended/suspending, the mask is restored at resume time.             \
         */                                                                                     \
        if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)                              \
-               gpu_write(pirq->iomem, INT_MASK, pirq->mask);                                   \
+               gpu_write(pirq->regs, INT_MASK, pirq->mask);                                    \
 }
 
 extern struct workqueue_struct *panthor_cleanup_wq;
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+static inline void gpu_write(struct panthor_reg_bank rbank, u32 reg, u32 data)
 {
-       writel(data, iomem + reg);
+       writel(data, rbank.iomem + reg);
 }
 
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+static inline u32 gpu_read(struct panthor_reg_bank rbank, u32 reg)
 {
-       return readl(iomem + reg);
+       return readl(rbank.iomem + reg);
 }
 
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+static inline u32 gpu_read_relaxed(struct panthor_reg_bank rbank, u32 reg)
 {
-       return readl_relaxed(iomem + reg);
+       return readl_relaxed(rbank.iomem + reg);
 }
 
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+static inline void gpu_write64(struct panthor_reg_bank rbank, u32 reg, u64 data)
 {
-       gpu_write(iomem, reg, lower_32_bits(data));
-       gpu_write(iomem, reg + 4, upper_32_bits(data));
+       gpu_write(rbank, reg, lower_32_bits(data));
+       gpu_write(rbank, reg + 4, upper_32_bits(data));
 }
 
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+static inline u64 gpu_read64(struct panthor_reg_bank rbank, u32 reg)
 {
-       return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+       return (gpu_read(rbank, reg) | ((u64)gpu_read(rbank, reg + 4) << 32));
 }
 
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+static inline u64 gpu_read64_relaxed(struct panthor_reg_bank rbank, u32 reg)
 {
-       return (gpu_read_relaxed(iomem, reg) |
-               ((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+       return (gpu_read_relaxed(rbank, reg) |
+               ((u64)gpu_read_relaxed(rbank, reg + 4) << 32));
 }
 
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+static inline u64 gpu_read64_counter(struct panthor_reg_bank rbank, u32 reg)
 {
        u32 lo, hi1, hi2;
        do {
-               hi1 = gpu_read(iomem, reg + 4);
-               lo = gpu_read(iomem, reg);
-               hi2 = gpu_read(iomem, reg + 4);
+               hi1 = gpu_read(rbank, reg + 4);
+               lo = gpu_read(rbank, reg);
+               hi2 = gpu_read(rbank, reg + 4);
        } while (hi1 != hi2);
        return lo | ((u64)hi2 << 32);
 }
 
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)     \
+#define gpu_read_poll_timeout(rbank, reg, val, cond, delay_us, timeout_us)     \
        read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,     \
-                         iomem, reg)
+                         rbank, reg)
 
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,          \
+#define gpu_read_poll_timeout_atomic(rbank, reg, val, cond, delay_us,          \
                                     timeout_us)                                \
        read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,     \
-                                false, iomem, reg)
+                                false, rbank, reg)
 
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)   \
+#define gpu_read64_poll_timeout(rbank, reg, val, cond, delay_us, timeout_us)   \
        read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,   \
-                         iomem, reg)
+                         rbank, reg)
 
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,                \
+#define gpu_read64_poll_timeout_atomic(rbank, reg, val, cond, delay_us,                \
                                       timeout_us)                              \
        read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,   \
-                                false, iomem, reg)
+                                false, rbank, reg)
 
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,  \
+#define gpu_read_relaxed_poll_timeout_atomic(rbank, reg, val, cond, delay_us,  \
                                             timeout_us)                        \
        read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,         \
-                                timeout_us, false, iomem, reg)
+                                timeout_us, false, rbank, reg)
 
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,       \
+#define gpu_read64_relaxed_poll_timeout(rbank, reg, val, cond, delay_us,       \
                                        timeout_us)                             \
        read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,  \
-                         false, iomem, reg)
+                         false, rbank, reg)
 
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..a2876c99ac54 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -234,8 +234,8 @@ struct panthor_fw_iface {
  * struct panthor_fw - Firmware management
  */
 struct panthor_fw {
-       /** @iomem: CPU mapping of MCU_CONTROL iomem region */
-       void __iomem *iomem;
+       /** @regs: CPU mapping of MCU_CONTROL iomem region */
+       struct panthor_reg_bank regs;
 
        /** @vm: MCU VM. */
        struct panthor_vm *vm;
@@ -1072,7 +1072,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
        if (tracepoint_enabled(gpu_job_irq))
                start = ktime_get_ns();
 
-       gpu_write(ptdev->fw->irq.iomem, INT_CLEAR, status);
+       gpu_write(ptdev->fw->irq.regs, INT_CLEAR, status);
 
        if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
                ptdev->fw->booted = true;
@@ -1101,13 +1101,13 @@ static int panthor_fw_start(struct panthor_device *ptdev)
        ptdev->fw->booted = false;
        panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
        panthor_job_irq_resume(&ptdev->fw->irq);
-       gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
+       gpu_write(fw->regs, MCU_CONTROL, MCU_CONTROL_AUTO);
 
        if (!wait_event_timeout(ptdev->fw->req_waitqueue,
                                ptdev->fw->booted,
                                msecs_to_jiffies(1000))) {
                if (!ptdev->fw->booted &&
-                   !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
+                   !(gpu_read(fw->irq.regs, INT_STAT) & JOB_INT_GLOBAL_IF))
                        timedout = true;
        }
 
@@ -1118,7 +1118,7 @@ static int panthor_fw_start(struct panthor_device *ptdev)
                        [MCU_STATUS_HALT] = "halt",
                        [MCU_STATUS_FATAL] = "fatal",
                };
-               u32 status = gpu_read(fw->iomem, MCU_STATUS);
+               u32 status = gpu_read(fw->regs, MCU_STATUS);
 
                drm_err(&ptdev->base, "Failed to boot MCU (status=%s)",
                        status < ARRAY_SIZE(status_str) ? status_str[status] : "unknown");
@@ -1133,8 +1133,8 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
        struct panthor_fw *fw = ptdev->fw;
        u32 status;
 
-       gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
-       if (gpu_read_poll_timeout(fw->iomem, MCU_STATUS, status,
+       gpu_write(fw->regs, MCU_CONTROL, MCU_CONTROL_DISABLE);
+       if (gpu_read_poll_timeout(fw->regs, MCU_STATUS, status,
                                  status == MCU_STATUS_DISABLED, 10, 100000))
                drm_err(&ptdev->base, "Failed to stop MCU");
 }
@@ -1144,7 +1144,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
        struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
        bool halted;
 
-       halted = gpu_read(ptdev->fw->iomem, MCU_STATUS) == MCU_STATUS_HALT;
+       halted = gpu_read(ptdev->fw->regs, MCU_STATUS) == MCU_STATUS_HALT;
 
        if (panthor_fw_has_glb_state(ptdev))
                halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
@@ -1407,7 +1407,11 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
 
 void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id)
 {
-       gpu_write(ptdev->iomem, CSF_DOORBELL(doorbell_id), 1);
+       const struct panthor_reg_bank db_regs = {
+               .iomem = ptdev->iomem,
+       };
+
+       gpu_write(db_regs, CSF_DOORBELL(doorbell_id), 1);
 }
 
 /**
@@ -1466,7 +1470,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
        if (!fw)
                return -ENOMEM;
 
-       fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
+       fw->regs.iomem = ptdev->iomem + MCU_CONTROL_BASE;
        ptdev->fw = fw;
        init_waitqueue_head(&fw->req_waitqueue);
        INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index e52c5675981f..2fa625bedb36 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -29,8 +29,8 @@
  * struct panthor_gpu - GPU block management data.
  */
 struct panthor_gpu {
-       /** @iomem: CPU mapping of GPU_CONTROL iomem region */
-       void __iomem *iomem;
+       /** @regs: CPU mapping of GPU_CONTROL regs region */
+       struct panthor_reg_bank regs;
 
        /** @irq: GPU irq. */
        struct panthor_irq irq;
@@ -59,7 +59,7 @@ struct panthor_gpu {
 
 static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 {
-       gpu_write(ptdev->gpu->iomem, GPU_COHERENCY_PROTOCOL,
+       gpu_write(ptdev->gpu->regs, GPU_COHERENCY_PROTOCOL,
                  ptdev->gpu_info.selected_coherency);
 }
 
@@ -79,28 +79,28 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
        }
 
        for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
-               gpu_write(gpu->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
+               gpu_write(gpu->regs, GPU_ASN_HASH(i), data->asn_hash[i]);
 
-       l2_config = gpu_read(gpu->iomem, GPU_L2_CONFIG);
+       l2_config = gpu_read(gpu->regs, GPU_L2_CONFIG);
        l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
-       gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
+       gpu_write(gpu->regs, GPU_L2_CONFIG, l2_config);
 }
 
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
        struct panthor_gpu *gpu = ptdev->gpu;
 
-       gpu_write(gpu->irq.iomem, INT_CLEAR, status);
+       gpu_write(gpu->irq.regs, INT_CLEAR, status);
 
        if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
                trace_gpu_power_status(ptdev->base.dev,
-                                      gpu_read64(gpu->iomem, SHADER_READY),
-                                      gpu_read64(gpu->iomem, TILER_READY),
-                                      gpu_read64(gpu->iomem, L2_READY));
+                                      gpu_read64(gpu->regs, SHADER_READY),
+                                      gpu_read64(gpu->regs, TILER_READY),
+                                      gpu_read64(gpu->regs, L2_READY));
 
        if (status & GPU_IRQ_FAULT) {
-               u32 fault_status = gpu_read(gpu->iomem, GPU_FAULT_STATUS);
-               u64 address = gpu_read64(gpu->iomem, GPU_FAULT_ADDR);
+               u32 fault_status = gpu_read(gpu->regs, GPU_FAULT_STATUS);
+               u64 address = gpu_read64(gpu->regs, GPU_FAULT_ADDR);
 
                drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
                         fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
@@ -153,7 +153,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
        if (!gpu)
                return -ENOMEM;
 
-       gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
+       gpu->regs.iomem = ptdev->iomem + GPU_CONTROL_BASE;
        spin_lock_init(&gpu->reqs_lock);
        init_waitqueue_head(&gpu->reqs_acked);
        mutex_init(&gpu->cache_flush_lock);
@@ -171,7 +171,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 
        ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
                                      GPU_INTERRUPTS_MASK,
-                                     ptdev->iomem + GPU_INT_BASE);
+                                     gpu->regs.iomem + GPU_INT_BASE);
        if (ret)
                return ret;
 
@@ -214,7 +214,7 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
        u32 val;
        int ret;
 
-       ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
+       ret = gpu_read64_relaxed_poll_timeout(gpu->regs, pwrtrans_reg, val,
                                              !(mask & val), 100, timeout_us);
        if (ret) {
                drm_err(&ptdev->base,
@@ -223,9 +223,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
                return ret;
        }
 
-       gpu_write64(gpu->iomem, pwroff_reg, mask);
+       gpu_write64(gpu->regs, pwroff_reg, mask);
 
-       ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
+       ret = gpu_read64_relaxed_poll_timeout(gpu->regs, pwrtrans_reg, val,
                                              !(mask & val), 100, timeout_us);
        if (ret) {
                drm_err(&ptdev->base,
@@ -258,7 +258,7 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
        u32 val;
        int ret;
 
-       ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
+       ret = gpu_read64_relaxed_poll_timeout(gpu->regs, pwrtrans_reg, val,
                                              !(mask & val), 100, timeout_us);
        if (ret) {
                drm_err(&ptdev->base,
@@ -267,9 +267,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
                return ret;
        }
 
-       gpu_write64(gpu->iomem, pwron_reg, mask);
+       gpu_write64(gpu->regs, pwron_reg, mask);
 
-       ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, rdy_reg, val,
+       ret = gpu_read64_relaxed_poll_timeout(gpu->regs, rdy_reg, val,
                                              (mask & val) == val,
                                              100, timeout_us);
        if (ret) {
@@ -338,7 +338,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
        spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
        if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
                ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-               gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+               gpu_write(gpu->regs, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
        } else {
                ret = -EIO;
        }
@@ -352,7 +352,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
                                msecs_to_jiffies(100))) {
                spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
                if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-                   !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+                   !(gpu_read(gpu->irq.regs, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
                        ret = -ETIMEDOUT;
                else
                        ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
@@ -383,8 +383,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
        if (!drm_WARN_ON(&ptdev->base,
                         ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
                ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
-               gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-               gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
+               gpu_write(gpu->irq.regs, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
+               gpu_write(gpu->regs, GPU_CMD, GPU_SOFT_RESET);
        }
        spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
@@ -393,7 +393,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
                                msecs_to_jiffies(100))) {
                spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
                if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
-                   !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
+                   !(gpu_read(gpu->irq.regs, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
                        timedout = true;
                else
                        ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
@@ -442,17 +442,17 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 
 u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
 {
-       return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
+       return gpu_read64_counter(ptdev->gpu->regs, GPU_TIMESTAMP);
 }
 
 u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
 {
-       return gpu_read64(ptdev->gpu->iomem, GPU_TIMESTAMP_OFFSET);
+       return gpu_read64(ptdev->gpu->regs, GPU_TIMESTAMP_OFFSET);
 }
 
 u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
 {
-       return gpu_read64_counter(ptdev->gpu->iomem, GPU_CYCLE_COUNT);
+       return gpu_read64_counter(ptdev->gpu->regs, GPU_CYCLE_COUNT);
 }
 
 int panthor_gpu_coherency_init(struct panthor_device *ptdev)
@@ -471,7 +471,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
        /* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
         * ACE protocol has never been supported for command stream frontend GPUs.
         */
-       if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
+       if ((gpu_read(ptdev->gpu->regs, GPU_COHERENCY_FEATURES) &
                      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
                ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
                return 0;
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 7e315708ca7c..b7c683d1c425 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -193,44 +193,47 @@ static int overload_shader_present(struct panthor_device *ptdev)
 
 static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
+       const struct panthor_reg_bank gpu_regs = {
+               .iomem = ptdev->iomem + GPU_CONTROL_BASE,
+       };
        unsigned int i;
 
-       void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
-
-       ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
-       ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
-       ptdev->gpu_info.core_features = gpu_read(gpu_iomem, GPU_CORE_FEATURES);
-       ptdev->gpu_info.l2_features = gpu_read(gpu_iomem, GPU_L2_FEATURES);
-       ptdev->gpu_info.tiler_features = gpu_read(gpu_iomem, GPU_TILER_FEATURES);
-       ptdev->gpu_info.mem_features = gpu_read(gpu_iomem, GPU_MEM_FEATURES);
-       ptdev->gpu_info.mmu_features = gpu_read(gpu_iomem, GPU_MMU_FEATURES);
-       ptdev->gpu_info.thread_features = gpu_read(gpu_iomem, GPU_THREAD_FEATURES);
-       ptdev->gpu_info.max_threads = gpu_read(gpu_iomem, GPU_THREAD_MAX_THREADS);
+       ptdev->gpu_info.csf_id = gpu_read(gpu_regs, GPU_CSF_ID);
+       ptdev->gpu_info.gpu_rev = gpu_read(gpu_regs, GPU_REVID);
+       ptdev->gpu_info.core_features = gpu_read(gpu_regs, GPU_CORE_FEATURES);
+       ptdev->gpu_info.l2_features = gpu_read(gpu_regs, GPU_L2_FEATURES);
+       ptdev->gpu_info.tiler_features = gpu_read(gpu_regs, GPU_TILER_FEATURES);
+       ptdev->gpu_info.mem_features = gpu_read(gpu_regs, GPU_MEM_FEATURES);
+       ptdev->gpu_info.mmu_features = gpu_read(gpu_regs, GPU_MMU_FEATURES);
+       ptdev->gpu_info.thread_features = gpu_read(gpu_regs, GPU_THREAD_FEATURES);
+       ptdev->gpu_info.max_threads = gpu_read(gpu_regs, GPU_THREAD_MAX_THREADS);
        ptdev->gpu_info.thread_max_workgroup_size =
-               gpu_read(gpu_iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
+               gpu_read(gpu_regs, GPU_THREAD_MAX_WORKGROUP_SIZE);
        ptdev->gpu_info.thread_max_barrier_size =
-               gpu_read(gpu_iomem, GPU_THREAD_MAX_BARRIER_SIZE);
-       ptdev->gpu_info.coherency_features = gpu_read(gpu_iomem, GPU_COHERENCY_FEATURES);
+               gpu_read(gpu_regs, GPU_THREAD_MAX_BARRIER_SIZE);
+       ptdev->gpu_info.coherency_features = gpu_read(gpu_regs, GPU_COHERENCY_FEATURES);
        for (i = 0; i < 4; i++)
                ptdev->gpu_info.texture_features[i] =
-                       gpu_read(gpu_iomem, GPU_TEXTURE_FEATURES(i));
+                       gpu_read(gpu_regs, GPU_TEXTURE_FEATURES(i));
 
-       ptdev->gpu_info.as_present = gpu_read(gpu_iomem, GPU_AS_PRESENT);
+       ptdev->gpu_info.as_present = gpu_read(gpu_regs, GPU_AS_PRESENT);
 
        /* Introduced in arch 11.x */
-       ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
+       ptdev->gpu_info.gpu_features = gpu_read64(gpu_regs, GPU_FEATURES);
 
        if (panthor_hw_has_pwr_ctrl(ptdev)) {
-               void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+               const struct panthor_reg_bank pwr_regs = {
+                       .iomem = gpu_regs.iomem + PWR_CONTROL_BASE,
+               };
 
                /* Introduced in arch 14.x */
-               ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
-               ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
-               ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
+               ptdev->gpu_info.l2_present = gpu_read64(pwr_regs, PWR_L2_PRESENT);
+               ptdev->gpu_info.tiler_present = gpu_read64(pwr_regs, PWR_TILER_PRESENT);
+               ptdev->gpu_info.shader_present = gpu_read64(pwr_regs, PWR_SHADER_PRESENT);
        } else {
-               ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
-               ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
-               ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
+               ptdev->gpu_info.shader_present = gpu_read64(gpu_regs, GPU_SHADER_PRESENT);
+               ptdev->gpu_info.tiler_present = gpu_read64(gpu_regs, GPU_TILER_PRESENT);
+               ptdev->gpu_info.l2_present = gpu_read64(gpu_regs, GPU_L2_PRESENT);
        }
 
        return overload_shader_present(ptdev);
@@ -295,7 +298,11 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
-       ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+       const struct panthor_reg_bank gpu_regs = {
+               .iomem = ptdev->iomem,
+       };
+
+       ptdev->gpu_info.gpu_id = gpu_read(gpu_regs, GPU_ID);
        if (!ptdev->gpu_info.gpu_id)
                return -ENXIO;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 9d4500850561..d4cc105afe24 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -55,8 +55,8 @@ struct panthor_as_slot {
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
-       /** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-       void __iomem *iomem;
+       /** @regs: CPU mapping of MMU_AS_CONTROL iomem region */
+       struct panthor_reg_bank regs;
 
        /** @irq: The MMU irq. */
        struct panthor_irq irq;
@@ -527,7 +527,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
        /* Wait for the MMU status to indicate there is no active command, in
         * case one is pending.
         */
-       ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+       ret = gpu_read_relaxed_poll_timeout_atomic(mmu->regs, AS_STATUS(as_nr), val,
                                                   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
        if (ret) {
@@ -545,7 +545,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
        /* write AS_COMMAND when MMU is ready to accept another command */
        status = wait_ready(ptdev, as_nr);
        if (!status) {
-               gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
+               gpu_write(ptdev->mmu->regs, AS_COMMAND(as_nr), cmd);
                status = wait_ready(ptdev, as_nr);
        }
 
@@ -598,9 +598,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
        panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
                                      panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-       gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-       gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-       gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+       gpu_write64(mmu->regs, AS_TRANSTAB(as_nr), transtab);
+       gpu_write64(mmu->regs, AS_MEMATTR(as_nr), memattr);
+       gpu_write64(mmu->regs, AS_TRANSCFG(as_nr), transcfg);
 
        return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -636,9 +636,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
        if (recycle_slot)
                return 0;
 
-       gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-       gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-       gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+       gpu_write64(mmu->regs, AS_TRANSTAB(as_nr), 0);
+       gpu_write64(mmu->regs, AS_MEMATTR(as_nr), 0);
+       gpu_write64(mmu->regs, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
        return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -791,7 +791,7 @@ int panthor_vm_active(struct panthor_vm *vm)
         */
        fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
        if (ptdev->mmu->as.faulty_mask & fault_mask) {
-               gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
+               gpu_write(ptdev->mmu->irq.regs, INT_CLEAR, fault_mask);
                ptdev->mmu->as.faulty_mask &= ~fault_mask;
        }
 
@@ -1738,7 +1738,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
        mutex_lock(&ptdev->mmu->as.slots_lock);
        if (vm->as.id >= 0 && size) {
                /* Lock the region that needs to be updated */
-               gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+               gpu_write64(ptdev->mmu->regs, AS_LOCKADDR(vm->as.id),
                            pack_region_range(ptdev, &start, &size));
 
                /* If the lock succeeded, update the locked_region info. */
@@ -1800,8 +1800,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
                u32 access_type;
                u32 source_id;
 
-               fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-               addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+               fault_status = gpu_read(mmu->regs, AS_FAULTSTATUS(as));
+               addr = gpu_read64(mmu->regs, AS_FAULTADDRESS(as));
 
                /* decode the fault status */
                exception_type = fault_status & 0xFF;
@@ -1832,7 +1832,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
                 * Note that COMPLETED irqs are never cleared, but this is fine
                 * because they are always masked.
                 */
-               gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
+               gpu_write(mmu->irq.regs, INT_CLEAR, mask);
 
                if (ptdev->mmu->as.slots[as].vm)
                        ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
@@ -3255,7 +3255,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
        if (ret)
                return ret;
 
-       mmu->iomem = ptdev->iomem + MMU_AS_BASE;
+       mmu->regs.iomem = ptdev->iomem + MMU_AS_BASE;
        ptdev->mmu = mmu;
 
        irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
@@ -3264,7 +3264,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 
        ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
                                      panthor_mmu_fault_mask(ptdev, ~0),
-                                     ptdev->iomem + MMU_INT_BASE);
+                                     mmu->regs.iomem + MMU_INT_BASE);
        if (ret)
                return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 7c7f424a1436..5db98ccd1a0b 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -40,8 +40,8 @@
  * struct panthor_pwr - PWR_CONTROL block management data.
  */
 struct panthor_pwr {
-       /** @iomem: CPU mapping of PWR_CONTROL iomem region */
-       void __iomem *iomem;
+       /** @regs: CPU mapping of PWR_CONTROL iomem region */
+       struct panthor_reg_bank regs;
 
        /** @irq: PWR irq. */
        struct panthor_irq irq;
@@ -61,7 +61,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
        struct panthor_pwr *pwr = ptdev->pwr;
 
        spin_lock(&ptdev->pwr->reqs_lock);
-       gpu_write(pwr->irq.iomem, INT_CLEAR, status);
+       gpu_write(pwr->irq.regs, INT_CLEAR, status);
 
        if (unlikely(status & PWR_IRQ_COMMAND_NOT_ALLOWED))
                drm_err(&ptdev->base, "PWR_IRQ: COMMAND_NOT_ALLOWED");
@@ -82,16 +82,16 @@ static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command,
        struct panthor_pwr *pwr = ptdev->pwr;
 
        if (args)
-               gpu_write64(pwr->iomem, PWR_CMDARG, args);
+               gpu_write64(pwr->regs, PWR_CMDARG, args);
 
-       gpu_write(pwr->iomem, PWR_COMMAND, command);
+       gpu_write(pwr->regs, PWR_COMMAND, command);
 }
 
 static bool reset_irq_raised(struct panthor_device *ptdev)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
 
-       return gpu_read(pwr->irq.iomem, INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
+       return gpu_read(pwr->irq.regs, INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
 }
 
 static bool reset_pending(struct panthor_device *ptdev)
@@ -108,7 +108,7 @@ static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
                        drm_WARN(&ptdev->base, 1, "Reset already pending");
                } else {
                        ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
-                       gpu_write(pwr->irq.iomem, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
+                       gpu_write(pwr->irq.regs, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
                        panthor_pwr_write_command(ptdev, reset_cmd, 0);
                }
        }
@@ -198,7 +198,7 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
        u64 val;
        int ret = 0;
 
-       ret = gpu_read64_poll_timeout(pwr->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
+       ret = gpu_read64_poll_timeout(pwr->regs, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
                                      timeout_us);
        if (ret) {
                drm_err(&ptdev->base, "%s domain power in transition, pwrtrans(0x%llx)",
@@ -214,16 +214,16 @@ static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
        struct panthor_pwr *pwr = ptdev->pwr;
 
        drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
-       drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(pwr->iomem, PWR_STATUS));
-       drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PRESENT));
-       drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(pwr->iomem, PWR_L2_PWRTRANS));
-       drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(pwr->iomem, PWR_L2_READY));
-       drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PRESENT));
-       drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_PWRTRANS));
-       drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(pwr->iomem, PWR_TILER_READY));
-       drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PRESENT));
-       drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PWRTRANS));
-       drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_READY));
+       drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(pwr->regs, PWR_STATUS));
+       drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(pwr->regs, PWR_L2_PRESENT));
+       drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(pwr->regs, PWR_L2_PWRTRANS));
+       drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(pwr->regs, PWR_L2_READY));
+       drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(pwr->regs, PWR_TILER_PRESENT));
+       drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(pwr->regs, PWR_TILER_PWRTRANS));
+       drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(pwr->regs, PWR_TILER_READY));
+       drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->regs, PWR_SHADER_PRESENT));
+       drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->regs, PWR_SHADER_PWRTRANS));
+       drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->regs, PWR_SHADER_READY));
 }
 
 static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
@@ -256,12 +256,12 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
                return ret;
 
        /* domain already in target state, return early */
-       if ((gpu_read64(pwr->iomem, ready_reg) & mask) == expected_val)
+       if ((gpu_read64(pwr->regs, ready_reg) & mask) == expected_val)
                return 0;
 
        panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-       ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
+       ret = gpu_read64_poll_timeout(pwr->regs, ready_reg, val, (mask & val) == expected_val,
                                      100, timeout_us);
        if (ret) {
                drm_err(&ptdev->base,
@@ -296,7 +296,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
        const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_RETRACT, domain, 0);
-       const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
+       const u64 pwr_status = gpu_read64(pwr->regs, PWR_STATUS);
        const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
        const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
        u64 val;
@@ -305,7 +305,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
        if (drm_WARN_ON(&ptdev->base, domain == PWR_COMMAND_DOMAIN_L2))
                return -EPERM;
 
-       ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
+       ret = gpu_read64_poll_timeout(pwr->regs, PWR_STATUS, val,
                                      !(PWR_STATUS_RETRACT_PENDING & val), 0,
                                      PWR_RETRACT_TIMEOUT_US);
        if (ret) {
@@ -324,7 +324,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
         * On successful retraction
         * allow-flag will be set with delegated-flag being cleared.
         */
-       ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
+       ret = gpu_read64_poll_timeout(pwr->regs, PWR_STATUS, val,
                                      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
                                      PWR_TRANSITION_TIMEOUT_US);
        if (ret) {
@@ -352,7 +352,7 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
        const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_DELEGATE, domain, 0);
-       const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
+       const u64 pwr_status = gpu_read64(pwr->regs, PWR_STATUS);
        const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
        const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
        u64 val;
@@ -381,7 +381,7 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
         * On successful delegation
         * allow-flag will be cleared with delegated-flag being set.
         */
-       ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
+       ret = gpu_read64_poll_timeout(pwr->regs, PWR_STATUS, val,
                                      ((delegated_mask | allow_mask) & val) == delegated_mask,
                                      10, PWR_TRANSITION_TIMEOUT_US);
        if (ret) {
@@ -430,7 +430,7 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
 static int panthor_pwr_domain_force_off(struct panthor_device *ptdev, u32 domain)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
-       const u64 domain_ready = gpu_read64(pwr->iomem, get_domain_ready_reg(domain));
+       const u64 domain_ready = gpu_read64(pwr->regs, get_domain_ready_reg(domain));
        int ret;
 
        /* Domain already powered down, early exit. */
@@ -474,7 +474,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
        if (!pwr)
                return -ENOMEM;
 
-       pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
+       pwr->regs.iomem = ptdev->iomem + PWR_CONTROL_BASE;
        spin_lock_init(&pwr->reqs_lock);
        init_waitqueue_head(&pwr->reqs_acked);
        ptdev->pwr = pwr;
@@ -485,7 +485,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
        err = panthor_request_pwr_irq(
                ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
-               pwr->iomem + PWR_INT_BASE);
+               pwr->regs.iomem + PWR_INT_BASE);
        if (err)
                return err;
 
@@ -496,7 +496,7 @@ int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
 
-       if (!(gpu_read64(pwr->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
+       if (!(gpu_read64(pwr->regs, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
                drm_err(&ptdev->base, "RESET_SOFT not allowed");
                return -EOPNOTSUPP;
        }
@@ -508,7 +508,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
        const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
-       const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
+       const u64 pwr_status = gpu_read64(pwr->regs, PWR_STATUS);
 
        /* Abort if L2 power off constraints are not satisfied */
        if (!(pwr_status & l2_allow_mask)) {
@@ -535,7 +535,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 int panthor_pwr_l2_power_on(struct panthor_device *ptdev)
 {
        struct panthor_pwr *pwr = ptdev->pwr;
-       const u32 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
+       const u32 pwr_status = gpu_read64(pwr->regs, PWR_STATUS);
        const u32 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
        int ret;
 

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA21CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 18:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811B610F57E;
	Thu, 28 May 2026 18:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YbJBEHFs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6427E10F57E
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X/4dOKqfdpaAMhOZRsLuzWvKhDAyX7Vs6E7WcICztQU=; b=YbJBEHFsIcoHlIU4jSXrU5lbtz
 pgQvYScW5CDYqjuNV9M12TpndJ3o0f27cAUVFePCar2QbwGAYxYx4pU61tBgxkDqa1BeZQ47SkVqL
 0QLr0k8UgXtFkfazW+t1EmfcfZ304F7pG5Lhk0nCd2+voomS5kMuIKfgt9QChknyp54okjZeGCcpC
 CDWnqVZ1pmrOnwTjHGYXi/mq8RUHkUTEq/yZDbFBx6KiYhT7UfRF3P6iT58roTv2HYItuRPFBvJke
 LjtDPH7PdprxN90ADjQlNeR7hYPYQQ6L9lVVgrNNzBZ+hpIpxNW1oxtwmfE4s1nRk83zt1OW0nTdZ
 Ty+/Qb8Q==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wSfu5-009VbN-1A; Thu, 28 May 2026 20:56:25 +0200
Message-ID: <34b59ada-940b-46ce-b376-bc372190633b@igalia.com>
Date: Thu, 28 May 2026 15:56:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel: ethosu: Add performance counter support
To: Tomeu Vizoso <tomeu.vizoso@gmail.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ARM ETHOS-U NPU DRIVER" <dri-devel@lists.freedesktop.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260515032625.1880618-1-robh@kernel.org>
 <20260523083730.255310-1-tomeu@tomeuvizoso.net>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260523083730.255310-1-tomeu@tomeuvizoso.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tomeu,

On 23/05/26 05:37, Tomeu Vizoso wrote:
> From: "Rob Herring (Arm)" <robh@kernel.org>
> 
> The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> different events. There is also a dedicated cycle counter.
> 
> The ABI and implementation are copied from the V3D driver. The main
> difference in the ABI is there is no query API for the the event list.
> The events differ between the U65 and U85, so the events lists are
> maintained in userspace along with other differences between the U65 and
> U85.
> 
> The cycle counter is always enabled when the PMU is enabled. When the
> user requests N events, reading the counters will return the N events
> plus the cycle counter.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Just small nits below. Feel free to fix it when applying it.

> ---
> v2:
>   - Use XArray instead of idr
>   - Rework locking to use per device spinlock to protect modifying active
>     perfmon. Based on pending V3D changes:
>     https://lore.kernel.org/all/20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com/
>   - Add missing perfmon puts in ethosu_ioctl_perfmon_set_global() and
>     ethosu_ioctl_perfmon_get_values() error paths.
>   - Fix reading number of counters on U85.
>   - Add defines NPU_REG_PMCCNTR_CFG
> 
> v3:
>   - Add explicit padding to drm_ethosu_perfmon_destroy
>   - Fix SPDX license expression
>   - Fix comment typos
>   - Convert perfmon lock from spinlock to mutex
>   - Simplify switch_perfmon condition check
>   - Remove unused ethosu_perfmon_init
>   - Add lockdep_assert_held to ethosu_perfmon_stop_locked
> ---
>   drivers/accel/ethosu/Makefile         |   2 +-
>   drivers/accel/ethosu/ethosu_device.h  |  33 +++
>   drivers/accel/ethosu/ethosu_drv.c     |  23 +-
>   drivers/accel/ethosu/ethosu_drv.h     |  61 +++++-
>   drivers/accel/ethosu/ethosu_job.c     |  39 +++-
>   drivers/accel/ethosu/ethosu_job.h     |   2 +
>   drivers/accel/ethosu/ethosu_perfmon.c | 298 ++++++++++++++++++++++++++
>   include/uapi/drm/ethosu_accel.h       |  60 +++++-
>   8 files changed, 504 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c
> 

[...]


> @@ -312,11 +318,16 @@ static int ethosu_init(struct ethosu_device *ethosudev)
>   
>   	ethosudev->npu_info.id = id = readl_relaxed(ethosudev->regs + NPU_REG_ID);
>   	ethosudev->npu_info.config = config = readl_relaxed(ethosudev->regs + NPU_REG_CONFIG);
> -

I believe this doesn't belong to this patch.

>   	ethosu_sram_init(ethosudev);
>   
> +	if (!ethosu_is_u65(ethosudev))
> +		ethosudev->pmu_regs += 0x1000;
> +
> +	ethosudev->npu_info.pmu_counters = FIELD_GET(PMCR_NUM_EVENT_CNT_MASK,
> +		readl_relaxed(ethosudev->pmu_regs + NPU_REG_PMCR));
> +
>   	dev_info(ethosudev->base.dev,
> -		 "Ethos-U NPU, arch v%ld.%ld.%ld, rev r%ldp%ld, cmd stream ver%ld, %d MACs, %dKB SRAM\n",
> +		 "Ethos-U NPU, arch v%ld.%ld.%ld, rev r%ldp%ld, cmd stream ver%ld, %d MACs, %dKB SRAM, %d PMU cntrs\n",
>   		 FIELD_GET(ID_ARCH_MAJOR_MASK, id),
>   		 FIELD_GET(ID_ARCH_MINOR_MASK, id),
>   		 FIELD_GET(ID_ARCH_PATCH_MASK, id),
> @@ -324,7 +335,8 @@ static int ethosu_init(struct ethosu_device *ethosudev)
>   		 FIELD_GET(ID_VER_MINOR_MASK, id),
>   		 FIELD_GET(CONFIG_CMD_STREAM_VER_MASK, config),
>   		 1 << FIELD_GET(CONFIG_MACS_PER_CC_MASK, config),
> -		 ethosudev->npu_info.sram_size / 1024);
> +		 ethosudev->npu_info.sram_size / 1024,
> +		 ethosudev->npu_info.pmu_counters);
>   
>   	return 0;
>   }
> @@ -343,11 +355,16 @@ static int ethosu_probe(struct platform_device *pdev)
>   	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>   
>   	ethosudev->regs = devm_platform_ioremap_resource(pdev, 0);
> +	ethosudev->pmu_regs = ethosudev->regs;
>   
>   	ethosudev->num_clks = devm_clk_bulk_get_all(&pdev->dev, &ethosudev->clks);
>   	if (ethosudev->num_clks < 0)
>   		return ethosudev->num_clks;
>   
> +	ret = devm_mutex_init(&pdev->dev, &ethosudev->perfmon_state.lock);

I believe this should be drmm_mutex_init() as it's bounded by the DRM
device.

> +	if (ret)
> +		return ret;
> +
>   	ret = ethosu_job_init(ethosudev);
>   	if (ret)
>   		return ret;

[...]

> +
> +void ethosu_perfmon_put(struct ethosu_perfmon *perfmon)
> +{
> +	if (perfmon && refcount_dec_and_test(&perfmon->refcnt)) {
> +		kfree(perfmon);
> +	}

No brackets needed.

> +}
> +
> +void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon)
> +{
> +	unsigned int i;
> +	u8 ncounters;
> +	u32 mask;

lockdep_assert_held?

> +
> +	if (WARN_ON_ONCE(!perfmon || ethosu->perfmon_state.active))
> +		return;
> +
> +	writel_relaxed(PMCR_CNT_EN, ethosu->pmu_regs + NPU_REG_PMCR);
> +	writel_relaxed(PMU_EV_TYPE_CYCLES, ethosu->pmu_regs + NPU_REG_PMCCNTR_CFG);
> +
> +	mask = 0x80000000;
> +	ncounters = perfmon->ncounters - 1;
> +	if (ncounters)
> +		mask |= GENMASK(ncounters - 1, 0);
> +
> +	for (i = 0; i < ncounters; i++)
> +		writel_relaxed(perfmon->counters[i], ethosu->pmu_regs + NPU_REG_PMU_EVTYPER(i));
> +
> +	writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENSET);
> +	writel_relaxed(PMCR_CNT_EN | PMCR_EVENT_CNT_RST | PMCR_CYCLE_CNT_RST,
> +		ethosu->pmu_regs + NPU_REG_PMCR);
> +	ethosu->perfmon_state.active = perfmon;
> +}
> +
> +void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
> +				bool capture)
> +{
> +	unsigned int i;
> +	u8 ncounters;
> +	u32 mask;
> +
> +	lockdep_assert_held(&ethosu->perfmon_state.lock);
> +
> +	if (!perfmon || perfmon != ethosu->perfmon_state.active)
> +		return;
> +
> +	ncounters = perfmon->ncounters - 1;
> +
> +	if (!pm_runtime_get_if_active(ethosu->base.dev)) {
> +		ethosu->perfmon_state.active = NULL;
> +		return;
> +	}
> +
> +	if (capture) {
> +		for (i = 0; i < ncounters; i++)
> +			perfmon->values[i] += readl_relaxed(ethosu->pmu_regs + NPU_REG_PMU_EVCNTR(i));

A new line here would make the code a bit more readable.

> +		perfmon->values[ncounters] +=
> +			readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNTR_LO) |
> +			(u64)readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNTR_HI) << 32;
> +	}
> +
> +	mask = 0x80000000;
> +	if (ncounters)
> +		mask |= GENMASK(ncounters - 1, 0);
> +	writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENCLR);
> +
> +	writel_relaxed(0, ethosu->pmu_regs + NPU_REG_PMCR);
> +	ethosu->perfmon_state.active = NULL;
> +
> +	pm_runtime_put(ethosu->base.dev);
> +}
> +
> +void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
> +			 bool capture)
> +{
> +	if (!perfmon)
> +		return;
> +
> +	guard(mutex)(&ethosu->perfmon_state.lock);
> +	ethosu_perfmon_stop_locked(ethosu, perfmon, capture);
> +}
> +
> +struct ethosu_perfmon *ethosu_perfmon_find(struct ethosu_file_priv *ethosu_priv, int id)
> +{
> +	struct ethosu_perfmon *perfmon;
> +
> +	xa_lock(&ethosu_priv->perfmons);
> +	perfmon = xa_load(&ethosu_priv->perfmons, id);
> +	ethosu_perfmon_get(perfmon);
> +	xa_unlock(&ethosu_priv->perfmons);
> +
> +	return perfmon;
> +}
> +
> +void ethosu_perfmon_open_file(struct ethosu_file_priv *ethosu_priv)
> +{
> +	xa_init_flags(&ethosu_priv->perfmons, XA_FLAGS_ALLOC1);
> +}
> +
> +static void ethosu_perfmon_delete(struct ethosu_file_priv *ethosu_priv,
> +				 struct ethosu_perfmon *perfmon)
> +{
> +	struct ethosu_device *ethosu = ethosu_priv->edev;
> +
> +	/* If the active perfmon is being destroyed, stop it first */
> +	scoped_guard(mutex, &ethosu->perfmon_state.lock) {
> +		/* If the global perfmon is being destroyed, set it to NULL */
> +		if (ethosu->global_perfmon == perfmon) {
> +			ethosu->global_perfmon = NULL;
> +			ethosu_perfmon_put(perfmon);
> +		}
> +
> +		ethosu_perfmon_stop_locked(ethosu, perfmon, false);
> +	}
> +
> +	ethosu_perfmon_put(perfmon);
> +}
> +
> +void ethosu_perfmon_close_file(struct ethosu_file_priv *ethosu_priv)
> +{
> +	struct ethosu_perfmon *perfmon;
> +	unsigned long id;
> +
> +	xa_for_each(&ethosu_priv->perfmons, id, perfmon)
> +		ethosu_perfmon_delete(ethosu_priv, perfmon);
> +
> +	xa_destroy(&ethosu_priv->perfmons);
> +}
> +
> +int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
> +			     struct drm_file *file_priv)
> +{
> +	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
> +	struct drm_ethosu_perfmon_create *req = data;
> +	struct ethosu_device *ethosu = to_ethosu_device(dev);
> +	struct ethosu_perfmon *perfmon;
> +	unsigned int i, event_max;
> +	int ret;
> +	u32 id;
> +
> +	/* Number of monitored counters cannot exceed HW limits. */
> +	if (req->ncounters > ethosu->npu_info.pmu_counters)

Feel free to ignore this comment if I'm mistaken, but IIUC, pmu_counters
is the maximum number of counters *including* cycle counter. If
pmu_counters indeed includes cycle counter, I believe this should be a >=.

Best regards,
- Maíra


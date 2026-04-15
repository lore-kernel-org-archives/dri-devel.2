Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CF3F41986
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B2710E6BD;
	Wed, 15 Apr 2026 11:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCAYjK64";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCC110E6BD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 03955400E5;
 Wed, 15 Apr 2026 11:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCE5C4AF0B;
 Wed, 15 Apr 2026 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776252348;
 bh=0QeTyvtoCnNRRXFdte6x9ln64i4XnIZGxAh5AfOrhe0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iCAYjK64Tfl1KN4kuqKnRr1MIBS5wxGrxzU+t139D3rX/u+TVTfifIuxn0wR4MCOy
 m1ymSKiAZkz0H3CzmR3j99AJO5uHnDJ84JPBk6Acz72isVtPZR9VUsvB7utW8cHYN4
 Jxopp7ZZDs/eNPylxgRy0DIaPaJfGX7AkpBPIA+fTEs/NYA0upwL7c9t/3Zb5Tr+sM
 PX0qfejWJhoy/vMZyCRG1kiFN45Wx5HqMta5cUBqosUzz6untmsafrmQ1e6TXCfTj2
 stKImHB1seIa0VzekRBD6hLS+ZHwOUtpTab1y1V5kSbSbY6CWeR7vHsccGWHaFSd/e
 rFl/xcOEOFgwQ==
Message-ID: <02f3c112-21a5-4eff-b23a-c11390604ce0@kernel.org>
Date: Wed, 15 Apr 2026 11:25:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
To: ekansh.gupta@oss.qualcomm.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
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



On 4/14/26 4:31 PM, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce a new generic bus type for synthetic context bank devices
> that require IOMMU context isolation. This bus provides a shared
> infrastructure for accelerator and GPU drivers that create virtual
> devices representing IOMMU context banks.
> 
> Currently, drivers like host1x implement their own bus types for
> context devices. This generic implementation allows multiple drivers
> to share the same bus infrastructure, simplifying the IOMMU subsystem
> integration and reducing code duplication.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/base/Kconfig        |  3 +++
>  drivers/base/Makefile       |  1 +
>  drivers/base/context_bus.c  | 24 ++++++++++++++++++++++++
>  include/linux/context_bus.h | 15 +++++++++++++++

This patch as it is does not add any details on how the iommu will be
binded to this bus, Please consider adding the iommu changes to this
patch so that its easy to understand and for completeness.


Also naming it as context bus is bit generic, I think the whole purpose
of this is bus is to add this as another supported bus in the iommu.

may be iommu_context bus or something on those lines would be much clear.


>  4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index f7d385cbd3ba..479bc4bb442b 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -4,6 +4,9 @@ menu "Generic Driver Options"
>  config AUXILIARY_BUS
>  	bool
>  
> +config CONTEXT_DEVICE_BUS
> +	bool
> +
>  config UEVENT_HELPER
>  	bool "Support for uevent helper"
>  	help
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..ab9a0b2dc73b 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -8,6 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
>  			   topology.o container.o property.o cacheinfo.o \
>  			   swnode.o faux.o
>  obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
> +obj-$(CONFIG_CONTEXT_DEVICE_BUS) += context_bus.o
>  obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
>  obj-y			+= power/
>  obj-$(CONFIG_ISA_BUS_API)	+= isa.o
> diff --git a/drivers/base/context_bus.c b/drivers/base/context_bus.c
> new file mode 100644
> index 000000000000..6ddb6c27bf69
> --- /dev/null
> +++ b/drivers/base/context_bus.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.

Some credits to the inspiring code would be nice.

> +
> +#include <linux/context_bus.h>
> +#include <linux/init.h>
> +
> +const struct bus_type context_device_bus_type = {
> +	.name = "context-device",
> +};
> +EXPORT_SYMBOL_GPL(context_device_bus_type);
> +
> +static int __init context_device_bus_init(void)
> +{
> +	int err;
> +
> +	err = bus_register(&context_device_bus_type);
> +	if (err < 0) {
> +		pr_err("context-device bus registration failed: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}

So is the consumer drivers are expected to do the device management for
this bus, this certainly is not correct and every consumer would be
duplicating it.

Did you consider faux bus?

> +postcore_initcall(context_device_bus_init);
> diff --git a/include/linux/context_bus.h b/include/linux/context_bus.h
> new file mode 100644
> index 000000000000..0cd44cb5b147
> --- /dev/null
> +++ b/include/linux/context_bus.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __LINUX_CONTEXT_BUS_H
> +#define __LINUX_CONTEXT_BUS_H
> +
> +#include <linux/device.h>
> +
> +#ifdef CONFIG_CONTEXT_DEVICE_BUS
> +extern const struct bus_type context_device_bus_type;
> +#endif
> +
> +#endif /* __LINUX_CONTEXT_BUS_H */
> 


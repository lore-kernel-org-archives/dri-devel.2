Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DB606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=BqS+h/HA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C1210FA57;
	Wed, 25 Nov 2026 08:55:22 +0000 (UTC)
Received: from mail-m81165.netease.com (mail-m81165.netease.com [47.88.81.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5A810FA44
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:55:15 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55f2f99e1;
 Wed, 25 Nov 2026 16:55:11 +0800 (GMT+08:00)
Message-ID: <82168811-c141-445a-97d1-e5c1ee38e0f4@rock-chips.com>
Date: Wed, 25 Nov 2026 16:55:06 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
To: Luo Liu <Luo.Liu@cixtech.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-4-Luo.Liu@cixtech.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261124120114.3273161-4-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa211ea839803a7kunm367dc79fe08dd9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkoaVklIQkodT08fTENITlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=BqS+h/HAVZ206PWEvVwfP1IycONXbmlKg6lhmJFv711VYa9d8faJGNxIZxw0hKmSE4cO5/hdsUHqmKQOUH3cz9wOul+AnEy5FAxlZk6wpRE7U/banOPxqtJ8XO5I+w3PulbMtrq5UgqlV4YvrrVq3P3uprzIGrVdzsO8flFpZFQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=o4GT54fvMYkC4amfZANmVOthCE6DeSD74V9mpKYzQZY=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/24/2026 8:01 PM, Luo Liu wrote:
> Add the DRM bridge that exposes the transmitter to KMS: connector
> detection, EDID mode enumeration with a downstream timing fallback,
> validation of a mode against the sink link capabilities, and the atomic
> enable and disable paths.
> 
> The bridge is meant to be attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR;
> the connector is created by drm_bridge_connector_init() from the bridge
> operations, so the driver only implements the bridge side and never
> creates a connector of its own.
> 
> Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
> ---
>  drivers/gpu/drm/bridge/trilinear/dptx_drm.c | 623 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/trilinear/dptx_drm.h |  17 +
>  2 files changed, 640 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.c
>  create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.h
> 
> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
> new file mode 100644
> index 000000000000..fde34bac1230
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DisplayPort DRM bridge helpers
> + *
> + * Copyright 2026 Cix Technology Group Co., Ltd.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_state_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_edid.h>
> +
> +#include "dptx.h"

This file does not appear until patch 4.

> +#include "dptx_drm.h"
> +
> +#define DPTX_MIN_H_BACKPORCH 12
> +#define DPTX_MIN_BPP		(6 * 3)
> +


-- 
Best, 
Chaoyi


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E0606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lkuxm/BZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25A710ED6B;
	Mon, 16 Nov 2026 09:07:22 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65310ED6B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:07:15 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD4F5B5;
 Mon, 16 Nov 2026 10:04:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794819888;
 bh=WXZM0v7Iccc0YJN6sQ4Tx8wDPorwn1ToYD+9hhAWpd8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lkuxm/BZ2UePK8LCRX7rGlh4744zQS0tXj0rgBall8N+8QEP2QrN0oNWfpoASriW8
 TfyiFjuzPxwnBV6GivBn9SDspSN5s825ywkKBW8mdnezD4wuRW1HpyO/xWWrLBCRgu
 uy25bWlz4+tg5C0csXIVZ4Id9cvebTsTuczb8v54=
Message-ID: <692d174e-eea4-4b5d-97f8-384de96e4eb4@ideasonboard.com>
Date: Mon, 16 Nov 2026 11:07:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Add no-hpd property to the cadence bridge
To: Yashas D <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, h-shenoy@ti.com, panchuang@vivo.com, kees@kernel.org,
 r-ravikumar@ti.com, sjakhade@cadence.com, yamonkar@cadence.com
References: <20261009064024.985688-1-y-d@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261009064024.985688-1-y-d@ti.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 09/10/2026 09:40, Yashas D wrote:
> This series adds 'no-hpd' device tree property support to the Cadence
> MHDP8546 bridge driver for boards where the HPD line cannot be used for
> hotplug detection.
> 
> On TI J721S2 EVMs, the DP0 HPD resistor is DNI from factory, so the HPD
> signal is not physically connected to SoC pin AA24 by default. AA24 must
> still be in DP0_HPD mux mode for the MHDP firmware to operate.
> 
> When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted and the framework
> falls back to polling .detect() every ~10 seconds. Presence is detected
> by reading DP_DPCD_REV (0x000) over AUX, with an early exit when the
> monitor is stably connected to avoid re-programming the stream each poll.

How did you test this? I can't get a picture on J721E EVM if I apply this.

  Tomi

> Changes since v6:
>    - Reverted back to dev_dbg instead of dev_err for the normal hpd case.
>    - Picked up Acked-by from Krzysztof Kozlowski from v6 on the bindings patch.
> 
> Link to v6: https://lore.kernel.org/all/20260802153825.1570435-1-y-d@ti.com/
> 
> Rahul T R (2):
>    dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd property to
>      the cadence bridge
>    drm: bridge: cdns-mhdp8546: Add no-hpd property
> 
>   .../display/bridge/cdns,mhdp8546.yaml         | 11 +++
>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 69 +++++++++++++++++--
>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
>   3 files changed, 75 insertions(+), 6 deletions(-)
> 


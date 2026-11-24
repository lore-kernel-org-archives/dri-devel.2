Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DF606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=FahLlVLe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2552D10E6EB;
	Tue, 24 Nov 2026 08:43:04 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7985710E6EB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:42:58 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 06F74C4B;
 Tue, 24 Nov 2026 09:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795509624;
 bh=5QNDiqdYBPyhKBc3UH1FZVUuv+wsTMoB/TZSNUvaoVA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FahLlVLef7i7o+VTD0s++Pf/KH7K3dkn4Lcp+mTmMWs/nfzdx1UOt7A5fgyThGBt5
 9MqK4frMRvsv+qCPaya485Upoc5T01YocgWA3LO1pF7WIz2ECqVvQm7ItIY1QxaKQi
 10G4twVj0hO74wBXc0omDQamLazBHC5AN4LkttDU=
Message-ID: <c60c4e6c-f9cc-4d3a-b0ca-f374f298825b@ideasonboard.com>
Date: Tue, 24 Nov 2026 10:42:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/42] drm/atomic: Add drm_private_obj name
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-7-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-7-a67c2b45b8ec@kernel.org>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/11/2026 14:54, Maxime Ripard wrote:
> drm_private_obj does not carry a human-readable name, which makes
> debug messages hard to interpret when multiple private objects are
> registered on the same device.
> 
> Add a name field to drm_private_obj, passed through
> drm_atomic_private_obj_init() and freed in
> drm_atomic_private_obj_fini(). Update the existing callers to pass a
> name.
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       |  1 +
>   drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c |  8 ++++++++
>   drivers/gpu/drm/display/drm_dp_mst_topology.c           |  2 +-
>   drivers/gpu/drm/display/drm_dp_tunnel.c                 | 15 +++++++++++++--
>   drivers/gpu/drm/drm_atomic.c                            | 13 +++++++++++++
>   drivers/gpu/drm/drm_bridge.c                            | 10 +++++++++-
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c               |  1 +
>   drivers/gpu/drm/ingenic/ingenic-ipu.c                   |  1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                 |  1 +
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                |  1 +
>   drivers/gpu/drm/omapdrm/omap_drv.c                      |  1 +
>   drivers/gpu/drm/tegra/hub.c                             |  1 +
>   drivers/gpu/drm/vc4/vc4_kms.c                           |  3 +++
>   include/drm/drm_atomic.h                                |  7 +++++++
>   include/drm/drm_bridge.h                                |  2 ++
>   15 files changed, 63 insertions(+), 4 deletions(-)
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi


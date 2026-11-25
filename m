Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C9606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=da2zP3pe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC18310FA2B;
	Wed, 25 Nov 2026 09:05:50 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC22910FA2B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:05:44 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5AC652E0;
 Wed, 25 Nov 2026 10:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795597390;
 bh=eMk2pLj3OCNXQ/8DEhsEwWHklduaTO2PHAn+5c7tIVA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=da2zP3peQASYNajGQFrxuu8yVC7OOK7x41QfLgB35y4CO/It9wAgT5hVXH4WoQyIC
 aFhoGlRHcgcCwbsT82D9VNLwDUg702JgFMDtWfmmpESgGwhQGfV81zo1FKygteA08W
 /K3AN/VYAUeypsguU//cQfs1+zHmtfDXkfVAbEQQ=
Message-ID: <1588fb80-c76d-4268-96a0-390c104aff46@ideasonboard.com>
Date: Wed, 25 Nov 2026 11:05:40 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/42] drm/atomic_sro: Create kernel parameter to force
 or disable readout
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-14-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-14-a67c2b45b8ec@kernel.org>
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

On 20/11/2026 14:55, Maxime Ripard wrote:
> The hardware state readout is useful, but might need to be disabled
> in case of bugs, or its checks relaxed during development when not
> all hooks are implemented yet.
> 
> Add a module parameter to control the readout behavior: it can be
> disabled entirely, or the checks for missing compare or readout hooks
> can be skipped independently.
> 
> Suggested-by: Simona Vetter <simona@ffwll.ch>
> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++
>   drivers/gpu/drm/drm_atomic_state_readout.c      | 29 +++++++++++++++++++++++++
>   include/drm/drm_atomic_state_readout.h          | 11 ++++++++++
>   3 files changed, 52 insertions(+)
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi


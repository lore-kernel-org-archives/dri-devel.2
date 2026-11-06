Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD8606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KXGSaWym
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC6E112D60;
	Fri,  6 Nov 2026 13:29:00 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE100112D60
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793971733;
 bh=Zbw4Pdi7/7yO5hBdNSUYXrfRS7EY1BsSPUefMzufvO0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KXGSaWymhy7vDq1ttAqgN//6MlUzMkvBRQ9TGNFIUu8N8bF+aJhjxYkcOykxTASZe
 dXjkFbsSyC3pB9bg00QGoDlehTyzk3MX/feiNb1UzSi6jB1kqnL2pTh4a/tj+vagM/
 aq+wt5I3zRIPZ19jauH2NmtFHgxwxCE9Emf1r6LB6VFX5bwBQ85fngNYVHBuWdHoY2
 QgOCY+AuyzqjASUSPVIU5ieCo+n0iZNrXJ+S0XPNnBs/J5YrlV04UshV1yIojc9sae
 +zUBMzi2QNTupSQXfzy8eYXJ8skF+ZKYIkK4O/F+Sxsqd9aAzuCN4uGzLfKzJtawXh
 u6eNZJHg/RJOw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AA49317E031D;
 Fri, 06 Nov 2026 14:28:52 +0100 (CET)
Message-ID: <a22410c8-7ee3-473c-aa8e-9c71c8555bda@collabora.com>
Date: Fri, 6 Nov 2026 14:28:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mediatek: Validate gamma_lut size
To: Fei Shao <fshao@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20261106103932.1219696-1-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261106103932.1219696-1-fshao@chromium.org>
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:39, Fei Shao wrote:
> The DRM core checks that a gamma_lut blob is aligned to
> sizeof(struct drm_color_lut) and at most GAMMA_LUT_SIZE entries, so
> shorter blobs still reach the driver. mtk_aal_gamma_set() and
> mtk_gamma_set() read up to the fixed hardware LUT size, which is an OOB
> read when the blob is shorter.
> 
> Add mtk_crtc_atomic_check() and reject gamma_lut if its entry count does
> not match crtc->gamma_size.
> 
> Fixes: 2f3f4dda747c ("drm/mediatek: Add gamma correction.")
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


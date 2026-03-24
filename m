Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3C5E9A756
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184CD10E65D;
	Tue, 24 Mar 2026 09:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="n1iIzZiC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF74210E5C2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774346133;
 bh=tnrLvArGzRZzy5aK1JFU5crmecE4BzC8HL11nAYoeek=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n1iIzZiCeQaEIHV9LXid9Zc+tG8TD8wRQjJtqNPYsCLW7W3UTVb4iTH6Hbg2kmIbl
 WesshralHDISjw1JtT+9aZlgttWVBKgvsUC2U8lR6pVxsybmkeI97PUlc83kBS4Eog
 KyYb/6FCH2oiULQ79xNUcK9b/WQZusGOlpj10LxWtLU/N1kGF9iVH43QFV3xNtsnZU
 04o0nbFkbyGX6Atrr/atrbtBi4+SFsePJq4spHC3jNyhZuU46Wja/v0Anedkawz1dP
 E6tdjBWEuF8MyUm2fjjGDFSbpu6vqlTIf8WxtGh3rfADb29rYaIhx//0Hx/KzjFZWk
 QKS8SO+mRCQ2Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F0F6E17E59B7;
 Tue, 24 Mar 2026 10:55:32 +0100 (CET)
Date: Tue, 24 Mar 2026 10:55:29 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Boqun
 Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda
 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Steven
 Price <steven.price@arm.com>, Dirk Behme <dirk.behme@gmail.com>, Alexandre
 Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v3 03/12] drm/tyr: Set interconnect coherency during probe
Message-ID: <20260324105529.09d4d214@fedora>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-3-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-3-a87daf9e4701@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Mon, 23 Mar 2026 17:18:05 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Currently GpuInfo reports the interconnect coherency protocol as none
> without actually reading the `COHERENCY_ENABLE` register.
> 
> Although the result is the same, write `NO_COHERENCY` to the register
> during probe and then read back the register to populate the GpuInfo
> struct.
> 
> This ensures that GpuInfo is populated consistently and is always as
> accurate as possible by reporting the register values directly.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tyr/driver.rs | 5 +++++
>  drivers/gpu/drm/tyr/gpu.rs    | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 3ebb5e08bfca342f136e8d365b1d9dcb6cc3dbca..7232d9f9547c239689dc424380109a4e5140dd84 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -136,6 +136,11 @@ fn probe(
>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
>  
> +        let io = (*iomem).access(pdev.as_ref())?;
> +        // FIXME: This needs to be set properly once we get
> +        // device_get_dma_attr() properly exposed to the rust drivers.
> +        io.write_reg(COHERENCY_ENABLE::zeroed().with_l2_cache_protocol_select(CoherencyMode::None));
> +
>          let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
>          gpu_info_log(pdev.as_ref(), &iomem)?;
>  
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index 4a50055b415c693a89cb99dba241b21351a14149..d5240f4567ca4e763b09e015908bdc5c22276e0d 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -60,7 +60,7 @@ pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
>                  io.read(TEXTURE_FEATURES::at(3)).supported_formats().get(),
>              ],
>              as_present: io.read(AS_PRESENT).into_raw(),
> -            selected_coherency: uapi::drm_panthor_gpu_coherency_DRM_PANTHOR_GPU_COHERENCY_NONE,
> +            selected_coherency: io.read(COHERENCY_ENABLE).into_raw(),
>              shader_present: io.read(SHADER_PRESENT).into_raw(),
>              l2_present: io.read(L2_PRESENT).into_raw(),
>              tiler_present: io.read(TILER_PRESENT).into_raw(),
> 


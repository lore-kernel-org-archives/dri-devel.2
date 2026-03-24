Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C35DE9A755
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBB410E5B1;
	Tue, 24 Mar 2026 09:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cW14d0dh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDC410E5B1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774346084;
 bh=TduUf8cYUueDiOeghuHab8L9UNHmGg6Smnk+PIa7t48=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cW14d0dhU2RvvGmHOadOaBcONCyjPptPEJohqMaBIPUdg9ul2Pcy+5OirzQle4ZHH
 FKfkiU9YOZGooeCQ/Sl33gQF4YSceuQOead+kRNEz/X2MaXTHhMtbPQo2fPztxfN9Z
 Aot9vEFfH2iDlkYlLK8//pxqHPPJLST/pWJNgIcP8HqoOLsERNzo37QPj4EqZbKRaB
 vdeH9Yo1Atl0TdNClnU2h5jLNHi2yDCtDqAjWnFEOir60z+BZ9BMBGL2Kd6pVbTaLx
 RqylhzdET6+C1+CJtXf9HScwtvedJxRAZNV3NJTgSciMZukMRSwc/0iSzsoOIRKHrs
 qOUD4pQl0ibYw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E7A1417E59B0;
 Tue, 24 Mar 2026 10:54:43 +0100 (CET)
Date: Tue, 24 Mar 2026 10:54:38 +0100
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
Subject: Re: [PATCH v3 02/12] drm/tyr: Print GPU_ID without filtering
Message-ID: <20260324105438.0408e68f@fedora>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-2-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-2-a87daf9e4701@collabora.com>
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

On Mon, 23 Mar 2026 17:18:04 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Currently, Tyr prints just the upper 16 bits of the GPU_ID register,
> namely, ARCH_MAJOR, ARCH_MINOR, ARCH_REV, and PRODUCT_MAJOR. This matches
> the id printed by the panthor driver.
> 
> To avoid the manual bit shift, just print the full GPU_ID register. This
> prints all of the same information and adds the VERSION_MAJOR,
> VERSION_MINOR, and VERSION_STATUS.
> 
> Before this change:
>   mali-g610 id 0xa867 major 0x0 minor 0x0 status 0x5
> 
> After this change:
>   mali-g610 GPU_ID 0xa8670005 major 0x0 minor 0x0 status 0x5
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tyr/gpu.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index 66fd6c016c62abe3c34669a2e47b680c3a3f873d..4a50055b415c693a89cb99dba241b21351a14149 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -124,9 +124,9 @@ pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result
>  
>      dev_info!(
>          dev,
> -        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> +        "mali-{} GPU_ID 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
>          model_name,
> -        gpu_id.into_raw() >> 16,
> +        gpu_id.into_raw(),
>          gpu_id.ver_major().get(),
>          gpu_id.ver_minor().get(),
>          gpu_id.ver_status().get()
> 


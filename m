Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA256074099
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gfxstrand-net.20251104.gappssmtp.com header.i=@gfxstrand-net.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=unvmz3DK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D661A10E6CD;
	Mon, 19 Oct 2026 15:43:53 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA44A10EE2F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:43:46 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-16079d54c17so5005015c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792424626; cv=none;
 d=google.com; s=arc-20260327;
 b=AQuVP8/dFvQZ1IugCftx5ITnwiosc+jDahtCxnGbiSB7EwbyLYW1BchaktekHFZwjn
 GjjhTasXZYR3OMz5SgQomLtH7UxFc+BfVanwVB9XUHIPzLdQnWxUcJYtwWLs459Ehzwm
 TuzaXOFEHquBFRtfPVM4OQ2UsVfD2M4PSCTpyY62yZAbyniK1lW7hw7k/cNjbfY0sMrR
 UTsoDbeMO7YktBWPk6tCO+YtjxWMV4DtfKI7akxEpc+38Cz8l7EW6OdGcii3jxRc7w8w
 8ygnVeOwjZtDWbcJQ/0O6x4Gg7PRw17xfZlIqkOdr0ElpHdPouKGHOfLiTsJQA0T3KFC
 pRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l+PJNaaQkcG0U6cvab+pi5NeILsnDidwAVp4AKHhEWI=;
 fh=ikGrILH3a00XG8jOmGar2d5dkFlSzYEoCOV/lKlRq98=;
 b=YvkrhTgM+GmYIEczOLkeOhpz849kJ9P4b23rbprVeq94+0yPbF0p9XqKEtf/xT1YYM
 PUp8irNgsYuH5V3EDqvexHJGB9voznMsEjd62y3MK0tNtLk1uTGfY/N4KVcTH/5vm6CA
 t5qsXw7doyF0/7HGe6xi82e7WRmDpzZMsIGbXT0dyA1+pVcTB4HpmN/K5C8IWKr/pmsI
 IVvmrCV7+/Mkfmsi9k6UnW9iOVhNltipv9JwBd8Sof9GMOIEirh+OftUr7MC5fsk30e7
 3eV2U9krdkI2jZdyCsXLoZgn5SmGIRI6kzRV1BOpcyibcWwiOStDFO7zB582MozrejZx
 vcOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gfxstrand-net.20251104.gappssmtp.com; s=20251104; t=1792424626; x=1793029426;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l+PJNaaQkcG0U6cvab+pi5NeILsnDidwAVp4AKHhEWI=;
 b=unvmz3DK64D5BMmZ3yzpyesrwCBXzFxQoLgqlBFJTms7evq7sUMC0T7teN9Sl0lgzT
 LXreR43gmj+170p/jkPFPaed2B54ActwpohgCtmX1SLSGrQVhbZgjy61pkraHti1/Yer
 iwEKwRVf+1gPmuvToMjBB+JyfMj6iHNGNKVN2DaPrqCtxV9DkG1AGS+XXogrMS3Kdu6d
 K+FlVlmLZMcn5YA10gy6bNeVOEIgRFdsgHLU+PYXt4x6ynNvhxdQ44RhrBPTys9EtCrf
 LRxieTV2MJYbxtfqh4qNm7xq0pCDs5H/qTfYepbX4TH4DJDS2HuxIgnlKwDBZLbfpFzP
 7OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424626; x=1793029426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l+PJNaaQkcG0U6cvab+pi5NeILsnDidwAVp4AKHhEWI=;
 b=CNjKxiWT6qhjNi25bbOwuG5tc77jEpT4LZqsfmLJzkhfveXqz7XX58pZHY4Lwmpk6B
 y9F40Dxd4LVDzXfsyqpoHr6cllchRyFcyfxcatPrzMZyM9mYvcIvEb6ZH45bd4zfIDo+
 CK9aieYVKwJgCXx05YT64HDRAlSDIg80ZiftUQhA1N5NYIbmvK4+94z0NFivPVmFMSdN
 AUhrYA5HbTbEfHlYJ2fDvp2ldQlVGEPVNCqLN4+lM4JfgdRVRc/mFH7SgRebmk1VPrrO
 NeuLWlEgoOepEA+a5Rd+RiFI2f3sE9g82mYYOrRYlgqJZn0UjlWco5c+9b1pWdd7S3Vy
 pi1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByDIqUCsSktKOvN0XURsdRvRjv8Uw6LPFzwsdnlxt5q7tpmsGfiEi09ktHr6cg5bocQreI7ZBz4JmM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKEqKg8qjsSJwZ/cOnzFqJ/bys975yrfq6t09gzrpIIpH9sZ5v+
 xlMrolKUENdnbqfeVxYZCwuXiWe9u1yF0kM0P9A7EsNI6bM0f1UrqMIdfWPtaVjzCY8F6/AtQJI
 32Hh9lPHl5HsnkDegJ2b9Eo1M2LwNn5L6YagJDUrsTQ==
X-Gm-Gg: AYBFou3iYUoirVs/rZwbFAccFix1JwRyWVybQu9DPbbW21dwh30ubWV4prA92pQQO6N
 ar0cX4Q6Cd1yFihTMJgzaTbEsLGxWwzS0fRemzmDnIVXdbnXx7xH0xUPGfEc/tPIPky7HZb1VGL
 ZVar8GOcCZAWkd40Ile9JHub7p80C8AQr3l3EOJu3G7Pjhv2eq/56GYX621ym52d12Uf0zeGQh+
 H1yTzarzhzf9+VbtT7vY+8Bh48yFP6kF/Sw3zjpVVFoP6y3/WL62hY2KzbFcgwQgD1kIDjgWz7I
 RWSf0JF03VZBcSGEtYvdQnCaISkP6AgD58/5mAzZSLGXpck9auds
X-Received: by 2002:a05:701b:21cd:b0:14c:be8e:69f2 with SMTP id
 a92af1059eb24-18512b3f773mr11411490c88.21.1792424625673; Mon, 19 Oct 2026
 08:43:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260909064506.910162-9-apopple@nvidia.com>
In-Reply-To: <20260909064506.910162-9-apopple@nvidia.com>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Mon, 19 Oct 2026 11:43:34 -0400
X-Gm-Features: AclHuK8wgzDeroqopGem9K3ppSyG5cc3vLnnGQN2wHpX-RdNKKojDR1u5BsOoW0
Message-ID: <CAOFGe97oDdZP-XDhthZ-5tuJjuJyKxvLq9YqvWaTApZE6B8exQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] drm: nova: Add usable VRAM size to GPU info
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Sep 9, 2026 at 2:46=E2=80=AFAM Alistair Popple <apopple@nvidia.com>=
 wrote:
>
> Add a field to the GPU info structure containing the total usable
> framebuffer size. The usable framebuffer excludes GSP carveouts and
> other protected regions, so it may differ from the BAR size and total
> physical VRAM.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>
> ---
>
> Changes since v5:
>
>  - Expose the GSP static info through a NovaCoreApi::gsp_static_info()
>    accessor and read the VRAM size from it rather than adding a
>    forwarding method, as suggested by Danilo
>
> Changes since v3:
>
>  - Partially new for v4 - previously a separate scalar GETPARAM
>    parameter
> ---
>  drivers/gpu/drm/nova/file.rs          |  2 ++
>  drivers/gpu/nova-core/api.rs          |  6 ++++++
>  drivers/gpu/nova-core/gpu.rs          |  6 ++----
>  drivers/gpu/nova-core/gsp/commands.rs | 10 +++++++++-
>  include/uapi/drm/nova_drm.h           |  6 ++++++
>  5 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index 4a65bec0fbce..d0ab3df6bcd2 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -38,10 +38,12 @@ impl GpuInfo {
>      /// another documented default instead.
>      fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
>          let spec =3D reg_data.api.with(|api| api.get_ref().spec());
> +        let gsp_static_info =3D reg_data.api.with(|api| api.get_ref().gs=
p_static_info());
>
>          let info =3D uapi::drm_nova_info_gpu {
>              architecture: spec.chipset.arch() as u32,
>              chipid: spec.chipset as u32,
> +            vram_size: gsp_static_info.vram_size(),
>          };
>          Ok(Self(info))
>      }
> diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
> index 876451dcc051..64f9ea442278 100644
> --- a/drivers/gpu/nova-core/api.rs
> +++ b/drivers/gpu/nova-core/api.rs
> @@ -15,6 +15,7 @@
>  pub use crate::gpu::Spec;
>
>  use crate::gpu::Gpu;
> +use crate::gsp::commands::GetGspStaticInfoReply;
>
>  /// API handle for the auxiliary bus child drivers to interact with nova=
-core.
>  pub struct NovaCoreApi<'bound> {
> @@ -28,6 +29,11 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<N=
ovaCoreApiHandle<'_>> {
>          NovaCoreApiHandle::of(adev)
>      }
>
> +    /// Returns the GPU [`GetGspStaticInfoReply`].
> +    pub fn gsp_static_info(&self) -> &GetGspStaticInfoReply {
> +        &self.gpu.gsp_static_info
> +    }
> +
>      /// Returns the GPU [`Spec`].
>      pub fn spec(&self) -> &Spec {
>          &self.gpu.spec
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 91db64dcaea7..b9fba3a79b1e 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -301,7 +301,7 @@ struct GspResources<'gpu> {
>  pub(crate) struct Gpu<'gpu> {
>      pub(crate) spec: Spec,
>      /// Static GPU information as provided by the GSP.
> -    gsp_static_info: GetGspStaticInfoReply,
> +    pub(crate) gsp_static_info: GetGspStaticInfoReply,
>      /// GSP and its resources.
>      #[pin]
>      gsp_resources: GspResources<'gpu>,
> @@ -422,9 +422,7 @@ pub(crate) fn new<'a>(
>                      dev_dbg!(
>                          dev,
>                          "Total usable VRAM: {} MiB\n",
> -                        info.usable_fb_regions.iter().fold(0u64, |res, r=
egion| res
> -                            .saturating_add(region.end - region.start))
> -                            / u64::SZ_1M
> +                        info.vram_size() / u64::SZ_1M
>                      );
>                  }
>
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index ffc25fd8c47b..5c1f9d296198 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -212,7 +212,7 @@ fn init(&self) -> impl Init<Self::Command, Self::Init=
Error> {
>  }
>
>  /// The reply from the GSP to the [`GetGspStaticInfo`] command.
> -pub(crate) struct GetGspStaticInfoReply {
> +pub struct GetGspStaticInfoReply {
>      gpu_name: [u8; 64],
>      /// Usable FB (VRAM) regions for driver memory allocation.
>      pub(crate) usable_fb_regions: KVec<Range<u64>>,
> @@ -261,6 +261,14 @@ pub(crate) fn gpu_name(&self) -> core::result::Resul=
t<&str, GpuNameError> {
>              .to_str()
>              .map_err(GpuNameError::InvalidUtf8)
>      }
> +
> +    /// Returns the total usable VRAM size in bytes, i.e. the summed len=
gths of all usable FB
> +    /// regions.
> +    pub fn vram_size(&self) -> u64 {
> +        self.usable_fb_regions.iter().fold(0, |size, region| {
> +            size.saturating_add(region.end - region.start)
> +        })
> +    }
>  }
>
>  pub(crate) use fw::commands::PowerStateLevel;
> diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> index 26a5e7ca5425..946bd4bf8fbd 100644
> --- a/include/uapi/drm/nova_drm.h
> +++ b/include/uapi/drm/nova_drm.h
> @@ -180,6 +180,12 @@ struct drm_nova_info_gpu {
>          * currently known chips.
>          */
>         __u32 chipid;
> +
> +       /**
> +        * @vram_size: Amount of usable FB, excluding GSP carveouts and p=
rotected
> +        * regions.

Does this also exclude the compression tag carve-out?

> +        */
> +       __u64 vram_size;
>  };
>
>  #define DRM_NOVA_GETPARAM              0x00
> --
> 2.54.0
>

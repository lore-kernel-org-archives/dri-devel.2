Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A06CD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 06:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8588010E49A;
	Tue, 26 May 2026 06:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YbxQQRYr";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C5310E4A2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779777841;
 bh=Khh3bfBuey5JL1UfnZwr3BRsPXoQ7q7n4zB2lZK45HA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YbxQQRYrS1TTHt5h95oURB7jRAztrTGEmWzkiILJ9ODjOjVcQi0vgEFT8RQ+ck1V/
 d0bSrsnTCczXVTwzmGfsMJoN9w3E/XggA4MAaGRr4umlh8zaXHRxHxX2JMxRj7Bzw0
 YtjOpSZUN7y8KxzCAse03pE2S48pKgOWaDe9h4FwG1W4cNbYUgtJ3aPWxvA5o/wLHu
 pU+eB+GF7l4xS4CB4ZArnyydVYMVAcl1o3Fv5lNZB2GhlfjrGvF3zMljHcsuhneBYN
 rtthG/UusqboSgJM8u0+vt+9DgGly4t2tVALiik6bOuKEnj5jDFxR3pLvWwr/WuudY
 n9zBL1YrBDP1Q==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A19B17E0443;
 Tue, 26 May 2026 08:44:01 +0200 (CEST)
Date: Tue, 26 May 2026 08:43:58 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, daniel.almeida@collabora.com,
 deborah.brouwer@collabora.com, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: drm: tyr: separate driver type from driver data
Message-ID: <20260526084358.3fb40cff@fedora>
In-Reply-To: <20260525230152.277820-2-dakr@kernel.org>
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-2-dakr@kernel.org>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Tue, 26 May 2026 01:01:43 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Introduce TyrPlatformDriver as a unit struct for the platform::Driver
> trait implementation and keep TyrPlatformDriverData for the private
> driver data.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tyr/driver.rs | 10 ++++++----
>  drivers/gpu/drm/tyr/tyr.rs    |  4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 2224fdb20a51..5f4c484f671f 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -51,6 +51,8 @@
>  /// Convenience type alias for the DRM device type for this driver.
>  pub(crate) type TyrDrmDevice = drm::Device<TyrDrmDriver>;
>  
> +pub(crate) struct TyrPlatformDriver;
> +
>  #[pin_data(PinnedDrop)]
>  pub(crate) struct TyrPlatformDriverData {
>      _device: ARef<TyrDrmDevice>,
> @@ -93,22 +95,22 @@ fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
>  kernel::of_device_table!(
>      OF_TABLE,
>      MODULE_OF_TABLE,
> -    <TyrPlatformDriverData as platform::Driver>::IdInfo,
> +    <TyrPlatformDriver as platform::Driver>::IdInfo,
>      [
>          (of::DeviceId::new(c"rockchip,rk3588-mali"), ()),
>          (of::DeviceId::new(c"arm,mali-valhall-csf"), ())
>      ]
>  );
>  
> -impl platform::Driver for TyrPlatformDriverData {
> +impl platform::Driver for TyrPlatformDriver {
>      type IdInfo = ();
> -    type Data<'bound> = Self;
> +    type Data<'bound> = TyrPlatformDriverData;
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
>  
>      fn probe<'bound>(
>          pdev: &'bound platform::Device<Core<'_>>,
>          _info: Option<&'bound Self::IdInfo>,
> -    ) -> impl PinInit<Self, Error> + 'bound {
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>          let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
>          let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
>          let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 9432ddd6b5b8..95cda7b0962f 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -5,7 +5,7 @@
>  //! The name "Tyr" is inspired by Norse mythology, reflecting Arm's tradition of
>  //! naming their GPUs after Nordic mythological figures and places.
>  
> -use crate::driver::TyrPlatformDriverData;
> +use crate::driver::TyrPlatformDriver;
>  
>  mod driver;
>  mod file;
> @@ -14,7 +14,7 @@
>  mod regs;
>  
>  kernel::module_platform_driver! {
> -    type: TyrPlatformDriverData,
> +    type: TyrPlatformDriver,
>      name: "tyr",
>      authors: ["The Tyr driver authors"],
>      description: "Arm Mali Tyr DRM driver",


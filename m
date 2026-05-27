Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4BCCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 22:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C152810EA8A;
	Wed, 27 May 2026 22:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="bDveqo1T";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A39610EA8A
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779922584; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ef9xFYZRLLooh2FZ5QejfmOobWzbx8OhUznwmBn2oK1zStX92gDxLuIFgjCMmWqhBt8Kb/uE5AgYmLYuX35l9DIlqnIVXWASIAlc5OIFtp9n23D7ujcV2UD+XTSHJFwqLxF4AQJu28CmRVv/joN9a+nGtufdAdKplejI+nuW/ZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779922584;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kTZkwCqKrQ1RccJhZ0Ny5etxeXqz+L9rW4idmre4STo=; 
 b=Ohy7zRbyS6Kdq3SVik13fDICo+PVt2hp5d/z1m4Ig88BZC8Xp91koBapG4LBSyEi5jhM256dXcXKhiA0tHnw6qUk38bWkw5Os9GUqpDxKkEytOkkPtCR9Dtt/OuJd9UUjcK8f3R7p0m17Mg1IzyxLctIqCn6XqSrBV5sgcitNwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779922584; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=kTZkwCqKrQ1RccJhZ0Ny5etxeXqz+L9rW4idmre4STo=;
 b=bDveqo1TPciICYDklIQM0RM3VqoD5jUKS6fcAqJYp2G1/7OGdEjVdDfPBXDnvnc4
 7iGl6h5nsnnLvO0OC3PvY+DB960JJ8eAWdO3jzeSXHdtbvQ05zPTga+PIZeE0hXkneH
 ynV+DGEbdVntjbNukFrKjDHtKwQvXGmrFqrPxSHc=
Received: by mx.zohomail.com with SMTPS id 1779922582476218.05927782354888;
 Wed, 27 May 2026 15:56:22 -0700 (PDT)
Date: Wed, 27 May 2026 15:56:21 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, daniel.almeida@collabora.com,
 boris.brezillon@collabora.com, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: drm: tyr: separate driver type from driver data
Message-ID: <ahd2lZuX7oZ0j_lx@um790>
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-2-dakr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525230152.277820-2-dakr@kernel.org>
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

On Tue, May 26, 2026 at 01:01:43AM +0200, Danilo Krummrich wrote:
> Introduce TyrPlatformDriver as a unit struct for the platform::Driver
> trait implementation and keep TyrPlatformDriverData for the private
> driver data.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
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
> -- 
> 2.54.0
>

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>


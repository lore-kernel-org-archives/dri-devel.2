Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C782107BCD7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625FD10E0AB;
	Fri, 13 Mar 2026 19:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="UczBoS+u";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD08810E0AB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 19:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773429227; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mwpTnRYly+IzGIov9SEB0JBKA9312bEb6yBNEI1nVYJ1Hb7AIKoqLNu3dHT/PPkLkJTCwZATStuy1qvFmCuZgEB4KmHWjS7D81wvHHdEcIIg1p0gkL/ISVjbDiYybjvxPY2g9M6ML0vHvFgbfBzs7aCZ+Yz5N58VVaxF6oXhFpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773429227;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=d178WPV7IADG26IcL6Xdkq9tGIb34gJiamUIxC5mAWs=; 
 b=kyDWjxoHafLiLEN9ocT7l1VQhh6X7axz4TqWYk24kzqCX571YAEW8/bJWxhPeVotawQ6FvcB+U7GW77yuk9AQVaohIk042udY4B+zw7TjmyV3L5vG2Qfpg9iDIHCECzkurtVYfZiNWroM4CMWWoaqQVbd+/4vWEFntaYqx9gayc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773429227; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=d178WPV7IADG26IcL6Xdkq9tGIb34gJiamUIxC5mAWs=;
 b=UczBoS+u0aFO6yLkTKpEmLtB+MluluhxCPLlWNS9GWkww4YRZU//1SXIxZe+WBCS
 ANWo73BeBR8m5VCyQhV8HTPSIt0xh+62/QvA3Va+Ah/CQJenA106SEn5GKUhVtOu1hZ
 9WupmT4PPuYcRAY7dNl3zlfphqv7PpJZ/1USEA6U=
Received: by mx.zohomail.com with SMTPS id 1773429226595123.56723760916884;
 Fri, 13 Mar 2026 12:13:46 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:13:45 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Boqun Feng <boqun@kernel.org>
Subject: Re: [PATCH v2 1/5] drm/tyr: Use register! macro for GPU_CONTROL
Message-ID: <abRh6cZIDN1V_jQ5@um790>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
 <20260312093953.78f53864@fedora>
 <FC466045-4D34-4100-B0BA-E0B2AFE66435@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FC466045-4D34-4100-B0BA-E0B2AFE66435@collabora.com>
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

On Fri, Mar 13, 2026 at 03:29:03PM -0300, Daniel Almeida wrote:
> 
> >> @@ -182,37 +105,67 @@ struct GpuModels {
> >>     prod_major: 7,
> >> }];
> >> 
> >> -#[allow(dead_code)]
> >> -pub(crate) struct GpuId {
> >> -    pub(crate) arch_major: u32,
> >> -    pub(crate) arch_minor: u32,
> >> -    pub(crate) arch_rev: u32,
> >> -    pub(crate) prod_major: u32,
> >> -    pub(crate) ver_major: u32,
> >> -    pub(crate) ver_minor: u32,
> >> -    pub(crate) ver_status: u32,
> >> -}
> >> -
> >> -impl From<u32> for GpuId {
> >> -    fn from(value: u32) -> Self {
> >> -        GpuId {
> >> -            arch_major: (value & genmask_u32(28..=31)) >> 28,
> >> -            arch_minor: (value & genmask_u32(24..=27)) >> 24,
> >> -            arch_rev: (value & genmask_u32(20..=23)) >> 20,
> >> -            prod_major: (value & genmask_u32(16..=19)) >> 16,
> >> -            ver_major: (value & genmask_u32(12..=15)) >> 12,
> >> -            ver_minor: (value & genmask_u32(4..=11)) >> 4,
> >> -            ver_status: value & genmask_u32(0..=3),
> >> -        }
> >> -    }
> >> +pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> >> +    let io = (*iomem).access(dev)?;
> >> +    let gpu_id = io.read(GPU_ID);
> >> +
> >> +    let model_name = if let Some(model) = GPU_MODELS.iter().find(|&f| {
> >> +        f.arch_major == gpu_id.arch_major().get() && f.prod_major == gpu_id.prod_major().get()
> >> +    }) {
> >> +        model.name
> >> +    } else {
> >> +        "unknown"
> >> +    };
> >> +
> >> +    // Create canonical product ID with only arch/product fields, excluding version
> >> +    // fields. This ensures the same product at different revisions has the same ID.
> >> +    let id = GPU_ID::zeroed()
> >> +        .with_arch_major(gpu_id.arch_major())
> >> +        .with_arch_minor(gpu_id.arch_minor())
> >> +        .with_arch_rev(gpu_id.arch_rev())
> >> +        .with_prod_major(gpu_id.prod_major())
> >> +        .into_raw();
> >> +
> >> +    dev_info!(
> >> +        dev,
> >> +        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> >> +        model_name,
> >> +        id,
> > 
> > This was previously right-shifted by 16. Now, I'm questioning this
> > decision to filter out the version fields. I think it'd be better to
> > print the raw ID directly. We're already extracting and printing the
> > arch major.minor and version status, but if there's anything else
> > we want to clearly extract from this raw ID, we could add more.
> > 
> > TLDR; that's probably one place where I think it's not such a bad idea
> > to diverge from Panthor and print an unmodified GPU_ID. Maybe s/id/raw
> > GPU ID/ to make the distincting clear. None of this should happen in
> > this commit though. Either we do that in a preliminary commit that
> > drops the `>> 16`, or we keep the `>> 16` here, and change that in a
> > follow-up.
> 
> IIRC, Onur recently cleaned this up, hasn’t he?

Onur's patch fixes the model name detection and it's in drm-rust-next:
289cf6f91459 drm/tyr: gpu: fix GpuInfo::log model/version decoding

But it doesn't touch the generation of the id. So, in v3 I'll add a
separate commit to print the GPU_ID without filtering.

> 
> > 
> >> +        gpu_id.ver_major().get(),
> >> +        gpu_id.ver_minor().get(),
> >> +        gpu_id.ver_status().get()
> >> +    );
> > 
> > [...]
> > 
> >> +
> >> +    impl GPU_COMMAND {
> >> +        /// No operation. This is the default value.
> >> +        pub(crate) const NOP: u32 = 0;
> >> +        /// Reset the GPU.
> >> +        pub(crate) const RESET: u32 = 1;
> >> +        /// Flush caches.
> >> +        pub(crate) const FLUSH_CACHES: u32 = 4;
> >> +        /// Clear GPU faults.
> >> +        pub(crate) const CLEAR_FAULT: u32 = 7;
> >> +    }
> >> +
> >> +    register! {
> >> +        /// GPU command register in reset mode.
> >> +        /// Set command to [`GPU_COMMAND::RESET`] to set reset_mode.
> >> +        pub(crate) GPU_COMMAND_RESET (u32) => GPU_COMMAND {
> >> +            7:0     command;
> > 
> > Alexandre, dunno how hard it would be to extend this alias syntax to
> > provide auto-initialization/expected-value of certain fields, like:
> > 
> > pub(crate) GPU_COMMAND_RESET (u32) => GPU_COMMAND {
> >            7:0     command <- GPU_COMMAND::RESET;
> >            11:8    reset_mode;
> >        }
> > 
> 
> +1 to the syntax above. This looks quite ergonomic IMHO.
> 
> > so that when you instantiate a GPU_COMMAND_RESET, all you have to set is
> > reset_mode and the command gets set to GPU_COMMAND::RESET for you.
> > (that's for the write path, for the read path, you'll need some sort of
> > match to do the re-interpretation anyway).
> > 
> > Just to be clear, I'm not asking for any of that in the current
> > register!() patchset. It's more a suggestion for a potential future
> > improvement.
> > 
> >> +            11:8    reset_mode;
> >> +        }
> >> +    }
> 
> — Daniel

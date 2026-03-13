Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C146107BCD6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737BA10E481;
	Fri, 13 Mar 2026 18:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="T7qSRLp7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB6510E481
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773426564; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UA+YIPa2f/wH9T9V9S8KwWfDPMGfc4ZrugiaUEAWsLzmwA7KfGBeHC/Q+66peSQT5FqG0u2XDOCNnsJUQtsA0tD/B18S8kQLpNg+BuIS9spvFYQ5P38Jir/wQdM6lqc8iY1JnsSQnLMpByF05DrOhgS5K3hIwHv6DCp5aEP/Lg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773426564;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aLv5wB04JBZ4qwqg8LI8dC2Wcc9L1ydcyX5MHr5YKm0=; 
 b=PuZLYE//mSrUqbZthqHDWd8rI0hLaThsmcjTT2pbh8QUtDDesNQp/Cq2L6ymGMgmkspNQWphMiBD1uHQNw8v3QT6RTMOW1/F+SBq/1jtYNtMhMmEI4luoY8oCibdqivFJFOULxbPxAUAHf0h2CzaRh2eT6BE5raQpLoGOzG0zBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773426563; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=aLv5wB04JBZ4qwqg8LI8dC2Wcc9L1ydcyX5MHr5YKm0=;
 b=T7qSRLp7tHWkzJeceLHhsJ0JosxLGrU3jX7rQz71v6QEYN7ac/7TN/B3AJ9sX6Ry
 NjeiA9/xc/UvlshpwG180QS2dU8WmWHkvIc89LRCTQ+h8yfh2OpY/D0gDKoG/+WJClN
 0K4nuOiNIoLFe7z6qwGrh/QPYNpLIPFME1O4x618=
Received: by mx.zohomail.com with SMTPS id 1773426561175590.3130153228211;
 Fri, 13 Mar 2026 11:29:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/5] drm/tyr: Use register! macro for GPU_CONTROL
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260312093953.78f53864@fedora>
Date: Fri, 13 Mar 2026 15:29:03 -0300
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Boqun Feng <boqun@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC466045-4D34-4100-B0BA-E0B2AFE66435@collabora.com>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
 <20260312093953.78f53864@fedora>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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


>> @@ -182,37 +105,67 @@ struct GpuModels {
>>     prod_major: 7,
>> }];
>>=20
>> -#[allow(dead_code)]
>> -pub(crate) struct GpuId {
>> -    pub(crate) arch_major: u32,
>> -    pub(crate) arch_minor: u32,
>> -    pub(crate) arch_rev: u32,
>> -    pub(crate) prod_major: u32,
>> -    pub(crate) ver_major: u32,
>> -    pub(crate) ver_minor: u32,
>> -    pub(crate) ver_status: u32,
>> -}
>> -
>> -impl From<u32> for GpuId {
>> -    fn from(value: u32) -> Self {
>> -        GpuId {
>> -            arch_major: (value & genmask_u32(28..=3D31)) >> 28,
>> -            arch_minor: (value & genmask_u32(24..=3D27)) >> 24,
>> -            arch_rev: (value & genmask_u32(20..=3D23)) >> 20,
>> -            prod_major: (value & genmask_u32(16..=3D19)) >> 16,
>> -            ver_major: (value & genmask_u32(12..=3D15)) >> 12,
>> -            ver_minor: (value & genmask_u32(4..=3D11)) >> 4,
>> -            ver_status: value & genmask_u32(0..=3D3),
>> -        }
>> -    }
>> +pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: =
&Devres<IoMem>) -> Result {
>> +    let io =3D (*iomem).access(dev)?;
>> +    let gpu_id =3D io.read(GPU_ID);
>> +
>> +    let model_name =3D if let Some(model) =3D =
GPU_MODELS.iter().find(|&f| {
>> +        f.arch_major =3D=3D gpu_id.arch_major().get() && =
f.prod_major =3D=3D gpu_id.prod_major().get()
>> +    }) {
>> +        model.name
>> +    } else {
>> +        "unknown"
>> +    };
>> +
>> +    // Create canonical product ID with only arch/product fields, =
excluding version
>> +    // fields. This ensures the same product at different revisions =
has the same ID.
>> +    let id =3D GPU_ID::zeroed()
>> +        .with_arch_major(gpu_id.arch_major())
>> +        .with_arch_minor(gpu_id.arch_minor())
>> +        .with_arch_rev(gpu_id.arch_rev())
>> +        .with_prod_major(gpu_id.prod_major())
>> +        .into_raw();
>> +
>> +    dev_info!(
>> +        dev,
>> +        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
>> +        model_name,
>> +        id,
>=20
> This was previously right-shifted by 16. Now, I'm questioning this
> decision to filter out the version fields. I think it'd be better to
> print the raw ID directly. We're already extracting and printing the
> arch major.minor and version status, but if there's anything else
> we want to clearly extract from this raw ID, we could add more.
>=20
> TLDR; that's probably one place where I think it's not such a bad idea
> to diverge from Panthor and print an unmodified GPU_ID. Maybe s/id/raw
> GPU ID/ to make the distincting clear. None of this should happen in
> this commit though. Either we do that in a preliminary commit that
> drops the `>> 16`, or we keep the `>> 16` here, and change that in a
> follow-up.

IIRC, Onur recently cleaned this up, hasn=E2=80=99t he?

>=20
>> +        gpu_id.ver_major().get(),
>> +        gpu_id.ver_minor().get(),
>> +        gpu_id.ver_status().get()
>> +    );
>=20
> [...]
>=20
>> +
>> +    impl GPU_COMMAND {
>> +        /// No operation. This is the default value.
>> +        pub(crate) const NOP: u32 =3D 0;
>> +        /// Reset the GPU.
>> +        pub(crate) const RESET: u32 =3D 1;
>> +        /// Flush caches.
>> +        pub(crate) const FLUSH_CACHES: u32 =3D 4;
>> +        /// Clear GPU faults.
>> +        pub(crate) const CLEAR_FAULT: u32 =3D 7;
>> +    }
>> +
>> +    register! {
>> +        /// GPU command register in reset mode.
>> +        /// Set command to [`GPU_COMMAND::RESET`] to set reset_mode.
>> +        pub(crate) GPU_COMMAND_RESET (u32) =3D> GPU_COMMAND {
>> +            7:0     command;
>=20
> Alexandre, dunno how hard it would be to extend this alias syntax to
> provide auto-initialization/expected-value of certain fields, like:
>=20
> pub(crate) GPU_COMMAND_RESET (u32) =3D> GPU_COMMAND {
>            7:0     command <- GPU_COMMAND::RESET;
>            11:8    reset_mode;
>        }
>=20

+1 to the syntax above. This looks quite ergonomic IMHO.

> so that when you instantiate a GPU_COMMAND_RESET, all you have to set =
is
> reset_mode and the command gets set to GPU_COMMAND::RESET for you.
> (that's for the write path, for the read path, you'll need some sort =
of
> match to do the re-interpretation anyway).
>=20
> Just to be clear, I'm not asking for any of that in the current
> register!() patchset. It's more a suggestion for a potential future
> improvement.
>=20
>> +            11:8    reset_mode;
>> +        }
>> +    }

=E2=80=94 Daniel=

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B088C55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DCE10E639;
	Mon,  3 Aug 2026 17:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OdRw8WJC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D9910E639
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:56:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 997F841A6B;
 Mon,  3 Aug 2026 17:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C6B1F000E9;
 Mon,  3 Aug 2026 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785779797;
 bh=ihzE00+caEyyGAyJnAUTpAAPcz2FPtHVqqcNm5l8H8Y=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=OdRw8WJCR5s67MPCCDorPFOUgUk/FS8WgAxajB4Ins7fYQvAzwi/g50xFhbRPDGI7
 j5o2T8zpPNIh0Q4ECnR5oTU9NkMEeV5ssoY1AN63S9jYy4A1MiefEuboQLdSH6LjaD
 E0ZbFipEqW3LKKkUY8HldcUeS+8jsOKkFcpYfOCucMi8x9pPGuAQoPFWPP7TzhfsG6
 ZgcOQq5Y+PdPZNlGeq3RVNgeLlFqMHK42hWY3YjxsLfxnd3/eordh3BFB56ko5SEzB
 2j21QfTqKnSHC6kpRMRbw/cjw400Wp2PPlR2yfOeiZ3JC2sVD6W8L4InN48k6cM8zc
 5O6oB4VDxgyMg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 19:56:30 +0200
Message-Id: <DKFI3QBK1A04.28I347HOKJ8TE@kernel.org>
Subject: Re: [PATCH v2 8/9] drm/tyr: add gpuvas debugfs file
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Melissa Wen"
 <mwen@igalia.com>, "Wambui Karuga" <wambui.karugax@gmail.com>, "Eric
 Anholt" <eric@anholt.net>, "Ben Gamari" <bgamari@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Alvin Sun" <alvin.sun@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-8-aea19eccb996@linux.dev>
In-Reply-To: <20260731-tyr-debugfs-v2-v2-8-aea19eccb996@linux.dev>
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

On Thu Jul 30, 2026 at 7:05 PM CEST, Alvin Sun wrote:
> +impl drm::debugfs::DrmSeqShow<TyrDrmDriver> for GpuvasShow {
> +    fn show(guard: &drm::RegistrationGuard<'_, TyrDrmDriver>, m: &seq_fi=
le::SeqFile) -> Result {
> +        guard.registration_data_with(|reg_data| {
> +            reg_data
> +                .debugfs_data
> +                .gpuvas
> +                .for_each(|vm| vm.dump_gpuva_info(m))
> +        })
> +    }
> +}

Should simplify to:

	impl SeqShow<TyrDrmRegistrationData<'_>> for GpuvasShow {
	    fn show(reg_data: &TyrDrmRegistrationData<'_>, m: &SeqFile) -> Result =
{
	        reg_data
	            .debugfs_data
	            .gpuvas
	            .for_each(|vm| vm.dump_gpuva_info(m))
	    }
	}

> +    fn debugfs_init<'a>(dev: &'a drm::Device<Self, drm::Normal>, dir: &S=
copedDir<'a, 'static>) {
> +        dir.seq_file::<GpuvasShow, _>(c"gpuvas", dev);
> +    }

Should become:

	fn debugfs_init(dir: &debugfs::ScopeRef<'_, TyrDrmRegistrationData<'_>>) {
	    dir.seq_file::<GpuvasShow>(c"gpuvas");
	}

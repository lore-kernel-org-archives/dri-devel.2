Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE7EC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427B210E10A;
	Mon, 10 Aug 2026 22:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GhbxCYa/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D37810E10A
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 22:24:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E72E6001D;
 Mon, 10 Aug 2026 22:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9EA1F000E9;
 Mon, 10 Aug 2026 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786400660;
 bh=c5teRNqTCwBmsRp6KfY4/U4W4r2oUzk4Bf/5/gdPplQ=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=GhbxCYa/bVp8EyR5yS9RiF9YdaRYpQh+cmKvn2Hm9z6VTs23J7/2i7FUkCLjUXAk+
 Vq01S+07iAO6yI9j5D/5heCbRhh529UwmcZf/dFY/r/KOT2HKdtFAOSSBYihthpoVm
 53sUQ96tJpbT8HNMCeIVPiYzeSbDCBOUMPEDfXi+B44XFsKYZG19Qzcfzjfc8Ze+pp
 zguHO/llRh0MdFCrFlT1U0rbt3G9Q3fDuzdsSfWfqkc5g+ZlyMd5pjLxmvVsc3sU2i
 cOT2dKWychwAopSo1WnlOTudMixJ4/F0/vyJR1hIbShjBSWoNZroh1NNgQc24MBHkJ
 H0OVCzb2uzibw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 00:24:13 +0200
Message-Id: <DKLM6J169QBA.100RAXAAOA9HO@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 04/12] gpu: nova-core: mm: Add VramAddress type
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
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

On Mon Aug 10, 2026 at 3:55 PM CEST, Eliot Courtney wrote:
> +/// Physical VRAM address in GPU video memory.
> +#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
> +#[repr(transparent)]
> +pub(crate) struct VramAddress(u64);

Let's move this into generic code, maybe rust/kernel/gpu/types.rs? I wouldn=
't
mind doing this as a follow-up though. Will go over the rest of the series =
soon.

Thanks,
Danilo

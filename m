Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446B606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtOT5pas
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD66210EFD6;
	Mon, 16 Nov 2026 12:29:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41C010EFD6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:29:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84154412A1;
 Mon, 16 Nov 2026 12:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C731F000C5;
 Mon, 16 Nov 2026 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794832174;
 bh=guwh6GozeLPvfz356i8dWE3xUsjRarXnXelDp26/pfM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=BtOT5paszL/iHTVLo7bxBBQaxXYSu4mS5U31XRsJQwxbbyqtQHDN445nhI1N4gY7M
 RuZtqBcHPweZutKPJaSM9bbn0Hs/8/DcvtIa4VBx8a9yPe0pnv6ZPG2vXI673s/rJQ
 iYB1EK3Fb81UJi+OmE9L2/NDTRNFiEHmQ39f5KiuUET88zv8DF6gvsYZbXrMtcamBP
 NTLMRdu4RM7AT11Q1vXvuRA/wYf89tRcKedxm6r9G/E0Iz+h+nx5cIkNJuppszSRuX
 0q+zjL0Sh49t33CJ1OdSvF3ugVHLsJ5uc9AlReFTZG8h7egWMMKGdd3ty+Hg+VfPyo
 aCTBlVsnkVS0g==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 13:29:29 +0100
Message-Id: <DMWMWJV23VO4.1V6D60QKD5KT5@kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: remove unnecessary firmware pin-init
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261114234324.82387-1-dakr@kernel.org>
 <20261114234324.82387-2-dakr@kernel.org>
 <DMWC44MU9W7N.3TBNH0HCKK065@nvidia.com>
In-Reply-To: <DMWC44MU9W7N.3TBNH0HCKK065@nvidia.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 5:02 AM CET, Alexandre Courbot wrote:
>> +    pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset: =
Chipset) -> Result<Self> {
>
> `GspFirmware` is 312 bytes, that's not enormous but that's also not
> small... Shall we keep returning an `impl Pininit`?

I considered that, but it's only ever constructed in Gsp::boot() and does n=
ot
outlive boot(), so I think it should be fine.

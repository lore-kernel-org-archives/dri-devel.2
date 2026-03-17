Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43408FB5EAD
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF2310E259;
	Tue, 17 Mar 2026 14:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YET4X8Al";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D706410E259;
 Tue, 17 Mar 2026 14:40:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 15E4660018;
 Tue, 17 Mar 2026 14:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8DAC2BC86;
 Tue, 17 Mar 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773758432;
 bh=EvYCcTW9OZ4w+eYnCud94ZVVBQFcEHeOk0Qf21v1cWs=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=YET4X8Al0E7xW+qNdPitpEBKm67SGfBeakvvFwPWtHFId/MrUTmacfbxc+Dvtprp7
 l89HGwLfRbb6UNAOtar9lV10fYIY9tfSp2yohZK/tLKjgJ2Fxl2w+vYDgYbHs7piq4
 7et28Wse4LWMT3UF5yDw6KlqDutJ/VxXIED6eesTZVsCerJSN1+x6i0D/b83uX9qKB
 6ykLvlCHefbUiVxdUo2c3SWCGT363ZQZ0xekXjun0eLrlRFBXZPxjL8yRaA9dCUwcs
 ZtCa2MkNk1ReLDHuZBhvC+39B0/Hj8mR8tTAigYX8f4GM078sQ5rYPvGV03tah/F+m
 lhT176bR0fCtw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 15:40:28 +0100
Message-Id: <DH54VWW1RXMQ.34MLWMQ1ZE0I1@kernel.org>
Subject: Re: [PATCH 4/8] rust: dma: introduce dma::CoherentInit for memory
 initialization
Cc: <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-5-dakr@kernel.org> <abj6I9c_2IR0cKJ6@google.com>
In-Reply-To: <abj6I9c_2IR0cKJ6@google.com>
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

On Tue Mar 17, 2026 at 7:52 AM CET, Alice Ryhl wrote:
> On Tue, Mar 03, 2026 at 05:22:55PM +0100, Danilo Krummrich wrote:
>> Currently, dma::Coherent cannot safely provide (mutable) access to its
>> underlying memory because the memory might be concurrently accessed by a
>> DMA device. This makes it difficult to safely initialize the memory
>> before handing it over to the hardware.
>>=20
>> Introduce dma::CoherentInit, a type that encapsulates a dma::Coherent
>> before its DMA address is exposed to the device. dma::CoherentInit can
>> guarantee exclusive access to the inner dma::Coherent and implement
>> Deref and DerefMut.
>>=20
>> Once the memory is properly initialized, dma::CoherentInit can be
>> converted into a regular dma::Coherent.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> overall LGTM
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Gary and me concluded that dma::CoherentBox would probably be a better name=
 for
what this structure represents. I.e. you can carry it around and use it sim=
ilar
to a "real" Box until it is converted to dma::Coherent in order to make it
available to the device.

Is your RB still valid with this rename?

>> +        let ptr =3D core::ptr::from_mut(&mut self[i]);
>
> &raw mut self[i].
>
> Alice


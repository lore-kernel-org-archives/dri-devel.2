Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A11C106B538
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65DA10E1B4;
	Wed, 25 Mar 2026 13:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lzc9iRun";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D7010E1B4;
 Wed, 25 Mar 2026 13:46:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DD6B643DE8;
 Wed, 25 Mar 2026 13:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B01C4CEF7;
 Wed, 25 Mar 2026 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774446401;
 bh=EsepFe1hTb5yu5DvZwZ6ftYofkp6jSkghDu2bLsvZFc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=Lzc9iRunAk7MiPNEUxkZBdZUGG559+UZ9DVpW3Ciygeuez0OPaJRURjDHkplhW3/g
 ASTg+NyrAwFUpscHzNrkdeqX2gZxv6dVT1gYCHJ2oA06aTK4VtQcuMoMJ4qu74BBuZ
 Eunp3AqstGSSUAaF909Dmdu9yVkm9mxygGT4MqJHVH1/qv9yFSOFVgX2HD51sxiaCO
 mbxzUvH8qaIzRq4MGvbezsVtHYokDXHjMGWzpVlbZnbv7Mznr80zDXg4RR8R6aw4jA
 VZnCFJyx4rJoj0gWRYkKYAz/VDPcPPTytp82xjooGwP25FDwGoA4MR1zp1zca9RsKC
 eGiUNqVkHMU7w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 14:46:36 +0100
Message-Id: <DHBWR17G0AIE.30MDYBUT7PNZL@kernel.org>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <ttabi@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260325003921.3420-1-dakr@kernel.org>
 <DHBVS7DX89G2.34ELW7TJAH7M8@garyguo.net>
In-Reply-To: <DHBVS7DX89G2.34ELW7TJAH7M8@garyguo.net>
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

On Wed Mar 25, 2026 at 2:01 PM CET, Gary Guo wrote:
> I think there is a reason, which is that it weakens the strong typing tha=
t we
> have. I think it'll be better to have this be
>
>     fn write_dma<T>(&mut self, view: View<'_, Coherent<T>, [u8]>, offset:=
 usize) -> Result
>
> once we have I/O view and expect people to create cast views into bytes
> explicitly.
>

There is technically no difference between the above and the below, except =
that
for the above the user has to create the View first, i.e. it needs addition=
al
code. What's the advantage?

>> +    pub fn write_dma<T: KnownSize + AsBytes + ?Sized>(
>> +        &mut self,
>> +        alloc: &Coherent<T>,
>> +        offset: usize,
>> +        count: usize,
>> +    ) -> Result {

<snip>

> Although, given that we already have APIs like
>
>     fn write<T: AsBytes>(&mut self, value: &T)
>
> I'm okay with putting this in until we have a replacement solution.

Sounds good.

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F540CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F326F10E0DC;
	Mon, 25 May 2026 12:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H46V06tl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCEE310E224;
 Mon, 25 May 2026 12:05:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2D1C600BB;
 Mon, 25 May 2026 12:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6301F000E9;
 Mon, 25 May 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779710740;
 bh=8Nk9IRpfjFpPpcX3RiYgN+W6i/7+f2+AyfDzqFLXzt0=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=H46V06tlanS3w6FJpaYnHysMTaAdRs09nAhIdviag/qtWU5rAZ+SebBBlXCd+k1ki
 IIjWlnwI7wRGB2HeaEyW+yvEeHzY3gfgcaqdcRkQkgLsYc2vEAsWl/Jo5O/qk9E5Up
 LHPptJzP0wih50NohTPP+q8EeLNjy544KS6V2dT715q06s0c0An/YJOk7ONQDnsvoH
 2klWQ5GJ0DC4oExrsjEUszN/1/Qd+cH7difkpY3G5N4vs1HHWruW0hzXBZmyk6wvYN
 wJVKSb7pm5tbUn6fne/9LsJYQo8swAcJ8IT3Oox0CTOiGcgia2SDQmrCoAm2w2yofX
 QsbiWVqMSpgnw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 14:05:32 +0200
Message-Id: <DIRQSVO5H9X6.VG0RGGPYVWU9@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-18-dakr@kernel.org>
 <DIRHA02BRA92.32YSMYYL2QBIG@nvidia.com>
 <DIRQA2JNXAHY.2TVOL7GYSHM3V@garyguo.net>
In-Reply-To: <DIRQA2JNXAHY.2TVOL7GYSHM3V@garyguo.net>
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

On Mon May 25, 2026 at 1:40 PM CEST, Gary Guo wrote:
> On Mon May 25, 2026 at 5:37 AM BST, Eliot Courtney wrote:
>> On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
>>> +impl<'a, const SIZE: usize> Bar<'a, SIZE> {
>>> +    pub(super) fn new(pdev: &'a Device<device::Bound>, num: u32, name:=
 &CStr) -> Result<Self> {
>>
>> I think Sashiko's comment w.r.t. &CStrs in this patch looks accurate
>> and they should be 'static or at least 'a ish.
>
> It needs to be `'static` to be leak-safe.

Yes, it needs to be 'static as it is stored directly in struct resource. Th=
is
has been a bug without this patch already; I will insert a small fix for th=
is,
so it can be picked by stable separately.

Thanks,
Danilo

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E512C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC25A10EC4F;
	Wed, 29 Jul 2026 13:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jbOoEGYH";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0551B10EC47
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785331536;
 bh=KWJYtKPpKPxd/0cD7qwV/nPTub03vwqoMJ8NXWCbYSo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jbOoEGYHamZaPpx+biGDO+78RTJJNICdxia4npBYgOM2VgKZdhvF9VGhXFNADR+hC
 8Yzmn7s4xNvmH6VCUtucWwgqRlBBQYyoqTDWbEXHqfIZjwuNC7DyeJzt5keBeU7ctK
 KZtlD3p+Dsm+6ECkplXkhbDQnk4mUnjEhrGzbpy0UnuwNsec4IIy4lj8FK4QN/Oc/h
 hcapMLF+tui/gZdTdL7281iYZoWKaU3sEn+W3uN46583NLXhW9ftjKLL83I3+Ra4Ob
 /jb990rbZtxd2nPriCoVIRZP7KBMdZni7YdsHA98HeBlct4JrsIs+8k5V0JoxPOVED
 KUj9jzQnoSQRw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E5E3117E0055;
 Wed, 29 Jul 2026 15:25:34 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: ewan.chorynski@ik.me
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com,
 deborah.brouwer@collabora.com, dri-devel@lists.freedesktop.org,
 gary@garyguo.net, kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v2] drm/tyr: add Job IRQ handling
Date: Wed, 29 Jul 2026 15:25:22 +0200
Message-Id: <20260729132522.478273-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <9cf1107a-3dfd-43a6-9f25-d8e01595c9e3@mail.infomaniak.com>
References: <9cf1107a-3dfd-43a6-9f25-d8e01595c9e3@mail.infomaniak.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Ewan,

On 7/29/26 14:12, Ewan Chorynski wrote:
> On Wed, Jul 29, 2026 at 11:58:29AM +0200, Laura Nao wrote:
>> [...]
>> +
>> +impl<T: TyrIrqTrait> TyrIrq<T> {
>> +    pub(crate) fn request<'a>(
>> +        pdev: &'a platform::Device<Bound>,
>> +        name: &'static CStr,
>> +        irq: T,
>> +    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a>
>> +    where
>> +        T: 'a,
>> +    {
>> +        let handler = try_pin_init!(Self {
>> +            irq,
>> +            _pin: PhantomPinned,
>> +        });
>> +
>> +        // SAFETY: The resulting `PinInit` is not leaked, it is consumed by the caller to
>> +        // initialize a pinned `ThreadedRegistration`.
>> +        Ok(unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, name, name, handler) })
>
> I think your `request` function should be unsafe with the same
> requirements as `request_threaded_irq_by_name`, otherwise how do you
> guarantee that this safety justification holds ?
>

Oh right, I somehow forgot to propagate the safety requirement up the
call chain. That means job_irq_init() also needs to become unsafe, as
it's just a wrapper around request().

I'll address this in the next revision.

Thanks for the heads up!

Best,

Laura

>> +    }
>> +}
>> [...]


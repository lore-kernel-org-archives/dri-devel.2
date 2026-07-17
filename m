Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B41C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EAF10E28C;
	Fri, 17 Jul 2026 11:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TV2K7aLs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2358810E28C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:19:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 409F560A61;
 Fri, 17 Jul 2026 11:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1DB1F000E9;
 Fri, 17 Jul 2026 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784287187;
 bh=6+3kplEtdJiZ7BArih1Y0WYc76SIkb0/U86jp1lq8X4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TV2K7aLsAXB5ThVfMdKhRsNVo/RjAZC34KM3L3aU15x9S4j56z6k8gfO+zVQCkrCc
 Vzhyb6x/phaQkYm1TlcXknDBKf/5pPwXwUd/9MWx2Gx/ARhmDDzuFaoba23NwzQOTP
 yjWa26t/e3s6iLr2yP96G2WSd97KG8at/4AOiepRbYtl8TvyeE44t3iRIdL4mQyqqC
 uVG+HW+XkXZXPZXbteARiGO6KfE30fLheIMly3L1+Mp/dE2Eq+sx70aytXECgbpYf/
 3q/8/mvr3Rx+LAcKkbL0xLuc/C6Z19YTrsT8uxDQ4ViEtaNvNQhDrzQ1UWcyCdd0C5
 /2i4nOdTpAAog==
Message-ID: <415dd6e7-4613-47e9-b345-76a44d3ec49e@kernel.org>
Date: Fri, 17 Jul 2026 13:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Markus Probst <markus.probst@posteo.de>, Rob Herring <robh@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Kari Argillander <kari.argillander@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2026071747-android-overhead-c927@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/17/26 12:55 PM, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
>> This patch series adds the serdev device bus rust abstraction into the
>> kernel.
>>
>> This abstraction will be used by a driver,
>> which targets the MCU devices in Synology devices.
>>
>> Kari Argillander also messaged me, stating that he wants to write a
>> watchdog driver with this abstraction (needing initial device data).
>>
>> This series depends on [1].
>>
>> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/
>>
>> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> 
> Given there are no objections, I'll go queue this up now, thanks.
You'll need the patches from [1] as well.

Thanks,
Danilo

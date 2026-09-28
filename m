Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EED2C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E1910E4EE;
	Mon, 28 Sep 2026 12:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B5Q4e80Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBEBB10E4EE
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:15:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E248411B6;
 Mon, 28 Sep 2026 12:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526A21F000FF;
 Mon, 28 Sep 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790597716;
 bh=HDe6ouDH2NewJUwwqo4l3PMqfR3AF+iTbUPvWV57SaM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=B5Q4e80QkWzex+4GkzBEcZCsdU13+v85Y0pZBrq4Yx5u0vi4HUoYYNSKFLtluIq/h
 ua+9qD3RmcRpFwrXsyuYy1WyH7DsdSegltYaC8dJtiqHXuoJJLU6t3EwPqy1t53ZBL
 VtvNFz3uKmuA7BAi5ICMVrwEdKxwvS/rdnodgMYXA0soI5SFwqrpegGoFMUBpFYX1b
 eiwGv00smtL09d0/OYdQXQVdOcE0MR1oq5VtUBrp1quJXA4j61XYsBZgfbVycBGqxM
 LffCwp6BtWAP5eXGhbCrmCXfOkOvVI18dOwmiYwj7OUTnuRYTuuySgTg3KTjRXdZwh
 K1L4A9ezd+K8g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:15:13 +0200
Message-Id: <DLQXWXRP3P1J.28SLFOJJQ2EDK@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQX3FCYMAGD.3MS8E1JK5J7D2@garyguo.net>
 <DLQXLV1FYMQS.JBP531K4P4T8@kernel.org>
 <DLQXTBWUJWGP.WGY6G88ATQM7@garyguo.net>
In-Reply-To: <DLQXTBWUJWGP.WGY6G88ATQM7@garyguo.net>
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

On Mon Sep 28, 2026 at 2:10 PM CEST, Gary Guo wrote:
> On Mon Sep 28, 2026 at 1:00 PM BST, Danilo Krummrich wrote:
>> On Mon Sep 28, 2026 at 1:36 PM CEST, Gary Guo wrote:
>>> I think this doesn't need to use `pin_chain`? You can do
>>>
>>>     gpu <- ...,
>>>
>>>     _: {
>>>         #[cfg(...)]
>>>         gpu.run_self_tests(pdev);
>>>     }
>>
>> Unfortunately, this produces the following error.
>>
>> 	error[E0382]: borrow of moved value: `gpu`
>> 	   --> drivers/gpu/nova-core/driver.rs:140:62
>> 	    |
>> 	119 |             gpu <- Gpu::new(
>> 	    |             --- move occurs because `gpu` has type `core::pin::Pi=
n<&mut gpu::Gpu<'_>>`, which does not implement the `Copy` trait
>> 	...
>> 	129 |                 gpu.run_selftests(pdev);
>> 	    |                 --- value moved here
>
>     gpu.as_mut().run_selftests(pdev);
>
> should work?

I tried that previously, that gives another error. I didn't dig in further
though.

	error[E0596]: cannot borrow `gpu` as mutable, as it is not declared as mut=
able
	   --> drivers/gpu/nova-core/driver.rs:129:17
	    |
	129 |                 gpu.as_mut().run_selftests(pdev);
	    |                 ^^^ cannot borrow as mutable
	    |
	help: consider changing this to be mutable
	    |
	119 |             mut gpu <- Gpu::new(
	    |             +++
=09
	error: aborting due to 1 previous error

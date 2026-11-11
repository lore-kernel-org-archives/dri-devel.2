Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66A606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsN3k6eM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4696A10FD1B;
	Wed, 11 Nov 2026 19:48:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1014A10FD1B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:48:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3A3361E15;
 Wed, 11 Nov 2026 19:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B31F00A05;
 Wed, 11 Nov 2026 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794426508;
 bh=sreCxIXGIejtK05MJ82O28sfOgXln4JF8sALP5b78xE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gsN3k6eMqOCYeLtz+wraoZ5FHzTo8InlE/0idhUY6HPNbT4KDm0boRaK6Iyv8ObTc
 TamNfRMfIhWeJYAKGo3nkV9SNfh8zEYNUNnq0ClJjKbA3HqPFENu1mYkpaYQYBw7aZ
 VyN82hmfZJgsNzkpMkVxBCyifNVUsBbfEDcPvINmpcFUmo/naD4fAkELiynIbEVgtf
 qFHLF4iCrXFtfnLWtUpo6f9K/9xTh21xx65ZCeZD1tJrR3Htu6TXLvPC+UeDUC7t/l
 ChSYs+uJbzalY2k3bDGomejZ4h48rbBHg2yFJFZ0MkFxZHm8QAbGRfEOpvZL0xF4kP
 BTbmmfnqUaCBw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>, Dave Airlie via B4 Relay
 <devnull+airlied.redhat.com@kernel.org>
Cc: airlied@redhat.com, FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary
 Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 1/2] rust: time: expose as_nanos for clock sources.
In-Reply-To: <DMRKZL0RNSG4.3P7B0RM71I0CG@nvidia.com>
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
 <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
 <HgxksqDneCpV2KCW_EeAGi_PEZ4HXYdwPqm0pHMkGPQlo0kktMkB-lNOjxQyUZtYhs1JzEFfjHyQAgDlVAqMMg==@protonmail.internalid>
 <DMRKZL0RNSG4.3P7B0RM71I0CG@nvidia.com>
Date: Wed, 11 Nov 2026 20:48:17 +0100
Message-ID: <87zevfup32.fsf@t14s.mail-host-address-is-not-set>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Alexandre Courbot" <acourbot@nvidia.com> writes:

> On Mon Nov 9, 2026 at 10:55 AM JST, Dave Airlie via B4 Relay wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> The nouveau C driver does ktime_to_ns(ktime_get()) to program
>> the cpu ns into some hw/fw, so allow this method for rust drivers.
>>
>> This is needed for following nova patch.
>>
>> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>
> This patch has also received a maintainer acked-by:
>
> https://lore.kernel.org/all/875wyoydqk.fsf@t14s.mail-host-address-is-not-set/

You guys want to take this through your tree? Otherwise I will apply it
to rust-timekeeping this week.

Best regards,
Andreas Hindborg



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ou8Ls/u0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD11A10E5DF;
	Thu, 12 Nov 2026 13:51:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589A610E5DF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:50:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 149DC43C07;
 Thu, 12 Nov 2026 13:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EFF1F00A05;
 Thu, 12 Nov 2026 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794491458;
 bh=b2rTD3RNw/wmfQmagbMmHdQ+mRLznGGUNUzFgFRsNVM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ou8Ls/u0SV/9IsDV8EHksS4J/VjPYYOXNnydIW3tI8ilMfGYgY6oNJjiRD1fcQJkA
 vbV+gRMyBwaXmf8CJaP2VQRcQ6RDmfabBNpgNUE2a5/62VWrsU9XDpkNiY3umiZ+sz
 /RaUGoWF20VS85myoaH3EPKZ/meNWorZOhGxD9v3Y9hSKGRc1ZQTW1WREFyzRPAB/h
 YTX18PMsE4XOdPHcNbO7Tx1+SlayX0YrFrOtpeMoap1Uzbx0VuEgzhCn9siS6U7kPb
 ELGePdQsPxrVkCPUIwoeCTAxrAy9N2um/VbEd3zienj3lyof4ig1wlXUC9JYMJDnDF
 MgJoNZADZfY8Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo
 <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Dave Airlie <airlied@redhat.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 1/2] rust: time: expose as_nanos for clock sources.
In-Reply-To: <DMT91N7BGPUU.17BEZWQDLH3CC@kernel.org>
References: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
 <179448764517.621816.16006004780926601543.b4-ty@b4>
 <DMT91N7BGPUU.17BEZWQDLH3CC@kernel.org>
Date: Thu, 12 Nov 2026 14:50:45 +0100
Message-ID: <87tslmupje.fsf@t14s.mail-host-address-is-not-set>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Thu Nov 12, 2026 at 1:47 PM CET, Andreas Hindborg wrote:
>>
>> On Wed, 11 Nov 2026 15:23:24 +1000, Dave Airlie wrote:
>>> The nouveau C driver does ktime_to_ns(ktime_get()) to program
>>> the cpu ns into some hw/fw, so allow this method for rust drivers.
>>> 
>>> This is needed for following nova patch.
>>
>> Applied, thanks!
>
> Do you mind if we take this through the DRM tree? Otherwise the subsequent patch
> in this series has to wait for a cycle.

No it is fine, I can drop it from my tree. I asked on v6 what you
wanted, either way is fine :)


Best regards,
Andreas Hindborg



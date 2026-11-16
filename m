Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF5606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kF82zkG/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D251510E332;
	Mon, 16 Nov 2026 12:47:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DDF10E332
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:47:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A91FC461D4;
 Mon, 16 Nov 2026 12:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD70B1F000C4;
 Mon, 16 Nov 2026 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794833244;
 bh=+cDv/pKHxcNHjklS71gl29DbGDdZdz6UNn0YpVLmt14=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=kF82zkG/Q/t6koMQVrwlYIC5NMCiFTq/yo3Q2orsUqZqqnFdC8NCyUPVeEhno4jHs
 WfN3itAslWHNeQPNitouyQGmyQqVIyn/3c/JMCeGcw1z2+Ho+5kDQYv+ruGIZL4wag
 mi6PG+tiTshNN87hswDC1TzoySq3IstjUIStzEtMUKZjqXP9YZxJZe1exgsewu1mMG
 CfmwQplqcAIgvprEkT2ySgfn67Lg8X1JadvA1Sb/m5Z12IcNBBQlHIBJFW8yftH816
 r8jWdcJpaMFo6U/nDPariIqPJooPUk6awzToz7m74bDio8J4HzsfE6mOXX1BLdytY3
 3/CSn6Sq2DalQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 13:47:21 +0100
Message-Id: <DMWNA84XI432.TJG95PPPMGPR@kernel.org>
Subject: Re: [PATCH v2 2/2] gpu: nova-core: use pin-init self-referential
 support
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261111161935.750047-1-dakr@kernel.org>
 <20261111161935.750047-2-dakr@kernel.org>
 <DMWH39UWW4KZ.1C5B2M4W1V3CF@nvidia.com>
 <DMWM4KAYL7PT.2ECY3BSNIA2P@garyguo.net>
In-Reply-To: <DMWM4KAYL7PT.2ECY3BSNIA2P@garyguo.net>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 12:52 PM CET, Gary Guo wrote:
> On Mon Nov 16, 2026 at 7:56 AM GMT, Alexandre Courbot wrote:
>> On Thu Nov 12, 2026 at 1:19 AM JST, Danilo Krummrich wrote:
>> <...>
>>>  drivers/gpu/nova-core/gsp/cmdq.rs     | 16 ++++++--
>>>  drivers/gpu/nova-core/gsp/cmdq/gmc.rs |  9 +++--
>>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 11 +++---
>>
>> The changes to these files look like they are a change on their own;
>> they are not using the self-referential support but rather change how
>> the queue lock is acquired. It should probably be a separate patch
>> before the rest (which would be the last patch of the series).
>
> This is actually integral due to variances, as the existing code more or =
less
> relies on cmdq being covariant unsafely. Pin-init is going to enforce tha=
t so it
> needs to be updated to use existential lifetime to make cmdq actually cov=
ariant.

Yes, those changes are related to the use of self-referential pin-init. We =
could
technically introduce the with_inner_locked() helper separately, but that s=
eems
excessive and creates unnecessary churn.

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3459606E315
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyxTUrUZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4441410E259;
	Thu, 12 Nov 2026 14:22:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AAD10E259
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:22:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 039F06025F;
 Thu, 12 Nov 2026 14:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6011F00A07;
 Thu, 12 Nov 2026 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794493339;
 bh=6Uhgh5f0UkJqtxuPPZlStg6ICiuBZFc5JhOCR4BHkuY=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=VyxTUrUZDdCUiRmQh0hmFVPZb5oo70UmX5ge/ugQS1Wmuw2p4jZ1ccxp62yPSVCcZ
 H6q5beXdT8gHM5iIbbufnC5qw3z4+ab+BrNLo+EUezuNQj77jcE37dhOrKuLMOfqGp
 DK7SKgbxHyQzJYo8R9WD0PLEBdPVQdJ9rmO8J69eTIVa3v8B9/pLNByN2G4aChKYJC
 u0oKlWJysrE8D0mLmk4QdKx8Dn/sw3xDZ59IAFr7204A3LpzdrFoyhrB1cPk7t/m1U
 yJF9cZRY9zo5r7PsSTFKHVG8WAxd9386jLgPgXpABQC11tSiSvGbmZoqxnnlZuYq8B
 Wmgqg5ezHwbjg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 15:22:15 +0100
Message-Id: <DMTASPUDKG3F.1H8JUZ5C0A2M3@kernel.org>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Dave Airlie" <airlied@redhat.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 1/2] rust: time: expose as_nanos for clock sources.
References: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
 <179448764517.621816.16006004780926601543.b4-ty@b4>
 <DMT91N7BGPUU.17BEZWQDLH3CC@kernel.org>
 <87tslmupje.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87tslmupje.fsf@t14s.mail-host-address-is-not-set>
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

On Thu Nov 12, 2026 at 2:50 PM CET, Andreas Hindborg wrote:
> "Danilo Krummrich" <dakr@kernel.org> writes:
>
>> On Thu Nov 12, 2026 at 1:47 PM CET, Andreas Hindborg wrote:
>>>
>>> On Wed, 11 Nov 2026 15:23:24 +1000, Dave Airlie wrote:
>>>> The nouveau C driver does ktime_to_ns(ktime_get()) to program
>>>> the cpu ns into some hw/fw, so allow this method for rust drivers.
>>>>=20
>>>> This is needed for following nova patch.
>>>
>>> Applied, thanks!
>>
>> Do you mind if we take this through the DRM tree? Otherwise the subseque=
nt patch
>> in this series has to wait for a cycle.
>
> No it is fine, I can drop it from my tree. I asked on v6 what you
> wanted, either way is fine :)

Great, thanks!

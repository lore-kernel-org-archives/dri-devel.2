Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B722606A883
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCGrJu3C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3308E11210E;
	Thu, 12 Nov 2026 13:00:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0484B11210E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:59:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A32063A4A;
 Thu, 12 Nov 2026 12:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0F31F00A07;
 Thu, 12 Nov 2026 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794488396;
 bh=jIVSLZ+nV6QTFe7lcxPhx/3voVvLmU+R5xaxWupgc5c=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=GCGrJu3Cg6CS/4RuhyjRMrEKlR0CWNPkj3Bv6XTpEErjPhp/Ab8FrBsvjA6E50TBJ
 /jLf23vc578olnUx7ETqvKYObDiXQVsrhCjWz4OqEDHDMOIgC//0LyAv9AzCW8O+Hj
 QLjwS0vu3o5H3yfQAZb46M5mHSyXuthR5K096IEy9T+LxYh204I4P6ZcVoOyNmKxAz
 3I2QESz4erP9UF6RUar6Tu6QRIr5B6MNq3jaJoOI8nNCG8bc4mj1sIaySMchRGtDNy
 8XTO3k5q2OyNC8vwmPOFp3GFufhKS+d7lGUbWH+041cTQWbleQpdBfcWG9ZS9RrCy9
 bI6O8oIRd6YMQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 13:59:53 +0100
Message-Id: <DMT91N7BGPUU.17BEZWQDLH3CC@kernel.org>
Subject: Re: [PATCH v7 1/2] rust: time: expose as_nanos for clock sources.
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Dave Airlie" <airlied@redhat.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
 <179448764517.621816.16006004780926601543.b4-ty@b4>
In-Reply-To: <179448764517.621816.16006004780926601543.b4-ty@b4>
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

On Thu Nov 12, 2026 at 1:47 PM CET, Andreas Hindborg wrote:
>
> On Wed, 11 Nov 2026 15:23:24 +1000, Dave Airlie wrote:
>> The nouveau C driver does ktime_to_ns(ktime_get()) to program
>> the cpu ns into some hw/fw, so allow this method for rust drivers.
>>=20
>> This is needed for following nova patch.
>
> Applied, thanks!

Do you mind if we take this through the DRM tree? Otherwise the subsequent =
patch
in this series has to wait for a cycle.

Thanks,
Danilo

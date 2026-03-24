Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EA3E9A779
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1972A10E5BF;
	Tue, 24 Mar 2026 12:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d1cJkGkO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E313F10E5BF;
 Tue, 24 Mar 2026 12:46:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 34DD86013E;
 Tue, 24 Mar 2026 12:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC4CC19424;
 Tue, 24 Mar 2026 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774356407;
 bh=dsxveakDjRYMQkye9OWRI3sTONphVUVna8ujrl9GArE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=d1cJkGkOpD3P10vow6H193rMwXx4pCGknvlcsUyKntyc3hs/Dl6cAmaqUqazKT8mS
 IcjVlKuVgutbV2SYEHS3ON5BlhJLbFK1ejAQ1WosoxDL26QL0j0mz7DNktyKw00AXD
 61lvhBj5bDAirroIg7FMAWGDBzyEZOWrw41fyi9C3H3Stkrby6J64GFLJjknK55jp5
 UOSXNVCz2JIKyK7LKDFkhTfVyAVc6YtnTGB4shSfmSdJYUokpq1XBmiAWzMxT5b0nV
 fKTA03FfPN3sEqu3iB8pjBKWtMCm/Yc+wRHfPpVrhe6R4E1jHNoRx3JWglVIx6TBQ3
 1CcacJaKLrAnw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com,
 driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] dma::Coherent & dma::CoherentInit API
In-Reply-To: <314ab89f-3aee-49f5-804b-f33dc8ef5ba4@kernel.org>
References: <9A1gWen63AbJmi06Y_vu_qF1S86nj3fcQEil9RzLAn8QkIYpCOrLMNO7JcgIP0BccPHhzaYaQ_te1S_gKuHRgg==@protonmail.internalid>
 <20260303162314.94363-1-dakr@kernel.org> <87cy0tqueu.fsf@kernel.org>
 <NNO45MYwzudmCWH1mWf1k0Icy8Q0eKR4ANI6fg9-zxq3_dHLfhyRsHaq2l77l-RBwmek7tHzQIv2vNhOFg1Ysw==@protonmail.internalid>
 <314ab89f-3aee-49f5-804b-f33dc8ef5ba4@kernel.org>
Date: Tue, 24 Mar 2026 13:46:36 +0100
Message-ID: <87a4vxqtsj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

"Danilo Krummrich" <dakr@kernel.org> writes:

> On 3/24/26 1:33 PM, Andreas Hindborg wrote:
>> What did you base this on?
>
> drm-rust-next

I don't think 1195fcbda62f12108dc9be56fa4173897905b90c is in
drm-rust-next - or any of the other branches in of
https://gitlab.freedesktop.org/drm/rust/kernel.git .


Best regards,
Andreas Hindborg



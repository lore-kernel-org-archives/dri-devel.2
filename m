Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DB606A884
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAWINCEw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E1D10E5BB;
	Thu, 12 Nov 2026 12:49:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4D31120C1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:49:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCA086549D;
 Thu, 12 Nov 2026 12:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E041F00A11;
 Thu, 12 Nov 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794487741;
 bh=bbjvxGLiLRjOuG6IBi4zc6utgaw4kKNuTIsp1Xrqk6w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=GAWINCEwiJD8jcm5yD9Vrz/j0mBmmXq6zDjh9Bew2Bhq5Hn13ygGXHboKycvyI0zt
 L7FxNyhrqe3H3GIzQxQu4Q1jhvzjSaCalvgTv33JBkizmZ03GGlArIWXONnwa7ygF1
 n76fdEcysWtV8P+T6Ek4Vi0nuVvZBpFN5XB8uOGc0yEg2OQIfYYgTJ7LMWjmFI6xQK
 LiM3nRf/aw/vGj1uSk7ej8VhmTzX+786rpEBMShQN1/W2/bZaaDAZb6dsIa658bRwU
 cNqA1endGQgN+U2u1sx5xVoPLhzr8SxA2Ph0Iq0ICrJ3ejStTaS8wZgOaJZzFlwhEF
 V8hJRL0cQKGKQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Dave Airlie <airlied@redhat.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
References: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
Subject: Re: [PATCH v7 1/2] rust: time: expose as_nanos for clock sources.
Message-Id: <179448764517.621816.16006004780926601543.b4-ty@b4>
Date: Thu, 12 Nov 2026 13:47:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 11 Nov 2026 15:23:24 +1000, Dave Airlie wrote:
> The nouveau C driver does ktime_to_ns(ktime_get()) to program
> the cpu ns into some hw/fw, so allow this method for rust drivers.
> 
> This is needed for following nova patch.

Applied, thanks!

[1/2] rust: time: expose as_nanos for clock sources.
      commit: b6437dcd8958440fdbf05a957d8fdfb7e44a0b5c

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



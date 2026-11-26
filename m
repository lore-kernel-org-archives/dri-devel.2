Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C4606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k10GsYKJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A9311246F;
	Thu, 26 Nov 2026 14:18:47 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C21B11246F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795702717;
 bh=JucLJO8s2LUWmGGq3P+iCmFjYmGKjZAtIrVZIaSBnss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k10GsYKJSVYB6hugOrnfDpmv9Yu2+0OIMjyq21AudIpCLH+1kiskEjCWkb5xzWgSJ
 WRKyMvQjNLp10aGYRSg+Wrbq0gzQi2PtBGTEVLnGm2Kb7cQCHYZlo8oX9TeRF/67on
 UbPuVBugdGzFIHlK/HhmXGkjcPFRmcZLuLI/n6uhtztxsnnboFhFBCULQwN8zLnvMJ
 ih0IwXLTnx95ht+vmu/vL+q9yZXHz9LO1o+0QNDkRTpX+BBSJWw9oxyYaY8jOrJhAS
 6WFQTZynSG6ewt+j8abyEDaUsr+e9Z+Ve0gyQy5adoIoP6UF/OIe+wIsoUWpAw3cc1
 XMYFGxYvAm7NQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 71BB217E04F7;
 Thu, 26 Nov 2026 15:18:36 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com,
	daniel.almeida@collabora.com
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, deborah.brouwer@collabora.com,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, kernel@collabora.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v7 3/3] drm/tyr: add Job IRQ handling
Date: Thu, 26 Nov 2026 15:18:30 +0100
Message-Id: <20261126141830.215638-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261126111145.117769-1-laura.nao@collabora.com>
References: <20261126111145.117769-1-laura.nao@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 12:11, Laura Nao wrote:
>
> Makes sense, thanks for the pointer. I this this also means 
> job_irq_init needs to return Result<impl PinInit<Self, Error> + 'a>
> instead of a fully constructed Result<Pin<KBox<TyrIrqRegistration<'a, JobIrq>>>>,
> right?
>
> With [0], Firmware is no longer wrapped in Arc. Iiuic, combined with the
> above, this will let us embed both the firmware and the job IRQ 
> registration as plain #[pin] fields in the same TyrDrmRegistrationData 
> struct. The job IRQ can then borrow a reference to the firmware's 
> JobIrqEvents directly within that same struct, instead of cloning it
> through Arc.
>
> If that's correct, I'll change both job_irq_init() and 
> TyrIrqRegistration::request() to return a 
> Result<impl PinInit<Self, Error> + 'a>.
>

..and here I meant job_irq_init should return 
Result<impl PinInit<TyrIrqRegistration<'a, JobIrq>, Error> + 'a> and
TyrRegistration::request() should return 
Result<impl PinInit<Self, Error> + 'a>. Sorry for the confusion.

Using a pin initializer seems the right direction regardless[1], so I'll
make the change.

Best,

Laura

[1] https://lore.kernel.org/all/DN545I66CKO1.2YKP99UIQQR43@kernel.org/

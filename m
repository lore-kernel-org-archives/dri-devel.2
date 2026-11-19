Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C58606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=v2aBK9/u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F8A10EFFA;
	Thu, 19 Nov 2026 07:27:15 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7319C10EFFA
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:27:08 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jVVQw4Vt0zKp42;
 Thu, 19 Nov 2026 08:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795073224; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHec+bcorVdFivY0AsqfT4qwBXwZIOqFaXBbhEon4Rk=;
 b=v2aBK9/uSUt79zZCB478wuJ7j8gMDI0lhc06QOm0ironoWz+tfGmwGfZRbxil4WGLiskbO
 SSyhHHqRxefOKRvNmUzKwJsccz/0Jy8MZo850+0WarJZNu2u7T9VOdYmS4EPuOeFX1/1xF
 +sCj0qdmwVJsXy4AruDvqgeVeOmBoBqjMP76J+EV6FeclGEFxzRSF4W1VMdqTjmo6Pq756
 2uOe9ALPOgg3AoqA/rCxb08uvT6JxgidOQBHqBP/bOJfHngzTm5FzggLHBkL3DvBai/Pqa
 00VpEiiWGBvBUAi/I0+AhpDv7CcVrOU2jDNfrS4gMX50rTg6Ck+b7f5GdDMSHg==
Message-ID: <7aa027e3ff479118c30828d77f7d348f611b7ea1.camel@mailbox.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: remove unnecessary firmware pin-init
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com, 
 aliceryhl@google.com, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, 	robin.murphy@arm.com, a.hindborg@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, 	gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
 tamird@kernel.org, work@onurozkan.dev
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
Date: Thu, 19 Nov 2026 08:27:00 +0100
In-Reply-To: <20261114234324.82387-2-dakr@kernel.org>
References: <20261114234324.82387-1-dakr@kernel.org>
 <20261114234324.82387-2-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 5aac85ed30d7b19f367
X-MBO-RS-META: 5nofx34a7of1nrrc8mapextogthzndoy
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 2026-11-15 at 00:42 +0100, Danilo Krummrich wrote:
> Now that SGTable no longer requires pinning, remove the pin-init
> machinery from Radix3 and GspFirmware.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

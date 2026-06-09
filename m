Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BC7CD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85D010E19D;
	Tue,  9 Jun 2026 08:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I2+G7M7O";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C95B10E19D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:43:45 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gZMrZ4qfYz9tyK;
 Tue,  9 Jun 2026 10:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780994622; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TutrcWV4weLV63rn6DOTmO8rnOaAiET3qj78ShPmQNU=;
 b=I2+G7M7O/nLScRZ49TGC3cmN5cfqPPb9zqKE76qw8auAsniWaqsyGncfeWPDO8CxwceK2n
 j7kRkmv9Ahxkk+odKi1D/c9V+0YvLZ8I+2GmNykowMd5B/1v7myJmQWaMebf7ugwNUXO0C
 Hywago82s9mMtYCVDD5RVhtaikIS93U8gDCPGYaYIA8FFMo2UpbeGBHx7kM+b2rWyeLifN
 pKFz4o4mmB4O4jrvFoA+cptN4QxlKVV21PscK+aqtAMGBERJUDDav9bh3Tt/Qo2uZQhiYU
 YV3nMRw1yvo2wi6tqueuuxh7mNkqbTA/ZsD2XGZZLmccvf4pMU9u5xklatzv7Q==
Message-ID: <739df49a9c0fc54e3d096f95f7d738081f6fcfc2.camel@mailbox.org>
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
From: Philipp Stanner <phasta@mailbox.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alice Ryhl <aliceryhl@google.com>, Daniel
 Almeida	 <dwlsalmeida@gmail.com>, Gary Guo <gary@garyguo.net>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 10:43:39 +0200
In-Reply-To: <20260608181630.20145d1c@fedora-2.home>
References: <20260608142436.265820-2-phasta@kernel.org>
 <20260608170112.24fd92df@fedora-2.home>
 <6bdbdb6541392c6ea58e0035f0b20ac3c8f3e54e.camel@mailbox.org>
 <DJ3RRRX6JY4M.LCRKJ074W9DQ@kernel.org>
 <256dc5ae3529e2548c4151af34a540476ac928c1.camel@mailbox.org>
 <20260608181630.20145d1c@fedora-2.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: i8k4fmo6ne3hna7bsdyiqc4xaumfwd19
X-MBO-RS-ID: 3aff6afd757c241ff74
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-08 at 18:16 +0200, Boris Brezillon wrote:
> If I were to choose, I'd probably go for a dedicated rwlock_t to

side note:
rw_locks are officially discouraged AFAIK. They utilize more of the
expensive instructions than a spinlock and are only worth it if the
read section is really long compared to the write section.

> protect dma_fence_ops, so we can:
>=20
> - protect all dma_buf_ops::xx() consistently no matter the kind of op
> - protect returned data (get_xxx_name()) with this lock instead of the
> =C2=A0 RCU read lock

That doesn't solve our Rust destructor problem though, does it?

What we want to do is:

   1. Signal the fence before it drops
   2. Wait for all accessors to be gone
   3. Run the destructor

Step #2 by definition demands the signaled-state lock.

Or would your plan be to take and release the ops-lock before the
destructor to ensure all callbacks are gone?

P.

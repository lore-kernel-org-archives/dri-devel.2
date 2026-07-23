Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DD0C531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD3110E583;
	Thu, 23 Jul 2026 11:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="StdM88VO";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A394F10E583
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:56:32 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h5V2h6GJWzKpmh;
 Thu, 23 Jul 2026 13:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784807788; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3/0YSZYQzDgQyuA6SQ6Ur7WoM1y3Eq+jlVzjnL0T7c=;
 b=StdM88VOL0qKMar551fpvZ4V8Ra4MhAyAJnN/U1PArk+62n3lTwyHwRSOL8Ir/L561oVss
 Qq7WBQHYut/4lTneTkg0IPPgW7Or5hKUZDZWgQqM45fHdSlQ6e1vXrrmTJ0sArXgtlEjDu
 RJRzTjpt4uflj+tAzuDTIRp2/QqDCyo7eMVo04X7grMdfr1AKQuXY/YNtTy64RL/rprZ6K
 AznFIIgCWu7PIzVtau7TxEVbpUgIMq6whmYSHbgzKMuo6bjWkm9ZSj20mGD7o2MMgI4qN+
 cCFPqAZp+KO28Mhxk73e9/Skz0+3qs2yXbzUrMrNwhkQXQGaa6CyZDrSXWf/Kg==
Message-ID: <73981717a8a609013eaca197a41a741c52bff44d.camel@mailbox.org>
Subject: Re: [PATCH v6 2/6] rust: error: Add ECANCELED error code
From: Philipp Stanner <phasta@mailbox.org>
To: Timur Tabi <ttabi@nvidia.com>, "qiang.zhang@linux.dev"	
 <qiang.zhang@linux.dev>, "josh@joshtriplett.org" <josh@joshtriplett.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>,
 "delcastillodelarosadaniel@gmail.com"	
 <delcastillodelarosadaniel@gmail.com>, "a.hindborg@kernel.org"	
 <a.hindborg@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Eliot
 Courtney <ecourtney@nvidia.com>, "adzicmirko97@gmail.com"
 <adzicmirko97@gmail.com>,  "alistair.francis@wdc.com"	
 <alistair.francis@wdc.com>, "ojeda@kernel.org" <ojeda@kernel.org>, 
 "sumit.semwal@linaro.org"	 <sumit.semwal@linaro.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, 
 "yury.norov@gmail.com"	 <yury.norov@gmail.com>, "tmgross@umich.edu"
 <tmgross@umich.edu>,  "frederic@kernel.org"	 <frederic@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>, 
 "daniel.almeida@collabora.com"	 <daniel.almeida@collabora.com>,
 "boqun@kernel.org" <boqun@kernel.org>,  "lossin@kernel.org"	
 <lossin@kernel.org>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
 "neeraj.upadhyay@kernel.org"	 <neeraj.upadhyay@kernel.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>,  "phasta@kernel.org"	
 <phasta@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
 "dakr@kernel.org"	 <dakr@kernel.org>, "tamird@kernel.org"
 <tamird@kernel.org>,  "gregkh@linuxfoundation.org"	
 <gregkh@linuxfoundation.org>, "lyude@redhat.com" <lyude@redhat.com>, 
 "lina+kernel@asahilina.net"	 <lina+kernel@asahilina.net>, "ljs@kernel.org"
 <ljs@kernel.org>,  "mathieu.desnoyers@efficios.com"	
 <mathieu.desnoyers@efficios.com>, "work@onurozkan.dev"
 <work@onurozkan.dev>,  "urezki@gmail.com"	 <urezki@gmail.com>,
 "gary@garyguo.net" <gary@garyguo.net>,  "jiangshanlai@gmail.com"	
 <jiangshanlai@gmail.com>, "fujita.tomonori@gmail.com"	
 <fujita.tomonori@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-media@vger.kernel.org"	 <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org"	 <linaro-mm-sig@lists.linaro.org>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org"	 <rust-for-linux@vger.kernel.org>
Date: Thu, 23 Jul 2026 13:56:15 +0200
In-Reply-To: <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com>
References: <20260722144931.1070312-2-phasta@kernel.org>
 <20260722144931.1070312-4-phasta@kernel.org>
 <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 1wph3j35gedcc8zuwpiwyyaxym5kdm86
X-MBO-RS-ID: a53eb3e66d41100d98c
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

On Wed, 2026-07-22 at 18:38 +0000, Timur Tabi wrote:
> On Wed, 2026-07-22 at 16:49 +0200, Philipp Stanner wrote:
> > The Rust dma_fence abstractions need the ECANCELED error code.
> >=20
> > Add ECANCELED error code.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> No need for this, all remaining codes are being added via
>=20
> https://lore.kernel.org/rust-for-linux/20260629183022.2709524-1-ttabi@nvi=
dia.com/
>=20
> Please pick up that patch instead.

Ok, pulled it in my local branch for now, thx for the heads-up.

I see that your patch is from June. If it lands in drm-rust-next
soonish I'd simply rebase.


Regards
P.

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94850606D823
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qd0I7Vod
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0487A10E24F;
	Thu,  5 Nov 2026 13:24:19 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB2810E14B;
 Thu,  5 Nov 2026 13:24:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jL31M2Q9yzKp4M;
 Thu, 05 Nov 2026 14:24:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793885047; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr7b357bQF9gcmhhu+T4xYlpo1IDNyxkNJbpgvGxS7k=;
 b=qd0I7VodEh/YGmDacD0GpRjBefhw/+7TY4fYCETDCELlDau43W4Iv1ZAtJX5YQM/vD7F/t
 Io2f6fgGc/1F5ghEf/MwbMRYSvhnO23qAWB8qco1mS8wiPuKLqck7hVRtAjv9KvLCpRwsN
 5BDGlkKRIyCWuqV/u+BODFeuOQ9d5alieCuk/+Y6suKKqh7/GA3zAEMoUY4UorCuzThBnx
 RAoCZP1x6JKpPOjnRBqcV4hJHO2lbA1oGvP5u59rPEgEaDAqhk/4utGymk+LRznEokAtCo
 zHJ1rjx+Yg28UFnUB1y5TF6dTQ9YwzaheqekvhLUbhZMsDBU6ghGaQzycEEhCw==
Message-ID: <2fa6e631e133acfc7e7de1b287c8b3983168b1c6.camel@mailbox.org>
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-usb@vger.kernel.org
Date: Thu, 05 Nov 2026 14:24:04 +0100
In-Reply-To: <b8179edb-bc59-49af-b8d0-f62e39752f3a@ursulin.net>
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-3-phasta@kernel.org>
 <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
 <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
 <b8179edb-bc59-49af-b8d0-f62e39752f3a@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: bba065728d0df46fffa
X-MBO-RS-META: 6r63pcufosrhwuio4jrkztwnqgi8ttuw
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 12:51 +0000, Tvrtko Ursulin wrote:
> On 05/11/2026 12:35, Christian K=C3=B6nig wrote:
> > Well one advantage of the Linux kernel is to avoid such wrappers. I
> > think having more than one function for the same thing basically
> > just adds more confusion.
>=20
> Sure we can churn if we really want. But as 99% of callers will be=20
> passing 0 it's not even very readable. Another option is variadic like=
=20
> kmalloc_objs so flags can be optional. Anyway, for consideration only.


It has the advantage of forcing the reader to think about whether he
wants 64-bit sequence numbers or not. In Rust-fence, for example, we
completely overlooked that for months:

https://lore.kernel.org/rust-for-linux/20261023175750.2979015-2-phasta@kern=
el.org/


Besides unused flags fields are quite common in APIs. As I state in the
description, this is also for future extensions, see my race-flag (if
accepted) as one potential example.

It could also be used for canonically setting the user-flags, which
users currently do with a manual set_bit(NR, &fence.base.flags;

So I think it's safe to say that it's the right thing for long-term
reduction of churn and maintainability.


P.

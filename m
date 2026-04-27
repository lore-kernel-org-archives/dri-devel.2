Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9238FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D366410E5C7;
	Mon, 27 Apr 2026 07:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fu5eqJ+b";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7471010E5C7
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:34:07 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-488cc31ea57so76336195e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777275246; x=1777880046;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=oG3t3J+0nLXnFLxmSYOt/+viYtGDD3nFENttdAE4Lak=;
 b=fu5eqJ+bC5HvkEmLZd9HFjlGw8AFSM4BMI+NcvIOcl+RhIoY751ZNPFjxNAzPKj0bc
 57mLiuirloKB2nnZ60iiHFK99fFeL/cuL9olEDtbNG8rmmTCcqZ5pqrDZiWqOJMBWChe
 0uGBSYCZUw5KVFeP+GaF1ElUFPZPToJ3mH6rD0HUi8i54nQq3Q8b+r2+/kO1sci2s6Ic
 GJqrLf7Fjfk12tDVzj3s8EQMUEXjhtQzFDXWGv8TGULbe43SjdX8g5Cwd9ZzxPeibT8H
 SbU7vS7yRVV4ER1oj5CXBp+8BEV7dbL9eVgqtp1tDglLnzH/tYOYE0zg3116rkwIw1vJ
 Vqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275246; x=1777880046;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oG3t3J+0nLXnFLxmSYOt/+viYtGDD3nFENttdAE4Lak=;
 b=SZDSl8YuAVVicQKo7QCfm6f/GE4ov+E9kIXrlf3eYKVowC8X6Lpl1fwF9cO5dntOoP
 W8bZKuuzZWAQ2bW+ZscS4s5b32Cjwin2XodnM/2gBN/5SGCWhAdUbGi1nCRNqnGRrPwa
 cD8LRxKooshWg3NeR1MtWwiEcahjzLMKtT9UGBxP/5iDpKSilIlBdB6NbeyyjFwG2kyU
 ezGYf4oelGK+1NKgy7o6va5JKpJCBB+TvGNoos8qLzVtkcLEbz5Z3BMIDQCVBFAhJAW5
 azSb809fIBVXhoG2YSwJ9yVJJFOnMrqcCV5iAWEdu16zap6D+JrAOaXK5nFMhsEW4n0G
 ZS5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tFTbUhPXKbBTpq3XjlZIkcQZrBQzlWOlAFyPS2gf60a2aVx53oFRfdfRiAlJRG/HUSIARsk5mmsk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzbyt4H+6mnvpjrcGPh/NdY7mkRl7wX5OyexWYU0j1TlgIMe7Bu
 Z05lyhOzSxpm4fIGEA6vlMMQwFTURB7/Y5T/IP7zOA5s/icYZQm8Se6psPLL9725x6d1WuYrg4v
 HUq0HHLgrQaiFwBtSgw==
X-Received: from wmhf5.prod.google.com ([2002:a7b:cc05:0:b0:48a:7385:f096])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a52f2a5f0mr394264665e9.18.1777275245704; 
 Mon, 27 Apr 2026 00:34:05 -0700 (PDT)
Date: Mon, 27 Apr 2026 07:34:04 +0000
In-Reply-To: <c9ce94ae6c7956d63ca51f6e979100ec713f68f2.camel@linux.intel.com>
Mime-Version: 1.0
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
 <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
 <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
 <215f305ff04ddf8a426871e895aaf520b02e89bf.camel@linux.intel.com>
 <DHY2RPB300R2.1XXG87NPYFRCI@kernel.org>
 <c9ce94ae6c7956d63ca51f6e979100ec713f68f2.camel@linux.intel.com>
Message-ID: <ae8RbMocX2KBivpE@google.com>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
From: Alice Ryhl <aliceryhl@google.com>
To: "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 20, 2026 at 06:19:02PM +0200, Thomas Hellstr=C3=B6m wrote:
> On Mon, 2026-04-20 at 17:08 +0200, Danilo Krummrich wrote:
> > On Mon Apr 20, 2026 at 11:28 AM CEST, Thomas Hellstr=C3=B6m wrote:
> > > I agree with your reasoning here, but current fact is that most (if
> > > not
> > > all) holders of a drm device reference (files, pagemaps, dma-bufs)
> > > currently also hold a module reference to protect against this, and
> > > drm_gpuvm would be an outlier.
> >=20
> > I'm not convinced; if the DRM device has the requirement to not
> > outlive the
> > module it is associated with, then the DRM device code has to take
> > care of this
> > requirement, and not every caller of drm_dev_get().
> >=20
> > Besides that, if GPUVM holds the module reference count on behalf of
> > the DRM
> > device, it has the same effect that you rightfully point out below --
> > it breaks
> > rmmod.
> >=20
> > > To fix this properly (lifting that requirement) one could introduce
> > > a
> > > drm device count in the module and have the module exit function
> > > wait
> > > for it to become zero, *and* that the code that did the last
> > > decrement
> > > finished executing.
> > >=20
> > > https://patchwork.freedesktop.org/patch/712146/?series=3D163298&rev=
=3D1
> >=20
> > This looks like a reasonable fix to me. And it makes me conclude that
> > we
> > basically agree on everything. :)
>=20
> Yes, unless we'd want to do a similar wait for gpuvms before returning
> from the close() callback: If we assume all GPUVMs are tied to an open
> drm file, that would conceptually be nicer IMO but I agree if gpuvm
> drivers implement something like the above per-driver device count,
> that would be unnecessary.

Just to confirm, it sounds like no changes to my patch are required
here?

Alice

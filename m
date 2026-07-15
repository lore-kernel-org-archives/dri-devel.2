Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00A8C4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 05:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA1410E09E;
	Wed, 15 Jul 2026 05:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mjz5lDPp";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877BA10E09E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:31:15 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h0Psr36tkz8v3n;
 Wed, 15 Jul 2026 07:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784093472; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfNgUst2tVMXAMgZqbisK74hu/zl7ZHiGzY9UbJrcy0=;
 b=mjz5lDPp2VvSHaRwymizi2mqdESCAX0FOrr8TZs0eh5eQZT+ARc0RF7S3H5oYLcgvO1Jgs
 xa1u0mhvxp0WQ8BQz/btCGhvKxcISHxcXz6puU5nXZV5I+ygN8eI1ARF2BdWv3qFv+ei24
 EqctzvMcOmc9/IDa1FEmwpGuw1O/dL29aeu7uOxoD/kNUJfRteJZn8KmRwhJUAMRflIMo5
 af479gTRT4FvyI3nZ8ioMdkiwnDL46JCSNRPQl0qVbVtIcBl+Ni4af9OcEyXqUYQsnCzWc
 3l9NhYOaOX2S0T+b+3pXtZvtWkJIwTIwUdV72A+xtbAb7d2L1kkRaX0oF8kJaA==
Message-ID: <f3ab1427536e005b2acdc7da84f0f91f8a304602.camel@mailbox.org>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
From: Philipp Stanner <phasta@mailbox.org>
To: Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org, Boris Brezillon
 <boris.brezillon@collabora.com>,  Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,  Danilo
 Krummrich	 <dakr@kernel.org>, kernel-dev@igalia.com
Date: Wed, 15 Jul 2026 07:31:07 +0200
In-Reply-To: <alE6Anbf5nSYszVT@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
 <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
 <akwD28ihbzn1FB-P@slm.duckdns.org>
 <fe9c5564-9a56-429d-a991-9b77f8a97d5b@igalia.com>
 <19f0c3fe-7395-492f-b016-7a7a507da4f6@igalia.com>
 <250bfc53-e91b-4c48-9401-bbe636d3400b@igalia.com>
 <alEZlhfTZ1tD3hMo@slm.duckdns.org>
 <alE6Anbf5nSYszVT@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 8e4ca4640ff637c83aa
X-MBO-RS-META: 7z1ai4h1ytbnoypi1ffbdpzxn64gan5u
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

On Fri, 2026-07-10 at 11:29 -0700, Matthew Brost wrote:
> On Fri, Jul 10, 2026 at 06:11:02AM -1000, Tejun Heo wrote:
> > On Fri, Jul 10, 2026 at 01:29:19PM +0100, Tvrtko Ursulin wrote:
> > > So the question is whether something like this is acceptable to workq=
ueue
> > > core? If so, I can send it as a proper RFC and go from there.
> >=20
> > Yes, that looks like enough data. Let's add RT support.
> >=20
>=20
> +1 - This solves a bunch of our DRM internal debate around what to do
> here.

ACK.

Thanks for jumping in, Tejun. Very helpful!


P.

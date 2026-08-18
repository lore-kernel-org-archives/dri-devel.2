Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DFAC5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B881C10E053;
	Tue, 18 Aug 2026 13:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BPwkbCNL";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719C810E053
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:48:54 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hPWJM4TP4zKnRY;
 Tue, 18 Aug 2026 15:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1787060931; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnCWKIEbXnzvERwfK57jvlqaRf+FfEFLIfp/6YtNPbc=;
 b=BPwkbCNLIRSHMz8a++I5W/oFHKAzHQo2XlZbuIXvTF/MpufdGACpfczf5uR0x991kUDogu
 Myzy3mGafM/reD5OIbqoPPQEtfxdhh9RxHQlboAszqL4J95N79pv9UE5XcKHJxWPKac+aS
 TiHy+j2lZ5Yz9d+9dFC4NQhFgdo5YlWMGr2mhuV32jud9hwWkPLdezODVV8ZlHWYfpwPzF
 B5C2WWq96Rdx1TAyNGj7h0tYszEVrzBaWybTcocdoMqNcAjVXqEUTU5WLwRG3Q3IwGD71q
 f2RikpnNY9nYIF3+5moIJeApXt9yxL4ThOT5/1T6iYjBDXD3rGvkdjzlu1pA3Q==
Message-ID: <c65a016801f3151a042f46366c99bbce5597fc91.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Lock drm_sched_entity_is_idle()
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 15:48:46 +0200
In-Reply-To: <2dd34398-3ef2-4573-8311-60e5f6b346aa@ursulin.net>
References: <20260813094539.2407911-2-phasta@kernel.org>
 <2dd34398-3ef2-4573-8311-60e5f6b346aa@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 02b1ec67361eff4ea6a
X-MBO-RS-META: 9se6gi9dodrtjawr1k5b5kosz8jwnyt7
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

On Thu, 2026-08-13 at 11:37 +0100, Tvrtko Ursulin wrote:
>=20
> On 13/08/2026 10:45, Philipp Stanner wrote:
> > drm_sched_entity_is_idle() contains a badly documented memory barrier
> > and an invalid lockless access to entity->stopped. Moreover, it also
> > accesses entity->list which is at all other places protected by
> > entity->lock.
> >=20
> > This function is in no way performance critical, so it is safer, more
> > readable and more maintainable to take the spinlock.
> >=20
> > Add locking to drm_sched_entity_is_idle().
> >=20
>=20

[=E2=80=A6]

> Spotted by chance on the mailing list but I believe I gave you r-b for=
=20
> this one already.

Applied to misc-next with your r-b.

Thx

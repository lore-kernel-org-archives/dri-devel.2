Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8543DC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BF110FA9A;
	Fri,  4 Sep 2026 10:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y/LpR9Cr";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB27010FA9A
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:51:54 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbtZH59vkz8tyG;
 Fri, 04 Sep 2026 12:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788519111; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rF1iIKdnD1arpqoiak4GAiMJte83ZTCC7sRmA66w/tY=;
 b=Y/LpR9CrtAx7PqoKF75627q5BCiO97S/1Sh06ZLgNceEPJPM6KSvbffv9rKSbExDDP118D
 YttwY9FqCjI1jPJZbiBsOyA1vrcyc9BCEZ1oVPG3Q4V3QJvMhTgokFnzphbWNp+eS8nnqM
 oRXVVAJv0h60cwDz6C7OyOM1sHR6ru5wJJJxst7WeU7OTQADxNpEQjGG7UD5kwdJeegW50
 otGZvwTODFuT52Kq/SHYm4N+fZI5CqA9kZgZrb//wpaXy444i2P5fx/nuHtjEl9qTgszIG
 muMwtBuk1LK1wS1u7GsOfmt9BNa/rgvKE0vraEvXCYWnUQHOJS0jKymL4qAa1w==
Message-ID: <3958ef460d25cd7bc2a72729c8bfd8ade4dc0b79.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, "Jonghyuk Kim(MalHyuk)"
 <malhyuk97@gmail.com>
Cc: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net, 
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, mdaenzer@redhat.com,
 alessio.belle@imgtec.com, 	luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Date: Fri, 04 Sep 2026 12:51:47 +0200
In-Reply-To: <DL6FYL70FVCX.10MCZIPFSVJ5G@kernel.org>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <DL6FYL70FVCX.10MCZIPFSVJ5G@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: i5bernthh4t84ra48qtbsp7gwf9h4u8t
X-MBO-RS-ID: 60fe534f6ce160e7ad4
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

On Fri, 2026-09-04 at 11:57 +0200, Danilo Krummrich wrote:
> On Fri Sep 4, 2026 at 10:06 AM CEST, Jonghyuk Kim(MalHyuk) wrote:
> > Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document t=
he rules")
> > Cc: stable@vger.kernel.org=C2=A0# we don't know since when
>=20
> How is that?

That is referring to the fact that it only is a reachable bug if the
respective driver exposes a mechanism that runs into
get_timeline_name().

>=20
> More in general, putting "we don't know since when" for the stable folks =
is
> rough. If neither the author of the patch nor the maintainers of the subs=
ystem
> can figure it out, how are the stable folks supposed to?

That's on me, it was a joking phrase by me that Jonghyuk or his LLM
picked up 1:1.

Anyways. So would you suggest backporting a fix as far as possible to
the amd origin commit? That might not be backportable that far, so
stable would still have to figure it out.


P.

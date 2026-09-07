Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA509C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED37610E4A6;
	Mon,  7 Sep 2026 13:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="awq3sdmG";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE6110E4A6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:38:54 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hdp7b1WKhz8spW;
 Mon, 07 Sep 2026 15:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788788331; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEke2EPs1nd9N9Nxynh/mJMqpAdvs9NuQ3mp5kWf9VE=;
 b=awq3sdmGdjFFqitT1UNk0BqAkA+qyYbZbf+Z8qOSG+02uqNin7wCy1iX7rIox2uPTiDHBW
 z9Kd87A6zfshdOdlfvQSIYQehqxImBRY4BYmtiGvfNpPe0n75i2kROIYNYUNSpbUulBLku
 z49T8v1G/phTGJWX1WFSTYBfxPrgyDKlOMBlCqUQi7CvwW9JbYqV49dspnd5c3LxDWVi+f
 g1Po48j9W4F+PssuMZIQIsSd8+NNLEOBKPQ+sWyNXItU8BOsgEPwMALYdSZSFr3pK6huI/
 MBDtNxHEVIebcAsn6hW2TKC0uyGxdW6v/iM1kmdgoA9mzgUTGrhSzosCSrDiFA==
Message-ID: <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>, "Jonghyuk
 Kim(MalHyuk)" <malhyuk97@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Date: Mon, 07 Sep 2026 15:38:46 +0200
In-Reply-To: <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
 <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
 <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: ipg9bp9sjkftrx9pyqqjiyefy5qzrbq1
X-MBO-RS-ID: fc4c7d91b475e08ac8a
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

On Mon, 2026-09-07 at 14:59 +0200, Christian K=C3=B6nig wrote:
> I think the memory ordering isn't really a problem.
>=20
> See if the ops pointer or the signaled bit is loaded first doesn't
> matter if you check both.
>=20
> You only need to make sure that the ops pointer is loaded once cause
> that one is used multiple times, but that is already the case by
> using rcu_dereference().

That.. sounds correct.

Although I still don't get why we then can't use the signaled state
everywhere instead of the ops pointer. That would be simpler.


Anyways.
Maybe Jonghyuk can give your patch a test run and then we could use it
as a hot-fix to backport and discuss the wider future of dma-fence
separately?


P.

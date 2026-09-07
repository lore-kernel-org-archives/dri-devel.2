Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C1C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D550210E7BF;
	Mon,  7 Sep 2026 11:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="solvOZpZ";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B4310E7B6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:54:42 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hdlqL6lsJzMlDL;
 Mon, 07 Sep 2026 13:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1788782078; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53KcBrkFsMMtIwM6/KsvB28KUfU9olumCJ+Q/BCCcQA=;
 b=solvOZpZHFXg1d68wbpZP7//okzTnJWvlqlgBhGxtweZj74ZCEFsCJkwrztegEvQhQtq0F
 A7ahXptFgwWkXPzSRv3g4O7UXhK5mL+RGZ5f4bQiK5xgKHGFX+Mh3FIKZ32tA1YF4kVtxZ
 0wFp69IFMtPedBmCej58qCncct2z0oCTDb+SF+RvFkmI5bSw4Q3aLzZt3QlU5FHB0dcQAa
 o20KQgHdJ2LtMnAhn9TwWvPdy2Cp9sF6rCUYoAgx9PZjqEaXjFrit4tf5+lulv0TZ/JxdN
 Y7Geq6Y24kK8rTbxkY6ltNYAt5Qe8UQtcI4TI+kEpX0wN8iUnFd76j/5GjeuiA==
Message-ID: <0ac0d9192cf234911e28341cee48bdeb789b4577.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, 
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Date: Mon, 07 Sep 2026 13:54:33 +0200
In-Reply-To: <05bd9329-1982-44bb-9d8e-bc2f8b345cb6@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <05bd9329-1982-44bb-9d8e-bc2f8b345cb6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: dc6fa35c1beff9ad349
X-MBO-RS-META: afk96yxhqhquifxxbhpifjc9tipfgfet
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

On Mon, 2026-09-07 at 13:42 +0200, Christian K=C3=B6nig wrote:
> Well no, before patch "035219a760ed dma-buf: dma-fence: Fix potential
> NULL pointer dereference" everything worked correctly as long as the
> driver waited for an RCU grace period before tearing down the
> scheduler.

035219a760ed literally fixed a race condition for weakly ordered
platforms, so I wouldn't say that "everything worked correctly" :)

>=20

[=E2=80=A6]

> >=20
> >=20
> > Correct me if I'm wrong, but it seems we have not found an alternative
> > solution that can work yet?
>=20
> I think we did. The problem was introduced with patch 035219a760ed
> and I think we should fix it there as well.
>=20
> We just need to start checking for both the ops and signaled status
> in the dma_fence framework.

Agreed, we should address the problem there.

But see my other answer to Tvrtko. I think if the decoupling point is
the signaled bit anyways, we can and should stop setting ops to NULL in
the first place.

Because now we'd have two decoupling points.


> > > >=20
> >=20
> > I hope that wasn't me because that again looks very racy.
>=20
> Why? Tvrtko added the RCU protection for that.

RCU does not address ordering between signaled bit and ops pointer.

> > I think that there is no way around using the spinlock. As I have
> > pointed out many times, the fact that the signaled-bit is set with lock
> > protection and read without it is fundamentally broken :(
>=20
> As far as I can see the RCU approach works just fine, the problem is
> only that we dropped the check for the signaled bit from the common
> framework and didn't considered that scheduler fence and a few other
> weren't changed to not have a release callback yet.
>=20
> > > > IOW, we keep the solution presented here (removing ops->release for
> > > > finished-fence) and the few drivers that check whether a fence is
> > > > their
> > > > own first do a locked dma_fence_is_signaled() check?
> > >=20
> > > Works for me as well, but as I said I would rather like to keep it
> > > simple and stupid for backporting.
> >=20
> > If you can think of a stupid and simple solution, shoot. The only thing
> > I can think of is moving the string into the dma_fence, as a hard copy
> > :)
>=20
> See attached. It doesn't fully solve the problem, but it gives us the
> status again we had after Tvrtko's RCU protection work.
>=20

Patch 0001 seems to reintroduce the race condition. No one guarantees
that the CPU will load the signaled flag before the ops.

P.

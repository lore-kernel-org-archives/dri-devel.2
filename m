Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C7AC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4D510E00E;
	Tue, 14 Jul 2026 08:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PY+5wKmO";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F0910E00E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:43:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gzt9h32YhzKnkS;
 Tue, 14 Jul 2026 10:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784018584; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcuVd28/B1/gjyhzwuyoKO1FA4PSc1ZXawv4lavDk0g=;
 b=PY+5wKmO7NrZO97V1BWq6hfWTjLqFxemVZr19+pe70WS5T+1In+T2C7IclYuwamarw/j1s
 Hc20Cc5FjVIYg/c4lOAaeOzC8vWqJB+XMhQ/5MSnLQ97JFvr7As8avAjFxXl/9FZh6OtVE
 EYN2Gn1BxvoATXFO2wCmnoMDRUlR21YJC61KxjncigYzO6QpwNt5/38Cax7miMPJ5KweqA
 BHm+jzx1yze0iYmrYsczrL5GQX3XXjqxu3FX43+ALoXw20k9IeNeQd2rHgx+/XH1Buf5uK
 ZJr9/Tgmaflc586NX8blEXAlkxqkCOZP2s2BgnVHEVaNArD6N9/hXCbpuN0W2Q==
Message-ID: <9edeaa17aebc284f1f171b1dd4d9ffee4721b750.camel@mailbox.org>
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
From: Philipp Stanner <phasta@mailbox.org>
To: phasta@kernel.org, Jiri Slaby <jirislaby@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Tue, 14 Jul 2026 10:43:00 +0200
In-Reply-To: <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
 <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
 <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 51ec5f551e682329c92
X-MBO-RS-META: xy77jqgsk5tqheuk9x6qp7fhyrm8obhg
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

On Tue, 2026-07-14 at 09:53 +0200, Philipp Stanner wrote:
> On Mon, 2026-07-13 at 10:58 +0200, Jiri Slaby wrote:
> > Hi,
> >=20
> > On 20. 01. 26, 11:54, Christian K=C3=B6nig wrote:
> > > Some driver use fence->ops to test if a fence was initialized or not.
> > > The problem is that this utilizes internal behavior of the dma_fence
> > > implementation.
> > >=20
> > > So better abstract that into a function.
> > >=20
> > > v2: use a flag instead of testing fence->ops, rename the function, mo=
ve
> > > =C2=A0=C2=A0=C2=A0=C2=A0 to the beginning of the patch set.
> > ...
> > > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > > @@ -146,7 +146,7 @@ qxl_release_free(struct qxl_device *qdev,
> > > =C2=A0=C2=A0	idr_remove(&qdev->release_idr, release->id);
> > > =C2=A0=C2=A0	spin_unlock(&qdev->release_idr_lock);
> > > =C2=A0=20
> > > -	if (release->base.ops) {
> > > +	if (dma_fence_was_initialized(&release->base)) {
>=20
> Could you verify the cause with sth like
>=20
> if (release->base.ops && dma_fence_was_initialized(=E2=80=A6)) {

Forget about that, probably would not work or cause other issues
because the NULL-setting on signal().

I'd then probably try to verify it with a separate boolean in struct
release. Though I also don't get why the fence-initialized check does
not do the trick.


P.

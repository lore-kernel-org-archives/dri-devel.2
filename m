Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09229C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5725310E91E;
	Fri, 25 Sep 2026 08:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jzhL2YVu";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B94A910E91E
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:42:06 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hrkhq5Kd5zMlN2;
 Fri, 25 Sep 2026 10:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790325723; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRvOW5NrkIUrw9dWfkyAdujFBwy7oebVmERVFMWai8Y=;
 b=jzhL2YVuv3ff2aE5LMGqBShNaDSCXIjidBG3CC124ceWlQZjbfOxQpIScjA50TNl3dqdVY
 0b3Axa6oJwQ3KRSpeBzN30pqPEqMDvJDbainpz/6fUDS/FKz3Ouf+NslWP5vacyPJ1e3rB
 pUvYgomNYXd2DXp0CJ26SVHPk269eSCAtOhqfBb8PH7E8Q3opP2NgWjtQhCc1Z+K+koXYX
 xgJ9JmRX8HkpXTxQZwwlpvx1EW4L9Kvenop9L1AVDDN7NrBrgSmlYZiHjkLj6hV9bgk4D5
 M0gi/cvf2jxsSlZB14XuCGpWMO2PiYgrgTJ5BzEzkijkhxdpFf698Ql2jUs8eg==
Message-ID: <7b8942e29f6c714979415a59b42af450afa101e4.camel@mailbox.org>
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 10:42:01 +0200
In-Reply-To: <c7d9c659-d903-456f-87f2-d75aafb8de3b@amd.com>
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
 <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
 <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
 <a4655e4ab7a2477b75351a0e83b98e0cb0396fdb.camel@mailbox.org>
 <c7d9c659-d903-456f-87f2-d75aafb8de3b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 7c07fbf7874eee8c257
X-MBO-RS-META: ysrckashgmocyszoea99kqe6zsniwgxt
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

On Fri, 2026-09-25 at 10:21 +0200, Christian K=C3=B6nig wrote:
> Some problems like the locking design are still WIP, but we are
> slowly moving towards that.

The question will be whether we can reach common ground with that one.

>=20
> But some problems like parts of the dma_fence uAPI are unfixable
> without time travel.

I would be especially interested in learning about who the party is
that apparently is spinning on dma_fence_is_signaled(), supposedly
preventing us from getting the memory ordering right.

Also learning more about the users that definitely *need* ops-
>signaled() and ops->enable_signaling() would be interesting. drm_sched
users cannot make use of these, since the sched-fence does not pass the
request through to the hardware fence.

So who are the users? Parties like Nouveau implement these callbacks,
but it's not clear whether they actually need them.

(btw, funnily enough, with the Rust-fence design we finally have the
ability to fully support all callbacks with or without a scheduler,
since the need for an intermediate fence disappeared)


P.

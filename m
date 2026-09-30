Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11D2CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFCE10F350;
	Wed, 30 Sep 2026 12:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vXsUjpoj";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDBE10F350;
 Wed, 30 Sep 2026 12:11:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hvv5s2Yk8zKpFn;
 Wed, 30 Sep 2026 14:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1790770273; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUwDlRmHKu8BGZIdcy7UY5pSixItBiiOcySxCneV2X4=;
 b=vXsUjpojZ9jisyVPi3rjrTeljjYXyvKWogRx5ZXfv5sDqKhLS22ZX16w3C//fqBbkeMRJt
 ulSQOKYZhNAvoYRbhbGCi/OtcJdekvoNRqHkd+ezHSGCcqTE/Zf67PEhrc0TX/HnRcrBDd
 bkNkJODrdzRMNUJGLgdAB2xeNGKxIG8D5Hn2Wbw/XGUwOAklSspoWc3ZVYaNNWWMJuv+Tl
 lhZGG8lgSgCaMk7ZQ13vXWLrsCt8XySa/m4tdkWU8Y2DeHr82kjF6HGW6T9zW/cXut6Uvf
 1qdtqgQIcwFrm+IMBlhiF2TSJXIg4kd9D4TZMWurIXDc44sECJZ5w3antKlNnA==
Message-ID: <83f162922f8be47f373c49ffca2b7ab68a6d99c7.camel@mailbox.org>
Subject: Re: [RFC] drm/sched: Replace completion with a flush
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Date: Wed, 30 Sep 2026 14:11:09 +0200
In-Reply-To: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-META: 71nh3jquhsj8t4sm75jfqgbnywm9jmni
X-MBO-RS-ID: 85c95b8f9c6c710f182
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

On Thu, 2026-06-11 at 13:34 +0100, Tvrtko Ursulin wrote:
> Due the scheduler locking design, and the inability to always lock both
> the entity and the run-queue in the consistent order, a completion exists
> which effectively marks the entity as in use from a call path which is no=
t
> able to lock it.
>=20
> When entity is selected from the run job worker, its completion is marked
> as non-idle all until the code is sure it will not be dereferencing it an=
y
> more, at which point it signals it as idle, releasing the potential
> parallel cleanup path.
>=20
> We can remove the need for this completion by implementing the identical
> guarantee by simply flushing the run job work from the cleanup path, afte=
r
> having removed the entity from the run queue.
>=20
> We then know that the entity is no longer reachable by the run queue
> selection logic, so as soon as any pending work is done the cleanup can
> safely proceed. And because we have marked the entity as stopped, we also
> know that the entity cannot re-enter the run queue.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I think Christian and I agree that this patch is cool. It fell through
the cracks in summer and would now need a rebase.


If you're still up to it, I'd say go for v1


Greetings,
Philipp

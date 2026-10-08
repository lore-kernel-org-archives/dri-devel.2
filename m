Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FB5CA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3F910E6DD;
	Thu,  8 Oct 2026 10:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jjKgvlti";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B958E10E6DD
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 10:19:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j0mDj0PW8zMlG3;
 Thu, 08 Oct 2026 12:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1791454741; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7irScfbRf2bXjKUhGEludzZp7D8UWNmY9IRXFNnawMs=;
 b=jjKgvltiUxCGP45bIPBE9mFFVUZAVN6b9W+v4rWlu03aEk3Uh5vnOLi5do5r0ECVHNgNX/
 HhvvgHLRuO7JtViaVTCucG4cSs4mqncavOEgCTNYml1nJzJbpzg6gYJaWmkzlVqcLR0VOI
 FUJyOlXlEB7UIhxo7sje6+lPwqvw7Mzi9YNET3TCnft3AZQjtZtOuiDqRdBXaTGS1IK3KE
 fGO+CJ9P1t8bBxU1ZAhGk5YYn3XL3oQlnlUUZBAMR3i8Xav+fcQLdeRQl3DBZbPdwI/Z3B
 s8iey9vYe/xNsYv6MlYqNoUyDtFzXtTGbSpKgbitGIwHBmtD+zFNolwpuMLP5w==
Message-ID: <154fd1c6273812a804799cb82d11655c1726a83e.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Fix out of bounds entity priority check
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 stable@vger.kernel.org
Date: Thu, 08 Oct 2026 12:18:24 +0200
In-Reply-To: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
References: <20261002124622.74696-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-META: swrufom8hw8fqtbejd8dh1e7i3t6q575
X-MBO-RS-ID: a03e0b1a6e3e0911d2d
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

On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
> When the out of range priority at entity init time is clamped to the
> number of run queues in the supplied scheduler the internal run-queue
> priority needs to be adjusted as well.
>=20
> There is no impact since none of the drivers hit the clamping path, but
> we still need to address it by moving the entity->rq_priority assignment
> to after the clamping is done.
>=20
> Note that a lot of this will hopefully get removed once again when the
> single run-queue simplification lands.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")

Help me out here; we recently landed this fix [1] that Luke reported.
Is there a relation? I guess not, since you say there is "no impact".

This did not exist before CFS in drm_sched, did it? Did you discover it
by review?


P.


[1] https://lore.kernel.org/dri-devel/20260915150557.62847-1-tvrtko.ursulin=
@igalia.com/

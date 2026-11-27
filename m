Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D5606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=Gr1hLz/7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D3610E38B;
	Sat, 28 Nov 2026 09:41:01 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5C310E045;
 Fri, 27 Nov 2026 11:29:41 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id A436220DC832;
 Fri, 27 Nov 2026 12:29:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 80F8D20F06F3;
 Fri, 27 Nov 2026 12:29:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 80F8D20F06F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795778979;
 bh=ORsmi8rn4wC5wIc9Ndp8PeBaNOlh/oiUbZBQYpF8ip8=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Gr1hLz/7rH7+l2dRR/Wwg4uT/bEX4UeHCoDfmgRUImB974+y4NYYHQrk/oZGePW3z
 1NHLL/wIorroCZcNFtluwaTEw1WMog9HqGWX3FPhadImk3HI8pISMxQlt+v8b+1Fs5
 wpFHvd1A60CSu8YB+Jd6hJ6vZtzx3UwrWHZOGGYAnFtfxxJ7Fatf/1nzDbIeyigfqk
 KExGAtVIJeAalKAMMJF2cNYTHqzb4+hCp1x5ISwc9Z2le7vjYQOR4VKRCj9Muxrzta
 BChL+GnEeVV5PQbu/zF35SvjGj6c4W9SJAF4qsQjclFr6rqorQyox71wHPxHqR9u6s
 8cOVm05w+/O7Q==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id jdae3Ts8Fw6Y; Fri, 27 Nov 2026 12:29:39 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id 368E020DC832;
 Fri, 27 Nov 2026 12:29:39 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] drm/nouveau/fifo/gf100-: reset the faulting engine even
 if it switched channels
Date: Fri, 27 Nov 2026 12:29:26 +0100
Message-ID: <20261127112927.981649-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-235999@kernel.org>
References: <sashiko-outbox-235999@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 18:11:26 +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Can setting engn->rc_reset before nvkm_runl_rc_cgrp() leave a stale
> rc_reset flag armed when cgrp->rc has already left NVKM_CGRP_RC_NONE?

Yes. A second fault for a group that is already in recovery sets the
flag, nvkm_runl_rc_cgrp() schedules nothing, and the flag waits for the
next recovery on that runlist, which then resets the engine on behalf of
a group it is not recovering. A duplicate fault entry for one fault is
the likely way to get there (fault buffer on gv100+); on Fermi I only
ever saw one fault per channel kill.

> Conversely, if a second engine in the same channel group faults after
> nvkm_runl_rc() has already passed the engine reset loop for the first
> fault, [...] leaving the second engine stalled.

That case is not recovered without the patch either: the group is
already in recovery, so nothing is scheduled. The patch does not make it
worse, but it does not fix it.

> And if an unrelated channel group cgrpB faults on engn while
> nvkm_runl_rc() is already past the cgrp loop [...] the in-progress pass
> will consume engn->rc_reset and reset engn before cgrpB's channels have
> been disabled and removed from the runlist.

Right, the flag is not tied to the pass that recovers the group.

v2 keeps the faulting engines in the channel group (a mask, rc_engm)
instead of a per-engine flag. The recovery pass collects the mask of
each group it moves from PENDING to RUNNING, after the cmpxchg, and only
resets those engines (plus, as before, engines whose context belongs to
a group in recovery). So:

- a fault for a group already in recovery only adds to that group's
  mask, which no later pass reads, as the group never returns to
  PENDING;
- a pass in progress cannot pick up the mask of a group it did not take
  into recovery; that group's own pass gets it after removing its
  channels.

The mask is written before nvkm_runl_rc_cgrp() (atomic_or, then the
cmpxchg NONE -> PENDING), and read after the PENDING -> RUNNING cmpxchg,
so a pass that takes the group always sees the engines that faulted
before it.

v2 has been through the same tests as v1 on a Quadro 600 (GF108),
with no failure (numbers in its changelog); I am sending it now.

Analysis done with the help of Claude (AI assistant).

Fr=C3=A9d=C3=A9ric Mah=C3=A9

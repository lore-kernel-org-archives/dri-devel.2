Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D289606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mw0BPJoH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F93C10E9C6;
	Tue, 10 Nov 2026 15:47:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BF310E9C6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:47:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25B5C63105;
 Tue, 10 Nov 2026 15:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99131F0089F;
 Tue, 10 Nov 2026 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794325648;
 bh=ERCEmzjry5FIWOkj+DY0CDazXUeTnj95dRUhGioqzNY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Mw0BPJoHoTuh80RrmIFoA3tGKMzhj2Ac0ceuexozRUoVGQTdQl2olXdVo/xVEmL5I
 HBkyopcPcOOlDhFDHZhf53Qfz2CzF8tBcbOQ0O1mXbMMHZMF7/ZedaVZwRSuigGJff
 2F6hpYucCilVAt7h+vLNcWNHbMDmRJiHBYPnk/xrFrZxJ0Y1eiC2GEWctIxoww/yOQ
 hm4CvcND7Z6akWAM0QRpup4nDa3Fwia4DRFKP9BK0tLfKuFn64FqHvJmnCgsks2rb0
 TG1hXsl9YKXDub+3FB47FbhWg0GT1pt6MxSybA55dXF6lkMGOTTQSqltsQafrvnL+x
 6dXz5WBjlJsVQ==
Message-ID: <sashiko-outbox-207296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/28] drm/panthor: Rename neural accelerator feature
 macro to NX
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-3-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:47:28 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/panthor: commit message does not explain why GPU_FEATURES_NX
  is renamed
--

commit b271181b3f70a8fceddc935ef5d82c1ab9eb1aa8
Author: Karunika Choo <karunika.choo@arm.com>

> drm/panthor: Rename neural accelerator feature macro to NX
>
> Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
> Update the panthor_hw helper to use the new name.
>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

[Severity: Low]
This isn't a bug, but the commit message only restates the code change
without explaining why GPU_FEATURES_NEURAL_ENGINE is renamed to
GPU_FEATURES_NX while panthor_hw_has_neural() and the PWR_NEURAL_*
definitions keep the neural naming.  Could the commit message explain the
rationale for the new name (for example, matching the hardware register
specification)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D2

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E725606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=thelittleman.net header.i=@thelittleman.net header.a=rsa-sha256 header.s=20140415-thelittleman header.b=cABqwdBx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D4C10E87B;
	Wed,  4 Nov 2026 08:58:22 +0000 (UTC)
Received: from mail.thelittleman.net (mail.thelittleman.net [91.99.148.243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28EB10E02F;
 Tue,  3 Nov 2026 22:02:00 +0000 (UTC)
Received: from mail.thelittleman.net (localhost [127.0.0.1])
 by mail.thelittleman.net (Postfix) with ESMTPSA id B7EB75F491;
 Tue, 03 Nov 2026 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thelittleman.net;
 s=20140415-thelittleman; t=1793743318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+ljwUcRqPa1I8PKwk28jT3BsaQMof3yBXjCBJacyK0=;
 b=cABqwdBxjs1lavtCsxwE2XmJSpQSX2LyLMLILD+JTQ3S71NcJYV5h9VHXfPoTlnjHNqOQ+
 gEL914uu7mTRig4MKDpVEMd4kuZj1a1rrkvH0dSmkw5D+U/eTLsW4JfHHY30DdsWjvC1pg
 jEscpYzHOTYxJxmXRIuzDMCJ+BuzohQ=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 16:01:58 -0600
From: "David R. Hedges" <linuxdev844@thelittleman.net>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 2/5] drm/nouveau/kms/nv50-: don't enable a DP output with
 no trained link
In-Reply-To: <sashiko-outbox-195991@kernel.org>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
 <20261103-nouveau-dp-relink-v1-2-7ee88c7f1e8a@thelittleman.net>
 <sashiko-outbox-195991@kernel.org>
Message-ID: <9c007e977c249af5064bf34a37694e76@thelittleman.net>
X-Sender: linuxdev844@thelittleman.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03 14:27 -0600, sashiko-bot@kernel.org wrote:
> When nv50_sor_atomic_enable() returns early here on -EINVAL, does this 
> still
> end up enabling DP audio on the untrained and detached SOR?

[...]

Yeah, nv50_disp_atomic_commit_tail() marks the output enabled whatever
nv50_sor_atomic_enable() did, and nv50_disp_atomic_commit_core() then
enables audio on it.  In v2, I'll have nouveau_dp_train() clear dp.lt.nr
before it starts, so an output left detached has no trained link, and
nv50_audio_enable() skips a DP output without one.

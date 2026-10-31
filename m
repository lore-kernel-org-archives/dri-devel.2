Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1325606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=WTvjPV5J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9353B10EA19;
	Sun,  1 Nov 2026 12:01:40 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE07A10E10C
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 18:34:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jH68B0Cmcz8v2f;
 Sat, 31 Oct 2026 19:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793471690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mr9ICfX9GZSmJoYtnOLDM1PJyuX2i4qLwBDyTMhSy+I=;
 b=WTvjPV5JDGDKXsIs6PsfNRdz2Lw7LYuQVwwN+AAX5W7Tqs3dldtz2krSiwHeQNqAk9VY7t
 sAQr3f/+b9ULnexgX3nMl6cRauJMWgUmwUHiWGwgusyZviagNin8vFlL5tNQyMcAR3L2/L
 2VeP3KNh+7tCpmutB8idLss2bkOkgzB/o/CdteGYPgex8G5thUV9TqHNeml1haAwbD2xWe
 qw4PDiBmKnb751+qyfSk7xEoeYu9LVd+s4IQOJRkI1n9EXkG6CJqP5bfwD9x4EeiuGLuQ4
 4ZRn0wNk62hrAYsoHnim6eR1VJIlSD5knZNXDyr18eoRYXijIQob3Tu7Eg3d/Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Hold the VRR vblank reference only on
 active CRTCs
Date: Sat, 31 Oct 2026 18:34:48 +0000
Message-ID: <20261031183448.2400535-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-192001@kernel.org>
References: <sashiko-outbox-192001@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jH68B0Cmcz8v2f
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Should the dc_lock block and dc_exit_ips_for_hw_access() in that branch
> be skipped when new_state->stream is NULL?

Thanks. I can't test this, since my laptop is DCN 2.1 and has no IPS.
Reading the code, though, I agree: with this patch, disabling a CRTC that
has VRR on goes through the VRR-off branch, and that branch calls
dc_exit_ips_for_hw_access(). When it was the last display, that undoes
the IPS allow that amdgpu_dm_commit_streams() made just before.

v2 will skip the PSR, Replay and IPS step when the CRTC has no stream,
with a KUnit test that counts the IPS calls. I'll wait a few days for
other comments before sending it. A Tested-by from anyone with DCN 3.5
hardware would be welcome.

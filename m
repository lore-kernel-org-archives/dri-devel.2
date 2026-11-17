Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8B606A333
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Hm7dKjsv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C0110EB63;
	Tue, 17 Nov 2026 11:53:33 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1B610EB63;
 Tue, 17 Nov 2026 11:53:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jTNR81TLDzMlJf;
 Tue, 17 Nov 2026 12:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794916404; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQb7cXwFIQUpCfRWO5RTs2eWZcFbGVs5mUChgFbC5WI=;
 b=Hm7dKjsvmgldV5cI2i/C3Y5Zj3ADWxCWa1uYOtwCCUxO2/fLqkASHsc0NBde8OZUgklDiy
 TLF6U/lw96uKmdHtSDSqafXKPcpT2Gtpcrd30goSNMJJCdS9oPNTCUEdWcFsmgA8fJUO6s
 L7O7mO2vlhhtFwCOgIinn+mT44qzVHp3vp3y6w4oGVxrqYgegnu9qNJDd6TDSUSM+3IcmS
 WHV+lNpBwgV+GejlCe8CD2SR1Ykl2Uv+7xfqcYrbPBX69s3YOyr7blF/aocq4PVQkbL13X
 g5kGJaaVH6LMrOY8Dx/I59OxQ7+B65OAAdZg+OhyZTriqSUnH/NKUeLOf+hhKw==
Message-ID: <fd86312b062767e3434573064aeb267721c7a4f6.camel@mailbox.org>
Subject: Re: [PATCH 2/4] drm/sched: Ignore stopped entity attempt to change
 its run-queue
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>
Date: Tue, 17 Nov 2026 12:53:21 +0100
In-Reply-To: <20261117100654.8593-3-tvrtko.ursulin@igalia.com>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 3ee580c3afd7906fd0b
X-MBO-RS-META: sxchmtzhb5oecewteezncoi8cywgw5ac
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-17 at 10:06 +0000, Tvrtko Ursulin wrote:
> Jobs submitted to a stopped entity do not go anywhere due how they are
> handled in drm_sched_rq_add_entity() so there is no point to allow them
> to change their run-queue.

Who stops an entity?
Who submits to a stopped entity?
Isn't entity_select_rq only called for drm_sched_job_arm()?
Who's arming jobs for an entity that he has stopped himself?

P.

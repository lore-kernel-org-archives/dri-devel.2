Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3D606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YnV4thnu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A0810E862;
	Wed,  4 Nov 2026 08:18:39 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0EB10E862;
 Wed,  4 Nov 2026 08:18:32 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKJH968FszMm4v;
 Wed, 04 Nov 2026 09:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793780309; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7dDBAzV3mcLjs6XCIA+U1la/+cXsiOiJ/OxebKRP7k=;
 b=YnV4thnuEW3PAFCubKZxrgnv2WVq6Snr17C6oCPkZylvXsSeHgDonb8QhccRHYrbqohzzq
 xvstCn4AkHff7cfVZonKCpNz7+aOSHNimGs0XzWwZqePhOV+LthR9AiqcVuejKG6OS7SN4
 oC/eqGnniokUpgTDVeVNhPUGVE0ZNOHRm/EUToZrOY0vv6LfOl8kNcAPWNB7X/1Ma2y7ke
 MqYXMwisCl1bjq+S0JlpVB+um1aCmvIr+5Ke5yzc8l63+W/rfIRBMK28ui+3ayNm5PcU6N
 9rzeT/X96jb8PkxvGAxJE1c2C9GItxdtNCPaFLYO6Iz4ZkWFKFm1/K5D+qZIWQ==
Message-ID: <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>,
 stable@vger.kernel.org
Date: Wed, 04 Nov 2026 09:18:25 +0100
In-Reply-To: <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 9mcgfcds44eaidqu4m9i6i84qznefcqg
X-MBO-RS-ID: 77aceeb30479762a143
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

On Tue, 2026-11-03 at 16:03 +0000, Tvrtko Ursulin wrote:
> I'd like to get the fixes in so I can mentally focus on the continuation=
=20
> of the bigger story. Not least that not fixing it causes sashiko to flag=
=20
> the bugs, either when touching the neighbouring code, or possibly even=
=20
> just the logical functionality.


Fine by me, no major objections :)

The only thing that makes me a bit uneasy is
drm_sched_entity_set_priority()'s semantic. I know it's only used by
amdgpu, but nevertheless the reader might be tempted to think it should
only change the priority of an entity within a runqueue.
Could you add some sort of code or doc comment hinting at there being a
TODO for the future rework? Good to have that in case any of us is
assigned to work on different projects in 2 months.


Greetings
P.

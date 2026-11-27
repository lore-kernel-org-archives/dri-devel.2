Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86349606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wC0EA7Xs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61B010E161;
	Fri, 27 Nov 2026 11:44:01 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1943E10E161;
 Fri, 27 Nov 2026 11:43:55 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jbWlS2mFhzKmSh;
 Fri, 27 Nov 2026 12:43:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795779831; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpO7QIZp9eDf2b/vorZ5cqU73l47qHouBGMtAMaWFeQ=;
 b=wC0EA7Xs45NGUfeZwEsTQxN90TKphYNgpa9X+iA6adC6YhWArhmjHvOjL1tHJCNHf3N1dq
 mBQ7Y9JZ/qEiRTEqGCY4tYt7E/Lq9aWXHwrdt5V6CIgo5UQo9kpqBlaQNJ/fUY7IDuiw2Z
 tVh+bXYHwqn6XjEZcuzVFylwxC7r6+jf/bq8FeIkA0h1ARzWjZC1UuTDI3LNpaESzjmdSG
 RuftL9dIsYLkXmHREOgPhwaJm436vjUkGHaHYIyV92WMQjIVB/lva90ZA/E4tVw/28wYlq
 uOa7Qi7A7rXpusCQk2fV5gmJpWleTLPFXKQRaFaVGThkYF9Q5MWeb7T2R1tXhw==
Message-ID: <b6b75395da594c4bf8deb1daaf857854565c66cd.camel@mailbox.org>
Subject: Re: [PATCH 0/3] dma-fence: Properly order timestamps
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Matthew Brost	 <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Tvrtko
 Ursulin	 <tvrtko.ursulin@igalia.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>,  Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,  Gustavo
 Padovan <gustavo.padovan@collabora.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Luben Tuikov	 <ltuikov89@gmail.com>, Shashank
 Sharma <shashank.sharma@amd.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Gary Guo <gary@garyguo.net>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 27 Nov 2026 12:43:44 +0100
In-Reply-To: <DN5YMFCMLL2E.3LMY2Z5ZQAYFG@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
 <DN5YMFCMLL2E.3LMY2Z5ZQAYFG@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 40531303c2cea4e117c
X-MBO-RS-META: i6e7srj96rpfrqs6kw1sdcq97sckomz4
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

On Fri, 2026-11-27 at 12:34 +0100, Danilo Krummrich wrote:
> On Thu Nov 26, 2026 at 6:20 PM CET, Philipp Stanner wrote:
> > I propose stuffing these hotfixes into the stable kernel / misc-fixes
> > while we move on on misc-next with a more proper solution. I'll post a
> > series for that soonish, too.
>=20
> What has changed that this now became an issue that needs a hotfix? Do we=
 have
> broken users?

We don't know. But we have no reports, no.

It's literally UB. Can explode any time, or after 5 years, or never.

>=20
> If so, it would be good link a report if there's one publicly available.
> Otherwise, I'd suggest to just go ahead with the proper solution you work=
 on.

What do you mean with that, like not backporting it?


P.

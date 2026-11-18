Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F231A606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=a3tA09/c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B14D10EC25;
	Wed, 18 Nov 2026 16:42:46 +0000 (UTC)
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D253910EC41
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795020157; x=1795279357;
 bh=3XbQoLah0egYlieD3txH87dLBAMTst4xSgrXteL2enY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=a3tA09/cEmrpCOCkgK63Fa2m8gKJhyxvMqjJ+GzaDrZ3RKHnY7slPpL5B3uesb5/5
 H8eKLVa2eoiYiXGaJB/o3012Kf1/ILA8Xu/2XKlRVZN7I/s1coKq+jW2AnGJOWKho+
 C0Rs4noid8QJ973/H/UhaH8itDseat19r1aiDOXwNPo72C+FyFtDgJYMBj52Aa6nGf
 IE8b0mco5JMzp/PNWuYvkwYOJIjQKS3hjjREIDg2g3Iq8J6sVp6pomzfCAt3SxScZ+
 yGdfgjSRCFXhlTQQegaTeCU3Q+iyIZ3vfpwY/kCrpiQvmIdYTgkNeVSAA/RSq01bRy
 k5lwPkaf0u3og==
Date: Wed, 18 Nov 2026 16:42:33 +0000
To: SimonIT <simonit.orig@gmail.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Richard Hughes <richard@hughsie.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, Wayne Lin <Wayne.Lin@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Message-ID: <vm6yu0KAGt5woNSG6qP1BmKpyJGnhkeDwUuP5NdWZBxvcTzCHOdt7HuIOtZkU-KAwugtki3FergswtjIzREiOpiwA1QshrwlfDhaHcT4D6I=@protonmail.com>
In-Reply-To: <3458ff8e-a82a-42ac-9d1a-59a6a27e32d0@gmail.com>
References: <20261103-superm1-amdgpu-ddc-v2-1-7bde6d004382@kernel.org>
 <20261115082042.1902826-1-Wayne.Lin@amd.com>
 <c6d79680-1fd2-4e71-9d00-616010b7727c@kernel.org>
 <QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=@protonmail.com>
 <5386db0f-e9b3-4c62-bb2b-392cca4d761a@kernel.org>
 <0TqebV7r6TwuSRlaon2zTcY7N7UqY3fhGl1WDQ7U9iw4c_dTzijuuXkEWxUWSCqk2U-Rx7j_vjaXfaKNu0ohsM7esirKVbIOeLrsiuYMsOc=@protonmail.com>
 <3458ff8e-a82a-42ac-9d1a-59a6a27e32d0@gmail.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 438c1a332c239218f9b5cd77bc764672c38ec577
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

To avoid a mix-up: the patch in my mail only fixes a unit test that
runs in a simulated kernel during development. It doesn't change how
the  driver talks to your monitor,so there's nothing in it for you to
test.

The fix for your problem is Mario's patch. He's about to fold my test
change into a v4, so it's best to wait for him to say which version to
test.

About breaking your installation, a kernel you build yourself is
normally installed next to your distribution's kernel, not over it. If
it doesn't work, you pick the old kernel in the boot menu and nothing
is lost.

Thanks,
Eren


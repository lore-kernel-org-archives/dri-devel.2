Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DC606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DM0OvQP4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFA010F25E;
	Tue, 20 Oct 2026 07:04:22 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C4F10F25E
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:04:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j83LN4hd5zMlhM;
 Tue, 20 Oct 2026 09:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792479852; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGHO0Oh1Rp8gcSmbv++9QDYR9aE1sJ5oXRRAH09V9KY=;
 b=DM0OvQP4GTfXcW1vfu50tNwsjH/l1xcwlD3CfsZQOsNsJKkPkZAOSGoeV2kzFaAYWGdHG5
 93WI2Zs8/ydIcT/UipgRcbr/OEYAetQ5fE9PwZcdJb7YpU9hw/6aIiBR7gHXYHWlmsCrb8
 Yv3DS1/985/m7ROGuIfNFWBJgYMzpZmyOFoLqPsGvP2E/RVhbjzLGeb8LP76a4rRR/M/Oo
 JRPRp+1StcU6DbQxqrye8mpVx2newQypfnfvtatDyBJhO3as1cFUX+gc86drDlIFR6J29b
 TNKDtEYSM1TuOsiQPD6sbB4zMX2nnVJe5pCb8Schp+5VGjacMh8GX6ZAN/MXSA==
Message-ID: <73fc12734386c9bebc9cf6d3cea4c5f8e125255e.camel@mailbox.org>
Subject: Re: [PATCH] drm: Don't BUG when a CRTC fence signals during a name
 lookup
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, redducc	
 <sushmit718@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 09:04:09 +0200
In-Reply-To: <4dabaef5-25ad-480d-96f6-5feb26a64e42@igalia.com>
References: <20261019161731.2341-1-sushmit718@gmail.com>
 <30a31088a0386d5f5d53e74632ea9a63566dccde.camel@mailbox.org>
 <4dabaef5-25ad-480d-96f6-5feb26a64e42@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: f3da3a41ddf652a8c5c
X-MBO-RS-META: eqppfy79ui5huuypzdaxqw3p84bssusw
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

On Tue, 2026-10-20 at 07:57 +0100, Tvrtko Ursulin wrote:
> Hm this looked familiar so I looked around. There was an earlier fix for=
=20
> the same from Andre with msg-id=20
> 20260721-linux-drm_crtc_fix2-v3-2-afa8c71506e6@linaro.org=C2=A0which seem=
s to=20
> have fallen through the cracks.

Oh, right. Good catch.

patch =E2=84=961 still misses an R-b.

Seems CRTC is one of the collectively maintained components. So one of
us has to push it.

I can do today, it synergies well with my new fence RFC.

Regards
P.

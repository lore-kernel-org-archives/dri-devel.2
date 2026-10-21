Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58795606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=c4uZ2YHj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C3610FDD1;
	Wed, 21 Oct 2026 12:22:13 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390A810FDD1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:22:07 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so573617a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1792585327; x=1793190127; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nm84xhZ5VD0N09VimNJbbjTrxWz/UGMFx4b8eXz8p5M=;
 b=c4uZ2YHjUfAenbmVZxsXFE2q9hQJLHzzsiVevdCUMC4cuA3Xb4YfMhl9to8ZNB3QkJ
 MxhDDOesEvmQn3CXvLljT6efwS3nAIRe5HbN/Vu6lwvU5TqmSaEiYDrYpknMGJ6GjKhC
 Hzj3z8OdZKg1l6+YWYLb8ghSQaYl95TIReZXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792585327; x=1793190127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nm84xhZ5VD0N09VimNJbbjTrxWz/UGMFx4b8eXz8p5M=;
 b=IzThKgG3H3Tx94HbCiLIMpfNpk2Q8SGsJvQCUkESf28GM1CuZoUHNWQ1/kcY4C/fVJ
 /YrXz50cvYo9gXCzLCszqkBljYnd8YtA0wafzgTe1/sBSz3tt35XxQoK5nZ2cGgpgY6U
 wJsJnaZNKPFb4P2vxg0idCQSBMH/7/HgAV9xNZBSKeS2dejyP/xchxUaernL4XMgdtp2
 acCM8zNNy6EzUujq2gf55GuH32PmAkn9PY1kSD/Jb7vv0Au8UJEH8EdGlVNSE7FtdTRi
 kqiAFrLAhG9NyDvS1CRzKYxvq41GLG9kKbXIjsrwvElTTdHdzMZek1zPWBQ1LGk43Y6b
 SJSQ==
X-Gm-Message-State: AFq9FYJPdc6QZ8/KxIyY4cltjpoQKrvC4BmciQNTNl/bN/ktNhLOTcGE
 mW40K8vWZwnwABSLI77YSJnh4N58GKLTq9ZxvdwJT2ZB0arqdev8axwUsZ233tycTsk=
X-Gm-Gg: AYBFou31QFUmjkvgIaQDSdVoed6zp/yik/N6bTncWZ9VsMuwUhS9Bd4dV7ZGk7zGhhB
 hRa0CHwhUSLRZsRArf5mNIE0k4vc7uTMTgPQiFmVqnlV41igwNq7ZFnGn6BGYXy0rEOM3sTiWoX
 HvdhylU7Tevc+yTBpi7X+r4fGSrLDGAdNhQq/cDv+HYu+JXPB/BT2qOA0tNLB/Uopa7TVzFqrMW
 m0gn8xF6fwUDoYJ6jnqA2tcplW93+s96eOrvRDF4K46EbRszJE/8cryhktkMCigfUnuai/NNqH0
 X0fpKUlgpLftxXb7iEP52Rtqr/oP4oLFaIcZA3S1qFcuKfrS57fMj1BVToUwE2ND5Dj6QS5+jOo
 0LCj7Fn3PyNwiPCsBV7+Qn3cYzV5XMynMZO0JabfzNabkdctBVgzeF/Pbn7Qu3Ttpt/spT4DOpI
 QVOvywrpb+mMvVmnZB310Rpv6Dn1qj5zGPJOpO3ejyE/PuKQ81wXWNbersnm8TDWFRzRHA7mmK2
 GvI6auyebxUmmgipAS4y/R23WtQJC5UYWZQGksrtNrv92zlBdKJu4CxxA==
X-Received: by 2002:a17:90b:4b0a:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3ad86f45340mr1541343a91.31.1792585326711; 
 Wed, 21 Oct 2026 05:22:06 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8021d29bsm4309317a91.4.2026.10.21.05.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:22:06 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: Re: [PATCH v2 8/8] drm/sched: Untangle the scheduler list mess
Date: Wed, 21 Oct 2026 21:21:49 +0900
Message-ID: <20261021122151.7384-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020154123.33631-9-tvrtko.ursulin@igalia.com>
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-9-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:41:23PM +0100, Tvrtko Ursulin wrote:
> Rocket only compile tested!

Tested on a ROCK 5B+ (RK3588) with rocket and panthor: MobileNet
inference with up to 6 concurrent clients, open/close stress and the
drm_sched KUnit tests all pass, with no warnings.

Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # rocket on RK3588

Thanks,
Sidong

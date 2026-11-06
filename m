Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF790606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fy763ARJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2749710E2FD;
	Fri,  6 Nov 2026 05:08:11 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F3810E197
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:08:04 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-5364d86f7f0so2473341cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941684; cv=none;
 d=google.com; s=arc-20260327;
 b=YajGUkwdnkJyMzyL5jU2QXzzH7vG1w/bMZ1niYbLFvnISkaUMHTzYUL7DGZPfyN2CG
 gzMbr6ckBxljO/luOf4hcCivwwdUuxO53KhJiLs6wXPZZuS9kWFkKGDtm5NuybRviNEG
 lCiLIjxHc/FzYpt2A4XVSaRPK1zeIKlSh/C/KOJjDOjg/Zt4HnHJQreLus9kU94+14Sq
 uR8L49N+KB2gsb/9XQxMteydEZSE504wy1SozSUEAjpL1X54Yl1+hNf1qU1lhEhjqykF
 R2QQ/qPMBdUDsYpxjJrYtTcp5Ov40LaOqKyetXE2vQd230niqlolSPGCfi7U8PureUGz
 KpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=huVl+IlIYSdVDEO2gdFrs3mcLTIebTCw/xfvvqFw3UI=;
 fh=5b2+1W3n6kvzwHlPIUCu+IJoUJf5PEBh7E2/Sx4GQus=;
 b=PEvbq7+oXf/rBtwIeXVcsjY8HKsdlqaeJkacZTp7jS0TrDKOJPkbqqDQZPW4U9KuZE
 /TTaDWIA5KHvIIG6alB//+9BvjyMwXrNE8hu9BH3p4/9hU70uqvemBfJaMWSZVK5hTT5
 MMnsMwguYbgLjITdaXYNqQxfyTsI2HnsQgtuyD+KTKPGPQGRBAjfOc+LPg0dAt9jN4ZO
 AUM4m4k8jUVRZtv9jpKxoEmC5OjukDTvrv0YZnvnT7/nxkYwG8UT8MvDjVn+4bg6BHxi
 Zt4dpXtxQxWi1nu4Ff6QVJi74k0H1/5uQmHZuIGdxvlmRNNkB9CQawOHlW5sZ+qYrWdf
 UgZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793941684; x=1794546484; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=huVl+IlIYSdVDEO2gdFrs3mcLTIebTCw/xfvvqFw3UI=;
 b=Fy763ARJpbLOLHMl9HpFCdXWCmexPCeSvdFcvqZYv49dk/4hjpsNCGOrnKeZvLvqQP
 fPxV7GaqVybRb6l/j0Id8nKK1ro2pOr4zl4CDI9FDrvztY58oJHikBgl4ERt2hGF43Bo
 eZ49vv1IbxnzejRS/1ZD8LmUbQpt50N7VUvAF26OP1IQNv/q1NhEPLLbGCJey5Pa590z
 v1MaTiU7QvXOIfPFDNinQBPHy4VtPCHuvqP569O3ZkztQ6R+fb7UWH1+1XCaY25OlSQB
 6Bs4tWQUZ4mZ4kXh9ih4BtDdntIHzj/hTZ/IWNRwZkgYlgCCKLF4buBwYXLaLPDiuZaj
 +Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793941684; x=1794546484;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=huVl+IlIYSdVDEO2gdFrs3mcLTIebTCw/xfvvqFw3UI=;
 b=XFiiTnD+LYHz2wXiOgj3meSBmGxxuNy6wUtPP35IkZjLylnQTYlccW0WeHaalGEnY4
 NPufxItVaKF0VJnN1X6YFwUr7j7DYP9d1ALHYCdaHtFE/Idi4CO8KilPu8MAED1yKAbO
 S5NQVhJ+vrf3ctGDMBYd8j9e415U8JFAEoDNIyWLUtFvqCLk2JXMQsaI6f4nFmXpjUAl
 UEGOjdXJyKr5ZZF/NY7VmqQJxbjbaeFIoSLuEHI7/8anzTDflCp1diTIA4cTbqb2SE6F
 u2B25v+UFkTQYZ5Ie5u6h4J1W0ph/yOAvfERbv5hqgMi+LrMp3qCZxQcruf8uReDw+74
 SK1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDX4grKZaMIZ2SQtiliXrvguQehVGgCrCya1mZL+04HN19hV/tNuPlGckzsA0I9IwLl/XgGB/bsXM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z83jsxnsXqztNIj0/pnDAfQktZXvm+Btr+qwzoDY7yF12MQn356
 xZKM4QH5+YPy+PioDan5F43/6TNqVkOl8eSrSLFPIu0fZgii5WL54ruAycTM7z14IBv7Djt/fHA
 itmvbN9yhxM9T0h+cAkOzh61xANip4vE=
X-Gm-Gg: AYBFou34rCo4qrfXSHyEsbO6Ng4AQauPSV2VczOStvYaV22YAXk9KuSL0G19qPx9ckH
 WSAXmNhDr6kCot6EKaNNMXGmyqeEFOTL+xopLtjLXw236416QlVROYPGM28fEeL4U9aJxX8JrFF
 hfczrGQYPuX2v5l48lg2J2UWB36ROSIP+G0NE7knoqMiN1Nx5eEYOP20YhqLkzoFLhOdSz6NN/F
 Z39YDBH8Qp1zF1zfe1bP5N4n7KrJvvZQBqYwOUmzqbOzpsh0/MmiTImeDZRcCghUDacaWzvDRcL
 IgpiuBitcb+M9JIx6ptG1Vjq7daHudAac+uHdMy7Jq6D571ud8889P/FZBvG+mn3IsNeWXCqvAi
 WR4pgfogi4o5ngQR9fVgKhmS/dXUjtfWm36VaX47OWAAwpz68a+K7WmLsAgC4xqGDiejYefz0cY
 LLFbAUHTh7s34DLnGMqwjdGw==
X-Received: by 2002:a05:622a:114b:b0:54d:6b3a:d22f with SMTP id
 d75a77b69052e-54e1309deb9mr23285741cf.22.1793941683728; Thu, 05 Nov 2026
 21:08:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <au06WTroGBQ/Gqbt@gsse-cloud1.jf.intel.com>
 <au09iOI78yeru3BK@gsse-cloud1.jf.intel.com>
In-Reply-To: <au09iOI78yeru3BK@gsse-cloud1.jf.intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Nov 2026 15:07:51 +1000
X-Gm-Features: AclHuK-Tzf2viDf_stMcddnJZaRm6-IN9felbic9bp3B876AGg3rzgiWvizNEeY
Message-ID: <CAPM=9twYRmFoaibBZQA2+-qRe=dTc8z9fC0WjgudM=HD+QzDGQ@mail.gmail.com>
Subject: Re: [PULL] drm-xe-fixes
To: Matthew Brost <matthew.brost@intel.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dim-tools@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

>
> I'm not sure why patches below bac6deafcd2b are in this PR?
>
> I did have to force-push drm-xe-fixes today, likewise had to force the
> PR generation as patches which were not Xe's complained about a missing
> SoB.
>
> Not sure what is going here. If you need to drop this PR, I can sync
> with my fellow Intel maintainers and try again after rc2. Again apologie.
>

Something is very messed up, you don't have v7.4-rc1 so it seems like
somebody rebased back too far and screwed up the tree history.

Please rebase onto Linus v7.4-rc1 tag

commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4 (tag: v7.4-rc1)

In your tree

commit 8f26dd9c8361a9428cad2ffa40bad672577be6c6
Author: Linus Torvalds <torvalds@linux-foundation.org>
Commit: Matthew Brost <matthew.brost@intel.com>

    Linux 7.4-rc1

Something went wrong in a rebase land, force pushing was probably not
the right answer.

Dave.

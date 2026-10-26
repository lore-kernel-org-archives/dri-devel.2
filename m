Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64426606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SjT+cLJ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFA210E119;
	Mon, 26 Oct 2026 08:50:00 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2D510E9B2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:49:53 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so15878395e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793004592; x=1793609392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rszKDmeyYp+Dq9ttmtnC0+XaYnbTJ3v9qyyrMyWHQC8=;
 b=SjT+cLJ5aZe49LFSRTXTViuV5dmnwjoAoGSUtWbln/UfslQ2VEY7Iaue+svGNtwyH9
 59FCTD06o1pC9r/RR1tYLjRS8HPpW2XoKB4ArI5fBVpLRbZ0Hc3I8VS5KsQbTGyLEANZ
 9X9eDK9CqG3HPp62qJ5cF5uJoua0zl0fMJxE7eSxNTkUkcqojilYM9NysxFQD5eRA2PB
 UMABUDxsfrcqB+qk/MRkPrZeAqx/vt39WpODe75atoX/xVyciAcioAPiqf0m8d2Xa3IZ
 FJbm05I/eElX+mfCrW1RKyVkdzmZD2s2Np+UOjBqo0zMYfnColmST+K5/aXtxmGQP/4o
 +3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004592; x=1793609392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rszKDmeyYp+Dq9ttmtnC0+XaYnbTJ3v9qyyrMyWHQC8=;
 b=SyhLgUNEYY4P6lS55qmE6BB8bLmUD1pszZrnJa8iMVqYoeSx6p3U+SbKYAeXtwkp3u
 41sgvx2ZEhmjV35gRUhyBJFfyCsCOkqMOJd10qg+tnbzw7hlaE/UBbkT9PvLkhMSkkUW
 GZhoIsnuQZhMvj/doYP4I43B4Yq0RX3sii8mdmylyPlXO8IeZV4ivJSr29zmPAApnzAA
 6nHpocN45uoEbWuJ0WM1GT4duIJ45tTnDyoXFrf2pQWELwCRY4HNXJCFZc5EzI/7v/1Z
 hH6dhudsJZJ5ZmwT5CtnKHjRfNMS+KlzInuxOCcF0o7oAOx8UZzkXW/iLRI0g7choMsv
 qjPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwmH7J2e//A81rL9g0Bdg2ZMafMTYyCfecd/AdCpi9g1CAJMZl3XgxlBX9/yjW+CFLgdHCOPU1Qxs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiOxWO5bupeDSNKS9NZr3Crf6MAab4m1mx8SqdOrAkR6rO4T1x
 ++2X82CSV6B+Zsg9+ThsuhR9wOA6jHRIfN0Chuw4XB9eYVpXuq+KYomv
X-Gm-Gg: AYBFou2QyWaO3f6cMa8R6ZknwqeITW6USj/9g5+ZFkFyza5JLLb2ZFKsBg1GlS+nqgM
 kbW/8eh3uic+2aaxkBJ1pR9XjQaKdNxlA8U9wjngyKWLVi+Nad03n5Dy4+6ZI+iAmBwxO6cGrMo
 Max74U+2e2L8qLhod9XhLMzVvLwQoB/aQZLIKC7m5d5iU26BSuoQRBQcqck4mBOJR3DmGF+XoDP
 sJmf6cN1y3GFegWRHQhqXsLQOURaS9kKH9awSeMUIIeQe3/EV5nHGKzl/nYzeKRIt+AD+JpsD3H
 L3BH+AkAsQs52zsfdxtXxO+/5gvwM2PPF87oIbS2Nsuc6yS83tP91CNXHH49lWfF4Bu3ZC8SVQP
 okeMaQHCcJoyQGqvXUce+wIOnw51zfFT85d2l2mjd4RyaPOEIRGysL+fxmM5H96QDpE6tEzGal7
 nW7/w0pr4xsLcwJY+UhHEgLvzc5XHPmh/2Jpx1AkwsiXk8GBRT+vDtNovyLSkhZkaXjM48rh11j
 6otg/Yc7R4pNuWcme3Zipp8OE+3/9BaNHBagb6I5BVsI+bWPrx4qvn+il1PNGkZyN69
X-Received: by 2002:a05:600c:1c06:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4a35ac407fdmr149623005e9.2.1793004592159; 
 Mon, 26 Oct 2026 01:49:52 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.244.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm179923445e9.2.2026.10.26.01.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 01:49:51 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/clk: don't ignore RAM clock programming
 errors in nvkm_pstate_prog
Date: Mon, 26 Oct 2026 09:49:49 +0100
Message-ID: <20261026084949.256678-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260727152821.128432-1-postadelmaga@gmail.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lyude,

Gentle ping on these two.  The v3 of the cursor series is in v7.3 now,
thanks for picking it up - but these two don't show up in mainline or in
drm-misc-next, so I suspect they got lost after your review.

Both still apply on current mainline (one line of offset).  On
drm-misc-next 2/2 needs the v3 series to be there first, since its
context comes from "drm/nouveau/clk: don't use the pstate cursor after
the loop" - so either after the next backmerge, or I can rebase and
resend, whichever is less work for you.

Thanks,
Francesco

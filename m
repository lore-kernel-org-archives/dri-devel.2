Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ECFC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087A810E161;
	Wed, 19 Aug 2026 16:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NuFHjOSu";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E202A10E161
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:36:01 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49987367394so451785e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787157360; x=1787762160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BPL7y9X630pUrfi7Xh2kd4FCG9qq2NeQSHvxsEBJ2nU=;
 b=NuFHjOSuF9Vk983FTYtz/jrvzw0r5NCcvrsR3579GkXeg0inmOaQ0GcKQfP7xtifp7
 4d4UsNZkLE77v0Hn2iuf1cSpVLipFMy4jy7GfjhpNLi6qOgSmBJZYdIB27NNYTJbsPMc
 lBVaZVuYzRmjt/5a/ZuqNB/B49EUuUwJEvyCUD8C+Ny1hOqXIar2LT41wwdSUwdumRZy
 WILy3sA4mUfaXhJhtRC14gQ7r6otWaVWspmmyFPw2jYQHSpoWiHlxZkKLVHM4IqlXk/p
 98lHJFUreDBvlFNkuqhUuGT4xnrHppyrMyaJJ/SkMAclp1kBk5kqECbfp8m83ZWH+hoS
 O4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157360; x=1787762160;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BPL7y9X630pUrfi7Xh2kd4FCG9qq2NeQSHvxsEBJ2nU=;
 b=AUtCmou2mY6J7TL52hn5z8jP2nX+1POk/bnBPRq+aeLQKjsP6pFA4pnjmp6Hm4EB1n
 HcIKBdhcOhMoBNmOhiF38Oraeiq5IMBTKlNidUbO5IPUP+p2uF7C71ZRUqw34FMJWcAQ
 HY5zOSPI1HSWwtK6S4cuLMasU/1MGuP4PhNLcHF6g950ie8odq8JqOhzQPWsW7ELsyxv
 IjVDB2jMfqpLpy8mpVYGF2mjY+fmaZgR4Toi8EU0jEN9ngWAgSqso5rlIwvTvhulUk4e
 ArxOdu66HJ0RtOQj5bm4D29goSuMbb7hHRhQoLceKkXEaZ6BUsnwNwAcZVtuWKOulomr
 QxoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9zaTF3w8pyIGonk/nsCnQPL1zNEfHRqK/rx1jPbzF1i6+gXkMSxNf1aUIuF01VBFM9RBZqv7ae7M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5JFc+ghs7q8CtLiBrCnGY+ZtdXp1ezxGmpf6B+5BcWks7LL39
 1zo6dOOUo+7t+5rGVvxRf3cAp7x62PaA4N6ZDDD5VLZENQ7saRkboP3E
X-Gm-Gg: AR+sD13i9vXS7Lx1n9H5RYxNSHXyg/fKN05ZDE9JP8fKzg6x5QYYcdjWQkp1pyvAZvS
 t9AMdinSrFXhsZlGyfVfNf/iCadtAaY97LP3hFgmCZErKZt08B/JYbZ0sPJg+pQ3pL0XV9nU7ed
 4/EHOc5XL+DBHNMO0dYuFemJtKhLKaAxyBRC1ir5Y+BTOXGyDVwOkWc5buEJjnrA72oGZGYSrnL
 uLpDbfD/o7Anh8uxbx3XTADpKSWZgeqptt4pxrzFSR02sXlPveGtvSYFcRIGA6LpJ4503Vp1YVv
 uEM9M89YAvuy8Gf6QSdKU35EeOJ12Z9S/+cyPUK9XHLW7b+0GWyKXKpwCpCI1Y8ScQNOo/7pjTe
 C1QbSG4TIJQiaFFJnuCiuPJ3F8vTiFS+xU25Jnp68X78oEtPXTUKdcsYk6WcLVZzqy8Tk+GumQE
 ptXYBDBeOny/ZLnZRoV+7ycHt3YrAzdc5xLi1VICtyDJzLxdWQ2FjbeICxTgvbrVGrVCAkWoWWm
 4UZP6Wk2DO6QY0rrp+N9OTqYM6b2x+0wx2NKgs4q92Lh4gPiwW6Um4SspHtreUm8sg8Ow==
X-Received: by 2002:a05:600c:81ca:b0:499:77de:78ba with SMTP id
 5b1f17b1804b1-499aa202aa1mr61812315e9.2.1787157360271; 
 Wed, 19 Aug 2026 09:36:00 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9296004062FC4B2781498E.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:4062:fc4b:2781:498e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd5fcsm78793365e9.14.2026.08.19.09.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:35:59 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Markus Elfring <markus.elfring@web.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
Date: Wed, 19 Aug 2026 18:35:33 +0200
Message-ID: <20260819163552.5847-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
References: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
 <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Triet,

Same run as on 1/2, with one round aimed specifically at this patch:
ten pairs of concurrent clients, so two rocket_file_priv instances with
their own scheduler entities live at the same time, submitting in
parallel. All pairs completed with bit-correct output, no lockdep or
atomic-sleep hits, and clean autosuspend afterwards.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, functional,
                                                 # incl. concurrent clients

Regards,
Igor

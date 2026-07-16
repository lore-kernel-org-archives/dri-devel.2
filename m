Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A554C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5C110E761;
	Thu, 16 Jul 2026 11:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RAK67tkS";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8A410E761
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:45:37 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h1B7K2xNPzMlG6;
 Thu, 16 Jul 2026 13:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784202333; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lHA1KIF3ZYfJgjJcHFiljPd/+p5UTTmoz7g08D3Lmo=;
 b=RAK67tkSHlU0B04BSrusTG8IXcVCZDhL94XVL9kim4khV3z2shM4hfQBIpX9M1rnJ7taJd
 bLmTp8MCEpJB8Y7NR3Mz9ONdc9EKlxgXEM+9t7FV0quqZsEz2ytUtMNu7RkMx4X1oK6aQI
 ovDpxncnfrgc/mQTmJ8vpNKIsR+2dRgMb4l5ZX/uLkssaOzHE0TMe+Ngo+TpHYJ7g4k4Nq
 ZIgb78BXCx/U2PVqQWnW776YkRTEgKWTCHFbLtedd87pittalYpJ+Fny9PVAxMfTYuXMdK
 2iEJHZM2+JuHOjmcZAFvsVCylY6NifnbFC22YYekQuV2TRwl8SINE1I47RFuAQ==
Message-ID: <a0d969408a5a55dfb6d0b3e65906fd7bbf3eee1c.camel@mailbox.org>
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, Tvrtko
 Ursulin <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich	 <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Marco Pagani <marco.pagani@linux.dev>, Boris Brezillon	
 <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Date: Thu, 16 Jul 2026 13:45:26 +0200
In-Reply-To: <9e6c5123-f8b2-4a06-9fb0-be84c39ddd77@igalia.com>
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
 <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
 <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
 <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
 <e9e12e30-80c1-4650-9d71-4107517bc956@igalia.com>
 <9e6c5123-f8b2-4a06-9fb0-be84c39ddd77@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: ab856407d7812df3992
X-MBO-RS-META: mxz4g73r3dcs4fncjxmyhzfaeoq5ytw6
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-07-07 at 10:21 +0100, Tvrtko Ursulin wrote:
> Therefore, for what I am concerned, it is okay to go ahead with this=20
> simplification.


It is not a "simplification", it is establishing of proper computer
science standards, which trumps -2% fps, lock cycles and
microbenchmarks in any case.


P.

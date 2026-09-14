Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C4CC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3811E10ED9E;
	Mon, 14 Sep 2026 11:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BUmaY14v";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC1E10ED9E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:48:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hk3MF2VgTzMlNS;
 Mon, 14 Sep 2026 13:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789386521; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyQGZwHw5haqEcdliPr3jUJtPGxgDDPJVLcrxxibLKI=;
 b=BUmaY14vGqvHklakfOVznqaLLpeDC4S5klzU3amm/Zg5B/Dho9QOD3ny9ZzjdBUuiVzEDw
 Ft8r5P3aNopIZSadl4Sf91DwQw/ISqkgKXtDlQzMciqnscyrU8LymddoL33isnCzcl04Jb
 +a4hxncL/RmppPk3huRSd5DHkjkBRPGN9MwsPQvHVdSFaJiG8ipnuxeYJAr8AlRhiB2TQq
 KBvHuKARHy0MXZnI3ls5sfrUPI7X89+jaF0erLupBuvKZQQaZk40kO24il3JGVu9mRvagk
 8W64/xmILO3pdBPQKGUsdLbE8oOKfEMZ3AputS27zHOU6J+Sx1+ihO+gQoPEng==
Message-ID: <26926372f9d375e1741b16abd2a910f3754a0410.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Increase drm_mock_sched_job_wait_finished
 timeout when CONFIG_HZ=100
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Gow <david@davidgow.net>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo
 Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner	 <phasta@kernel.org>, Pierre-Eric Pelloux-Prayer	
 <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 kunit-dev@googlegroups.com
Date: Mon, 14 Sep 2026 13:48:36 +0200
In-Reply-To: <f570ea7f-164c-4232-85d8-14604baca607@igalia.com>
References: <20260913084155.520015-2-david@davidgow.net>
 <b4f017cc-3dbf-416c-b456-0c19d2f0647a@igalia.com>
 <0ce1883f-7de3-4a16-82f0-c8950459163e@davidgow.net>
 <f570ea7f-164c-4232-85d8-14604baca607@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 0caeec876783032458d
X-MBO-RS-META: cpfqec6bmbydshw5zw9myphmmthryz7d
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

On Mon, 2026-09-14 at 12:21 +0100, Tvrtko Ursulin wrote:
> It's not a loss really to
> skip the scheduling quality tests on more platforms than strictly=20
> required so I'd say lets go with that.

Does that mean you agree with my idea of having two options for
building the tests, one for sanity and one for performance-ish things?


P.

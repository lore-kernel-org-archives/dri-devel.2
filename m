Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2E3C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35D810F23C;
	Wed,  2 Sep 2026 14:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fTAZCD7L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC89810F25E;
 Wed,  2 Sep 2026 14:35:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A398B40912;
 Wed,  2 Sep 2026 14:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E531F000E9;
 Wed,  2 Sep 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788359722;
 bh=PQs6g7VXxJkpL7lP9WgiDnYYUeMEbzLg/W5+SDZj6sg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fTAZCD7LlO96bpJ6Op7ArPfhdCS3q9keLwyo3C4HoD2hmE0nuJDt/IxI/eAJVMPPQ
 GzIvvN8p8yi21M4+sMq7y7KHh0XsHWmMoAnFzNC6jaIXyU/yXnHzRsbgwAWEEvAfLl
 AGWMxXOWSF3F/yD/GxC/SSq2GUd2BNsjEfmHNUKeUcRu4D7mi8dwM/bCpq2KiQLrUx
 umoxRqgz8mog6X7aOekjpwxPwcJjRHfiVMuKcxgFayb196hMA6XGhh6N4DrrchJb5F
 xRViCPvY4jQd0mQMqItHx3Qw7aaSB259pMfK8plDGlYHtvAFGjCAqc34DtEXr4LLhZ
 dqDvImrGDaGKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] perf: Fix null pointer access in
 is_include_guest_event()
To: "Vinay Belgaumkar" <vinay.belgaumkar@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260902141824.733112-2-vinay.belgaumkar@intel.com>
References: <20260902141824.733112-1-vinay.belgaumkar@intel.com>
 <20260902141824.733112-2-vinay.belgaumkar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:35:22 +0000
Message-Id: <20260902143522.69E531F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims that `READ_ONCE` was added to `is_incl=
ude_guest_event()` for checking the `pmu` state, but the code lacks this in=
struction.
--

commit 7c0504a46d493eec58eae8ca000ce324320508fd
Author: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

perf: Fix null pointer access in is_include_guest_event()

This commit addresses a null pointer dereference in is_include_guest_event()
caused by a module unload occurring while a perf connection is active. It a=
dds
a null check for the pmu pointer and calls mediated_pmu_unaccount_event()
before clearing the pointer to maintain the event counts correctly.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..7777e82aad5e7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6350,6 +6350,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
>  /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
>  static inline bool is_include_guest_event(struct perf_event *event)
>  {
> +	if (!event->pmu)
> +		return false;
> +
>  	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&

[Severity: Medium]
The commit message claims that READ_ONCE was added for checking the pmu sta=
te,
but the code lacks this instruction here.

Without READ_ONCE(), the compiler is free to issue two independent memory l=
oads
of event->pmu: one for the null check and one for accessing capabilities.

Could this leave a potential double-read hazard if event->pmu is concurrent=
ly
nullified by __pmu_detach_event() while is_include_guest_event() is executi=
ng?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902141824.7331=
12-1-vinay.belgaumkar@intel.com?part=3D1

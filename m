Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bahp8jDN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A65210E84A;
	Thu, 19 Nov 2026 10:27:46 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE77C10E84A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:27:39 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jVZRD50SWzMm1V;
 Thu, 19 Nov 2026 11:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795084056; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOX9nyivrM3ck0H36dvzV+Zj3ndjiCCyczZW/5f1e9g=;
 b=bahp8jDNBuQkwIXHRAHoj+SxCsKzQ9EmEyH35beHLp+DnSsC45YeBczP1yvz2whSTrQLhO
 cTkVUeQOmdOuNLkqi/eo3r/A4LWiqLVacylD1n875K18+qx6ZIDYs4lcHt/Ybq/rUEj5ad
 +rXtCrJHecEyOGREoFqGBteMElxRSAEkQgeeCR9gklLI2p1uXtddVrYv1ozXesyAN/pdIP
 k83d6L6rgH+vJHxAENFE0DTU4MCkg1DGOoMADq+xdm6tpXM2W5wwGv85NvYm9duadaexc0
 DP7xhgAjJqRm26AWWuuhUEBVZbqh2IVvspROikAXq7wTNQgxSoqb/LeBsMIA9w==
Message-ID: <88fbb3446db2403a4f305cc525c16d149551f57a.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Do not overaccount job runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Thu, 19 Nov 2026 11:27:34 +0100
In-Reply-To: <20261117094324.8256-1-tvrtko.ursulin@igalia.com>
References: <20261117094324.8256-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 95b2edd0c6c91839680
X-MBO-RS-META: sj3wctnsg4co398ie6cj16fkacux44kk
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-17 at 09:43 +0000, Tvrtko Ursulin wrote:
> Currently the starting timestamp of the next job on the timeline is
> adjusted to the end of a preceding job. This works if the next job has
> been submitted while the preceding job was still executing, but not if it
> was submitted in the window between it finishing and free job work runnin=
g
> the timestamp adjustment.
>=20
> This can happen because the run job and free job work items share the sam=
e
> ordered workqueue and run job can easily submit the next job before the
> free job gets a chance to run. This over accounting window is present
> especially with single credit schedulers, but not limited too.

What's a single credit scheduler? Maybe rephrase that?

>=20
> Fix it by only adjusting the starting timestamp if it is not already afte=
r
> the finish time of the preceding job.
>=20
> While at it move the logic to a helper to keep indendation at bay.

typo, indentation.


Acked-by: Philipp Stanner <phasta@kernel.org>

Feel free to push yourself, with the above addressed if you like.


P.

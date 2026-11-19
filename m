Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB2606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Gb95Xi3R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3401B10EB9B;
	Thu, 19 Nov 2026 12:11:24 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CAA10EB9B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:11:18 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jVckq5GsPzKnmZ;
 Thu, 19 Nov 2026 13:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795090275; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hUbeUZ2ql8YnrFxWAGvLHeu4ehfd3o439Wv8LkGnIw=;
 b=Gb95Xi3R1KdkB+iRt7fWW29SN4s5Xw3FFsmab4Gfb23vDFwqbvTYEBTzsyx6T3WZD1W29l
 gbY81bG6V8gl9tH2UVoceRys8KJ0BWestq+BBCkI4UeuEhyoYHkasd7gc9Q3r+WWHwhJjV
 GaRlEmubVEXwkUGMRl78x5h9QP3VVOo57IkmC1TqIT/3EmzFPubdnyWmZN3/FSZg8VbY4J
 6/eXGVESUWGjHsoolZR77QapfbPgjdiMYAiDkrDOQ8Zq+2mHrJL6sNNSdMgFR3YkxPzDDA
 FSRzI0AS2cWpJanLeGQrrr1G9d91y55AXjzjexdYp2D9hWowaFRC0B1Wv8WC9Q==
Message-ID: <6e8e09370d76219f7d2061e635c1ad224ac9d8a3.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Do not overaccount job runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Thu, 19 Nov 2026 13:11:13 +0100
In-Reply-To: <20261117094324.8256-1-tvrtko.ursulin@igalia.com>
References: <20261117094324.8256-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: eb0f94f10897b7d3a18
X-MBO-RS-META: u94sgg11hcoegio9674u4xzhxe1yfeeh
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

On Tue, 2026-11-17 at 09:43 +0000, Tvrtko Ursulin wrote:

[=E2=80=A6]
=C2=A0
> +static void
> +drm_sched_job_adjust_next_start(struct drm_sched_job *job,
> +				struct drm_sched_job *next)
> +{
> +	struct dma_fence *next_scheduled =3D &next->s_fence->scheduled;
> +	ktime_t ts;
> +
> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &next_scheduled->flags))
> +		return;
> +
> +	/*
> +	 * If the next job has been submitted while the previous one was still
> +	 * running adjust it's starting timestamp to avoid accounting overlap.
> +	 */
> +	ts =3D dma_fence_timestamp(&job->s_fence->finished);
> +	if (ktime_after(ts, next_scheduled->timestamp))

sry for the back and forth, just seeing this

Why is ts accessed through the accessor function and the scheduled
timestamp via a direct pointer access? That's inconsistent and
shouldn't be done.


P.

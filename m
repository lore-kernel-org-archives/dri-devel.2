Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030F606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gnsu0eeJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417F410E85B;
	Mon,  9 Nov 2026 10:21:16 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDBC10E85B;
 Mon,  9 Nov 2026 10:21:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jNQmK6GdxzKnCY;
 Mon, 09 Nov 2026 11:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794219665; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuuWW3Syt2+hvt553HfYc9XJXAAIvtR9m+V/lPJpa6c=;
 b=gnsu0eeJFkHEPHGJp4polsmIV0GY9jncQ5aryVHoknMRuSzp4Li4GZLB38ghxVlDDTj6Kk
 cnrlRikHV5c+IDDJHN5VA2As4HQgtT9ybO3B1p4W/mOLT8b+Nl+b/NBpN6uvvGU+qMkYfd
 /flE3yS+sbzR+qDaK5s3cyBGIdxB9LQPbsaemg8fQvPJSfXq0BiWtspHOTJIr2pSs3h5M2
 cLph01/GpFfUVB1luz5FotT5RpsM9NMMcy9mDp8ffKal028jYfRICl97BWtsiggNQRD3xN
 UQW819qcXs+EaCeoYF4pJQLbxa3g/w3BKKU/82oNMMiKAJKdhwC8XWqM2elc2A==
Message-ID: <e0476d10290d0f787a467f36381e8439530ba2ff.camel@mailbox.org>
Subject: Re: [PATCH 0/7] drm/sched: Replace SPSC queue with a list and spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Mon, 09 Nov 2026 11:21:03 +0100
In-Reply-To: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: hr4eoix8a757ensr6apchmypukmbzhd1
X-MBO-RS-ID: f1fbc1bf6e267f41d6d
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

On Fri, 2026-11-06 at 14:56 +0000, Tvrtko Ursulin wrote:
> [First four patches are just my queue to avoid conflicts. I am still hopi=
ng I
> can bring them in a state where all is good since all these together simp=
lify
> things.]

I'm confused, so is this an RFC for AMD to take a first look?

> So as requested by Philipp and as the title says - replacing the SPSC que=
ue with
> a list and a spinlock. A first cut which passes unit tests and smoke test=
ing on
> AMD.

Thx for working on this, it's one of the most important chunks of tech
debt!

> But it wasn't easy, since we can't really get away from some of the deepl=
y
> ingrained scheduler design points.

What would those be?



P.

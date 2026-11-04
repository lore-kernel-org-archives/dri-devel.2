Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A571606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=SwtvEyPL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEC110E84D;
	Wed,  4 Nov 2026 08:48:13 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825FE10E84D;
 Wed,  4 Nov 2026 08:48:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKJxH2QYNz8v1K;
 Wed, 04 Nov 2026 09:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793782083; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTcKGaMEFZJ+gKcb8wNFFFYabXj82mL3rKDihJVqD/8=;
 b=SwtvEyPLIoWWaYpSkGb0pIfrSexCQ+WlN8vRZk4gX25sJpdbwKd7+Hap2hmLDOpQVSBctB
 cLFhfQRu2zCgu0ijQXh4bEDrGsIuQf9jR2XxGEraRmWSmJd8C8Q/q+2OUqdSKMQlyM735p
 SXIkuaEvoEfsZCf5K8esIG6WpJvlV33Y8qkAWUkZzHc3Ri8clBjRIY97BQCprrguHlaLhM
 csK1S0nJ0AjeQ7MyVpKurn1idcSHfKjUHcAB5De2hfp9F5GjD5OCtpFagiLCRWTg14N3HF
 rFXSWAWCQpP0zrCL75Oe/gJ7mF2tdSpwKwZHO/z7x0rFrrCKaRrHg/aKe6Gx5A==
Message-ID: <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>,
 stable@vger.kernel.org
Date: Wed, 04 Nov 2026 09:48:01 +0100
In-Reply-To: <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
 <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 318yyz1zitody3gc1eoi1khtmm5qk139
X-MBO-RS-ID: 8727d1ffcbddc88b426
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

On Wed, 2026-11-04 at 08:33 +0000, Tvrtko Ursulin wrote:
> I lost you here - what should the comment say?

Just a "TODO: entity->rq_priority could not be fully removed due to the
partial revert of the CFS scheduling rework. For formal correctness, it
still has to be adjusted here".

Just so that the reader sees that this is in an intermediate state
right now, and so he's incentivized to git-blame the TODO to find the
associated commits and mailing-list-archives.


Regards,

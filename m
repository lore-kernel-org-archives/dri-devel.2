Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434B606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YrxlNfSU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D8110EC7F;
	Wed, 18 Nov 2026 17:13:55 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7732610EC7F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:13:49 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jV7VK6l3czMlrd;
 Wed, 18 Nov 2026 18:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795022025; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QR1RNHzs2u14Ph0B4gD3aU3qoBrSNnqTkcBoRvF2bT4=;
 b=YrxlNfSUElq3FaIcdvtZiFVoVmZG6NuRyXML1/7MZuTaQmr9VCKxzQl7iqPbAKvXm01+8z
 /a6gxgCXvIY6bP4k5XAwd+1XSLgG0+6hN+0r/GbgnpVhJejy+Dbx7BrQZ4QVYfT7atV8TP
 DdV3H2PhstJ2zDbv2cJuszSr6QiKie3ey+1zf4pAQ6Bt0WsxQdZh2WHFOzwpcDKgeJGEye
 spGeq7iTydjBs8shjXiKsTWrO7CWYNzwQYehmjq651Gs4rmilpFq9Nv/5nOwfjBvVf4GPo
 tjkSf3GTgZ8cb4HCJcjouN8DM684x2yMuvwO3tR07AFgBt46tirOXE2lK3uwSQ==
Message-ID: <34494226eb920bdbd7f3257ef6f9b20f4e8ffd6a.camel@mailbox.org>
Subject: Re: [PATCH v5 1/2] drm/sched: Add drm_sched_entity_get_runtime()
From: Philipp Stanner <phasta@mailbox.org>
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>,  Oded Gabbay <ogabbay@kernel.org>, Philipp Stanner
 <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,  Matthew Brost
 <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com, Heiko Stuebner
 <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 18:13:43 +0100
In-Reply-To: <20261112171144.3151554-2-sidong.yang@furiosa.ai>
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-2-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: nihofrjwt83qtc66on69bxqupay6dcpp
X-MBO-RS-ID: 0cbdfb5ec03db5df4c9
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-13 at 02:11 +0900, Sidong Yang wrote:
> The scheduler accumulates the time each entity's jobs spend on the
> hardware for the fair policy, but drivers cannot read it. Export it so
> drivers can report per-client engine time through fdinfo without
> keeping their own counter.
>=20
> The stats object is refcounted and held by the entity and its jobs, so
> unlike commit df622729ddbf ("drm/scheduler: track GPU active time per
> entity"), which was reverted, accounting a job does not touch the
> entity.

In general looks good to me, no objections.

But a question below:

>=20
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>


> +u64 drm_sched_entity_get_runtime(struct drm_sched_entity *entity)
> +{
> +	struct drm_sched_entity_stats *stats =3D entity->stats;
> +	ktime_t runtime;
> +
> +	spin_lock(&stats->lock);
> +	runtime =3D stats->runtime;
> +	spin_unlock(&stats->lock);
> +
> +	return ktime_to_ns(runtime);

Why not return it as ktime_t?

ktime_t, I suppose, is the universal time unit in the kernel, and the
user can use one of the converters to turn it into whatever is desired.

With ns you would have to write the converters yourself.

P.

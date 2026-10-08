Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D901ACA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA9210FD5D;
	Thu,  8 Oct 2026 10:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CIUcBsvC";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D4510FD5D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 10:10:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j0m2h6S1RzMlM4;
 Thu, 08 Oct 2026 12:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1791454221; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+U5fqn+WpCc2hqRBDj7VIV1ltzNKH82OjdIr6I45iPQ=;
 b=CIUcBsvCMfqvrAuyFNC8+eH2BM9W+QlrkMHIdfD56pca1jQXMlL2VhqmdjMz6E59BcytBG
 KIBj5O+ykmDptAhGz735MOva+ovrND/5pQ2mEu5GEvpsfgYBBR+wYttBFamZiMBbdQ9/Vj
 n6QHsuebS+vPh9Cp3XkEqujla5keMgpJX5F5yBiEbyPydXzPIhMu9x2uVywjPWBDSm2L6S
 5f9PVXfADB78XVXRvrcde4AW9G8txOlTOQ6UEos/mchb9eW6ECIuRS/1ZKEjqS+VKAGVxr
 EPzZhMF9qXFrNnZvzl0jshTOgWUy2RTemuqiWDqw2HhYP1CNsaCkUcKqsXqx6g==
Message-ID: <c7a17c258ae39abe74e7abe270aaee1daf31258d.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Document entity->stopped is protect by
 entity->lock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Thu, 08 Oct 2026 12:10:15 +0200
In-Reply-To: <20261002124655.74716-1-tvrtko.ursulin@igalia.com>
References: <20261002124655.74716-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-MBO-RS-ID: 9d19c6d0a3f6606de26
X-MBO-RS-META: i7gbfmt9grp9dbufx1gxrewif7p1c4ko
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

On Fri, 2026-10-02 at 13:46 +0100, Tvrtko Ursulin wrote:
> Commit
> 0e118b936dc5 ("drm/sched: Lock drm_sched_entity_is_idle()")
> has removed the last unlocked entity->stopped access so lets officially
> document it in kerneldoc as locked with the entity lock.

Ah nice, I overlooked that. Thx for fixing.

Nit: typo in the commit title, "protectED". I can fix that at applying
if you want.


P.

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0include/drm/gpu_scheduler.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 563d7fb88a6d..3b0978fa8cf0 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -101,7 +101,7 @@ struct drm_sched_entity {
> =C2=A0	 *
> =C2=A0	 * Lock protecting the run-queue (@rq) to which this entity belong=
s,
> =C2=A0	 * @priority, @last_scheduled and the list of schedulers (@sched_l=
ist,
> -	 * @num_sched_list) and @rr_ts.
> +	 * @num_sched_list), @rr_ts and @stopped.
> =C2=A0	 */
> =C2=A0	spinlock_t			lock;
> =C2=A0

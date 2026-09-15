Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F7AC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A50B10EFCC;
	Tue, 15 Sep 2026 07:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HLbHv5e4";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD79010EFCC
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:13 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hkYLx5DpNzMlCF;
 Tue, 15 Sep 2026 09:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789456809; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+wLRmdGG7/Y4tpo0/xjd90c1sLD7GxGhMrSYb6BXtE=;
 b=HLbHv5e4/6Vz3z8UvudokdtnyWaTHKoEw4NzwIW8rky2bJiSaqreUSigia9MeWugDi0mQ2
 IYVLrSuPBgCL0lwIHweuOf4HPwgeeSPECDs2PJiEGM2253joBT26u0ilfkGe+xOz4jrINE
 cV1WL90PTT+uOj5GWZjKGbps0+N0SqTE9jfvRHF/DwPQqpkOVK7CSpxMZJUXw7ZmLZFyQJ
 O6TtVts4nFDk7NRC+MKv9DKlXcqwY/Rryv4VVba+ftgGGQWze4X6lW7YnNKbMArL7Ew52q
 cCNEFSK/OlNPic3Op8yO66qg9kV3yk61EvJKstovXmWB3eJAjmBzTKrGWFpirw==
Message-ID: <1fa1da9650fdd7cecb11195134d6fd0e1c3978df.camel@mailbox.org>
Subject: Re: [PATCH 2/2] drm/sched: document the RCU dependency
From: Philipp Stanner <phasta@mailbox.org>
To: christian.koenig@amd.com, phasta@kernel.org, malhyuk97@gmail.com, 
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Date: Tue, 15 Sep 2026 09:20:03 +0200
In-Reply-To: <20260914182740.1587-2-christian.koenig@amd.com>
References: <20260914182740.1587-1-christian.koenig@amd.com>
 <20260914182740.1587-2-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: a68fa6ec319ad5b96f2
X-MBO-RS-META: t5btidzie5mr3t5yspjddnxjkid8o4pm
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

On Mon, 2026-09-14 at 20:27 +0200, Christian K=C3=B6nig wrote:
> Tvrkos patches added RCU protection to the returned strings from

*Tvrtko ;)

Anyways, which patches? Better add a commit ID?

> get_timeline_name()/get_driver_name() callbacks of the dma_fence
> backends.
>=20
> This fixed use after free problems for a couple of drivers, but we never
> documented the consequences for the drm_sched_fence.
>=20
> Add a few words on the function documentation to note that we need an
> RCU grace period between signaling the last scheduler fence and

s/scheduler fence/hardware-fence

:D

> scheduler teardown.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

with the above:

Acked-by: Philipp Stanner <phasta@kernel.org>

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 6cb6f95464938..f73c5141b4e5c 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1203,6 +1203,11 @@ static void drm_sched_cancel_remaining_jobs(struct=
 drm_gpu_scheduler *sched)
> =C2=A0 * is implemented, all jobs will be canceled through it and afterwa=
rds cleaned
> =C2=A0 * up through &struct drm_sched_backend_ops.free_job. If cancel_job=
 is not
> =C2=A0 * implemented, memory could leak.
> + *
> + * The user must wait one RCU grace period between signaling the last ha=
rdware-
> + * fence and calling this function because the timeline name returned by
> + * scheduler fences must stay valid until all readers have exited their =
RCU read
> + * side critical section.
> =C2=A0 */
> =C2=A0void drm_sched_fini(struct drm_gpu_scheduler *sched)
> =C2=A0{

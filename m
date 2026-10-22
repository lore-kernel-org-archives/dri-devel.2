Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C4606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUfYiDcz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F39F10E455;
	Thu, 22 Oct 2026 17:52:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919EF10E455
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 17:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D64E40318;
 Thu, 22 Oct 2026 17:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D101F01825;
 Thu, 22 Oct 2026 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792691518;
 bh=b+haD+rF2wK+426IiKtZ0wj0VXCMso+GtSPw/G3x2kg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QUfYiDczHm0hbUvpujj3LESI62MF1Iy3LzxXZqmskry7wlfo6jWiMD9XXDe19sqnF
 mZYGi6CVxc7REuoT5P+TBr1/waQ44/PSOoPu8x38QhzZJTi2uJT47c/8fp4E4T6LMP
 X9toCdBpeyZLkAtcSQyz73ojvzeQn0w5bpMPm1bLV0EFFJuRlcOKGtMEuYOwvJxI6t
 cXnN+zIxodnemx0698QHV4DRHbVy2iduSXBo5EX8DFAMePJO2Qa4TTVWzLcRhjCugL
 snP769wRB91KGwvQlXr3dwPChtkkThVf7ABdOSUH9n99s1gYCh2rsVIPE8NFURHOJ9
 bD9c3XDwp6zTw==
Message-ID: <sashiko-outbox-181892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amd/display: Fix some memory lifetime issues in
 KUnit tests
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022173655.2318987-2-John.Harrison@Igalia.com>
References: <20261022173655.2318987-1-John.Harrison@Igalia.com>
 <20261022173655.2318987-2-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:51:57 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/amd/display: memory leak of wbcon in dm_test_wb_connector_in=
it_success()
- [Medium] drm/amd/display: memory leak of port in dm_mst_test_alloc_dsc_li=
nk_ctx()
--

commit 46c185efd7ffdbf05586b8f2bd12c8e611ccd969
Author: John Harrison <John.Harrison@Igalia.com>

drm/amd/display: Fix some memory lifetime issues in KUnit tests

This commit updates memory allocations in several amdgpu display KUnit
tests to avoid use-after-free errors during test teardown when memory
debugging is enabled.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_ty=
pes_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_type=
s_test.c
> index eafa3e6733a64..5dc6cd8801691 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_tes=
t.c
> @@ -3833,7 +3833,7 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, =
int total_avail_slots)
>  	link_srv =3D kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
>  	res_pool =3D kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
>  	sink =3D kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
> -	port =3D kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
> +	port =3D kzalloc(sizeof(*port), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, link_srv);
>  	KUNIT_ASSERT_NOT_NULL(test, res_pool);
>  	KUNIT_ASSERT_NOT_NULL(test, sink);

[Severity: Medium]
Does this leak port in dm_mst_test_alloc_dsc_link_ctx() in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
when running the dm_mst_test_dsc_link_* tests?

Later in dm_mst_test_alloc_dsc_link_ctx(), port->malloc_kref is
initialized to 1:

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c:
dm_mst_test_alloc_dsc_link_ctx() {
    ...
	/* The payload allocation takes a reference, so start above zero. */
	kref_init(&port->malloc_kref);
	port->mgr =3D &ctx->aconnector->mst_mgr;
	port->connector =3D &ctx->aconnector->base;
	port->full_pbn =3D 2000;
    ...
}

When pre_compute_mst_dsc_configs_for_state() runs
compute_mst_dsc_configs_for_link() -> drm_dp_atomic_find_time_slots(), it
adds a payload to ctx->mst_state->payloads and calls
drm_dp_mst_get_port_malloc(port), incrementing port->malloc_kref from 1 to
2.

On test exit, tearing down ctx->state calls drm_dp_mst_destroy_state() in
drivers/gpu/drm/display/drm_dp_mst_topology.c:

drivers/gpu/drm/display/drm_dp_mst_topology.c:drm_dp_mst_destroy_state() {
    ...
	list_for_each_entry_safe(pos, tmp, &mst_state->payloads, next) {
		/* We only keep references to ports with active payloads */
		if (!pos->delete)
			drm_dp_mst_put_port_malloc(pos->port);
		kfree(pos);
	}
    ...
}

That drops only the payload reference, decrementing port->malloc_kref from
2 back to 1. Because ctx->aconnector is initialized with
dm_mst_test_dsc_link_conn_funcs rather than dm_dp_mst_connector_destroy()
and port is not attached to any branch in ctx->aconnector->mst_mgr,
nothing ever drops the initial malloc_kref reference (and if it did reach
0, drm_dp_free_mst_port() would call drm_dp_mst_put_mstb_malloc() on a
null port->parent).

The original use-after-free happened because kunit_kzalloc() for port was
registered after drm_kunit_helper_atomic_state_alloc(), so KUnit's
last-in, first-out cleanup freed port before ctx->state teardown ran
drm_dp_mst_destroy_state(). Could port be allocated with
drmm_kzalloc(ctx->drm, ...) or allocated with kunit_kzalloc() prior to
drm_kunit_helper_atomic_state_alloc() instead?

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_tes=
t.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> index 4bc033fdfa97a..f3b64a66cf28d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> @@ -500,7 +500,7 @@ static void dm_test_wb_connector_init_success(struct =
kunit *test)
>  	dc->links[0] =3D link;
>  	dm->dc =3D dc;
> =20
> -	wbcon =3D kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
> +	wbcon =3D kzalloc_obj(*wbcon);
>  	KUNIT_ASSERT_NOT_NULL(test, wbcon);
> =20
>  	ret =3D amdgpu_dm_wb_connector_init(dm, wbcon, 0);

[Severity: Medium]
Won't changing wbcon to kzalloc_obj(*wbcon) in
dm_test_wb_connector_init_success() in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c leak wbcon
on every run of this test?

In drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c,
amdgpu_dm_wb_connector_init() initializes wbcon->base through
drm_writeback_connector_init() using amdgpu_dm_wb_connector_funcs:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c:
static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs =3D {
	.fill_modes =3D drm_helper_probe_single_connector_modes,
	.destroy =3D drm_connector_cleanup,
	.reset =3D amdgpu_dm_connector_funcs_reset,
	.atomic_duplicate_state =3D amdgpu_dm_connector_atomic_duplicate_state,
	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
};

Unlike regular amdgpu_dm_connector_funcs (which uses
amdgpu_dm_connector_destroy() to kfree() the connector),
amdgpu_dm_wb_connector_funcs sets .destroy to drm_connector_cleanup(),
which in drivers/gpu/drm/drm_connector.c only cleans up internal connector
state without freeing the enclosing struct amdgpu_dm_wb_connector.

The original use-after-free occurred because wbcon was allocated with
kunit_kzalloc() after adev =3D dm_kunit_alloc_adev(test), causing KUnit to
free wbcon before drm_mode_config_cleanup(&adev->ddev) cleaned up the
writeback connector and encoder. Would allocating wbcon with
kunit_kzalloc() before dm_kunit_alloc_adev(test) (or via drmm_kzalloc())
fix the ordering issue without leaking wbcon?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022173655.2318=
987-1-John.Harrison@Igalia.com?part=3D1

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AE606A32F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTEQvc5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C706610E7AD;
	Fri,  6 Nov 2026 06:44:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB3C10E55B;
 Fri,  6 Nov 2026 06:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 081914004F;
 Fri,  6 Nov 2026 06:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2BA1F008A3;
 Fri,  6 Nov 2026 06:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793947441;
 bh=Lq19CXhOeqT6MgWlI1F8gJb79H8vmjdCYSmVq7k8iiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bTEQvc5weNeLyI1u7/gm54hcOU8v3Q5LJVc3mur0J/cg5PsEBzgaC8ehD/iQZIViG
 IY3CFds0CZArtr4S0ikPhNGM5KnD1yorhPOUIMThv+zbwvKSwAl+EeOMPP6Snxnqn2
 WU6HZONz6hAqb/a0ngt2M5WVJphMSr99tpW5h0uWaai2MR9RGnfedStAqohjSiJcsz
 rC3KAb2IykwglIz9drJOPP2GyIYKz1ZNGCC7ejrzMsSj3OdMmBzjXiwdmHJ8RBxWoB
 Sm+qivQx0f4VIKrRSGirLH+c1+u3NIs+zXDjpftkkR3U9HA701dJDSkBopfPUXRv+4
 yFOXfivABprUw==
Message-ID: <sashiko-outbox-200939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/23] dma-buf: Add kunit tests for mapping type
 selection
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261105-dma_mapping_type_v4-v2-23-78b8dc9ae80a@nvidia.com>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-23-78b8dc9ae80a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 06:44:01 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] dma-buf: duplicate KUNIT_EXPECT_PTR_EQ() added in
  test_mock_attach()
- [Low] dma-buf: duplicated callback setup and dead field in
  mock_mapping
- [Low] dma-buf: commit message omits failed map and pin selection tests
--

commit 71d342095c556fe9ee3e5b69defcc3e410afbe6f
Author: Alistair Popple <apopple@nvidia.com>

dma-buf: Add kunit tests for mapping type selection

This commit adds a configurable offer list, a select_mapping() callback, and
map/unmap operations for the mock mapping types in the dma-buf KUnit test
suite. It also introduces new KUnit test cases to verify the mapping type
selection contract across attach, map, pin, and failure paths.

>     dma-buf: Add kunit tests for mapping type selection
>    =20
>     Add an offer list and a select_mapping() callback to the mock exporter
>     along with map/unmap for the two mock types.
>    =20
>     Adds tests for the exporter/importer contract.
>    =20
>      - test_match_set_is_final: a later importer attaching, even one the
>        exporter answers differently, does not change an existing
>        attachment's match set or default. Later attachments influence what
>        the exporter selects at pin and map time, not previous attachments.
>    =20
>      - test_select_at_map: the exporter chooses a non-default entry
>        at the first map and the result is tagged with it. A pin taken
>        under the live mapping inherits the type and the choice survives
>        unmap/remap even though the exporter would answer differently. Only
>        dma_buf_invalidate_mappings() allows the exporter to make a differ=
ent
>        selection. An -EBUSY from selection leaves nothing established.
>    =20
>      - test_select_at_pin: pin selects, and the choice survives map, unmap
>        and unpin so a pinned importer that is never invalidated keeps its
>        first type for the life of the import.
>    =20
>     Signed-off-by: Alistair Popple <apopple@nvidia.com>

[Severity: Low]
This isn't a bug, but the commit message only lists test_match_set_is_final,
test_select_at_map, and test_select_at_pin, while the patch also adds
mock_dmabuf_pin(), mock_dmabuf_unpin(), failure injection state, and two
additional test cases in dma_mapping_cases (test_select_survives_failed_map
and test_select_after_failed_pin).

Could the commit message be updated to describe these two failed map and pin
selection tests as well?

> diff --git a/drivers/dma-buf/st-dma-mapping.c b/drivers/dma-buf/st-dma-ma=
pping.c
> index cbfa99aeb0ff5..11010731150ae 100644
> --- a/drivers/dma-buf/st-dma-mapping.c
> +++ b/drivers/dma-buf/st-dma-mapping.c

[ ... ]

> @@ -370,11 +391,478 @@ static void test_mock_attach(struct kunit *test)
>  	KUNIT_EXPECT_PTR_EQ(test, dma_buf_attach_map_type(attach)->type,
>  			    &mock_type_a);
>  	KUNIT_EXPECT_PTR_EQ(test, mock_match_dev_arg, dev);
> +	KUNIT_EXPECT_PTR_EQ(test, mock_match_dev_arg, dev);

[Severity: Low]
This isn't a bug, but was this second KUNIT_EXPECT_PTR_EQ(test,
mock_match_dev_arg, dev) in test_mock_attach() added by accident?

[ ... ]

> +/* Mock mapping result for the generic map path */
> +struct mock_mapping {
> +	struct dma_buf_mapping base;
> +	const struct dma_buf_mapping_type *made_by;
> +};
> +
> +static struct dma_buf_mapping *mock_type_map(struct dma_buf_attachment *=
attach,
> +					     enum dma_data_direction dir)
> +{
> +	struct mock_mapping *m;
> +
> +	if (mock_map_err)
> +		return ERR_PTR(mock_map_err);
> +	m =3D kzalloc_obj(*m);
> +	if (!m)
> +		return ERR_PTR(-ENOMEM);
> +	m->base.type =3D dma_buf_attach_map_type(attach)->type;
> +	m->made_by =3D dma_buf_attach_map_type(attach)->type;
> +	return &m->base;
> +}

[ ... ]

> +static void test_select_at_map(struct kunit *test)
> +{
> +	static const struct dma_buf_mapping_match offer_ab[] =3D {
> +		{ .type =3D &mock_type_a },
> +		{ .type =3D &mock_type_b },
> +	};
> +	struct dma_buf_mapping_match imp[] =3D {
> +		{ .type =3D &mock_type_a },
> +		{ .type =3D &mock_type_b },
> +	};
> +	MOCK_IMPORTER_OPS(importer_ops, imp);
> +	struct dma_buf_attachment *attach;
> +	struct dma_buf_mapping *mapping;
> +	struct dma_buf *dmabuf;
> +	struct device *dev;
> +
> +	mock_type_a.map =3D mock_type_map;
> +	mock_type_a.unmap =3D mock_type_unmap;
> +	mock_type_b.map =3D mock_type_map;
> +	mock_type_b.unmap =3D mock_type_unmap;

[Severity: Low]
This isn't a bug, but test_select_at_map(), test_select_at_pin(),
test_select_survives_failed_map(), and test_select_after_failed_pin() each
manually assign map and unmap on mock_type_a and mock_type_b at the start of
the test and clear them to NULL at the end. If any KUNIT_ASSERT_NOT_ERR_OR_=
NULL
in those tests fails, the test aborts before clearing the pointers and
reset_mock_state() does not reset them.

Since none of the other tests in drivers/dma-buf/st-dma-mapping.c require
mock_type_a.map or mock_type_b.map to be NULL, could map and unmap be
initialized directly in the static definitions of mock_type_a and mock_type=
_b
instead? Also, is the made_by field in struct mock_mapping needed given that
mock_type_map() sets m->base.type to the same value and made_by is never re=
ad?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-dma_mappin=
g_type_v4-v2-0-78b8dc9ae80a@nvidia.com?part=3D23

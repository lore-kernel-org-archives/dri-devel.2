Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736E606A337
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/oF9EDw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5EE10E1FD;
	Sat, 21 Nov 2026 05:59:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD9010E13E;
 Sat, 21 Nov 2026 05:58:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCA0160D5A;
 Sat, 21 Nov 2026 05:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7371F000CA;
 Sat, 21 Nov 2026 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795240729;
 bh=hnDRM73TC0nplRxc205ku0j1sS5JoUC+VQrBwd8j4Mg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E/oF9EDwtlEOefb8q5DVGI8aTeqrgp5bRuKfhd+9iFK6UKL5tEqRO6GPj74oUIlNu
 CpnMuTRZlJc+r7wzaUpGZdUeT7+p/I+RaJ9KXzssWvIOzFfk4bMEk/3lswiEjk3/PZ
 QNNFqotvMgcBsiBvvEvrRQdLS/u60oMlZu3ok+ZCJXe+MuMII6m4LGdVv9+ZY32cko
 IqGrUCTUPx7MZjoMPQc7pZ9ocGD36ip6kTVKCbgVWWytjzJ9Elt3UK6HEuvHC71WHH
 3goqt/q4haCh/Cq/2YTn88Ha6WhjWY1Hcqe772T9mU8iHvgG26RYfW0OXl7q7G1Vr9
 f/JTiL2BLVvYA==
Message-ID: <sashiko-outbox-226692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/24] dma-buf: Add kunit tests for mapping type
 selection
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261120-dma_mapping_type_v4-v3-24-c0183a409bdf@nvidia.com>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-24-c0183a409bdf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 05:58:48 +0000
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
- [High] dma-buf: build failure from mapping2->type access in selection
  KUnit tests
- [Low] dma-buf: duplicated mock_type_a and mock_type_b callback setup
  across tests
- [Low] dma-buf: commit message omits failed map and pin selection KUnit
  tests
--

commit fdd7641c86ac3670b97b442d9f583c8418cdf65b
Author: Alistair Popple <apopple@nvidia.com>

> dma-buf: Add kunit tests for mapping type selection
>
> Add an offer list and a select_mapping() callback to the mock exporter
> along with map/unmap for the two mock types.
>
> Adds tests for the exporter/importer contract.
>
>  - test_match_set_is_final: a later importer attaching does not change
>    an existing attachment's match set or default. Later attachments
>    influence what the exporter selects at pin and map time but not
>    previous attachments.
>
>  - test_select_at_map: the exporter chooses a non-default entry on first
>    map and the result is tagged with it. A pin taken while there is a
>    live mapping inherits the type and the choice survives unmap/remap.
>    Only dma_buf_invalidate_mappings() allows the exporter to make
>    a different selection. An -EBUSY from selection leaves nothing
>    established.
>
>  - test_select_at_pin: pin selects, and the choice survives map, unmap
>    and unpin so a pinned importer that is never invalidated keeps its
>    first type for the life of the import.
>
>  - test_unmap_uses_own_type: after an invalidate the exporter may select
>    another type for the next map. A mapping made with the previous one
>    is still live, and each mapping must be torn down with the type it
>    was made with.
>
>  - test_select_survives_own_invalidate: a pin or map whose exporter
>    callback invalidates every attachment still ends up selected, and one
>    that invalidates and fails does not.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

[Severity: Low]
This isn't a bug, but the commit message lists five of the new test cases
while omitting test_select_survives_failed_map and
test_select_after_failed_pin.

> diff --git a/drivers/dma-buf/st-dma-mapping.c b/drivers/dma-buf/st-dma-ma=
pping.c
> index 8c69ae212455c..42e6748f0ae65 100644
> --- a/drivers/dma-buf/st-dma-mapping.c
> +++ b/drivers/dma-buf/st-dma-mapping.c

[ ... ]

> @@ -374,6 +407,485 @@ static void test_mock_attach(struct kunit *test)
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

[ ... ]

> +	dma_buf_detach(dmabuf, attach);
> +	dma_buf_put(dmabuf);
> +
> +	mock_type_a.map =3D NULL;
> +	mock_type_a.unmap =3D NULL;
> +	mock_type_b.map =3D NULL;
> +	mock_type_b.unmap =3D NULL;
> +}

[Severity: Low]
This isn't a bug, but all six selection tests assign and clear .map and
.unmap on mock_type_a and mock_type_b, and an early KUNIT_ASSERT failure
skips the teardown since reset_mock_state() does not reset them.  Can
mock_type_a and mock_type_b initialize .map =3D mock_type_map and .unmap =3D
mock_type_unmap statically (or manage them in reset_mock_state())?

> @@ -381,6 +893,190 @@ static const struct dma_exporter dma_exporter_param=
s[] =3D {
> +static void test_unmap_uses_own_type(struct kunit *test)
> +{

[ ... ]

> +	/* Invalidated while that mapping is live: the next map reselects */
> +	dma_buf_invalidate_mappings(dmabuf);
> +	KUNIT_EXPECT_FALSE(test, attach->selected);
> +	mock_select_idx =3D 0;
> +	mapping2 =3D dma_buf_mapping_map(attach, DMA_BIDIRECTIONAL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mapping2);
> +	KUNIT_EXPECT_PTR_EQ(test, mapping2->type, &mock_type_a);

[ ... ]

> +static void test_select_survives_own_invalidate(struct kunit *test)
> +{

[ ... ]

> +	/* A second map does not reselect. */
> +	mock_select_idx =3D 0;
> +	mapping2 =3D dma_buf_mapping_map(attach, DMA_BIDIRECTIONAL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mapping2);
> +	KUNIT_EXPECT_PTR_EQ(test, mapping2->type, &mock_type_b);

[Severity: High]
Does accessing mapping2->type break the build when CONFIG_DMABUF_KUNIT_TEST
is enabled?

struct dma_buf_mapping only has a match member, not type, so these two
checks in test_unmap_uses_own_type() and
test_select_survives_own_invalidate() should use
dma_buf_mapping_type_of(mapping2).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dma_mappin=
g_type_v4-v3-0-c0183a409bdf@nvidia.com?part=3D24

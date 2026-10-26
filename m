Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49676606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxALa8B4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73B510EDB3;
	Mon, 26 Oct 2026 10:19:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025C810EDA7;
 Mon, 26 Oct 2026 10:19:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EA6D43601;
 Mon, 26 Oct 2026 10:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA511F01825;
 Mon, 26 Oct 2026 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009984;
 bh=oZXuIZB1OfhO4xVP5brrsRIQTt0HNBTRDxCMpd4Ya+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bxALa8B4ZO5meVz12zCEO9mqK14UuDMBCHbc2hnnvUx8uBeXNJOfC1cB3wVjOqIHN
 O7mYSV9vWZQlvjwiYxRZDY5z8Rvn6PK9KgWIUl45pGsnqu/TxBn4FgFJeJKXWlJLAk
 p/aEQV+3hds9addlOI+IA2UeofSmTZmqjIU2UxhOVHbc8h/d8JXUMwmAaC1p3XNDMN
 ciqTCZntYi51/oHCxXF5NWO12gZuWufu6kP8I2X+4yv3ZjmBRcB4Tczv2EUv7CzDvs
 sskZy6Mrn4GyitFTIt4N54kSDeHObbxqndU9Ula1QPG3npvY3dX2USMZqqBRUju36A
 KKbrVxeWp6bPg==
Message-ID: <sashiko-outbox-184924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/26] dma-buf: Add kunit tests for mapping type
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261026053623.202642-26-apopple@nvidia.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-26-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:19:43 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dma-buf: kunit: test_match_fail() overwrites args before type mi=
smatch check
--

commit 4b902f505b8acdddc13e192c921c70bcac60644c
Author: Jason Gunthorpe <jgg@ziepe.ca>

dma-buf: Add kunit tests for mapping type

This commit adds KUnit tests in drivers/dma-buf/st-dma-mapping.c to test
dma_buf_match_mapping() matching and priority rules as well as SGT and
dynamic attachment flows.

> diff --git a/drivers/dma-buf/st-dma-mapping.c b/drivers/dma-buf/st-dma-ma=
pping.c
> new file mode 100644
> index 0000000000000..9d0f1e389e15e
> --- /dev/null
> +++ b/drivers/dma-buf/st-dma-mapping.c
> @@ -0,0 +1,385 @@

[ ... ]

> +static void test_match_fail(struct kunit *test)
> +{
> +	struct dma_buf_mapping_match matches[] =3D { { .type =3D &mock_type_a }=
 };
> +	struct dma_buf_mapping_match exp[] =3D { { .type =3D &mock_type_b } };
> +	struct dma_buf_attachment attach =3D {};
> +	struct dma_buf_match_args args =3D {
> +		.attach =3D &attach,
> +		.imp_matches =3D matches,
> +		.imp_len =3D ARRAY_SIZE(matches),
> +	};
> +
> +	/* Zero-length exporter array returns -EINVAL */
> +	KUNIT_EXPECT_EQ(test, dma_buf_match_mapping(&args, NULL, 0), -EINVAL);
> +	KUNIT_EXPECT_FALSE(test, mock_match_called);
> +	KUNIT_EXPECT_FALSE(test, mock_finish_called);
> +
> +	/* Zero-length importer array returns -EINVAL */
> +	args =3D (struct dma_buf_match_args){ .attach =3D &attach };
> +	KUNIT_EXPECT_EQ(test,
> +			dma_buf_match_mapping(&args, matches,
> +					      ARRAY_SIZE(matches)),
> +			-EINVAL);
> +	KUNIT_EXPECT_FALSE(test, mock_match_called);
> +	KUNIT_EXPECT_FALSE(test, mock_finish_called);
> +
> +	/* Different types produce no match */
> +	KUNIT_EXPECT_EQ(test,
> +			dma_buf_match_mapping(&args, exp, ARRAY_SIZE(exp)),
> +			-EINVAL);
> +	KUNIT_EXPECT_FALSE(test, mock_match_called);
> +	KUNIT_EXPECT_FALSE(test, mock_finish_called);
> +}

[Severity: Medium]
In drivers/dma-buf/st-dma-mapping.c, test_match_fail() overwrites args with:

	args =3D (struct dma_buf_match_args){ .attach =3D &attach };

for the zero-length importer array check, which zeroes args.imp_matches and
args.imp_len.

When the subsequent "Different types produce no match" check calls
dma_buf_match_mapping(&args, exp, ARRAY_SIZE(exp)), args.imp_matches is sti=
ll
NULL and args.imp_len is still 0. In drivers/dma-buf/dma-buf-mapping.c,
dma_buf_match_mapping() computes imp_end =3D args->imp_matches + args->imp_=
len,
so imp =3D=3D imp_end on entry to the inner loop:

	for (; exp !=3D exp_end; exp++) {
		const struct dma_buf_mapping_match *imp =3D args->imp_matches;

		for (; imp !=3D imp_end; imp++) {
			if (exp->type !=3D imp->type)
				continue;

Doesn't this bypass the exp->type !=3D imp->type comparison and just re-tes=
t a
zero-length importer array instead of testing mismatched types? Should
args.imp_matches and args.imp_len be restored to matches and
ARRAY_SIZE(matches) before the third dma_buf_match_mapping() call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026053623.2026=
42-1-apopple@nvidia.com?part=3D25

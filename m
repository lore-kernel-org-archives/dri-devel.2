Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C80606A328
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsPH6VwS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC3C1129B7;
	Fri, 23 Oct 2026 07:16:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC1A1129B7
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:16:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C99FD6053A;
 Fri, 23 Oct 2026 07:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF41F01825;
 Fri, 23 Oct 2026 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792739766;
 bh=I/q0+xX510Kbc0iTYGAUr8eb1ZlB2bi7zM6xNgSVHBk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZsPH6VwSRsFtk3iaALme4YifBNN6weDKKPT2URmbA53uAs2Ci6vNdDZsaBxtN6J4J
 VjxDCV4EzwSN+pPGXlXTBE/D3/nKRwdlzzRk/qZockFPSxbaq+cP5wrxI7oNnx6rRE
 ZlY6pio6kwkOjmgSckVA+1xAbXVRigcV+QaQq+VZ2V6L8JqzCPy71qYzdXZV7oG06R
 hkSB5oaZsKlMJmjC/7LXf+3qzdSdM3BscJsDTwH3gVf67DQnsT8/szlfLVsXzy27Mr
 7F9EUEKpWlxnDhgRcjkSTcAshv0d26xmeYBpoVSbLq9H//UlDveNWoSP0geugEIwci
 dAoQZRTF4P6eA==
Message-ID: <sashiko-outbox-182396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/16] accel/thames: Add support for submitting DMA
 operations
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261023-thames-v3-8-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-8-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:16:05 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] accel/thames: destination bounds bypass in thames_transfer_tra=
nslate()
- [High] accel/thames: premature table publication in thames_transfers_buil=
d()
- [High] accel/thames: use-after-free of transfer_table_pool_map after unbi=
nd
--

commit 46b1c4034d8528dbd324d7c61cb1cf6deecdf877
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

accel/thames: Add support for submitting DMA operations

This commit adds support for validating, translating, and writing C7x DRU D=
MA
transfer records into an IPC transfer table pool so jobs can perform
asynchronous DMA copies between context BOs and L2 apertures.

> diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/tha=
mes_drv.c
> index a17e7a90f7c1d..030c60963a0a8 100644
> --- a/drivers/accel/thames/thames_drv.c
> +++ b/drivers/accel/thames/thames_drv.c

[ ... ]

> @@ -269,6 +272,10 @@ static struct thames_device *thames_device_init(stru=
ct platform_device *pdev,
>  	if (err)
>  		return ERR_PTR(err);
> =20
> +	err =3D drmm_mutex_init(&tdev->ddev, &tdev->transfer_table_pool_lock);
> +	if (err)
> +		return ERR_PTR(err);
> +
>  	err =3D drmm_mutex_init(&tdev->ddev, &tdev->asid_lock);
>  	if (err)
>  		return ERR_PTR(err);
> @@ -281,6 +288,7 @@ static struct thames_device *thames_device_init(struc=
t platform_device *pdev,
>  	if (err)
>  		return ERR_PTR(err);
> =20
> +	INIT_LIST_HEAD(&tdev->transfer_tables);
>  	INIT_LIST_HEAD(&tdev->contexts);
> =20
>  	tdev->asid_next =3D 1;
> @@ -349,6 +357,15 @@ static int thames_platform_probe(struct platform_dev=
ice *pdev)
>  		goto err_fini_dev;
>  	}
> =20
> +	tdev->transfer_table_pool_map =3D
> +		devm_bitmap_zalloc(&pdev->dev,
> +				   tdev->caps.transfer_table_pool_size / THAMES_ABI_LINE_SIZE,
> +				   GFP_KERNEL);
> +	if (!tdev->transfer_table_pool_map) {
> +		err =3D -ENOMEM;
> +		goto err_fini_cores;
> +	}

[Severity: High]
Can allocating tdev->transfer_table_pool_map with devm_bitmap_zalloc() on
&pdev->dev in thames_platform_probe() cause a use-after-free in
thames_transfers_free() if a job is freed after the platform driver unbinds?

In drivers/accel/thames/thames_drv.c, thames_device_init() allocates tdev w=
ith
devm_drm_dev_alloc() and initializes tdev->transfer_table_pool_lock with
drmm_mutex_init(&tdev->ddev, ...) so that client buffers and jobs can clean=
 up
after driver unbind.

However, devm_bitmap_zalloc(&pdev->dev, ...) ties the lifetime of
tdev->transfer_table_pool_map to the platform device binding rather than to
tdev->ddev. If the platform device is unbound while a DRM file or deferred =
job
cleanup outlives thames_platform_remove(), devres releases
tdev->transfer_table_pool_map while tdev->ddev is still alive. When the job=
 is
subsequently freed:

  thames_sched_job_free()
    -> thames_job_free()
      -> thames_transfers_free()

thames_transfers_free() in drivers/accel/thames/thames_transfers.c acquires
tdev->transfer_table_pool_lock and calls bitmap_clear() on the already-freed
tdev->transfer_table_pool_map:

	scoped_guard(mutex, &tdev->transfer_table_pool_lock) {
		bitmap_clear(tdev->transfer_table_pool_map, table->offset / THAMES_ABI_LI=
NE_SIZE,
			     table->size / THAMES_ABI_LINE_SIZE);
		list_del(&table->node);
	}

Should tdev->transfer_table_pool_map be managed by drmm (or freed in
thames_device_release()) so its lifetime matches tdev->ddev and
tdev->transfer_table_pool_lock?

> diff --git a/drivers/accel/thames/thames_transfers.c b/drivers/accel/tham=
es/thames_transfers.c
> new file mode 100644
> index 0000000000000..aad4542d5cb95
> --- /dev/null
> +++ b/drivers/accel/thames/thames_transfers.c

[ ... ]

> +static int thames_transfer_translate(struct thames_file_priv *file_priv,
> +				     const struct drm_thames_transfer *t,
> +				     struct thames_transfer_table *table,
> +				     struct thames_transfer *out)
> +{
> +	const u32 *w =3D t->words;
> +	u32 icnt[4], dicnt[4];
> +	s32 dim[4] =3D { 0 }, ddim[4] =3D { 0 };
> +	u64 src, dst, start, end, bytes, dbytes, addr;
> +	int ret;
> +
> +	if (!thames_transfer_flags_ok(w[TR_FLAGS]) || w[TR_FMTFLAGS])
> +		return -EINVAL;
> +
> +	icnt[0] =3D w[TR_ICNT01] & 0xffff;
> +	icnt[1] =3D w[TR_ICNT01] >> 16;
> +	icnt[2] =3D w[TR_ICNT23] & 0xffff;
> +	icnt[3] =3D w[TR_ICNT23] >> 16;
> +	dim[1] =3D w[TR_DIM1];
> +	dim[2] =3D w[TR_DIM2];
> +	dim[3] =3D w[TR_DIM3];
> +	src =3D (u64)w[TR_ADDR_HI] << 32 | w[TR_ADDR_LO];
> +
> +	dicnt[0] =3D w[TR_DICNT01] & 0xffff;
> +	dicnt[1] =3D w[TR_DICNT01] >> 16;
> +	dicnt[2] =3D w[TR_DICNT23] & 0xffff;
> +	dicnt[3] =3D w[TR_DICNT23] >> 16;
> +	ddim[1] =3D w[TR_DDIM1];
> +	ddim[2] =3D w[TR_DDIM2];
> +	ddim[3] =3D w[TR_DDIM3];
> +	dst =3D (u64)w[TR_DADDR_HI] << 32 | w[TR_DADDR_LO];
> +
> +	memcpy(out->record.words, w, sizeof(out->record.words));
> +	out->channel =3D t->channel;
> +
> +	ret =3D thames_transfer_span(src, icnt, dim, &start, &end, &bytes);
> +	if (ret)
> +		return ret;
> +	ret =3D thames_transfer_side(file_priv, start, end, false, table, &out-=
>side[0], &addr);
> +	if (ret)
> +		return ret;
> +	addr +=3D src - start;
> +	out->record.words[TR_ADDR_LO] =3D lower_32_bits(addr);
> +	out->record.words[TR_ADDR_HI] =3D upper_32_bits(addr);
> +
> +	ret =3D thames_transfer_span(dst, dicnt, ddim, &start, &end, &dbytes);
> +	if (ret)
> +		return ret;
> +	if (dbytes !=3D bytes)
> +		return -EINVAL;
> +	ret =3D thames_transfer_side(file_priv, start, end, true, table, &out->=
side[1], &addr);

[Severity: Critical]
In drivers/accel/thames/thames_transfers.c, does computing the destination
span in thames_transfer_translate() from dicnt[] (words TR_DICNT01 and
TR_DICNT23) instead of icnt[] allow a Type 8 transfer record to bypass
destination BO bounds checking?

THAMES_TRANSFER_TYPES in drivers/accel/thames/thames_transfers.h is BIT(8),=
 so
thames_transfer_flags_ok() only accepts Type 8 (4D block move without
repacking). In the K3 DRU transfer record format (SPRUIL1D 10.4.3.3), words=
 14
and 15 (DICNT0..3) are only used by repacking transfer types such as Type 9
and Type 15 (which the UAPI comment on struct drm_thames_transfer in
include/uapi/drm/thames_accel.h references via Table 10-63). For Type 8, wo=
rds
14 and 15 are reserved and the DRU uses ICNT0..3 for both source and
destination loop iterations while stepping the destination address by
DDIM1..3.

Because thames_transfer_translate() passes dicnt[] to thames_transfer_span()
and only checks that dbytes =3D=3D bytes, a client can submit a Type 8 reco=
rd with
icnt =3D { 1, N, 1, 1 } (for N > 1), dicnt =3D { N, 1, 1, 1 }, and an arbit=
rary
ddim[1] stride. In that case:

1. thames_transfer_span() calculates (dicnt[1] - 1) * ddim[1] =3D=3D 0 and
   validates only [dst, dst + N) against the destination mapping.
2. The DRU executes ICNT1 =3D N iterations using DDIM1 and writes to physic=
al
   addresses dst + i * ddim[1] outside the validated BO.
3. Conversely, a Type 8 record with reserved words 14 and 15 set to zero is
   rejected with -EINVAL because dicnt[0] is zero.

For Type 8 records, should thames_transfer_translate() require w[TR_DICNT01]
and w[TR_DICNT23] to be zero and pass icnt[] to thames_transfer_span() when
computing the destination span?

[ ... ]

> +static int thames_transfers_alloc_table(struct thames_device *tdev,
> +					struct thames_transfer_table *table)
> +{
> +	const unsigned long lines =3D tdev->caps.transfer_table_pool_size / THA=
MES_ABI_LINE_SIZE;
> +	unsigned long start, nr =3D table->size / THAMES_ABI_LINE_SIZE;
> +
> +	guard(mutex)(&tdev->transfer_table_pool_lock);
> +
> +	start =3D bitmap_find_next_zero_area(tdev->transfer_table_pool_map, lin=
es, 0, nr, 0);
> +	if (start + nr > lines)
> +		return -ENOSPC;
> +
> +	bitmap_set(tdev->transfer_table_pool_map, start, nr);
> +	table->offset =3D start * THAMES_ABI_LINE_SIZE;
> +	list_add_tail(&table->node, &tdev->transfer_tables);
> +	return 0;
> +}

[ ... ]

> +	table->count =3D transfers->count;
> +	table->size =3D THAMES_TRANSFER_TABLE_SIZE(table->count, table->group_c=
ount);
> +
> +	ret =3D thames_transfers_alloc_table(tdev, table);
> +	if (ret) {
> +		table->size =3D 0;
> +		goto err_free;
> +	}
> +
> +	table->records =3D out;
> +	table->group_counts =3D group_counts;
> +
> +	for (i =3D 0; i < tdev->num_cores; i++)
> +		thames_transfers_write_table(&tdev->cores[i], table);

[Severity: High]
What happens if thames_core_resume() calls thames_transfers_rewrite()
concurrently with thames_transfers_build() right after
thames_transfers_alloc_table() releases tdev->transfer_table_pool_lock?

In drivers/accel/thames/thames_transfers.c, thames_transfers_alloc_table()
adds table->node to tdev->transfer_tables and drops
tdev->transfer_table_pool_lock before thames_transfers_build() sets
table->records =3D out and table->group_counts =3D group_counts:

CPU 0                                   CPU 1
thames_transfers_build()
  thames_transfers_alloc_table()
    guard(mutex)(&tdev->transfer_table_pool_lock);
    list_add_tail(&table->node, &tdev->transfer_tables);
    /* unlocks transfer_table_pool_lock */
                                        thames_core_resume()
                                          thames_transfers_rewrite()
                                            guard(mutex)(&tdev->transfer_ta=
ble_pool_lock);
                                            thames_transfers_write_table(co=
re, table)
                                              /* dereferences NULL table->r=
ecords
                                               * and table->group_counts */
  table->records =3D out;
  table->group_counts =3D group_counts;

Should table->records and table->group_counts be populated before adding the
table to tdev->transfer_tables (and the initial thames_transfers_write_tabl=
e()
calls performed under tdev->transfer_table_pool_lock)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-thames-v3-=
0-3ab40aa17157@tomeuvizoso.net?part=3D8

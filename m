Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DB60A2637
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZPSsJLM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8420E10E8BF;
	Wed, 18 Nov 2026 23:51:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CC210E8BF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:51:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 086E764322;
 Wed, 18 Nov 2026 23:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9722D1F000C4;
 Wed, 18 Nov 2026 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045874;
 bh=9FzNeLbTX9tvFD43RI0R/jcifGeu12plDsOqqoxQs08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lZPSsJLMojYlugTHsfA8AGZbUr4kXEzxDyTeygKt1QSwGalPANaRXnuBbn4/6onE6
 Iv6Ldkiqdhmae4Y38wLsZ5oTlkjEaUJWqe8GTfszsC8mIgyamZu7feiu5j/7YUfXKX
 GoIBLSIPTV5jK6tUoovrUA7vi0+LvnTe3C0bIjK12AWjpu9y+Kx84Sh1VYRt6ilbkK
 bIhMNARasIZxwhOGRaQU3GazjbdPA9djy9M3DXaAuWthjrJ/FHSYlwyGW/UTGKvOLk
 HAzj6K5nXOtdA+jdStvL4m1I+U4IqziPPgXQZMwK4LD7Luz7Ne6wmrphYs4JBdKdzp
 MJ5Lxg4NMEhHQ==
Message-ID: <sashiko-outbox-222217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] accel/amd-ai-engine: Add reset operations
To: "Gregory Williams" <gregory.williams@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118233211.4121361-16-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
 <20261118233211.4121361-16-gregory.williams@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:51:14 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] accel/amd-ai-engine: unflushed pm_ops on error in
  aiemlv2_part_init()
- [Medium] accel/amd-ai-engine: unchecked 2-column NMU range in
  aiemlv2_part_init()
- [Low] accel/amd-ai-engine: open-coded polling in
  aie_part_maskpoll_register()
--

commit 7ceb805ff0b7740b5882eeff9e935665efc44bc8
Author: Gregory Williams <gregory.williams@amd.com>

accel/amd-ai-engine: Add reset operations

This commit adds partition initialization and teardown callbacks for AI
Engine partitions, configuring resets, memory zeroization, NMU routing,
ECC scrubbing, error reporting, and tile clocks.

> diff --git a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c b/drivers/ac=
cel/amd-ai-engine/ai-engine-aiemlv2.c
> index 26dd1d726bfad..910a9bda23055 100644
> --- a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
> +++ b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c

[ ... ]

> @@ -173,10 +177,250 @@ static int aiemlv2_set_part_clocks(struct aie_part=
ition *apart)

[ ... ]

> +static int aiemlv2_part_init(struct aie_partition *apart,
> +			     struct aie_partition_init_args *args)
> +{
> +	u32 opts;
> +	int ret;

[ ... ]

> +	if (args->init_opts & AIE_PART_INIT_OPT_NMU_CONFIG) {
> +		struct aie_range range =3D {0};
> +
> +		opts |=3D AIE_PART_INIT_OPT_NMU_CONFIG;
> +		if (apart->range.start.col =3D=3D 0) {
> +			range.size.col =3D 2;
> +			ret =3D aie_part_pm_ops(apart, NULL, AIE_PART_INIT_OPT_NMU_CONFIG,
> +					      range, 0);
> +			if (ret)
> +				goto out;
> +		}
> +	}

[Severity: Medium]
Can this configure column 1 outside the partition's allocated columns?
If a 1-column partition is requested at column 0 (apart->range.start.col
=3D=3D 0, apart->range.size.col =3D=3D 1), setting range.size.col =3D 2 wit=
hout
checking apart->range.size.col >=3D 2 programs NMU routing on column 1 as
well, which may belong to another partition.

> +
> +	if (args->init_opts & AIE_PART_INIT_OPT_HW_ERR_INT) {
> +		u16 data =3D 0;
> +
> +		opts |=3D AIE_PART_INIT_OPT_HW_ERR_INT;
> +		ret =3D aie_part_pm_ops(apart, &data, AIE_PART_INIT_OPT_HW_ERR_INT,
> +				      apart->range, 0);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (args->init_opts & AIE_PART_INIT_OPT_HW_ERR_MASK) {
> +		u16 data =3D 0x2;
> +
> +		opts |=3D AIE_PART_INIT_OPT_HW_ERR_MASK;
> +		ret =3D aie_part_pm_ops(apart, &data, AIE_PART_INIT_OPT_HW_ERR_MASK,
> +				      apart->range, 0);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (args->init_opts & AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD) {
> +		u16 data;
> +
> +		if (args->ecc_scrub > U16_MAX) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		data =3D args->ecc_scrub;
> +		opts |=3D AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD;
> +		ret =3D aie_part_pm_ops(apart, &data,
> +				      AIE_PART_INIT_OPT_SET_ECC_SCRUB_PERIOD,
> +				      apart->range, 0);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (args->init_opts & AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV) {
> +		opts |=3D AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV;
> +
> +		ret =3D aie_part_pm_ops(apart, NULL, AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV,
> +				      apart->range, 0);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* Request tile locations */
> +	ret =3D aie_part_request_tiles(apart, args->num_tiles, args->locs);
> +	if (ret)
> +		goto out;
> +
> +	if (args->init_opts & AIE_PART_INIT_OPT_DIS_TLAST_ERROR) {
> +		u16 data =3D 0;
> +
> +		opts |=3D AIE_PART_INIT_OPT_DIS_TLAST_ERROR;
> +		ret =3D aie_part_pm_ops(apart, &data,
> +				      AIE_PART_INIT_OPT_DIS_TLAST_ERROR,
> +				      apart->range, 1);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (opts !=3D args->init_opts)
> +		dev_warn(&apart->dev, "Invalid init_opts: 0x%x\n", opts ^ args->init_o=
pts);
> +
> +out:
> +	mutex_unlock(&apart->mlock);
> +	return ret;
> +}

[Severity: Medium]
Does the error path leave unflushed commands queued in apart->pm_ops?

The operations from AIE_PART_INIT_OPT_NMU_CONFIG through
AIE_PART_INIT_OPT_UC_ENB_MEM_PRIV are queued with flush =3D 0 and rely on
aie_part_request_tiles() -> aiemlv2_set_part_clocks() ->
aie_part_pm_ops_flush() to flush and reset the buffer.  If args->ecc_scrub
> U16_MAX or aie_part_request_tiles() fails (for example, when
args->num_tiles > 0 and args->locs is NULL), jumping to out leaves those
descriptors in apart->pm_ops.pkt_va, so they will be sent to firmware
ahead of the DMA pause operations on the next initialize or teardown call.

Validating args before modifying hardware state and resetting
apart->pm_ops on failure would avoid both the stale command buffer and
leaving the partition partially reset on -EINVAL.

> diff --git a/drivers/accel/amd-ai-engine/ai-engine-part.c b/drivers/accel=
/amd-ai-engine/ai-engine-part.c
> index 35451d1ed88a4..2cd93c02246e5 100644
> --- a/drivers/accel/amd-ai-engine/ai-engine-part.c
> +++ b/drivers/accel/amd-ai-engine/ai-engine-part.c

[ ... ]

> @@ -106,3 +107,34 @@ struct aie_partition *aie_part_create(struct aie_dev=
ice *adev,
>  	device_unregister(&apart->dev);
>  	return ERR_PTR(ret);
>  }
> +
> +/**
> + * aie_part_maskpoll_register() - Mask polls an address for a data in a =
partition.
> + * @apart: AI engine partition.
> + * @offset: AI engine register offset.
> + * @data: data to poll.
> + * @mask: if it is non 0, it is mask read.
> + * @timeout: Timeout in microseconds.
> + *
> + * Return: zero for success, or -EBUSY for failure
> + */
> +int aie_part_maskpoll_register(struct aie_partition *apart, u32 offset, =
u32 data,
> +			       u32 mask, u32 timeout)
> +{
> +	u32 usleep_time =3D 10;
> +	u32 value;
> +	u32 i;
> +
> +	for (i =3D 0; i < timeout; i +=3D usleep_time) {
> +		value =3D readl(apart->adev->base + offset);
> +		if ((value & mask) =3D=3D data)
> +			return 0;
> +		usleep_range(usleep_time, usleep_time + 10);
> +	}
> +
> +	value =3D readl(apart->adev->base + offset);
> +	if ((value & mask) =3D=3D data)
> +		return 0;
> +
> +	return -EBUSY;
> +}

[Severity: Low]
Can this use readl_poll_timeout() from linux/iopoll.h instead of an
open-coded loop?  Advancing i by 10 us per iteration while calling
usleep_range(10, 20) does not account for sleeps up to 20 us or scheduler
wakeup overhead, so a 2000000 us timeout can block for much longer than 2
seconds per column while holding apart->mlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118233211.4121=
361-1-gregory.williams@amd.com?part=3D15

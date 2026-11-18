Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DF606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOlvp1jA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8391D10ECE6;
	Wed, 18 Nov 2026 23:46:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF99210ECE7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:46:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99E4E43772;
 Wed, 18 Nov 2026 23:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562971F000C5;
 Wed, 18 Nov 2026 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045599;
 bh=E7EoscQ8NNxdCdmjdhVVaNgCM3N3qjsFw/VwaEOvtYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NOlvp1jAYgNM8uAwwOjQyuuprBWKjJ9WAKvG4JQPy9yeokJbcQHD/hPUsTlox2ZEf
 RvTiZOhx2cntHTqkQNFqrhfe0EsEIki/ORGnHOJTm2XMPMnGkY42G+A/PaURdQH7jm
 IvPca19tv4xupH9bkRkAmzaT5qbgdpu1F8/XgUD06EMWVFG6+FvsonHcrjb03LfHFX
 jG9niOaYIOEG9m+rTrQ1gRdTGcvOuGl6nDjc7U5/vjmapDBhFdHZxszUkq166I5jZr
 HfQxSv5MHAnCtsSJgQaRGnT7IEmVsNb3VPcqeVCyMHbAh6ltiALXtotSqqfoz9y0MX
 UK4XRdAsId2RQ==
Message-ID: <sashiko-outbox-222211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] accel/amd-ai-engine: Add pm ops for firmware calls
To: "Gregory Williams" <gregory.williams@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118233211.4121361-14-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
 <20261118233211.4121361-14-gregory.williams@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:46:38 +0000
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
- [Medium] accel/amd-ai-engine: spurious goto again after flush in
  aie_part_pm_ops()
- [Low] accel/amd-ai-engine: missing @loc kernel-doc in
  aie_op_handshake_data
- [Low] accel/amd-ai-engine: 32-bit shift overflow on dma_addr_t in
  aie_part_pm_ops()
--

commit d2e06ea50ba27d65c500c4af65cd1c3eb56d05cf
Author: Gregory Williams <gregory.williams@amd.com>

accel/amd-ai-engine: Add pm ops for firmware calls

This commit adds platform management operation structures and helpers to
pack and flush privileged AI Engine register operations to trusted
firmware via coherent DMA buffers.

> diff --git a/drivers/accel/amd-ai-engine/ai-engine-pm.c b/drivers/accel/a=
md-ai-engine/ai-engine-pm.c
> new file mode 100644
> index 0000000000000..103879456f520
> --- /dev/null
> +++ b/drivers/accel/amd-ai-engine/ai-engine-pm.c
> @@ -0,0 +1,472 @@

[ ... ]

> +int aie_part_pm_ops(struct aie_partition *apart, void *data, u32 type,
> +		    struct aie_range range, bool flush)
> +{
> +	struct aie_pm_ops *pm_ops =3D &apart->pm_ops;
> +	struct aie_op_start_num_col *op_range;
> +	ssize_t end;
> +	int ret =3D 0;
> +
> +again:
> +	op_range =3D pm_ops->op_range;
> +	if (!op_range ||
> +	    op_range->num_col !=3D range.size.col ||
> +	    op_range->start_col !=3D range.start.col) {
> +		if (check_add_overflow(pm_ops->offset, sizeof(*op_range), &end) ||
> +		    end >=3D pm_ops->size) {
> +			ret =3D aie_part_pm_ops_flush(apart);
> +			if (ret)
> +				return ret;
> +		}
> +		pm_ops->op_range =3D pm_ops->pkt_va + pm_ops->offset;
> +		pm_ops->offset +=3D sizeof(*pm_ops->op_range);
> +		op_range =3D pm_ops->op_range;
> +		op_range->type =3D XILINX_AIE_OPS_START_NUM_COL;
> +		op_range->start_col =3D range.start.col;
> +		op_range->num_col =3D range.size.col;
> +		op_range->len =3D sizeof(*op_range);
> +	}

[ ... ]

> +	if (type & AIE_PART_INIT_OPT_HW_ERR_STS) {
> +		struct aie_op_hw_err *op;
> +
> +		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
> +		    end >=3D pm_ops->size) {
> +			ret =3D aie_part_pm_ops_flush(apart);
> +			if (ret)
> +				return ret;
> +			goto again;
> +		}
> +		type &=3D ~AIE_PART_INIT_OPT_HW_ERR_STS;
> +		op =3D pm_ops->pkt_va + pm_ops->offset;
> +		pm_ops->offset +=3D sizeof(*op);
> +		op->type =3D XILINX_AIE_OPS_CLR_HW_ERR_STS;
> +		op->len =3D sizeof(*op);
> +		op->val =3D *((u16 *)data);
> +		ret =3D aie_part_pm_ops_flush(apart);
> +		if (ret)
> +			return ret;
> +		goto again;
> +	}
> +	if (type & AIE_PART_INIT_OPT_DIS_TLAST_ERROR) {
> +		struct aie_op_tlast *op;
> +
> +		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
> +		    end >=3D pm_ops->size) {
> +			ret =3D aie_part_pm_ops_flush(apart);
> +			if (ret)
> +				return ret;
> +			goto again;
> +		}
> +		type &=3D ~AIE_PART_INIT_OPT_DIS_TLAST_ERROR;
> +		op =3D pm_ops->pkt_va + pm_ops->offset;
> +		pm_ops->offset +=3D sizeof(*op);
> +		op->type =3D XILINX_AIE_OPS_CTRL_PKT_TLAST_ERR;
> +		op->len =3D sizeof(*op);
> +		op->state =3D *((u16 *)data);
> +	}
> +	if (type & AIE_PART_INIT_OPT_HANDSHAKE) {
> +		struct aie_op_handshake *op;
> +		struct aie_op_handshake_addr *hs_addr =3D data;
> +
> +		if (check_add_overflow(pm_ops->offset, sizeof(*op), &end) ||
> +		    end >=3D pm_ops->size) {
> +			ret =3D aie_part_pm_ops_flush(apart);
> +			if (ret)
> +				return ret;
> +			goto again;
> +		}
> +
> +		type &=3D ~AIE_PART_INIT_OPT_HANDSHAKE;
> +		op =3D pm_ops->pkt_va + pm_ops->offset;
> +		pm_ops->offset +=3D sizeof(*op);
> +		op->type =3D XILINX_AIE_OPS_HANDSHAKE;
> +		op->len =3D sizeof(*op) + hs_addr->size;
> +		op->offset =3D hs_addr->offset;
> +		op->low_addr =3D hs_addr->hs_dma & 0xFFFFFFFFULL;
> +		op->high_addr =3D hs_addr->hs_dma >> 32;

[Severity: Low]
Can shifting hs_addr->hs_dma by 32 bits trigger a -Wshift-count-overflow
warning on 32-bit COMPILE_TEST builds?

hs_dma has type dma_addr_t, which is 32 bits wide when
CONFIG_ARCH_DMA_ADDR_T_64BIT is disabled.  Using lower_32_bits() and
upper_32_bits() as in aie_part_pm_ops_flush() avoids the shift overflow.

> +		if (flush)
> +			ret =3D aie_part_pm_ops_flush(apart);
> +
> +		if (ret)
> +			return ret;
> +		goto again;
> +	}
> +
> +	if (type)
> +		dev_warn(&apart->dev, "Unknown ops type: 0x%x\n", type);
> +
> +	if (flush)
> +		ret =3D aie_part_pm_ops_flush(apart);
> +
> +	return ret;
> +}

[Severity: Medium]
Why do the AIE_PART_INIT_OPT_HW_ERR_STS and AIE_PART_INIT_OPT_HANDSHAKE
branches flush and jump back to again after queuing their operation?

Jumping to again after aie_part_pm_ops_flush() resets pm_ops->op_range to
NULL causes a new XILINX_AIE_OPS_START_NUM_COL range header to be written
into pm_ops->pkt_va even when no bits remain in type.  When flush is
true, the function then flushes a second time at the end; when flush is
false with AIE_PART_INIT_OPT_HW_ERR_STS (which also ignores the flush
parameter), an empty range header is left in pm_ops->pkt_va and will not
be stripped by aie_part_pm_ops_flush() if the next call uses a different
column range.

> diff --git a/include/linux/amd-ai-engine.h b/include/linux/amd-ai-engine.h
> index f5750d219e211..9df3463985afd 100644
> --- a/include/linux/amd-ai-engine.h
> +++ b/include/linux/amd-ai-engine.h

[ ... ]

> +/**
> + * struct aie_op_handshake_data - AI engine uc handshake region informat=
ion
> + * @addr: handshake data address from where the data needs to be copied.
> + * @size: handshake data size.
> + * @offset: offset for handshake region update.
> + */
> +struct aie_op_handshake_data {
> +	void *addr;
> +	size_t size;
> +	size_t offset;
> +	struct aie_location loc;
> +};

[Severity: Low]
The kernel-doc comment for struct aie_op_handshake_data is missing an
entry for @loc, which will trigger a kernel-doc warning under W=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118233211.4121=
361-1-gregory.williams@amd.com?part=3D13

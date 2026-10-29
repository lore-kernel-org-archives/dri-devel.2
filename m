Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLHfQ+BR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6D61123D5;
	Thu, 29 Oct 2026 15:32:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DE51123D5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:32:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A49CA41825
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6189F1F01816;
 Thu, 29 Oct 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793287927;
 bh=GQaIeYELVZoFgCm7oajK9Ic1HDc4Wh3eeoO0zc4suSs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KLHfQ+BRar5MOXuSFWw3NzpkF+/6hJREqfA8EpmuzjlKsUCIK6klS9lgx6iVj3qBC
 QfrrsDGd0v3FnpjcdILI8bCl7/7AI3f+3E3cIhR9HlPDig4B0xOAX/KkbLNM85kYv5
 kAwGzyMRsTkvp0POR2xLNqVlJyil6G3jOyy7cYeyDd0e/r2rMW7UjhS9VE5OomgCgN
 RjoAPyOeJJy/sNQb8Q1uqunY1QYD1IOSbOyA8G7zGFYunnFxB/Bjydf62i39fUAFVn
 oafwckpIS54dgfhzoSbOqWTEdNWKKbZcRq6AwIyGAZvhDk/aZAHCRbpi7GGJujIx4G
 YXqpRvcmpn/Bw==
Message-ID: <sashiko-outbox-189611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 26/31] accel: ethosu: Split U65 and U85 DMA length
 validation
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-26-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-26-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:32:06 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] accel: ethosu: missing size0/size1 scaling for 1D side in mixed-mo=
de DMA
--

commit 186c2e0ed128e4d62938b05418f963aa19e82266
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Split U65 and U85 DMA length validation

This commit splits DMA length validation in the Ethos-U driver into separate
functions for U65 and U85 to account for their different stride and skip
models. It also updates the command stream validator to populate shared U65
strides and sign-extended U85 strides for source and destination DMA.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 117046e5a61f8..04c0de8336cd1 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -245,40 +245,97 @@ static bool dma_params_valid(struct ethosu_device *=
edev, struct cmd_state *st,
>  	return true;
>  }
> =20
> -static u64 dma_length(struct ethosu_device *edev,
> -		      struct ethosu_validated_cmdstream_info *info,
> -		      struct cmd_state *st, struct dma_state *dma_st,
> -		      struct dma *dma, u16 region_cmd, u16 addr_cmd)
> +static u64 dma_length_finish(struct ethosu_validated_cmdstream_info *inf=
o,
> +			     const struct dma *dma, u64 len)
> +{
> +	if (dma->region >=3D 0) {
> +		u64 end;
> +
> +		if (check_add_overflow(len, dma->offset, &end))
> +			return U64_MAX;
> +		info->region_size[dma->region] =3D
> +			max(info->region_size[dma->region], end);
> +	}
> +
> +	return len;
> +}
> +
> +static u64 dma_length_u65(struct ethosu_validated_cmdstream_info *info,
> +			  struct dma_state *dma_st,
> +			  struct dma *dma)
>  {
>  	s8 mode =3D dma->mode;
>  	u64 len =3D dma->len;
> +	u64 stride;
> =20
> -	if (!dma_params_valid(edev, st, dma_st, dma, region_cmd, addr_cmd))
> -		return U64_MAX;
> +	if (mode >=3D 1) {
> +		if (check_mul_overflow(len, (u64)dma_st->size0, &len) ||
> +		    check_mul_overflow((u64)dma->stride[0],
> +				       (u64)dma_st->size0 - 1, &stride) ||
> +		    check_add_overflow(len, stride, &len))
> +			return U64_MAX;
> +	}
> +	if (mode =3D=3D 2) {
> +		if (check_mul_overflow(len, (u64)dma_st->size1, &len) ||
> +		    check_mul_overflow((u64)dma->stride[1],
> +				       (u64)dma_st->size1 - 1, &stride) ||
> +		    check_add_overflow(len, stride, &len))
> +			return U64_MAX;
> +	}
> +
> +	return dma_length_finish(info, dma, len);
> +}
> +
> +static u64 dma_length_u85(struct ethosu_validated_cmdstream_info *info,
> +			  struct dma_state *dma_st,
> +			  struct dma *dma)
> +{
> +	s8 mode =3D dma->mode;
> +	s64 min =3D 0;
> +	u64 max =3D dma->len;
> +	s64 stride;
> =20
>  	if (mode >=3D 1) {
> -		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
> +		if (check_mul_overflow(dma->stride[0],
> +				       (s64)dma_st->size0 - 1, &stride))
>  			return U64_MAX;
> -		len +=3D dma->stride[0];
> -		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
> +		if (stride < 0) {
> +			if (check_add_overflow(min, stride, &min))
> +				return U64_MAX;
> +		} else if (check_add_overflow(max, (u64)stride, &max)) {
>  			return U64_MAX;
> +		}
>  	}
>  	if (mode =3D=3D 2) {
> -		if (dma->stride[1] < 0 && (u64)(-dma->stride[1]) > len)
> +		if (check_mul_overflow(dma->stride[1],
> +				       (s64)dma_st->size1 - 1, &stride))
>  			return U64_MAX;
> -		len +=3D dma->stride[1];
> -		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
> +		if (stride < 0) {
> +			if (check_add_overflow(min, stride, &min))
> +				return U64_MAX;
> +		} else if (check_add_overflow(max, (u64)stride, &max)) {
>  			return U64_MAX;
> +		}
>  	}
> -	if (dma->region >=3D 0) {
> -		u64 end;
> =20
> -		if (check_add_overflow(len, dma->offset, &end))
> -			return U64_MAX;
> -		info->region_size[dma->region] =3D max(info->region_size[dma->region],=
 end);
> -	}
> +	if (min < 0 && -(u64)min > dma->offset)
> +		return U64_MAX;
> =20
> -	return len;
> +	return dma_length_finish(info, dma, max);
> +}

[Severity: High]
When ethosu_gem_cmdstream_copy_and_validate() handles NPU_OP_DMA_START in
drivers/accel/ethosu/ethosu_gem.c, it validates the source and destination
endpoints independently via dma_length():

		case NPU_OP_DMA_START:
			srclen =3D dma_length(edev, info, &st, &st.dma, &st.dma.src,
					    NPU_SET_DMA0_SRC_REGION, NPU_SET_DMA0_SRC);
			dstlen =3D dma_length(edev, info, &st, &st.dma, &st.dma.dst,
					    NPU_SET_DMA0_DST_REGION, NPU_SET_DMA0_DST);

What happens when a DMA operation uses mixed modes between source and
destination, such as copying between a 1D contiguous buffer (mode =3D=3D 0)=
 and
a 2D or 3D strided buffer (mode =3D=3D 1 or 2)?

On U65 in particular, NPU_SET_DMA0_SRC_STRIDE0 and NPU_SET_DMA0_SRC_STRIDE1
are shared between source and destination, so copying between a contiguous
buffer and a strided buffer requires one side to use mode =3D=3D 0 while the
other uses mode =3D=3D 1 or 2.

Both dma_length_u65() and dma_length_u85() only inspect dma->mode of the
endpoint currently being evaluated. When dma->mode =3D=3D 0 while the other
endpoint has mode >=3D 1, the 1D endpoint's length is left as dma->len (a
single 1D transfer) rather than being scaled by dma_st->size0 (and
dma_st->size1 for 3D) to cover all transfers performed by the DMA engine.

Could this under-compute info->region_size[dma->region] in
dma_length_finish() for the 1D endpoint and allow out-of-bounds DMA reads or
writes past the end of the backing GEM buffer object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D26

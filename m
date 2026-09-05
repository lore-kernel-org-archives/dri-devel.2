Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37593C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A1D10FB74;
	Sat,  5 Sep 2026 01:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VAYmre4p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596CE10FB74
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:05:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24E7443F64
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 01:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45491F00A3D;
 Sat,  5 Sep 2026 01:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788570303;
 bh=zj9pBpoIXIoiql/NH0ybTsBmq2w6tYaRk14U1CjDCAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VAYmre4p/4BlBka1z/+jtzKH8xGzbWgySbnvTctwNEy1LfVJ6VIEZ7jiy5gRr2jKz
 CCoZqLHZl6TKV49RNKseQEliao76g7RX1Cn5MH+tXWEL11HVuqlTd5PdtTvxxhwC6X
 AgpBsoiJcLxbcTBoHMt5kX3UgyNWXKGE5bv0mhm2YliXe8jQpKECX11l8XWOiHIDyu
 rFoWo9ZD3166IzIKtXpimu+8bUVhm0cFvoZRAMPyXNyGPchmy8j+1hJIdJSYi5RMZz
 7wGCA04w0eXNywEFF61rrXeA+XnAnBYO1LG0M7sDEGwCUQJb1ROZQulysLZvXpyaqA
 Xp1gH6cFN8RBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/19] accel: ethosu: Reject unsupported commands
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-9-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-9-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 01:05:02 +0000
Message-Id: <20260905010502.C45491F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability due to DMA-BUF=
 export of command stream BO
- [Medium] Sandbox escape vulnerability due to default-allow validation of =
unknown commands
--

commit d6039ab4982bea39258f6865972e83f60eb4978c
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Reject unsupported commands

The command-stream validator does not model U85 branches, indexed DMA,
or OFM transposes. A branch can bypass the linear validation state,
indexed DMA accesses an unchecked index buffer, and a transpose changes
the feature-map address calculation.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index ec2832eb9a07a..c913c95e48ae0 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -885,18 +896,26 @@ static int ethosu_gem_cmdstream_copy_and_validate(s=
truct drm_device *ddev,
>  			break;
> =20
>  		case NPU_SET_DMA0_SRC_REGION:
> +			if (param & NPU_DMA_REGION_INDEX_MODE)
> +				return -EINVAL;
[ ... ]

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential sandbox escape
vulnerability in this switch statement due to default-allow validation
of unknown commands.

In ethosu_gem_cmdstream_copy_and_validate(), if a future NPU hardware
revision introduces new opcodes that perform memory accesses, the current
driver will blindly allow them without calculating their memory bounds
because of the default case:

        case NPU_SET_DMA0_LEN:
            st.dma.src.len =3D st.dma.dst.len =3D addr;
            break;
        default:
            break;
        }

Can this allow the NPU to execute unvalidated commands and access memory
outside the validated BO regions if such opcodes are introduced?

[Severity: High]
This is also a pre-existing issue, but could this driver be vulnerable to a
Time-of-Check to Time-of-Use (TOCTOU) attack via DMA-BUF export?

In drivers/accel/ethosu/ethosu_gem.c:ethosu_gem_funcs, the .get_sg_table
callback is exposed without overriding the .export callback:

static const struct drm_gem_object_funcs ethosu_gem_funcs =3D {
    .free =3D ethosu_gem_free_object,
    .print_info =3D drm_gem_dma_object_print_info,
    .get_sg_table =3D drm_gem_dma_object_get_sg_table,
    ...
};

This permits the command stream BO to be exported as a DMA-BUF and mapped
by other devices.

Meanwhile, in drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job(),
the job submission blindly trusts the pre-calculated cmd_info (including
region_size) without preventing concurrent modifications to the buffer
contents:

        /* Verify the command stream doesn't have accesses outside the BO */
        if (cmd_info->region_size[i] > gem->size) {
            dev_err(dev->dev,
                "cmd stream region %d size greater than BO size (%llu > %zu=
)\n",
                i, cmd_info->region_size[i], gem->size);
            ret =3D -EOVERFLOW;
            goto out_cleanup_job;
        }

Could a malicious userspace application create a command stream, export it
as a DMA-BUF to another device, and overwrite the command stream with
malicious instructions using the secondary device's DMA capabilities after
validation but before execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D9

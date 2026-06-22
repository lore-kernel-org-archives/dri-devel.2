Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2605CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E73410E8B2;
	Mon, 22 Jun 2026 21:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="A/tkbtBc";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571DD10E8B2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 21:36:59 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c88b8fe9059so1846398a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 14:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782164219; cv=none;
 d=google.com; s=arc-20240605;
 b=NexjRQVhaqhwHRhKAM+U3GSQYIf5wZHPPlzWRxNIrSxUjxoiiPsDvqk1d4Bz3cS0e1
 i+IvUIwRg6dQ9sm3oSs5zcGxWRt3+BSUIKe5MOJ0md2Op6D9Cc590rMu0vDTRsve1B8K
 nsoA9wLgCv/INvv6bSsl8NRQbGK1oOruTiKbN2cdIcVipfBF5LjZasvp9vIGRQbeMgjf
 1JlArHRmVaX66OwtiqcZSP9g/YGNYNHArh3UkJInr/1E4ugH5Tg1whkzBwQXeBuByIev
 X98bQX4lzuR58nFn4JVEWAdlXMLVb/CTIDp2lC343UMtCUHj3Q1EYDBzYRVoNWWKn1Np
 W25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zzUg1BcP9Qnb9ASXav3KcPioO7TxRaczkdT3qjW/Sqo=;
 fh=TtajIdewxLj9gyUJHHT1ccYIMDz3/yfxP4gcQYcRsXA=;
 b=d9dH7PB0ENuT8xs0vwjlEQv27l9PwnFD0FrMj6s3rBFCsjLnRPoPE14DgmoAU55GVH
 oYd5KTIr+wPirvPLK00cS04mVP2T1norxNHpURaMnVef/68ncxiAG0zxLKmvSATp+7qU
 8HESn8+qQrTdyNV0yi9UhQZpZhu2B7YWNbBM+15O1zv+gZHRsZU2pyR1dhYBvkL1a0NI
 niWnde3dIOKqwzPa7DcoFfwcd/0Z9Yrc+kRcy7kV7sMbJVYqe71FIXijwu/R+piG3fsx
 1iPEBNBvTBqMQIx+th0dnGdhdzuzYoEFcIaTPCDaTgNG+UEASFRmKEunrdHvctkBrNoz
 BQwQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1782164219; x=1782769019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzUg1BcP9Qnb9ASXav3KcPioO7TxRaczkdT3qjW/Sqo=;
 b=A/tkbtBcLvfHqAAYm4B0jlRB/uC6Qoua9bNoKt+o8sde7FBfCIQVJAfirgFHvjgv1D
 KqMTqZcHlUlzim8tza3SybfiDwCF4DKcjw+2nySwVz4Nzy6jC78S7eWq3rEVGuPLE/Xa
 V9ZKIBWhd0NX9XpLWEGei6PgNy4ze8ta8agF8vOTcJdyGJcuwHM4CaiT7XGqqrWOH0Tm
 EV4dLMcThpkWsjQ3jFGrydEYAt6owr0VwGUSXzcTlID5uHNAKGAKfmm8OFd2vM5I2dKk
 3Fhir5+IyJq8qAcVn1cbKTA+yOPV+SeYJ02FkZqVqa7FzpSHMNxBNqnV6t8f+HUghGvi
 Nd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782164219; x=1782769019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zzUg1BcP9Qnb9ASXav3KcPioO7TxRaczkdT3qjW/Sqo=;
 b=Bfm4Xo6TTGrb+IRwXI2mKwe81bjgpp3uYATEprH7aYbny1q6rtz6eZSjqxja7Eu5w3
 h+5i8+OJzc94DafYcmDPLvp1WFtSzf83RIwC8X2glJN2+XhlNDBZ+kcVern/nttdudT4
 XUgaAzRaeTamkSzmvxhF62SPfAm8uRvL3EVEcelcdkY3QTNDnPzBrYcBdFNy/uvYOHXe
 aIzwvYzF2r47pkOYELZrE1qsM1WxQbe434qPJN1diQj+ekhwtSgvFtLPrOHcJcqZCq/w
 aUdDLSAzWz/v+lYpZMpoolB0HpLWWd5EciymG9k4RA7xzNLHOvykfT5rctHD6F5cFU34
 71RQ==
X-Gm-Message-State: AOJu0YwDPKDossyH28s6eMj6NeHabf5oaBCpYomlsyE9z2l0f3fwFmIH
 YDUtxUmF+vlN72ZQ4sMCmB3Qo89QlQ1bpp6zWfRN9BvCThuqeFw1WeUSYPb7le1F2BxEDyqJPCq
 zditQ+dXnntBbTGOf7Bc5myKln/o7jbBhDHjFqg9i
X-Gm-Gg: AfdE7cnKm2vRTlrVBjry4rx/voCzpcTFv9S7PE+76SG10l0DT8HKKMQNuVaVnbkgkOn
 PIQjOoFffSsaiHRopGfvVrXuUopScP28BN0Px5q+xdHf/2zxC5FhodHQOHoXTvyjiTsBTOOxwzX
 2fK5HzEvHEMCddxBxCkAFTa6/X8squXm6roPBra2yy/zPyW0s75Egb6NN69l3ksMq0NviksUjek
 JC0GKGxqKxa5wKqp980DUai1tw7EiTxtds9PbV/rnTZe2pkvCFHeVM+ea2n2hlU9AThdKsy1RXi
 dLmQ2b/nr1FiuntDNBYZWjTcpAnp
X-Received: by 2002:a05:6a21:689:b0:3ba:ecfb:ae2c with SMTP id
 adf61e73a8af0-3bd14fbf7bdmr224301637.20.1782164218554; Mon, 22 Jun 2026
 14:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260615184737.899892-1-xmei5@asu.edu>
 <d7fdf98414e1f0386eb4acee2600b92f1ab66053@intel.com>
 <37304e9ea4bc50f7c6f1b168d43d3525ac2cdc08@intel.com>
In-Reply-To: <37304e9ea4bc50f7c6f1b168d43d3525ac2cdc08@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 22 Jun 2026 14:36:47 -0700
X-Gm-Features: AVVi8CcegrOMHIkoWNs187DXbhy1qvWkibVmgKiML11Bvaq_X6JaQ9gJ5mZ6Ua0
Message-ID: <CAPpSM+R2U-LuymMAbY8x25vR4L_RQpgLOUBnproFdmnVH=AkjQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/edid: fix OOB read in drm_parse_tiled_block()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Jun 22, 2026 at 6:39=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 17 Jun 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 15 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> >> drm_parse_tiled_block() casts the DisplayID block to a
> >> struct displayid_tiled_block and reads the full fixed layout up to
> >> tile->topology_id[7] without checking block->num_bytes. The DisplayID
> >> iterator only validates the declared payload length, so a crafted EDID
> >> can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
> >> DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes a=
t
> >> the end of a DisplayID extension. The read then runs past the end of t=
he
> >> exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
> >>
> >> Reject blocks shorter than the spec's 22-byte tiled payload before
> >> reading the fixed struct, as drm_parse_vesa_mso_data() already does.
> >>
> >>   BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
> >>   Read of size 2 at addr ffff888010077700 by task exploit/147
> >>    dump_stack_lvl (lib/dump_stack.c:94 ...)
> >>    print_report (mm/kasan/report.c:378 ...)
> >>    kasan_report (mm/kasan/report.c:595)
> >>    drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
> >>    bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:574)
> >>    drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_=
helper.c:426)
> >>    status_store (drivers/gpu/drm/drm_sysfs.c:219)
> >>    ...
> >>    vfs_write (fs/read_write.c:595 fs/read_write.c:688)
> >>    ksys_write (fs/read_write.c:740)
> >>
> >> Fixes: 40d9b043a89e ("drm/connector: store tile information from displ=
ayid (v3)")
> >> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> And pushed to drm-misc-fixes, thanks for the patch.
>
Thanks for your review!

Best,
Xiang
> BR,
> Jani.
>
>
> >
> >> ---
> >> v2: use 22 instead of sizeof, based on the topology_id[9] fix:
> >> https://lore.kernel.org/r/20260610141549.555605-1-jani.nikula@intel.co=
m
> >>
> >>  drivers/gpu/drm/drm_edid.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> >> index 404208bf23a6..df3c25bac761 100644
> >> --- a/drivers/gpu/drm/drm_edid.c
> >> +++ b/drivers/gpu/drm/drm_edid.c
> >> @@ -7575,6 +7575,14 @@ static void drm_parse_tiled_block(struct drm_co=
nnector *connector,
> >>      u8 num_v_tile, num_h_tile;
> >>      struct drm_tile_group *tg;
> >>
> >> +    /* tiled block payload per spec: cap 1 + topo 3 + size 4 + bezel =
5 + id 9 =3D 22 */
> >> +    if (block->num_bytes < 22) {
> >> +            drm_dbg_kms(connector->dev,
> >> +                        "[CONNECTOR:%d:%s] Unexpected tiled block siz=
e %u\n",
> >> +                        connector->base.id, connector->name, block->n=
um_bytes);
> >> +            return;
> >> +    }
> >> +
> >>      w =3D tile->tile_size[0] | tile->tile_size[1] << 8;
> >>      h =3D tile->tile_size[2] | tile->tile_size[3] << 8;
>
> --
> Jani Nikula, Intel

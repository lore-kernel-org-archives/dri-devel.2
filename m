Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7271FCD98EF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050B710ECE5;
	Tue, 16 Jun 2026 18:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="GExlg0z6";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D47510E5DC
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 18:49:17 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so3702282a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781549357; cv=none;
 d=google.com; s=arc-20240605;
 b=Yx8knq2KKOPjmXSE7TXorKQIJGsdbhoKE4Fo3YjhUsQvHQiWe2FJeCAgQxy1NLvZxg
 mjjeu7Wtbu5NKdOeLoaE3FF7uW5fnYtDm9YMWLIItoQqeyJuLGqtO8fWIv/8R/KBo6mR
 rB1MC+vq4ev3EhVaBYN4aDwQnC+GGwQ3q2yYcloQ4GNrsbjGyPKyQmyrxn0YC95TdZb+
 xBq4VjI64Z8yeHiEDl9gRfGob3yqDyrD4i6bY5vSi3TYhyWiqrg3pSEZm1U7FsCcinnb
 GeAouyVDMFCJuJ1edibkeTIVGPniB2Q0OeT9IFvEidor3jFU9QSqy60vV3NxJH766DPs
 LP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d5/DJ9DNGuShuLcbXqMZ2Vz9TuI3CFZzJNzSjnAzN5o=;
 fh=TtajIdewxLj9gyUJHHT1ccYIMDz3/yfxP4gcQYcRsXA=;
 b=iLjiTsw0/vJonDflnvQFYTiYGXeKN+J93HhhT20r1uLSuygUDi02ffXxtVizGh0waj
 E7nc7rOUJcGARoNnueD56SXAmJWcmjvoOUGYPW+5Jjy5/8XIHeZMzTvPlPLHfMx8J8TX
 zceIbS7iwMJueLT0DE+s5Uu66hausT5orWUMHzpw7TpY75wlcyGG+Lh0/c0NDyxT4Jrp
 0G/JIcrpLDXhv7rKqoD/sbLzCGDhzXZ0RXKcfQAqSputcU3yLTfLpaWBRf42YlauJnNZ
 oe4OuTbiHvraNpdX9qLeidx414moPlrjhAOsuHpHXJwWw+AQEFaElhJ2B7SbUE5L+w1M
 ltuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1781549357; x=1782154157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5/DJ9DNGuShuLcbXqMZ2Vz9TuI3CFZzJNzSjnAzN5o=;
 b=GExlg0z6uzmJuo+C7ivozo0FeQSVzRTrwkXmrkJ/lgwWqhUXXfMb45iTAZlEFWvTBw
 4O+liPz3C8/GdjLx+F4v0XgeAeUypWBTIVuUOkxosr+w+cHi15GOt4p62e/XNxAuxG70
 yukdmEuhtuhUdeutu2zpgReOTd3KX5EYw9PvM1ndKn4M11u7ayBNI6cPt8iF5KUC9J3Q
 X/BlcVzFXJwXG6lCvI8tNc/qvnckcLmRFIag5g99NcADGaH5KHpqX3EaKAlNu0/vwoBo
 AOhjtWq/CnEN2YqulIspPj1IJvqyj3l2JdjLBJPdfCvuOt4L7urNm11VqvS5yGNLqsdN
 gVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549357; x=1782154157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5/DJ9DNGuShuLcbXqMZ2Vz9TuI3CFZzJNzSjnAzN5o=;
 b=O3gJTVr7IR2RUYSqBlp+rAbnD+XQB739k4Ncn3tx2a/iwhednWmoJmnXvuEYL6FmlE
 HEx24/+jhoFViNWUKGMrCAIm73lVCvzJkvye2Yn8aqttSuibo0VIRbI8U9+jGqQoE851
 YaVF2HDEUbSxXc86exVVf2gDaQ4l2ZtOXlEHUomd9WuRYNUqC0yOOI5qoAwr2Tzxrz0F
 +NfV23pAjlP4oHtJks6kWJAKxEWVOomflqzGoUBedZVgEwEVAdGqV6PtRztwx+Z/QJOV
 JBdOtP12C1R3ilRxe1Z7d96YAWoEZq/gSntLJVFzcfcCE+9Zwsumvd3EOJ+ujByY94Le
 tAiw==
X-Gm-Message-State: AOJu0YxJQemPLAzvoakXXJzUJTuhELepBrEUoWOhE7BMy4MWW9fL6gLi
 B83Qw+hjiY2228NkAsi25M0g0AhrYz4/f5yLs68Xe8PVkPnKdKZ8MmD5FnZWRnwQVDArC+62EVN
 dcDwJGSfYvWFk9575roZQezSztczfp3ZiHawlAwHS
X-Gm-Gg: Acq92OGOX/ZGgpSzOp1kGgrs7RCau4XrQHw/EaNyMUL9XVuu7JCWOtWq/T6cW9rE86M
 WSHGzavaeWLxDBFakpijjpmi29eN2iPhR78noIu1I5hMJddmtslxjXfA5Xqz0m1rTAgb51nprpS
 Tw1WQJ9d8Yh9/ku+BBhGhq0hTcwnXYkrhLKmLAQurCHGHe1tgeFVFjHzetuCGPpMAX70xs2jpMk
 9LSOIijayRmCbbOSmVvBS8hR0jJ+q9AyFWDyhUD/tFwE/4mkjDp7qpkbAlMI5uiEGWygCp/HpuN
 C7jZuj/OGCH/0lQBNhD5oSRJFzHgTaoOIsvBSv8=
X-Received: by 2002:a17:90b:53cc:b0:36b:7f69:c152 with SMTP id
 98e67ed59e1d1-37c2bd494e7mr12595357a91.18.1781549356834; Mon, 15 Jun 2026
 11:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260609064038.2799482-1-xmei5@asu.edu>
 <4e784cad86c91595b6d5da64ca854dab38357658@intel.com>
 <CAPpSM+RXTg6KCAVHRESi8=7=3pAWGfc1bjrdS_OTf+dsSwyL7A@mail.gmail.com>
 <f9bc5c32e22198e957adcfaab5e4849a3b0e5268@intel.com>
In-Reply-To: <f9bc5c32e22198e957adcfaab5e4849a3b0e5268@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 15 Jun 2026 11:49:06 -0700
X-Gm-Features: AVVi8Cf9VDwqb7LL4w7_VjZiHvKtklhoHqqRuT4PxckdQrdNEKMOou4IdDuZTX8
Message-ID: <CAPpSM+Swx6Hu-xEj+5qoCN_jPE2i=rJqaR8YP72Ca_HpchHa2A@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: fix OOB read in drm_parse_tiled_block()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:18:52 +0000
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

On Mon, Jun 15, 2026 at 1:53=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Sat, 13 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> > On Wed, Jun 10, 2026 at 5:49=E2=80=AFAM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> >>
> >> On Mon, 08 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> >> > drm_parse_tiled_block() casts the DisplayID block to a
> >> > struct displayid_tiled_block and reads the full fixed layout up to
> >> > tile->topology_id[7] without checking block->num_bytes. The DisplayI=
D
> >> > iterator only validates the declared payload length, so a crafted ED=
ID
> >> > can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, o=
r
> >> > DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes=
 at
> >> > the end of a DisplayID extension. The read then runs past the end of=
 the
> >> > exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
> >> >
> >> > Add a minimum-length check, as drm_parse_vesa_mso_data() already doe=
s.
> >> >
> >> >   BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
> >> >   Read of size 2 at addr ffff888010077700 by task exploit/147
> >> >    dump_stack_lvl (lib/dump_stack.c:94 ...)
> >> >    print_report (mm/kasan/report.c:378 ...)
> >> >    kasan_report (mm/kasan/report.c:595)
> >> >    drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
> >> >    bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:57=
4)
> >> >    drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_prob=
e_helper.c:426)
> >> >    status_store (drivers/gpu/drm/drm_sysfs.c:219)
> >> >    ...
> >> >    vfs_write (fs/read_write.c:595 fs/read_write.c:688)
> >> >    ksys_write (fs/read_write.c:740)
> >> >
> >> > Fixes: 40d9b043a89e ("drm/connector: store tile information from dis=
playid (v3)")
> >> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> > Assisted-by: Claude:claude-opus-4-8
> >> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >> > ---
> >> >  drivers/gpu/drm/drm_edid.c | 7 +++++++
> >> >  1 file changed, 7 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> >> > index 404208bf23a6..92054ac82fe2 100644
> >> > --- a/drivers/gpu/drm/drm_edid.c
> >> > +++ b/drivers/gpu/drm/drm_edid.c
> >> > @@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_=
connector *connector,
> >> >       u8 num_v_tile, num_h_tile;
> >> >       struct drm_tile_group *tg;
> >> >
> >> > +     if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
> >>
> >> I'd prefer using fixed values here. If the tiled display topology data
> >> block is ever expanded, we'll need to have them anyway.
> >>
> >> This should be if (block->num_bytes < 22).
> >>
> >
> > I've been advised on other patches that it's better to avoid magic
> > numbers, and I think sizeof(*tile) - sizeof(*block) is preferable here
> > for two reasons:
> >
> > 1. It's easier to understand. A bare 22 forces the reader to know what
> > it stands for, while sizeof(*tile) - sizeof(*block) reads as exactly
> > what it is: the number of payload bytes the code dereferences.
> >
> > 2. It's more maintainable for the expansion case you mention. It stays
> > in lockstep with the struct, so once topology_id is corrected to 9
> > bytes (below) it becomes 22 automatically and the patch still works
> > with no edit. A hardcoded 21 would silently re-open the OOB when the
> > struct grows, and a hardcoded 22 doesn't match what the current code
> > reads today.
>
> I'm not referring to struct changes, I'm referring to spec changes.
>
> If the spec gets changed, the struct needs to reflect the newest/biggest
> size, and access to the end of the struct needs to be gated on the size
> available. If you add that sizeof thing now, it'll need to be changed if
> the spec gets exended.
>
> I'll argue that adding the sizeof or < 21 check now is *wrong* because
> it does not match the *spec*. It's not about the struct, it's about the
> spec. The check should be < 22.

Thanks for the explanation. v2 uses 22 instead of sizeof.

>
> >> And reviewing this, I realize struct displayid_tiled_block definition =
is
> >> actually only 21 bytes. The topology_id member is 8 bytes, while it
> >> consists of
> >>
> >> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
> >> - Tiled Display Product ID Code Field (2 bytes)
> >> - Tiled Display Serial Number Field (4 bytes)
> >>
> >> i.e. total of 9 bytes.
> >>
> > Good catch. This looks like a separate, pre-existing issue from the
> > OOB read fixed here, and it also touches group_data[8] and the
> > memcpy/memcmp sites in drm_mode_{get,create}_tile_group(). We don't
> > have much experience with this part of the code, so if it's okay we'd
> > rather leave it for you to assess the impact and the right fix, and
> > keep this patch as the minimal OOB fix.
>
> The fix is at [1].
>
Thanks for the patch!

Xiang
>
> BR,
> Jani.
>
>
> [1] https://lore.kernel.org/r/20260610141549.555605-1-jani.nikula@intel.c=
om
>
> >
> >
> > Xiang
> >
> >> BR,
> >> Jani.
> >>
> >>
> >> > +             drm_dbg_kms(connector->dev,
> >> > +                         "[CONNECTOR:%d:%s] Unexpected tiled block =
size %u\n",
> >> > +                         connector->base.id, connector->name, block=
->num_bytes);
> >> > +             return;
> >> > +     }
> >> > +
> >> >       w =3D tile->tile_size[0] | tile->tile_size[1] << 8;
> >> >       h =3D tile->tile_size[2] | tile->tile_size[3] << 8;
> >>
> >> --
> >> Jani Nikula, Intel
>
> --
> Jani Nikula, Intel

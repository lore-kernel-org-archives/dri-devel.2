Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163DCD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A9E10E0BA;
	Sun, 14 Jun 2026 15:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="GZfcfI+n";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143D510E0D2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 21:17:34 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2bf22d29dabso13639415ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 14:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781385454; cv=none;
 d=google.com; s=arc-20240605;
 b=C5Z0MSfTshLcxa4PNO32dIXOEqeSwTjTvyDBq5Nfa3TKk6BqO7CxnUA6KCXVA9Gsil
 lywkO93GjVyKZV3Ft+JytJpD8uJ6d9qI/zwO/0hQ0baAn2LaNxI5MevweigeuBxssGeV
 HaOAYp55m4Ub2+OOFrL9ru3KqybClhh914xGCozwj/9EWpKaKzEJlBI9eSZO3B/3VeQa
 FNh0TOyTHfykBGEo+wX0/WJUVxfizIqOk2VQf08rSmK7r25JvYwO7hajE9EldUVnauz8
 zXLMl7+HVvfsOnVN20ZyvFN3ttBwwGJUCzHYB7FL90J7F9VjvZeyfNld93ZavR1NgK/L
 ECHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P5mXzsGRWKo5p82tVmxYirj6uc69tm3cPXgLYl40MD4=;
 fh=TtajIdewxLj9gyUJHHT1ccYIMDz3/yfxP4gcQYcRsXA=;
 b=PpWclseJpPloRAB2HDcruN8zK8c4WpgE0APRYa+idc/+qunF3/KonJfxaom5yf1t+a
 ZA0hbxdifZvGTMlNzScx7QYpop9j2/cxCbDXuvnIhfjT0DqKqZTt8lUthFB5MqLNJfcb
 VbweMgTKgj88oH7SWgnoWBG4sN4s6Lv3muJcxDyFG8h/zaDZPr1rVAknoqIuX6znbmR8
 77FrfYeKj4zMNp5rSlOh8MIEjITt2vyhouAi8Lopae7eeImKpNfalf4E05WZlhza+3b+
 Y9VBLadtjb4/C65su0AziqiXmV4wLPq0427ee+bF6RWqnzbEGVjoFNPF+iSavpiNOVZL
 LxEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1781385454; x=1781990254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5mXzsGRWKo5p82tVmxYirj6uc69tm3cPXgLYl40MD4=;
 b=GZfcfI+nI1Xdrw+E/w+sXz0gaxIB/zvPsyrNp10NxBQxDGxy8nXfjNuyMdsVAfUDGZ
 xF84fXe9K6ZIvtUp+xY5jFgXgnjoE/uRETPjzUuG2R9kFj8trdl3Dln1YOYzNbCgHGVD
 41AxCjY/VUbc9CCiYhUTaLaA9aKadVsA9Oq73hsI6pZ4eXBvVytELsTbbWu0RCkD3sX7
 7DGQk7t5ju5MYI16ubaAbOXOCif017e9gD8W+hpkEXk1taAzz7Ylpe1J97rwrEeCxfk6
 iJycaf6AKvTI5DNi34NQVJDugEjOrAIWVpXriLMFjqPE80CGqQZIOwGc7r+U3+oxDdhX
 gZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781385454; x=1781990254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5mXzsGRWKo5p82tVmxYirj6uc69tm3cPXgLYl40MD4=;
 b=oqZ7qp1eZNRxRbDao73U1UDYObuBo5foL4B4yr/PWz/m0TW4EGaToVUvAEPFobcY1X
 JogtSJSNTWIAiqKI+Vpt7H1nQgMPIjm+hSXixvr7ZmW0OZCEsxVCeE7QoFwwiHXPFOmB
 xsl3bKOTV8hF5LUqBeuIQyFVB74CpCmo73o5ErJgYL17syLzYx57WnVraSJ2hAu+qLJ4
 DhRDHDwDa9P1n3WHjqUjTIl9Z2KzdcP1auHQjLMlpUfwhcPXbSzAt0HfPax84Rsn3Iyl
 rUoh2dE8x3ZgpyjDzkzAEHIQ2Q8lrPssUR+iBo4vt4MWrXylNinWC/n7NPO6RpOoo2Tf
 QzFA==
X-Gm-Message-State: AOJu0YywgcsLjLCSmEp8H98ECsV5KMLkiz9vaL8MdUAD3vJOqqDYPdkH
 CyDkxkPZjy5B5s2kKVkFZLb1x5rV5qSREFkzlAPYChM6IR3gyn9pmLCSTCxWu7fSniO2lALc9fr
 BKrOYM7OQ+ky5Of8oI6Ec8YUImx6MxLR+tukYsy/v
X-Gm-Gg: Acq92OHZdWl+z0KR1FwfJICUKa8sS7y8MjWO+2rUEO/ofGyN7W7kdX3hNboIV+jGKP5
 FpdVkokHPDXvveRaR6AR3lcnR2IrBcokBD2Ce2KyHYrX6UwZQpOZCHh0uW75HKksBfkqZNPyc3c
 ZAbp3Wo8tUtdh83ktWVJOZrgiRbyObks6MwwDFIkYR6AtAOjqpwMAA+NlsSGicocF4qAxBcU0FB
 YL+6aPt4iqswEOp0I9o9rq6FczRvDXqBU9c2kJiN/9xpNr+BpcJlCRYBS+4stae0C091iVU6Q+U
 mjkltHrb/KKUPg6R/LNl9m3SrO108bL5lajPIEw=
X-Received: by 2002:a17:903:19cf:b0:2bf:211c:4980 with SMTP id
 d9443c01a7336-2c412a32d6amr92152015ad.35.1781385454383; Sat, 13 Jun 2026
 14:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260609064038.2799482-1-xmei5@asu.edu>
 <4e784cad86c91595b6d5da64ca854dab38357658@intel.com>
In-Reply-To: <4e784cad86c91595b6d5da64ca854dab38357658@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 14:17:23 -0700
X-Gm-Features: AVVi8CcrY1i-woSBF4uaCqaxUh4AzZQ03JzY63--20Z0J0-Ud6VsKO77X4s3EgI
Message-ID: <CAPpSM+RXTg6KCAVHRESi8=7=3pAWGfc1bjrdS_OTf+dsSwyL7A@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: fix OOB read in drm_parse_tiled_block()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

On Wed, Jun 10, 2026 at 5:49=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 08 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> > drm_parse_tiled_block() casts the DisplayID block to a
> > struct displayid_tiled_block and reads the full fixed layout up to
> > tile->topology_id[7] without checking block->num_bytes. The DisplayID
> > iterator only validates the declared payload length, so a crafted EDID
> > can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
> > DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes at
> > the end of a DisplayID extension. The read then runs past the end of th=
e
> > exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
> >
> > Add a minimum-length check, as drm_parse_vesa_mso_data() already does.
> >
> >   BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
> >   Read of size 2 at addr ffff888010077700 by task exploit/147
> >    dump_stack_lvl (lib/dump_stack.c:94 ...)
> >    print_report (mm/kasan/report.c:378 ...)
> >    kasan_report (mm/kasan/report.c:595)
> >    drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
> >    bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:574)
> >    drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_h=
elper.c:426)
> >    status_store (drivers/gpu/drm/drm_sysfs.c:219)
> >    ...
> >    vfs_write (fs/read_write.c:595 fs/read_write.c:688)
> >    ksys_write (fs/read_write.c:740)
> >
> > Fixes: 40d9b043a89e ("drm/connector: store tile information from displa=
yid (v3)")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  drivers/gpu/drm/drm_edid.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 404208bf23a6..92054ac82fe2 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_con=
nector *connector,
> >       u8 num_v_tile, num_h_tile;
> >       struct drm_tile_group *tg;
> >
> > +     if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
>
> I'd prefer using fixed values here. If the tiled display topology data
> block is ever expanded, we'll need to have them anyway.
>
> This should be if (block->num_bytes < 22).
>

I've been advised on other patches that it's better to avoid magic
numbers, and I think sizeof(*tile) - sizeof(*block) is preferable here
for two reasons:

1. It's easier to understand. A bare 22 forces the reader to know what
it stands for, while sizeof(*tile) - sizeof(*block) reads as exactly
what it is: the number of payload bytes the code dereferences.

2. It's more maintainable for the expansion case you mention. It stays
in lockstep with the struct, so once topology_id is corrected to 9
bytes (below) it becomes 22 automatically and the patch still works
with no edit. A hardcoded 21 would silently re-open the OOB when the
struct grows, and a hardcoded 22 doesn't match what the current code
reads today.

> And reviewing this, I realize struct displayid_tiled_block definition is
> actually only 21 bytes. The topology_id member is 8 bytes, while it
> consists of
>
> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
> - Tiled Display Product ID Code Field (2 bytes)
> - Tiled Display Serial Number Field (4 bytes)
>
> i.e. total of 9 bytes.
>
Good catch. This looks like a separate, pre-existing issue from the
OOB read fixed here, and it also touches group_data[8] and the
memcpy/memcmp sites in drm_mode_{get,create}_tile_group(). We don't
have much experience with this part of the code, so if it's okay we'd
rather leave it for you to assess the impact and the right fix, and
keep this patch as the minimal OOB fix.


Xiang

> BR,
> Jani.
>
>
> > +             drm_dbg_kms(connector->dev,
> > +                         "[CONNECTOR:%d:%s] Unexpected tiled block siz=
e %u\n",
> > +                         connector->base.id, connector->name, block->n=
um_bytes);
> > +             return;
> > +     }
> > +
> >       w =3D tile->tile_size[0] | tile->tile_size[1] << 8;
> >       h =3D tile->tile_size[2] | tile->tile_size[3] << 8;
>
> --
> Jani Nikula, Intel

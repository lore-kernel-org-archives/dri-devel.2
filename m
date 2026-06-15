Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBC7CD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9395310E2C5;
	Mon, 15 Jun 2026 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oBzUUdym";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B8210E2C5
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781513578; x=1813049578;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=ZDVr3i9Yu7tYRqrmPANfv9Dj23e9viHLFjxVPis/OOs=;
 b=oBzUUdymEsA+QJQs6Nufr9cT7c08R6K7lxUIar5BqgSU6Jz9FpURUiPn
 kR/xVSwh314HFvezhZbArb5BCn7E6eyyl4uPg4BgSPSytnM9w3Mz3tuGa
 RbqLIHo63QBRnv4EmFs+FtRm2CHjXvTerAMfhFTMjfRJ46OXGVDXXRQUt
 qSLyS6tFwizw2SPQA1QX/VPGANdt5zzmoUJNP163fSc04pmcEEWP97gB8
 TxtxigBz6zQ2uZchpI9WjrwmlYoia2cvSsYvj6OKU8a58NOKVhFvFdrjE
 MN/K/QEksJqSoqkuTWV8sNagxG59K5YDlByQbUlQ8iXypYGluF6/g0zgq A==;
X-CSE-ConnectionGUID: 3yt7oZPsScaceVKtZ172lg==
X-CSE-MsgGUID: UqpD4Kt9QGiXlotcMgBW4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="107678246"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="107678246"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:52:58 -0700
X-CSE-ConnectionGUID: y7wa29YESamUZqjGVSutiA==
X-CSE-MsgGUID: fFeYKAlKQAiN/rY+4gXITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="277613918"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.28])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 01:52:55 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, bestswngs@gmail.com
Subject: Re: [PATCH] drm/edid: fix OOB read in drm_parse_tiled_block()
In-Reply-To: <CAPpSM+RXTg6KCAVHRESi8=7=3pAWGfc1bjrdS_OTf+dsSwyL7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260609064038.2799482-1-xmei5@asu.edu>
 <4e784cad86c91595b6d5da64ca854dab38357658@intel.com>
 <CAPpSM+RXTg6KCAVHRESi8=7=3pAWGfc1bjrdS_OTf+dsSwyL7A@mail.gmail.com>
Date: Mon, 15 Jun 2026 11:52:52 +0300
Message-ID: <f9bc5c32e22198e957adcfaab5e4849a3b0e5268@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Sat, 13 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
> On Wed, Jun 10, 2026 at 5:49=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>>
>> On Mon, 08 Jun 2026, Xiang Mei <xmei5@asu.edu> wrote:
>> > drm_parse_tiled_block() casts the DisplayID block to a
>> > struct displayid_tiled_block and reads the full fixed layout up to
>> > tile->topology_id[7] without checking block->num_bytes. The DisplayID
>> > iterator only validates the declared payload length, so a crafted EDID
>> > can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
>> > DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes at
>> > the end of a DisplayID extension. The read then runs past the end of t=
he
>> > exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
>> >
>> > Add a minimum-length check, as drm_parse_vesa_mso_data() already does.
>> >
>> >   BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
>> >   Read of size 2 at addr ffff888010077700 by task exploit/147
>> >    dump_stack_lvl (lib/dump_stack.c:94 ...)
>> >    print_report (mm/kasan/report.c:378 ...)
>> >    kasan_report (mm/kasan/report.c:595)
>> >    drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
>> >    bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:574)
>> >    drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_=
helper.c:426)
>> >    status_store (drivers/gpu/drm/drm_sysfs.c:219)
>> >    ...
>> >    vfs_write (fs/read_write.c:595 fs/read_write.c:688)
>> >    ksys_write (fs/read_write.c:740)
>> >
>> > Fixes: 40d9b043a89e ("drm/connector: store tile information from displ=
ayid (v3)")
>> > Reported-by: Weiming Shi <bestswngs@gmail.com>
>> > Assisted-by: Claude:claude-opus-4-8
>> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>> > ---
>> >  drivers/gpu/drm/drm_edid.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> > index 404208bf23a6..92054ac82fe2 100644
>> > --- a/drivers/gpu/drm/drm_edid.c
>> > +++ b/drivers/gpu/drm/drm_edid.c
>> > @@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_co=
nnector *connector,
>> >       u8 num_v_tile, num_h_tile;
>> >       struct drm_tile_group *tg;
>> >
>> > +     if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
>>
>> I'd prefer using fixed values here. If the tiled display topology data
>> block is ever expanded, we'll need to have them anyway.
>>
>> This should be if (block->num_bytes < 22).
>>
>
> I've been advised on other patches that it's better to avoid magic
> numbers, and I think sizeof(*tile) - sizeof(*block) is preferable here
> for two reasons:
>
> 1. It's easier to understand. A bare 22 forces the reader to know what
> it stands for, while sizeof(*tile) - sizeof(*block) reads as exactly
> what it is: the number of payload bytes the code dereferences.
>
> 2. It's more maintainable for the expansion case you mention. It stays
> in lockstep with the struct, so once topology_id is corrected to 9
> bytes (below) it becomes 22 automatically and the patch still works
> with no edit. A hardcoded 21 would silently re-open the OOB when the
> struct grows, and a hardcoded 22 doesn't match what the current code
> reads today.

I'm not referring to struct changes, I'm referring to spec changes.

If the spec gets changed, the struct needs to reflect the newest/biggest
size, and access to the end of the struct needs to be gated on the size
available. If you add that sizeof thing now, it'll need to be changed if
the spec gets exended.

I'll argue that adding the sizeof or < 21 check now is *wrong* because
it does not match the *spec*. It's not about the struct, it's about the
spec. The check should be < 22.

>> And reviewing this, I realize struct displayid_tiled_block definition is
>> actually only 21 bytes. The topology_id member is 8 bytes, while it
>> consists of
>>
>> - Tiled Display Manufacturer/Vendor ID Field (3 bytes)
>> - Tiled Display Product ID Code Field (2 bytes)
>> - Tiled Display Serial Number Field (4 bytes)
>>
>> i.e. total of 9 bytes.
>>
> Good catch. This looks like a separate, pre-existing issue from the
> OOB read fixed here, and it also touches group_data[8] and the
> memcpy/memcmp sites in drm_mode_{get,create}_tile_group(). We don't
> have much experience with this part of the code, so if it's okay we'd
> rather leave it for you to assess the impact and the right fix, and
> keep this patch as the minimal OOB fix.

The fix is at [1].


BR,
Jani.


[1] https://lore.kernel.org/r/20260610141549.555605-1-jani.nikula@intel.com

>
>
> Xiang
>
>> BR,
>> Jani.
>>
>>
>> > +             drm_dbg_kms(connector->dev,
>> > +                         "[CONNECTOR:%d:%s] Unexpected tiled block si=
ze %u\n",
>> > +                         connector->base.id, connector->name, block->=
num_bytes);
>> > +             return;
>> > +     }
>> > +
>> >       w =3D tile->tile_size[0] | tile->tile_size[1] << 8;
>> >       h =3D tile->tile_size[2] | tile->tile_size[3] << 8;
>>
>> --
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel

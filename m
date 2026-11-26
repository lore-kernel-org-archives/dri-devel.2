Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D460606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bnc+67L4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027431124A7;
	Thu, 26 Nov 2026 14:41:33 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F5A11249B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:41:26 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-6ddaf3b8defso442937eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:41:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795704085; cv=none;
 d=google.com; s=arc-20260327;
 b=izXTnkowJs+mJq2+tSWk8bdrEs72Lb/zAChNm9hIH9JxDAJ/DtuEsOjai4WG7hil5f
 IyYLQGWk67BhZuJkdGZrMIx3oDkt8bKZinsVWKmqH/C48qqOObNU2hlfquNxufsocf37
 7GxR/bQGihWpSLgYRb8Hlyx1mGHb5LW+V3zLSpU86oBb3NK7XklpYjf9aBDuxnjyQrBS
 WxdP0bK+PP7kRadaBZEr5YA7knMAixGB+BPnrCXUnbArifz6EgWYfxf4fUmHVJOtjCG1
 4b3Q8qWy3gUNVjZFkzii8XK5nggVL9EbZJ+FHXHvdk8Ozde4T5DjmIs+hY1YGqktEOvZ
 mEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Q0FF1IyAcwjpLjwd+mXTwMoeBmTLz95TeFBN3exZ8o=;
 fh=t3ROCa29S+oyF8C4Jgph795mqcW/rgnGW4/yfhTknJw=;
 b=MUnJtt7/hcJQ7evtG85OsHS5I2IvhiGfqLPuw+mdSoYwlMTQA05no0SV/FPGW4aoe+
 cF16l+RPJ5w/VWYq53fNvk6qtnks1nSAFQoLN6F5ltfpRJrgxIxgVgxaPZrKdskqvzkM
 mV+GNOZqXxLzp2AU39xqYBXWQ6KWtpp0KzRlacViZWAaovThy0LXzZkVJf5eyT54FNhZ
 Dv7r9L/Z/1wkPDaVLPUEzXbhMrN1vGZV5y+ZLHfIcaWwZfXbQMDueh4sqOOOMwqonyCh
 xshKQq7KWBGbWEoageTurKJQBKjY90BQSVCJkSWTVw6Gz50Hcx3V5vmstQW0i48jmkPC
 jbww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795704085; x=1796308885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Q0FF1IyAcwjpLjwd+mXTwMoeBmTLz95TeFBN3exZ8o=;
 b=Bnc+67L41tMER2NzRWZxx6WthfT3Rwn1sMBIXArMcUN+4yKI3oFRelg6qDTLccX4oi
 ojt1YeBKJFcb5yG1pona19zlCK8IGbtIEnzeHWNtLoHvVj5AhbEuDh82PjRRJsLr587D
 yVMDSA6gAhJ6BwBg3lVyfCAZq7eRrjD2Pfbz7Kq5vvh78AXxgJBpHbBLoc6uuN9RpaUc
 JHBwRezIsCB7M94M8o+kVhjPahwAYNw+fjbsqGp1uawIsjuu24uCMUWlliXLF8dyf3Do
 r0K5gwf2V7CwEI/C8p2vRfaWhKwfo4yJhUfQFrIWGpg617zw5Ai5ZDL9wtdiP24dQ3ch
 onYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704085; x=1796308885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Q0FF1IyAcwjpLjwd+mXTwMoeBmTLz95TeFBN3exZ8o=;
 b=G4cYMgszQ82NvF82sGloK4IyiaJHkrxUoWYgnusFEfhgtserT6LMQ/p8IHRjveN/Ul
 UdgqNksjyDraS4wUOn7iXLaZOzX4DP1LJcF/sd10RBbOOzUCXSUhbWoI3Rf7om6B+zTH
 WmZAtXfagGVnxpUW2zjYTRec4XkRTBbZjM3+/EDEEZr3snxppN1wfP28szHo9Oz7qIo4
 178kcjaLgphIaKRJXHCSxAH05kyQCnNLqZrh8ArHwp4dk7wZ8FpLr1iYiICMAq6gtHI9
 +TQLrATdJUvusf+nUBBQjrqEseu4ld7m/X5RpbDzulDlhetDU0yZXnhT4DDJn4yzRQrw
 k75Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHa1X+brg/LewfFB4mI5W9sWCi5bfNVYAWjLlbG0s60tv0BjFOTeKSW1uwVPoyjv6c4UH7cPAv0bZ4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JAdqnrYYKuN+K4eElnEddzi1rmt93snsQkW23wIgJprv5N5mj
 yeBQ6+qGIuTOlzs45pj9074uwv2ikEEqA76u+vQcFOyvgidNcHKRExaZ9Ek4jEoQN8inDy0VVzS
 C2JSk9qOktuw8uJbs/s5zrBFNAwNe3GY=
X-Gm-Gg: AZFdTZfZ6Y76OTDWp4U+MoNpD4h0A+iYPxrUCF2NgkNxFsfxeN6z1/ATSZClYZHmnZR
 L6NM8aGOk0rwX4StAZKMriWN4VDyPB5+3lrEVodRPfLqHplkoirBJR+L2YT/P9WqU9gX1EpaCcu
 rk1EzPyGgYJYAQedmImAs3x1PTkjnfUnoIt6kJIONY3+1Dd3YmlM15mnIr1baYvQHEw2t9XgR0f
 5guv0cfmF1LXKshZLUMyFt6LI/o7g1Vpd9+787HmW3ZiZK0JPQowwUYkZNmJCNPgGpJ1aTLWz/f
 t0Jl/2LbEwEnqqP6LCToWHzCo7DZjMMdxVQ2ObuQzDcmoHnBx6jG12dpps1xyRR9jQmp0OJAHvr
 wenB4ntJYAKul5L4E/62MgfRKMyNXngSw5TeYGB+ZqpiETfVJ5RfR9QpWuVaRmi/3gQZfV+RuvY
 hCAHvQKs9YlmmRkzA2oTyE0mFmu3jRG0za0ovrPP6f2mdxsG4DtNqgZ1H6Qn0=
X-Received: by 2002:a05:6820:a781:20b0:71a:ed80:f0 with SMTP id
 006d021491bc7-71b393836f1mr18817278eaf.2.1795704085187; Thu, 26 Nov 2026
 06:41:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6c7b9cdf-9562-4954-9f66-444745e430bb@gmail.com>
 <SJ0PR12MB6830376D484FDC67FA87E10EF7432@SJ0PR12MB6830.namprd12.prod.outlook.com>
 <e25c68b6-d67a-4d5e-86d2-724ee2407f0c@gmail.com>
In-Reply-To: <e25c68b6-d67a-4d5e-86d2-724ee2407f0c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Nov 2026 09:41:14 -0500
X-Gm-Features: Aa3M54rd4-ZxJfzUBH2RLa9G95otVSabj3WJmMgpkejSZMXwLC-mfLZ813mzpOc
Message-ID: <CADnq5_NrEhM+SsqdABYrDh+0uthsE8w4sBw9M25OTxK8e6q4mA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/amd/display: unlock secondary tile on Apple
 4K/5K iMac panels
To: Richard Lane <richardlanedev@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 6:01=E2=80=AFPM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> On 25/11/2026 15:41, Deucher, Alexander wrote:
> > Public
> >
> >> -----Original Message-----
> >> From: Richard Lane <richardlanedev@gmail.com>
> >> Sent: Tuesday, November 24, 2026 8:04 PM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
> >> Vetter <simona@ffwll.ch>; Wentland, Harry <Harry.Wentland@amd.com>; Li=
,
> >> Sun peng (Leo) <Sunpeng.Li@amd.com>; Rodrigo Siqueira
> >> <siqueira@igalia.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> >> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Richard=
 Lane
> >> <richardlanedev@gmail.com>
> >> Subject: [PATCH v3 2/3] drm/amd/display: unlock secondary tile on Appl=
e 4K/5K
> >> iMac panels
> >>
> >> Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
> >> iMac18,3, Polaris-based iMac19,1) Retina iMacs expose their internal p=
anel as
> >> a 2x1 tiled display over an eDP root link and a secondary DP link. At =
boot, the
> >> panel TCON operates in single-pipe mode and holds the secondary DP lin=
k's
> >> HPD line low until unlocked via DPCD registers.
> >>
> >> Enable native tiled detection and link training for DCE < 12 Apple 4K/=
5K Retina
> >> iMac panels:
> >> - Latch the root eDP link via DPCD 0x4F1 prior to reading its EDID in
> >>   dm_helpers_read_local_edid() on Apple hardware (DCE < 12) so the
> >>   TCON exposes its full DisplayID tile properties even when Apple and
> >>   OpenCore Legacy Patcher (OCLP) EFI folders are absent.
> >> - Point the secondary DP dc_link to the root eDP dc_link
> >>   (apple_tcon_peer) during EDID quirk matching on DCE < 12 iMac15,1
> >>   (AE01/02), iMac17,1 (AE05/06), iMac18,3 (AE11/12), iMac18,2/19,2
> >>   (AE19/1A), and Polaris-based iMac19,1 (AE25/26), checking
> >>   connector_signal since panel IDs can flip across the two links after
> >>   S3 wake. DCE >=3D 12 support for Vega-based iMac19,1, iMacPro1,1, an=
d
> >>   iMac20,x is documented as TODO.
> >> - Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F=
1
> >>   on the root eDP link when probing the secondary link, allowing the
> >>   secondary link to read its EDID and populate DRM's DisplayID tile
> >>   properties (has_tile, tile_group, and tile_is_single_monitor).
> >> - Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
> >>   0x310 in dpcd_set_source_specific_data() to unlock the secondary til=
e.
> >> - Prevent the secondary tile from entering DP_SET_POWER D3, which caus=
es
> >>   the TCON to drop HPD and stop responding to AUX transactions.
> >
> > Does the display still blank properly without this?
> >
> > Alex
> >
>
> I have just tested and the display still blanks, and recovers from suspen=
d
> properly without needing to prevent the secondary tile from entering
> DP_SET_POWER D3. Hence this patch hunk can be dropped (no modification is
> therefore needed to link_dp_phy.c):
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c =
b/drivers/gpu/drm/amd/display/dc/link/
> protocols/link_dp_phy.c
> index 49521ac4b0e8..f051fe6c060c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> @@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, boo=
l on)
>         if (link->sync_lt_in_progress)
>                 return;
>
> +       if (!on && link->apple_imac_peer)
> +               return;
> +
>         core_link_write_dpcd(link, DP_SET_POWER, &state,
>                                                  sizeof(state));
>
> Should I submit a v4 patch with this change?

Yes please.

Thanks,

Alex

>
> Richard
>
> >> - Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310=
)
> >>   and DP_EDP_CONFIGURATION_SET (0x10A) in
> >> amdgpu_dm_apple_tcon_unlatch()
> >>   during dm_suspend() so the TCON returns to single-pipe mode for the
> >>   EFI boot screen across reboots.
> >>
> >> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >> ---
> >>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++
> >> .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34
> >> +++++++++++++++++++
> >>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
> >>  .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
> >>  .../dc/link/protocols/link_dp_capability.c    |  4 +++
> >>  .../display/dc/link/protocols/link_dp_phy.c   |  3 ++
> >>  6 files changed, 67 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 3d2201285888..6275a585593c 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -1610,6 +1610,23 @@ STATIC_IFN_KUNIT void
> >> dm_destroy_cached_state(struct amdgpu_device *adev)  }
> >> EXPORT_IF_KUNIT(dm_destroy_cached_state);
> >>
> >> +static void amdgpu_dm_apple_imac_unlatch(struct dc *dc) {
> >> +     const u8 zeros[3] =3D { 0 };
> >> +
> >> +     for (int i =3D 0; i < dc->link_count; i++) {
> >> +             struct dc_link *link =3D dc->links[i];
> >> +
> >> +             if (link->apple_imac_peer) {
> >> +                     core_link_write_dpcd(link,
> >> DP_SOURCE_TABLE_REVISION, zeros, 3);
> >> +                     core_link_write_dpcd(link,
> >> DP_EDP_CONFIGURATION_SET, zeros, 1);
> >> +                     core_link_write_dpcd(link, 0x4F1, zeros, 1);
> >> +                     core_link_write_dpcd(link->apple_imac_peer, 0x4F=
1,
> >> zeros, 1);
> >> +                     break;
> >> +             }
> >> +     }
> >> +}
> >> +
> >>  static int dm_suspend(struct amdgpu_ip_block *ip_block)  {
> >>       struct amdgpu_device *adev =3D ip_block->adev; @@ -1677,6 +1694,=
8
> >> @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
> >>
> >>       amdgpu_dm_hpd_rx_irq_work_suspend(dm);
> >>
> >> +     amdgpu_dm_apple_imac_unlatch(dm->dc);
> >> +
> >>       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> >>
> >>       if (dm->dc->caps.ips_support && adev->in_s0ix) diff --git
> >> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> index 6192c0f6086d..e30450415462 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/string.h>
> >>  #include <linux/acpi.h>
> >>  #include <linux/i2c.h>
> >> +#include <linux/dmi.h>
> >>
> >>  #include <drm/drm_atomic.h>
> >>  #include <drm/drm_probe_helper.h>
> >> @@ -173,6 +174,30 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct
> >> dc_link *link, struct edid *edid,
> >>               drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on pane=
l id
> >> %X\n", panel_id);
> >>               edid_caps->panel_patch.force_freesync_min_hz =3D 60;
> >>               break;
> >> +     /*
> >> +      * Workaround for Apple 21.5" 4K and 27" 5K iMacs which expose a=
 2x1
> >> +      * tiled internal panel over an eDP root link and a secondary DP=
 link.
> >> +      * Point the secondary link to the root link to latch/unlatch th=
e TCON
> >> +      * via DPCD, checking connector_signal as panel IDs can flip aft=
er wake.
> >> +      * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
> >> +      * iMac18,3 (AE11/12), iMac18,2/19,2 (AE19/1A), iMac19,1 (AE25/2=
6);
> >> +      * TODO (DCE >=3D 12): iMac19,1/19,2 Vega, iMacPro1,1 (AE1D/1E),
> >> iMac20,x (AE31/32, AE35/36).
> >> +      */
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE19):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE1A):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
> >> +     case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
> >> +             if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP &&
> >> +                 link->ctx->dce_version < DCE_VERSION_12_0 &&
> >> +                 (link->link_index ^ 1) < link->dc->link_count)
> >> +                     link->dc->links[link->link_index ^ 1]->apple_ima=
c_peer
> >> =3D link;
> >> +             break;
> >>       default:
> >>               return;
> >>       }
> >> @@ -1299,6 +1324,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
> >>       if (link->dc->hwss.prepare_ddc)
> >>               link->dc->hwss.prepare_ddc(link);
> >>
> >> +     if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP &&
> >> +         link->ctx->dce_version < DCE_VERSION_12_0 &&
> >> +         dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
> >> +             const char *product =3D
> >> dmi_get_system_info(DMI_PRODUCT_NAME);
> >> +
> >> +             if (product && str_has_prefix(product, "iMac"))
> >> +                     dm_helpers_dp_write_dpcd(ctx, link, 0x4F1, &(con=
st
> >> uint8_t){1}, 1);
> >> +     }
> >> +
> >>       dm_helpers_wait_for_edid_ready(link, ddc);
> >>
> >>       /* some dongles read edid incorrectly the first time, diff --git
> >> a/drivers/gpu/drm/amd/display/dc/dc.h
> >> b/drivers/gpu/drm/amd/display/dc/dc.h
> >> index 8471dcfe24fd..bd3857267331 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> >> @@ -2018,6 +2018,7 @@ struct dc_scratch_space {
> >>       bool skip_implict_edp_power_control;
> >>       bool forced_psr_active;
> >>       enum backlight_control_type backlight_control_type;
> >> +     struct dc_link *apple_imac_peer;
> >>  };
> >>
> >>  struct dc {
> >> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> >> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> >> index 5b257f003f13..02c6e5874c16 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> >> @@ -218,7 +218,7 @@ static enum signal_type
> >> link_detect_sink_signal_type(struct dc_link *link,
> >>                        * we assume signal is DVI; it could be correcte=
d
> >>                        * to HDMI after dongle detection
> >>                        */
> >> -                     if (!dm_helpers_is_dp_sink_present(link))
> >> +                     if (!link->apple_imac_peer &&
> >> !dm_helpers_is_dp_sink_present(link))
> >>                               result =3D SIGNAL_TYPE_DVI_SINGLE_LINK;
> >>               }
> >>               break;
> >> @@ -1651,6 +1651,11 @@ bool link_detect_connection_type(struct dc_link
> >> *link, enum dc_connection_type *
> >>               }
> >>       }
> >>
> >> +     if (*type =3D=3D dc_connection_none && link->apple_imac_peer) {
> >> +             core_link_write_dpcd(link->apple_imac_peer, 0x4F1, &(con=
st
> >> uint8_t){1}, 1);
> >> +             *type =3D dc_connection_single;
> >> +     }
> >> +
> >>       return true;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_cap=
ability.c
> >> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> >> index c487c5b87dfd..74954702c5a9 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability=
.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability=
.c
> >> @@ -1496,6 +1496,10 @@ void dpcd_set_source_specific_data(struct dc_li=
nk
> >> *link)
> >>                               link->dc->vendor_signature.data.raw,
> >>                               sizeof(link->dc->vendor_signature.data.r=
aw));
> >>       }
> >> +
> >> +     if (link->apple_imac_peer)
> >> +             core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
> >> +                                  (const uint8_t[]){0x04, 0x1d, 0x03}=
, 3);
> >>  }
> >>
> >>  void dpcd_write_cable_id_to_dprx(struct dc_link *link) diff --git
> >> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> >> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> >> index 49521ac4b0e8..f051fe6c060c 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> >> @@ -50,6 +50,9 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, =
bool
> >> on)
> >>       if (link->sync_lt_in_progress)
> >>               return;
> >>
> >> +     if (!on && link->apple_imac_peer)
> >> +             return;
> >> +
> >>       core_link_write_dpcd(link, DP_SET_POWER, &state,
> >>                                                sizeof(state));
> >>
> >> --
> >> 2.55.0
>

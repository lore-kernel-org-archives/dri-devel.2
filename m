Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A81C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556A110E59C;
	Tue, 22 Sep 2026 21:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="EzXIr51O";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F346C10E59C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114005; bh=q7kOWwgT2qZEczcxJU5TH3d+7vJSejztPez4jmIWhSY=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=EzXIr51OlcJOa/1qky2wH8uDJVwZuFMcn9cfjT9nGWxEc6VH95DUFu0YGx1LA945rM6fjmbOsIBNNIvX2sG+aEQPtQ0BGEn4Zg7r3MBAdIE5NqiGE/lLGmwEkkH1FzXBzV1zMfR+FYEiDT6grcctRrQxLVmYSIxeaQdH1s6BF2KK0wOm/quGnHuUNSu335aTo0YBEBK45KOo0x/jOGml7y6CRt72TDeriI1G8/vOwoBtBG+cQplU9mx1sRbt486WNqPfcPmqNvfdyZlT5UMZbrW7J0UgFNcclgbHNdBQZomhZwvQFO9jFvxMK2xMp3x6L9nQ2UZ9YEjzlIlxCG4vvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114005; bh=t3xzOj8q9d8Qcwi4isGT4AkkvO+2MVC1Mty8kSQ70Lv=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=B37hyURmmEA5NNvELxraPcHC+YNAp9HABd3rOzZaH8G1IgqL5Te3SLSQ+UHtPI+U9mGqbPKM2rQ/WpxIBZBpyGQHnzMj4V6vxwiS8TE54221m6ThO7joOP8TXQ8F75f38Fl93bisnyx37uDxTaYkeEGcfZYJsuYQZOskXV2VI58x8fQq3oBdxwz6WblWmqnanMWzBR+WLeZ/lhXj/DU3J0jxHv6/jUBQECK/kvYjZedMl/iEMUReWVsXGb9YcJYlNzoF0Y7TcEs7rZpGalIaGAJbQQO3ayUtsE/ljvRxmlyG5XUE/1lSOiYce5E/3bHJyC1HCwAOfLWEnwUVVtts8g==
X-YMail-OSG: .w.jv88VM1k6AI_aSHdZcvMuYYy_77DDVhdcQjD3JhnUGf.7MJ8UQ9iDix_EMMR
 ZsL_To9j3BeALa5kbtBnCVYNG3l5axt2fZHiLtBcq5OVa.IlKmmS1AT6pX1INRSpqOtGE8pxCkPi
 Hj7vgtHJCj8AK.0WDqhoPytriQJc9WHwAZAHdfP.Adgtuftuiosp9ZoiNktROl3FmRBM2sbrjZvU
 EnwIyvlMPFhZEzGMJP6IWQ7Pz4vQl__6Ddc57Mvjv03dTlMnZ3hp27yJi9xPXcXo7Pl_hNL.3r8B
 hbh9BVvDzzBfEl1DfZVFlv1c__1oahU8WVc7c8jHhx7k503wgwX.PX64g2p.M3pu2BV4s9BE4yb1
 YoeEZ2XUPnUALRk78k.th7Baq4Qu0SOzQBCEm28_NvR_jHgAx2.8H_PJ6HSOo3gmuOawhjbJxTJp
 MWvddI5L_4O1vII17k2I3.heI51z_k0k5JcDUDzq9iKecCmJ9AdshnDcv9NWVtgBxJtapwbs7yds
 N79VlZod4Zey.XuyKVtMXhfgtAW.u4b.pE2AjgEixlM0UcRfJtznMWqtOCZjhopvdKIfs3zBMMMe
 UKpVu4Kg0FxCSopAeOVGFw4aKPlEupFH_257ufBrbpJYC3gaKr0LJqwYkssQz3PGIgVBMNyZfM8u
 LQaFt0E7sn15OrwkMAdKrBrTWRzxMb7piAevpXBxhMkv4U.hbU6OqhmrGTgfZLfkQcON7ue76zMP
 iNO1gL1pfEqDWuRPVek_ilN7H8gh5J7ssRv2QHVlPkeWzWmhcPEZ5L9GXyT61Zd6q6GHYmQeceaj
 algNXwrXFKxYMJnSjQws6ME9GR_JwpdsB1s9op99v2.x.hbhr5L5ChP74fgg4d2ws5pIqRFDjiWf
 beT4q2J02lGaXBfXZsUC.SHFxi7SdgFUc2q8g0.tDTNIgAN93wIjXJpsypCMyUw9w2WfHa0zh1G1
 Ca7bwpUh1AqJU4CiLmSwOb0VfsVbvt8jhSQm0E.dC7IHh8QpzzS4FZV1KhUr.v_yXDAr1mH_Ahdr
 iU36oAoJLql3yBD_rbTcgYxoIgjvPhZ6KZWFp7g1gzw1LuUtGnltHpYOdoLT4NFeQEDuaZOulc01
 MHd4Q84Y2YSQS3AgnBuj9_PACWQTBsZnjKkM29OwdXrOoAcuZN6shsNvCBARRvXoItBIlN.tjqBA
 uN5BC7TaIkBJLBiWWA2ld2URsSdO_v_c2DesmcF7v2kXrQTBHLWwdXtsS7.6AE5m8MdflR7imFMs
 1U_Pryt7VI6HZB2nHq6NBEN_sltbDm3_5AV2jVWQXEx8moVKGyPm1eEAnRtVI5EEGyG7gYwUhIEv
 axsrasw917pe7mlDpQvtNDfTD6K.3vJfarQfXL9MpExZxrJgQOuMWK7H7.kzYTSQkrlAT_6RoTNN
 danL9EAyAsR2erPidywAVGTOug_pwEM8dmRUMXaDBEKR.D6U3_3DyVSdXTuV7kSJLtUx1ju9sESz
 ax1IrPVCvhLPPR3PN96vee87hVcB4qgWDZBOW5fEH65o.TL8OyRg1DiHnQxx6bIJdBWSOOBq1a0r
 UGh0z7_tLrboU0ebEBkNzG1kdhd7A4zCMeb_j4V2JK5HsWdWxJDDdrpKQEybkyvwHkGQ4zmR7iAV
 b45JhsddVWRG6iWQxnaXWgNyXPY7EGvsgH1xFCqcCGjM29QHyxDBYKDwPlZyRWyeyR8o6aEh36MZ
 IepSAOgsFILaHtiOqnOs_iznvCRWdG_1DTtkEMygMd2s1vpMIQAnm1R8NVzOHVK2UcFhKJW2pVSC
 rfpCL6.Ks81i0BJL.MiPLlvGlpyn4LTcSbwdE8zjhKhp.k1KDSuSvJujJee2dDKz3fK4nHgtYDqk
 2SGoIgicua6RA5QeoGqgwLqp.GtoB7z_4iRlQozhMxh.9TZdPuwHWnCt.eSWJGf6WvFSbqmH3bjt
 ukyGyygNGJrTBhS9el.piZTDR4NjO5tiTBNRfFfWJkbsRaAluaRHGydB5Qyhn3h5Jt6DJFQiFBNn
 GS7399A1dAkzXmMEqZA--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: adc2f6c3-da22-4845-8395-3192bf8521cf
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 21:53:25 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
 by hello (SMTP) with SMTP ID a34e68627d724ee34c25b40bae8a8d59;
 Tue, 22 Sep 2026 21:53:22 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH v2 0/3] drm/nouveau: HDMI Deep Color link depth (30/36/48 bpp)
Date: Tue, 22 Sep 2026 18:53:14 -0300
Message-ID: <20260922215317.611388-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260922215317.611388-1-Capitain_Jack.ref@yahoo.com>
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

This series wires up HDMI Deep Color on nouveau.  The connector gains the
"max bpc" property, the atomic check selects a link depth that both the
sink EDID (HDMI VSDB DC_30/36/48) and the TMDS character-rate budget
admit, the head is programmed for 30/36/48 bpp RGB, and the TMDS General
Control Packet carries the matching CD/PP fields.

Patch 3 is what makes the link physically work on GSP boards.  The
GV100-class GCP writers emitted a depth-less packet, and on GSP systems
the HDMI audio enable runs after the display commit and emits it again,
erasing the deep-color declaration (sor->disp->func->gsp.hdmi_gcp).  The
proprietary NVIDIA stack performs the same audio operation and then
rebuilds the GCP from the committed head depth.  Threading CD/PP through
the OUTP HDMI ctrl method (patch 2), caching them on the ior, and writing
them with a 0x00ffffff mask gives nouveau the same ordering; the mask also
keeps generation-specific bits sharing the register intact (GB20x
SB1_CTRL).

Tested on a GA106 (RTX 3060) driving a Sony KDL-46HX855 (HDMI 1.4 sink,
EDID DC_30/DC_36, 225 MHz TMDS ceiling): 1920x1080p60 RGB at 36 bpp,
i.e. a 222.75 MHz character rate.  Without the series the sink rejects
the modeset with an incompatible-signal OSD; with it the set accepts the
signal, reports a 12-bit input, and renders correctly.  The v2 30-bpp
additions follow the same wire construction (CD/PP encodings per HDMI
1.4b section 6.5.3, with CD=5 verified against the Synopsys dw-hdmi
packetizer).  The new 30-bpp arm is bench-exercised too: with "max bpc"
clamped to 10 the same sink links at 30 bpp and renders correctly, a
regression run at the default depth confirms the 36-bpp 12-bit result is
unchanged, and 1080p24 frame packing at 12 bpc (a 222.75 MHz link) and
side-by-side/top-and-bottom 3D at 12 bpc all display correctly with the
sink in 3D.  All runs are logged in the bench repository.

Changes in v2 (credit to the automated review mails on v1 for the first
two):

- patch 2: encode GCP CD/PP for 30 bpp as well (CD=5, PP from the
  four-pixel packing group, wire 0 = phase 4 per NVIDIA's phase constant
  numbering).  v1's description already promised 30/36/48 bpp, but the
  enable path only encoded the 36 and 48-bpp arms; 10 bpc was reachable
  there and would have declared the default 24 bpp on a 30-bpp wire.
- patch 2: gate SCDC scrambling and the 1:40 TMDS bit clock ratio on the
  TMDS character rate (pixel clock scaled by depth), not the raw pixel
  clock, per the HDMI 2.0 340 MHz character-rate rule.  The OUTP HDMI
  ctrl khz argument stays the pixel clock on purpose: measured on the
  bench, the 36-bpp link trained at the correct 222.75 MHz character
  rate, so the sequencer derives the scaling itself.
- patches 1 and 2: rate frame-packed 3D modes at the link clock, twice
  the mode clock, in the depth selection and the SCDC gate, as
  nouveau_connector_mode_valid() already does.  v1 used the per-eye
  clock, which could pick a depth the link cannot carry; found reading
  the bench logs, harmless on the test sink.
- patch 1 (no code change): the "max bpc" property stays attached to
  HDMI-A connectors only, matching i915.  Extending it to DVI
  connectors that feed HDMI sinks through passive adapters belongs with
  the follow-on series below, which does it; DP++ adapters stay open.

Scope and non-goals, so nobody has to guess:

- Only RGB is selected.  YCbCr output additionally needs a connector
  color-format selection path that nouveau does not have today, plus AVI
  InfoFrame colorspace/range handling and format-aware bandwidth and
  packing.  That is a follow-on series built on this one, using the DRM
  "color format" and "Broadcast RGB" properties (limited/full RGB, YCbCr
  4:4:4, 4:2:2 and 4:2:0), sent separately.
- 48 bpp (16 bpc) is implemented from DC_48, BPP_48_444 and GCP CD=7 but
  is untested: the bench has no DC_48 sink.  It might enable professional
  16-bit displays; the mechanism is the same, but we do not own the
  hardware to test or claim it.
- HDR might benefit: HDR10's baseline transport is 10-bpc YCbCr 4:2:2
  carried in a 12-bpc container, and link-depth failures feature in HDR
  reports.  The transport mechanism is the same, but we do not have
  hardware to test or claim native HDR here (static metadata and
  colorspace are separate pieces nouveau does not yet emit for HDMI).

For context: on this same bench the installed proprietary NVIDIA driver
(615.71.09, hdmi_deepcolor=Y, max_output_color_depth=10) caps this sink
at 10 bpc by default policy, while Windows on the same card reports
12 bpc; with the parameter lifted to 12 the stock Linux driver drives
this sink at 12 bpc too.  A companion one-line default-cap change for
the open NVIDIA kernel modules is in that repository as the
closed-source counterpart of this series.

Related items from the same diagnosis, for maintainers who want the full
EDID-surface picture on the proprietary stack: NVIDIA's repository tracks
three measured symptoms of the same narrowing at
https://github.com/NVIDIA/open-gpu-kernel-modules/issues/1384 (plus the
HDMI 1.4 3D VSDB sibling at .../issues/1382), with the one-line
default-cap companion PR at .../pull/1386.  Nothing there blocks this
series; it is the same disease seen from the other driver.

Normative chain this series is built and measured against: HDMI 1.4b
section 6.5.3 (General Control Packet CD/PP encodings), HDMI 2.0a
(340 MHz character-rate scrambling and clock-ratio rule), CTA-861-G
(EDID VSDB Deep Color capability bits), NVIDIA's public nvtiming.h and
display-class headers, and the in-tree Synopsys dw-hdmi packetizer, which
implements the same CD table with the same section citation.  The
reproducible bench harness, EDID dumps and test logs live at
https://github.com/danielcamposramos/sony-bravia-linux (tools/stereo-modeset);
the curated public evidence indexes are
https://github.com/danielcamposramos/awesome-stereoscopy and
https://github.com/danielcamposramos/awesome-linux-hdr.

AI partners were leveraged in the production of this work.

Daniel Campos Ramos (3):
  drm/nouveau: select HDMI deep-color link depth
  drm/nouveau: pass HDMI GCP deep-color state through NVIF
  drm/nouveau: program HDMI deep-color GCP fields

 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 110 ++++++++++++++++--
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c   |   6 +
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c   |   6 +
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c   |   6 +
 drivers/gpu/drm/nouveau/include/nvif/if0012.h |   3 +
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |   2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |   9 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h   |   1 +
 drivers/gpu/drm/nouveau/nvif/outp.c           |   7 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  |  12 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/gv100.c  |   4 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |   2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  |   4 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  |   6 +
 14 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.53.0


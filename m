Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E175C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E67D10E517;
	Tue, 22 Sep 2026 19:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="BQKQhs37";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C3810E517
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104899; bh=nDOfxoTgfCt/MAClno9vSr5ImwJy4en6RIMi/TVJbfI=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=BQKQhs37J50RNsrRe3N+w9tyvjTzYBb8BCju5fvGctcTwDP6ILhBYNYZ0lCptVUYsKV0+F7eYMJCZJuZnU1OH9EkY3Y9ji0Y2OxL3NJJ7U804L4j5HtcaIfkNXyebm3XS7RHPQGogtnUh7G6WtpLxCPsHEdBPu39jcEYVfhrPZkHgZYpbGSFiQ67roy2ePjUZxcEL1fH+msRvzpL5Ggu1PtI3X7UQt9r4O7Ik0dMOhs7M0UgYHWid+sgN8pnW15xfyKSpBZTIz+iXUhshgIJZj0FH/4xFijMGTtXZ/l/XHWPvBCvot3BtfgnRUqzqu9iJsmVnSSd7Fb/XFFDD2uysw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104899; bh=4Ftxh7RoFDFM9fCoONlDy0OYlgXLKeTzcM/6DwdBhHu=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=ujXgWySJiec640YFXKUWCn5jaoPmLPzGONL118tzTOWdM0rREV9GiwgQlN/mZyhpIqvtoy8mycCglIrsT96t9UAhNF5RjxZZ7zguwX6XjCvvluPx2zubkRV4fEDvdxl9iOatfzuWzJTc411n8eiSn365XiLz47eHTsaTU/6lRf63kdS0yfc+QXZ89BUTXT2BvXBGspirAQYMGScwb8X1rzq2VNhm7r9q9tgrmWsUMX9a7I8xYGe7E4/f6kRZU4NSDt/J5pUt45jmj041ja1wGGxehkFeR2QcfhSQ+CqlmD0A59EcjXxQUnBtQtnFubffSZwp9K7STqrLcM4acWsdXA==
X-YMail-OSG: omQoRu0VM1nn7plvZ2UVsm5PQfK.hv9aC6roGq.11HpygY7D1jT9mKsaAfWQK7t
 K0_25yPw.UHD_uRdUA57adfT.c4suelni4ObFYeW8jtF_7oW_RkhTvQMSIgAcIDH.NKQjAjjdTUl
 ZxNUWeQDx9lW10DC5HGeu4pQ4g8_plhDedTotOZTM0bCHkxjrqp23M4rnyb.JDMQ3Whs5x.2cP5G
 no6cF7ql_NLUIoTkzrUuV3PRQg44REP6hPLI0kL26PqIYpUtr0wHPiVP56NJn4uwnqsJVqwS.res
 hEX4.0uVxSngP_mrtN6DdSOt0jExFkg9ZhekPYOKCzgKKgRPxsboTr9Ab.pJMtjvi4HDjOjMOAOz
 TE2F_nwAUrqYnhuSa4Lyvnf73M8d0QDE.37ENzpWgxpK8is58EOelOVyeXeN72JjMEHZH4OWDX4c
 sNUmzqLMcBVtPEUPl0vzHetx96gNiaN6IbTbxHbtf8Nd4XFAQMndYwPscUltJVtTDCsz0qhprrlH
 xIMSDhVs5WqolGvLFj7BjuhbBmCuRG6Ceys1jbKWOjIngVXeX19QzyOCZrU6DFKYiqc_24FS4wFp
 tRCI9GZddrOhWXIrp8.3ChNl6PmGoetYHXaGpUUBplcRj2MbwZYZxfpQJDnq79w45lhX1YuFFxTY
 StEvo7_utXufK2hUICdx.snM5Bc74tV1Tkx7VI..INBvvryR0jvK1TNCvvGnQj5ODYK63ZAGIkmL
 prSnR2B5ibXk8fcaSSYLE5O7WNVyQfkPW3L3g4RYzqeFlhnPqHbQ5dWNSHk_LTJpQ7En6Cj1jk61
 xe5Vi9czSmvk.nFGUYYSp10W3fAH9YENXSUOLy.RuPeGAi4viBTdu1hkTxJ2l6JJJWHRVuT13CkS
 R6EyOc9sRJOrDvF6xUVL0oYYtaQfLjUhl2SohBqpOSrYfKFbhdIG0ZaWXsF11GbzZ29Ofwayjz.x
 ko9vyIKDz_hV4bfdoDTKPIjxOiANaDj.YPqw2U2F9_PlS9cwry_1sv_UiuD28IzqdPpT.LpbRmFQ
 3eURCo0KXC_waSW41hGQhE6M2Y4upvWkoVu9YUg5u1qNtWW2rrlnlrekf89YN_oymIxPMKe97vVC
 flWwWDeQXKBhnbRmRxpC1Gat5_PlzE354ZD4vJ.EQQABU2Kz1WjZOMedfLTewvRgP7GUbhjx5SRg
 2SSPnFs7BmIhW0nCRUMN_gfQsKJQdu5ffDf9R5YyFZJCWU69tDN.IIycbt8L0HD2dhN0bsgsimXF
 Txf4ApE8keA0ikJFkmimjiGX6B4VudsjR4YhWU0.HYOJ05R82z3cyNaYPrp_iCfrQJxX0cmOHmK4
 gNPRj4z83JGY3lQowm9q8OAUisxvNLP9e7cS4nGxNgGndquHyNIsI4vm3aDrTnfQen9OJGbr4ly6
 GtDpUfR_AQKWn.SiGJAb7LnUAIbFOcuRKiurh8YxA2sfFDlEWbtLV0mkv_jf7MeqMVUtm8ghpz3L
 VxOcOfp2XVRKEIlJCaStGOq.Ukn2ZAkKE_cDIlQGrRQV9WfA0FmKMVRValRvR.6PvrxOjXObw86K
 Tqoe0DUb3bylwgMXlw6VJvNPa7TS0i.5rbhRDmKS4WHEVQz5u6PDW5gCN.WOHfNvy0D7Ttux93ub
 WQOWgVPkMN9hiZYhvduO7tKpKQ8XFC6NvfMnPq52udr5qJlsYilsmZLJyT5XPryqT3WcG4jeGzZe
 gh5__20WXLr6pFF9j.mz1S0f5Ikd4VKqXttAqv._q.Y5ZMnYpJd0WGC32fZ9RNlD8fMUrG_AVhfX
 zmtjaqjRS3xzT7sC6r.9DDQT35VcujGs4Shfi9CcXqx6sPPd7K.cTZ_gcxIw6gaSFslK8wEfTvAw
 WY2eAba_a7dpNj8SI5AqJFPrPzTvECOQsydzdrbYEGVeIrApK2V.9H1AJzOyEyCYr7MBQ9v0bWXK
 JkhD9WOPQx2g1T.KvGiqz5xx0TGquiQpSS2m4sVM3ltE1VRNWHwcBcpnLucLS2ki_.JHzurLzVZJ
 lgRON2g--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: c3f4c507-9aeb-4c38-9b54-cb5466943159
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 19:21:39 +0000
Received: from dip49.lsn.bf1.yahoo.com ([67.195.177.58])
 by hello (SMTP) with SMTP ID a114298d351310ec48bd21743ed80317;
 Tue, 22 Sep 2026 19:21:36 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 0/3] drm/nouveau: HDMI Deep Color link depth (30/36/48 bpp)
Date: Tue, 22 Sep 2026 16:21:29 -0300
Message-ID: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260922192132.114546-1-Capitain_Jack.ref@yahoo.com>
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
signal, reports a 12-bit input, and renders correctly.  30 bpp follows
the same code paths.

Scope and non-goals, so nobody has to guess:

- Only RGB is selected.  YCbCr output additionally needs a connector
  color-format selection path that nouveau does not have today, plus AVI
  InfoFrame colorspace/range handling and format-aware bandwidth and
  packing.  That is the next series, building on the DRM connector
  color-format property work.
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
12 bpc.  A companion one-line default-cap change for the open NVIDIA
kernel modules is being submitted to its own repository as the
closed-source counterpart of this series.

AI partners were leveraged in the production of this work.

Daniel Campos Ramos (3):
  drm/nouveau: select HDMI deep-color link depth
  drm/nouveau: pass HDMI GCP deep-color state through NVIF
  drm/nouveau: program HDMI deep-color GCP fields

 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 80 +++++++++++++++++--
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c   |  6 ++
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c   |  6 ++
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c   |  6 ++
 drivers/gpu/drm/nouveau/include/nvif/if0012.h |  3 +
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  9 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.h   |  1 +
 drivers/gpu/drm/nouveau/nvif/outp.c           |  7 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 12 +--
 .../gpu/drm/nouveau/nvkm/engine/disp/gv100.c  |  4 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  |  4 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  |  6 ++
 14 files changed, 128 insertions(+), 20 deletions(-)

-- 
2.53.0


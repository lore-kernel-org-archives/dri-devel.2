Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44284C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9224B10EE8E;
	Tue, 22 Sep 2026 21:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="Km2cHfnm";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B93F10EE94
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114025; bh=rUZAn4+qNL34bUmwz1znA1X/HizHQYdaEs29wfahXLw=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=Km2cHfnm06AY7jXzOJAEvrOUbgnVKhwwoqW9KiNdCrP9oWxsZWBwa4g436b1Roz1f4PrdsE07x3URu73a4VaF5lEWF9/9ujRBchwWBc3bPSjiU2DlaR8gFa/Q9NG2xwgG7y22EHEyGULBMv5Lh0wiLw38jLXLuppa48tTEGurqM11UM2l3EaRl7tugPBwP8A3tJjumD4dUpWMGyFr97/DGkW40OLIaBDA5ldxTVAehbL18+lbrl6aA4ZIp5MzfctW1nEktPAdPHFYYBcOA5CCnxg4ecJOdqaN27GXjH+mDnUUTLpt2w+xk+YEy4gonEHm1Vws0Qkp957JH6Lq/mEqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114025; bh=UcWh9RH8GZS/5dH24HrJ4aCAQ7S/rO1C7k1CK1LNNJ0=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=etuOKs4GYWP7Eu/5rSsl8RqcQqa5j99rVBru6X1AbTpTwDXiSMNdjaSDNFukpVAZXDA9fQAeI5PhMYYuP9nkbeOSfD96Lk3TPzECDDWT1y3z7HdzE05/fcdKD622xO5EpWbopEDHV4EEcgO4hYR3DASU+b61SJYbbgfyAbc8X57AbQu3d6sntvXwryrYjIVWXhSNNscCt8/2sjTXcONLh3zf3vg7tX7BsmnOTlelFjzfOdjV0VtU3IfxoP4Tz2exVWWSTLzbcS8rZnSoDSAnV9FTXiSz1YMmTDwFZxLstz39apxTPZMhzRkSah4mTP2gyYrqwkI7+y01hG89lmIDBg==
X-YMail-OSG: 80j1xB4VM1l76yilhwv2d_LlQLlT7uXeHB6HIn.I.ILTnGspSq_9S.xRPpz.wM3
 nr1rqaL6KPOCmGIMm0ybHTJIheOOnKaMxi20sDtUkr78QqLgOk152Yd5ooM89896keLZJaej7fWA
 5acTGDIMvT2LHv1wo2ZsoyMjqoDRYDXRJVW54_AVxQ_mA3tpn_aasM45HhPS4cqUHGSPFHwXF333
 o7eyWN5t3ZRKD8BKVjFKpmUsyHcoTVU9BYazh1XiW3H_w53yBKjaimEhlKGCbMoJc6uSJQjFpNRR
 Gao4lgzDmF4nUr_mevLnCvq.r_X8G_QuknIxW3dz1zknVb6ZxRALINXmHXs693VIKvIQezUbSiG3
 fJaS8UyIFwRjhI_WYOSB5pk4xhvcpklTVBJz91n0pTuaAXTaFRsTVfRnyVHYNZcim1AGm51ybAV1
 SSZ8WfySAshMnba_9Yt2L5o6sb5HDzCq2IoZ58g9Sygg5BEoaI.quWnaIJtgA_5nTILxHKb4HAM_
 lOphwAshUSx8r2p2BnURfIyeZy9l.lSdSunYAjd.l6twfJhxStZsP_jqpgNcqLKa9ZjDgSrYxV5X
 HyT7bFzXFYAnYLa39K5iT8MgfmGNqwQPUJyxMhZhjw_1g0KMYI9bCh2s4HNTLS5AhuF_4f2x4jvU
 cnT.ueDJQ3lNSPv0IGMXYUGiRUIM1p_dmP4JYm22Gx6fyDan.RD_jEC1ZMasWnvaPzxkCJyEb.gl
 2e_ZJLs6qEIYP98P4V78R6gr4_5OE7UyHC7qsyAHWTqY2T.yv7vvcCcOEIBTdJcBxqE19.dAqPVq
 6GTAIiMBO5KvRpjUWLPC6DbeqpPlxntfRYHWO7zMp5rx6QhcRNs2qsk9kpafqfemTZmTK5GdWiOl
 .7vFkfdXyfLil1J47i9u3cAGNSfqPRM8tk8ydAXb4BmIeeJCM.grvKY2rxTbfUDHw.Hw3ampwuwY
 eNYSipyUynyNIahCm7W7EKR6tzMzbngnNYBLi1yO_QNWnUSeAHT2iZDJlDEi2qK6bkWpEsdsJJVO
 bXEJfl9l1eumxRnZJ1doilvtKaNsuBqhuZjnAONDA2JXrHbALH5ywFRs9VARmo9iixkMSb9Coo0q
 d6_v1VLwIjZjCaFA2y8QhgxvZ0Wy7WT03wNW13LV_X1Pr5WEqudM0tVB3R9QmSgQdc7xty8JMgA3
 sll7Nc4iAhtjpneTQjEL.H1AraIXWsALM9KnzJ895NbG.dE4VnXDl1W6zilNGW0lJvr5_2La7nQ0
 kf4Qxxr.PUHj7xiuzDrZNr9Io5td5TrG_KTYQyAd50xoRtc8F.p13tgevOZM2QeY5sNvSeIoeXfl
 yDYx1QTOLfcu.et8MztCkhyc3eyVmWuCmM7PJoT7msHbcXYkeEPax3qNfsWwrmq9R4qrxS2dOOxv
 iTWNkgr9.bCwpfOERz.ryy7VG5kZO6VhxeonGEuuL290GJ17_ZcaBVJpYIeKqUcINdBK06_JX5HG
 SJrYytPdWS8sU4P869vREA6jeyX.IhZr79qGurnVu.3PhjfzlJbJI7FpdknOY.ynCGVGUlr6ZFt6
 wb32B3c8q_vNJnVtZy1A7FDrOF4n3XVAU5zppHoO.W75jDlDb_ZK7VoGGfwBtq6aQkPlACQHM0G9
 wVB9zfYeb6OsDYi6ygbJnQNs0V.2eSmwwJIUZnHA6Zhs0ro4WxNczFivudf4JTKxQYWgliVQl0Od
 dApliMqsXcmItBm0HkzCkYcEQ4jxlPVA.7d2olTupdQLcb104YtklKstNSrMwoyvJ.BFZxSAH6t_
 NYSqmfNSijm065fn06zgouya1RfGERSPGSnh_mJ02nApBmtERYm1107Yd12GJ2xbd3bJnpiZue7R
 IZX1a3fDEI7lQ6jtOmgdquMq_6Crj7HKvCFoJOevcFa5tP6CjEN.sO9I4s1HE3FMEQdSXKxvK6eG
 7eUgZrzzPiemcC0bnO9BEbTfN_8MzKdHy7a40ZDWBi9UtFg6_j.seAcLpR8n8fvTVGX2xHJXfceU
 ZWozpNA31AFyVkV4TkrrVDgRRyCvFetPvoZQ9YWsngrf3ZINA
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 4b8ca253-1bf4-4e7c-82af-38fc693fe3f5
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 21:53:45 +0000
Received: from dip68.lsn.bf1.yahoo.com ([67.195.177.77])
 by hello (SMTP) with SMTP ID 98779d167a59bfbe653b3ebdee112417;
 Tue, 22 Sep 2026 21:53:39 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 0/6] drm/nouveau: HDMI output colour format and quantization
 range
Date: Tue, 22 Sep 2026 18:53:30 -0300
Message-ID: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260922215336.612239-1-Capitain_Jack.ref@yahoo.com>
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

Nouveau only ever outputs full-range RGB on HDMI.  This series adds the
standard "Broadcast RGB" and "color format" connector properties on
Turing to Ada heads and selects the pixel encoding together with the
link depth: limited or full range RGB, and YCbCr 4:4:4, 4:2:2 and 4:2:0.
It applies on top of the HDMI Deep Color series v2 (base and
prerequisite ids below).

The hardware stage was already there.  On NVC57D-class heads the final
colour conversion is HEAD_SET_PROCAMP plus the OCSC1 matrix and the
output clamp ranges; nouveau only wrote PROCAMP, hardcoded to RGB/VESA
under a TODO.  The programming follows NVIDIA's open NVKMS on the same
classes (EvoSetProcAmpC5, EvoSetOCsc1C5, the YUV420PACKER head control).
The OCSC1 matrices are the ITU-R BT.601, BT.709 and BT.2020 coefficients
at limited-range scale; re-derived independently, they match NVIDIA's
register values to within 4 in the last place, and the patch uses
NVIDIA's values so the output is bit-identical to the proprietary driver
on the same hardware.

Selection policy follows drm_hdmi_state_helper.c, with amdgpu as the
reference consumer of the "color format" property: sink rules per
format (RGB/4:4:4 Deep Color bits, 4:2:2 up to 12 bpc in the 24-bit
container, 4:2:0 through its own bits), TMDS character rates from
drm_hdmi_compute_mode_clock(), "Automatic" picking RGB and falling back
to 4:2:0, explicit requests honoured or refused.  YCbCr is limited range
with the CTA-861 default colorimetry (BT.709 above 576 lines, BT.601
below), declared in the AVI InfoFrame together with the pixel encoding.

One default changes: "Broadcast RGB" Automatic selects limited range for
CE video formats, as i915 and the HDMI helpers do.  Today nouveau sends
full-range pixels there and can only declare that to sinks with a Video
Capability Data Block, so sinks without one apply their default limited
range to full-range data.  "Full" restores the previous output.

  1: NVC57D output CSC and clamp methods (class header)
  2: program PROCAMP/OCSC1/clamps from head state (no functional change)
  3: Broadcast RGB
  4: color format with YCbCr 4:4:4 and 4:2:2
  5: YCbCr 4:2:0 on GA102+, gated per head on the capability notifier
  6: the same properties on DVI connectors, which carry HDMI to HDMI
     sinks through passive adapters (reported by the automated review
     of the Deep Color series v1)

Tested on a GA106 (RTX 3060) driving a Sony KDL-46HX855 (HDMI 1.4,
YCbCr 4:4:4 and 4:2:2, DC_30/DC_36/DC_Y444, 225 MHz, no VCDB), 25
configurations in two runs: RGB full, limited and automatic at 8/10/12
bpc; YCbCr 4:4:4 and 4:2:2 at 8/10/12 bpc; BT.601 at 576p/480p and
BT.709 from 720p; 640x480 held at 8 bpc; and side-by-side, top-and-
bottom and frame-packed 3D at 12 bpc with YCbCr 4:4:4, limited RGB and
YCbCr 4:2:2.  Every frame carried colour bars over near-black and
near-white steps; the sink accepted each signal and displayed correct
colours and levels, and the driver's selection was logged per step.

Not tested here: 4:2:0 (the sink declares none) and DVI (the board has
no DVI port); both reuse the paths exercised above.  Volta keeps its
current behaviour (NVKMS has no Volta display code to compare against)
and Blackwell (NVCA7D, same methods at a different stride) is left for
a follow-up.  The class header additions are verbatim subsets of
NVIDIA's headers and carry their usual checkpatch style findings.

Normative chain: HDMI 1.4b section 6.5 (pixel encodings, General Control
Packet), HDMI 2.0 section 7.1 (YCbCr 4:2:0), CTA-861 (AVI InfoFrame
Y/C/Q/YQ fields, default colorimetry, the QS rule), ITU-R BT.601,
BT.709 and BT.2020.  Bench harness and logs:
https://github.com/danielcamposramos/sony-bravia-linux (tools/stereo-modeset,
run27 and run28); curated public indexes:
https://github.com/danielcamposramos/awesome-linux-hdr and
https://github.com/danielcamposramos/awesome-stereoscopy.

AI partners were leveraged in the production of this work.

Daniel Campos Ramos (6):
  drm/nouveau: add NVC57D output CSC and clamp range methods
  drm/nouveau: program head output conversion for limited range and
    YCbCr
  drm/nouveau: add the Broadcast RGB property for HDMI
  drm/nouveau: add HDMI YCbCr 4:4:4 and 4:2:2 output
  drm/nouveau: add HDMI YCbCr 4:2:0 output on GA102 and later
  drm/nouveau: expose HDMI output properties on DVI connectors

 drivers/gpu/drm/nouveau/dispnv50/atom.h       |  11 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 305 +++++++++++++++---
 drivers/gpu/drm/nouveau/dispnv50/head.c       |  19 ++
 drivers/gpu/drm/nouveau/dispnv50/head.h       |   3 +
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c   | 112 +++++--
 .../drm/nouveau/include/nvhw/class/clc57d.h   |  34 ++
 .../drm/nouveau/include/nvhw/class/clc673.h   |  17 +
 .../drm/nouveau/include/nvhw/class/clc67d.h   |  16 +
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  48 ++-
 9 files changed, 488 insertions(+), 77 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/include/nvhw/class/clc673.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvhw/class/clc67d.h


base-commit: 73ef663c75688168e31dbe9c585b939be410a945
prerequisite-patch-id: 6bd193908862475dd809b40037984747467236d6
prerequisite-patch-id: bf3b51b5393ef1c612930f4c474e6852372ca7db
prerequisite-patch-id: 22c3f84b6576853e9d3053d4e5a15a4bd37e6dcd
-- 
2.53.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7152AC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B64310E33E;
	Mon, 21 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AR+UqiGP";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242EE10E8C9
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:39:07 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-52fb766bfd3so5193201cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789738746; cv=none;
 d=google.com; s=arc-20260327;
 b=r2uNEIN+phNqVB77OXYSMC1q3PJ3N7K9YmQOdKXfjeGB39L/OB9n3AW6L2sVLKfJJ4
 vHN75k1E2/O/SUV7+/UQD2fNnHqOACiabexN8vZg/Yay8pgNKLDu8VT6kVRREwQpT+Hd
 8sBzuJrY+TNeTiBc2d7mg7mQxiWa32b98XqGLREowacaTMjtTDKOAehDfHZJY1vq9APZ
 jlygutXcb+DYhI2lxMOF6JBuIko9F+FewaiYEa8XvHanPLUCABPNHURqtoUKRytc2qmZ
 1LvVQk06zeFUPC0eidLIv+IFiWYFywdS9Bn0Lw/wdvgOW9Ah9n598+RAVkuBmJOH9p1T
 CnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=8shZtkh2erMmBxc3KBWifQ9XLT/eyycvKuYPngX8/v8=;
 fh=zmTf8bfGPs1KSwS6TrxVLc1WIVxoydMUuFoBJyE2QWs=;
 b=nSeSdQpmqQG/A6DoAVU7a7WsPqsRi58iSKV/TuZMqyCw4gKnQttTyGEW6dtyYGIx3O
 QHbekO3eisvvlx/oldFZ9EGCTiFUmZDABElCo6LQPaaaoJMV3RVXLVkIS33aQY250wsj
 8CnWFRvZrSHYsK9jk9GKluzD+3EfNzpAXG/ZX753Tf2Bkh3t2ssIao2r0YfPtscgeL6V
 4qOTaY7iFMDWyzMn0JBiJoEv2owU0eJK64pbnXeHMFeTY9Oh+ZRuOFWI04fCBe/X73oE
 8i/RSuhkk7lYBsSSIRo7McQwHJ7vFyf1xA2d+CZFrgpHPBy6mMqm1UBVeF7riQ881w6s
 zGFA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789738746; x=1790343546; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8shZtkh2erMmBxc3KBWifQ9XLT/eyycvKuYPngX8/v8=;
 b=AR+UqiGP6PFfUYAF470H50aL9A6jWXSbFDic51IvAkeyS90MXgENKlyz/Vkydfs0FT
 A2/tlKLIJm0maPWuzeWFwgkn7pNJRVcfaS5tVJbkzv6qFSaPqDnMDx53ccNba3im+zom
 LvRck7gBbzDcWvCZ9Y9jDAWf2TH25j4YwzRTlNehJBsrko9LJWPA6USBNUrQhFqZetag
 8t6r+Yvy8UE4XQ5SV4ocUJbelf9Ytng8F6MhPS5FxyIXOfnH7j8DFGDD7tiU591vLX1B
 zzj0ePOoorhse4N30aqCDQDn7OeY8JpV24qZVMy5HFsedI4acT6QPE0NYmzaDcydR5Nx
 eluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789738746; x=1790343546;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8shZtkh2erMmBxc3KBWifQ9XLT/eyycvKuYPngX8/v8=;
 b=1PkHEKNlyHp5ECMeyD1F5bLQ+vj9C7lc8KACJtc5u+oeg87z7WuiAN2mB9667zkuue
 Fas2CHO8KXLTUGSyPpFK/vFdbyBkMLVQd2RvR+oqQS3TVF4pwyQKJ48lXGB782x+H2Cq
 v3i1YfAkXZEAjKfUAc6kWRiQLK1cR7KRDqI41hgLMQDvcnfNKcp/DocujNdw9ap4/dcK
 kip4MsX8rwnQIASJ2mJ/bnPYTCmg6HdTaRyW8mSq2jfW+deImDdiy+9U+XqrmPmV5TW7
 pD8skPj/mwLt+njgUWkG3Pc4lSBMS7D2JqtuL9zMAeBUbGqv5KKp3iq0GOZpWUFZxqBf
 3fbQ==
X-Gm-Message-State: AFuF++n/ooyPomoEzhv+Ol7WQyPRtdnt5lB+tb/F5b9Fxhko7Ziudc0I
 5yMnDjvB2PTeGv7g4RAZKuhtKgjArUHzu33w46BX3IlMfUHqDLDzCWMuWMxJEJlpg3cUGTukxGM
 ay3pM51PR+mHwiHuGsIT1Av/zw+/a6vRDGvw6jfE=
X-Gm-Gg: AYBFou3ZfJAbW/V4v2QQyDfsrs3jSgIoqoGCeBmeS3BTHWiC4Wz8P9c05zKxLGo5IHe
 QEZtbTLg9Np8tcm4muwMjJ4z7biRPPkH1Vc6dMJrbD/+1rO/LlmFjLH+RdjgbC9rK9gehiK9KwJ
 ey87+MCxP7rrwZo37IlP1Sx+t9Mxne3i2L5/drFYr6L0rZSTACO3iyqdNsDZ7XIpmUylNwqwfS+
 hjInIPLaa1QeheANIpNwGkFpS1GMB3xxFAQt/bK/jCESO3Qe4frGGNwMJz5ADUadDwR+JZ0I9+R
 aP9VbIFJsGJ02RdJfMs/Xrj9FPGHTA2dplnXfToAhqUOjHycjiH0bqprHk3u0uShFf2NIVVqs1E
 kVWaONgKrC6UbcLFfMwOrOoK/tmQycfhLnnfsfKiKCljBTxb9fqSKj2ccBh5l4/M1TvXXnmfRhf
 Glan7LcWqW+rDF6GrQ39U/SEV1HZyccA==
X-Received: by 2002:a05:622a:48a:b0:532:9adc:63a5 with SMTP id
 d75a77b69052e-5329e4ff2ffmr35896301cf.73.1789738745727; Fri, 18 Sep 2026
 06:39:05 -0700 (PDT)
MIME-Version: 1.0
From: Daniele Parravicini <dparravicini@gmail.com>
Date: Fri, 18 Sep 2026 15:38:54 +0200
X-Gm-Features: AcwNN1WToQZtjBBnTlgOHU8nYVKK5lZ7UGzu5-aQVhHctGt1f_pobkDHzrJGpI8
Message-ID: <CA+eWHqcvKvBoW=piGbbRLOMQi99Hsd_Qo3Ge+BGAMQ1ucOg03w@mail.gmail.com>
Subject: [PATCH 0/2] drm/nouveau: fix dual-mode DisplayPort connectors losing
 the output
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Hi,

the external Mini-DisplayPort output of an Apple MacBook5,1 (NVIDIA C79 /
GeForce 9400M, 10de:0863) never appears in /sys/class/drm: only LVDS-1 is
listed, so the output cannot be used at all.  The VBIOS describes that
connector with two outputs sharing the same connector index:

    disp: conn 01:0146: type 46 loc 1 hpd 02 dp 2 ...
    disp: outp 01:0002:0242: type 02 (TMDS) loc 0 or 2 link 1 con 1 ...
    disp: outp 02:0006:0242: type 06 (DP)   loc 0 or 2 link 1 con 1 ...

nvkm_uconn_uevent() picks the first output whose connector index matches, i.e.
the TMDS one without an AUX channel, so a NVIF_CONN_EVENT_V0_IRQ request ends
up in the GPIO path and is refused with -EINVAL.  nouveau_connector_create()
treats that as fatal and destroys connector and output.

With that fixed, ddc_detect() shows the second half of the problem: it also
walks the encoders in list order, so a sink that is really speaking
DisplayPort is probed through the TMDS/DDC path first and reported as
disconnected because its EDID cannot be read from that bus.

Tested with a Samsung U28E590 on the Mini-DisplayPort output (Linux 7.2.5):
the connector is created, its IRQ event is registered on the DP output,
nouveau_dp_detect() returns NOUVEAU_DP_SST, and 1920x1080@60 and 2560x1440@60
work.  Native 3840x2160 is limited to 30 Hz by the DP 1.1 link of this GPU;
on this particular panel 4K@30 trains but leaves the panel asleep, which I
believe is a separate sink-side issue and not covered here.

Comments welcome.

Daniele Parravicini (2):
  drm/nouveau/nvkm: pick an AUX-capable output for DP IRQ events
  drm/nouveau: probe the DP output first on DisplayPort connectors

 drivers/gpu/drm/nouveau/nouveau_connector.c      | 23 ++++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 22 +++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

From fa3c4fb42c735323ef48214c174dc112e637303c Mon Sep 17 00:00:00 2001
From: Daniele Parravicini <dparravicini@gmail.com>
Date: Thu, 18 Sep 2026 15:55:00 +0200
Subject: [PATCH 1/2] drm/nouveau/nvkm: pick an AUX-capable output for
DP IRQ events

nvkm_uconn_uevent() picks the first output whose connector index matches, and
decides how to service the requested events from that output alone.

A connector can be driven by more than one output: on dual-mode connectors
(eg. Apple Mini-DP) both a TMDS and a DP output carry the same connector
index.  The TMDS output has no AUX channel, so a request for
NVIF_CONN_EVENT_V0_IRQ ends up in the GPIO path, where it is refused with
-EINVAL:

if (!outp->info.location && !nvkm_connector_is_dp_dms(conn->info.type))
return -EINVAL;

nouveau_connector_create() treats that error as fatal and destroys the
connector, so the external output disappears entirely (only LVDS-1 is left in
/sys/class/drm).

Prefer an output that can actually service the request: when IRQ events are
asked for, use the first matching output with an AUX channel, falling back to
the previous behaviour when there is none.

Diagnosed on a MacBook5,1 (GeForce 9400M, C79) with a Samsung U28E590 on the
Mini-DisplayPort output: the connector is created and its IRQ event is
registered on the DP output instead of being dropped.

Signed-off-by: Daniele Parravicini <dparravicini@gmail.com>
---
  drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c |   22 +++++++++++++++++++---
  1 file changed, 19 insertions(+), 3 deletions(-)
---
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
index 23d1e5c..319352e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
@@ -98,6 +98,7 @@ nvkm_uconn_uevent(struct nvkm_object *object, void
*argv, u32 argc, struct nvkm_
  struct nvkm_disp *disp = conn->disp;
  struct nvkm_device *device = disp->engine.subdev.device;
  struct nvkm_outp *outp;
+ struct nvkm_outp *iter;
  union nvif_conn_event_args *args = argv;
  u64 bits = 0;

@@ -110,12 +111,27 @@ nvkm_uconn_uevent(struct nvkm_object *object,
void *argv, u32 argc, struct nvkm_
  if (argc != sizeof(args->v0) || args->v0.version != 0)
  return -ENOSYS;

- list_for_each_entry(outp, &conn->disp->outps, head) {
- if (outp->info.connector == conn->index)
+ /* A connector can be driven by more than one output: on dual-mode
+ * connectors (eg. Apple Mini-DP) both a TMDS and a DP output carry the
+ * same connector index.  DP IRQ events can only be serviced by an output
+ * that has an AUX channel, and picking the wrong one makes event setup
+ * fail, which in turn makes DRM drop the connector completely.
+ */
+ outp = NULL;
+ list_for_each_entry(iter, &conn->disp->outps, head) {
+ if (iter->info.connector != conn->index)
+ continue;
+
+ if (!(args->v0.types & NVIF_CONN_EVENT_V0_IRQ) || iter->dp.aux) {
+ outp = iter;
  break;
+ }
+
+ if (!outp)
+ outp = iter;
  }

- if (&outp->head == &conn->disp->outps)
+ if (!outp)
  return -EINVAL;

  if (disp->rm.client.gsp) {

From 4d3bc3d57988c5fb6f2c976e66f5ec7a8b921eb7 Mon Sep 17 00:00:00 2001
From: Daniele Parravicini <dparravicini@gmail.com>
Date: Thu, 18 Sep 2026 15:55:00 +0200
Subject: [PATCH 2/2] drm/nouveau: probe the DP output first on
DisplayPort connectors

nouveau_connector_ddc_detect() walks the encoders attached to the connector in
list order.  On a dual-mode DisplayPort connector both a TMDS and a DP output
are attached to the same connector and HPD presence is shared by both, so the
TMDS output is picked first: a sink in DP mode is then taken for a DVI/HDMI
sink and its EDID is read from a DDC bus that doesn't exist, losing the
display.

Ask the DP output first for DP-capable connectors.  Only it can tell whether
the sink is really speaking DisplayPort; if it is not, the previous TMDS/DDC
path is still tried.

Diagnosed on a MacBook5,1 (GeForce 9400M, C79): HPD reads present and the
monitor answers on AUX (nvkm-...-aux-0008), but the connector was reported
disconnected because the EDID was read from the TMDS DDC bus.

Signed-off-by: Daniele Parravicini <dparravicini@gmail.com>
---
  drivers/gpu/drm/nouveau/nouveau_connector.c |   23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)
---
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b0b0ad9..3628e6d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -417,6 +417,29 @@ nouveau_connector_ddc_detect(struct drm_connector
*connector)
  int ret;
  bool switcheroo_ddc = false;

+ /* Dual-mode DisplayPort connectors (eg. Apple Mini-DP) carry both a TMDS
+ * and a DP output on the same connector, and HPD presence is shared by
+ * both of them.  Probing them in list order would pick the TMDS output
+ * first and read EDID from a DDC bus that doesn't exist, even when the
+ * sink is connected in DP mode.  Ask the DP output first: only it can
+ * tell whether the sink is really speaking DisplayPort.
+ */
+ if (conn->type == DCB_CONNECTOR_DMS59_DP0 ||
+    conn->type == DCB_CONNECTOR_DMS59_DP1 ||
+    conn->type == DCB_CONNECTOR_DP ||
+    conn->type == DCB_CONNECTOR_mDP ||
+    conn->type == DCB_CONNECTOR_USB_C ||
+    conn->type == DCB_CONNECTOR_eDP) {
+ nv_encoder = find_encoder(connector, DCB_OUTPUT_DP);
+ if (nv_encoder && nvif_object_constructed(&nv_encoder->outp.object)) {
+ ret = nouveau_dp_detect(conn, nv_encoder);
+ if (ret == NOUVEAU_DP_MST)
+ return NULL;
+ if (ret == NOUVEAU_DP_SST)
+ return nv_encoder;
+ }
+ }
+
  drm_connector_for_each_possible_encoder(connector, encoder) {
  nv_encoder = nouveau_encoder(encoder);

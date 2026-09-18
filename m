Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C90AC982F5
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327A710E349;
	Mon, 21 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lY6u/Bvh";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A557C10F4CC
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 19:40:44 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-5308fc4b716so6516021cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789760443; cv=none;
 d=google.com; s=arc-20260327;
 b=FrnO89wxarmWcfH9aBeh97DB1128dE+nkfdhEuk6NCGAQgV/SV04c/38qCEy1QnEXM
 dJIg6oMllIcBlHxhCSaDSocClet1JcyPC0Ruia4bb1ADwuGc1uMzX5RKAl4Q4V5kCwkK
 A5lgP+ymlD4JURTrxYq7m2XQjsQUtrqEGp+iVy5MPKrLpedylvcPExIiXIss6ZrUhHXB
 V4ju5X9t5O/xQWmiyHUKN4IB3jyW7AgkZrZznygMqszl/ROoWfoV1BrvXM4pe4LBnF16
 uNtx7O48GwsWpaKjopjJW88TV+32QIjh7HOTptkQjbie0X76L0Xp5hwir0opFBuGO9c+
 z7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=+j9LDH9I11RX04jTocwiaPxb0PRQV2ZYvZsDO5Upvoo=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=QOiK+k8Hfq51g89Eix9lXM5RMhmvFXcoufC0nWdMsdj11yEfxrEMLEHfkU/zEPb/UP
 jgR18pmhri0p+PE9q7IPMwWcnz825Mls5rI/W47wYDxrJOMzkmL1y2XZaKEqicTu4AYz
 gbPHQ1+olb/t+qsk5tEVbdMn5r2GaTmBF8n5iHiA+HtC1z12CFcGAwY6IQF1ncz3GLDQ
 0FOHo/2xnUqfn6uCq/ORwh7pTEyfKxwWtjaJxTEqSnKEzuxT9OC5A89eYB8quWTjhObr
 oepLH0jnLHqSUTP6dYFmOb6R2I7dwYQHkDz6hLNKPRn9gih1UwHfhi/qcb8/LvwRrYwA
 YOxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789760443; x=1790365243; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+j9LDH9I11RX04jTocwiaPxb0PRQV2ZYvZsDO5Upvoo=;
 b=lY6u/Bvhp4hnetGEJEBcYc5VMLg00OIgn91KO05FnDJS1ThubCYk8+Gi35/rIX3E29
 BMvkbpMEFHgK/F0QCtxaqpE9PAUYINGkSaS32T1a2Kzz/bljzHhfzCJOb55O0/BVwfcu
 kJZhb7CCXZJfHbHobZMFO3iLy4O0htOw5jMbXQ81mZ9QVvv8TSJH+gKy9wZbgskFpI5r
 8RtJ1/aVtrbH/rIEiXl0junFNB008Nrrma5Hp3ETiF3mlnoGLp08H12LpybAwzo1SJ5w
 J1iyBbhNcg5TamlbExJB/fSDzbZoYOxxoqHI5gAEUh+Shrb5YwKN+j/TYtDF/xkM9tGR
 TU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789760443; x=1790365243;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+j9LDH9I11RX04jTocwiaPxb0PRQV2ZYvZsDO5Upvoo=;
 b=U2EGPAjoaQxgp4O6HRli6j6vjSWlcmgGXH7TxYJQ44Yt+xc8KcmUnhtiwuMYMhQ7uP
 sgLHI00IRB5RdGHx0wggfr1tg7WUVY8HyWpxMzPS8JFNXGw4o48Of/PnqtKr8P18X4TZ
 WSxDO03ShAuZ7BUqnhEOZ8xks0r4oTZ2Hu0aVWSqm02ISkUeeuLfWqqWOvlUX/Ba/4eM
 pgJTtAG/mCyy5zLIMvwSYDgGPgnSaXA7USv2aE4jTyiQi7fudqCCav4YYhceKXCvLka9
 WzfIWeeHl98t7V+HZqFglOm0jtvNVmoWFOadvi2rhIQ7t2ubkSRxhE2+Zi6OZhm+p0GI
 32AA==
X-Gm-Message-State: AFuF++nbx0KZRyux7WvBVkye7b81dHvMpagTpUgwgFZTX1VJQlNSRK2M
 GArsHefJbHlZqb9YGyS2ru63bsPmukxfFnlw9jkan88OZ3m6W0S8ckLxssDbwxRd9/KVdd+HUTC
 PackcQw91hAWjwHabN9y31qzYB/7smUoz8R5K2qo=
X-Gm-Gg: AYBFou0J+ihfsa5vMIdTOBgdSj1g6zRjrgkCnjRcj9FlbyFUrxQb43ClW87bRekh+pY
 qNF+4v/schoDJA3wXLMWTN0bQgRHaRRiRND8cohmVv1kG5ceNYrM9/jk1+J3p5yOBkdu3+yjPSh
 Dj99se6tmgnl58ZevvLbu7xig1i6+HsBU+Il5bcehoPVvPVuPHEPR7Bx6qPEkxMkuSFbKVIqwve
 KnNvq63sWPHfjk7ttxbnxEmRzXciHMpgoM+C+UzVTeFVfKguccPQsCiqYqdgWE0d/GfUKmCzssF
 H5mLb6OkwNkuSxfJkRuuWqir0tjAStYotgv4vQU3+XcULrvNgvF/qUiuGxcbNctfAzZAnJUZ4le
 NZWqYTfJuj8OmDlyGPcESGGJCfY7+ZfEfpi1HBWqFV0FYzpW+S3FbeX4voNFcJahrLD/oXVhZK5
 qSLc7nSbnkF44QIOPxoSlt1ZWQdj3Uew==
X-Received: by 2002:a05:622a:138c:b0:530:42e6:b18d with SMTP id
 d75a77b69052e-5329e494ff4mr62864031cf.43.1789760438324; Fri, 18 Sep 2026
 12:40:38 -0700 (PDT)
MIME-Version: 1.0
From: Daniele Parravicini <dparravicini@gmail.com>
Date: Fri, 18 Sep 2026 21:40:25 +0200
X-Gm-Features: AcwNN1XmziRoOx_3Ijia9UgfUCYYxrEgbo6h3kyZHBMfvmhF9zNmBUvRDwl0a88
Message-ID: <CA+eWHqeG97Md3XnuMzHJq8tS+c4xj1p+zxDAZkha+z7DO0MshA@mail.gmail.com>
Subject: [PATCH 0/2] drm/nouveau: fix dual-mode DisplayPort connectors losing
 the output
To: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000028d448065bc7133b"
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

--00000000000028d448065bc7133b
Content-Type: text/plain; charset="UTF-8"

Hi,

the external Mini-DisplayPort output of an Apple MacBook5,1 (NVIDIA C79 /
GeForce 9400M, 10de:0863) never appears in /sys/class/drm: only LVDS-1 is
listed, so the output cannot be used at all.  The VBIOS describes that
connector with two outputs sharing the same connector index:

    disp: conn 01:0146: type 46 loc 1 hpd 02 dp 2 ...
    disp: outp 01:0002:0242: type 02 (TMDS) loc 0 or 2 link 1 con 1 ...
    disp: outp 02:0006:0242: type 06 (DP)   loc 0 or 2 link 1 con 1 ...

nvkm_uconn_uevent() picks the first output whose connector index matches,
i.e.
the TMDS one without an AUX channel, so a NVIF_CONN_EVENT_V0_IRQ request
ends
up in the GPIO path and is refused with -EINVAL.  nouveau_connector_create()
treats that as fatal and destroys connector and output.

With that fixed, ddc_detect() shows the second half of the problem: it also
walks the encoders in list order, so a sink that is really speaking
DisplayPort is probed through the TMDS/DDC path first and reported as
disconnected because its EDID cannot be read from that bus.

Tested with a Samsung U28E590 on the Mini-DisplayPort output (Linux 7.2.5):
the connector is created, its IRQ event is registered on the DP output,
nouveau_dp_detect() returns NOUVEAU_DP_SST, and 1920x1080@60 and
2560x1440@60
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

nvkm_uconn_uevent() picks the first output whose connector index matches,
and
decides how to service the requested events from that output alone.

A connector can be driven by more than one output: on dual-mode connectors
(eg. Apple Mini-DP) both a TMDS and a DP output carry the same connector
index.  The TMDS output has no AUX channel, so a request for
NVIF_CONN_EVENT_V0_IRQ ends up in the GPIO path, where it is refused with
-EINVAL:

if (!outp->info.location && !nvkm_connector_is_dp_dms(conn->info.type))
return -EINVAL;

nouveau_connector_create() treats that error as fatal and destroys the
connector, so the external output disappears entirely (only LVDS-1 is left
in
/sys/class/drm).

Prefer an output that can actually service the request: when IRQ events are
asked for, use the first matching output with an AUX channel, falling back
to
the previous behaviour when there is none.

Diagnosed on a MacBook5,1 (GeForce 9400M, C79) with a Samsung U28E590 on the
Mini-DisplayPort output: the connector is created and its IRQ event is
registered on the DP output instead of being dropped.

Signed-off-by: Daniele Parravicini <dparravicini@gmail.com>
---
  drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c |   22
+++++++++++++++++++---
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

nouveau_connector_ddc_detect() walks the encoders attached to the connector
in
list order.  On a dual-mode DisplayPort connector both a TMDS and a DP
output
are attached to the same connector and HPD presence is shared by both, so
the
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

--00000000000028d448065bc7133b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>the external Mini-DisplayPort output of an Appl=
e MacBook5,1 (NVIDIA C79 /<br>GeForce 9400M, 10de:0863) never appears in /s=
ys/class/drm: only LVDS-1 is<br>listed, so the output cannot be used at all=
.=C2=A0 The VBIOS describes that<br>connector with two outputs sharing the =
same connector index:<br><br>=C2=A0 =C2=A0 disp: conn 01:0146: type 46 loc =
1 hpd 02 dp 2 ...<br>=C2=A0 =C2=A0 disp: outp 01:0002:0242: type 02 (TMDS) =
loc 0 or 2 link 1 con 1 ...<br>=C2=A0 =C2=A0 disp: outp 02:0006:0242: type =
06 (DP) =C2=A0 loc 0 or 2 link 1 con 1 ...<br><br>nvkm_uconn_uevent() picks=
 the first output whose connector index matches, i.e.<br>the TMDS one witho=
ut an AUX channel, so a NVIF_CONN_EVENT_V0_IRQ request ends<br>up in the GP=
IO path and is refused with -EINVAL. =C2=A0nouveau_connector_create()<br>tr=
eats that as fatal and destroys connector and output.<br><br>With that fixe=
d, ddc_detect() shows the second half of the problem: it also<br>walks the =
encoders in list order, so a sink that is really speaking<br>DisplayPort is=
 probed through the TMDS/DDC path first and reported as<br>disconnected bec=
ause its EDID cannot be read from that bus.<br><br>Tested with a Samsung U2=
8E590 on the Mini-DisplayPort output (Linux 7.2.5):<br>the connector is cre=
ated, its IRQ event is registered on the DP output,<br>nouveau_dp_detect() =
returns NOUVEAU_DP_SST, and 1920x1080@60 and 2560x1440@60<br>work.=C2=A0 Na=
tive 3840x2160 is limited to 30 Hz by the DP 1.1 link of this GPU;<br>on th=
is particular panel 4K@30 trains but leaves the panel asleep, which I<br>be=
lieve is a separate sink-side issue and not covered here.<br><br>Comments w=
elcome.<br><br>Daniele Parravicini (2):<br>=C2=A0 drm/nouveau/nvkm: pick an=
 AUX-capable output for DP IRQ events<br>=C2=A0 drm/nouveau: probe the DP o=
utput first on DisplayPort connectors<br><br>=C2=A0drivers/gpu/drm/nouveau/=
nouveau_connector.c =C2=A0 =C2=A0 =C2=A0| 23 ++++++++++++++++++<br>=C2=A0dr=
ivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 22 +++++++++++++++---<br>=
=C2=A02 files changed, 42 insertions(+), 3 deletions(-)<br><br>From fa3c4fb=
42c735323ef48214c174dc112e637303c Mon Sep 17 00:00:00 2001<br>From: Daniele=
 Parravicini &lt;<a href=3D"mailto:dparravicini@gmail.com">dparravicini@gma=
il.com</a>&gt;<br>Date: Thu, 18 Sep 2026 15:55:00 +0200<br>Subject: [PATCH =
1/2] drm/nouveau/nvkm: pick an AUX-capable output for<br>DP IRQ events<br><=
br>nvkm_uconn_uevent() picks the first output whose connector index matches=
, and<br>decides how to service the requested events from that output alone=
.<br><br>A connector can be driven by more than one output: on dual-mode co=
nnectors<br>(eg. Apple Mini-DP) both a TMDS and a DP output carry the same =
connector<br>index.=C2=A0 The TMDS output has no AUX channel, so a request =
for<br>NVIF_CONN_EVENT_V0_IRQ ends up in the GPIO path, where it is refused=
 with<br>-EINVAL:<br><br>if (!outp-&gt;info.location &amp;&amp; !nvkm_conne=
ctor_is_dp_dms(conn-&gt;info.type))<br>return -EINVAL;<br><br>nouveau_conne=
ctor_create() treats that error as fatal and destroys the<br>connector, so =
the external output disappears entirely (only LVDS-1 is left in<br>/sys/cla=
ss/drm).<br><br>Prefer an output that can actually service the request: whe=
n IRQ events are<br>asked for, use the first matching output with an AUX ch=
annel, falling back to<br>the previous behaviour when there is none.<br><br=
>Diagnosed on a MacBook5,1 (GeForce 9400M, C79) with a Samsung U28E590 on t=
he<br>Mini-DisplayPort output: the connector is created and its IRQ event i=
s<br>registered on the DP output instead of being dropped.<br><br>Signed-of=
f-by: Daniele Parravicini &lt;<a href=3D"mailto:dparravicini@gmail.com">dpa=
rravicini@gmail.com</a>&gt;<br>---<br>=C2=A0 drivers/gpu/drm/nouveau/nvkm/e=
ngine/disp/uconn.c | =C2=A0 22 +++++++++++++++++++---<br>=C2=A0 1 file chan=
ged, 19 insertions(+), 3 deletions(-)<br>---<br>diff --git a/drivers/gpu/dr=
m/nouveau/nvkm/engine/disp/uconn.c<br>b/drivers/gpu/drm/nouveau/nvkm/engine=
/disp/uconn.c<br>index 23d1e5c..319352e 100644<br>--- a/drivers/gpu/drm/nou=
veau/nvkm/engine/disp/uconn.c<br>+++ b/drivers/gpu/drm/nouveau/nvkm/engine/=
disp/uconn.c<br>@@ -98,6 +98,7 @@ nvkm_uconn_uevent(struct nvkm_object *obj=
ect, void<br>*argv, u32 argc, struct nvkm_<br>=C2=A0 struct nvkm_disp *disp=
 =3D conn-&gt;disp;<br>=C2=A0 struct nvkm_device *device =3D disp-&gt;engin=
e.subdev.device;<br>=C2=A0 struct nvkm_outp *outp;<br>+ struct nvkm_outp *i=
ter;<br>=C2=A0 union nvif_conn_event_args *args =3D argv;<br>=C2=A0 u64 bit=
s =3D 0;<br><br>@@ -110,12 +111,27 @@ nvkm_uconn_uevent(struct nvkm_object =
*object,<br>void *argv, u32 argc, struct nvkm_<br>=C2=A0 if (argc !=3D size=
of(args-&gt;v0) || args-&gt;v0.version !=3D 0)<br>=C2=A0 return -ENOSYS;<br=
><br>- list_for_each_entry(outp, &amp;conn-&gt;disp-&gt;outps, head) {<br>-=
 if (outp-&gt;info.connector =3D=3D conn-&gt;index)<br>+ /* A connector can=
 be driven by more than one output: on dual-mode<br>+ * connectors (eg. App=
le Mini-DP) both a TMDS and a DP output carry the<br>+ * same connector ind=
ex.=C2=A0 DP IRQ events can only be serviced by an output<br>+ * that has a=
n AUX channel, and picking the wrong one makes event setup<br>+ * fail, whi=
ch in turn makes DRM drop the connector completely.<br>+ */<br>+ outp =3D N=
ULL;<br>+ list_for_each_entry(iter, &amp;conn-&gt;disp-&gt;outps, head) {<b=
r>+ if (iter-&gt;info.connector !=3D conn-&gt;index)<br>+ continue;<br>+<br=
>+ if (!(args-&gt;v0.types &amp; NVIF_CONN_EVENT_V0_IRQ) || iter-&gt;dp.aux=
) {<br>+ outp =3D iter;<br>=C2=A0 break;<br>+ }<br>+<br>+ if (!outp)<br>+ o=
utp =3D iter;<br>=C2=A0 }<br><br>- if (&amp;outp-&gt;head =3D=3D &amp;conn-=
&gt;disp-&gt;outps)<br>+ if (!outp)<br>=C2=A0 return -EINVAL;<br><br>=C2=A0=
 if (disp-&gt;rm.client.gsp) {<br><br>From 4d3bc3d57988c5fb6f2c976e66f5ec7a=
8b921eb7 Mon Sep 17 00:00:00 2001<br>From: Daniele Parravicini &lt;<a href=
=3D"mailto:dparravicini@gmail.com">dparravicini@gmail.com</a>&gt;<br>Date: =
Thu, 18 Sep 2026 15:55:00 +0200<br>Subject: [PATCH 2/2] drm/nouveau: probe =
the DP output first on<br>DisplayPort connectors<br><br>nouveau_connector_d=
dc_detect() walks the encoders attached to the connector in<br>list order.=
=C2=A0 On a dual-mode DisplayPort connector both a TMDS and a DP output<br>=
are attached to the same connector and HPD presence is shared by both, so t=
he<br>TMDS output is picked first: a sink in DP mode is then taken for a DV=
I/HDMI<br>sink and its EDID is read from a DDC bus that doesn&#39;t exist, =
losing the<br>display.<br><br>Ask the DP output first for DP-capable connec=
tors.=C2=A0 Only it can tell whether<br>the sink is really speaking Display=
Port; if it is not, the previous TMDS/DDC<br>path is still tried.<br><br>Di=
agnosed on a MacBook5,1 (GeForce 9400M, C79): HPD reads present and the<br>=
monitor answers on AUX (nvkm-...-aux-0008), but the connector was reported<=
br>disconnected because the EDID was read from the TMDS DDC bus.<br><br>Sig=
ned-off-by: Daniele Parravicini &lt;<a href=3D"mailto:dparravicini@gmail.co=
m">dparravicini@gmail.com</a>&gt;<br>---<br>=C2=A0 drivers/gpu/drm/nouveau/=
nouveau_connector.c | =C2=A0 23 +++++++++++++++++++++++<br>=C2=A0 1 file ch=
anged, 23 insertions(+)<br>---<br>diff --git a/drivers/gpu/drm/nouveau/nouv=
eau_connector.c<br>b/drivers/gpu/drm/nouveau/nouveau_connector.c<br>index b=
0b0ad9..3628e6d 100644<br>--- a/drivers/gpu/drm/nouveau/nouveau_connector.c=
<br>+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c<br>@@ -417,6 +417,29 =
@@ nouveau_connector_ddc_detect(struct drm_connector<br>*connector)<br>=C2=
=A0 int ret;<br>=C2=A0 bool switcheroo_ddc =3D false;<br><br>+ /* Dual-mode=
 DisplayPort connectors (eg. Apple Mini-DP) carry both a TMDS<br>+ * and a =
DP output on the same connector, and HPD presence is shared by<br>+ * both =
of them.=C2=A0 Probing them in list order would pick the TMDS output<br>+ *=
 first and read EDID from a DDC bus that doesn&#39;t exist, even when the<b=
r>+ * sink is connected in DP mode.=C2=A0 Ask the DP output first: only it =
can<br>+ * tell whether the sink is really speaking DisplayPort.<br>+ */<br=
>+ if (conn-&gt;type =3D=3D DCB_CONNECTOR_DMS59_DP0 ||<br>+ =C2=A0 =C2=A0co=
nn-&gt;type =3D=3D DCB_CONNECTOR_DMS59_DP1 ||<br>+ =C2=A0 =C2=A0conn-&gt;ty=
pe =3D=3D DCB_CONNECTOR_DP ||<br>+ =C2=A0 =C2=A0conn-&gt;type =3D=3D DCB_CO=
NNECTOR_mDP ||<br>+ =C2=A0 =C2=A0conn-&gt;type =3D=3D DCB_CONNECTOR_USB_C |=
|<br>+ =C2=A0 =C2=A0conn-&gt;type =3D=3D DCB_CONNECTOR_eDP) {<br>+ nv_encod=
er =3D find_encoder(connector, DCB_OUTPUT_DP);<br>+ if (nv_encoder &amp;&am=
p; nvif_object_constructed(&amp;nv_encoder-&gt;outp.object)) {<br>+ ret =3D=
 nouveau_dp_detect(conn, nv_encoder);<br>+ if (ret =3D=3D NOUVEAU_DP_MST)<b=
r>+ return NULL;<br>+ if (ret =3D=3D NOUVEAU_DP_SST)<br>+ return nv_encoder=
;<br>+ }<br>+ }<br>+<br>=C2=A0 drm_connector_for_each_possible_encoder(conn=
ector, encoder) {<br>=C2=A0 nv_encoder =3D nouveau_encoder(encoder);</div>

--00000000000028d448065bc7133b--

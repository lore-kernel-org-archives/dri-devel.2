Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D4FFF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 15:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AF310E1E0;
	Sun, 26 Apr 2026 15:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="DgfNZvgO";
	dkim-atps=neutral
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5129A10E1E0
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1777216625; x=1777475825;
 bh=EK4gdgh+FUAnAWgd9x1j6WVQbhJEp+zFygIhIQtiEAw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=DgfNZvgO+TZ7oTpY4GJx5iDsifJ846z9XD8Nw31DE975MrOFlrmiBdHxniQ8dgNEj
 5yLf4rDKELQVO/Vov/JFSHrfR0fOffhy6lhNMfWkecciMruTB6lgdfto/m1aJQSBCA
 jBH8lRW2NTp07RdbxOqpPcnRkWxlmfy3Vym+oCdmZH663PKj0T5XTK+15nrweFtxpc
 COWljfziVnRfrya+QiSkmuDhq57OG+dZvpVvHIFVHpWkunrsOrR+eYiYzvLLFMmnBU
 +eODFlxVl2V9v/BfR64WDr6/wx0WKGjAb8S7aL3v5yEnz0z58MPMU7KemjRZY+/5BP
 QNbGzn0lFLcsQ==
Date: Sun, 26 Apr 2026 15:16:58 +0000
To: dri-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniel@fooishbar.org>
Subject: [PATCH] drm/fourcc: document format naming scheme
Message-ID: <20260426151641.93763-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: d4f50a22495a116103f60ee25d98495641d5bb86
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

When adding a new format, one needs to pick a name and fourcc.
This is not always an easy task: figuring out why current formats
are named this way is tricky.

Document current practice to make that process easier.

See previous discussion at:
https://lore.kernel.org/all/aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvBLf=
MPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=3D@emersion.fr=
/

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Stone <daniel@fooishbar.org>
---
 include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ac66fa93b5a3..dc737c4fa5f2 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -38,6 +38,45 @@ extern "C" {
  * fourcc code, a Format Modifier may optionally be provided, in order to
  * further describe the buffer's format - for example tiling or compressio=
n.
  *
+ * Formats
+ * -------
+ *
+ * Formats describe how a buffer is interpreted to decode pixel color and =
alpha
+ * values. Formats are uniquely identified by a four character code (fourc=
c).
+ * Memory layout is always described in little-endian order.
+ *
+ * The following channels are defined:
+ *
+ * - "R", red
+ * - "G", green
+ * - "B", blue
+ * - "A", alpha
+ * - "C", color index (for paletted formats)
+ * - "D", darkness (inverse relationship between channel value and brightn=
ess)
+ * - "Y", luma/brightness
+ * - "U", blue-difference chroma (Cb)
+ * - "V", red-difference chroma (Cr)
+ * - "X", a placeholder for undefined/unused contents
+ *
+ * Formats using the RGB color model have names made up of a list of chann=
els
+ * followed by the number of bits used by each channel, respectively. Any
+ * padding is explicitly indicated by the special "X" channel. Channels us=
e
+ * unsigned integers, except when suffixed by "F" to indicate IEEE 754 flo=
ats.
+ * An underscore "_" can be used to delimit planes.
+ *
+ * Multi-planar YUV formats use the following naming scheme for the most p=
art:
+ *
+ * - The first letter indicates the number of planes, channel alignment an=
d
+ *   ordering. It is should not be a letter already used to denote a chann=
el.
+ * - The first digit indicates chroma sub-sampling: 0 for 2x2, 2 for 2x1, =
4 for
+ *   none.
+ * - The two other digits indicate bits for the Y channel. If the Cb chann=
el
+ *   comes before Cr, the digits are reversed.
+ *
+ * Fourccs are allocated on a first-come, first-served basis. New format n=
ames
+ * and fourccs should try to use the same naming scheme as existing, simil=
ar
+ * formats.
+ *
  * Format Modifiers
  * ----------------
  *
--=20
2.54.0



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341EBC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C9410E6CD;
	Mon, 20 Jul 2026 07:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Bwqbjtjq";
	dkim-atps=neutral
X-Greylist: delayed 664 seconds by postgrey-1.36 at gabe;
 Thu, 16 Jul 2026 15:06:29 UTC
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEF510E351
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:06:28 +0000 (UTC)
X-KPN-MessageId: 5f222859-8126-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 5f222859-8126-11f1-83b1-005056ab378f;
 Thu, 16 Jul 2026 16:55:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=to:date:message-id:subject:mime-version:content-type:from;
 bh=b48V2mjHWtO3DRxcg0I7El8TeH9sLhSUkfEF2Fih+nA=;
 b=BwqbjtjqEyBz0gxGSu6vGGH+++GN8cgttZEmiHIPMBaMbWrcDDhzQTRL6cKpfUx3aROj/iz+ZXSvk
 dckN2oOdxgTSsicdXvOuP7V1QLU9QO6ryNii8CqBmyBEDMVUf+1ksdAM9O1peLbp5fbQvyJmXtnrZf
 y11fNMu8iXwgrpkSGzsd8ZHOpZ/8UAn9nvWApSrMAWi5/haD7CLuaQHY5tagjyV0GzTPPYlkSUG/XY
 4TxmbZcIj9hriwhpNZ1IBoHC6Idla/jdguZPhfn03tUb/8WWuZkpicJSMXux7hoE3rbFsdHcHKKe/L
 bUf9LpyGqbWJlT/q+WuQbPfVC5k21yw==
X-KPN-MID: 33|vTbzhwvOSD9S7gcWt1KykwtGfEO35dmAd1JvMErXoRE7cph1uocz8/1RW0YvnUM
 ffOfpZWk/72n5EUSvZvefarOw6jAepHmdDZ3DGOXVSXM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XMBJ2ekhgyqFVkwC43UGX6ffaHluPDwmwQ41akygCRQ+hDBgO2LQqn/GLUGy7SU
 gHFK6pWNZHEgOlfXikkPzCg==
X-Originating-IP: 80.60.70.196
Received: from smtpclient.apple (80-60-70-196.fixed.kpn.net [80.60.70.196])
 by smtp.xs4all.nl (Halon) with ESMTPSA
 id 5ec8a675-8126-11f1-86b1-005056ab7584;
 Thu, 16 Jul 2026 16:55:22 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [PATCH] drm/nouveau/disp: Prevent division-by-zero during DisplayPort
 link training transitions
Message-Id: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
Date: Thu, 16 Jul 2026 16:55:10 +0200
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Dear Nouveau Maintainers,
=20
Please find below a proposed patch to prevent a division-by-zero kernel =
oops and subsequent lockup in the Nouveau display supervisor engine when =
DisplayPort links transition to 0 active lanes. This bug was observed =
and patched/tested against the mainline kernel version **7.1.3**, but is =
present in all current upstream code.
=20
---
=20
### BRIEF EXPLANATION
=20
During screen sleep transitions or multi-input display switches (KVM =
switching), the active lane count of a DisplayPort link can temporarily =
drop to 0 (`ior->dp.nr =3D=3D 0`).=20
=20
When this occurs, the DisplayPort supervisor function =
`nv50_disp_super_2_2_dp` is invoked via modeset interrupts. Without an =
early-exit guard, the function attempts to perform symbols/hblank and =
link rate calculations that divide by `ior->dp.nr`, resulting in a =
kernel division-by-zero math exception, lockup, and system freeze.
=20
This patch adds an early-exit check at the beginning of =
`nv50_disp_super_2_2_dp` to abort display configuration when the link =
training lanes count is zero.

*   **Tested Kernel Version:** `7.1.3` (mainline stable branch)

---

### EXTREMELY DETAILED TECHNICAL BREAKDOWN

#### 1. Hardware Context
This bug has been consistently reproduced on a Lenovo ThinkPad T430 =
(Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset) connected to =
a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338) with dual =
external monitors on dock DisplayPorts (`DP-2` and `DP-3`).=20

#### 2. Root Cause Analysis (Code Level)
Inside `drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`, when =
`ior->dp.nr =3D=3D 0`, the driver executes the following lines in =
`nv50_disp_super_2_2_dp()`:

*   **Line 1179:** Calculations for horizontal blank symbols:
    ```c
    h =3D h - (3 * ior->dp.ef) - (12 / ior->dp.nr);
    ```
*   **Line 1185:** Calculations for vertical blank symbols:
    ```c
    v =3D v - ((36 / ior->dp.nr) + 3) - 1;
    ```
*   **Line 1190:** Calculations for active link data rate:
    ```c
    link_data_rate =3D (khz * head->asy.or.depth / 8) / ior->dp.nr;
    ```

In all three instances, the denominator `ior->dp.nr` is `0`, causing an =
immediate kernel math exception in the display workqueue =
(`nouveau_display_hpd_work` or `nv50_disp_super`), locking up the =
graphics pipeline, freezing the screen, and hanging any reboot attempts =
(requiring a physical hard reset).

#### 3. Daily Workday Trigger Scenario
1.  The T430 (via dock) and a secondary workstation are both connected =
to different inputs on the same external monitors.
2.  The monitors' input sources are switched to the secondary =
workstation.
3.  At the end of the day, the secondary workstation goes to sleep or is =
shut down.
4.  With no active inputs, the external monitors enter power-saving =
standby mode.
5.  When the user subsequently wakes up or interacts with the T430, the =
driver attempts a modeset refresh. Since the monitors are asleep and =
inputs are switched away, the lanes count is read as `0`, triggering the =
division-by-zero oops.

#### 4. Stack Trace (Oops Log)
```text
[di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC responded, but =
no EDID for DP-2
[di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC responded, but =
no EDID for DP-3
[di jul 23 10:28:26 2024] Workqueue: nvkm-disp nv50_disp_super [nouveau]
[di jul 23 10:28:26 2024] RIP: 0010:nv50_disp_super_2_2_dp+0xa7/0x320 =
[nouveau]
[di jul 23 10:28:26 2024]  ? nv50_disp_super_2_2_dp+0xa7/0x320 [nouveau]
[di jul 23 10:28:26 2024]  nv50_disp_super_2_2+0xf2/0x160 [nouveau]
[di jul 23 10:28:26 2024]  nv50_disp_super+0x139/0x280 [nouveau]
```

#### 5. Verification Proof (Bypass Log)
With the patch applied and running on kernel `7.1.3-custom #2`, the =
screen standby transition was bypassed cleanly. The driver caught the =
lane count of 0, bypassed display configuration, and proceeded to put =
the graphics chip into its low-power runtime suspend state (`suspended`) =
without locking up the OS:
```text
[45162.232371] nouveau 0000:01:00.0: disp: DP link is inactive (lanes =3D =
0), skipping display configuration.
[45162.232402] nouveau 0000:01:00.0: disp: DP link is inactive (lanes =3D =
0), skipping display configuration.
[45178.605627] nouveau 0000:01:00.0: timeout
[45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0 [nouveau]
[45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini timeout, 8e061008
[45182.608521] nouveau 0000:01:00.0: timeout
[45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190 [nouveau]
```

---

Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
---

### CHOOSE ONE OF THE PATCH OPTIONS BELOW TO APPEND:

#### OPTION A: The Silent Production Patch (RECOMMENDED FOR UPSTREAM)
*Note: Kernel maintainers generally reject warnings or print spam for =
expected hardware sleep/disconnect transitions. A silent return is the =
preferred upstream pattern.*

```diff
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
index 51c045bdfcbb..ab1bc0898def 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head, =
struct nvkm_ior *ior)
 {
 	struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
=20
+	/* If the DisplayPort link is inactive (0 lanes), skip =
configuration */
+	if (ior->dp.nr =3D=3D 0)
+		return;
+
 	const u32 khz =3D head->asy.hz / 1000;
 	const u32 linkKBps =3D ior->dp.bw * 27000;
 	const u32 symbol =3D 100000;
```

#### OPTION B: The Warning/Verbose Patch (What was tested locally)
*Note: Prints warning logs to the kernel buffer for validation and =
troubleshooting.*

```diff
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
index 51c045bdfcbb..ab1bc0898def 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head, =
struct nvkm_ior *ior)
 {
 	struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
=20
+	/* If the DisplayPort link is inactive (0 lanes), skip =
configuration */
+	if (ior->dp.nr =3D=3D 0) {
+		nvkm_warn(subdev, "DP link is inactive (lanes =3D 0), =
skipping display configuration.\n");
+		return;
+	}
+
 	const u32 khz =3D head->asy.hz / 1000;
 	const u32 linkKBps =3D ior->dp.bw * 27000;
 	const u32 symbol =3D 100000;
```


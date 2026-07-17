Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D748CC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9256A10E6E0;
	Mon, 20 Jul 2026 07:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="Mdsh7jL3";
	dkim-atps=neutral
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755D110F49F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:15:20 +0000 (UTC)
X-KPN-MessageId: a4f84db2-81b7-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a4f84db2-81b7-11f1-a055-005056abad63;
 Fri, 17 Jul 2026 10:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=to:message-id:date:from:subject:mime-version:content-type;
 bh=UpJIZizX98khuMkS+abb9UPzC4RW9RMi5Gev4m1cMAg=;
 b=Mdsh7jL3N1scC2EZEaUJG49+p/cEhd2GjqvsX0wxCAT3PGILP1RnnHvKZzS/ZlHE6itQnIeGqzdHF
 Wb3QmjVnRnvMzs5kJD3nmTvikHYKI8coQBORJza3C+EdeENGHf3jAj9MTk41DdXsYyZAE4eMg1Eiti
 Fa8GwWDpYcik4b+ysogHNrxzodlcqOMHLvjk/MIbtyJEX+u+aMhU7KkNjU4T2/RRgUK7wXdF1Bube0
 MRC3Gxji/LeUCZDJruyyUfUWCnN9vgNsjw0umn04x+FdBpJ1VT3OgLmTTtghggoPQ+GK1+HDs9rYfB
 uBVwhlADEsiwiWeb9IQiqCMBWgp6Pdw==
X-KPN-MID: 33|E7BNZZuytpKoD+gtSzqskNjWEWVAU+8v8/OKSzhk20m7pltalSCfBA5w8e7HF47
 f9d4LDCZbl5ny1y+Yyqgh5N1VnACA0VJYLz3glzbpodY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7fj3Xilr2ozx8819yR03JGIE7vbDVvGa9LNNaRg1J1VglbODRE+s+ctrCEvEX4m
 RhxmXbpJJUOmpFMCDgSgnUQ==
X-Originating-IP: 80.60.70.196
Received: from smtpclient.apple (80-60-70-196.fixed.kpn.net [80.60.70.196])
 by smtp.xs4all.nl (Halon) with ESMTPSA
 id a474e3a5-81b7-11f1-86b1-005056ab7584;
 Fri, 17 Jul 2026 10:15:17 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] drm/nouveau/disp: Prevent division-by-zero during
 DisplayPort link training transitions
From: Arjan Filius <iafilius@xs4all.nl>
In-Reply-To: <d51b99262dd7feb96d245926fcec65890f35c59d.camel@redhat.com>
Date: Fri, 17 Jul 2026 10:15:01 +0200
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BF6102D-CBBC-4C98-8E74-F2AD208A7169@xs4all.nl>
References: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
 <d51b99262dd7feb96d245926fcec65890f35c59d.camel@redhat.com>
To: lyude@redhat.com
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

Hello Lyude,

Yes, I did use generative AI to help refine and structure this (old) =
patch.
It is completely based on work/debug/fixing I had done manually few =
years back.=20
Generative AI helped me to send the message, but re-used my old patched =
code, brushed up a bit.
And tested it this week on kernel 7.1.3, but previous tested on 6.8.0.x =
and 6.9.9 kernels.

In 2024 i submitted a bug report/fix/workaround (to prevent a full =
lockup every day) on the Freedesktop GitLab under Issue 377:
https://gitlab.freedesktop.org/drm/nouveau/-/issues/377

Back then, my local workaround was a bit less elegant, and had a few =
extra checks/debug statements.
I had almost forgotten about the issue since my workaround was running =
fine.
When I recently booted up a clean mainline 7.1.3 kernel and saw the =
system freeze again within a day and every day,=20
and had to fsck my disks due to it, I remembered the fix I once debugged =
and posted in 2024.=20
I wanted to see if I could find a cleaner, more elegant solution and =
used AI for it, to see if the patch could be in a nicer place,=20
but ended up to basically reproduce the fix i had written in 2024 =
(without AI).


Regarding the two patches (A and B):=20
* **Patch B** was the version I compiled and tested locally with the =
`nvkm_warn()` statement
  so I could verify in `dmesg` that the standby transitions were =
actually triggering the block and being safely bypassed.
* **Patch A** is the exact same check but silent (without the warning =
logs).

To avoid any confusion i repeat my patch, which does not produce any =
logging every time,=20
but just avoids the lockup referencing null pointers when external =
displays goes to sleep.


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

This completely fixes my lenovo T430(NVIDIA NVS 5400M) + 4338 Dock and 2 =
external (multi-input) monitors freeze, proven over some years.
At the time the nvidia kernel driver on my T430 became an issue wih =
newer kernels, and notice nouveau driver did pretty well too.

Hope this claries it.

Best regards,
Arjan Filius


> On 16 Jul 2026, at 22:40, lyude@redhat.com wrote:
>=20
> Hi, can you please clarify whether or not you used generative AI for
> this patch series? If so, this needs to be noted as part of the commit
> message. Additionally, both of these patches look to be identical
> except that one prints a message and the other doesn't. You can just
> send a single version, we will figure out how to handle that part
> after.
>=20
> On Thu, 2026-07-16 at 16:55 +0200, Arjan Filius wrote:
>> Dear Nouveau Maintainers,
>> =20
>> Please find below a proposed patch to prevent a division-by-zero
>> kernel oops and subsequent lockup in the Nouveau display supervisor
>> engine when DisplayPort links transition to 0 active lanes. This bug
>> was observed and patched/tested against the mainline kernel version
>> **7.1.3**, but is present in all current upstream code.
>> =20
>> ---
>> =20
>> ### BRIEF EXPLANATION
>> =20
>> During screen sleep transitions or multi-input display switches (KVM
>> switching), the active lane count of a DisplayPort link can
>> temporarily drop to 0 (`ior->dp.nr =3D=3D 0`).=20
>> =20
>> When this occurs, the DisplayPort supervisor function
>> `nv50_disp_super_2_2_dp` is invoked via modeset interrupts. Without
>> an early-exit guard, the function attempts to perform symbols/hblank
>> and link rate calculations that divide by `ior->dp.nr`, resulting in
>> a kernel division-by-zero math exception, lockup, and system freeze.
>> =20
>> This patch adds an early-exit check at the beginning of
>> `nv50_disp_super_2_2_dp` to abort display configuration when the link
>> training lanes count is zero.
>>=20
>> *   **Tested Kernel Version:** `7.1.3` (mainline stable branch)
>>=20
>> ---
>>=20
>> ### EXTREMELY DETAILED TECHNICAL BREAKDOWN
>>=20
>> #### 1. Hardware Context
>> This bug has been consistently reproduced on a Lenovo ThinkPad T430
>> (Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset) connected
>> to a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338) with dual
>> external monitors on dock DisplayPorts (`DP-2` and `DP-3`).=20
>>=20
>> #### 2. Root Cause Analysis (Code Level)
>> Inside `drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`, when `ior-
>>> dp.nr =3D=3D 0`, the driver executes the following lines in
>> `nv50_disp_super_2_2_dp()`:
>>=20
>> *   **Line 1179:** Calculations for horizontal blank symbols:
>>     ```c
>>     h =3D h - (3 * ior->dp.ef) - (12 / ior->dp.nr);
>>     ```
>> *   **Line 1185:** Calculations for vertical blank symbols:
>>     ```c
>>     v =3D v - ((36 / ior->dp.nr) + 3) - 1;
>>     ```
>> *   **Line 1190:** Calculations for active link data rate:
>>     ```c
>>     link_data_rate =3D (khz * head->asy.or.depth / 8) / ior->dp.nr;
>>     ```
>>=20
>> In all three instances, the denominator `ior->dp.nr` is `0`, causing
>> an immediate kernel math exception in the display workqueue
>> (`nouveau_display_hpd_work` or `nv50_disp_super`), locking up the
>> graphics pipeline, freezing the screen, and hanging any reboot
>> attempts (requiring a physical hard reset).
>>=20
>> #### 3. Daily Workday Trigger Scenario
>> 1.  The T430 (via dock) and a secondary workstation are both
>> connected to different inputs on the same external monitors.
>> 2.  The monitors' input sources are switched to the secondary
>> workstation.
>> 3.  At the end of the day, the secondary workstation goes to sleep or
>> is shut down.
>> 4.  With no active inputs, the external monitors enter power-saving
>> standby mode.
>> 5.  When the user subsequently wakes up or interacts with the T430,
>> the driver attempts a modeset refresh. Since the monitors are asleep
>> and inputs are switched away, the lanes count is read as `0`,
>> triggering the division-by-zero oops.
>>=20
>> #### 4. Stack Trace (Oops Log)
>> ```text
>> [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC responded,
>> but no EDID for DP-2
>> [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC responded,
>> but no EDID for DP-3
>> [di jul 23 10:28:26 2024] Workqueue: nvkm-disp nv50_disp_super
>> [nouveau]
>> [di jul 23 10:28:26 2024] RIP: 0010:nv50_disp_super_2_2_dp+0xa7/0x320
>> [nouveau]
>> [di jul 23 10:28:26 2024]  ? nv50_disp_super_2_2_dp+0xa7/0x320
>> [nouveau]
>> [di jul 23 10:28:26 2024]  nv50_disp_super_2_2+0xf2/0x160 [nouveau]
>> [di jul 23 10:28:26 2024]  nv50_disp_super+0x139/0x280 [nouveau]
>> ```
>>=20
>> #### 5. Verification Proof (Bypass Log)
>> With the patch applied and running on kernel `7.1.3-custom #2`, the
>> screen standby transition was bypassed cleanly. The driver caught the
>> lane count of 0, bypassed display configuration, and proceeded to put
>> the graphics chip into its low-power runtime suspend state
>> (`suspended`) without locking up the OS:
>> ```text
>> [45162.232371] nouveau 0000:01:00.0: disp: DP link is inactive (lanes
>> =3D 0), skipping display configuration.
>> [45162.232402] nouveau 0000:01:00.0: disp: DP link is inactive (lanes
>> =3D 0), skipping display configuration.
>> [45178.605627] nouveau 0000:01:00.0: timeout
>> [45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0 [nouveau]
>> [45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini timeout,
>> 8e061008
>> [45182.608521] nouveau 0000:01:00.0: timeout
>> [45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190 [nouveau]
>> ```
>>=20
>> ---
>>=20
>> Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
>> ---
>>=20
>> ### CHOOSE ONE OF THE PATCH OPTIONS BELOW TO APPEND:
>>=20
>> #### OPTION A: The Silent Production Patch (RECOMMENDED FOR UPSTREAM)
>> *Note: Kernel maintainers generally reject warnings or print spam for
>> expected hardware sleep/disconnect transitions. A silent return is
>> the preferred upstream pattern.*
>>=20
>> ```diff
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> index 51c045bdfcbb..ab1bc0898def 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> @@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head,
>> struct nvkm_ior *ior)
>>  {
>>  	struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
>> =20
>> +	/* If the DisplayPort link is inactive (0 lanes), skip
>> configuration */
>> +	if (ior->dp.nr =3D=3D 0)
>> +		return;
>> +
>>  	const u32 khz =3D head->asy.hz / 1000;
>>  	const u32 linkKBps =3D ior->dp.bw * 27000;
>>  	const u32 symbol =3D 100000;
>> ```
>>=20
>> #### OPTION B: The Warning/Verbose Patch (What was tested locally)
>> *Note: Prints warning logs to the kernel buffer for validation and
>> troubleshooting.*
>>=20
>> ```diff
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> index 51c045bdfcbb..ab1bc0898def 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>> @@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head,
>> struct nvkm_ior *ior)
>>  {
>>  	struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
>> =20
>> +	/* If the DisplayPort link is inactive (0 lanes), skip
>> configuration */
>> +	if (ior->dp.nr =3D=3D 0) {
>> +		nvkm_warn(subdev, "DP link is inactive (lanes =3D 0),
>> skipping display configuration.\n");
>> +		return;
>> +	}
>> +
>>  	const u32 khz =3D head->asy.hz / 1000;
>>  	const u32 linkKBps =3D ior->dp.bw * 27000;
>>  	const u32 symbol =3D 100000;
>> ```
>=20


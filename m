Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94438606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8775A10EC79;
	Mon, 26 Oct 2026 08:36:50 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F83D10E29B
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 17:14:45 +0000 (UTC)
X-KPN-MessageId: 90b0e53e-d097-11f1-b424-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 90b0e53e-d097-11f1-b424-005056aba152;
 Sun, 25 Oct 2026 18:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=to:date:subject:mime-version:content-type:message-id:from;
 bh=BXQJ+gKHcmdmXJ2OE1ptmrjfk8EeLbE57OgzsDLSBBU=;
 b=fJfUZooaIG6Y9qOTQTIe8I4YlDUYPY3a7TaOPOu56Fj2jcR/Fp4gUPrbS0823C0lkFpQfw9MIkT63
 Gmz2j+aKuNhcWGT5u3Ah9y8KrG61Nnnoeu9c69a6GQIGQbdrwLLpMiBRC1OXy1ysdnyVhYoAniHVJ7
 jSVY14igtLo1R5Z2b+3onHByIdnFCCzq8LzPQE0M9PL0X43FRHUSFcb3By2/JnYmbCkA0P0JEKA2Js
 cd4kCg2AEsYpk5e8f11FImFNfmC9IB7OtS51Gx8C5RHcjztZX+RG0cI1QtK4nr7CGCMjvavKahFQUR
 zmabkNdWB9t/X410GnncVeX3y6WnNPA==
X-KPN-MID: 33|L8UMG8GQLU2eR5Wpv4xkxqNC/0dLM/C2yPx4IQvQI7EzMeEapczW8ebv/GJIuw7
 QEbOKYQOzs33dcwZcohVEpPZF7gpB1ZlLshBZv1IeTTk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zqONYCRnlo5tbs28rLqgfeCy9FmBIlKr3TWqjKYflme4M78E3I7XWPwVJ5fCIl1
 l5KQyg8xESx1J+WuRvZuQ1A==
Received: from smtpclient.apple (80-60-70-196.fixed.kpn.net [80.60.70.196])
 by smtp.xs4all.nl (Halon) with ESMTPSA
 id 908f1409-d097-11f1-b538-005056ab7584;
 Sun, 25 Oct 2026 18:14:41 +0100 (CET)
From: Arjan Filius <iafilius@xs4all.nl>
Message-Id: <EB2FB627-5EFE-4572-81D9-3D965C868C90@xs4all.nl>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_319B43AF-C230-406A-89A4-0D04D2A02767"
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] drm/nouveau/disp: Prevent division-by-zero during
 DisplayPort link training transitions
Date: Sun, 25 Oct 2026 18:14:30 +0100
In-Reply-To: <3c9ad85d1a773ab44ddfd0c101e2127e58e962fb.camel@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To: lyude@redhat.com
References: <69D67A9F-1A56-4814-AE68-50559DED42AF@xs4all.nl>
 <d51b99262dd7feb96d245926fcec65890f35c59d.camel@redhat.com>
 <6BF6102D-CBBC-4C98-8E74-F2AD208A7169@xs4all.nl>
 <2de49c1551bef14f30776221c10e43ebf1305ff6.camel@redhat.com>
 <32FD1A55-E5FA-40E5-BB7E-7A7524CB8AF9@xs4all.nl>
 <3c9ad85d1a773ab44ddfd0c101e2127e58e962fb.camel@redhat.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Apple-Mail=_319B43AF-C230-406A-89A4-0D04D2A02767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Lyude,

Thanks for the update, and good luck with the move! Totally understand =
being swamped=E2=80=94take your time.

Here is the patch with the original, concise commit message from 2024 =
restored (no LLM text, and only the single silent early-return patch):

---

From: Arjan Filius <iafilius@xs4all.nl>
Subject: [PATCH v2] drm/nouveau/disp: Prevent divide by zero after =
screen wake-up

On a Lenovo T430, dock, using DisplayPort and 2 4K external screens, a =
divide=20
crash happens in nv50_disp_super_2_2_dp() after waking up the screens =
when the=20
monitors were in power save (or switched to another input), because =
ior->dp.nr=20
drops to 0.

This causes:
- Screen lockup
- High system load after the issue is triggered
- Hangs during reboot

Fix this by returning early if the link has 0 active lanes (ior->dp.nr =
=3D=3D 0)
before doing the division calculations.

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/377
Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c | 4 ++++
 1 file changed, 4 insertions(+)

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
--=20
2.45.2


> On 23 Oct 2026, at 19:17, lyude@redhat.com wrote:
>=20
> On Sun, 2026-10-18 at 13:01 +0200, Arjan Filius wrote:
>> Hi Lyude,
>> Just a friendly gentle ping on this patch whenever you have a chance =
to take a look.
>> No rush if you're still swamped with runtime PM work, but wanted to =
check in to see if you need anything else from my side (or if you'd =
prefer me to resend it as a standalone [PATCH v2] formatted with =
git-format-patch).
>> Thanks again for your time!
>=20
> I will try to review this asap, unfortunately I am quite swamped and =
in the middle of moving - so I need to focus on the stuff that's =
assigned on my plate this week.
>=20
> I think the one thing that would be appreciated is if you could re-add =
the old commit message you had before generating the new one with an LLM =
- it was easier to read IMO.
>=20
>> Best regards,
>> Arjan Filius
>>=20
>>> On 5 Aug 2026, at 19:29, lyude@redhat.com wrote:
>>>=20
>>> JFYI - going to try to review/test this ASAP, just been sidetracked
>>> chasing some big runtime PM issues in nouveau atm :S
>>>=20
>>> On Fri, 2026-07-17 at 10:15 +0200, Arjan Filius wrote:
>>>> Hello Lyude,
>>>>=20
>>>> Yes, I did use generative AI to help refine and structure this =
(old)
>>>> patch.
>>>> It is completely based on work/debug/fixing I had done manually few
>>>> years back.=20
>>>> Generative AI helped me to send the message, but re-used my old
>>>> patched code, brushed up a bit.
>>>> And tested it this week on kernel 7.1.3, but previous tested on
>>>> 6.8.0.x and 6.9.9 kernels.
>>>>=20
>>>> In 2024 i submitted a bug report/fix/workaround (to prevent a full
>>>> lockup every day) on the Freedesktop GitLab under Issue 377:
>>>> https://gitlab.freedesktop.org/drm/nouveau/-/issues/377
>>>>=20
>>>> Back then, my local workaround was a bit less elegant, and had a =
few
>>>> extra checks/debug statements.
>>>> I had almost forgotten about the issue since my workaround was
>>>> running fine.
>>>> When I recently booted up a clean mainline 7.1.3 kernel and saw the
>>>> system freeze again within a day and every day,=20
>>>> and had to fsck my disks due to it, I remembered the fix I once
>>>> debugged and posted in 2024.=20
>>>> I wanted to see if I could find a cleaner, more elegant solution =
and
>>>> used AI for it, to see if the patch could be in a nicer place,=20
>>>> but ended up to basically reproduce the fix i had written in 2024
>>>> (without AI).
>>>>=20
>>>>=20
>>>> Regarding the two patches (A and B):=20
>>>> * **Patch B** was the version I compiled and tested locally with =
the
>>>> `nvkm_warn()` statement
>>>>   so I could verify in `dmesg` that the standby transitions were
>>>> actually triggering the block and being safely bypassed.
>>>> * **Patch A** is the exact same check but silent (without the =
warning
>>>> logs).
>>>>=20
>>>> To avoid any confusion i repeat my patch, which does not produce =
any
>>>> logging every time,=20
>>>> but just avoids the lockup referencing null pointers when external
>>>> displays goes to sleep.
>>>>=20
>>>>=20
>>>> ```diff
>>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>> index 51c045bdfcbb..ab1bc0898def 100644
>>>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>> @@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head =
*head,
>>>> struct nvkm_ior *ior)
>>>>  {
>>>>  	struct nvkm_subdev *subdev =3D &head->disp->engine.subdev;
>>>> =20
>>>> +	/* If the DisplayPort link is inactive (0 lanes), skip
>>>> configuration */
>>>> +	if (ior->dp.nr =3D=3D 0)
>>>> +		return;
>>>> +
>>>>  	const u32 khz =3D head->asy.hz / 1000;
>>>>  	const u32 linkKBps =3D ior->dp.bw * 27000;
>>>>  	const u32 symbol =3D 100000;
>>>> ```
>>>>=20
>>>> This completely fixes my lenovo T430(NVIDIA NVS 5400M) + 4338 Dock
>>>> and 2 external (multi-input) monitors freeze, proven over some =
years.
>>>> At the time the nvidia kernel driver on my T430 became an issue wih
>>>> newer kernels, and notice nouveau driver did pretty well too.
>>>>=20
>>>> Hope this claries it.
>>>>=20
>>>> Best regards,
>>>> Arjan Filius
>>>>=20
>>>>=20
>>>>> On 16 Jul 2026, at 22:40, lyude@redhat.com wrote:
>>>>>=20
>>>>> Hi, can you please clarify whether or not you used generative AI
>>>>> for
>>>>> this patch series? If so, this needs to be noted as part of the
>>>>> commit
>>>>> message. Additionally, both of these patches look to be identical
>>>>> except that one prints a message and the other doesn't. You can
>>>>> just
>>>>> send a single version, we will figure out how to handle that part
>>>>> after.
>>>>>=20
>>>>> On Thu, 2026-07-16 at 16:55 +0200, Arjan Filius wrote:
>>>>>> Dear Nouveau Maintainers,
>>>>>> =20
>>>>>> Please find below a proposed patch to prevent a division-by-zero
>>>>>> kernel oops and subsequent lockup in the Nouveau display
>>>>>> supervisor
>>>>>> engine when DisplayPort links transition to 0 active lanes. This
>>>>>> bug
>>>>>> was observed and patched/tested against the mainline kernel
>>>>>> version
>>>>>> **7.1.3**, but is present in all current upstream code.
>>>>>> =20
>>>>>> ---
>>>>>> =20
>>>>>> ### BRIEF EXPLANATION
>>>>>> =20
>>>>>> During screen sleep transitions or multi-input display switches
>>>>>> (KVM
>>>>>> switching), the active lane count of a DisplayPort link can
>>>>>> temporarily drop to 0 (`ior->dp.nr =3D=3D 0`).=20
>>>>>> =20
>>>>>> When this occurs, the DisplayPort supervisor function
>>>>>> `nv50_disp_super_2_2_dp` is invoked via modeset interrupts.
>>>>>> Without
>>>>>> an early-exit guard, the function attempts to perform
>>>>>> symbols/hblank
>>>>>> and link rate calculations that divide by `ior->dp.nr`, resulting
>>>>>> in
>>>>>> a kernel division-by-zero math exception, lockup, and system
>>>>>> freeze.
>>>>>> =20
>>>>>> This patch adds an early-exit check at the beginning of
>>>>>> `nv50_disp_super_2_2_dp` to abort display configuration when the
>>>>>> link
>>>>>> training lanes count is zero.
>>>>>>=20
>>>>>> *   **Tested Kernel Version:** `7.1.3` (mainline stable branch)
>>>>>>=20
>>>>>> ---
>>>>>>=20
>>>>>> ### EXTREMELY DETAILED TECHNICAL BREAKDOWN
>>>>>>=20
>>>>>> #### 1. Hardware Context
>>>>>> This bug has been consistently reproduced on a Lenovo ThinkPad
>>>>>> T430
>>>>>> (Intel HD 4000 + discrete NVIDIA NVS 5400M / GF108 chipset)
>>>>>> connected
>>>>>> to a Lenovo ThinkPad Mini Dock Plus Series 3 (Model 4338) with
>>>>>> dual
>>>>>> external monitors on dock DisplayPorts (`DP-2` and `DP-3`).=20
>>>>>>=20
>>>>>> #### 2. Root Cause Analysis (Code Level)
>>>>>> Inside `drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`, when
>>>>>> `ior-
>>>>>>> dp.nr =3D=3D 0`, the driver executes the following lines in
>>>>>> `nv50_disp_super_2_2_dp()`:
>>>>>>=20
>>>>>> *   **Line 1179:** Calculations for horizontal blank symbols:
>>>>>>     ```c
>>>>>>     h =3D h - (3 * ior->dp.ef) - (12 / ior->dp.nr);
>>>>>>     ```
>>>>>> *   **Line 1185:** Calculations for vertical blank symbols:
>>>>>>     ```c
>>>>>>     v =3D v - ((36 / ior->dp.nr) + 3) - 1;
>>>>>>     ```
>>>>>> *   **Line 1190:** Calculations for active link data rate:
>>>>>>     ```c
>>>>>>     link_data_rate =3D (khz * head->asy.or.depth / 8) / =
ior->dp.nr;
>>>>>>     ```
>>>>>>=20
>>>>>> In all three instances, the denominator `ior->dp.nr` is `0`,
>>>>>> causing
>>>>>> an immediate kernel math exception in the display workqueue
>>>>>> (`nouveau_display_hpd_work` or `nv50_disp_super`), locking up the
>>>>>> graphics pipeline, freezing the screen, and hanging any reboot
>>>>>> attempts (requiring a physical hard reset).
>>>>>>=20
>>>>>> #### 3. Daily Workday Trigger Scenario
>>>>>> 1.  The T430 (via dock) and a secondary workstation are both
>>>>>> connected to different inputs on the same external monitors.
>>>>>> 2.  The monitors' input sources are switched to the secondary
>>>>>> workstation.
>>>>>> 3.  At the end of the day, the secondary workstation goes to
>>>>>> sleep or
>>>>>> is shut down.
>>>>>> 4.  With no active inputs, the external monitors enter power-
>>>>>> saving
>>>>>> standby mode.
>>>>>> 5.  When the user subsequently wakes up or interacts with the
>>>>>> T430,
>>>>>> the driver attempts a modeset refresh. Since the monitors are
>>>>>> asleep
>>>>>> and inputs are switched away, the lanes count is read as `0`,
>>>>>> triggering the division-by-zero oops.
>>>>>>=20
>>>>>> #### 4. Stack Trace (Oops Log)
>>>>>> ```text
>>>>>> [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC
>>>>>> responded,
>>>>>> but no EDID for DP-2
>>>>>> [di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC
>>>>>> responded,
>>>>>> but no EDID for DP-3
>>>>>> [di jul 23 10:28:26 2024] Workqueue: nvkm-disp nv50_disp_super
>>>>>> [nouveau]
>>>>>> [di jul 23 10:28:26 2024] RIP:
>>>>>> 0010:nv50_disp_super_2_2_dp+0xa7/0x320
>>>>>> [nouveau]
>>>>>> [di jul 23 10:28:26 2024]  ? nv50_disp_super_2_2_dp+0xa7/0x320
>>>>>> [nouveau]
>>>>>> [di jul 23 10:28:26 2024]  nv50_disp_super_2_2+0xf2/0x160
>>>>>> [nouveau]
>>>>>> [di jul 23 10:28:26 2024]  nv50_disp_super+0x139/0x280 [nouveau]
>>>>>> ```
>>>>>>=20
>>>>>> #### 5. Verification Proof (Bypass Log)
>>>>>> With the patch applied and running on kernel `7.1.3-custom #2`,
>>>>>> the
>>>>>> screen standby transition was bypassed cleanly. The driver caught
>>>>>> the
>>>>>> lane count of 0, bypassed display configuration, and proceeded to
>>>>>> put
>>>>>> the graphics chip into its low-power runtime suspend state
>>>>>> (`suspended`) without locking up the OS:
>>>>>> ```text
>>>>>> [45162.232371] nouveau 0000:01:00.0: disp: DP link is inactive
>>>>>> (lanes
>>>>>> =3D 0), skipping display configuration.
>>>>>> [45162.232402] nouveau 0000:01:00.0: disp: DP link is inactive
>>>>>> (lanes
>>>>>> =3D 0), skipping display configuration.
>>>>>> [45178.605627] nouveau 0000:01:00.0: timeout
>>>>>> [45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0 [nouveau]
>>>>>> [45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini timeout,
>>>>>> 8e061008
>>>>>> [45182.608521] nouveau 0000:01:00.0: timeout
>>>>>> [45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190 [nouveau]
>>>>>> ```
>>>>>>=20
>>>>>> ---
>>>>>>=20
>>>>>> Signed-off-by: Arjan Filius <iafilius@xs4all.nl>
>>>>>> ---
>>>>>>=20
>>>>>> ### CHOOSE ONE OF THE PATCH OPTIONS BELOW TO APPEND:
>>>>>>=20
>>>>>> #### OPTION A: The Silent Production Patch (RECOMMENDED FOR
>>>>>> UPSTREAM)
>>>>>> *Note: Kernel maintainers generally reject warnings or print spam
>>>>>> for
>>>>>> expected hardware sleep/disconnect transitions. A silent return
>>>>>> is
>>>>>> the preferred upstream pattern.*
>>>>>>=20
>>>>>> ```diff
>>>>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> index 51c045bdfcbb..ab1bc0898def 100644
>>>>>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> @@ -1157,6 +1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head
>>>>>> *head,
>>>>>> struct nvkm_ior *ior)
>>>>>>  {
>>>>>>  	struct nvkm_subdev *subdev =3D =
&head->disp->engine.subdev;
>>>>>> =20
>>>>>> +	/* If the DisplayPort link is inactive (0 lanes), skip
>>>>>> configuration */
>>>>>> +	if (ior->dp.nr =3D=3D 0)
>>>>>> +		return;
>>>>>> +
>>>>>>  	const u32 khz =3D head->asy.hz / 1000;
>>>>>>  	const u32 linkKBps =3D ior->dp.bw * 27000;
>>>>>>  	const u32 symbol =3D 100000;
>>>>>> ```
>>>>>>=20
>>>>>> #### OPTION B: The Warning/Verbose Patch (What was tested
>>>>>> locally)
>>>>>> *Note: Prints warning logs to the kernel buffer for validation
>>>>>> and
>>>>>> troubleshooting.*
>>>>>>=20
>>>>>> ```diff
>>>>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> index 51c045bdfcbb..ab1bc0898def 100644
>>>>>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
>>>>>> @@ -1157,6 +1157,12 @@ nv50_disp_super_2_2_dp(struct nvkm_head
>>>>>> *head,
>>>>>> struct nvkm_ior *ior)
>>>>>>  {
>>>>>>  	struct nvkm_subdev *subdev =3D =
&head->disp->engine.subdev;
>>>>>> =20
>>>>>> +	/* If the DisplayPort link is inactive (0 lanes), skip
>>>>>> configuration */
>>>>>> +	if (ior->dp.nr =3D=3D 0) {
>>>>>> +		nvkm_warn(subdev, "DP link is inactive (lanes =3D
>>>>>> 0),
>>>>>> skipping display configuration.\n");
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>>  	const u32 khz =3D head->asy.hz / 1000;
>>>>>>  	const u32 linkKBps =3D ior->dp.bw * 27000;
>>>>>>  	const u32 symbol =3D 100000;
>>>>>> ```


--Apple-Mail=_319B43AF-C230-406A-89A4-0D04D2A02767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div>Hi =
Lyude,</div><div><br></div><div>Thanks for the update, and good luck =
with the move! Totally understand being swamped=E2=80=94take your =
time.</div><div><br></div><div>Here is the patch with the original, =
concise commit message from 2024 restored (no LLM text, and only the =
single silent early-return =
patch):</div><div><br></div><div>---</div><div><br></div><div>From: =
Arjan Filius &lt;iafilius@xs4all.nl&gt;</div><div>Subject: [PATCH v2] =
drm/nouveau/disp: Prevent divide by zero after screen =
wake-up</div><div><br></div><div>On a Lenovo T430, dock, using =
DisplayPort and 2 4K external screens, a divide&nbsp;</div><div>crash =
happens in nv50_disp_super_2_2_dp() after waking up the screens when =
the&nbsp;</div><div>monitors were in power save (or switched to another =
input), because ior-&gt;dp.nr&nbsp;</div><div>drops to =
0.</div><div><br></div><div>This causes:</div><div>- Screen =
lockup</div><div>- High system load after the issue is =
triggered</div><div>- Hangs during reboot</div><div><br></div><div>Fix =
this by returning early if the link has 0 active lanes (ior-&gt;dp.nr =3D=3D=
 0)</div><div>before doing the division =
calculations.</div><div><br></div><div>Closes: =
https://gitlab.freedesktop.org/drm/nouveau/-/issues/377</div><div>Signed-o=
ff-by: Arjan Filius =
&lt;iafilius@xs4all.nl&gt;</div><div>---</div><div>&nbsp;drivers/gpu/drm/n=
ouveau/nvkm/engine/disp/nv50.c | 4 ++++</div><div>&nbsp;1 file changed, =
4 insertions(+)</div><div><br></div><div>diff --git =
a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c</div><div>index =
51c045bdfcbb..ab1bc0898def 100644</div><div>--- =
a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c</div><div>+++ =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c</div><div>@@ -1157,6 =
+1157,10 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head, struct =
nvkm_ior *ior)</div><div>&nbsp;{</div><div>&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct =
nvkm_subdev *subdev =3D =
&amp;head-&gt;disp-&gt;engine.subdev;</div><div>&nbsp;</div><div>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>/* If the =
DisplayPort link is inactive (0 lanes), skip configuration =
*/</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>if (ior-&gt;dp.nr =3D=3D 0)</div><div>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>return;</div><div>+</div><div>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>const u32 khz =3D head-&gt;asy.hz =
/ 1000;</div><div>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>const u32 linkKBps =3D =
ior-&gt;dp.bw * 27000;</div><div>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>const u32 symbol =3D =
100000;</div><div>--&nbsp;</div><div>2.45.2</div><div><br></div><div><br><=
blockquote type=3D"cite"><div>On 23 Oct 2026, at 19:17, lyude@redhat.com =
wrote:</div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><div style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">On Sun, 2026-10-18 at 13:01 +0200, Arjan Filius =
wrote:</div><blockquote type=3D"cite" style=3D"margin: 0px 0px 0px =
0.8ex; font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; border-left: 2px =
solid rgb(114, 159, 207); padding-left: 1ex;"><div data-index=3D"4" =
data-line-number=3D"5" data-line-start=3D"5" data-line-end=3D"5" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;">Hi Lyude,</span></div></div><div data-index=3D"5" =
data-line-number=3D"6" data-line-start=3D"6" data-line-end=3D"6" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;"></span></div></div><div data-index=3D"6" =
data-line-number=3D"7" data-line-start=3D"7" data-line-end=3D"7" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;">Just a friendly gentle ping on this patch whenever =
you have a chance to take a look.</span></div></div><div data-index=3D"7" =
data-line-number=3D"8" data-line-start=3D"8" data-line-end=3D"8" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;"></span></div></div><div data-index=3D"8" =
data-line-number=3D"9" data-line-start=3D"9" data-line-end=3D"9" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;">No rush if you're still swamped with runtime PM =
work, but wanted to check in to see if you need anything else from my =
side (or if you'd prefer me to resend it as a standalone [PATCH v2] =
formatted with git-format-patch).</span></div></div><div data-index=3D"9" =
data-line-number=3D"10" data-line-start=3D"10" data-line-end=3D"10" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;"></span></div></div><div data-index=3D"10" =
data-line-number=3D"11" data-line-start=3D"11" data-line-end=3D"11" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;">Thanks again for your time!</span></div></div><div =
data-index=3D"11" data-line-number=3D"12" data-line-start=3D"12" =
data-line-end=3D"12" class=3D"code-line" style=3D"white-space: pre-wrap; =
border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; =
border-width: 0px; border-style: solid; color: rgb(64, 64, 64); =
font-family: monospace; font-size: 11.008px; font-variant-ligatures: =
normal; background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;"></span></div></div></blockquote><div =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><br></div><div =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">I will try to =
review this asap, unfortunately I am quite swamped and in the middle of =
moving - so I need to focus on the stuff that's assigned on my plate =
this week.</div><div style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br></div><div style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">I think the one =
thing that would be appreciated is if you could re-add the old commit =
message you had before generating the new one with an LLM - it was =
easier to read IMO.</div><div style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"><br></div><blockquote type=3D"cite" style=3D"margin: 0px 0px 0px =
0.8ex; font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; border-left: 2px =
solid rgb(114, 159, 207); padding-left: 1ex;"><div data-index=3D"12" =
data-line-number=3D"13" data-line-start=3D"13" data-line-end=3D"13" =
class=3D"code-line" style=3D"white-space: pre-wrap; border-color: =
color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; border-width: =
0px; border-style: solid; color: rgb(64, 64, 64); font-family: =
monospace; font-size: 11.008px; font-variant-ligatures: normal; =
background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;">Best regards,</span></div></div><div =
data-index=3D"13" data-line-number=3D"14" data-line-start=3D"14" =
data-line-end=3D"14" class=3D"code-line" style=3D"white-space: pre-wrap; =
border-color: color(srgb 0.8 0.8 0.8 / 0.05); box-sizing: border-box; =
border-width: 0px; border-style: solid; color: rgb(64, 64, 64); =
font-family: monospace; font-size: 11.008px; font-variant-ligatures: =
normal; background-color: rgb(255, 255, 255); display: flex; min-height: =
1.2rem;"><div class=3D"line-content" style=3D"--tw-border-spacing-x: 0; =
--tw-border-spacing-y: 0; --tw-translate-x: 0; --tw-translate-y: 0; =
--tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y: 0; --tw-scale-x: 1; =
--tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-pinch-zoom: ; =
--tw-scroll-snap-strictness: proximity; --tw-gradient-from-position: ; =
--tw-gradient-via-position: ; --tw-gradient-to-position: ; --tw-ordinal: =
; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spacing: ; =
--tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-width: 0px; =
--tw-ring-offset-color: #fff; --tw-ring-color: rgb(67 128 180 / .5); =
--tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; =
--tw-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; =
--tw-brightness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; =
--tw-invert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; =
--tw-backdrop-blur: ; --tw-backdrop-brightness: ; =
--tw-backdrop-contrast: ; --tw-backdrop-grayscale: ; =
--tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; =
--tw-backdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: =
; --tw-contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; =
--tw-contain-style: ; border-color: color(srgb 0.8 0.8 0.8 / 0.05); =
box-sizing: border-box; border-width: 0px; border-style: solid; flex: 1 =
1 0%; word-break: break-word;"><span class=3D"mtk1" =
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; =
--tw-translate-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: =
0; --tw-skew-y: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; =
--tw-pan-y: ; --tw-pinch-zoom: ; --tw-scroll-snap-strictness: proximity; =
--tw-gradient-from-position: ; --tw-gradient-via-position: ; =
--tw-gradient-to-position: ; --tw-ordinal: ; --tw-slashed-zero: ; =
--tw-numeric-figure: ; --tw-numeric-spacing: ; --tw-numeric-fraction: ; =
--tw-ring-inset: ; --tw-ring-offset-width: 0px; --tw-ring-offset-color: =
#fff; --tw-ring-color: rgb(67 128 180 / .5); --tw-ring-offset-shadow: 0 =
0 #0000; --tw-ring-shadow: 0 0 #0000; --tw-shadow: 0 0 #0000; =
--tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-brightness: ; =
--tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-invert: ; =
--tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-blur: ; =
--tw-backdrop-brightness: ; --tw-backdrop-contrast: ; =
--tw-backdrop-grayscale: ; --tw-backdrop-hue-rotate: ; =
--tw-backdrop-invert: ; --tw-backdrop-opacity: ; --tw-backdrop-saturate: =
; --tw-backdrop-sepia: ; --tw-contain-size: ; --tw-contain-layout: ; =
--tw-contain-paint: ; --tw-contain-style: ; border-color: color(srgb 0.8 =
0.8 0.8 / 0.05); box-sizing: border-box; border-width: 0px; =
border-style: solid;">Arjan =
Filius</span></div></div><div><br><blockquote type=3D"cite" =
style=3D"margin: 0px 0px 0px 0.8ex; border-left: 2px solid rgb(114, 159, =
207); padding-left: 1ex;"><div>On 5 Aug 2026, at 19:29, lyude@redhat.com =
wrote:</div><div><br =
class=3D"Apple-interchange-newline"></div><div><div>JFYI - going to try =
to review/test this ASAP, just been sidetracked<br>chasing some big =
runtime PM issues in nouveau atm :S<br><br>On Fri, 2026-07-17 at 10:15 =
+0200, Arjan Filius wrote:<br><blockquote type=3D"cite" style=3D"margin: =
0px 0px 0px 0.8ex; border-left: 2px solid rgb(114, 159, 207); =
padding-left: 1ex;"><div>Hello Lyude,<br><br>Yes, I did use generative =
AI to help refine and structure this (old)<br>patch.<br>It is completely =
based on work/debug/fixing I had done manually few<br>years back.<span =
class=3D"Apple-converted-space">&nbsp;</span><br>Generative AI helped me =
to send the message, but re-used my old<br>patched code, brushed up a =
bit.<br>And tested it this week on kernel 7.1.3, but previous tested =
on<br>6.8.0.x and 6.9.9 kernels.<br><br>In 2024 i submitted a bug =
report/fix/workaround (to prevent a full<br>lockup every day) on the =
Freedesktop GitLab under Issue =
377:<br>https://gitlab.freedesktop.org/drm/nouveau/-/issues/377<br><br>Bac=
k then, my local workaround was a bit less elegant, and had a =
few<br>extra checks/debug statements.<br>I had almost forgotten about =
the issue since my workaround was<br>running fine.<br>When I recently =
booted up a clean mainline 7.1.3 kernel and saw the<br>system freeze =
again within a day and every day,<span =
class=3D"Apple-converted-space">&nbsp;</span><br>and had to fsck my =
disks due to it, I remembered the fix I once<br>debugged and posted in =
2024.<span class=3D"Apple-converted-space">&nbsp;</span><br>I wanted to =
see if I could find a cleaner, more elegant solution and<br>used AI for =
it, to see if the patch could be in a nicer place,<span =
class=3D"Apple-converted-space">&nbsp;</span><br>but ended up to =
basically reproduce the fix i had written in 2024<br>(without =
AI).<br><br><br>Regarding the two patches (A and B):<span =
class=3D"Apple-converted-space">&nbsp;</span><br>* **Patch B** was the =
version I compiled and tested locally with the<br>`nvkm_warn()` =
statement<br>&nbsp; so I could verify in `dmesg` that the standby =
transitions were<br>actually triggering the block and being safely =
bypassed.<br>* **Patch A** is the exact same check but silent (without =
the warning<br>logs).<br><br>To avoid any confusion i repeat my patch, =
which does not produce any<br>logging every time,<span =
class=3D"Apple-converted-space">&nbsp;</span><br>but just avoids the =
lockup referencing null pointers when external<br>displays goes to =
sleep.<br><br><br>```diff<br>diff --git =
a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>b/drivers/gpu/drm/nou=
veau/nvkm/engine/disp/nv50.c<br>index 51c045bdfcbb..ab1bc0898def =
100644<br>--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>+++ =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>@@ -1157,6 +1157,10 =
@@ nv50_disp_super_2_2_dp(struct nvkm_head *head,<br>struct nvkm_ior =
*ior)<br>&nbsp;{<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct nvkm_subdev *subdev =3D =
&amp;head-&gt;disp-&gt;engine.subdev;<br>&nbsp;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* If the =
DisplayPort link is inactive (0 lanes), skip<br>configuration =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ior-&gt;dp.nr =3D=3D 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<br>&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>const u32 =
khz =3D head-&gt;asy.hz / 1000;<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>const u32 linkKBps =3D =
ior-&gt;dp.bw * 27000;<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>const u32 symbol =3D =
100000;<br>```<br><br>This completely fixes my lenovo T430(NVIDIA NVS =
5400M) + 4338 Dock<br>and 2 external (multi-input) monitors freeze, =
proven over some years.<br>At the time the nvidia kernel driver on my =
T430 became an issue wih<br>newer kernels, and notice nouveau driver did =
pretty well too.<br><br>Hope this claries it.<br><br>Best =
regards,<br>Arjan Filius<br><br><br></div><blockquote type=3D"cite" =
style=3D"margin: 0px 0px 0px 0.8ex; border-left: 2px solid rgb(114, 159, =
207); padding-left: 1ex;"><div>On 16 Jul 2026, at 22:40, =
lyude@redhat.com&nbsp;wrote:<br><br>Hi, can you please clarify whether =
or not you used generative AI<br>for<br>this patch series? If so, this =
needs to be noted as part of the<br>commit<br>message. Additionally, =
both of these patches look to be identical<br>except that one prints a =
message and the other doesn't. You can<br>just<br>send a single version, =
we will figure out how to handle that part<br>after.<br><br>On Thu, =
2026-07-16 at 16:55 +0200, Arjan Filius wrote:<br></div><blockquote =
type=3D"cite" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 2px solid =
rgb(114, 159, 207); padding-left: 1ex;"><div>Dear Nouveau =
Maintainers,<br>&nbsp;<br>Please find below a proposed patch to prevent =
a division-by-zero<br>kernel oops and subsequent lockup in the Nouveau =
display<br>supervisor<br>engine when DisplayPort links transition to 0 =
active lanes. This<br>bug<br>was observed and patched/tested against the =
mainline kernel<br>version<br>**7.1.3**, but is present in all current =
upstream code.<br>&nbsp;<br>---<br>&nbsp;<br>### BRIEF =
EXPLANATION<br>&nbsp;<br>During screen sleep transitions or multi-input =
display switches<br>(KVM<br>switching), the active lane count of a =
DisplayPort link can<br>temporarily drop to 0 (`ior-&gt;dp.nr =3D=3D =
0`).<span class=3D"Apple-converted-space">&nbsp;</span><br>&nbsp;<br>When =
this occurs, the DisplayPort supervisor =
function<br>`nv50_disp_super_2_2_dp` is invoked via modeset =
interrupts.<br>Without<br>an early-exit guard, the function attempts to =
perform<br>symbols/hblank<br>and link rate calculations that divide by =
`ior-&gt;dp.nr`, resulting<br>in<br>a kernel division-by-zero math =
exception, lockup, and system<br>freeze.<br>&nbsp;<br>This patch adds an =
early-exit check at the beginning of<br>`nv50_disp_super_2_2_dp` to =
abort display configuration when the<br>link<br>training lanes count is =
zero.<br><br>*&nbsp;&nbsp; **Tested Kernel Version:** `7.1.3` (mainline =
stable branch)<br><br>---<br><br>### EXTREMELY DETAILED TECHNICAL =
BREAKDOWN<br><br>#### 1. Hardware Context<br>This bug has been =
consistently reproduced on a Lenovo ThinkPad<br>T430<br>(Intel HD 4000 + =
discrete NVIDIA NVS 5400M / GF108 chipset)<br>connected<br>to a Lenovo =
ThinkPad Mini Dock Plus Series 3 (Model 4338) with<br>dual<br>external =
monitors on dock DisplayPorts (`DP-2` and `DP-3`).<span =
class=3D"Apple-converted-space">&nbsp;</span><br><br>#### 2. Root Cause =
Analysis (Code Level)<br>Inside =
`drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c`, =
when<br>`ior-<br></div><blockquote type=3D"cite" style=3D"margin: 0px =
0px 0px 0.8ex; border-left: 2px solid rgb(114, 159, 207); padding-left: =
1ex;"><div>dp.nr =3D=3D 0`, the driver executes the following lines =
in<br></div></blockquote><div>`nv50_disp_super_2_2_dp()`:<br><br>*&nbsp;&n=
bsp; **Line 1179:** Calculations for horizontal blank =
symbols:<br>&nbsp;&nbsp;&nbsp; ```c<br>&nbsp;&nbsp;&nbsp; h =3D h - (3 * =
ior-&gt;dp.ef) - (12 / ior-&gt;dp.nr);<br>&nbsp;&nbsp;&nbsp; =
```<br>*&nbsp;&nbsp; **Line 1185:** Calculations for vertical blank =
symbols:<br>&nbsp;&nbsp;&nbsp; ```c<br>&nbsp;&nbsp;&nbsp; v =3D v - ((36 =
/ ior-&gt;dp.nr) + 3) - 1;<br>&nbsp;&nbsp;&nbsp; ```<br>*&nbsp;&nbsp; =
**Line 1190:** Calculations for active link data =
rate:<br>&nbsp;&nbsp;&nbsp; ```c<br>&nbsp;&nbsp;&nbsp; link_data_rate =3D =
(khz * head-&gt;asy.or.depth / 8) / ior-&gt;dp.nr;<br>&nbsp;&nbsp;&nbsp; =
```<br><br>In all three instances, the denominator `ior-&gt;dp.nr` is =
`0`,<br>causing<br>an immediate kernel math exception in the display =
workqueue<br>(`nouveau_display_hpd_work` or `nv50_disp_super`), locking =
up the<br>graphics pipeline, freezing the screen, and hanging any =
reboot<br>attempts (requiring a physical hard reset).<br><br>#### 3. =
Daily Workday Trigger Scenario<br>1.&nbsp; The T430 (via dock) and a =
secondary workstation are both<br>connected to different inputs on the =
same external monitors.<br>2.&nbsp; The monitors' input sources are =
switched to the secondary<br>workstation.<br>3.&nbsp; At the end of the =
day, the secondary workstation goes to<br>sleep or<br>is shut =
down.<br>4.&nbsp; With no active inputs, the external monitors enter =
power-<br>saving<br>standby mode.<br>5.&nbsp; When the user subsequently =
wakes up or interacts with the<br>T430,<br>the driver attempts a modeset =
refresh. Since the monitors are<br>asleep<br>and inputs are switched =
away, the lanes count is read as `0`,<br>triggering the division-by-zero =
oops.<br><br>#### 4. Stack Trace (Oops Log)<br>```text<br>[di jul 23 =
10:28:25 2024] nouveau 0000:01:00.0: DRM: DDC<br>responded,<br>but no =
EDID for DP-2<br>[di jul 23 10:28:25 2024] nouveau 0000:01:00.0: DRM: =
DDC<br>responded,<br>but no EDID for DP-3<br>[di jul 23 10:28:26 2024] =
Workqueue: nvkm-disp nv50_disp_super<br>[nouveau]<br>[di jul 23 10:28:26 =
2024] RIP:<br>0010:nv50_disp_super_2_2_dp+0xa7/0x320<br>[nouveau]<br>[di =
jul 23 10:28:26 2024]&nbsp; ? =
nv50_disp_super_2_2_dp+0xa7/0x320<br>[nouveau]<br>[di jul 23 10:28:26 =
2024]&nbsp; nv50_disp_super_2_2+0xf2/0x160<br>[nouveau]<br>[di jul 23 =
10:28:26 2024]&nbsp; nv50_disp_super+0x139/0x280 =
[nouveau]<br>```<br><br>#### 5. Verification Proof (Bypass Log)<br>With =
the patch applied and running on kernel `7.1.3-custom =
#2`,<br>the<br>screen standby transition was bypassed cleanly. The =
driver caught<br>the<br>lane count of 0, bypassed display configuration, =
and proceeded to<br>put<br>the graphics chip into its low-power runtime =
suspend state<br>(`suspended`) without locking up the =
OS:<br>```text<br>[45162.232371] nouveau 0000:01:00.0: disp: DP link is =
inactive<br>(lanes<br>=3D 0), skipping display =
configuration.<br>[45162.232402] nouveau 0000:01:00.0: disp: DP link is =
inactive<br>(lanes<br>=3D 0), skipping display =
configuration.<br>[45178.605627] nouveau 0000:01:00.0: =
timeout<br>[45178.605629] WARNING: nv50_disp_dmac_fini+0x168/0x1c0 =
[nouveau]<br>[45180.608524] nouveau 0000:01:00.0: disp: ch 1 fini =
timeout,<br>8e061008<br>[45182.608521] nouveau 0000:01:00.0: =
timeout<br>[45182.608523] WARNING: nv50_disp_core_fini+0x143/0x190 =
[nouveau]<br>```<br><br>---<br><br>Signed-off-by: Arjan Filius =
&lt;iafilius@xs4all.nl&gt;<br>---<br><br>### CHOOSE ONE OF THE PATCH =
OPTIONS BELOW TO APPEND:<br><br>#### OPTION A: The Silent Production =
Patch (RECOMMENDED FOR<br>UPSTREAM)<br>*Note: Kernel maintainers =
generally reject warnings or print spam<br>for<br>expected hardware =
sleep/disconnect transitions. A silent return<br>is<br>the preferred =
upstream pattern.*<br><br>```diff<br>diff --git =
a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>b/drivers/gpu/drm/nou=
veau/nvkm/engine/disp/nv50.c<br>index 51c045bdfcbb..ab1bc0898def =
100644<br>--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>+++ =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>@@ -1157,6 +1157,10 =
@@ nv50_disp_super_2_2_dp(struct nvkm_head<br>*head,<br>struct nvkm_ior =
*ior)<br>&nbsp;{<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct nvkm_subdev *subdev =3D =
&amp;head-&gt;disp-&gt;engine.subdev;<br>&nbsp;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* If the =
DisplayPort link is inactive (0 lanes), skip<br>configuration =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ior-&gt;dp.nr =3D=3D 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<br>&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>const u32 =
khz =3D head-&gt;asy.hz / 1000;<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>const u32 linkKBps =3D =
ior-&gt;dp.bw * 27000;<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>const u32 symbol =3D =
100000;<br>```<br><br>#### OPTION B: The Warning/Verbose Patch (What was =
tested<br>locally)<br>*Note: Prints warning logs to the kernel buffer =
for validation<br>and<br>troubleshooting.*<br><br>```diff<br>diff --git =
a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>b/drivers/gpu/drm/nou=
veau/nvkm/engine/disp/nv50.c<br>index 51c045bdfcbb..ab1bc0898def =
100644<br>--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>+++ =
b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c<br>@@ -1157,6 +1157,12 =
@@ nv50_disp_super_2_2_dp(struct nvkm_head<br>*head,<br>struct nvkm_ior =
*ior)<br>&nbsp;{<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct nvkm_subdev *subdev =3D =
&amp;head-&gt;disp-&gt;engine.subdev;<br>&nbsp;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>/* If the =
DisplayPort link is inactive (0 lanes), skip<br>configuration =
*/<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ior-&gt;dp.nr =3D=3D 0) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>nvkm_warn(subdev, "DP link is =
inactive (lanes =3D<br>0),<br>skipping display =
configuration.\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>const u32 khz =3D head-&gt;asy.hz =
/ 1000;<br>&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>const u32 linkKBps =3D ior-&gt;dp.bw * =
27000;<br>&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>const u32 symbol =3D =
100000;<br>```</div></blockquote></blockquote></blockquote></div></div></b=
lockquote></div></blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_319B43AF-C230-406A-89A4-0D04D2A02767--

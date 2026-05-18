Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D17CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307F810E2FE;
	Mon, 18 May 2026 11:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="JzALU++K";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D768410E2FE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779105489; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IPkBQcOo5XFdejmJPG8InUSZQTBcbyzcNQZ1YvrvESMAwa1i0QvINOhHgv9vbPX3LrJ+n+scQFYzELVet96hYIXqGe2VGO81NmhEQLqoAuIyRJPyl0YNK838A1OEyMmhugGqYJVRbAQHYkmvlDUAbEwo3328+foUSA5x+cO68PQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779105489;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xjoH0EPjo8/NO/3DivGdW8xWQO4fJdSYvzOExA8pRko=; 
 b=M/CD1+yDUMCIY3m9DmVym6VCYbVZtcN7xaV18lj0iP+Rtu+v1rnmT0p2pOAGYwIhD+CUTK6eJ6rXEU1mXg1aYwM4iR76U5jQW3Wp57m5u+4EhIQrk3k6jUaanTLEwv71UROlDc/a/kXh8KMHJZGIqPDPOggaVgPJ/dWlYSFuDeg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779105489; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=xjoH0EPjo8/NO/3DivGdW8xWQO4fJdSYvzOExA8pRko=;
 b=JzALU++KhOmnXGWFxVeL2M+gb6owfyGwdVllnBd7sh5or7TtbDoh23ZitayFoHZj
 dDIWAmmlcgYouA9L+Y+rEVYzUI767VlMBOY+8J7xm9c9XRgAThrRFm7NFgKQUvJFvKi
 yxveIGbT2XAf/dXOHUeEnJfG27lz8rFxwIDexq9ZdN69GGd9Ad1Kn4TVWKpoSsGvQDA
 +KQdb1tQGJzB83HXyySSpDJB3I3DD1qnaNNuwu5zCGI0pRsYWwHm9mHetbZofktzzG0
 owL5y/ArBJYw7Go9f3C3v7kmXHsVdGULCg8Ho58oK9H5sjiS4O18jc/S2P7Wc09rEHQ
 xH12JleKnQ==
Received: by mx.zohomail.com with SMTPS id 177910548572495.00359433048015;
 Mon, 18 May 2026 04:58:05 -0700 (PDT)
Date: Mon, 18 May 2026 19:57:33 +0800
From: Icenowy Zheng <uwu@icenowy.me>
To: dri-devel@lists.freedesktop.org, Joey Lu <a0987203069@gmail.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
CC: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_drm/verisilicon=3A_add_support_fo?=
 =?US-ASCII?Q?r_Nuvoton_MA35D1_DCUltra_Lite_display_controller?=
User-Agent: K-9 Mail for Android
In-Reply-To: <520e1683-6d5c-4e1f-8811-0ef78cf8d605@gmail.com>
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
 <93e69179dbc495188cfffd8015350b3a55ce7876.camel@iscas.ac.cn>
 <de35406e-874d-4bdd-be7f-3d74dc37b13f@gmail.com>
 <3b94806073de8bd1d79aa7ec956493f67679e46b.camel@iscas.ac.cn>
 <dfbc4042-64cf-49f2-a5de-12260beffaa0@gmail.com>
 <4bf6efbb222ebc4d770ad613d17c6185e7cb2fda.camel@iscas.ac.cn>
 <1d04dd6d-f245-4b83-96b0-c5491fad8093@gmail.com>
 <76a9e9b676509e85484a1eb31c723b46c7e21a19.camel@iscas.ac.cn>
 <1a42a168-1dbb-467e-9053-b5585a737f71@gmail.com>
 <1c4d8611411e2d14699ac0b9aeb5b2377feedc8a.camel@iscas.ac.cn>
 <520e1683-6d5c-4e1f-8811-0ef78cf8d605@gmail.com>
Message-ID: <A8EFEF67-21EB-405B-91BA-293A7D0DE564@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
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



=E4=BA=8E 2026=E5=B9=B45=E6=9C=8815=E6=97=A5 GMT+08:00 17:08:25=EF=BC=8CJo=
ey Lu <a0987203069@gmail=2Ecom> =E5=86=99=E9=81=93=EF=BC=9A
>
>On 5/15/2026 4:38 PM, Icenowy Zheng wrote:
>> =E5=9C=A8 2026-05-15=E4=BA=94=E7=9A=84 14:25 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
>>> On 5/12/2026 9:12 PM, Icenowy Zheng wrote:
>>>> =E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 18:59 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
>>>>> On 5/12/2026 6:01 PM, Icenowy Zheng wrote:
>>>>>> =E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 17:06 +0800=EF=BC=8CJoey Lu=
=E5=86=99=E9=81=93=EF=BC=9A
>>>>>>=20
>>>>>> =3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge=2Ec
>>>>>>>>>>> b/drivers/gpu/drm/verisilicon/vs_bridge=2Ec
>>>>>>>>>>> index 7a93049368db=2E=2E225af322de32 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/verisilicon/vs_bridge=2Ec
>>>>>>>>>>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge=2Ec
>>>>>>>>>>> @@ -164,13 +164,16 @@ static void
>>>>>>>>>>> vs_bridge_enable_common(struct
>>>>>>>>>>> vs_crtc *crtc,
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_CLK_E
>>>>>>>>>>> N);
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	regmap_set_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_CONFIG(output),
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_RUNNI
>>>>>>>>>>> NG);
>>>>>>>>>>> -	regmap_clear_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>>> -		=09
>>>>>>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>>>>>>> -	regmap_set_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>>> -
>>>>>>>>>>> 			VSDC_DISP_PANEL_START_RUNNIN
>>>>>>>>>>> G(ou
>>>>>>>>>>> tput));
>>>>>>>>>>>       -	regmap_set_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>>>>>>>>>>> id),
>>>>>>>>>>> -
>>>>>>>>>>> 			VSDC_DISP_PANEL_CONFIG_EX_CO
>>>>>>>>>>> MMIT);
>>>>>>>>>>> +	if (dc->info->has_config_ex) {
>>>>>>>>>>> +		regmap_clear_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>>> +			=09
>>>>>>>>>>> VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>>>>>>>>>>> +		regmap_set_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_START,
>>>>>>>>>>> +				VSDC_DISP_PANEL_STAR
>>>>>>>>>>> T_RU
>>>>>>>>>>> NNIN
>>>>>>>>>>> G(ou
>>>>>>>>>>> tput
>>>>>>>>>>> ));
>>>>>>>>>>> +
>>>>>>>>>>> +		regmap_set_bits(dc->regs,
>>>>>>>>>>> VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>>>>>>>>>>> +				VSDC_DISP_PANEL_CONF
>>>>>>>>>>> IG_E
>>>>>>>>>>> X_CO
>>>>>>>>>>> MMIT
>>>>>>>>>>> );
>>>>>>>>>> Should the commit operation happen on
>>>>>>>>>> DC8000/DCUltraLite
>>>>>>>>>> too?
>>>>>>>>>> (By
>>>>>>>>>> writing to DcregFrameBufferConfig0=2EVALID)=2E
>>>>>>>>>>=20
>>>>>>>>>> Many registers written has "Note: This field is double
>>>>>>>>>> buffered" in
>>>>>>>>>> the
>>>>>>>>>> DCUltraLite documentation=2E
>>>>>>>>>>=20
>>>>>>>>>> I suggest create a static function for commit -- write
>>>>>>>>>> to
>>>>>>>>>> the
>>>>>>>>>> corresponding commit bit on DC8200, and write to
>>>>>>>>>> DcregFrameBufferConfig0=2EVALID on DC8000/DCUltraLite=2E
>>>>>>>>> [a] There is no commit operation for DCUltra Lite=2E
>>>>>>>>> I'll not add a `VSDC_FB_CONFIG_VALID` macro=2E VALID
>>>>>>>>> (BIT(3))
>>>>>>>>> is a
>>>>>>>>> hardware-managed double-buffer status bit: hardware
>>>>>>>>> writes
>>>>>>>>> 1=3DPENDING
>>>>>>>>> when a new register set is ready and clears to 0=3DWORKING
>>>>>>>>> after
>>>>>>>>> the
>>>>>>>>> VBLANK copy=2E Software must never write it, and there is
>>>>>>>>> no
>>>>>>>>> polling
>>>>>>>>> use
>>>>>>>> It seems to be writable and controls whether register
>>>>>>>> buffering
>>>>>>>> is
>>>>>>>> enabled, see [1]=2E
>>>>>>>>=20
>>>>>>>> The description of this bit in MA35D1 TRM says "This
>>>>>>>> ensures a
>>>>>>>> frame
>>>>>>>> will always start with a valid working set if this register
>>>>>>>> is
>>>>>>>> programmed last, which reduces the need for SW to wait for
>>>>>>>> the
>>>>>>>> start of
>>>>>>>> a VBLANK signal in order to ensure all states are loaded
>>>>>>>> before
>>>>>>>> the
>>>>>>>> next VBLANK", which indicates some kind of "committing
>>>>>>>> write",
>>>>>>>> although
>>>>>>>> the code at [1] seems to indicate that double buffering is
>>>>>>>> only
>>>>>>>> enabled
>>>>>>>> when bit is cleared=2E
>>>>>>>>=20
>>>>>>>> Anyway this bit should be programmable, and "Software must
>>>>>>>> never
>>>>>>>> write
>>>>>>>> it" contradicts with the MA35D1 TRM=2E
>>>>>>>>=20
>>>>>>>> Thanks,
>>>>>>>> Icenowy
>>>>>>>>=20
>>>>>>>> [1]
>>>>>>>> https://github=2Ecom/rockos-riscv/rockos-kernel/blob/rockos-v6=2E=
6=2Ey/drivers/gpu/drm/eswin/es_dc_hw=2Ec#L993
>>>>>>> Thank you for the correction=2E I'll add
>>>>>>> `#define VSDC_FB_CONFIG_VALID BIT(3)` to
>>>>>>> vs_primary_plane_regs=2Eh
>>>>>>> and
>>>>>>> write it in `vs_primary_plane_commit()` for non-config_ex
>>>>>>> variants=2E
>>>>>>>>> case in the driver that requires a named constant=2E For
>>>>>>>>> non-
>>>>>>>>> config_ex
>>>>>>>>> variants, `vs_primary_plane_commit()` performs no commit
>>>>>>>>> operation =E2=80=94
>>>>>>>>> `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
>>>>>>>>> `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET`
>>>>>>>>> (BIT(4))
>>>>>>>>> is
>>>>>>>>> set/cleared in the bridge enable/disable paths=2E
>>>>>> Well according to the driver code for DC8000 from Eswin, and
>>>>>> the
>>>>>> bit
>>>>>> named "VALID", maybe it should be cleared before programming
>>>>>> the
>>>>>> registers, and set after programming registers, to make the
>>>>>> process
>>>>>> of
>>>>>> programming registers atomic from the perspective of the
>>>>>> display
>>>>>> controller=2E
>>>>>>=20
>>>>>> Anyway this should require testing on real hardware to verify=2E
>>>>>>=20
>>>>>> By the way, I see multiple peripheral drivers for MA35D1 get
>>>>>> applied in
>>>>>> the torvalds tree, but the device tree is still only a
>>>>>> skeleton;
>>>>>> when
>>>>>> will the device tree be updated?
>>>>>>=20
>>>>>> Thanks,
>>>>>> Icenowy
>>>>> Thanks for pointing this out=2E=C2=A0I=E2=80=99ll perform tests on r=
eal hardware
>>>>> since
>>>>> I haven=E2=80=99t used this bit before=2E
>>>>>=20
>>>>> As for the device tree,=C2=A0we plan to update it comprehensively
>>>>> after
>>>>> completing several major IPs, with the goal of releasing the
>>>>> update
>>>>> later this year=2E
>>>> Well I bought a MA35D1 board (MYIR MYB-LMA35 + RGB LCD) earlier
>>>> this
>>>> year (and this is where I got the MA35D1 identification register
>>>> values)=2E Hope I can have a chance to test this driver by myself=2E
>>>>=20
>>>> As MMC, Ethernet and USB support is all applied, maybe it's already
>>>> worthy to update the device tree ;-)
>>>>=20
>>>> Thanks,
>>>> Icenowy
>>> Yes you can!
>>>=20
>>> I have performed hardware validation on the MA35D1 and found that
>>> this
>>> bit acts as a manual latch for the shadow registers rather than an
>>> auto-clearing trigger, which clarifies the slightly ambiguous
>>> description in the TRM=2E
>>>=20
>>> Following your suggestion, I will align the implementation with
>>> ESWIN's
>>> DC8000 logic: setting the VALID bit at atomic_begin and clearing it
>> Ah do you mean clearing it at begin and setting it at flush?
>>=20
>> In the Eswin driver (which seems to be based on reference code by
>> Verisilicon, I saw similar driver code for DC8200),
>> dc_hw_enable_shadow_register() clears VALID bit when enable is true,
>> and all register setting sequences calls that function with enable =3D
>> true before setting and enable =3D false after setting=2E
>>=20
>> In addition, considering this bit is called "VALID" instead of
>> "INVALID", I think it represents that the DC will apply the new setting
>> when it's set and keep the current setting when it's cleared, so I
>> think it should be cleared before modeset sequence and be set after
>> modeset sequence=2E
>>=20
>> Thanks,
>> Icenowy
>Thanks for pointing that out=2E To clarify, the TRM defines the states fo=
r this bit as:
>1: PENDING (Shadow registers are locked; incoming CPU writes are held in =
the shadow buffer)=2E
>0: WORKING (Shadow registers are unfrozen/live; configuration is committe=
d)=2E

This sounds reasonable, thanks for the clarification=2E

Sorry for me to be too lazy to verify it in HW=2E

Thanks,
Icenowy

>
>Regarding the Eswin reference, `dc_hw_enable_shadow_register(hw, false)` =
actually writes a 1 to isolate the registers during a batch update, and the=
n transitions back to true (0) to flush them out=2E
>My hardware test confirms this sequence:
>
>- atomic_begin: We set VALID =3D 1=2E This safely freezes the current sca=
nout configuration so we can update multiple registers (like frame addresse=
s and pitches) without mid-frame tearing=2E
>- atomic_update: We write the new register values safely into the frozen =
shadow space=2E
>- atomic_flush: We clear VALID =3D 0=2E This releases the shadow lock, tr=
iggering the hardware to latch the whole batch atomically=2E
>
>If we reverse this logic=E2=80=94leaving the bit at 1 after the flush =E2=
=80=94 the hardware remains permanently stuck in the PENDING state, waiting=
 to be unfrozen, which starves the display engine and results in the blank =
screen behavior I observed=2E
>>> at
>>> atomic_flush=2E My tests confirm this allows the hardware to latch the
>>> plane configuration correctly while avoiding the blank screen issues
>>> observed with other configurations=2E
>>>=20
>>> I am preparing the v2 patchset with this change, along with the
>>> requested commit splits, and will submit it shortly=2E=F0=9F=99=82
>>>=20
>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>=20

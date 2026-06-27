Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B415C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A504310E4B8;
	Sat, 27 Jun 2026 11:54:56 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A71710E4B8;
 Sat, 27 Jun 2026 11:54:54 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.75.66])
 by APP-03 (Coremail) with SMTP id rQCowADHq+IEuj9qIkkMFg--.11853S2;
 Sat, 27 Jun 2026 19:54:46 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/amd/display: dm_update_crtc_state: skip_modeset
 path leaves new_stream dangling, causing double release
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <35dee3d1-f114-4eda-8185-244bc429c021@amd.com>
Date: Sat, 27 Jun 2026 19:54:34 +0800
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, alex.hung@amd.com, superm1@kernel.org,
 timur.kristof@gmail.com, ivan.lipski@amd.com, aurabindo.pillai@amd.com,
 chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <785A9F48-8192-4C1A-B61F-FFBAC9E92D41@iscas.ac.cn>
References: <20260626124128.36625-1-vulab@iscas.ac.cn>
 <35dee3d1-f114-4eda-8185-244bc429c021@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: rQCowADHq+IEuj9qIkkMFg--.11853S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43uFW5Jw45JrWDZrWxCrg_yoW8CF48pr
 4fJw1Yvr9rZ3WIqa47C3WY9Fyjk34fX340kr4UAw1Sv345Ar15Ja4rXr1kWrZ7uFW2vw4a
 qFyDG39rXF1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
 wI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
 0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
 17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
 nxnUUI43ZEXa7IUnTq2tUUUUU==
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQLA2o-mA9ApAAAsm
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



> 2026=E5=B9=B46=E6=9C=8827=E6=97=A5 00:45=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 6/26/26 07:41, WenTao Liang wrote:
>> The skip_modeset path calls dc_stream_release(new_stream) but does =
not
>>   set new_stream to NULL. If a subsequent error (e.g., color =
management
>>   failure) triggers goto fail, the fail label executes a second
>>   dc_stream_release on the same pointer, causing a use-after-free or =
excess
>>   put on the stream reference.
>> Cc: stable@vger.kernel.org
>> Fixes: 3ce51649cdf2 ("drm/amdgpu/display: add quirk handling for =
stutter mode")
>> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
>=20
> The code change looks good to me, but this Fixes hash doesn't really =
make sense to me.
>=20
> Are you sure about that?
>=20
> I /think/ this is the correct hash:
>=20
> Fixes: 9b690ef3c7042 ("drm/amd/display: Avoid full modeset when not =
required")
>=20
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 5fc5d5608506..acf0b01d6f62 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -11708,6 +11708,7 @@ static int dm_update_crtc_state(struct =
amdgpu_display_manager *dm,
>>  	/* Release extra reference */
>>  	if (new_stream)
>>  		dc_stream_release(new_stream);
>> +	new_stream =3D NULL;
>>    	/*
>>  	 * We want to do dc stream updates that do not require a



Thank you for the review and for catching this. You are right =E2=80=94 =
I used
the wrong Fixes hash. The correct one is indeed:

Fixes: 9b690ef3c7042 ("drm/amd/display: Avoid full modeset when not =
required")

I will update it in the next version.

Thanks again for your help.

Best regards,
WenTao Liang


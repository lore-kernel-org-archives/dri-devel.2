Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B921CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F7210E873;
	Tue, 16 Jun 2026 07:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="wFVGN+vG";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7060910E873;
 Tue, 16 Jun 2026 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1781594368; x=1782199168; i=markus.elfring@web.de;
 bh=pSx51ARb762cF++8sMw7WeSt1Rt4X3wVSC+Ioih9Ygc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=wFVGN+vGzgHNq2ukqsFQkLOnAGn9NdX8CEtT/gza05o48eHgBy5Faj/CvaJO39vM
 e1aiEX8tQ6uAF630I2t5moVdi498Z+Z42G3Khm+KcL3R0dCMFnVc37qJ6qFrx5qZU
 vA1dTk3ZLIwaeOcDLL9S3bxAFWVW79J/ApwHAU2UbLtYvsKfgO2Rs6JrEDMDo4W4R
 HLZO+8dBPRucfV6SdzTCNyrcIeX2XhBZoGEzpNjxWR/SFNgus/1COez/nuLRzf/Da
 k1IS/NPcZPcO2g14a7jGtuO0f00etMElLk1GM2gXf3TwKgPcPrjEcdhRkX6FXticp
 enxLVjn7QX4F9dyjng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1xSAau2nXM-00uDB9; Tue, 16
 Jun 2026 09:19:28 +0200
Message-ID: <1ed4140f-83b6-4393-a67d-ed321b72ecb2@web.de>
Date: Tue, 16 Jun 2026 09:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: Simplify data output in
 psr_capability_show()
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Ray Wu <ray.wu@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Rong Zhang <i@rong.moe>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tom Chung <chiahsuan.chung@amd.com>, LKML <linux-kernel@vger.kernel.org>
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
 <e2023393-da68-4775-9f55-16363191328a@web.de>
 <CADnq5_P6aSFKefO+f3aofhfNh7kELEQWxid4EWgwAUr2saEh8Q@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CADnq5_P6aSFKefO+f3aofhfNh7kELEQWxid4EWgwAUr2saEh8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OFvIVOh0xAY4doqBJ/rJQ2Wa7FPK3o0OBnjiz+2NREfYgyUATnT
 WiNr7s93NaGiQOIXY5rOdY+IpjCipQiT7fXO1F9TXIwoLCgR7PituaEiteqe1VDraKRhfxt
 K5uH5YNhk3TiM2SvxRiHEvgZ+a/yBBsz2fsgulGK4LvE4H3+nBspkEjhBraqQwLCtXpupoa
 HL2yW5gbfelH4nzwewjnQ==
UI-OutboundReport: notjunk:1;M01:P0:yq8Hl58EFYY=;9HfoH5t+EfdCWmcLa8cKtpB1Mdc
 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
 ulHaf+RuD4DXMs+LkI=
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

>> Move the specification for a line break from a seq_puts() call
>> to a seq_printf() call.
>>
>> The source code was transformed by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> index 4b09a740f205..6e6f391b640e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> @@ -1076,9 +1076,9 @@ static int psr_capability_show(struct seq_file *m=
, void *data)
>>         seq_printf(m, "Sink support: %s", str_yes_no(link->dpcd_caps.ps=
r_info.psr_version !=3D 0));
>>         if (link->dpcd_caps.psr_info.psr_version)
>>                 seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.psr=
_version);
>> -       seq_puts(m, "\n");
>=20
> Why not just convert this to seq_putc() and drop the rest?  It seems
> more logical from a code structure perspective.

I obviously propose to omit a function call at this source code place
because an intended line break output can be achieved also with the subseq=
uent function call.

Do you insist to preserve a similar statement here?


>>
>> -       seq_printf(m, "Driver support: %s", str_yes_no(link->psr_settin=
gs.psr_feature_enabled));
>> +       seq_printf(m, "\nDriver support: %s",
>> +                  str_yes_no(link->psr_settings.psr_feature_enabled));
>>         if (link->psr_settings.psr_version)
>>                 seq_printf(m, " [0x%02x]", link->psr_settings.psr_versi=
on);
>>         seq_puts(m, "\n");

Regards,
Markus

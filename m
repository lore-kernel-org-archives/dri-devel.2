Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FBDC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC7E10E32E;
	Tue, 28 Jul 2026 12:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="SNegq939";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA3610E32E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1785240916; x=1785845716; i=markus.elfring@web.de;
 bh=Qhwh8pFsGLuqpZfSM4dAu0UCLRZAEUW3H/Ogkx+1KL4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SNegq93988Ojkc8xE4mT6eZsDhfe7yG26dN0WicwrNuRTKppsgQ4TjnoKMDZf04q
 mju/xL16V/9mWdRJeK/xhsPtK44MfWCHKppJs/rdMLWA/Y23SJ6MkRjeMlg0Hlo0T
 qIutCQH2eYUwEEBxpg0HI04AQWj7MiYneFJXAsBuzMP3lIHZ10Sp8AD40onAmriws
 6UdkRvdVZ4oVU0sUhwQpvFQ82340FGkxFUf8puT4KcQd9od5D5YZCHsrX8MnTwBNW
 3x0958CAvA4PlygXwvV4WLEk8C+som4KuidLSPlC+31Ul7P/ODX2ZbMOnZyTjYAXG
 Ovo/S+mL3Fou/+W51g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZMK-1xJMlo1Clc-00iU8L; Tue, 28
 Jul 2026 14:15:16 +0200
Message-ID: <4fad393f-ab3f-4f29-b0a3-8ef440b0e82e@web.de>
Date: Tue, 28 Jul 2026 14:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/bios: Move a variable assignment behind a null
 pointer check in intel_bios_encoder_supports_dp_dual_mode()
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>, David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <e81277a0-93f8-45e9-9fa4-7c2c2df9c311@web.de>
 <alZVl0o7uBoncUos@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alZVl0o7uBoncUos@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZI0JXO1j1sBBqysCYGJomPon/Mmco38eWvA7iHsLWvWptUQ7QH6
 Wvo8UgOOjVUtCCqAQzst/8R56iCxjIaHO+bkKG+52904f3kTiyN6J6Qy4H5n1bsJ2xxSSZQ
 yWpY/Gj46M4mo3jtctmQ4nsGYAg+sGR2W+NupMIYGipshFsi8Nj8Ul+YJMKtaz+JWNxduo6
 ZsNOThSujXI7V5s6mkDmw==
UI-OutboundReport: notjunk:1;M01:P0:JplgunNnKS4=;aRt9uAsmuRLzUoub1EdzGAAZ2Oe
 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
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

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Cintel_bios_encoder_supports_dp_dual_mode=E2=80=9D=
.
>>
>> Thus avoid the risk for undefined behaviour by reducing the scope for
>> the variable =E2=80=9Cchild=E2=80=9D behind condition checks.
=E2=80=A6
>> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
>> @@ -3514,8 +3514,6 @@ bool intel_bios_is_port_present(struct intel_disp=
lay *display, enum port port)
>> =20
>>  bool intel_bios_encoder_supports_dp_dual_mode(const struct intel_bios_=
encoder_data *devdata)
>>  {
>> -	const struct child_device_config *child =3D &devdata->child;
>> -
>>  	if (!devdata)
>>  		return false;
>> =20
>> @@ -3523,6 +3521,8 @@ bool intel_bios_encoder_supports_dp_dual_mode(con=
st struct intel_bios_encoder_da
>>  	    !intel_bios_encoder_supports_hdmi(devdata))
>>  		return false;
>> =20
>> +	const struct child_device_config *child =3D &devdata->child;
>> +
>=20
> does it compile?
>=20
> please keep the variable definition where it is and move only its
> assignment after the null check.
Would you find the proposed adjustment more acceptable if a bit of source =
code
would be moved into another function?
https://refactoring.com/catalog/extractFunction.html

Regards,
Markus

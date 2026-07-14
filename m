Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F544C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C789F10EDE7;
	Tue, 14 Jul 2026 16:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="USKTxdpH";
	dkim-atps=neutral
X-Greylist: delayed 93854 seconds by postgrey-1.36 at gabe;
 Tue, 14 Jul 2026 16:10:18 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246EA10E0B8;
 Tue, 14 Jul 2026 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1784045411; x=1784650211; i=markus.elfring@web.de;
 bh=EderJaK9SWfHtM5yP4F5xgy26wvyZY2GJGBK0Hhwouc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=USKTxdpH41riR1NA740kUGL5HpRUJvh+ccQBjEBoCLuVFKHr6y/KvS3OMNgPiPKk
 clg3exRs26L8yQXoOQzFBf8htwSYSPSlmv6fgy5h7u3wqcI+i9kwvBICGkNtUdWm4
 jZUwyZtY3Tm51isNQsYcTrndLExh4e8Sr3Kwze1B30lhLNNy6BsnuDwMPgXGUVxl+
 clyu86kYYqCyWlwS4J3zlwD17dWtVFBpcrKcb6bxzeBbUsht1ORiS2O9V6WOCUk0P
 NDK/M1bQcptFFMs7AyWi8jZ4ZocBcUL6VHz8M/lwRJZ3Gk+g8nuL9WyeFzWwe4SPz
 K0DBKR3dEyqPyEjhbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1wZjWh1lNU-00LwjW; Tue, 14
 Jul 2026 18:10:11 +0200
Message-ID: <4d0426b4-e40b-4cc6-841f-ca18b2256db4@web.de>
Date: Tue, 14 Jul 2026 18:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/bios: Move a variable assignment behind a null
 pointer check in intel_bios_encoder_supports_dp_dual_mode()
To: Dan Carpenter <error27@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <e81277a0-93f8-45e9-9fa4-7c2c2df9c311@web.de>
 <alZVl0o7uBoncUos@intel.com> <alZZviFT2jfABiZq@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alZZviFT2jfABiZq@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rC82bBKYgByUw3tV+iK2Ar/aoTlmebweQ6hkSraBLf3yDTNlEz5
 SZArnp8I5ofkNDsnsKqH2OBdMb9n1LVhB69wpq2arr/PTZcJdQls26K9F6FMRsqAszgfiXy
 kHYLr2rC2cw1swmaWBDlYM2s1N2CIhrhwFnM4jAXkcaZ/rkNmKTRjFFXgxPseZpgpn5O9vr
 xujztEtI6Gpk1/acKBnWQ==
UI-OutboundReport: notjunk:1;M01:P0:JtLtSE3GLwQ=;quLuQAb9zq7gLSzE93g5oCau1ct
 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
 w7xQ7RWs2U+hx8MJX/3/j23IpSHeHBIDXw==
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

>>> The address of a data structure member was determined before
>>> a corresponding null pointer check in the implementation of
>>> the function =E2=80=9Cintel_bios_encoder_supports_dp_dual_mode=E2=80=
=9D.
>>>
>>> Thus avoid the risk for undefined behaviour by reducing the scope for
>>> the variable =E2=80=9Cchild=E2=80=9D behind condition checks.
>>>
>>> This issue was detected by using the Coccinelle software.
>>>
>>> Fixes: 044cbc7a74c136f12a80c855cadd1b085084aef1 ("drm/i915/bios: Nuke =
DEVICE_TYPE_DP_DUAL_MODE_BITS")
>>> Cc: stable@vger.kernel.org
>=20
> Please stop adding Fixes tags to these and talking about "undefined
> behavior" in the commit message.  Pointer math is defined...

What does hinder you to take additional information sources better into ac=
count?


> It's just a style preference on your part.
Do you find the guidance appropriate according to the SEI CERT C Coding St=
andard?
https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-standa=
rd/rules/expressions-exp/exp34-c/

Regards,
Markus

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C986606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WbW7DL51
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DFD10E7B7;
	Wed, 18 Nov 2026 15:42:22 +0000 (UTC)
X-Greylist: delayed 27502 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 15:42:11 UTC
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3D610E7DF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795016529; bh=y8u+OZhO/nTMzs14EC5YrRgq3XD6tkv1WTJ3BOvDLqc=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date;
 b=WbW7DL517aNDKNcSSWP5nex2UwPkiN7bt90mgT/md6a6n5FQ26l3tm7+5Uoc+bgX2
 tAyRdA10RgOmRLzuRxv+RMb8gXd3VuojPt5hQiiKPdSnO4WlzK/rBVl8NqQi4vJ2Ye
 Ly0qiIR3iAS787zpyl0VKwgx/V7OZXACFgcFzFC4=
X-QQ-FEAT: +BBVktQ4OjarWbUScNLyURicI+5MY33i
X-QQ-SSF: 0000000000000040000000000000
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: MKhYWaoujcwFPo2hJkynS5BeIshDBi36rhxYIaLSvrICTMrcM+J5CtDwdAQ5a2
 bIYZOAHbgxoTtqy/oD0GuGLMIZjV6Rb8U48o3vBDVVAL0FBlLPeHe2ubA4dbmRYjvMfzcUHkugVbE
 th9Tc6nB2rJdv8mUgVq9INHNGAsSsEf21J+9+ib7gV8SL/G5UzNRaATAYpIZ3nxyOQE7q901k+mvN
 EtZLjaI2ceUxyvX4W3qDovhtGIUFHcqmI96+cnCTQeUAsboNGQXq+bUW3p4Z0KB0f1hYRo4poy/WI
 TWvoNm7YlA7C3YJ2XaX+O+DHPSXoEaSxYWFTaZ8iHlpi4/Z6+Ny5SWnsiIE/HleOc3v5nZgkNoTqX
 Fbcxc+iQNvhs7/0pcJ3ennronMO210Y8dEDLDLSLNfEd3XMywF16Ghq0vVyXaL/Jt19oPnrbwRfo0
 J9oktr1ITzIN7WKG3K9qAW5T750uTX4qnoQUaeiWnwHNQVgXgFWvTWwdDU9hTSTcoLL8Hf/ih+4fl
 UchXYXupOjKRNw1rbggQ0wfeVeVoZLDYr2taGzDUL09WlBCFJ4sDN7JS7NG9vCnfeZO6MlLJGRliC
 w2ebg1BsRhC9pZJQtOR4rQMp+A5uvH/KoEHJhmHOQcqNzM9Y0Ba9cmjKmNXMvjBwXGYN7e8XlNUUG
 tnUEBjWWaVVfh4EHJtF0c6rVocN+WbYKwDF8w60ZTnwRzzg1POPk0LaDYskgAG5tQYu66ktOXaI5P
 g79UKjAbxQBU7CHffyJHIAZ+RV2C/j6hQOWadoNDRjTg5XFjrfYluHkFxV5NzACLGJmDQywLEZclR
 K87q6Qg+R5aLsCNQdpjAeoP6UyZDNRl3HUVXNR2X2AG9OpL6Q10N0bTXDJfe62N4cr0iFYz9IFE24
 tCf6wwYpKPBvLzThzlwnQdtp4TJZlpKNJDjLpDTo7APn+v7A/CRRt1HtYD0n0g35QNUpy72diA1hl
 SfWxuszpl0GQRad2bZAB6Cn4HUBOYmL0XjK/ABeMlgO7EVTUBK0d2o73Jjvq2kh2683ZwYk3UwPT7
 MRz+NukFj9oqCzQLnoardj/r2MG/8MZAyKIWd
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
In-Reply-To: <c32211b3-c62b-4fe7-9b0e-71534904c23c@kernel.org>
References: <20261118094720.110127-1-147148383@qq.com>
 <c32211b3-c62b-4fe7-9b0e-71534904c23c@kernel.org>
X-QQ-STYLE: 
X-QQ-mid: webmail643t1795016528t6455804
From: "=?gb18030?B?xe2/ofCp?=" <147148383@qq.com>
To: "=?gb18030?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk@kernel.org>,
 "=?gb18030?B?TmVpbCBBcm1zdHJvbmc=?=" <neil.armstrong@linaro.org>
Cc: "=?gb18030?B?ZHJpLWRldmVs?=" <dri-devel@lists.freedesktop.org>,
 "=?gb18030?B?SmVzc2ljYSBaaGFuZw==?=" <jesszhan0024@gmail.com>,
 "=?gb18030?B?TWF4aW1lIFJpcGFyZA==?=" <mripard@kernel.org>,
 "=?gb18030?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>,
 "=?gb18030?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>,
 "=?gb18030?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>
Subject: Re: [PATCH v2 0/3] drm/panel: ilitek-ili9881c: add Industio Purple Pi
 OH panel
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
Date: Wed, 18 Nov 2026 23:42:07 +0800
X-Priority: 3
Message-ID: <tencent_8011206148DC3094C41852951822FCDCDE06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTgvMTEvMjAyNiAyMjozNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKJmd0OyBT
byB5b3UganVzdCBpZ25vcmVkIHdoYXQgSSB3cm90ZSB0byB5b3UgMSBob3VyIGJlZm9yZSB0
aGlzIHBvc3Rpbmc/IEFyZQomZ3Q7IHdlIHRhbGtpbmcgdG8gaHVtYW4gb3IgdG8gYSBib3Q/
CgpIaSBLcnp5c3p0b2YsCgpNeSBzaW5jZXJlIGFwb2xvZ2llcy4gSSBhbSBkZWZpbml0ZWx5
IGEgaHVtYW4gc3VibWl0dGVyIChqdXN0IGEgdmVyeQpjbHVtc3kgZmlyc3QtdGltZSBjb250
cmlidXRvcikuCgpJIHdhcyB0b28gZWFnZXIgdG8gZml4IG15IG1pc3Rha2VzLCBhbmQgSSBz
ZW50IGl0IGFnYWluIGluc3RlYWQgb2YKd2FpdGluZy4gVGhhdCBpcyB3aHkgdjIgY2FtZSBv
bmx5IDU1IG1pbnV0ZXMgYWZ0ZXIgeW91ciByZXZpZXcgb2YgdjEuCgpJIGhhZCBhbiBpc3N1
ZSB3aXRoIG15IG1haWwgY2xpZW50IG5vdCBzaG93aW5nIHRoZSBzZW50IGVtYWlscywgc28g
SQptaXN0YWtlbmx5IHRob3VnaHQgbXkgcGF0Y2hlcyB3ZXJlbid0IGdvaW5nIHRocm91Z2gg
YW5kIHNlbnQgdjMgZnJvbSBhCmRpZmZlcmVudCBhY2NvdW50LCBhbmQgSSB3cm9uZ2x5IHdy
b3RlIGluIHRoZSB2MyBjaGFuZ2Vsb2cgdGhhdCB2MiBuZXZlcgpyZWFjaGVkIHRoZSBsaXN0
LgoKRm9yIHlvdXIgcmVmZXJlbmNlLCB2MiBkaWQgcmVtb3ZlIHRoZSBub24tc3RhbmRhcmQg
QXNzaXN0ZWQtYnkgdGFncyBhbmQKZHJvcCB3aWR0aC1tbS9oZWlnaHQtbW0sIGJ1dCBJIGZh
aWxlZCB0byBzdGF0ZSB0aGlzIGNsZWFybHkgaW4gdGhlIGNvdmVyCmxldHRlci4gSSBoYXZl
IG5vdyByZS1ydW4gY2hlY2twYXRjaCBhbmQgY2hlY2twYXRjaCAtLXN0cmljdCwgYW5kIGJv
dGgKYXJlIGNvbXBsZXRlbHkgY2xlYW4uCgpJIGhhdmUgc3RvcHBlZCBzZW5kaW5nIGFueXRo
aW5nIHRvZGF5LiBJIHdpbGwgd2FpdCBhbmQgc2VuZCBhIHNpbmdsZSwKY2xlYW4gdjQgdG9t
b3Jyb3cgYXMgQ29ub3IgYWR2aXNlZC4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGllbmNlIGFu
ZCBmb3IKcG9pbnRpbmcgb3V0IG15IG1pc3Rha2VzLiBBbmQgc29ycnkgYWdhaW4gZm9yIHdh
c3RpbmcgeW91ciB0aW1lLgoKQmVzdCByZWdhcmRzLApwamg0NTY=


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D2606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=aRfcChSJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3191510E037;
	Wed, 18 Nov 2026 21:08:26 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68FF10E037
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:08:19 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795036098; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:ST2RCoQW78Qv9GSFBVwpA/e81JN6
 CK83+AIn2KD+C4Wy0/mxIS40JNkNATxcq8OjRQ46mZgr7j5GgkuLycqdtcfHW3WvyqalNYsMEPe
 u3F8WaXQQhy04dT1hguZL7WDuBv5XG8oThxyOAqPW35OZC/wAYQXbCF6gm44IAA0TQYKq4VBOag
 kl4rTkncmORQlnWbPZIVcP1jR1gf4Jvp96QOGrBt58iSQ0kJD41E8Z9JZtBQqic6zITCpFRSz/e
 aSrghtjKoM/U7CNjcePKizYjYcc5mzb8nlj9vA30X8NhzPfRmpAW6m3QwbTkUybuoamiHrDuwhA
 mR1WCYpNLevoPA==;
Message-Instance: m=1; h=sha256: gPV/kaYseNcMU5ulTH0gff5uaRdBNmtZ1UJKddfNfvc=:
 IcZLKn6sIvlY5Slw6BEEnLNOycItkVNDLhI0uqKV5zk=, sha512:
 eCFy3dh4WWq1XzbFOmhiLzOKX7HDgC2RgORb5zCxSHvNI/mVh62VIscuUqgNix7ZvvpB59KZTRXn299PNyVYvg==:
 dP4vtfX83yro88u4t1FvTerAWsUXuU6AUsteB1QfmIOReS0hlkNbXiPwk7AXaBPfLEQfwLOG/+UtmxY+skpvbg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795036098; x=1795640898; i=deller@gmx.de;
 bh=qT9Hm75ud3WZKxuUhfMVPtPPtpZGQdC9KEgRcY5UCZ4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aRfcChSJ2zheB9xdkjGnqTD3ZzG9RAH4XAWCcyM5D7d3eHArs70LfevRVTCkaAU4
 maFptbKtSfxvON89uibaWfNv30Xbu4wcUtRwb/RCG3UJwm8kX2HKOXKHjk8FG000F
 u2WjJShSdD7+6SwbjWke/td/grMsb6w3Qa8CniQmxsSf5TZrLIUgjgESNo6X1XyNZ
 hA0KD7Lufr4rhnEq/Cwm9U91VJONssTfCZFqIkqokTHCoZ0zr8F6Vzax+Xh79YDQ3
 xzKdTRZMi0H7P8h0ThHKof2yb7eRxZA5uBwPNZEr1ewenBMwcxUfjfAQDzUHkwoIO
 vPluc3VnZf8V+jvxPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1wkrlV3cTU-00qmiu; Wed, 18
 Nov 2026 22:08:17 +0100
Message-ID: <6b99e7dd-5780-4b92-aa48-3c7411e3a4b2@gmx.de>
Date: Wed, 18 Nov 2026 22:08:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video/logo: Improve logo help texts
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <024a2d7e9a6b63d261f6ca4afb1a75d4f540defa.1790154481.git.geert+renesas@glider.be>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <024a2d7e9a6b63d261f6ca4afb1a75d4f540defa.1790154481.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gnxAq7DTs3I0afMtZd+1oEND+Ad7T1hCV6e0Ef+mi3+wDV8KNwO
 zc2IxtzOjFWXwwJG4xMt9q3uUdBkYMa/vWIaU6JPIcF3EabfKZ0wwT1rpPuQZzpUpqF+4Eg
 A9X8UK3/opHTUaLpw1f1sjBAE30PVM5j+NjZSZYxTnpDnmSOmopZtOmm259j/JETKwavvOU
 NJYKHmm2ZuBUib3xGCjQA==
UI-OutboundReport: notjunk:1;M01:P0:KZAAxu51Lm4=;nmtvjc6xU0OiOitNbJ9bLwFw+qG
 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
 RQXcIOBYXDGcqiXDZG88a/nmYgA==
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/23/26 11:09, Geert Uytterhoeven wrote:
> Since commit dfa6ce636cb8faea ("video/logo: allow custom logo"), the
> LOGO_LINUX_{MONO,VGA16,CLUT224} configuration options no longer control
> the inclusion of the "standard" Linux logo, but the inclusion of
> (possibly custom) logos specified through the correspondig *_FILE
> options.
>=20
> Adjust the one-line prompt to reflect this.
> Add long help texts while at it.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/video/logo/Kconfig | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
applied.

Thanks!
Helge

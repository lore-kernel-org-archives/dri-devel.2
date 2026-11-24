Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A9606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=I7+p/48b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B38E10E8D6;
	Tue, 24 Nov 2026 21:55:51 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0F210E8D6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:55:45 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795557344; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:gyElJC9zWTMVq9pFr0cWMsbHwXyO
 JBAjTIgJ45tbsfzLA38K8gpwxyGzoGzchdX3QA7/CXD2hN6KepauxFwL18XD7Ck3R6ckdnqsSEa
 ewaC4GJkLF5w/GM4QhQ+66oU0gAPeBDPOFbs9y9P22iJnBHTxxGhrFQsKC+zvdOyzLZkUzOaqY6
 O56FPAbRfuEJz8IfPujCTKrY3sDKiB+GL7fk7/85Sq5KfjcBfWptg/WvlG/MfEAVXzTIU2J19Td
 IC2n4n/qjE6yzabFDfpiP6TzSt452Yhntdf4LIrT6MQeWYuubl1wZFXAeiWC0jeFQkk65Clt9NV
 iuB6DiJQQlDnGg==;
Message-Instance: m=1; h=sha256: xtmxwSsyq9AlzvwAgPJy9OEFoM/xTCWxDK7D4njO+q8=:
 nbsOg09msuFbDQT+2u9I1m/baQof3Qb9Dnrfl5BLnUQ=, sha512:
 qvrFH2ItmvoZY86k0EQIbwsex/TSelioy/CqqNWblz4lZClB/6MXhREy8eRqWuUq0GHro2BK3gYY2dsF93BP0A==:
 guF5SjBkzNeKtjkEgMqFWrN1T/baXDxrMW5BoGZxYoIu/CQXXqxuuTEOj3kRtxdLiIATzHSV+YlpoNDTiXm52Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795557333; x=1796162133; i=deller@gmx.de;
 bh=5p2y3Wafua00cKz/HiVXG6lpfJaenrfrcldUQFV0IMA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=I7+p/48bGAJAVxGWu2KUhir4i/uFJ9bUUQmqPeICtqeIE+fl/P/11h8SHhifoQXI
 L9iSa4XVQsIg1A5I+/HtNd5/Y87xjAqK7ZaIU+hNo6kAtIFc68+nQTF0OdhQ1MqmJ
 tuLhsYea8usjhE1LGXcy+1FGyMy1k6zGpK4TQCo2bPRUBUw2OS9nrn3VTp8bnTB5i
 nN//F2PwDqZ6Mg/cOuGH5M17J1iyPhSAI5xIVICGgqIcKOlU1C6hXC6HF+GN681S/
 PY3EpGHR42T8J51L663G3h7uk4p9qbFVuRJmsTytcYLdSuLdYLP4MA6O8hLeXcipd
 8MCmNv6qa8vDszO0kA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1yLatu1PQV-0145E7; Tue, 24
 Nov 2026 22:55:33 +0100
Message-ID: <74bcbb9e-b7a9-474a-bf96-5e33507d226d@gmx.de>
Date: Tue, 24 Nov 2026 22:55:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: s3c-fb: Fix potential registration corruption
 on probe failure
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261124135840.2276343-1-liguangshuo@mail.sdu.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261124135840.2276343-1-liguangshuo@mail.sdu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3DWW+eWJ/fSBHN2ABEo+grcZjLmvDNdyj3eXYvq5k0xAKfNE/Pf
 tzEjc0d5mrKHk4cJeuablBNZnMeMxBIc7an42K/JBd8Mz5O75LfB7X3yaPwqyJ3SR7UfP4v
 m1f2ltieOABoup+ITEhDnzSgZgYB/JoiLlbDKvnCq6bVG3ApzlGTewm2mG2mSKiHg+KUVCH
 e5ExskzVAVDehhxWua1uQ==
UI-OutboundReport: notjunk:1;M01:P0:kJNb3BmL2YM=;TGoEO/fAreAuti96tI/1DbZ1eOk
 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
 BXklni1DEG6YyP2Pu3A==
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 14:58, Guangshuo Li wrote:
> s3c_fb_probe_win() publishes its window before registration succeeds.
> On failure, the caller unregisters that unregistered framebuffer, whose
> zero-initialized node can remove another framebuffer from registered_fb[=
0].
> Colour-map allocation failure is also ignored.
>=20
> Unwind failed windows inside s3c_fb_probe_win() and publish them only
> after successful registration. Stop the window before freeing its displa=
y
> memory if registration fails, and skip empty slots in the caller's clean=
up.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: ec549a0fdc32 ("fb: add s3c-fb driver for newer Samsung SoC frameb=
uffer devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
> Changes in v2:
>    - Unwind failed windows in s3c_fb_probe_win() and publish the window
>      only after registration succeeds, without a registration flag.
>    - Stop on colour-map allocation failure and skip empty cleanup slots.
>    - Blank the enabled window before freeing memory if registration fail=
s.
>=20
>   drivers/video/fbdev/s3c-fb.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
Thanks for cleaning up in v2!
Patch is now applied to the fbdev git tree.

Thanks!
Helge

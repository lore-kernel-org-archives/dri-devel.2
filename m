Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BC606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dz82R1Fs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681DD10E180;
	Wed, 18 Nov 2026 18:25:44 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B2B10E178
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:25:37 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795026336; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:cJedObdRe1gE+vAH238b/RtmmAvw
 EUksphXcAYDxzMDMt/cdz5TfmqKz0yiASgmnCqbm+cLgJYzneUJhE41LChFPyvQ6ZAo698SRCDw
 ppr0fpJD3f9JP23+Fay5NrGZtuTSwmphQe99E7IaEfBzI8KxCYCPh8mKeMKwJqXrqSG27UGGcso
 RIW3k9JG0j2e2HWCAEY56sAaLjCZA3v3BTFRlW0gqLTSZvzd9JgaJ2xRShX2zQfQmC9FnWtusU0
 uc5oxBcOXpt3PJGSOjqH+CVk8aWR8Rl5cY58hjl2zVONLHcg0kKq8B4laMZ1yOvRxgXtpHqxgYO
 oijS68TeStnFvg==;
Message-Instance: m=1; h=sha256: qMw1nWyAKZoZcltU+ZdKc8XZ8fBrMHUivh57o8xFT2k=:
 rs8iM9YqfFPoI1pIvdDKfzlNtvc4BbX+H24OMIwIzdk=, sha512:
 5npm3xrC+/tl4RZjGtR1Xc88+29gG3nY3J2xoi+PGEH7uYBgekWWdt9pwB0TMa1aWb/zZEQnVPLeXAg2+2XnGg==:
 cAH86jzii3KEj+OMT5xpj2tgZ5XT5OJof8ndNW7F0gRaCN3Q8+xFmhiVzLbPVUqCbPkUy9voRoCrK/C9LNN96w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795026329; x=1795631129; i=deller@gmx.de;
 bh=feTs6S5aiiuK69/ei7ZtPmYXYtCBsmy54mV9hP/zyL4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dz82R1Fsdo4s3uP8L6+rBr3yEeebFu6Bya+Izr0FaSl9j1J58930jGvoqEynhCOR
 crjXiPExrPJyse+DbpKHc+UcqIX/Rx3YMRp+FpP3SnYeHuUaAeskz77pj5YDR9mjv
 LJeaF5mJDBYkdfZAvIoPbaN5fFaUQYkXoj6bhXeUL6nJuai5/3Z9XOguTT/7+i5w8
 tjaL6674FlNMNwn3//l/oia5PuDE1dn8JJEo0/K2HWRi0FVUnw3zdB7/elpVlfSKD
 tbr5BjmZ+r6i+zPbbmthlL2jb+Ts/61xPnj0rp2yBfGJDVGIvs1s0hgqwSJ9MfGDX
 LWbieieqvH8Qwk1hGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1wMlaY47na-0119cq; Wed, 18
 Nov 2026 19:25:29 +0100
Message-ID: <3cc730f9-2e21-4e1d-9703-4a1adaef54e3@gmx.de>
Date: Wed, 18 Nov 2026 19:25:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fbdev: pxafb: fix teardown and early-interrupt
 lifetimes
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261102080332.1466689-1-matthias.goergens@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261102080332.1466689-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:82k7kbz9snvwwu/R1zwVLipEc95j8CqaCdK1StEUwLiwkedE84/
 LsyB7B7WfTF3d5VO82P1sR+mX56WudBfADB+3ppFPu/KCjWqORDm9fSgOXsT4Lv8YsHJA04
 mZIiiHvxFjuCblo3+gu+NYH9z46ZzIXeFIwsiB/i4lFkxx3VAFAMfkXd8mxuJI89G4/Jm5v
 ZQen/SEK7XAuJU5vmTBRg==
UI-OutboundReport: notjunk:1;M01:P0:3jOlWnhyA0o=;UPQ4z1WmRFVHjv5fItbq3RwSnwH
 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
 ij9nwI
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 09:03, Matthias Goergens wrote:
> Three lifetime fixes for problems Sashiko, the AI review bot, pointed
> out while reviewing a pxafb cleanup [1].  Removal leaves the cpufreq
> notifier registered on freed memory and the smart-panel thread running,
> and the interrupt handler can signal completions before probe has
> initialised them.
>=20
> v2: v1 went out before it was ready, as separate patches without my
> Signed-off-by or Fixes tags, and the completion patch depended on the
> others without saying so; sorry about that.  This version adds the tags,
> sends the patches as a series, and says in each commit message what goes
> wrong and how it is reached.  The notifier fix is now a patch of its
> own, and the smart-panel patch stops the thread after the controller is
> disabled and no longer changes the thread's freezer loop.  Patch 3 is
> unchanged.
>=20
> I have dropped "fbdev: pxafb: preserve IRQ probe errors".  On the
> in-tree PXA platforms the interrupt controller is registered from
> init_IRQ(), before any driver probes, so I could not find a way for
> platform_get_irq() to return -EPROBE_DEFER here, and the patch changed
> nothing users would see.
>=20
> [1] https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.=
org/
>=20
> v1 of patches 1 and 2 ("stop smart-panel thread and notifier"):
> https://lore.kernel.org/all/20261031033248.2491098-1-matthias.goergens@g=
mail.com/
> v1 of patch 3:
> https://lore.kernel.org/all/20261031003424.1796478-1-matthias.goergens@g=
mail.com/
> v1 of the dropped patch:
> https://lore.kernel.org/all/20261031033236.2490968-1-matthias.goergens@g=
mail.com/
>=20
> Thanks,
> Matthias
>=20
> Matthias Goergens (3):
>    fbdev: pxafb: unregister cpufreq notifier on removal
>    fbdev: pxafb: stop the smart-panel thread
>    fbdev: pxafb: initialize IRQ completions before requesting IRQ
>=20
>   drivers/video/fbdev/pxafb.c | 46 +++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 10 deletions(-)
series applied to fbdev git tree.

Thanks!
Helge

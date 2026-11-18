Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23581606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AYnCvwUj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881D410FF80;
	Wed, 18 Nov 2026 19:03:36 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C977A10FF80
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:03:29 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795028608; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:hEePL96+m+jnhGkdr5v65vBxIdcF
 8yztJI4nJ8KFY56YATBaaWOBAw9q+P7ddMVMulMjXwzVKugTBkYwmZcRqtWqLLFU0TxTrWyrulq
 ZfXlY9Bgp+KfsO5ZPBMD5B5OOyV/Lwt7c0v2cGbbfrsqbrv7+CcEtJ1wvAS/08FZF2wzDjlxGtl
 m/wEh5MKPeU62nJzaJPMZw1WYuX6CuvxzunvvoKNOZx4cTviBLp1FTBxJjSQvIDZCVF4PWRlNvE
 fFvRw+JUEv0g9oCy1bPaYxqYJEM9ALlwb6dX4ohLMqXtPPmvtasOIlptaSVz3Gnwdl5jIAH2cpk
 HRejARNvpszatA==;
Message-Instance: m=1; h=sha256: GiG4XgdIfgtdLuIHOZU8HCjf/2ZGZNqAQfoFIGbZhWE=:
 Atv9Op1h6Xm8uj4e6EuahELGu0otCEHKI+/P0kILb0Q=, sha512:
 7HlvnyXFEOYcS5mjQ+EyKOJny4aSd/MeYYgBbrPHGMrvKf1LoUfmTHSD6PdfMnVj3vbepzsRsbuGxWh7fmNp5Q==:
 VVq+1sVlMzwp5/p1aywNd3V1VySGPbS8yKB4h1t4nu3DP0EItlnW3A1ujbsGEJuRrsCp5y8OYOzcYu1wzlU2FA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795028606; x=1795633406; i=deller@gmx.de;
 bh=OGT1T5Xa+L4CQota1b1ODsj7SQfL2A5D/7W4fwgmvP8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AYnCvwUj9qUWGcbs7+kJ/Jh/ph5rP9cmW4w0VZPSWLBy8d+tRV0CCMyKlzmRSbui
 /M5s/87eY8wFfeKOnru6w13cRtKFiDSkJeGRua8xPKH6KMEdxwAoIN25D+FSSy7Pq
 yMntnDzxVm7YRVHwlIxjQB3N4oYHbYgJwdK74PM4QHBkbCkS+1veg5we5+k4BrVwZ
 wvBxJAC0E6E9IHTsliEhbqzjBFlXzZ82KDp/Iqplv2Wq/ZHKzM68a49lRHQYIIwD2
 7AE3JFHOUmmnck9MR3BYmUNxnicg8RVdgajitDUaRGz4YJ7D9uKG6HJPBQ7Ne03F/
 jkKiPZCK2HeS4F3Mmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1wiI9x3E2G-00mXTI; Wed, 18
 Nov 2026 20:03:25 +0100
Message-ID: <3c308799-7592-48d2-bfc1-c632613515c1@gmx.de>
Date: Wed, 18 Nov 2026 20:03:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: valkyriefb: keep the framebuffer mapping size fixed
To: Tim Douglas <me@timdoug.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261118015859.83794-1-me@timdoug.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261118015859.83794-1-me@timdoug.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WhKyN8kaZc/s1H9sgEXj4GZnSPrgFnKJ8dOUcg273VLGT9c1T9b
 aKcEW++TfivYeAHtrQH2C5mXlNveyOwWp7TTA38vlA3b0cEttq+smrNWLDc/HgvoWBCzPct
 RzSryU/69z4UFeXS9Te8yf/djG4xV2cLARTyMNpUKXjRBOE3yQSQwJ+xmycWiCJLPEYxV9a
 Pw/OO5IE4dyCGLwmP4pXw==
UI-OutboundReport: notjunk:1;M01:P0:b6tdXQZxiaA=;fNiP3H7mdhNsh+XaUQyZDBtLflN
 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
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

On 11/18/26 02:58, Tim Douglas wrote:
> When /dev/fb0 is mapped before a depth change, as with Xorg's fbdev
> driver, the mapping may be too short for the new mode. At 640x480,
> a full frame at 16 bpp is 600 KiB, so drawing it through the
> original 300 KiB mapping from 8 bpp can fault.
>=20
> Set smem_len to the usable video RAM by subtracting the 4 KiB offset
> already applied to smem_start, then keep that size across mode
> changes.
>=20
> On a Performa 6200CD using a kernel with local platform support,
> a write past the mapping caused a fault during an Xorg test at
> 16 bpp. With the corrected mapping size in the test kernel, twm
> and xterm were displayed successfully in Xorg at 640x480 and 16 bpp.
>=20
> In a test on a Quadra 630 in MAME with Linux v7.4-rc3, /dev/fb0 was
> mapped at 8 bpp and the depth was changed to 16 bpp with the original
> mapping still in place. A SIGSEGV was reported during the 16 bpp draw
> before the fix, and all 480 lines were drawn afterward.
>=20
> AI assistance was used to investigate the mapping size and draft
> the fix.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Tim Douglas <me@timdoug.com>
> ---
>   drivers/video/fbdev/valkyriefb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
applied.

Thanks!
Helge

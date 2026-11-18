Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957060A2600
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=csLOmXh4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D098952F;
	Wed, 18 Nov 2026 19:06:43 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2804410FF8F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:06:37 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795028795; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:JVWl8ONwk0TfGaHK+if8or5on8GA
 oPg4yAeLp57Jw9dMqX0i1l9oaKjiUfXTrEvv9/LElUsBGjBcsW/IhdjYZMmgEou0om8AVwveIK7
 tC/gqLAOvxoKshqZQCpJpyVxoSt4e1Tppg1sDZ0ycTwhSH2zlEDo0Y6R++0U4PKZpzXxaoG/Nw3
 CugrRJRNYKVKVo/fiZrdLdOs8KCIcmP5BdkA9xOod+T8iI0xrHUq4MpiMGtjQ3a09CM9pBoGiYq
 Ug6Xl7QfPWlOzVt1RyDnJWqWzqONtD7irYR5oPm1OIUxLdv5ATLLqymjfQxCeIZ2UBzyUpTtBNn
 hYcDuEGUr85F6w==;
Message-Instance: m=1; h=sha256: 0DW/KJwgGELkdAbqwaU8xmj/X7pRvlXiwLu0X4A0M+U=:
 /GxavHHS82/fwUH7NtXnG2JJE5zatq+vXv88Do4n6nE=, sha512:
 l5JboOJexpcVRGA0/UqTTiMALkNBGbpFxda8NHVxzoVAuYRVgLbojdPLHHhXU01CTDcaEecQ7CF9hr/LouL+BA==:
 nwCBCvXuDdcqCqWhh+SWrlhSvifu3Ec5QecYh0Wh+jNNf9/VA13bBXK68GN5hsYVi8gVK1Flk7GQ6NfgPONVHg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795028795; x=1795633595; i=deller@gmx.de;
 bh=mB6g/s+Mup8r/s6E0Jp46iCzcgYUsbc+dnHEaoDJmvA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=csLOmXh41090sdXEAhhmjjhyV+94vYYv/PeI/K2VDKGJKl/RmVcwetoNQJ4tn4a1
 Rde1o/6YFCnOZ6VcwjzMPs0nHJA6uOlEnAPTEwva8cIXuZMAXq1ih0eCu9g1B0lw1
 75OV2IXjUbR2AKJpHWln10f1z+gqQlE/KG7dd57uscVyYYkf9XUXccN8Pbj5bc4sm
 ep5dKpByr8/tjwK53yVudC4ML02ALZ1hMKNkPuryL92BfdimjbN8N23dvr+8VEtJy
 Se1mc++6iEKFStNlhmpx2QCvS9e3Q/IqzCIWSkQsSwVZFvu7Vpsld/KLmxPnU9PgJ
 nkSKdrgORNptjZRWkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1wpRt72fvq-00cylu; Wed, 18
 Nov 2026 20:06:35 +0100
Message-ID: <ce8acf84-1b74-4b0b-89a3-72e19fd05f34@gmx.de>
Date: Wed, 18 Nov 2026 20:06:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: cobalt_lcdfb: Don't read info after
 framebuffer_release()
To: shyckless@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-cobalt-lcdfb-v1-1-214062966e2c@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261118-cobalt-lcdfb-v1-1-214062966e2c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o+i1KgSHy/nYWWZTNkR6HhWRVsv1BswM3JFBH4Cx5xy833n7whv
 aEbuN2PQr8DizLDdfotCxme+AdOny75drah9NHPDDx8Isl4R5am0SIuUypK9R3xzyQoYdGx
 NGuIqRvb3GVi9vSskOyvHRifg8JjCkIiytSGmwSGk357IVE9onvQG7xOV1EzdPSqnu7c8lF
 5k77AzWdHWGsVZgGLjNXw==
UI-OutboundReport: notjunk:1;M01:P0:c/pltLxN2Xk=;1x3OL6uWFFg/YAhrDdJLi5Af7GG
 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
 kLsEPJ+2cYgMMqo2PckHzfVuFwSOXKTEOi372fs=
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

On 11/18/26 15:07, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
>=20
> When devm_platform_get_and_ioremap_resource() fails, cobalt_lcdfb_probe(=
)
> releases the framebuffer and then dereferences it for the return value:
>=20
> 	framebuffer_release(info);
> 	return PTR_ERR(info->screen_base);
>=20
> framebuffer_release() frees info, so info->screen_base is read from free=
d
> memory. Save the error code before releasing info.
>=20
> Found with a static analysis tool and checked by hand.
>=20
> Fixes: d2386d9e3eb4 ("fbdev: cobalt_lcdfb: Request memory region")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> The change only moves the error-code read before framebuffer_release().
> Checked by inspection; I couldn't build it here (MIPS, and my MIPS cross
> toolchain fails at an unrelated host step), and I don't have the
> hardware.
> ---
>   drivers/video/fbdev/cobalt_lcdfb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
applied.

Thanks!
Helge

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58405606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mW5Q9cDd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31D610E4A8;
	Tue, 20 Oct 2026 12:24:46 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E780910E08F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792499075; x=1793103875; i=deller@gmx.de;
 bh=KJVGJGArhzOAf3DrpyQOaSOnSdjcckw+tuBm8Rg5yYI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mW5Q9cDde+x09EofVByJdaPXogZt1j3GFltrRmRGNq62v17HNakMVAUgmg8QRdEG
 pqbK7XuYpNp6NRbFjZWyTbPxI7JoYE7LH9FBq87wQcjbd/9F10MfbvBtVpN7NfPtP
 DStoCWLWh9pcwP5hS7qQQME3daEjT1Rg+RojguL+BUi15H7LWFDA8h+DmMwH6U+xT
 eWlVOvoTyH1+gNa4Xc6MtaP9zuuB0q96rZQwHhQtCWAA2HK708ito1riPknRheP2F
 UOW+90IGxyAIiNTbYdVJYiKvfOun3AgZd19lV5+iJk6+1tOda29SIFYCRz4tTXwNF
 jgLNXAYD02m7qM5QEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1xFXKg2Ue5-00HHxh; Tue, 20
 Oct 2026 14:24:35 +0200
Message-ID: <01b697bc-a15c-4790-b0f0-a22c44d5873d@gmx.de>
Date: Tue, 20 Oct 2026 14:24:33 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans
To: CatMe0w <CatMe0w@live.cn>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <TYYP301MB1525C03FE71D47908263EBFCF69A2@TYYP301MB1525.JPNP301.PROD.OUTLOOK.COM>
 <d2490a35-df4e-450f-955a-0491529a3772@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <d2490a35-df4e-450f-955a-0491529a3772@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eePpjcGgjN6VtcMX+1SJE6d8RI2yDQTu4nqOyPHwS+20RprqsEi
 MtVVg+25OKXEHwc65xGiNRH2GFFQEo+XHEImqCE9jVlPpSFKYkHnMBt5JZwz17Vqb5T3zji
 PMOzWazP0U58x/jrMgIeD4Gus/SWJYHOwrgiGkHLOb7zS/samEdUw+kGafjlO7Cig16nQ8U
 skbqGvZBxi4oVu5avknUQ==
UI-OutboundReport: notjunk:1;M01:P0:ypgsoQyZpG0=;wgggpT/FcuElT58uideYen9jdgq
 EUgS2V2aBc0nyfgKSWch5HI7F6+XgK37xJD7GGf0HPybQbMcPlbR+2ty98sN1JE8CX3Xkiofc
 8jyUo+cG8EhDUry38g6nL84hbE57K94eIOEWb81I640ZF5zhkNwrDwjRykPDpbPKxsNGmtWlj
 vQHITsZh2mkfNyj+g7j4lNMO8r72aSS489+VTzwxem1RxxV/6Rp5+AQoEs8SC3lrRDQ3EZVTi
 cGSQIil/sFiUEqM+EkQXMOThwvLhqQPjx0qMnQJEnFZKQvcXbRTSxRb+c14hdkMBbnzNF1nA6
 yY9W6imAAcGMjr9GPoK4PM1Xe+zj2fyxJ838Bypv+NkZ3irCzNeey+y7N70bcTwXh/cPXd4p4
 AWAQ4rFDXKsk+ok4NA3BhUczdvYNjltyLF4EbxOo2vSmXMuQK68KNQLj5L0ybGUawAlMowQ6D
 0pQEtQNPnFz+yLRN6SaE3GqD8f+FL7I9kTrSfeXQ5TU0Sc5KTtb6UdmbPVQ+RX9SdXYYZq831
 9qVTReu6oAogDhU3C7ZH35gQpbflhHewrOGdpQ6vd+/U0J3Bl0Ofbjf9QulZDho78N065UuZi
 aQmiofWDOcxn7IqBhQQKGjNYGItWrs2ab531E6HauuoWGjKhKk30Vq2pMnYrmNvp/1nVqpHoq
 gCyTKRo9cenMtEPHR6lx2FNbfmLzXxz285vxyGwspwbplnX2Ud+8WCIDG6gR/0cTNt2YreJSs
 Qj56kdy18TQPl/QGmCL1q9oeY2KumIpCeNCmDlvQg+XFI4kY0lkTyNXnk03FcBiA27R+/iycQ
 EH7EqUm5z9kNTWbvqHXMvWAze/dS/mfk9FTxCLPKlxs7FauAMmVKqaTqDAKZecWUVER/u3gr7
 1MQJWLP8YnGPFqIeT2Vogh0l/U+HqbcBTjehSHONvhP5Dz97+mdxAqOTrztja5R7fgVxD8U9M
 vTfOB7QV0r2YzOB4uUTR15O6g+pumjuRSZ0gClW6F4kwVgEITGyUCqEQpGMwSraSaWmuKsgwe
 8Dk7DhmRC3YWxl3SDq5D3zQAMzK2Vdug2MqpImrUwt+BrGGTfiISPRN7Bky1zPICEGlC97HoP
 nBcq4eiQ3lVx/q9bfeD/qFc+BxmyZumBItsmFgnOY2bVBjyQJQTnPKTQ/Xmw365GgUWgXbI9M
 6JXTpEFHHrB+i1XFpoJ7WWaq2HSwkDfa9GgGr7scOEMGLP1Uiij5ep0QMuKrDmNJxRrv4GGL7
 PLX5M6uv5KZmxk90CIMMCRoVxeLY93d4brGXXVbZjoavzGF7b4HCU4AOqWRgvmfOUao/pywxd
 nm1kFAbW6Nd+Mu7iy9Lciyu2FNi16SuHwclaQDtNpHypsY1zwiALxC73DR2W/xot7i6YbXwIW
 NPVCfj6upZWTz6Bnpw0HIjZzpCpQ0JIa6s3w5FdcAUpUgGQIujOafM0TZ/Y7ySzkhtIWjei9T
 QvTItmLptjbgZZ3Et9cEYGQTGJmgo3Fz5ZP4QcvDHp+5vCdrKHQlVh6PP4ZwQkaOQ1my5JEQO
 nMTxHoW73M0dqI9w9HpJBN591BXwGD9HTM3FNphImdb+WoT0YMyjBjNEgaaiGulhbh0APM2+n
 ccDKoA3qMydFKii7ZzILPhSkVcMOGffY6++1lIUmZP218s/MM8uqyr7BxoON+hAOSntsQSpAQ
 ZuxLPMH7+jkxAS8yJbjITqCQ/ZONjGQ5Xi2TNoZiIHRvGjC6ijxsTBSyX46O7vUoarFabNhGn
 3uAUlvDX8d3RqiJdbiZirtpJlDYfatDy5zheZJ77QF1tz6oAC5ZjJxdnLrt+mvj6Y+es9shO8
 ct3Ou9F0+kOpl3ZE67SgAGsgmHw9YKOUyZDjiVVEPl8vsaRikfvWhewziKAnrmAX7fFPGVnn5
 wyNXQOS3XBtD7o9JtLGIsjE67w3xAWFnYZHd7uBrBANqsQ2uVIv/mebnX7ATxLxNZ5SnlsrcP
 3HZEj7l3n/CkXe1boeup5MrGsTRfM+mKZhsKZknQhbRIq6j7fdD9jl0mzN8plFaeFUQja+wVm
 zbet8XCyfb3L9PNuFfUPSDf+WBS4YtGezCds4JpQFAQnjBokGut/E4ct7RmxBpVfZedvTBt20
 xy3ez1CWfvqa4aLdOK5qOsCV32JBgEYMdcxfqQkb3TA17fwWfQZGcNifDtgp5fYEBgNIot8Yq
 iLOsFFkyH1w81pKdXmpMkwWluT61MxO6UXkO6wIKO/CVFTQZZcbvpAMpvZyEW2bE1FLyMroNm
 rkoLIHemr2JjadTMxG4JfIy0RodRMhhq35xAEnUXdwELf4Ldhx0a0ZqfhYykN1rMCI26IssaN
 PEuEJHHkAheOTecGO+OIST1FgEO3ikKU66EK8jKcECDvX8DP/4Mrot6tZozsUeeEjxuMjLpbj
 FbCzrNv6yYdpTRrtvwWFQTGNA4pH9Ala5wTlYjFxNFh2Kcy0G4FBD0PA4ybzYGIJ5RRhICt2U
 Koip35s4+Zv4OIQ2kCXHXsQqsQ90WKAclPlWbfvpi/mImZzbqiH4dEyVLftyjMFYfhCYV8YD9
 ya10ksk25M11Cz/TUmeLKolHPIOpO76kwwH+Rgnem6z25+FXsfF/YpZhGJoqq8edxYj/XKpND
 SWhZNjqPSKGO+/ZQi6nuaef9UWvnvPRAVrc+Ncm0o7maMvEThbx30uW5WE7JinwxUvMzXcqe4
 /MbP3IATnqKTkEr4jxp4Tx/G2hzfT8DbbeU/tTCjMnm6AYafxDZs+8xRstb6afDuSluh6PCKJ
 QA3MPJ3doma2ufRYCLSwN9PmgSyV0rviq52scPa0ruVpwjU7F7XvUPTX6D3t/qYRmFbx5bQYJ
 2V00dwjT8lmF/SL0EJt9mzgVpE3YXhcTsPHUHENAUOE66UQOcyM6tm/VPkjBDeqKbufR4LakS
 pfow09PQDmEYEoDby31RVB+0+5rsCpZ4xFKCg0DuXJMbCAzWVhOFoD2O0Kb7W1i7wFgmQ+NKd
 +kPoKvjVLozz2zwsgJHQQ0s7VPmXlc0OhRmvE5ETxyUBwc9R1TTRaZOyKrP2u7v+ft2A7dzG4
 JUd2NjLrsVVZ8WA5LreFFnZeFTAd/XHiitn82HQkgPUSXwpUQ58MRxm86PfUjMGBovyY8pPCH
 DuZMCkdcN/o5b/wuQeosXbSzRhmrBWPTNIutALfoSlbi/95QqQeVR3xm81XhKrrazh+N2rtXH
 cW+T/zL7wsjP6dT4JtqWaNWIub8Z1w8LuOZoiEskxW4tZIcKRb0KZKXjKPnhq912SBYq6JUpe
 hdJiX1Lk6TwpEegD5qX+lXu2unTSg46DwXVLrbc0Y6I6x+PpFnw5RJbYOcfLZBHprqP2XBqYX
 gUT7QmzXVECeSwRTX6fdhTBd+rkIE92cq/zriAyi4WhKaVyAc5pFiFDMDQUWUF3oH664OX7qL
 zJfZUdRdi40wwFykINt9WkVRfcwYx1Tkp/M5V8dD6l3VJOD6UzQiA9cw/QqyRSJ+GlLMO+7Xs
 hlQoeM684fg2E+iTpq3NFY2fCyPQOIEyZwimxdKvuB2jFUzSFg3tJ5ylqOJWKncgJ8NszJ9h2
 neBuMMxHKPl6dVX+h+v9qReQIN85c8s2m7pfjMERL0/s5+TFxHDryEcEueTNZJbsioCdlpjqs
 iathmfD0IsmM//V3tGNcnBE369ZFPiSFsL1HTol5KYZA1QvI2/iXkwW/t78AL2YFQVDhXLfnI
 M/I5062bkKU4nBARON2AFUcaRYcVz1CEWuD7bnhmOapc5ZOre8GsdNNFGK9GN7R6U9PTNkWXi
 J1HAnH4TUY6Nw09Wi4QOaRzNEbphdB5od3tRdWMGKP2Ser09X9AasuA494HNLpfTKUekrhRly
 W0aejewF9FtBO4xi5RHeAIVFnSGY05lPxjiidHW2NoTLTlx8Ali6wg9wEbZb3H36ju8zB8HqX
 3/4AMaim/ZOjwIOxclDwdIJNhXsyCIilciQwnBOfbFdig1GTD+dcpe/iESNFxXQCFubHMmbBA
 6g+4R/tyIujNWxpC+AUKUdUVPclIepGyC5dRM2vuSehqnxma41RYBHN7KTnA+ULGjnsxwwtPW
 2IM++ex/tC9NpUdbMn2de2feFa0sdEPibBG3MXzpjkyTunRqoNt3Wxc3aB4Xh6pbI95mr2YU4
 3vjMBUQlagZhrpVAh+bc7pxBOrceSo/V+JG8SCCmKzSoroHeyJh7Dzi+i+Nn9W3/MjiJAcKSb
 LEmJXyT35VVP7TKdrn0OkQlEerZ6TqKM9LVkSL7yBk1EcfPTeTeSieKDY2ph9WUo0YeRHTn1I
 jnOfHM9umM7vNC6vgGDXagD1etu8FhNNQOHk9E1WCH9jeJyJo8W4qxlQinRcE7OtOtKNeCf5i
 XgOdjeyXs2olnCLqp16gWPd93/fqucGyhUG4eJhjtApl9nbN8X28vNhk6CTtmETELJlqgw7Ss
 E6i4zhPMiTuJqbNayp3K4p5flaK4PxukCIdo3JdKpLbYbdI7N+QDt+uUTaZB/Pacqja3GR6Z9
 dlb81kWhp/n6CbxTNDWbTxcWqWF9mY//1P3GN+wjtPN5yXR7PQoyy4yjBgXsXESdVh2hf2naV
 sK/NMLVscSDV+ci1NQg1EcS9sHUy134BEdjHNeTjowZCFMYs+ER2m7oGOa3uPU9m0pVfq8B8d
 7pZ2WDSbXWYjK0qXxTk3SKLXKUpKxMA5+0S5BpqG21MTUY+ZdP1LBXscGp7v3TFpSSkJiOFoT
 Lval12D2peocV2e7Kca187s/1eaMQqY6WfWQ9wxf7tMgGrZcfvDeCBTWN/+gaFyhbbxIRHnBW
 LPkJfKV1TjuvxXxt/wj+TXRzf7nq8mI3bTYLn9CSxrYHY0ztLPv72O5wA/cfg7U2FmHHvcp6R
 QeefUMdyiFBn9UeuuxWr+E13vw9DUS2CzJFbY57ZO7LGTxOKBdK+GSNyhUwQeB+fEV4auY9Eq
 ibqCL6GMdAHVQCZe6WHXFv0lHpVGO9BEVJi3b6VvVTtKH9p/dgiPxSWCL85Cqdr2fC879HaPo
 SeoYnf5OhsCGvGqN/I675t/mv6C6YqYUv/nGKRnFp2Bzm9tG3ydSaIfY1tCoAf4AKpcFa02T4
 0/PEEWxCjh8QHB8Nqw0nBnBOautjRny13RDY9FHO7VoBfDPiYe0FckODCE7N+svHo4eEQLSZ5
 9mg+tpxVhqzqzvUrQ1Ekq7wtSf51i98zReg6sCbzJz6vKB57mUj6i7BhS5BOIlWQKZeGyJLZR
 nID7qTLPYznK2iAhhRzlqemekOqednVUXm3R+0QwH2wYU/qwo6hGqq0Pyvj2iPuXPV5OjtvYY
 Epgl95CnWRFsOgZgmgtHB1AwZzB608H0CzIzezcajme9hCzBDUE0Tg9ipvuFt9MgRUBIhonGT
 qCvJ1O9FQu1Db6hY0Ky27nQegcMXlrI0xxjaWLYVMlF3CCblWbR5NWwut0Pg2A8lPY30xdlFh
 lvWyiiRanAGQIN2S6aavMLDvu/QYicCZpfweaSGQY7gYVY5l2Cl0AkqI5SpXnjUYVhJNRLtIS
 CSgJdcrZq0PasYFyus8mW0HUPgk67jWdRmPHmU3VQQsdvK7rbtVgR/REcm0agVJktWJMRTo4m
 LyuyQ4V/P46nBoNi7gNb6rUqolmk/5esyNMjKYePy3fEW0oSnhuKSyghSpxrKnRYGxovFt/6L
 2JD6hkv1wy57pR5p55bPbtIBYnusafBpzrC8KLeQ0+lHXXstGnuEDFniMuuVF2KWeIirIcjTe
 VU4k2lUR0Dg0iMWDps+PrU9nPbFTeioYEclHkdZfhyBBxXlbwmZ7RClwYN3BC+GmHgvq8vZRt
 0zyxCuFbYGt3W62zrGi8jmmLL2xm7s2xp0Uxy3ZrUHTn1uXy1u+BD/2vc5nB1IaPMDzKzvbjs
 F2KoDaeZZcPjFQuEYCHUV6pPmCQyJk3QgpmssE1Y17KoPyo39hcf/eZtzY7zR9Y96VfFcUzha
 PbkR2NvVeZaP61Gp5XbOx4gkD3okblmec+88aVH7gVGrIjn5JsoA2Jb1Dgl/GIsqSMSxiF99v
 nd/+TuxP9bHEs3aFTxNtwDR/y77lF8X/0N0Vs/Mxecfgu9rwHgWZMmEPuvdrZpQ15q4mUenfG
 oRuZePsv/DWN2hSIXKFmDm1/EJpkmg0gXad4qR1WM82bISX11EGaYhQoOtba8IPuu3knvwfhO
 RSq4OJ0Z0F8YUjWZPWzQC1uvcR/T0Xs0+fy2OWjAjTEvRQ3OoDr+FTho6ly+vMQ7G2hCSX22R
 hzEa6xBNDYvYF5wrDGXoalOfRfdBHYZdkySKOHg7eD1jZ13tclf3DJPRW214luX40xYO/akK3
 x/A2TivJLr8PJ2gQV+xHE5z+puZ9bJ1NAJfirNnQ+J+2lfC14ZpHOUC+bG+viuPwAhZ/V+RtC
 JDidfspUzYb+ZIlQHIqsiT3lW6v1wtQtfzCGYHkywh0s5se0W70Xz5CsLOIoFo/LPXKkrIu1P
 jUY68ciA5ABA8KF3MdQp8DZ4HH5IHNJklDAvemIPC6Z6NSxBUi0MTuZSaM/Eup1vy7amVxTMF
 R/Vo31Rlk2U7xrZQpMjl2ZrwPIfa8tolZ8vRqC7ExT+/AM3g05YBxMHsOk3
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 13:40, Thomas Zimmermann wrote:
> Hi
>=20
> Am 17.10.26 um 10:53 schrieb CatMe0w:
>> Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
>> vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
>> fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
>> so after the first pan most new text is not drawn until the next full
>> redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
>> FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
>> CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=3Dy.
>>
>> Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
>> use as the drawing area height. When fbcon does not pan, GETVYRES()
>> returns var.yres, keeping the existing bound. When fbcon pans, it
>> returns var.yres_virtual, which the framebuffer memory must cover
>> anyway for panning to work.
>>
>> Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vm=
alloc-out-of-bounds")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: CatMe0w <CatMe0w@live.cn>
>=20
> This patch restores fbcon on my test system with sisfb.
>=20
> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Closes: https://lore.kernel.org/linux-fbdev/b8b52ffd-ecec-4fba-b432-ba32=
135c2f99@suse.de/
Thomas, thanks for testing!

CatMe0w, I'd like to take your patch, but as Greg already pointed out,
I can't take anonymous contributions.
This "Signed-off-by" isn't valid:
Signed-off-by: CatMe0w <CatMe0w@live.cn>
Can you please sign off again with your real name?

Thanks!
Helge

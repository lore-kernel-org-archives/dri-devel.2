Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F3606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=p30hsL0x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA02710E394;
	Tue, 10 Nov 2026 23:16:55 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0799C10E394
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 23:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794352608; x=1794957408; i=deller@gmx.de;
 bh=sPhpyylxMFga7oiP8JMZJDE2MIPujHqoYNioCbNmRpY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=p30hsL0xhHSlJGSLKw5fLrt642ezH2Z3C8SB9Ho6vCMlAJji+Mvj8jobSWjJvAtq
 tWDvaCWRz8KC8FS1s0x8fiQPMsR+4SrWw30OzW7+e861fu5esbqY0rjKnItrgBvvI
 0F0E7urkH7t0hBgboJ8NQgRoPDrnEhd5nRa04mfnjCm11HcP9Kew9h10javgkvXHA
 z2BN/7IZGoFhS+QqtX25Py1Y//DcPF9qzkvn0jsbkqQT1/6NSz9aoxcfStFKhYZXv
 zmuANsri3FjOCpQUwLD9BUgpF+KmdqijrEsDvi2ieOGUwAhgfTYttWuKPK2NrEL/c
 zuthQ8pnDGuKkUDp1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1x3JNu1Bkc-00JMhH; Wed, 11
 Nov 2026 00:16:48 +0100
Message-ID: <922ff42e-ab7c-4388-af93-443dbd09774b@gmx.de>
Date: Wed, 11 Nov 2026 00:16:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: xilinxfb: remove the driver
To: "Pandey, Radhey Shyam" <radheys@amd.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michal.simek@amd.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, git@amd.com
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
 <20261106170902.3656809-2-radhey.shyam.pandey@amd.com>
 <20261109-jumping-dolphin-of-refinement-14df24@quoll>
 <b05eee8c-ef32-416f-8c44-5eeec37d2e21@amd.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <b05eee8c-ef32-416f-8c44-5eeec37d2e21@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXLAIe2sEQ2V+Z2YEzGobFM+27O/t9ffPO7AJ/T7iRKDAxAEcJI
 xp6K+/pT+iyx6x8dG68LV17I42DWbLoLHbxBFStbmxP7epwRKm8CEozj3oEUqM17UR2ZiU3
 7566rhxbm89TaFvkAEYlhWUI9ERgA6C++biC2Jcv2aIb1Pmjm4NMQM5ZAHf9Wo8/Rwh8WvR
 9tYmEWMyY2KHXL6kqBBkg==
UI-OutboundReport: notjunk:1;M01:P0:8z0QYrfcuQI=;Xk0oobYY323cdHYj1Fj2XOrhs3o
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 04:55, Pandey, Radhey Shyam wrote:
> On 11/9/2026 7:17 PM, Krzysztof Kozlowski wrote:
>> On Fri, Nov 06, 2026 at 10:39:01PM +0530, Radhey Shyam Pandey wrote:
>>> Remove xilinx framebuffer soft IP driver. This IP core relies on Xilin=
x
>>> Platform Studio (XPS) and the ISE Design suite, both of which were
>>> discontinued by Xilinx years ago. Furthermore, modern AMD toolchains
>>> (Vivado Design Suite and Vitis) provide no support for the legacy PLB
>>> (Processor Local Bus) architecture used by these cores. As a result,
>>> no new hardware designs can be built using this IP.
>>>
>>> Nothing in the tree document the driver compatible strings. Given the
>>> complete obsolescence of the supporting hardware development tools
>>> and the lack of upstream users, remove the dead driver.
>>>
>>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>> ---
>>
>> You can include here defconfig update.
>>
>=20
> Thanks for the review. Based on Michal=E2=80=99s suggestion during the
> internal review, I left this out of the current series and plan to
> send defconfig update as a follow-up once this series is applied as
> it will go through his tree.

FYI, I've applied your series to the fbdev git tree.

Thanks!
Helge

>=20
> Thanks,
> Radhey


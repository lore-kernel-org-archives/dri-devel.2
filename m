Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54964CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD0C10EADD;
	Tue, 19 May 2026 07:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="ucFU5cCs";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E592C10EADD
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779176081; x=1779780881; i=deller@gmx.de;
 bh=aMd+A769QBWVQNPi1zWzRLJNiJjdGdknmlgq2IaIju4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ucFU5cCsxggwmkYRhEIH1wD24RT5wzjtVrQUWd7zNf9xdMo1UMhb0tkPvU7cKwVT
 wSOIbRSLra0MI/na/T7bq8bvQaZAd1tWdueanXO12UEsf4xnT9CcFuoq78PbmrIBB
 Vvc7MqmdHehR9jfZ/qZZedhkwfMIgEnubboJZ2zDphR3oDn28vaqWcZpEIfv+oGyg
 q8rDdtMjb7xRqhZl3z5SpM8pGgBmwrkX9NHpr1SrvNcbjthnnPn+lnLmvakkdE4ZB
 tZNoEeGIJaLqxovVLN2N1qr7GNsguV3DIWf9YNSfPT3RpJszb3Sm1dCBLBarz4tWs
 wPWNckXWkNo6UfWaFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1wTtnk26fR-00Ci3i; Tue, 19
 May 2026 09:34:41 +0200
Message-ID: <6a231d68-8231-4f40-80b7-0b82296ccede@gmx.de>
Date: Tue, 19 May 2026 09:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: chipsfb: add missing MODULE_DESCRIPTION() macro
To: =?UTF-8?Q?Rahman_Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260509131831.1073-1-mahmutovicrahman5@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260509131831.1073-1-mahmutovicrahman5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RKjnr5bbvt/mnQPUGFAvAIudPRkCAJ/TYFeU+L4PyG9hFf5dj6S
 y6auTz0VupeduQ3jnlf9mQTP0HKSGJUZXPT626Jw60BU5ChRffuU02Ps0yVrhZuMJ6YmRRP
 19bKeEt88x+6fJsaBPLArvNVnHPyC6lLLJR3AA8B1TRabQFYEkRyJsS9S6nmRqml7uAI2Cv
 V1fmf5GvIjxOjdDWY9iBw==
UI-OutboundReport: notjunk:1;M01:P0:Li3zej7KkTY=;yyU85Bc1JapnZ++FsU6CTYXBGXU
 htWPw+byDqOwrv0g4OxlEcP+J9ZBnRMHNXq7nq3YcXBVA7Js4RJisFz6yNOqT/FOoJSLAjbeR
 rST2WvD9JyK2e4fr3/BbVgZJTlQ6YyZ8z+ECLhI/qRj2g1labOe4g+Bfih5O+0VFO0FGYNaWy
 SkUkqW4erS5xNT61ysX1MrQC9hZoCX2+iPfgNSg0Rn/09pvX+nGQQsz6m0fwowmqaMJ7bTtJC
 +618pXMVppQBl0KErV7swO6zJiRWCua5oh8C0cLpFsGdSMnd7amJyXqlqq/URcJOHA05uRKya
 RGtv4hzdMY4VbE8zoGHy8WkbfW+EmVu4vYy1tCOrrycGTnmxMROwlfvpb2tmvamxa11eTTLCq
 hvVtYooSo/i39B8rpERZBHn7UFOXhD2TIiPm8gzPIrfMlGiMj3eMi0vLl+9umb1ZBVa0UwQZk
 l7Owg6A6f7KR2qdOZcy0Sh/r671KPA+65G9IuYyJNH8yB23cEWMEpabDA+F0IcVwxZPoW7YF6
 GiLl3FK7804Fqa6LlJQFQoCp5qKAVZrWHJ1u19XF12xi1KIjVg0QH7FeoBWXp/BMU/eWe0itA
 rvARwcYsazedbWsD/o4n4ddyD3Ys9geZRokohBWQPEb1qoIMUvNJI/s2u/JGqUBsdqza1thxY
 /8Nt6wcVW6B0k2nrnEokuj5OZMIVNAzlxMJw5Zyg7yxQnH7DYsO3XHadDC/0JPKxlAJM9jhE+
 O/KEMdZseZbNS1rSQ0WPWbbZjURC0NUHbySFnT4ro6Pz6vYXynyAbcwwj33/tYLMYTFiCP5or
 wneW7ojQQ+539iUmxVAQp6yWXCMqIt8Jt4/BaZ3nTiRFUscyPT0tpWwUB+h3WQVk8XHIrTVG5
 IRGXd8u4mzHjTIHAxDY5T4FiJXXvM6kJ/AkgZXZk8qjUDtUopx8zEykySTCdvyyw6ynR9hzE0
 nEK6GttgTnAY0AQ11JYAYh4YSorRo9BgS9Q7Mh9sG7nYKLgDzmAhhB/ZObKJ7Fs0gXhTNDY4B
 rragJJXNOWwAQQLXxq1DQjUmobgSLwPmLRbTYLwwZjZ14ahZo+h6C5yShvFV/5VnhI/Qpe9hX
 D5X11u8Yqe10ZKSLKm3tuzePMLizWl8u3zwEmfMOQOc4KbgrZkfiQj5BKP+O043PLV1rUwzmb
 cm12ECUOh2U5N1bNi+bNaOl8ZXcYthjE1u595+cKWncA4sm3WuzBJIRMB8VuVUg5wfS/+FV2m
 5zVonFdDzmpKycrbKDFGQyPGJJCu2dLaYxedFMJnChfueaG44K87WVlsCElZ/4N1fPiRkuBkF
 dEfZStHKmO2iys6pYmkKdodjh0d0j2yWp6ikl/pTaIG3moDnM7ocvO/rTbtj3B2ddU/pRvbVI
 EBcVM8B2Wd0jvFLW9WcEERcD6ZduQ5SuyJk0IlRr3yGpYnhrsq++ncE43wjHhL7zNX4i+oieG
 BbdJA+Eg7lt9SI43AFD0t8pnGvXtDSU4/pDJwd0pYZ1IvWHDcrExM58bM1e9rsDnWReVrEMFo
 v5Vylxy/q/XzTGacQ6a/+iir3v369CVghp/JWNcqSfUopc3r7LuLCcFzj55/oVxKgt/ljU/2P
 rb6RT8sNyCF/zeNIXJxumh5eG8SLR33rUanzK0Jd8jlyssvlKPqIv/WA5sW/Pcw3eE0lP6FVg
 EcbPjC2DZi+LiTYdQv8gfZwpINHr37WuXCfOeOJj84AK7OAskFV63E/fMg+EHqHXTgmhUQpOI
 ymAnTMnYYcaLR5RxWkrigL0Qfr8ThJXExPG0t4MUKDjcjlSv2nRGHuXyIrOMoeG+95Y+OExo+
 AUa8RCrcglfgjsVz8/X62x8QuqN5jHTtOmvAomhzzHnfZXruRuBasTYebz8iNPMs5vwFjDT5i
 4U/sYAttBhuwShGNO+HjwzRT1mrvpNBNIXkWNFhTT1BD/Irnt8/MK4Hfs6w3mKUSCYFCSYO/X
 P7+enIqjRaGn1I1M+LXGl9MEEbRQMWNh8T6ag0Hjf+/EHnm9m1LPpHurCdtQ+1yBBG0PCJZ/Q
 v+fLaaViwGHCwaJhatJMdoC3JPRb8Cjn2c1BTyTVHjIv+Fz1P6vCmt1HpdFCYsApRNK4/fM1J
 /XK95JIpTuSbKdy5+cyld7LcYRL60CoTRCrXJ8lkJVkG1A4ExwHgshr6/Za3i3mn7oinY7u58
 zsEIQBFDHV+/lzyDOQqXRBEeu9ZnlS6URuVGgWC/pKPZBGgDB3CPKNlNj7yhvYTe5fCJkG9P8
 /sNwG8E5t3D0UYnlp/DD/rNrW4TulxZAmEuDz/rjx2iR71RM6rjHNeW+R4kjj19WzVkdn5GK9
 4nLa+vl9o0EdM+dNMgazdnJymRDXFwhU0H7x3gduQWwKWbgFL/S/XeAuVv+amrjHPC0kTGif1
 sM+wwX+tGQbrYLo6+Ub13My9O/sh7p9l1CP4G9oCLGLg9pyW8UXaMZKnFLqmUomCYeoOTuku5
 IX+az+gbVr6jP316czovdbS+as5crAwCGzwMWNR8+Esp+RcmX4BHpvzHLRtl75ilkACQE5KWF
 pMJIsbjBKQ0K8SXtnQr5Y/z+cJmj1twtdeREK51onBV2J0svj8X/r/d7B3ZvfhgEouC+wFgIG
 RIMnpZDnDjBDcaQsFL1s4WqRG1ESNDJiUIPwbr5SA5/1BHR8sKn35P9ZcwPHoygXg5rpK0Nvh
 KuLwb58dncXsFrTUJcVDBYY/X8Zb6Too9EQ3QceQ4rtZxXW6zat+1Z91sp+2JKNNjtlEObJpR
 hBCECymsCmS3ujyf3OVqrHBIrS4ai7rPJco+9pj4NXn3qIHSWRueCt71iA2EJNgF0xTacGHsB
 5oB6Iez1wITSnhjcLjUArgM2ciHVxPDPKeXtakn+mcfYc0XHh/8otpuNPS/rDK1UlD0S6D63m
 38N+t2agFlL+FRLE06Qu2NtxzKAyh68RCDGdwrpR5hPzubDTMhlhm7xDl+OkZuU7tLQ5NTSgD
 eLXNSOr4q1ARO+mDQOosOwWoMG2nLGZ7HXIcudC/evbdpi8tdmEjXtzl5qCBzj8CjDGkLge6Z
 f6YOpdwLpnfzMQpMToY/jc6ljvue2mXydVAb/jKjsPqK6U407pz9Er7gBa4Noiu0NMHMIirqQ
 SB8S9lckoszticYQ0AwrJ7PcTDmSpwaeGVLmJMPZKgZD4CxbIk+ChTtS78UO8B5GJULJXoXJA
 z0gRGqBXmrqe5+rY+omI7xP5hQAXxS5x3mmDU+e5fgvY6akb3Bs375EWbb84THKaiZTDD+2ZS
 0ZC9gpndt+0glS9Abvl51BTpa9dqKm2GWBcEcTFPwa7Bt5V41phYTjNX2hVX+5eNXJrrlROjd
 BzPi5DOMNkTaAprwOVOQR1MOmGpX6TKsLf4AS2r6ZIKb1xFYLLGWm/eTeXziDZdniK5BX/BRD
 F2BgcuGrSdUUi7YmuPHPm3yTBVa1zKXtT19LDTbsj3sW8QkGnXSTZaKZ0GSDYqFi1bf0gEpJm
 jed7BFbVqjmHiuc4ThZCPcKOPqcFMDDrRC2i3OJx5uHof6URcBozEgop4oVqW+uvwqVOsHxtT
 XWZSkJU79B0UN7IjxBpa+cPxPu0AJJizBReAA+24knmhOkyk+6ioWEn0KEqQXH5Z5+2md5EQe
 kORjQmqrUWCrhyRMiSN+IO8G00ujKDfxPsQ3hbnZXJPhs/jkLKgAkzbHHAam8zKdhAWM/jZX/
 L0eWCByz+L0xpIK8DMSf5KGeDiy1zJPtGNxBAcvVW8DoWJrs432gZpve5sH2GEHRUL5/YweL7
 80PP88SplquOQnpTR5qYuQYvmyL1tdZ2xy08cooBxKL0CeN0TtlTh4o+qhBzv8MA6VCNNucRm
 /o5rZZa+vgdZPF1fAFGO29UDANt53zsbam1W9lUkIvKx2CwUlEvuLq75Lv6Bhj/kgYSS6PpYW
 M5C5ndjF2SaKpueplkykWzVFg0Jyy783ROZUTTO2lUDH6kengH0LNgLFmTv7i/nS0hAjJdghZ
 YB+qScRTCX5p9kxRJrXHd21JbJsljpDGuzmJ1Zhg493E9E4NJGEk7rC/fwCq92GthSP1Wu9qr
 wXMGIEX/PGr1WZmTOMdd+uWpY5cd9p5vhsXcVFdPvnXyMS+0zY078nG5v7pBBy6JiyAAKVrcl
 qmQLkZJPmVMi6D5XEsRfer7ZnX7CG2rQLOV5ynIMPcszU6Q2IKrqxTKl7lBgyyqhxouQxeWzw
 I4GHK5bhJleET+kcG9+bFmbJC5GAcgaGcEycJCycIOptA+h9rZsgdp3Xzp3bmRsP55eIkQ0vK
 veabys9jsJUCzI5PPCEsbacu7e3ZdmtF3+onZ3LrCmyON0zlV1YuNoIXZym0lSFej71vqlDn6
 YEB+aK0jaoDNL8FZCz6Qx/6L1iOu2wmDi5sPTAaIFY23bQ4TbqUxZDFgU6mR/wXcF7mwcIR6L
 qZ2qXV605XlGCQUh3272thbPgTJSjVcCp0AySXY6E187vUgGgf1isTMuKVXbFIZHwjnZ0AGBU
 D/F+g4Y/xItHUl3V0niNSfgOA7pG/BroIVnrBxnVDkw0zP3ZxgqR1lgA8KnYufyu1wBya6nen
 pStVUBIaCx4KDU1RrIlQQBcdmf6sOUnm8vP8x0JdHRSUse8xtcaDklgEsHII5Ixm+Zc8yBIIZ
 hgcPdgTRrrqm4i8z9jn1k86B69lO20q0aWKOVb3tjTcqhi36mrjrnkrHxq/oXTqTxD6MH2EYI
 wdcyvuXJek464IQFcydxB9WW7jsHdWJy3Qfw5nmJbRbzCTj5I12rsqqEy+45tERYuhB/awOXx
 RtYlCxxVWQh3jCxyZXc/WokE9FBCRsQ7FnrxxHe7q+rYBR/+jwebpGBQ5ZbfALa4j9uxgZRG9
 plaZynHsqSBruoIOEx1UaCLTEDt/K6WT1gd8lpkvJQEES6je8BjfL1cAzSJfG1a2U9DT9HsFd
 OntRSyg/1tOsQ0hpB2V51VFZj/UUeRWb5gE82Fq0bsHFkqsLJk0Dv+QR0sWtqHfgOT3uFupey
 fdKp2QCyQBw8yudM/ZEHSSm1mCsu4X4xZf4d+x70h9yoKZtSo7C+jReIArA+BeOtoMxZyMQ4N
 DIoLq/8FmZ2TmUcacL28+xpexIeuOTa0/AexRJbzIXl4N8wtnx8GZIOD7vAyMBdJyZQ1bFrRW
 orp2AbFvi8K/wvguWKcciQFdsIQH5M8CaZZAI+OhDJa0YslYNZ08lG8EB7eiamUO6PQBQj3gX
 Q+RMPT/dcN8N7v7H5EY50t0HfsgQ+YYADMT1MUKAd49jkNqr4gl8lu8zWmA+aRwV50IjkCNcz
 2cHzf3KJaiK0vEUFKZSZcH840WmV19QD5nw4sI/fog84+YkrXEufMlAyNl/DyLIFdlb4ISceG
 ZOk8nR/FvVlmPqg9xswKVMmWi3TGGjtnSOG/lFCokV/rH2773z0rTjA1lKZxecWDFU7AWgo5o
 Bi6VKth+niP+R40K5OEuwAs2S8TYqiH9DckNwXRXxJdYkDLSY0Cbjr5X0EZpUWKXJe9+o6WL6
 fglDQJvXuQ7JWDoKXBfwWo4vPUEsinDLdKqkE+5K6fpRa7LzE7nVNp8Pi
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

On 5/9/26 15:18, Rahman Mahmutovi=C4=87 wrote:
> The chipsfb driver is missing the MODULE_DESCRIPTION macro which
> is required for all kernel modules.
>=20
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Rahman Mahmutovi=C4=87 <mahmutovicrahman5@gmail.com>
> ---
>   drivers/video/fbdev/chipsfb.c | 1 +
>   1 file changed, 1 insertion(+)

applied.

Thanks!
Helge

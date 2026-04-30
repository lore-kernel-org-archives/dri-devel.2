Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEA8FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3325D10E18E;
	Thu, 30 Apr 2026 11:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="XK+MUNBj";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7967410E18E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777550344; x=1778155144; i=deller@gmx.de;
 bh=SqW8AwWEisRqNaQwyuATkccQWRwj5wrwzkZWZ4dkDfo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XK+MUNBjmrJLmtx2WFEL69hpcsOc4QWX8z5W5dVkF0hOVUGayAzHbSnRTW8yllaz
 LuXq/h39Ny0RZf48ACHF/GUH6xSuOdWVexZx9cSqP1L2Q+ptNWP+ch857mmDtv1AW
 jKeEr2EadVxZbbXAuligaoZFqr18kKlR1etk5dgsviOYJHRYMJmQ29y2Z3oX4/mke
 9CXE31hNetCAANt1O0PKw8T0oNWp67UBK3v0FQbnyGEfL82LGLggUKP/+C4QVHnGD
 HBpGIgHg+duXdmb+6eKq1LqTh+z8bCX3orFK9NEcYLf1MfTfP4BzIyL+ckZOIRdx+
 NoqXfOLOJCuhkVUY5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1w43WV39Po-00SoEc; Thu, 30
 Apr 2026 13:59:03 +0200
Message-ID: <8ce95d78-ee29-4f89-9b80-a604a1329beb@gmx.de>
Date: Thu, 30 Apr 2026 13:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-geode@lists.infradead.org, Markus Schneider-Pargmann <msp@baylibre.com>
References: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:668Zu2qFIrOQxOd7qjwoi5DSXTSbV6gS+1UnCuanGccNazf2yVD
 StsHz4b6HsvfvO3qZOX6nJlKnWeMvaWpaO2FLYRsfHi3kntZ6MQdAeXtjEu9WfmlgpiIIX9
 8Y1q3jF0bx4yFvq0FC3TsLEpr07dDnn3ZCeTFgq7YUwnCZET9Usvi3T/vRYMQYiEBS22NMH
 99LduiTCZFQaJvsKz67+w==
UI-OutboundReport: notjunk:1;M01:P0:GGroWRD833A=;VL+nqXtPDZMuyUwCLf2M1N79oK+
 tTr7Yb54ORYiaDWBozUkzmjtNc8BgfMz4I5sMWl2Hiv+p82W8NKgTmrtMP7AINexCdjuwStug
 Sr9lIqX7aCwpAEKr/ZFUQa5oyUM0LHGTPhRZJre06Zq2QgkGJo0M4fzM+eySCSG9DQFYap3Xi
 6io2UjBJYLbeQaMJz3Z/oYHvkR6pOgrGyYJSH2/73Pyq7525tiCWMz/eenh/MHQLyTejDEeUf
 U/q/AZsiTNBEmg4MgkI5/W4wI8g+m8NoHFf3rur7YmQiIeODl3a2+SLgDimk+N7K8cFDhzM+F
 F2yPwhS669aTLSDaOFW7A5O70fgtAAxRZ0X+tseKytIYMQEJdP2qyUPw5txPfr5wCPETYxAoZ
 AeRhKBeBJs7gymWD7e1GQYq147VzmdBm/frxt0loC5USBTh2egY01UDDujeZI/g0HoUtmfCkk
 3xLQz7+hIAFS9rksFfYZ6B0R6k8BlfMm2Q8ReAPHpU/C9faRDFhgpK5yxEDLHY9CiEdTifDOQ
 IbpeLbICczric3ubJ/ubG7EdEWIeO5NJspNHDdicYGe7UBpHW4wJN5d2T5D6C2gwcNp6vcTvk
 ZVhgEoOleM5vSX2oDDqEAkD8d+9x+XeqrJKqM7jkpR7T4vzhXd3HYJV+rVPLbrtCO1CvtNUNc
 UQL4OMfzvlcbSp1+B7VA/FeRXOHQJO+YWSbfRotJBxi06VNWinQ7dEgrNOxwBs6b4B/RQVYKf
 ZsCu1nbi4b6ihmFf5iJWOn4JwwsAhwvsxIK61NhKON6SdRKvt69Pb2mnMojKI+swMLjiq6wg5
 A80fvBtv/MaV+9VIVG9UURhN6yOlJ6IG+fBaxgGI9IddO72F+9PCVlPATuDuLVqtfuDzLP+nf
 gdgPBc9TSPREO9/WGWIRGaSF4XvIkPW5cydZQSMdmdAWF2PXDATaW0P6EMCO6a9HadJWOy2x2
 E0rt84VCkrCmrfSaU6BkoXM+T/s5qZZmfg3w28vDiD/JZm04YMBw/wsw6grXkXFaujMr3ucMC
 uidb6H0/HoWUou2WvWn1KGM9a8FnSdCb2zJ0qX+tO8XDs8yl193Y8Gt+M3n7QOyRE2bRN4bw3
 9IhBPVhzpKanlr9/inzUyj+RcUwKUmbfo1N1eLuCsTov8y8Uf+bzuvqlQ5WpVMlRphMv3JIUQ
 d7YKU++jtBc8I7Q1Zkm5OxRt7cB3Bgc93Q20qw8KegRG9RyLmppGpujuMmf4aOySWjRP6JtTu
 MIuJ2+YfXaXUecE0ei2+mklT6lUTLJ5s17JoQ+CgSO724gVw5MvNqkSwlqSGbE9xAsBwXMsqm
 haqBhl/VnsQ/evj5NcMuVVt0MGeTiooX0d7AXzX1Wp0IQIcqSASYQc/QgPyTPt5sLyN+etR5h
 NYpUDgLArvHqtoT0Mcmh7d3m87vGmvCnMub3EfUdnydHcUb8AZrAjL6K4twWHzfSoOEuwBaxS
 XLxPsibUCEj4OoSAHTtTifkKaxK9NURUvsq25xVnpSgXPLwyJmO7I+V2xBG1AcumKpe68pYep
 skXTx6FX51Jsg/eZqJ46cmGJYvJcRKEJfoVXY5Ys7AIHd7InYFmsBTkrncQ5tnsviQf2zUNCj
 T3+1Q6g42r2F6phgqN8Gr15KpUdp3elaMXGmp9VzmLWjTKC5BQ6s8LSLyxw1NOHWSg3A7fUjM
 pwBUfXJVvncjHfZ8g0Khgd4oDBcZ14Qx77nKQa6qX9NGLxdai84EFyRxi3+gWlTIRe5NGjwhB
 gJlroP0nRbjvfqvPBeS6Ck44Y6ulbqU61dm5qbx+gQtAUEZACc5oEKh/JMq6zK9V1FMUDMVNk
 xh77v2lQ6vGYu8RYaJmu+8M17dJwSBand1UXRA4PMAMAReCyesVkHhOxbqsaPKSgI4b6ZnvAo
 2qdf+a9w1K8kiQaXFMIwQfekr4+JOvjlVyVaby/weqOI8uZx8oOj4zw14GYV49jZQx199SsWu
 5fRMuo2fcQXhnq2BypXCGZGa9wNcT0PYUe3DzdHcthMLrUvdTcD7nQAJ0KNWxm7FHVqx2H5Qa
 JWdRiRLDkuGxX5B30PXOJwjtkrcMaeQ27Jof7WhYEsNyBBLlfSfC6pfpjWC2w6lNtMLfiM8A/
 dnGkVMtANeNdsFv4v7shl43qtiNj48d3NR4Ej3rrAH4IlxM+1EjE6Pzt6yjlCO8raDE1c0ZJ3
 9PEtZYBLcpRnVkg/bazlRCXFBLtRaGEn72rm1hA7JMIwhh++uHrnnA5VMVX5W5DGtz7fxRTcw
 dRlgwDffoDxOBIvau36PvObk7kTEaUcrDPRILY+ZSRiHQQ0OnHRl2P3yDUtOL3xLYHHEXxNU7
 fXp+cAjrFOzPTrsPc6TyDLo98usihEhWkbFeRwl3M7FmQAngdeaY1IoyYCNtHJpQcX/Tm28KU
 mktlUDdKBAq+/kvH1A2ny2XfwdiIUjZhpJNJKKo2+x8hyUBLYF22c3nPiPc5bPOi5tvbVFwRs
 5R+s6sikfwUOwa5Mos5mlumMAtb5ayV6LhXsRjKSY0M/TVcOC1AytVYz4J1LHwjl1r76aT3sz
 xOgPVh5q13SkROPpKEzceYKWURYyezNFqq5h2YXh6qppawUWXZ0xaYzl8b2mj/7TZvhsFXqbd
 GUFFIiv5EzcklWbZopKwptXUJStMmRssinPjIGfiku42PwuDxCfI5aYN/EBjo2eu3VreI2UNb
 Hnr/nAdqDPqrGkaXX6Ym+SpDtqifFq5VoAM6J4/2YDlQ89WOgEYRj9ZcnAJFlCEekAf7yjhkV
 gQC5mgd5xcLYVjcXPv311HA0PsyKHT3H8rstFmITMfgF96xOfbOmlyzoAei2lEGIkc8rg7DLd
 4NUphpRaUEUP3wCHbnqlxOe8PRifNpkWjJtAjTdlOvWGgjgwZcyhmTkZzZziR925TFnYVOmqE
 vnCMzOEo3frCAmXWMgHx1lGgDPoUxbbpy1ZaDRvKBXnhFRVPTyUaz06hZJM7DCL70VITF1M7s
 pxQrp0BewibjpJAAf+JqMeSeU3X2y96xUNRk8jo/JO1BJtINVMaiilIJX3BJ4m4mf5WAUEnku
 zPcvK8ORwSa93tf3trvdbMIS97k4VK0slJJ69WuUAHecEKI+D/cHFVnMxyhUM9mBiY4UPeBxv
 zZYkcQ3nYa1ho9xDUoBNkhIwp53xBXUxD17wSq3dm/zd7UXdmFC0uNuatZeGPdzU1/SerCRWc
 kQFei5DvbbuAv6+4VC9xRuNxA7u1isYIc0laLB8FuenEhoQLbnArGWokIhU9AanhiX6DI7fmf
 f4ZN2ipUzsNyBOJagb4ZSkuKZnRVHiieAIHz2bRvg6Ri1Nr0GY8bjLmxajm2cat6fo5jdkeKK
 bm5xPCpScG1cwqWfXDJDpKhyBQ+BE0JjmZw5GNIzTlN12f3lYpGJ0N13Y9f1BSayeDDgNEocJ
 jYLyIf98WFt/7Yc27nS4v47Z066ZRodzVajFSUADPa6XjeO0XBcuJm3o6I8MDSLPoFVZhovB2
 slcT+KsqTy+uDzo36Ukrib/sxfx26taoC011B+Az3mWq1G63ebSUcKPCJ4j0VQdeIBbjH9/CR
 1I0zctc+mFZCPYYiEXQbPbWjhAc+YDla4aKRW8vO5DgA8/0smDDTOS0EFU7Ug+8A2PC4msrkd
 +9uQCz6Fr+4bWnKlntdGicc0V8cLM2lOEqhbOx4wC3CWCCW7J4qhmtyshVirl/N05Qp5vWLmI
 znFGIXJS7eujUk8s89Iec1b/xKGjbMZS+7/RCxnru6yOFjBet6a2I4RZdIel5mqJiOZ8fqAHj
 5+DgRaQ7Glp5InD/PCpQLKadmB+ctPaQEZ7qm9BozPPkAMXHuaHurPD2LLJQImDJI2DO3uRkt
 GrmAcrmgfErbu7D9L9ROFoWVwa7uhLH2XRR2gg57Q+cUqNrx1WTZMv5s1vnlpNKTqAm9FXuqG
 7GIzFRFP8QoKnSi5KhxJYaM/DjNQP+gRT4ihZpRryJQ84ky1z2R54UI4VBFHtuOBHABnzgi0N
 6Ss/TihmTjjB8GCoJdWxRCkWv9fMlTy182K/dFHojrD0tK64sOgMw7nPgp+6+0BAwmFH7SKNM
 Llqy5dFvu8oYIK8EpZNIATZSgm22H2SbgXdrS/gl7d0CftewAMrCbM2fa0BW8+BIO0OjBJelG
 xqc5tbrcN7t5DckHRRVmxIf6LdKXC9EJ6VKu3V/ovDnzNzqihCNVBGszEaK8gVR9jD9hE2/YM
 v+h9cotAPb7rKNcaWJyKq9T6imLZVxAThc5uSWKoHxYhLtEJ54s1yL5qO6d8QON73jFTS+7Ui
 M8zjsaKouw1nvfiQ8/lgjuJk0vP1HxsULKh39tWq7Dt6zBqWYQEsDrpUh/P4/ugw6fYa6/vSu
 uSyyfZeU6JUWTNpkTUKVF+eja18R1hONY9zADtWZGaNekYukY1HzXsWnqGfssSKjKa3GOAmZp
 l/ltq4c8xANLDJWWEStPXlqKQLGmcU1+9F//C9ThV9sLlPRKU/ZAACrq1KNSdQia8Ksi11rnB
 aTqlooJOUq1yvxdSw3BsrxZjNVrpS7T5BUDlLYvEXEUohnSSLPjlVGH/S0FhPQykBIZIT++xh
 KFL9L65xn+VeYPWQZoZA88aL0eoDkSRxlgAVvF+zT2cXclOf7l6Z73rDp8T1HJBtJez2wODau
 azh8Y+vOaaNFugLZHNdymU9j+pa4/i2nM2Bkg7vOK+8vZP/2Any0pv/TLFInB629ebYtVe+9L
 9nKUkdlr8Rlf/ZFX0KscLfg+E6qloA1eS9qnjkp9eKa8fCXmlBNxHuoGG0rHXyroTCvxh4Tf/
 6U9JcZIcavZfc4LoaJK2Kxue2IGyHPoJbZT3PKMKJ5ynPK0beMbPfog4WSVgO2cw041Mo1kPR
 alUhpppYjyniD1M0Gzub01rn2U/S//7tDvE/SHP2VCd/0+Sel4FrIxh1xIBnVdlixZkA8yRwH
 jc+7l92qtyp4NBrplG4mDyhsEw2L2SV90ZALXf/Cz/xi03J6jbZx0ICduO1kH+WNyC0kjWgB+
 czeIfHOifRJZEkI72LfYy3Ai7KCoHkIZA6/V74vMs6gOBGg4bbzPgjmkf/M4FKYGAWEfBAxN9
 F688vwM5syyU+NgMl/CLHpVbLyHUyFGJBvbdB1BngS7PWxMg3aB8oQMIwtJruecjlWuytl0py
 Xa94RarkmAk0QYPkJEunamnX6m380cHRTf7/eBiQXIW1G5LQse1+MXKMC7/Pr92nxYmg1W+D2
 0f03ocVNXZ+mi4IjTRg8OXFsE0b+sTKiFvT6R8GB3KGHv/f9a+iSAk9BUs54AYwhLzdXee4Y/
 DIQI37LjttZ6Ltl7EcXzYR9pLsMFVVmtjXIKLgJv6I4+yvLJoSn2cz25rpUbGB3OaYCmaiCDp
 jvgu4EjgJqYKKMcLB1PaLEaONFUKg/kePj0jOQ27mVAAyz4hQOwBLtlW0uM5ETbj3Zl7tTJcE
 6hm38IPZq5pszFGO5JWn114/AH2y/GiOJhzH+/D4ylBguDjYQUKU13XxPWg0K3QiRggHjCdNb
 D2OqrJhWR14F3xA==
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

On 4/30/26 13:16, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> ... and PCI device helpers.
>=20
> The various struct pci_device_id arrays were initialized mostly by list
> expressions. This isn't easily readable if you're not into PCI. Using
> named initializers is more explicit and thus easier to parse. Also use
> PCI_DEVICE* helper macros to assign .vendor, .device, .subvendor and
> .subdevice where appropriate and skip explicit assignments of 0 (which
> the compiler takes care of).
>=20
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibr=
e.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> array. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
>=20
>   drivers/video/fbdev/arkfb.c                  |   4 +-
>   drivers/video/fbdev/aty/aty128fb.c           | 143 +++++++------------
>   drivers/video/fbdev/aty/radeon_base.c        |   2 +-
>   drivers/video/fbdev/carminefb.c              |   5 +-
>   drivers/video/fbdev/cirrusfb.c               |   2 +-
>   drivers/video/fbdev/cyber2000fb.c            |  24 ++--
>   drivers/video/fbdev/geode/gx1fb_core.c       |  10 +-
>   drivers/video/fbdev/kyro/fbdev.c             |   5 +-
>   drivers/video/fbdev/matrox/matroxfb_base.c   |  38 ++---
>   drivers/video/fbdev/neofb.c                  |  29 ++--
>   drivers/video/fbdev/nvidia/nvidia.c          |   9 +-
>   drivers/video/fbdev/pm2fb.c                  |  11 +-
>   drivers/video/fbdev/pm3fb.c                  |   5 +-
>   drivers/video/fbdev/pvr2fb.c                 |   5 +-
>   drivers/video/fbdev/riva/fbdev.c             | 128 ++++++-----------
>   drivers/video/fbdev/s3fb.c                   |  32 ++---
>   drivers/video/fbdev/savage/savagefb_driver.c | 140 +++++++++---------
>   drivers/video/fbdev/sis/sis_main.h           |  26 ++--
>   drivers/video/fbdev/tdfxfb.c                 |  21 +--
>   drivers/video/fbdev/tridentfb.c              |  44 +++---
>   drivers/video/fbdev/vt8623fb.c               |   4 +-
>   21 files changed, 292 insertions(+), 395 deletions(-)

applied.

Thanks!
Helge

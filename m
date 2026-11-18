Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4418606A339
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=N8OPpb6E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C6210FFAC;
	Wed, 18 Nov 2026 19:15:41 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AF410FFAD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:15:34 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795029333; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:tznRL4UXrJ3TK5jjAye7QVtPS4Nv
 WGaHrI6gBczGOo7h22dKVY5KEi/15BP7wPjSIdqpexogA0Q99T0sJn25AFJcdBUdgH3GvV2V6xo
 OfELmUnhX70Cjaro1y8z9LEdCWlhhID1yXD+iHJt/NxLfpDDBhJB6+ydYQ1F2BgIxoHqMM3G9eH
 UNiieYmpGKojAKVOQNs++N/DN8+gOjPnRLpC1RuZwYxCTBOCYJ+cUzEb8We6S1pLF7Alznldwh9
 nXo3brGKz+TmTOz+hUXcR7IkzZaxy4xO/7OkXLux8WdVooQvAjcX3B3PG22nrvo7FYTf+6WEoZD
 6phyoXMZ5SqsKg==;
Message-Instance: m=1; h=sha256: RwVPTp89gxWzTJanc5CTUVEZqhELOx50wn0yqfdghXE=:
 UOYexMIF9MnZ1REOgZnxzRUMo8ikM6q8Ix6NJd20hSY=, sha512:
 dgbowvGOA/d5X7Dl1V+KGdwXSo5f2JP9WzVJ0mxBPsUzpS2V6InNH2g3PPtL8R3n1jscQ2p+AWUU50/C1QKfQQ==:
 B9SpYHKU4gqRMNtCgMEFQ26fmgSNb50gBXVycGn1cxVw5semwqfI5YAjiJoa/mMTtEUlKHmJzF2Pwz7rvuHZbQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795029332; x=1795634132; i=deller@gmx.de;
 bh=u47cAxSdQSkx1pPGekgjoJHfC8hpbnBxtSZtleu/S08=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N8OPpb6E4g+CKkquwCge+Xcz6UESgNE9VC8b83d5OPGOyWfjUXvA4hWViV5370x1
 L60uOgTF3A3A6JSmJEz6EYtYLp1OdJ463rEkEMZOfJxh58xG/3DzPVr2i2rH5WESC
 HafOyaSPZ0GSVP3kv0stVg4TAM/HOcnaXUxV01ylZmsSEFv+8ZWKvErfD/zuKXF2d
 Kg1r8YWdpBcLp4FI5IFjAI0ESL0wZXpT88lFkdhm958jM8LhoR4xSpSOilGefVswK
 TLLOXxPmb6GKUMKiaZ4ZiFFy4hdWYdKuNQPY1/gV4YUbAHzUcy497aNnAx3ylWU5c
 2HK7csgNbdRmzNDGHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1xNyEQ3ReH-003vBo; Wed, 18
 Nov 2026 20:15:31 +0100
Message-ID: <4a5d5e4b-e376-463e-a919-2c16a625be1d@gmx.de>
Date: Wed, 18 Nov 2026 20:15:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: smscufx: don't free registered framebuffer on
 probe error
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261102084830.9890-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261102084830.9890-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EroS975HfyOQhcrxKU/luS6olzgcAVSdSNOMZW1HiUIYtogekH2
 TANB+RC3RgbF6GCTYIrifTQf61ck6jB8VwheO4e/6ALCOuTy1PjzA4X4TMEAwdNUZ9yihOV
 lWgmUzHBXHMGwhuuoQpWQXcbomBO0TmApSJFiAER0ifE9eFr9BxNlENeoWtI3p9Il5BnrsM
 w+qzysz/8Zi/Oc5B0d6lw==
UI-OutboundReport: notjunk:1;M01:P0:AM2WJbbDq6E=;rwUTPbig/UMteTDB2+STJ2kbLMM
 OdFNNdrnq7nASX3NxIr1M572SetwdZ/t8u0Hsc3LobSJBl1oguQYevkSwegenPRGH7+/5aCfK
 ccU7Rv7+lM2TRYndBCNWfkT+1e1VoCxpH+CoS6QMbzHqh9ZftXl1TF4lH9MtcbjkrIn4JxnxV
 6l1VRK2vhFvNtiYBGMOCzJ/qMuG5Q1eaJEZXKP+mOj7iooMwsmPlH62SxAFGj600+FQRROBK3
 FZtD71AilHoU+ftNgHpyAFiJgD6NRiLcOLQRMqMJDFmhpiMPA8xRJmxl2oauJ5KEYQ6X4GKJK
 Z43wlQJgAUW/dhSxgMWzS3oC10WOKZ5da0OnihWEwhaBURtULYP5vEtVko/vGvQnQU4vgPM0N
 shIbwMpng+Yez06kYBfO0abs+bPBCkbggWLlR/SrQGlysDN237uHadHW4IaaFwISH34Z+LmmE
 vNqDrIHB3ui0/iIC3MUIbwvirISDQ/JHV2t2dbCWHRsqGBmAKk2egWGozkxpsjHPk2Wd0XDhs
 gWi/uOXrDAfqwzEZGVDQgHuQxxyV1VHE0FGx5vqb9mMJuwY+92rxyvPvofGpld/qA0xTwRN19
 pfNB6/xjfty5+cOHNwGdpeN9UnGbR+BZ7AykPuO57VPgTmCIfw0a66o89nJ4mI8Id+y2GvFBr
 Fa58zdZYC9QbTOHjEsmZPDYCs96HL16NIQtzDZhGJYfGCrC0DGdZI95wZ5WpoemYDyDTg7p5W
 jJocpDhPLHGJFYZnI5nHe+VVJh1D3xgCHOfaCM9zQ3iUuN3PCaJkx0s4EwnqyQPKSScS0b/Zh
 3VsJ8M/y+ML9oeuZpdytjoZyf5dgVN66jh4cf2E+ulDrc9XHKeIC0bAVmuihQg1nfbxRr5F7H
 i4wrxmSauR1rJ7hvUn1iUlu/vMekZeFUTm7iUlIhowNGQh80p330aZEblXlfPS2T80zTqxfjb
 VkYEoEbNEx4AQ9TeZO9Mw3LXcQwOW09uCh7jA+VcMdK5eU0eQ9E5ghYku+tLUoDxex+/xHrAZ
 8cIHR9Rc/vKELuA5y3Kf1ESZny6iBQjYVUSj2mNkzhVslAXYwePKeY3XUGzrzt4vchBwsLa+c
 auPazBOVtGzVacZGiVdm1nmZsE5bqUQ3yjkQCrRDW/dWe8XKgnYO/mV5x2hve4yMdZa20f5/N
 ZwDmoa77999Xo4h4KpGlBA2ef4b7Xt+uDrP60QBv99TBR5je6WTlDiFpEumAKHD9dIswLG1Ib
 audjkp8ooGGWXi0N+yICmRzYGmenf6ibK7uijPlVSfptsuBaqupI63DQcc/CwpuN8UFskRjeu
 +WRwvoCH7mgkkECigh0aaT3Kb/aoG2+fMXJw4S037fdbNRshT3zIbmgJgmyy0RoYPj9O7JPri
 ofAhhNEFn5lF1Dm7cEonA4kweY6gQV/GOnhyQAhEkXL076PCwLLibF2NIwW8UoIHMvznebJzg
 08BaFHnBzl2zAOrWV7nk/CHXcqOj1gM+N209/d+qM/4WUbUAZ4QJ8jthHD306vPkFRNIKygiV
 2ALabT/gJiIA9gEs1lZ+6sNA+CGvVoTPTwm1Z7fueoPQG+No6FyYQHHbkq9/qRJKaipNNHVe5
 6pv7lFoIh5xaBHlSZ91dfzRPLI4aWIH7rvVlVzbWZETgl8HiHRe9yQL58jrYQRHcxTORl/6PO
 isSeUCfRIJGVQnoBLwQtVELXKK2S9p89zWxea/rtEzy6WyHX8dUF2/c6ISpPjg/qduFCgM1tB
 BiqOe9KSKvSp9zE6XAQFH23h3N9ZaYuj0Nvbk6qTMW4dI/lOMO6KxlcEab8TkwpcuLW0oWH9M
 i5UurCsWmk2fPN4Eo147ahl+LIyjvfjt1Jy7dxT8eTQTJ9lcC5a6L74aPaKu9ZGWnrU3lkdmT
 kRqZt32cELcHayd22Yliv8KjCqiJjMad8QMdK5aVvOgfZ793ZuMw7oFBSxugAsKshDzVoWQxW
 g4RMXcE8Zz5DQpJBwwkkAtWsxmgkH8Qlh4aDGBqPEPHeTfggmiDOD4TYMjV8VwG9EtUaWSZ/G
 oSU1niwTY8sAsfqWAca/7DH9ZZ4QZ8CioIj/nXuyLaTnvnSj/9/oDb8XNWbezNLB/qRCSeS96
 QvD6V9Mq6uJkchmA6wAPjL8xRsGkmTozidkRspQqrxcMSZIcABiIRbTSi79GYWuJzsxYS7Y5s
 09EhAVYTcbxGzDIHbGd0FMFoW1vdEWaCUyjgv3POTZauBfaizptZcpFscURxv1fo7vCdhIMai
 HnMF7FmjqIsclvCFveg0cyC9m1PtTe/zyptRk38DUp69HePstzoaAD3wvESBbE6KVsTEQ0j0G
 skhF9ah7KPRbD6oKuAlrbrbSHdvXob28cyQNnfHol44TqKpFw4aNtsubLPMSKaaLTLeigoPis
 6A1sVsUDE5zV5p0T4QaS6CiRKS2ckVTdfV9lP/bnPo2d5v+PTysAKu3+YkRhKPNlA0JzUZsjg
 78Hpz7yQlXv3vMxjSLqlhYvnUOwbBP2EmTxHU94jId+i0TyQP/JyrzbL0p4YYYFmxBOyGDZ1R
 i4OfX87XpgTfi/Le8DAa8Se3pImKLcAEUacUyLkHJ6HDik60YVTGXbT+ZqBYTtD3wYYMbwD/8
 YFNkntkU/LmTJ8fOJWzUaH2Nn1yMHO/y+hJb+a8yCfTCJNW1Fc2KP8HvUjer1YrTVRdNwViyD
 FMk0ZtxX54nvWte5ZIcke/TmL81yCpI8a06iTf+bgWLEJPRYZkDH1J6a/ZMrgiJTX2SkX12uk
 syYrVq5SKaGhu5vrC5ZRcyR2i14EYTIJt4MlE2lmi/cwQL2p5eQZww1O2Cd5CIaz+7g3cXNRg
 84BebTfcBL9OgVCu81q//yxnfIRvzVXgJp7pO/DQOR4dnUiz5d1W8p6iL/JWeErHC+18OlqDp
 90bC0H62it1aeMmnc/8kD6DF8xb1oQS1jvCDEkA4OwU/YqsRbLusFJ94IvtPsbC6HMdttxPrK
 MrUQxw7w40IHzuTuskvhv4gqLpyF4gaHVDGIo0ThApFJ0H7t7vY/4ejtGTTUF7mo/agBQ+OEE
 v2yGklgeWsT2RUzqsAYRevRqNPvK1HWGp2+7Rx0qG8pqmqIVLiSCi5dfgBPcldUg7SDMjixpO
 e7wr9WEXfvy2xnqcbMLdYywwhi1xr22Vaw0VAS1y7EI0ZZ+iS6vsnenJT5NdxzADCsxTXt8uv
 g2TFs06FVnt9zsbm3rPCU7XzLM0IL0Qb2SVRR3nPLLqsfrU7+4IfWwaFSXPL25n/bb3UEC6nc
 dhF1ZBHuCLEGCnlHH56UEH5lAfT1xzM2ctWqMmKLzvVPFVJLWbjIl2Qujwc4QBzqxYQqk0S/O
 vl58kI2XghsNgeNdzcRJ0GJnEBgcOLHm78iJ9QqOtDbP8aoo36jnxEkbcnZTDayIQ4+QGahSp
 0MR6gMSbO8iz8d45VH4SsX/iIatNGqve20AFm79cbH08CrmfTp7rAmSJAh+PXVxTtcm6NqIwx
 JsJs05H6AJ2burjk1hYneLUeO/9vKoJnqII5fiIbvIXnQ9XEzGanBptEGSZwko5tWFXx1Ko/X
 oDtIjXX0JzxQO36ZPj0I6OrLkfnloGN4Txg2ggpLdro+75wE9hhVkVbgF5Nuf6S94i/2GsQv4
 k9e7wM33mEmrrcigaXb0MVi0uw5OQ35KIkPooA+AVnAC6hN6kotChcRx2gsq2ZDG/oUU5ngYz
 I2Shc+JAgzWsuCK+80Xg2nKT3ASr4YWzawK+zvyRvsXEy1R2vHyJSU++KYKiaexdXxoacTnGp
 ZzOOMWOCKU3WHXPi6EEZucp1e+jsBGALP2BNMx+6nwFwWXI32ArvoygsaGqRt0v8S79NQ6jF0
 RZEGALxfvq8Dl+YLijwY6p9p8O2JqnzIPEG61F3+nwvDLnzRD/WhG+oXgqjbcRABadx+uotbM
 bDvSxt+zsxwl2zrye8dP7EVMM+6UGMKnkiZn0CNBMYo9npkQaZb9hHdxk2ZbsgGPUJm0n7SSq
 LMZDNVnuUlQIq7Ymv17OFW001ca5A1VYmGQAHjBt0Rwsj+XOzBMUuZXLNTKggD5dZfhp4b9r3
 SAHcRp9U5MGwULmiMDsHKVJHq66SykohPggescLrr4MUbbAWs/KB9x9SlzOFi4INDPBaDVaX8
 R26ZAHM1OYaC1r75eVA+8VR5TWeSLhfzo2uyd7ayGy1a2dgj0EtuPU+HZOn6ZrAEfm2+CJGxC
 4YWr6KjwdXii8DG9WV8t9/Kh+6ct2UNbhyCAfKTnHc5IlFQ9kPrMV02Sp/FhW82kz0KasegW/
 E8Aa3jydv6Y02p+IlB8qNxH7+X+k3BU0UFoGJf3bWgDq6VvNeiBcbTeL4UH4QpfBuiZECppB8
 7yylmxj5LHfkJcTl+d+w+MHauqFLQUzTPtqwwtvCOGFHndqZ09OgVB5Vv23AOlCxoT7WORE5Y
 RAq3GG/xKfOfhQ7ofCric+NQyw0jZSfaywl8wdlgycO2xcJ21vCG7IS3gz+geQPDWVkZvlic6
 vnwRQ6Cs9minC60eJDEF1t68TooqAB2DavypO/zvLoI6WflHi9zuf3399HC4g8mIZMQqJc8Tu
 WVrfyf4qwZldtjsggfjvGWwHrmzdvSTZkfgIB53lSSghxxY9IYdlFxnvZCBNcHhiKurV4g8A6
 IuRNq2I7swXBxlRz1BQRNS7RfCLM8ViZ1zVILfGDzwmXQJR7pSu7+xZ2LNIrVznGJs0alwsww
 U8QqdpgHCdqw+IFEv7N0B0GunUdFxNM3OyATQaNJEn4KQBshfVSkT5KaqwDjew7jliwtROcmL
 DLFci+EK7YnJD5kXNa/zqAYE41GCXPx7YHj76p5hPHCebAS0Nyv/rPIAyhbu3YVHln3khi9ZJ
 DU1aFKF+V6H9IInsALpTT+QpsAa9nzCJin+1miDDKMP8HNNKhi3apVPAXfTHUTMNrQU7AG2vb
 H5V23NAh/RYpFVM605jAI9CZMflU6qtKuV5EV7zqHrHQpHtIzLVZ8weGutOa6hMQ+YXRbew1z
 MROnBibUCg6ryxoKrR1TOrAc0UMc0mOdEa+8Rg35xzJTrG5nWWwEcrjyCPuzZ8xPoVULn7lw/
 xxVPjJDuFbbCbYyUhosv0UUclnVqhIZQvAyRW1IwfHoOVLVUSy2jdwCfGwIhN7SOtaOcvIElg
 r7rrLMt9jVi4R8Whu3OrrVM1FBX9F3TC3NVGTSHOcSJk7XX0GNmflPMQTReI2T19NSinFmFN+
 zIRU1E5jQeOMVuBb1Hr+OTOZQZPFkgO83RfXBHwh1T1U58NzR0huWjUAbdIIriTcx5X9NCUm6
 p/TwWi1BZSQ7+KH5+qq4b/uzGSHczq3KRgE/KpwaUbqaFm9nNhUvrssgMfqGEPD6g955do+j0
 o6SJ2QUd2g3Nzv3Ne2k/9MibqymBE1dfgPwov0HlwEvyK78bh6tn9lDZieQBD0EiqHzyoSEA4
 wUqt2nthw/nFFtXOAFbafxON+518zC4cR+paNvohplhkIDDIaLg5HiKVyyUApoS4h5g9zLRPC
 gnhsHpDrbPOOBQP7upscwbQCFtiRlqwwsOxAdJhKdGNbL2tmwpkps3E1OZ46WPiLQYERivr73
 LN7vxcNapXwOXiZaaz2kxy7ljFezKAQelnFhJE4RocyTVSRwK+tpyV8MLVIvX4QAsyQ2+RIEW
 o468DA0TPvzUaMEbxd/gNMKF/1O9OarBb57WU73Tn2CU2jM436qDdGBE4RElYuG8g9nljq1oS
 ouaOZuuOvub65RjpO+XOsF4aBQwN7GLrDHzgQsCs1igyo1aR4RhILYnkAyqA+dP6lkXns1XhJ
 nWRDAbF4yX2yrg+lkT+8MO8rrLHbt+QKfSvXN93T2apXwxOcqTjnEmM5Im5sua5RlyDqotusV
 Eag55tBEMogeykJDBBPDCTRGNTfv2cEXGsrLg/po0ngPPQhgtsTUeAm5kv5rWpFXsoyVIAB/7
 8tmr6ebLmg0NJUCvwYMaBuZran8Pb9kZFnyT0J/tmpJwvytjhU7E66/5/OQ98IE2Pp7BzGMQe
 wvXc+mndvoM4htEBvFF1Fhr/f+53L4cbGtqfk4t1sULJdK3Yob/w7WgzYpuuxLf9N6lZ9n4Lt
 Me1qxPvW2u3wF9Olkkt9U1HyJH9SRXCnbC02qGtGRJ35MaYqduaW3GUFviOCbO3ynGGsj651J
 35dVHs5Zf2OBaepW1m7FHK7QB0xB5ID45XycPIosfsCJ3SodxfqIFeJvrFbzV1q5ekz6Or+92
 Qb/xhMxmTav67qvhOyS/WvCvUB5NRmiboHy19OMLicCNhRLgCt9OOaWP3fsZ6uo3BF3nwLDHh
 vX8kD8QK9PBIlDEeqCT34usNfWP1T4GIK0Uvv2oEvcCSWQqwHZuSLz9hk4dkA5xbG7iXZ07a6
 s8TEy5UVnFSEJ5qdm1zvlm+YBkekg+28eoXlCMDkEDhZtfV5h73AS50FTegKWioQWVMtqFZ5x
 v3cpiUWwcmRgxTy1ex3mnzQFjthffoA2zzdtc8n+jnXiNPbA9zpvVOWAvdVRVURC9ds22D7WX
 xPZX6ADyLBo+l+txVj4o/Jk4E8ZZSS6CQnwNw1Hnd/fy1Ows0Lijlm6IoSBj9Vz7bYZ4gcyyC
 OaduAMhqlMlzppxgFHKo61c5Xq6x0LUtbujoAiyZJibML2zYIDqfGCubSzt43gXD6G0ImLOyV
 9jQ8U6dZnpFwHPHaaWZgbOzMfPaZBHaIeUsZK9979Ub5s/lxYy69cbtvEQ4cS5NfZv2+1hiBc
 F1nM8pE3ZCoPWf4gjKrx+i5tT9zPYMBzErJpqSH8mKxNCjq1BboY/n69aSdwaXrx8UJKxe74V
 sMqRxiGHmR5T7VJ4L1w/UD/imjh4dLxwPgWi8/lyyNJYin7LhixFnXScVNTHYjXKWIRDFKJcD
 2CVzp9nlO/oqt1hnd2UriXZaDLpvV2er/ICc5SZUe6ImdxrdoZsuhTR0zgd/iJ3RlS4DMxYR0
 bHeo/L4+JcH3xE+yCPWVW1Cw6oN5+JrRmJXFUJ6cSdRRojn1OJqE+P4jGk3kdD9IcmTFnxfQo
 J3EthAuahKR4VPmp9LMH/LvD40kE7jwEzD4sDQUsS+mLF46Il95VboIQBdbYtgVYR33KI88P6
 MS3UVTk7h+bpCFcmzJPtj8Ba+NoKH2Dt+0YgdbHe4D1e3IZ6lbtuJoB/1gn1SD0ljNtzWSmwA
 Oox/4KzNzVWoogSNl+JpywVrfX98QJmB2ASrHbW0GOEC5mK+FlckYm8CUGbdZS+pHt3h8++a/
 xFK6az81YN7P+qtH+7l+a8FMb0owh2hNTJe3aA/zZJOaNxGYOxpOW4/Gngv7wvWQeiaDXLizj
 3KkVts95KEM6eSrNg4so7BwvMdB5zGBYj6YIKaAXe/OUoufDlbzN41HPyXu6J/A3ggkOZiAvd
 xLVWyLssfEVU9nk+YHokJ7QCVNtQc7DkGxUuKrBzGYFxoKamsEQByRsfw9/0wh132zO157osY
 iQN8Pahamnf4Y8cR4UXXIG+8iT4tqsIs7F0diaMIooJVey9ulkL9lJ3z0zu4Gp390THvoXvUM
 /j+BYXB8OK9CXPJSuxAnxIkb/y+5wwxxeQT4FiXABCskj9YEs/Bsx2BRWxJKNmgPfur3JKz8o
 tTg+3kzJzgUHT8JuupaDx1ibUnOwC0PiAEbrpZ6rn7aGYBliISeb
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 09:48, YuanZhe Liu wrote:
> register_framebuffer() can return an error after the framebuffer has
> already been installed: do_register_framebuffer() bumps info->count,
> creates /dev/fbN and stores the fb_info in registered_fb[] before it
> returns the result of the console takeover, and that takeover may fail.
> ufx_usb_probe() treats any error as "nothing was registered" and unwinds
> through reset_active, which releases the fb_info and drops both
> references to struct ufx_data, freeing @dev.
>=20
> The framebuffer stays registered and can still be opened, so the next
> open() of /dev/fbN reaches ufx_ops_open() with info->par pointing at
> freed memory:
>=20
>    refcount_t: addition on 0; use-after-free.
>    WARNING: lib/refcount.c:25 at refcount_warn_saturate
>    Call Trace:
>     kref_get
>     ufx_ops_open    drivers/video/fbdev/smscufx.c:1033
>     fb_open         drivers/video/fbdev/core/fb_chrdev.c:351
>     chrdev_open
>     ...
>    refcount_t: underflow; use-after-free.
>    WARNING: lib/refcount.c:28 at refcount_warn_saturate
>    Call Trace:
>     ufx_ops_release drivers/video/fbdev/smscufx.c:1135
>     fb_release       drivers/video/fbdev/core/fb_chrdev.c:378
>     __fput
>=20
> Reuse the "has this fb_info been registered" test that ufx_setup_modes()
> already uses: take the error path only when refcount_read(&info->count)
> says the core did not register the framebuffer.  A failed console
> takeover is not fatal for the driver, so report it and keep the
> framebuffer registered; the disconnect callback will unregister it
> normally.
>=20
> Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adap=
ters")
> Cc: stable@vger.kernel.org
> ---
>   drivers/video/fbdev/smscufx.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

applied.

Thanks!
Helge

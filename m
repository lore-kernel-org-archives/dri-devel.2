Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8C606A330
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OkP9YVEm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4627910F0CE;
	Tue, 24 Nov 2026 21:43:17 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846EF10F0CE
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:43:11 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795556590; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:Hq7sHlsptB4bBnwI4i8LwT0LqkNA
 r6BO/nUDr0LW4Tpn/D2wlK3SN3Skrv17NGqXd19TOZkvtaFlld3p/piqsZ97V4Wt/LkUzpTQFSa
 5rm/LItqmgyuAXmPIT8iaN0kXK0jCoTHGC3PYLcum14F45Ikfd9tJ0KDJDkwZhkhpxFfV6WFtdR
 B+E9XVquQ8iQFvqCrSSbG9nqFhV8rzH5SjZPympll6f9C/TUTDQz8VGJCelIQEvHnN1vBBnmY5/
 5Piq5XoO4cO1vbH5MvQ7fwiR54VeA6VDLPk0835/89ZF3yJoSaY4WnuYAcX5nfrJ+Ooo2ByKE/k
 A2yZkqSGAU7eKA==;
Message-Instance: m=1; h=sha256: Wf+s8c/PHoAMGoTXRhPhwbdmEx9yKIB8mfsM2GegsX0=:
 yxaZs2TNamP//rs/+sMijz32fBQxXUNn7c8Fdp4/V2g=, sha512:
 8L7kHMepd608RUgOicXoaEqju0L+RDCli/Igl37m7EAHuU8LUbwXdHX+YHFbMUQ2PrF6YlftePsB0+WR0OhMpQ==:
 6/h+Ay+DB4HVnpqcrV0CGkij+anmwAYyf9COwTlET7uWfwh/rKefmjrWLrCJiDyA8JWRbVz4dl91OlT6yWoCoA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795556566; x=1796161366; i=deller@gmx.de;
 bh=SCLhI0zYUgWhlxsEWudQ/u4dDYR36QMiLxAv69D09t8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OkP9YVEmjstrxkeljnfDYzWQZKQh9kkHzZFW8xvn0o/mrpABVbrvkNga4/KOJoiJ
 XwonfvwHqZXk5AaVEHnKpwEXyeftYQe91TQdj6r74Td6JfTBapSfRlg4Z+MAYOdbS
 C52UM8h1g+p6/rXkmx3PwFx7viH26+DfWH5eMsylbIbt8kbRPVkuMZVMGoqEwH55m
 h8ASExDypS1BQMZhp3P0zBUSAMeIA6xKqM/1b2hFTmPG7rK7QypFAlGNi77DNmd+L
 I5qS81Et/GG++asVU5GsIBuhEbMdgqd6HKzgglWUu/oS5Ka7Be1lb/Rn7yZp/N36a
 PJ2X/M/gjdrVmNuTjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1yO4sM2pP2-00vRWV; Tue, 24
 Nov 2026 22:42:46 +0100
Message-ID: <2a7ecbf4-e22a-4216-9a7a-9deda6d957e5@gmx.de>
Date: Tue, 24 Nov 2026 22:42:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vgacon: Update CRTC start address when turning scrollback
 off
To: Yu Peng <pengyu@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261124024933.306103-1-pengyu@kylinos.cn>
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
In-Reply-To: <20261124024933.306103-1-pengyu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lidcouJmdQpanBOOIs88qi7Ova0gfuECMIVxm/IC88FSpzjHEBV
 wohPXHLHyjiLMCMIQgfWPfGdSFxdVRDurZcZuBOJI5lmoHO0ePfBD7+9LK8vNYIgVmDCyZh
 ECLzca4g4pVOEWX9jVYEoBrGaqjTCCbJYFW682PgPlVuBk3P0CaNkJslYj2qQMll8Y0dRXm
 i6dc5iFMdD0KlvRyGu1ZQ==
UI-OutboundReport: notjunk:1;M01:P0:NGuUxNd94xk=;vB7kHwCwOSYPn5vjOhMdq2O+ijZ
 vKj4c+sDdjmC2s5eCSgwrUAa1Ss1ZVX/lMOBX1v0HblMvI2vG7r291wwVPj8WzqM4vdPb6U2V
 zXqI2YRWl0bzK3nO6LbqRAwcJo6pSiywNqko2OyX4hSeCtCQ0h/1DDP2XW/asNMnM2PIaDAaF
 unSa37TEFj4mpRH/u8FbMSKH9W6ZMtFhy+sUDWsBPusc2eZCLA7svZcvWifU9uYlkD8nWtVxi
 4GtNU3ncW6vLqoKJzcXDTb3HyJl9bjyLwtVib9eBSQgu745mMdxD6LsvMowU2YFjaYIcAQGk8
 2LEoTGYOoR2jwFvkoP9nKKrbkd3bsvE6Z4TsrQ7OJxGzqw1gQp+MZN5pv6/L1F8dB4NxUaglO
 oDxqGniJbUhs/51a55UdjlZoBPCWzOHC1COwE4lHjnXzD6gbcDwTT3ctBa7pCSyUwlKJExeut
 Iei4h+cuMCSXScPUnlbahU7tu96zjtFFcz1jWkKCf5s1E7oE9VdVsOr0rrPKhAcGIyAti6aMD
 HbPNuPW5iHN0QT9VETfSHFJb+FJK+Enr9AqtfriHZ1vl7PwDkTZwA+E9lo+fI0cGju0H/VLsW
 Z7vpl+zHyiAhD/rLUnyg+YY/uhoLjtrec/qx0x2m+81Jqo4UwiVH2m/IL+HbQ+3Cu0sFJSSBB
 MdNW5h8bVrTUevcsBV45aE2JP8sLp0fNQ0v7qyVl1OxBL3i9X6IuVXC+lvd3ni+RPnqoPa0Jk
 o7ssEdlGFnVuy4edougr2j4O+ZMQoSKv56NRJJUw+lTxnfrIdGv+C/Vms4WdASJOKH+e3JLlL
 y0YSkax8M2U5AFiiZaq731qJR+j9IIcBlkWQIPxcOYKhPAdn7Tt63XHRZ/K2VwZ3QB/TllBCM
 +WuOx2DzR7PuW0MNs0/CohbVRUOD1y6gCWvWcVv4y4I49XsTAeJ6gla3JgXSKZEVtMAgqg1tk
 RmVQyiMnOOMZLiCSCRBXY/TlsHgzX6KASd437JDCrRAsg2oIuZV/1Xv4xbnq1BOXmp4UFc7rA
 hTPaxCujNaPbbDBOXJ/TaiKMAaOS/6/DnO/KCyrIeVRV/op4kYD1gkIM0LZYLbS1s44b5kUe2
 Ns8JluQ0oLSSzWWWe0UJRboNDbnB6knyqkQbmP4VilezeYSchPiChTSt49SS0/NNsgI1Z1DXv
 ODg0JAEM+hI57nejypFSPZnFC4lI+6xUkn92yW2s08LZf4sc0mkdOtX62ZU/KNB0TxWwykG/W
 J8Csv9FC134HIcdQdKgdxX1IXSAnHTnf4da+SXhJ1/v2i+p8xR/CUFhTrGoEawOgM38eDYRo4
 I2UJ/rTBHmDbnR7HpJ+KQmZqZPX2HdeRSTZCBJwHhHdeoVAGVS1h9VXpS3fZM4d9OoTJu+pbD
 mDnZr1jjv2WY+zkL/CjL+vRcMQ/Aqz+byZQveZPJUX4L2msXAlhGP55yyJclko734uIoc4dE9
 4rHZo15q+c5Wm2lHA1u2QOEbhBntpJ/JMb8fwq7wR4lIJVrRDGV58NEcUf3fXB/CZABxG7IPU
 SJjouRP/EgJSLX61FVKB9siSQD4P6n1z3sjIcbba3FaymSUG3Xqmjm9b73/CgqHGxH8pd2BCr
 GbKi/cueSBOkudImZJHM7n/SZw+TsH/DEQelPR4ACa3PXwQ2ldjN4KCEop3u/1ydCQBqPiejH
 ye8DEtAW4NKBgMtjt68yOT2GjYLZbHQSpU3t3RPJplxjbdCMYhNU23z7WI2tNu6Y5np+69J7B
 rfJVTtzInbLvBTjCvin8mnoumvRdxx++WpAD4A5g0dHmHIR6wQRW9OxMAMn0WnwQBU+OJtW10
 F8/RxgwJwIJWIddhtyXwUmlrosaklJGohk98IEvR8U58xDo6+S4H1JHBfWLbCoYNmq8QaWbnW
 Cvh8e6RfPYmF5LEiaeNSneKP9rdgTMlYhy9VhB6/cpnSAwyChxRLAOj4j/mIJXPIs37R1O80e
 UrW/LiHiMV1ITZ+ltkIE0/La8FDBa5sm1aX21ydJXSGo81SVMo6oPyMdUr3s3yWZON24o12Kb
 23ZnxQxNyVQQKxzxX02b64cOEkRdyZ8SKuxIZWkH1Yn11Dbl3pkGngmV8mVq5KKwPZ98v+Oxc
 KYgW3OTpLcCmhPyz87eoPggf/zOVQIl5LAJX1QayzsFlKqGPzWWhRsBL4OEPvfV6OuDsmACX4
 HOGbWyL/L7mbWaYrMn9ebHAaxYtFN0iX6GrfyfQUbIM+YOiZKA1HEoZCYGWQwIzgIKEgPkPA1
 Zxq6+vgslE3U4pZxPt32tLRCk9X7fB0emrYMuWD5F/YL7Gelhquj/bTqyFhA0PDRCDXe/ue3q
 5QP//HVX3J1kLffUzydJx/Xm3tPM1SA2AyT4Y/iUZKFMDAMe3+tiKB40xNOwvsDDsjmggBR4K
 /h3JYD+18I60Ayc55xb/EZgXugrFTO7IfEVg5sO+c28IJLDWnPtjULVNXmCW70JtPbGFhZLf1
 83DaiWHE4jgic9sL+mhVxHRyCbb23eNkDp1xTMC3ggBuzK2iv/JPVQl7/iYY1XA4VuF/GOCPz
 4l6AI9RINPqrbt7q1DGS/KS9Q8iIdVSgdE38XZyXJBwbstIMtOd36SNylsOCIkP0wf2w+WdIu
 dJjkUgStfHdGkgT3uHw/JrEByek2E6dPtvZxNZv1co0bMB5RJcRle6bpRiUr7SiTKXTKWNAbO
 rlBtIR0Mbgj3BrDbUeShJBt0W43qmosZ15Lq8aAg6hkMuCyCVfaVLvuQ8CyKzrGKWwcKJteqV
 Jel0C9SEDA6SqBVdtcpHLeZ/KBGIa4XNJXVCVNKMXuNnLP9JdItanJ1foi6k6/swCLYfcp/Os
 mY6F2+NiKpHUJi1q8HdI9QunXbnLOLrEEOhQ3mKgWyYbLyzdDQ71AXfDJMIhLEhOy35mvbGU3
 25U3qErpJ3ZosaOrqe8J0QQHtitkQs6WEoiEpTTt+R2jjFkzgERxwf3qzYrhvUEG+DQy+/GvS
 YQRVhc5jziZJzDiVuIvPLdLNsvN47FnBOSRZeBBM11OGDtnb+xHJkSP+qRCWbw09EI6iSfnre
 FegdC8RTs+ulHEYQbfMImjG80QmKbrk6EYmGOoqypiUPK6trr0GKYFXQcSkHRv8Mi0goCfn4l
 KMzfCi14QFLGjTd824LiQT7LiIbkkhUzfDgsKmwwZ8uvWPe05E7RGQHBwAnJBmWvK6YUePdwm
 nF3BpvIVH9JCtOS+Zf5u3hnkc3wTMXUns4GYNZUqxSWGoEGY4Sm4Q133ogXO5qzZDhyJ+hxp1
 v03Oz2s+13wATcNUu4uRvrKlHcMviA3bcl9f+bUON8TC+KeZSPJQNcIX3m8cE8ZGgORIPyjZi
 5x4YGTjL1biGfMatltPerrgYsmTzQIxjCoLU19KQbCaBqVcBT3YlM50TSMvPisDJpC7H35WW0
 vnQdEdGDLRNgqKePj+2Ts7n8grOwLWt/3u0xNBKpElMcJaffeHb7rdM7lgsjRQSqlQvnmrhW+
 mjXIK+Dwy83s+1DdY11X4a3DeCpkME0YFuSxOtq3Tb83zokGhHxz3D1pfundxq9Ap59HkvJMC
 mpbwHW++d7+nobLOnJQKZ3L7p00MuS8cJeNijaMC+yudmPzFD3YTiDbwCQ3JffaVTOHFDTg9b
 BtDyuHkfbOOUUqCkgeFldvE9/3Ren/pck15wNF7KKWKPC/oI/4iOnrdB/AqrCnzaX2zfy9CYA
 rtzF7q3tXvvv5xFmsQVtrIY//LMvDHJnYsIzwms5pv187CYUaO52pcp9+xOvmksX9xZACVomD
 oE9JO2rDzUQjHMdJU27R5kJqlpV78nwLNM9I/VSjs6BtHBTIhs+ZJJyZrHJKAuIAx7gJ2XMfc
 dcQm+TuRlc56l/u+huZYWz9+vZB2coU76ckZSGPfRGYnA3b5lapb+8BNzcWKk+kcPfT6okGUd
 uQ21UQbRTl8Rm/FvRnZrB6QLFtBwCE48lcvtK6GDUkSGhLS8IzcF/MdELI48YpE20HHf5wYmv
 nQJViRPJw7rNy9HUbRthJscWmJiUaCjZbEqS5tuIJQO2oWpfE1bnhgQuvSuqSPBSAo9Elypr8
 JamyrgiSa2d5Pxet+shH0PeiTvsF5TSGdJVN0xaOTDcx9W2mxG1pgekeYBBq1Fj94ZGNWnjk+
 SdIp2f2vZ8gF0iLjNBokQVhhS8FqX8CcLEGXIkTJw0Dag21UH8F0DiCsUz8a2ksh/mN4bq05U
 c26SSvebz1ks6RnkErW7dJ34UsVcSiB4ziWSAu9fo08aGjgOG0emqwKiBBb20Q+AUlnZYXY2A
 0Z16bW1Ai9/a0jUdVtAXhRnRbYf48juo6l6ldhIEGGkwnPgfmWJlsYhxeBzkjAmCO3TalST6x
 SP2gZpb7LtXvdl4HfzHt+Aq6TJ+DWPqNxRy3/NMyq+ljqkYJ+pMNrUq3m7w6sIjRr51//6wy7
 EuNrkli6JoSQ17ODsI6EV1yxBQuDVKbutS/sfR028p+fs3hd5Ex6zp92Dl3L/fMbL4pbp28UJ
 +ugkCRo5AbPgwjYZ0CURBIy3c3wQ01dLAhfqPl5rZozeSJOP/quzpe1WReI/BlX9SZ5qSiEpL
 STsyCrP1ZLcrcB4GqskWcu1Fn8ZHX43qhMbe09V66naJ49JQt+3l+PxktRBWF7T32KFOinAJk
 flJGm1ImpO5h3aKNJHlrO3N1pj6n/2Wm/lk3SVwxF3MxpDLYDD3/6t4A2B6dPZik3P/zGy4Cc
 oHB7S+XsZFIo+JgczE3yeJJ4v0RtVXlj+F372sJDpJ5JkW/ql/4cnISn/JCD8+biELm2nEdbc
 7dWKVJhWaf9yvgII5DZ1okkvKpWB0IWamC8onwYZYNzQTCbnXGswc0e9wzliySGCXDR4enmpj
 QQI9bwX0/pgVWZYCpTMEer7YQM1XaXXiKEG/DRBXI3bPk5ptsQbVIQaasmsSG8v2f20kMapfk
 x3k51xqUALCzguteoT3sYRDBjyDT2UROlNJHX9eZHZfB0hIw7q+4YhKJFbt+Hr8GbSx7RnH3m
 5bIUD4vCoZbBdwGr8AeJqj4YLL428qrFT5NVlFjLx+bIj05kN2+SfjHoxfQMUfGqTU0pC8WvD
 TgNye+fhXe0FFjRCc1IqpjPBMdsHq6nNppu7Cz5aDlg2BFYPHXueyzesypjgokJjiWTTf0IcG
 S6Vkv84pKLmT1p/TRKWmzSglvxQx/0EerSavqtMrxf1ZGRCsMfNyt6rmjTre0vYDE18K2kX+8
 Ic3sYDQSVH4iYqQ0R6ghoetrolUz8ZIGUTGARdac6/a+uN3NMCnEbgLs5c4Y2nHeXcov9Ep3p
 NTTt/TepOfzaWkE8pPvPBXK1M81X4PAMgAWtwuAjDThdpF+tgVXcurlUaXIcBlwN6oK3GEZoQ
 vZKAzBlKAzZeqbIO/Ww6AiPazAonbCDfyMK62TH/RKP/GvgnRpLWP6lexY90MK4Q+IhaRwSE9
 yoMnXFph3vqWAMWKS8y2x6Zey0jj1CwmT+xaRgiRUHkIMOmlZARZZyrdbWJZfAAKgZzQYpk2I
 c2LJ4SkRMRqnU27RJnf3DGdhWtDpWVlY/4V60cLQkZ7QoypI/rs3PuvPgUEXlh6C4Dxmt0sY8
 6mmh4jsGqLMDY0PnXV2KKAu57045qGrL2iJecwmi3fLFUmz1Od30ZpTeSCXXY+bw+DXUq4hYy
 HUO8f4Q0WlP9VgsyslWfQD6w/V6Br3p/RIiTLFuo5TWNTPfMSkl++fL7DCMHhdeUTEdJ/I7zD
 ec16v0Kr2e15QrzjTN/vAsniNdiUS7K30b4LzN4V2+w6SSVLW9J7IfKYc5Kw4/ICsIm6YjGjp
 Nbbw86YdrItRTLmAHLfgMr112gOK8x1cSLcgjLNWgUgnUsMaYPpn+fY6w2OUjZZOahMHPeZhP
 XzrlgElFI0xsDvbBKqOxDukeKIT50VHhdAV5tDKbiQFETREShWzIkm72/0Xul+QMSm13sjhTq
 W4mATUotgEElx0U/E466ojDKGmSGBINGI1Ld/lQoCrbtsSEEGj+H0j/y95RbEStdojrf0q0dn
 xDTtnQCMnfLIPlmEuLAGJPYTxaMuY8k+zE2H8PMbl3P6dqushICqoEm7ui6M7G6egGfuEnYrI
 8QUKARCP3YFrTrlOWdfa95Gae9Y1CJCYhXdXGzZJCXKdd3Y8sAzo8vSnIh6A2ClVNxseb/m8O
 Oy/vP00mjebRAyAdv5oD9/dFCNzAIYaPXiwAzFD1BPaFHDLkPFa6c6zo8YBtni7YEc5QWi/Ew
 FqWr3/ntBmmFz1yKiGRkMiK9QvJdf6c3p/fGlf1DvXag+0X2wl2YxlQZBWztHQdEJCGWlYcpT
 pHmxzCOTljihjf1HsEesFIi07hyvVTmOyUsJbysS2pl1Yl8AlfpjY8veVjbCU+Q+6oHKWPvr1
 iMQmgQ0l7tlt7M98zyshYtkkPdYtTbn1wjSFFGRtush+7KLPf1T6tcEWz2+EeUzCCM8uozYhN
 Yo/x4f0m9NhvnU5ikYrDmXq1BdWTf2BYlTad6oN81Jmbm20JdKUyeUck/J3WT1B+rlNznXaJN
 qYwdoQZ9w05dpwr00rw/SEGIoW9vK6H3qb4CyNieezhysDL04tBChMesJMiorOHDj/0cDZWVE
 eGegoG5CY/icLEBQy9KPzN/4VCqiUpIfK/bis9mMWBFhkJYg0XetrBUU5XJhICl7JxkZEqN7e
 aEW+ja/3SYekqV3idUskcr9D2zzyv/KM98MJfVA4K6RycXKJA0I2C9CyXs4JrRJROZg58dKw/
 zKmlxIW3XWFSIjn/VUJFmr+szqB6sem5v3eISrIzVdAfcwS7UTMcm8Qt0Acu4sUcl80Q9q/i+
 TczEmBmk0oosMPq6OUkcxiEUcdawHJCHU90wbdeqQfOn/FhCZBtZfEksb6KsMH7goeBTqi0vQ
 1AnKemwSquuCwZu7dgEJ83zXhoBvCCZGsgOVy/d+/X8LbKyjUkHMjV9ULbyrf187VhffqriXd
 mAcuYQPPlZbCYuFgFUlKhJ9OFaUQNaWNQyp5mfGCm1k8O9kTYw6Gf29M/9K1OHDft5KQuQixR
 cUIswoYI1N4gazZmbJIG5uTmaMaDRxdZvcxZ7lLPr4JZgjYGOYgYo9u5VC8anUYjQnbe7ur//
 byOvA2hdlajnq3Zj/NdGQan88qwEaEAW7iZJ5DvXZmp4B7YoOae8qmF9RUnLyUN0YGyu3MnQv
 eBJB+F0BRfhSInDiwqtqT96I1uKt2vkMJjPjkMbP2AunGsEAoVPVRjAQ7wfmwQO86BQCG5i48
 vnkTiKZoUfRZefBh5FhBTOF3qVlT0sqBX0IwSTDP/TaGauoD4z3OkDaPtstreD+NHMyv7Meaz
 KiX7ARXyqbg3VyLp/UwzcFepMidI2CRXakKdrtloJcno4mvlSQr+BGK62x5/EWnjhweS5PPbu
 bwUZ2A97vel+f1EvcFfgUs497kcPdYvA4SXsM4NVgCNfXWoMdFUUuJrZwxM+oEC+r6uGSwWmI
 aclJJA3UebC3c94FQADSLoJcxcaZ8mKCYRz3BgMvXc+VcelCZvMjN4h28Qiih8xmHiPWGqJk6
 Ap5UHWcnkBpBvUp8/zZDnnSdndOMoAD1Oqprq8eg=
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

On 11/24/26 03:49, Yu Peng wrote:
> Commit 174657478cd8 ("vgacon: inline vc_scrolldelta_helper() into
> vgacon_scrolldelta()") moved the early return for !lines into
> vgacon_scrolldelta(), skipping vga_set_mem_top(c). This leaves the VGA
> CRTC start address stuck at the old scrollback offset after
> vgacon_restore_screen().
>=20
> Call vga_set_mem_top(c) before returning when !lines.
>=20
> Fixes: 174657478cd8 ("vgacon: inline vc_scrolldelta_helper() into vgacon=
_scrolldelta()")
> Assisted-by: LLM
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>   drivers/video/console/vgacon.c | 1 +
>   1 file changed, 1 insertion(+)

applied to fbdev git tree.

Thanks!
Helge

 =20
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgac=
on.c
> index 09f7c376b4689..a6b0223ca596d 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -147,6 +147,7 @@ static void vgacon_scrolldelta(struct vc_data *c, in=
t lines)
>   	/* Turn scrollback off */
>   	if (!lines) {
>   		c->vc_visible_origin =3D c->vc_origin;
> +		vga_set_mem_top(c);
>   		return;
>   	}
>  =20


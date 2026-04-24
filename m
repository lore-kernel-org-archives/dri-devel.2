Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0BFB44D9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516F110E3C9;
	Fri, 24 Apr 2026 08:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="P4rI9KOj";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175D010F436
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777019819; x=1777624619; i=deller@gmx.de;
 bh=gIOfaC8Zw0u4GUS2tv5LaL7ITKQD3mXP0mqO4YTQl8c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=P4rI9KOjIp0y+24ataeDXgZcPp2znhOLxBUUZ/+dBDdj6poSqkW3fAb+vKR7hjR2
 A6o08k7bLXuPfDywwJLi4t9CFa88Fm2bJeLDcxHb9Y/FjErVWDwGEr1+z6QDJl/+V
 nIpWAmxiv3Zmj/g5sVGY4SWG8Ie6Wkeyj9kp+KKmHR2E8xxrBll3qLd910jdyLI0n
 qRCUAqNGu2EUAc49S1DYM5zYt2+RnQY69D5myhbWbmAQLXQWVYF7sv1JL4ADDFRuw
 DUO0IqZP98b5wztUYhYZ1ngRiYQmWFYTG2M0uay6+yJ0F1viajA08oL2eqaJVNnNF
 KHHwvS+z2u6n9uk+zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1vLSfs1vPD-00w9lb; Fri, 24
 Apr 2026 10:36:59 +0200
Message-ID: <c5e49d34-f9b7-4d9e-a8ff-c2de3a3025fb@gmx.de>
Date: Fri, 24 Apr 2026 10:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260423205531.49971-1-deller@gmx.de>
 <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
 <39ecf9f1-fd8d-4946-bb09-1041150d99eb@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <39ecf9f1-fd8d-4946-bb09-1041150d99eb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2D7zg+57g9WwGzqjgVYRVZH2+2sxZddP67p0KGHt0TK5+6EfzTe
 FO80bsNbN0NKJ7Fo4U/W7HFQNcOMLl9BHah5ixrsx6QAaTr7h1IcAmS8xg6W2fxu7XE/giL
 ryQNyEmAawKa4SsP1ITlSRM7RVxpllV2eYX//+IvKlFF90PxFVQXOwd7o6u3CUQ8LfeAC6N
 E3FUCJMEyeTEy8MLTBdZQ==
UI-OutboundReport: notjunk:1;M01:P0:XaDwgsCNPH0=;IpJS5YGfZyTzYfXiaQ+ckwuJzxi
 mot4KJ+Pt7o1ndynz7ZBQeJ4DF9/bhqmeTKDIslTjncFpATuB7s7sSituIFWCYB22CqxP7FMM
 hQEQUVoUk6wgQnukyAbI0b0Yv5OvMSCpSElN22XuXtt/19Y63ubU3te3iWcK6waOoW/am33o0
 s5fftYF+jTq1zeSwB7KsAnFAbKJnQZ8i50muFFmRVKWf58BjR8Kunzx2HfzymVFqFQTjqE5Nq
 dgA6KCsCvMZNeFldbo5+nPl/j36NhBXKAsFl0oc277PzQ06aHPa1ETCYXVhyxFUHCJHzU/eX6
 yFsc+3hwyFvDT56n7XwcObaauIbRpa54F/yuGM1xWYto1rJk/gf9mqmBLbMcLR7mfpROV0Il0
 80HXGMjIt7JTDSEQAlSOxQaegjkskP+wZNiGxiCu2SXwY65MuAkrDJjM8yVi7W0vcooTrsBTR
 3UZ0zd4Fp6WcjFzdbLeG+SC1KMc08y8fKIT3blEeeicQdnVgaW1956p2fFCfF0GrmS9X4pL35
 Oj/eWYJhTqum6r5MIQ9KwFSkLm+H866e3Aco/hg732NPorO8otUdeN5aPx1er5NINjUyjiLLP
 s1QR4XtcspEzf/UzVCec0dY5PHXiJ2yyI8lBtStOiV3OAyQDde2TO/s8qsQKGwWnVqGfgIgzT
 X2sFScHBu+EAvybMngXm/0MyUe7zj+kGr77RSw8lRw5l5tLQbNUuQUuSDiP/PHeiM/Nux0iga
 15C1ebQarnWidupdyZd4wHu/yvHB9vOclDMSNsT0HRYBBogpx7w6gISXnBXNPowjORvoaeAFu
 /MTiGCdD0bfutzYkIT9qLCygxYT3HfinhfHi4r4Ix5ZdcrOlyIFb8E2pCf6lpOxt697ks2AfT
 W2Wn/XErAYzfZbCHlLQL+yU7idW271MVuq3T8nE6NaelTYob1kGu+GvqpEYc5IGxMsZNOjkqf
 HR3DZRgmDvBQVXTGigxpVeJLY8Jq+NuUbfCvQSVWtUo9JDFRzQ7ZJuDlqBgkLO9C1TkP8c7F9
 iSGnDRUI1lK8rGQtI9uHRfZ5lsZPVHknWTsYxmfN+YMLArUXPY3UhQdlYqqVJ+JTGbzOijsHm
 waOMuLrVqyaAsLs1u44WxcD7Y8asaUGL/My4j0THm5PTH2Oae4gnKfHqMS2PxXQ/qxERbbZh/
 OtEXHTlrTVxUa9Z1onXuTPakzzh43kUT4NHaIQ0wQ54UFUMN62rM3xgmYXuHan6O8uTrR472w
 sur8h0Sz1Vx6ond5mIPOI/6iv9gN1XaU3EkRGQyW6Cijy4G+ki15OUOkTUqbsONvd5exKchkT
 1QysMM/HBffUP67nUWYXMZWkGjilWeMcAEKsTcTwzehb02NVe6v6iCzd5bm07RDpu1VaPU5hq
 TWKkxd1Rs19Xg37C112ysK8I55NQz5BkYjc4dChlOBhqzMi+MNWropq4j7Vk6z2ffuzHtkCQT
 6dMe4bDQCFKY4w1Lu/qfBv9uy0F8c58ENdQ6k8771ndw4Ok/021Kw0RPdA8h8h/uAqpmwDq8y
 FeRE6KCDczy+h75mRHFhA26ch/yE6K+HpoigsmFOHbzAIovsJVWQMSzcwvDz0Xn3NVAv4Fu3I
 1JzXIIYcBvvz4tDT0AM5bXHG0oKSU5m4R/NC1rf0LLPzp85478eJ9FM+enpkzL4WJYOBl3ro4
 TtxRsNo0hVl03HK7P2omgaqYa3Zmb9AaeHzvSjy05fa+McxMC923F8miKU10Zi1wvvmoxk/ux
 fVzB6mNKWjb4Z0Zt17anuW2n0SApE2U7XuK7BxOCI3APVl8XMwmFx0cqd1wm+/G5ca+fh67Ys
 n8HIqLwK6Yu/5A7cQO8Phgzysq4BN9tJC6nbN/nhUgr30CPYj6+NVZo724BIDT78Mi51LWgf5
 C5vnOkIvYd5E1yK6AKMt7eZGE0lUKQJ7xyUS0A1GNfS9GmMWKt3g/IEIvRPWwxzibyeTg3vx9
 7lQAgaZwl74FUXqNl3Hca+2MRJ6RdklX/RMZjajqXN9jB8cP+sQGqgCLj7BRX5lo1KRqdYGMl
 UM+zqyi1tZuMho/7U01BGdtVTXwLTzoQ1oHWrU+M+S28AGW8uIJCGnMsWqGYTpSayBrZo0quw
 Ng+4Ky+GYdeVwWsCqbdoPQ4MkQhdraXZnHOqMzaU7fyMpEvuOJRO66JDnldGDn1OXzutIivvr
 Q4PYdJ942xbmf3YVHCt+7p+6HLD3Gt0IOYxj17PfXjcrOPrLewrgA6/T0zj98jWFsuno+17UV
 uBo9ySmgGCiieyS07d3JMsgbgGi6gJ9RyB4IUfl6xUHucXzO0ja/eQ1LKZ88tLritGO3nt5so
 ewGW4JLLPh9aGTyecWKTlcq7BsLkioZJIF5H1D8w6f34lxk7B6P6Bb+VHrDP2uopdTQbwy+Hp
 4TI6xyKFc/UQBGGTdgeOhKVjgaqwLD7TytRIVHrrY3GM6NLrsCVbmrOvB92cv5iQ5yyjOgUST
 ltS4r8ze6dqWaLX0p2rfo2B6YXaMyVK3PmtQTW/icDjUCKveFm6NWxZOqvP9BKGvvVVeQt9Ir
 SArhTZ2VmT2VxCMM5/G/PqIFLIizyUrOq6O1uKVmYZNXZpK9fLM9fws2N5Qt7KzT9DiU8cR5z
 iIWiMO+ySnI6WuG3k4uVXN3b+vxPG9oMGd842w0Wetl+WXG1CCQu8O476JinZI3FfUVnYV6q9
 KDv2EKEXIKUO3nALBTkknqrR8VW+fnRMbqFCPaIQUt0UVm5P5KBa9dy3kEyWWqzclWUhDtzY0
 GlXnjgFaFZrWfbheTo5DKePwNYqQiW5pygt1IRhjbX+dlj7lh/oGUb0e2+Yxle5oRT7OC4Teo
 wiWVmpQ/+TQ2kOLQ3WosxI6rXQADiAj/izljteEBwKfBwADcu6QFwxoqMM/iNLHaf/gNvtTk5
 2C8noHKmVoQcVEN21U43hQOwWG/4y8jbkRzf20DWB7wiXb9zhiqH8kx0gNX60dQrHc2ExFjMX
 7kPSLE0FvYoOxjkKkPPqDTzk/dLsqmDuHOGHqv+3CMCdL+8U0gGOeHiYainfjKdwujeRNqcDy
 6dONu+zCut9voudzUSTlGofvjrcQTejWFvuJ3HdFZwaQ7mviQ54vNV8wMuKnIurZCcoqoGBQc
 Bk73RMRb6hRMVJB9fhflvbov/ihW+UzI7mnP8kYrVJOy9l7+YPlBU1UZhueeb38+q7h5XcI3A
 bpYq7gSzXX3Xuo2vZVwX5moc/yOhTKQ3d2t2JLMMq4VqAszvBuBlmP36Wg3uwCmUzf5V2uPv0
 2Nz2OfGtyK72cbbiNz6Fsth7CR3F1qunMMWpvN8W/OnyBCLn7lPDRYuLUriIxYsDoJkRNPy+C
 qBg0U5CAvix31R2q0n5881A9LrcistTXh7ppu/wKOW85EILKhbjQI+dCTwxGbDktZrfy4lH9u
 xnvIwpICrNGVbkYrZWSj66D28rc9CI71nTMYyFZcCFaPeQg+1nWkEbToZZh+TaaXrqhyYLJR+
 Vxy7/iNdAHnOykfcN/QoNKbkre31Ja3lYUlfu484xzRAjCfCV2P0VyZZBsBgnaf7Y5Lfb5kpL
 1UU956mhgzLkJdhVzyqWLdBdj3AwPixx0Gr/PdEH/09NrCvE8YiA3IvCD/xTYSVUhxQZfIc3K
 D4C8IjB3I/NTLYg615XiCRA3Zd85L5yXxrUuh7K112h1hjqxKMNPNkKo/6iKSK8xKjxpFJpa/
 lXb4CUCu9o1zzqMNkkd39opp9DpmqGCXJPMl08MrtEH9mpeL+itrAg2/UgxKnR2JEYDSKnyM5
 9e8BedsRtbEtZosrQ06kwaxexcbsmNrqhyR9LHkq1xxkzlzDaChkNWydU7loza2Wr6w+hEZUe
 HrueBZU2+MprDeI/Wgf2fRc5zQpUhxD8sV3tEfwyiVwCB6pfdmIDUjstTE/YSCdLU/QZM4CEH
 NSZSkoB8VAK/Uc0d/1k/plnnlw3n3fbiYQdZeEfZgOTKddQleJqB6dMT2XqIIIj01G8+lM2jb
 VyiHN16TJjjKoRyL+udUWBvlP68+LbungH97E4WiPMoHVW+tmxtCI1hQalMo60fw6LsOW/AEb
 /pB2yP51F3i7RpqcpgLrdXQOUwb9SK+J3JwuD9htXxuAiWy//2JozfvVOkUt7HbxnisgRDbdU
 XMWfuILSnXK/x79DvWer3JEsN4GF/DGakgGcKjtG28xGMsJ+aq6HGPaqYaIktGdny6Lo6IkPN
 jqd9WADy6Jkr4eEPX49E1JmERC/tUkJeCAJtMZpE5gIx4O2xWLEIx7jo4mW4lInhNQR0oS7Ph
 Pq5zvY6TSNbJnbi2eIvTz9zrp7yXCQ00RirXdmti9iibfIbDPY2UMB4wKk65u487az9l5iXcJ
 BFOZDHTXIZQZ2hEEDg5yowboq+2Fulmc43rCBpjvTXocwKSTeqJsCMWH+d6/qMX4iwRyoy3Zn
 KmPow0Fi+FIIyPpV7vvhJwnwVEL1DZa0Q9D9sGoYRUAS68qSXsTOqM9O73LpCIjcNzspEEPbv
 dmrv+Hyve/wn4mO0tck1mbFg57g1eTWTJwEgHwACi4MMBK1UT/f4D82/gIyKRNXtaPSZhW7jP
 Ij1tRUlVeSkwQoc0I+uVXYkgFbsgX2GF7+KMiCzqXP6vsPA8d3TukWR7cvtavixt0T9SUtcGo
 n85ZgGF9d57rvHZH/rqH0zMPxHkv3oT5TTmctDZ3acA63XXrb5IhnsNZ62jFftBJAaZthA03N
 l982mN6EG5TP8tV9uEjOKOVJg/TYg711SGMUgIyeEImRdyf3ifN40fxlEvpe0KAwEnejKok+u
 Yf5uSJNaNdPefIYQfyTEZRbdwYIBJvNrokf9i3dWO0B7V5d5t6tXzyXFgwdfjNw1FMqPA4iv7
 qLM5qdN16biOYNEjW6Q8eDZ8PZUO23FXp4QqrEAfsdICws8WuMQn/VuqEina1vJhvyx0O/wn0
 axP7nd9y2GRWwuy21g45TMH/7i2GRN9JUuC76HUoAEMNRNG/QFjRpedpnQciM4Lsx7DIfjdSM
 gb75CDtpArh297fp0awuFVP9HcRRtZ5jP59GNIvOwclwamr8d23z6cX+T2BpzJ+3ADSMJfNz/
 HV3sCkAyOsgXRIrGBYlnUGrk9L2YJ2XHy/o574j5PqhsAFpwe5XYfIA80i1v9R4FX9YeRRPis
 8FH4ok57jwJ0CrT4Vg3oO29e/pc0kckjyz+Gjc0jzdMHR5ty74mnY3MVf4dfDFx0Ye4D0whw5
 qWQzUnk01dGl5KevVkarGZO4ri9TdhTj3kaoh93mSVbKfjtxS4VDWVTjnD2DqolA9fkRJozKS
 5fiWLMtWc45fMxkMPn/Hhk4ICC75VLkCadKyE8N04mvki+eTthIumDqusA26a5C3czgUM0QNd
 RXjwEx6vVR/xi7qJW/xoaHKX9Yt+TzbuIVuOEMlKGtqdRtB8XDfOM9CTbjdgGAbvIaKrC6sLi
 TpZRA/XH2kZOyZa7QFgUQbJ2k/JkHpSnKV7EFvRIGkzdH4gm4b38+3kXTEibP6j4f1S3Q3mUi
 TKHhvkv3JQVsbjQ==
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

On 4/24/26 09:01, Thomas Zimmermann wrote:
> Hi
>=20
>>> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
>>> -
>>> -Level: Starter
>> I am not really against keeping this item. But as the related changes
>> are not pure refactorings, and cause a change in behavior, they _must_
>> be tested on actual hardware.=C2=A0 I guess making that explicit would =
be a
>> bit silly (heck, all changes should be tested).=C2=A0 And bumping the l=
evel
>> to intermediate might send the wrong message, too (starters don't need
>> to test? Doh...)
>>
>> Thomas: do we still any hardware for which there exist both DRM and
>> fbdev drivers, and the resource management is missing in the fbdev
>> drivers?
>=20
> See my other reply on why this item exists. It's also about hand-
> over during boot up, which could affect any/most driver.
>
> We can remove the item now, if that helps, but it might lead to other bu=
g reports later on.

Thanks, I'll remove the item now.
In case we run into reports later on, I'm happy to work with you on them t=
hen.

Can I add an Acked-by from you?

Helge

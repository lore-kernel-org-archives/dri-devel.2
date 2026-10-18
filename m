Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D58CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 20:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C52910E2A8;
	Sun, 18 Oct 2026 20:05:57 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A86610E2A8
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792353946; x=1792958746; i=deller@gmx.de;
 bh=OFK4Kvm9vLR4T9ffx8rjxTWyEwK0R1rgvH51CSv8/Ko=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VWvvsO6wh3GrAQVMmYXzQpMxWBe5eOT+RRnFafKyEczVS/TMvsLVH7NEzrly6Kt9
 BmK79794lAXWWp/suwpHhglXeDUOqijjBJtXGY/Kuc5Kg0ZaKvCzk0u2oj7reiew5
 8751JR8xNHIqW4S3UAiRyMcOZuy0jVSU+7xpOItDclUZta+EDKOkN0aJNlLBefs4W
 1KRNFY75H6eZpEtRlEMcT9heo3H0W7/0tSMVWKul9IuqNaiO7OXjsAj5qKm6zjMgk
 IZb6Rf+Pvhw+kzk5dTyGJV8Pb3QlrDr4b5qdigMGiKFO6V2IUcjvjjNBp874K+IZu
 GTcFYGcqt31PUaT/TA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1xMurK1zgO-004ZGg; Sun, 18
 Oct 2026 22:05:46 +0200
Message-ID: <d7028fb7-da1d-416f-8038-0c4cefdafb8c@gmx.de>
Date: Sun, 18 Oct 2026 22:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251003073210.48501-1-albinbabuvarghese20@gmail.com>
 <b4af6e84-6555-4629-8291-fc4c2c99390b@gmx.de>
 <b8b52ffd-ecec-4fba-b432-ba32135c2f99@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b8b52ffd-ecec-4fba-b432-ba32135c2f99@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LSz24fcMYaNVtoQYDY7jqrAwYkh3LDwaCBuGwbflfAI+y1NhOBe
 fU18wMbT2lw9MtXIzao/7oSekwQhEEdwxCpl+D21JJoeSFzpYGRCiq154TM4f8QPD++IW20
 KBdbq/yLXwh1OQFCTnE0nPo2iYncBC7XGcIITqD+wWflL4kB1pus3Rl12GJescUe4sTvDYk
 JJhkvUhdX6Y/L8oyZOnUA==
UI-OutboundReport: notjunk:1;M01:P0:k7I0GAvRbQM=;NVzyEgj5bOuKgzRm/fv7I09Yexg
 rDGan9aladxo1+xxJAY9uV64+gfotKNOlKEI+SjEq1iYKtuugJdEDOteH7HUC0MjkyCFAa6Zo
 LfDqh4LRlV1i8FxmLLSc9Phqs5oOisPwOKoQ9CScpKnKmxuuLrVTIlf5pMMdovBYJb7wBOT3e
 5ZvbglA4X9FgsgagDJ401VHMvNJc5nbAGK6cjDH/yQmJHAGhc8Ep+D2Tq93PWD5WV8w8T0LkO
 Qh2GugHzsJLvBr2Fq1xmCEe8tExCrPRgnvPuNHxuTb606vjLQ2ONvSlNMmwbwv4SKQOW4c/Bw
 B5qG6SHt6jp/P1LToIW6utpG9ZR6ih8emyAE9/EpY0Zq8A5CZsVPTQUfpG+jGnJ20HgSLAZlL
 CVHuSY4xc33Rp4hpPxAKBjGFTmWHbS788sYeYGMSI6fOzapIWFcBYMUcE1yQ2ukgYbV4qtIyP
 8Zd9vXPB8FSw34v0A5ULChvNZAdY6zyTGdf1Phu/qMc55fTEEyweOciUc/b/UI87M7acJu9E/
 Vkjj3kUSQagFZiH5gYGD97slexjrRtyz73156d36p0K63scQATC/2mOQjFo+rh16c1SDzQiH6
 ctLnTEIun8ws++aboJTNQQ/zd6ovQEH3CHRlHiUTxHVjb37hllHOq4HpX0ARshvDbi/SmunMw
 5Pi16D6So9jQ5mg/k30HcttcEAwFZOc5OJHaFRSOMXcsjpz4tCKpDhDIMxIeByzuLsHUjGmLk
 5GgjJxzD7fw7d9+53Y7xygqHMw6guAuDzCSRm2lbVd4YqfS/Dkv29IP2oVPBdxJfA0IbA77JI
 Hf4tVEUArTs0kVMRpub/xgplNhfgrtmUuIJHGWEgBmt/lRNgXudsKnxnm+zIDBdWHTj4hNR0g
 G+vczTBRq2T5nuccBWnZJwSu0lKGHiWU/4xtM04PiA9zwo9CMS9aiuub/XbtMowytTQMBvd7/
 0CtwQuGLNjAvJ3JNRVDx6XfPwfzv4Su85bZxCjReotURqd+ZEC/TaaL3Wj04FSeu31n5yIGYo
 BaLOTZmC7SMTVocABG9lJ3z79C3W7UR35vC2frSLUGE/G8cMFBb0lL6BNb5GAcbmBwpi+2rnK
 ZRW1Zvr5O55eTtQ6XJaUJ42WeExvw6/T0w8oT8JuRYJE4hB/AKZLewlmm0zrQaMB8BcFxyW08
 4+yHmEYo2MrdKB/U+mhdg7ZsM2D404e0x4JdRV+XuAHcdSc2kPhhy6dKSn1SdblE8rGuAzinr
 JrR+E9uXOuZKu5svjsa6gwXsri+p5gI2LYEhrsikCKUOlrJYxwch26dScN2SfdWMmb/9SRru+
 GVNOZ9BzRK1pSXUs+SBiE72EQRINLIgVh/LpPHn6Z4rrbTw49y7zDoxKLULZ4xZ/7y1WyR3z/
 xe8JQJFezYmMcMV+72YEAxFEY8DMwZX90HcIYY7JaWHZoRhSFcm+z47zJceYJC1bSHmrp0B/Z
 97rBSn3UbM2ezysM9S0g8Y6vS7X+X6p5b1z7OgdrApndwFItZSG/1a4SdRsVcdTCEjk20QGeN
 z2jtcqoqhW5ui6XkBLysDibxqZcQLdGN8dxUPtOZzvqQZm75rN3ROqasKb5Q6ujldzIJVUDCt
 zWONugF4IF8+SfPvSN0Hdkn9tKzoK9xST+lQmilr5UsMnl7R/HSnUtjwLtdIt7ya5/a9OgS1I
 lUWm7/yoTvBhVBwNMxcx0PNEyfArFfz6n3J1kcmCHDIm2LHIEiMb7fg5QqgNfAbq2ugI21WZQ
 qcbIk8aa6tEMstn2YRjVje90d7x2eOYSQuj09gW89XUy/z+sbvJyzY6ikGY37kySLi4Ry3qwR
 n+cm9/yva2anoYw/82ubKK4offT9bG5K3o7YeV3k9+DYgfIbCv13BJx8htn3Ad8HnhkAENkzh
 5aggmt7es9EnOorQNkX3ALaKzrl13GdVycz6FmoNSKJjh5X7i1FbcbXN6kBo+iYzWYNvHLPAY
 DphLgIsJJ5dd3KDwWHB4MMrmAeiVaRLRK0/foVG+xp1rNohm6rgN2VKmtzC4KOUHxk/Di2gxe
 AQdW8HIBbLWFKZtvgKxqjpweQ0BcjwMZjX9Bt+RFAQEAIBbuj8X5Pn1ye4NutKe1nD6cVFG1q
 rJijiQmGApaloaZzhi7Xhp29CmpvQDOj/1OtIxlyRNf4XSlAEvpsSIQEXzhKqp3wky7HxrHKi
 PFIHnFdwEzw+8FyKFCweW4CimavBBHM94tp102R36TI+XowviPif1aV4rTQwQZWelMmlIivRl
 KwYcMWVohkv/0O19FfuGsrEC721xzi65C7QPObx88iZVMpsgqTtd8vU4YAjd0M6zEbMAPmRXz
 Cnvg0FK8K3QqJ/PCHmFUOAUTU+yOClFKM4TI0/GyXHoMao458ZIBbFvwj9BRYNi7VH8TIqJ7I
 zDdzgWXve0ItnkJiYxyyzqvlj0tpLCZHOg5Ayz31kp8fgU1eygW/1IEX+kjI0K4cbtG205ZSh
 DC9a/UxbBhIBtAQiSr4XN4CLdPEelcrvMV3HNzjmvjrh7JNUjXBgfDf6sPqLFOKOKUu6tXr6N
 qK7s1F8xaSM2Jf8RzrB14v019x9RycmPGeSuUumrU0bBGKAbn/mm7mEqM/IXbqylhP9IO1TiP
 AeoifduG8u4/WhsRmMthhToq7JJK8LVb6ozalkt/dLo1DPh0yyPGDjiQfpg2nYE6YA9wK8v2l
 fYlaHZLSHNvNkUCzGoYzV2X10zYHcO1tJFD8vU+wlWTrMmXGbnPdtSEvUaDuvqZ/2O6pJNpgk
 I3rdI2R6DM7+uEvwT1uwIVNYrs7YenX41UElIf1mbNaUAt21CukDDS7NU4xZ2EJf81QpvpPR/
 Wc8uMhOrp0YkNCs+bU51yyku0KMd5k24GV9UGKNNQLmKt6Ddr19Jv3R5HLm7PgD1zmuqXUt85
 W5MFwoJCCwnVA0sIM7D6PoH+fbKAmxKksLYqM8OOW+EWf3q+0yhF6ObUR7EGtRTxW4X6wafK+
 ucfdRQrEg4bOYxYKLEJ8DamzbW9JYLvjljuLaYpauvXcBykLzKjhQchZgw8iMm4O7q1NDB6z3
 CXQsbn7U/gzyEJ8DhTfNJZ5l/EJtC5ueHDtpxI+90OVeG2yQ70O5lyoQHmNbgIoOyqNQh1sJD
 DvP9IECJcsKD5h3c/23WB4gLsUicl23uov5kniimL2xGAvw6xQLMXhj4EBuJH3sgqMqAewlmO
 RRQxYcGu+70YgNXNzVOcQDQYOINh68zDfV7uB2omge6avkCgrLD7RfeH6detLvUbLYvxoEqYP
 yLytJ+xfjtywiUzLzxNrPTLpqwVP0NZ7R0+HIGFolKJ8aDdBYZgW/v+jDc0Y3gTKSB+TNI/xu
 NbnJLa1K8Slgo5SFt3EpXXTphXass+qvVKGx40UUBK6ER5bvZrzed9bG2b0zuXB/wadHmICDz
 9wGM1Po37bR+oBRzxhRhxYlp9csHyJ2PDMG7iAizRT027WVaFvOjTBZE6aTF1dWwOueCROkIP
 v6Emj1arZH6n6/qWJguJ4BBRFsDQJQLGnyEVi4IL/b5h/J+GeNMmmd9o08RxXA6IVF9/gTzvP
 jNYLIOgBo2ptA5MhHuA6W4RbLHS8Le+31G/rH70uaRYqYjFARWCXlbGtKlEdxVc+mJEmMmvIR
 9jRR0Ab1thX5Ioh38iMnEZpq7ABM250ziv/KE9BVyRgaUEm+rDO2zW0/3d8Q3bxIenP8nQKMD
 6vrXAP+jX/5SETe+H4l3cKAF47M7LUyMcX3CeMr3ozoR7hr8kK+2npOPXpq19HeANiHBClDZY
 6v7DQ9X6QBAOMIifgiZMsHve7EIwDYkDUR9/vkyn4p/Ft83bhWwq+/0SAr3709X1jvm54aBdX
 Q9h1fuYmVAYpP61SKM/6hJqmcqsp1+Zpry6q7ssRl8xzKt7Y4R3CiOjWQlnaQ9V742H3QWMJd
 L5pIUkkyLWgBKVdqHz2X1fkuNVUwgcDip0ATca/G5o609BSzeOYcUWn6q45nCS7Z9KYlUohT2
 4V+6XPVIXrhy2NUi7xS5RGo2IBxzrW6Q3HXApO6pI20+624TBrZaXl7PeDVrL9PaIb1HazQ5x
 ZU/1LeAliFx7JjmbNsxUFRdXI6oO/ztsCSqelWXCNJKAYBsKpiP2jshvZQFc1UkG7WKSFnsgP
 SbkrdhVqQ8nZ3Q3W/0jve6C1j9ag+AChKBmAp/RNYeiVLXs4044xy1nrno+xDniJHfW12wImb
 IQYB+5qu5DAvx2AcRteglEHhzEKjgTrO6f6JgN0F6Mj3uOj2CL+N9deFXuSv2TyxReHzXH89H
 nJT2QKPWQqu+zwGMTNqOx4Oc+4tmBUmYHEPlhoEzpQq/xveSZP6ySiswNizKLp3qvdRzv/GLS
 yG4T7WdrPZy6fhuy36rXrUnMShhaVBDZxwW7ozUZap6KZsXr8kPSkxgE/gni4DHRnAi+9r6ls
 cfajSDSOFSn3ofQQS68ARW+eQxxa0m8guQdjGxPzhRFGP3UCu6vSagK63O1IenkfAJfy7jjcQ
 EKlTONoNyJBextDOp4CKOI+sWASoqk2De4X7GyGEHEr/atwNI/QMzogVzB4B0IZ5Xk9ldcaAX
 K4zmrsJ079LB4ggDydwV1w4dLx+VN02sc/H3ZIt9ATxsGwsQ2AKQzGBexpJJ0o3aRSdLD6F94
 /tZ+b+K3Sz/ryA/x3v+v3WNkn0Oa8UBMup46L36WYGuwVO5Ck7YDAzctW0Zpasyj3j/cBclzq
 5ACZCRnHgUYYoLc79B6njhgFqx2C6FVw6XGTFVbUTwnqeW8KqF5EW9sFBe5f1K96UiPJjijvz
 +4jtWh8HDofoL/CMHGhjd0A9biSucPGquWjru9vmSY14U9kxiygzhnpbXf/ZNjZEXpVqWOIV2
 mHXnVbdCiHIhhDXPIF8KFTQ6z0sXKx6CtN6XGtVVRAKDFieSnig1oMgMFXopf/QA0T3uevbaH
 YXSVSwEd7DN6CNzFroWyjPxlMGFJFTgVU279qzQaDNC2O48L2yiai6KlcCOnkUP7foKa6bT2E
 BZpenM1TccdKeq6kxA0a8SHnjMFgMtun3XQ7yhJzadSXYtkK1mkqEZXLekhozrMH8VLTQcnWZ
 ivECGr7PXHhlW8bzyfrnsyjmTpVpUgHvvsbdGwMGfPsZd3Poqm/DbIntyuYI1VLGPGz97Gk+D
 oWtwKnL/OYfBp5DHv32P0yF0ZWrMxdmcHWH4+nb+Ai0qao9wwJ/yMT1W/VT/BQBfcVCzPjEYn
 k+DVWXtdPZ7yx1VvkY7Z5pM7eELawa2H1Gr6PiT73L49iJRWCyluB/0QYsodWrEqmUYDwoJQA
 m/B/lByd1M9WqOxQh/LQAouBDizCgveDzzf+2QYB1UeOmKkySMUDeCjesUFpJPFYELudIPvKI
 KtShV7VymatMzjYi20Tj83PhFseFj46ksLUDMb0/bLzSZcBXX3AdukOL7DRJUHjXrjATNbgCK
 eEl1rhwCPtWdSi0vMzpgY75Y76U4gw5UfQNt3gHn+F6H5X8hL2sMpYl6h6RLaGQcWvz6Di9/+
 c9UbdPHm4Hz3ew7vNQUZt022q4ZIOB6NdH6hgmKdjHyuZuQK/3FsXdI5XVRFc4UYs/NcOxajq
 PKxznfs+fdubiUuxnrZG2NT6j6Dw+NKe97RC2pR8thbVNmUOx9PS7FyZajCxPTX7OLOAKqbRm
 pwQ18a/qipnSAh/GEgY4gMaGgaMgEhw1297e5gPdgYSGVr3xdaJ3kNk+LIxQVg14N2IibB43f
 TCtSmDaNtNjwr9V7KxPLgR8LZi3y0fjkwqd7BrAhWfuxprHiXEZwOf3uqpT0m6GnByX0Ys3y0
 iurUt3ekRbF4LBY0Ie3Qe56jf5FbD1To2+8MGWfJ1mDSYg6uK5MFvx+FKa9f0PAYicJoHhmRF
 sQnFFGBPCSkUkPjhmSCz1awXkRI3Yn/fW+MvcEubvRdgDslCg4YLcZLE2QyJ6ovKfs2PEvJno
 MfLoRc+lvdSdob3icopIxY1rmpFE08jqxwBbQ6zj0kfcj7OmUrK/AKMttY8tQ07TAa3PYjgYO
 Xo4IzqJ2ddgIebGTw8f68e3gRyqZ9SFT16/chk5HTkx6XqWqwqES0WBAFFVxsQMO9RJRscFH9
 qBYZ+80CUQcLT8FHbbwzfDhnFzsVdfZzWjrvCiyViNMZjXj8aZ9Pcyn94t8QN24Yv+n+jX6Rb
 W0Rmi4aMxc0kQSUcCc9sXLGpe1Nof7PBHX+Bjh+pw8jiskzalyqGbcNymxicds9cswxik/iE6
 fsLrZLJDHC3RNxU+4aIwuApz6tS+ui1jMo03uihcO5MArPd/HbMrSHAa6cdT6hojXQN5z5/Qh
 glSoWzjmGCiesNY0FoHiI48LRC17wkdWZN0d/TE0bkvwO+Ag9m9I/v8RAXzPctRAZ6RpCix/p
 73cCW6u+X64wncRQy9e2IXYHwyrqpOeh+xqvTtw7wmi3vpIdidadOJITivd53RBruH3yu+Uyh
 JRMek5laq4cJWVzq/T/vgoom24AYhwH2lNmH+FvjIhVvsewnHAQCmHzh7Bs90CgU7H/6pBfR9
 9Y0W/QR6bql6y3DvffI9yySiGrSE1QsNkS2FXVg0RC113LuJ6cHEHxnCosHRwQEuUBiaDNAQl
 Qja7NbOKG48gQgG+TckQeAY/C0Wq7zVZfhsiagsdlweomsobRWOlHOZggyyQLoZzJrCUB4oZW
 70DO1f4n8bqejFSQ8oxd8oTGoVFSdLR9Hj5Bo6kJbUam0AtyCdUmo2SrbxrpzNQ==
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

On 10/15/26 11:07, Thomas Zimmermann wrote:
> Hi
>=20
> Am 04.10.25 um 02:43 schrieb Helge Deller:
>> On 10/3/25 09:32, Albin Babu Varghese wrote:
>>> Add bounds checking to prevent writes past framebuffer boundaries when
>>> rendering text near screen edges. Return early if the Y position is of=
f-screen
>>> and clip image height to screen boundary. Break from the rendering loo=
p if the
>>> X position is off-screen. When clipping image width to fit the screen,=
 update
>>> the character count to match the clipped width to prevent buffer size
>>> mismatches.
>>>
>>> Without the character count update, bit_putcs_aligned and bit_putcs_un=
aligned
>>> receive mismatched parameters where the buffer is allocated for the cl=
ipped
>>> width but cnt reflects the original larger count, causing out-of-bound=
s writes.
>>>
>>> Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=3D48b0652a95834717f190
>>> Suggested-by: Helge Deller <deller@gmx.de>
>>> Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
>>> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Partially render when height exceeding screen boundaries instead of =
skipping
>>> - Update character count when width is clipped to prevent buffer misma=
tch
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20250927075010.119671-1-albinbabuvarghese2=
0@gmail.com/
>>> ---
>>> =C2=A0 drivers/video/fbdev/core/bitblit.c | 20 ++++++++++++++++++++
>>> =C2=A0 1 file changed, 20 insertions(+)
>>
>> applied.
>=20
> This patch mangles fbcon output on fbdev HW drivers. It's
> reproducible on matroxfb and sisfb. Reverting the change restores
> these driver's functionality.

Huh?
Are you sure?
This patch was upstreamed one year ago:

commit 3637d34b35b287ab830e66048841ace404382b67
Author: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Date:   Fri Oct 3 03:32:09 2025 -0400
     fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

I don't see any specific issues with stifb.

Helge

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C5606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=LjOhADgw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E3B10E553;
	Sat, 21 Nov 2026 16:09:27 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB5510E553
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:09:20 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277359; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:qeAtgKr4R2ajPe1JAb1jQw2g4ukT
 xtA1htnSmO6xDP89y8v3eLcoNzfVz3GvX2YYdEMWP3N7Tj4taGVDj0dEXRL2o50FMlKre2tzkMQ
 Uqtb+badj0FtUdtdBgc/jfuMUM5Sp2i9LlFJf8klRk/NHGuro7qphOjDUEBrLLvDCpmk1QqiO/u
 3v8rnjglp+YtQBnC+EqnM2DWaI7i0NEpX704UND+8e/M3NTFvzQ28AyL/frhqln725r4UduZ10Q
 E9MZXV/IWQfCdGjAPMDB6oDWJ3ZXW70xQmRhfprAtZ6soztaqH8S19yQj7Wq9hQpM20f7Pzsz46
 YyeH3ZNvMgsW6A==;
Message-Instance: m=1; h=sha256: aU/RdSLm0f/zdS8hF4j61aKTuInKaVe4UgWlH0IZrxw=:
 XoavLg46jNkYPucFYNCW5ACV6w7PtI1YzZ/JZUqAXrQ=, sha512:
 9AAE5ngVMsi1M2eVY3K4eZjOE2XqhUCRbSkEaGn4JzLJ7GbXXiAX6qxMluJnXv0t74Qc9OD0ZekmwJAH9dgF5g==:
 BLlbWhYHFX0g2P+ATQR7LZ8eI023cxpmoI+lCxo8SdbqFj7mqlbhECRDx53HxtBEtICFTVoAHwLlieRjTSat5A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277333; x=1795882133; i=jan.claussen10@web.de;
 bh=mgAJBK1ZuR8vOHJXCA8obDRVKDSfVhdhk1mCKd2tRis=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LjOhADgw0t+gJ9vJYx5jWssnKA2KzyTy75DADA8au+uwjheZPO20XqjTSBIDB5sT
 2odT7UzNWrEBw2raZ1Oo12/h6K7+4LUnyH1jh2WJPa2MQv1izjhHF3lIXFeXGdTZq
 YVPClenYK6R9SlN7I8gQfxUHJYB0eNE7gi1ZcjOS0V/S2kMQ5ZiVcnDcqE8nbNc9n
 xBmZiTq7Yl1ue053Go1CBCRvw0EIjyEDlUyPg55EQTYS/clx4pi74Mu+sLeAj8l0r
 NIH223H5iLMOPOYsPi5pycgafIwpV4Vu4OGVm2Yy8MPjCMUD0sjSDtZ0Y+6QARyte
 fgp/ibwjDdU8QOT/Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1xwGh63B5Q-00OepU; Sat, 21
 Nov 2026 17:08:52 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] drm/rockchip: vop2: Select the CSC matrix from the DRM
 colorimetry
Date: Sat, 21 Nov 2026 17:06:58 +0100
Message-ID: <20261121160725.6344-7-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YNbY5K7elgKzxnH+ZYH/YcrBmOjA8mMhiY1HwIM6y4n4+xbw3Gh
 orZrfBSoFssKPWWWwdWd1U2b6VzG0R0F5wWG26XxUe3RQP3vl1k1z67M739J+drD0kl4Dzk
 r7PTOAUqpK5P7q/DSjDj/7C6I5npSWyDgQLyvedOK7RUJZehNwFGnvEnDNuonAqSm1e5vVS
 sTMuKKc37ZVoK5cyQn93w==
UI-OutboundReport: notjunk:1;M01:P0:AKhoKPTrluE=;EJZNX1ecVe49NwHkOFJEBbW4kT3
 u+jE+dQLsxoSefaP9VlGB1Rpc289rzs+khdkgz0ZNi1pzqZSXndpiUok08c/2QKS8Me14J3L/
 zzplk/LT0it9J/B4KJ/aEDsJVOVwqq85d5vKO7Xg+s5v3v3Arz6Tb60a2UPv3vDnwoSkM7KOL
 dZVfaWEi4RSqUqgBuNCfK31J6CVdaimZn20Ga1YyPG7oVhTrlw4WJBsuQ8K/e8+knT/pW37UI
 JAF0cqaa6Vp+/TBWVoJ5LjGZF5NbjiAPBjCw9mYtgxjv0X7y+LSI1eweIfnJd3frnig/0QCCQ
 hi0ydWbUd1hSx+sMVhq9tMNKmQsWy2t6crQOaXuEbdJl/q234ijYbx3nKjGFEnZRq+P/bxgp+
 qRU5y0E97hX/XzHeah4Nw+cdfDVQv0uIvmPDObS8iDS8Ebmic7Y3AwMPK2PZjJkn9qlXw0HeO
 9WLyYwwO3/gLdyJy6mOR2egW0e+3mKmliNZ8wrmAGAHSzqs46nwU/W591BMq/zFbZ5KZlSFnZ
 fsehvFHEj9zktkK4/Lzj7ODKfzthBg3Z6bkAPt3Z+9hwqsrf34nEXaO4YJYoImcDquJcDrPJJ
 8E0aiMcpaVdR6HZ0HnVS38jkfE1wMno9ZhfmSQGDEOfGqQndR7G91uiwmHeWAbQNPDSiujQed
 81qfirEOAgQiwtCs3pH/AiXyqNOHaGoZnLmiJ2OSkfwi5RK9M2sU9tefZI7n44SIcPhiTn+t+
 2B5Wfi1EfiwcrL8beQZT3GN/NryjrtEOS2x0FtMwJ7m2aT1t7SwfymjUtyn5gSIAs46iIfsFx
 TXMS9L0aMNjnbcIKNiVqZYXfEtAsBY+AFPton0yGAUrP45qRQ9KfV4aTVKjnRsfjSjkabSc41
 cgzLR/aRRmPn9pUv4kA9qVG492ocXgJgYtHgFDksS1vhrpZiRkujL6az53SDrIjFPnFleQNUW
 AuvMgu8NVbFpgrfbngaQ9HkZdBb6s6+SnF+sX0KojygjHi0SwZhenMjSIpc1LPzqV3psOS8vv
 KveSskIHPWpq4A8gjiT6F1FyrfWJGK0r4JAttj8t4ijwxxbeP9Mix9hHSWXsYL6ywt5HUEGQM
 6n+rWEtxYiXJ2xSxZ5OQppll/PNzG/ODysRXsWi1EiS+0thjjbgbJ6v9GIcigmTKfuRXsgocQ
 os7N9lNZ/BS+p9GQpPf5BZ1ZAeT8ijcxzsk1Q23+nM0CyegVSUk7o4aUbocItF7ok+3SMBDAK
 9xeoM2q53hG48fNGV1sZlZ0BSBnkOWpGAzJzbNZkhKBaD7a+FnqxMIAr1V+Rlmtf4aUAvoQ1l
 Hs8tRuqY4/ONaeARfowFYohXpfQY//HrJ3h4DXosfbqzE/31Bt6KWYXN/CftO8UGE+D+CC5d4
 0T8sGk9uJru1aZdlS1Owzx0HBsHJIsPRObzLYv555ZGy3t6pnyjFPSSRcN4oHZp5BcmS56Lcj
 S6VzK5gSj/goOutAZYjuqZKhtPGwuu9b4pRSLv5GJJrrJ5aUFhRSvAqa2zBJLUjyKf1z9k8vA
 x25ZLpgJHB6clgcCvoWCNcCUwzFn0kgOGYZBHmp2DDHiSQloPC/hFDhAhfQMNeKCP0tNB2sj/
 nm/kG3ukFNk64vITbG353XhlcY0ow3+3TY1XBs1KquY0HvaidzFn0l0i7xuyX5t8mMo63lU6Y
 R8FmLhTWr4AwRA0VBRAGO+83NAJ2uGd7vsvNVnbsws6Lb/42bzwWJ2u04q58Px+7H/3RJtLHX
 5gWUioY+HpzfbZb0M48jGWp9XtDs+Aid6niQm/n79fDb7e8wGGjbVEuzL+Zm5wwsflgpjtIGW
 awiuaW+oj8OaefQfX64js2vGj6jw1UwC1GR9ZEifDnZOp+t3ZnsJizq5HtlGFDRKgDWNlnFzD
 cbHlgsGacQmoeGLrHKqOF7U0ge8lxm9/VRloeExwUbNB6mTM/BarWhkdgT4Z2zel/1DvRYqig
 szXsUcdnvcJewlOJD9QQUhgslUvLDLyQyW7ddXDY++nYLIgtSa6z0z5hSuAbv2J9Mr/FTE+z8
 nyApRxwfZfa5OLCUokFnUtU71Q/kQjUoRC9722Yp5sNoPGHDESYZTvfY7LBT66vRHVDELaFX2
 mNdvQqGSFXVX89ZQdtCOYn6mk8ouGJS/ljHNL9lyiX3+YT7b7sHXIbIw3OClCxbs+NU+/UPyF
 XVQyX6zmSLrxta7grAk4ziOsHgRm6PeVmGA4nffId81u5gI7FCgOaYciTmA4+ybs479BxjHzP
 HzhMjC9w9Rn6ZzyMtnuAHVjeszjRxN8UUJXXIBWCCEIjnfYWksEESvZAK3AnA0sZbg/+D1srh
 RCDXMvCtIvPnap53Y6B5Q4hT3wHlklTHKV7fqrP5Zym4UzMcDLTGEBqO+uX29DN3nF0YsP/c+
 cSX1Eyak0AyQtlezhlF9rom32v2w+eaYo8BwMPXAf118sXBoBFly/iXRj1gtx+Q2SZgpB2vvz
 9cFC7fyHp4ZNcVThVKxwh6DgJjhkmNKvcKsFBUWoSmz62vqqERrsPz25SP60gi0ilakD8F+MZ
 9zclaPw5wEKqqmTUFdoEw9hvO4KwiiwTxOv8/4T7J7BIApVW9OGhoSQXQwFRFtaWO/1mQvIRD
 6DSD9EXcW8RK8piKPScsrjVXFwpL8TXJaR5aKzKOvgpHMm4CXFwRPy2L/A63YFZ1FYdbmn8iK
 dhrv8MTh9t3/M/2XuBbynodmZYbmTr11ph79SfMBvjOejLpCsvLZWf2H1Rr5qZmg1bn2VpprQ
 FQS8/kN7JAzVyxmw+nRALAtACU7e0PWe3udQj7HZagAAxy2GRXbbxYB65UeDXx5++O6OokuWX
 JAZheipC4dBwNcccO8Btq2uDF8ovvFtYwFPmohxSX5c3JGwKvFkoARJ9eRvpPIrfIjVzug3Xk
 T7T6ZBWcjk8VCZ3ZCDO5bXTZUD+0L5BZcGbHryNTLsnVm1rYlsimoCgQdSPJon+WKy1IePs/x
 fjuEZy3f7kFH8DiM1Rz5MTJSiGH9Ac1Ns3ndhIC3F5TfLxSs3PrQO2hid2YU7fp3gd+CapMIs
 TD8MuCqCDol4fmnyTxYzRKgPQFHRY/pyov3g1yZCb96k4Cjqd4Ptblblym1cVwjXP3/XSwjkR
 Rv5Zz0HQOCln3q0Y+7EnHNX1qQ2iZ7V5MejMnqHtJIUrSGeDKOzol24zgM9oiUn2ZPScY8cMj
 Bs9L7urpIYgMv2N6cd3buetTUlvuX52TEKrKnBVsWEkP5/F6Nkwutc7iKVK5hHDuKxfPIJm8q
 6E9gQw6YCr/Xrcg2PGF231SBOxK3bFbci4Nm6JJaxw2m1sjuEnkR5/Lkz1nsLX6bw8l12D+RO
 RoVgwFTJAajHRf4/zwkjken8SBvHPyKBuSwEegtUF68u1agF/WFrps7sjS9QFhZ1o0pMSzAMu
 7NKq9cOdjiVySaRqgG3wDgy/IKbHChocqnHBkerWxHxFgrdsBRDHCxLRatz0Q55PaWL/WaYGW
 kLQldg+Cw3y/9X2j4qr/P/3dGtAFnmEjj/whlKmcX2CNO0xG5axPignzAggl7tIx+GmTT9cmt
 ykmaRerGFuhOKlVRIUzDjmPiZwAMh6BxlcNjIv57+y+LguswqoudcBHGggS46gxK3AIiOLBhU
 tQgSpYtSVT8dLSTFopHzGNOR7ev/eq6yLCIPD5LJRijVU11UUd8TMWRMB1zjGG35TKIctYd0h
 Vf6SGk+CjeFR8IBVV9sIdpmBxlmmZrZBFnEBo5do5g/ZAxi7ELrHwKGWs/J+LHAlThOY1+0NK
 06HcRydJTVubzeQxPTzhoc3HE15OIwJyjtYarVMPvTzakslYvzvxwC/euSesd/LCrO3J4ghRl
 dTQaJ7YPpFs0EB3rPvLyPFMkWGCturFSTLJFkbYPwZGqiwSIojuHRsI//0rNh0hJjFzWEcm8+
 ETBJGZtixlU8kgjHo/hqW76Xo3w72MSPntH555Vk3DVxtBpiE30K2Lyb36jopLtqM/aBxvnNI
 LD7WqSVwCK1Wkb8vAgydoQncs13KCWaniADPLSfbZzwkhN/ucegw4EB5Aycx1pAl4U+YC66Fj
 v0do/g19anVKy/3QYta4kieMczbIBtwYkMjOaTqB1JR0i/u7+4kJ6i7Lx19k86NMCaGvmveeD
 spD2Alrs6SNQolWODuKZyuilkf+EQsw1e38CPkY3wYc/TM/ffKb/zw2AsPWcDM5VzL1ShIN2X
 ci1M/gCHo22h1eh/Q+ODIolG+S06MA0mJxsSTrVaapNirvGSATKGuhp737djNnldGtSBIqn0C
 atyRR7BZSDkPL5IH3TOoqDgrz8j846S+PWmDT95qQq4K9iRDr59vnNIOPOzBn5nXnbZfPMEbd
 GlOeKuUgDW6sKkU21qq5MaCxGt9f1bzPRxY1xGLUs1saEi1xTGb2euN18Ud9vkWy1CxkL/KJ9
 4djacvnSfsWKphfBfsdGHhFmlwIgY2gg6SeLx6/Dbmj2AgStUy1GkWqSy7xv5+l/CnVTiglKn
 z7FUYZhgft1LgdJTLFCMQp9b8Wxb37ptat1DtZ2Ozh5WFKHRl8mBtB4PmPXUBHKm50EvhtjZI
 7nSiUbMlUWZSby7mQWXurjArf/+l3YL/WxOoFqFNxumiMpawIBehmUfZFwasqK+T4ygN8nHzm
 IIFdQONd0qRMb/7xiI0EGiZqASLUGMEyPf4LlolgrVjUjUUDlRvhyYefkjNENwh3GIYquvjRA
 QR9ZXiLfV1FQYoJFQ8GTFcvAfu5xtOWhwcKChOI59qve5n59nbJdoWT1Zw7wr3r2w8ogt9Ycu
 0BFypPbQs2PautulKKvgKFUwH5edGHry4Uuai7uoMQt2MZnWHstbh7391ED65EykbfFtQ6eFB
 TCKizyi32FETFoSmBuauTaRTws7VmFX0HcU6vSrKesEtRgCE6ONMk+elMlwD/tp7anKm4aDAR
 YBg5rcsj3+oAjty3+iU8Lk/nvFX/g9stMqFXJPU3l5lwhUGsWX9gQrBD92/Riz+FNS3A2UQD9
 nvN/HSUo5lqZhsih/D7eK1MgDM8h9NdpYEN317WJacKb4RGbjeqiCchMTEWcyxwm/EgxzfpKc
 eEmcJ89GZYCkQRZcmUHtJatpnPjJDLondk5Evw0X8NQolEueCKOlkVxUEhbZPflHOQa5PxhB/
 Cq4tFd3CjQL+QFtRcr4GsqjLABV+EF1dWz50gKaIQTxq+13CAP8DpiZXX2EM+jalaVkyymtk3
 fR6JrfItM6XKYsTJcrhk0ibFmQlC/Tnz7FX9rpgftwlWDhfElB3oa5rn84elneWUaAMEn9Rat
 A5uH9Fju4NrfxTgjZfycio/pnX5yVmEVMdFvYesrDYkQGLvDuXjx3r4TKUAs9aDCftw75TQZo
 AxFKjcNWWpAAWjQ6sZaoX8+G0eZprv5CXCAVL/NmJUjs4MfR52F5nn2YYEJM30nCvCv1FM07c
 +qJ/uax/R6thNFBySTHjUXlzFIbjTW+QVYtoJNE2Paxw08h2vUpT9413WaamNF8/nIRyMDrDA
 kqfRd11ZyF2Ag1Qv6ofHhUAO+/syNjl2x5nRTxKyhPmRyIFi3ArnExqlmCs7qcgC2+Ql7I7BQ
 k+A4kaSTHC8PYiPYEya8gSrgmIuiNtWERUc6X4k283G9kUYxg8/F9MNHgPHSJyPDODiJpmrRf
 AeDV9Y4Whah018Et7OR56jnxJ/2lc2LdtAs0ZMiizGSBbWtOHC5AtlAjpfgtj9xuZ8sVM8hnI
 cDOsjJK5tIEGU701MYMXkNTVN4FKpCj2fE7KYquAVgnaFBdYpXu7z9xr0y6XjAV2Vvtwx4Z6O
 +eVXvF5YAFeXkOMbOgU30tdBZBCBSpumcNzQKi/Y7zjZvNYHCFnn5HBAF3J9An+f+yZ0BoXCf
 ExyCx3NoPY921cC9APY49uVLmGfh6NX18S7SGuZ7B5U2qnEKaPpGlD1H5KHJtVJvchdXIse3J
 L3vFtvjyTdqli7LsO2LFLZkv0mebECr6igyDLvPpf9FbE2x+wDvzga2s+imn3lDgvWGUqINa7
 IsrCiLV+LkFMXEIVgvAULAapbOUd82vx6UaUMzh+tiHDE20MkrjYewaKdpFAh9I4nrOUY/jcy
 pHK0jBqI3/gAsddWsdPcpqqbd5cUCowFYweZ+ZBFhSE7vhweB7oIA4mceHSwKFGki04XhL4Us
 bie/DtHagQfi/HDIaWLpZS7UAwf64yY3obFAfDcKS+fycjDxkXUMOsaM6TKKwuCJ16XKE/26z
 Ri6L4itn3yad/uAK4x4I4sXvp4zOTmWAguRJSIE9DckKO9h4ZN0OlfJEQDdQkw80GDNUD2uOX
 FtiHVOBYMekSwpu47PnRHSORSOAAzVCMn3/zqKMQoUqyZTJH3vpBSeyWy2e7d1kkcIKUZA1Vi
 OZSvObLgDo+QMO+6rFY1AAykuwfNlbNO2+5zJB5Ay6LZuFvUCmU2VjGojep/AAuzTEV3CtYq0
 j8SFSnUYKy4n4j25uBEXg75QSK3Lze9GLDKo6dsmZ5FmpehoHKrS1W31w+ELTb42Az2JGk5jO
 hhAKPbzmyJqw2AL1zqbAnGNVasAM+AllH2ldNtgWe1SemukpvxhPWTzbNrhwKbbE1G7xdNbZV
 evRJl2NXgO/l89VpBka0VNdZeXzFA+P9jb5yehz5pKukPWDj7RdDUD+kg24j6tcRB99tz6NAs
 uclT4TuFCdJraxhY6H2HmwC9+Z51fwt+b2ZA2mtF2dOZfWkOoEYrZU35TOQ2/UQwkcz//g5f6
 SW3fVN5d3NbzWpMWa2OVUFtfSf8fLrk7pOo+ByY3O1CpYqmSfe+6xlLpTntYBCaqsOGSWDrIa
 C6azDEWKUoQHFI6y6CgSnLt457beNFNn9lIqvoG49uzl+BsOZX/8wG5kTh+YKRfoQUfUeuzv0
 G6eDcoU7WfXA8eOOYr7y29bUfQLXNz4uv4JV+0gxpaICgIcb4V8AcQrThBYsg6mFSKG2XJw/j
 FpuY8gPZGlpLf5FU/1AOWSD2P4IK1kLvIOfW6Eu97MSMHw/yT8Frl/WCz8QcERZgUaOXuNq/Y
 wvXkAWwByFhg+bCYBZ2+W8fTOH9fzyoVfQcBkqAlgzEJajPcsbbhSY5b0Em30t9mDkiyoTTlm
 /K4VNUqteoABvN9bb8HzFyYQWyUrBU9xxyBAv1f9ZW0GK3NuhkRbN6zd0NFf4aFkR5zfIWyoX
 ogUSTxlEEgvJgMIFaWgGWLYKqIQWj9TTzDMucJfdcRGIBevzWAvgRkqSf3PnlxSGV5MlhHZU+
 ckEuBedlSqgsV6jGdILpJR0Su4jIe3w9Z/v7i7RQGjCQzWkJ9NjGdLDQ2HMASc1ckJq6DX1HL
 CRCSq2zfnEcdHCou5RKVr+M6EaqpvXO2oSyWtyC2ulNeyRjs+iC5e/eIxngR5tpwB+/X/szS7
 IQ3e82ozYVxzH5DKaRQhD8WE4HBA4KSvARM1/DbZrS/CU5AikL3ZSOuGhqubp+yNzuzRnRNWE
 MdgipDoolg+1RoIAZbwH/z1XVBggxqB0TDwTGLjqieanm0QyFxYLDsP9KP07cz425/S8eu2s/
 6HCaMbgZaCfbUCgqIO8/10nVBhvFl2j7VYHWC5nSJZOoSd1fQm45KsRd7Z5JSgtaMy951wypi
 8WtuZqa4IjFi75oZrrohHk3VIgscSRWnx8ACsE/+9wcMawMnKwcGtlyIqBRf5EagI8W/TmsTR
 1zcG5j/fYOvsoVEPo8EgKYP/CuYi+tm2ub0PXTgp5itrV6ZK2OHlI1K5xHazL5e8P9v7xSBzl
 8JTxECdR+8Ee8oSjbVUexfIwk8XGxiInijSEjlJoSsrrOTdLYwAMfrOxgV9oHBJAGpU3+j0ng
 bysXZmK52jL/sfWsJeTk+yHwkQofC0MPELi/Tvwah/WuT86+ZXXzxImkI5TKorUVUbLyhbcwS
 yzJf4WCS2JJRqT60YGBa3e1iVsHVT1Q9zjE+4XDktAzjyLD/EdAuSY9wMiMOlFQg5XCeKsw7B
 XOufoDtsjHkRVK6YDv06wJryrSykECrfhqqBUGZx36vx4xUE6ne1NNN+ewgZXeyvvTH9SthwQ
 otok3w8yQ8Rx8JOAk/SkbTs4SBKejPWldoSenojgslL4M9YHrmYLgM8iJdKqkIyPI+znDwIre
 hpuWm24IOUY+YoX1Az0tFAvF6DqhEJHvhh2U/CRzAogeEbUoy2yegTts8SvU1PXCgvK5CoRbY
 ug==
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The color_space field in struct rockchip_crtc_state holds V4L2 colorspace
values, a leftover from the vendor kernel. The DP and DSI2 encoders only
ever set V4L2_COLORSPACE_DEFAULT, so VOP2 always ends up with BT.709.
An HDMI encoder that wants to honour the connector colorspace property
would have to translate DRM colorimetry into V4L2 values, only for VOP2
to map them back to a CSC matrix.

Store the connector's enum drm_colorspace in the CRTC state instead and
pick the CSC matrix from DRM_MODE_COLORIMETRY_* directly. Since
DRM_MODE_COLORIMETRY_DEFAULT is 0, the zero-initialised state keeps the
current BT.709 behaviour and the encoder assignments can go.

No functional change.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  3 --
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  2 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 41 +++++++++----------
 4 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi2-rockchip.c
index 6db88665060d..87bab11d6f8a 100644
=2D-- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -23,8 +23,6 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
=20
-#include <uapi/linux/videodev2.h>
-
 #include "rockchip_drm_drv.h"
=20
 #define PSEC_PER_SEC			1000000000000LL
@@ -268,7 +266,6 @@ dw_mipi_dsi2_encoder_atomic_check(struct drm_encoder *=
encoder,
=20
 	s->output_type =3D DRM_MODE_CONNECTOR_DSI;
 	s->bus_flags =3D info->bus_flags;
-	s->color_space =3D V4L2_COLORSPACE_DEFAULT;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/r=
ockchip/dw_dp-rockchip.c
index b23efb153c9e..412796435af6 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -10,7 +10,6 @@
 #include <linux/media-bus-format.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/videodev2.h>
=20
 #include <drm/bridge/dw_dp.h>
 #include <drm/drm_atomic_helper.h>
@@ -62,7 +61,6 @@ static int dw_dp_encoder_atomic_check(struct drm_encoder=
 *encoder,
 	s->output_type =3D DRM_MODE_CONNECTOR_DisplayPort;
 	s->bus_format =3D bus_format;
 	s->bus_flags =3D di->bus_flags;
-	s->color_space =3D V4L2_COLORSPACE_DEFAULT;
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm=
/rockchip/rockchip_drm_drv.h
index 4705dc6b8bd7..9c0d744ed95b 100644
=2D-- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -56,7 +56,7 @@ struct rockchip_crtc_state {
 	bool yuv_overlay;
 	u32 bus_format;
 	u32 bus_flags;
-	int color_space;
+	enum drm_colorspace colorspace;
 };
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_vop2.c
index bfb384142568..91453621546a 100644
=2D-- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -33,8 +33,6 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
=20
-#include <uapi/linux/videodev2.h>
-
 #include "rockchip_drm_gem.h"
 #include "rockchip_drm_vop2.h"
 #include "rockchip_rgb.h"
@@ -647,20 +645,19 @@ static void vop2_setup_scale(struct vop2 *vop2, cons=
t struct vop2_win *win,
 	}
 }
=20
-static int vop2_convert_csc_mode(int csc_mode)
+static enum vop_csc_format
+vop2_convert_csc_mode(enum drm_colorspace colorspace)
 {
-	switch (csc_mode) {
-	case V4L2_COLORSPACE_SMPTE170M:
-	case V4L2_COLORSPACE_470_SYSTEM_M:
-	case V4L2_COLORSPACE_470_SYSTEM_BG:
+	switch (colorspace) {
+	case DRM_MODE_COLORIMETRY_SMPTE_170M_YCC:
+	case DRM_MODE_COLORIMETRY_XVYCC_601:
+	case DRM_MODE_COLORIMETRY_SYCC_601:
+	case DRM_MODE_COLORIMETRY_OPYCC_601:
+	case DRM_MODE_COLORIMETRY_BT601_YCC:
 		return CSC_BT601L;
-	case V4L2_COLORSPACE_REC709:
-	case V4L2_COLORSPACE_SMPTE240M:
-	case V4L2_COLORSPACE_DEFAULT:
-		return CSC_BT709L;
-	case V4L2_COLORSPACE_JPEG:
-		return CSC_BT601F;
-	case V4L2_COLORSPACE_BT2020:
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+	case DRM_MODE_COLORIMETRY_BT2020_YCC:
+	case DRM_MODE_COLORIMETRY_BT2020_CYCC:
 		return CSC_BT2020L;
 	default:
 		return CSC_BT709L;
@@ -707,8 +704,8 @@ static void vop2_setup_csc_mode(struct vop2_video_port=
 *vp,
 	struct rockchip_crtc_state *vcstate =3D to_rockchip_crtc_state(vp->crtc.=
state);
 	int is_input_yuv =3D pstate->fb->format->is_yuv;
 	int is_output_yuv =3D is_yuv_output(vcstate->bus_format);
-	int input_csc =3D V4L2_COLORSPACE_DEFAULT;
-	int output_csc =3D vcstate->color_space;
+	enum drm_colorspace input_csc =3D DRM_MODE_COLORIMETRY_DEFAULT;
+	enum drm_colorspace output_csc =3D vcstate->colorspace;
 	bool r2y_en, y2r_en;
 	int csc_mode;
=20
@@ -797,10 +794,10 @@ vop2_rgb2yuv_get_matrix(enum vop_csc_format csc)
 }
=20
 /* Convert an RGB (16bpc) to YUV444 (16bpc). */
-static void vop2_rgb16_to_yuv16(int v4l2_cs, u16 r, u16 g, u16 b,
-				u16 *y, u16 *cb, u16 *cr)
+static void vop2_rgb16_to_yuv16(enum drm_colorspace colorspace,
+				u16 r, u16 g, u16 b, u16 *y, u16 *cb, u16 *cr)
 {
-	enum vop_csc_format csc =3D vop2_convert_csc_mode(v4l2_cs);
+	enum vop_csc_format csc =3D vop2_convert_csc_mode(colorspace);
 	const struct rgb2yuv_matrix *m =3D vop2_rgb2yuv_get_matrix(csc);
 	s64 rs =3D r, gs =3D g, bs =3D b;
 	s64 ys, cbs, crs;
@@ -1652,7 +1649,7 @@ static void vop2_bgcolor_setup(struct drm_crtc *crtc=
, bool force,
 	u32 val;
=20
 	if (!force && old_crtc_state->background_color =3D=3D bgcolor &&
-	    old_vcstate->color_space =3D=3D new_vcstate->color_space)
+	    old_vcstate->colorspace =3D=3D new_vcstate->colorspace)
 		return;
=20
 	/*
@@ -1660,7 +1657,7 @@ static void vop2_bgcolor_setup(struct drm_crtc *crtc=
, bool force,
 	 * format when operating in YUV overlay mode, and RGB otherwise.
 	 */
 	if (new_vcstate->yuv_overlay) {
-		vop2_rgb16_to_yuv16(new_vcstate->color_space,
+		vop2_rgb16_to_yuv16(new_vcstate->colorspace,
 				    DRM_ARGB64_GETR(bgcolor),
 				    DRM_ARGB64_GETG(bgcolor),
 				    DRM_ARGB64_GETB(bgcolor),
@@ -2140,7 +2137,7 @@ static int vop2_crtc_state_dump(struct drm_crtc *crt=
c, struct seq_file *s)
 	seq_printf(s, "\tbus_format[%x]: %s\n", vcstate->bus_format,
 		   drm_get_bus_format_name(vcstate->bus_format));
 	seq_printf(s, "\toutput_mode[%x]", vcstate->output_mode);
-	seq_printf(s, " color_space[%d]\n", vcstate->color_space);
+	seq_printf(s, " colorspace[%d]\n", vcstate->colorspace);
 	seq_printf(s, "\tbackground color (10bpc): r=3D0x%x g=3D0x%x b=3D0x%x\n"=
,
 		   DRM_ARGB64_GETR_BPCS(cstate->background_color, 10),
 		   DRM_ARGB64_GETG_BPCS(cstate->background_color, 10),
=2D-=20
2.56.0


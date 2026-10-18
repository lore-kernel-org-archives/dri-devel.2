Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E06CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D32E10E514;
	Sun, 18 Oct 2026 14:32:09 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE14C10E514
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333906; x=1792938706; i=jan.claussen10@web.de;
 bh=n3DJbxmkboj1OAhxZEyDr3Uvgwh3hmsUvlr/gkiBoQ4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D+vXeAEGFgHXHiQE8/0Ci4pQGJ7Siu6ejq+eHGOEZPuuQPK7u5MZUTSeNyZXCOK4
 swiwFbDIrngha1d5ud9UQxKb4RIKPOd6yG3S/40yr2PRJU3sZSqaIMgSbG/SMQ/uu
 2XfqrhN+c1utc+TfJqnfTJ5qd8OJa3YbnQ028p3aK8r3jRFIG2GS0yrH9b9Sn+l2z
 PWSCaiThVjNYwB8U6jnm59k+gAD6CTZNnK9iK+QMLN+TmddGF1j9eak0Pduyjs6S0
 wuTTziJBXw0VHkABisYvUUcvJ0gLMWDIpoZGQ3z2rJ9jCATc5eHT3HiwPdCe4FQ9L
 4ipvFkXFE4NRTNmb6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyaM-1x3Wbj3ry6-00KRgP; Sun, 18
 Oct 2026 16:31:46 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniels@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/7] drm: Add colorspace property support to the HDMI
 helpers
Date: Sun, 18 Oct 2026 16:31:06 +0200
Message-ID: <20261018143135.5745-1-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vGcEIDBUptGQ8eK+sTEEJ1RfCPPWcGstJIXWjzQz1JYUT40wT+v
 hqXCtWfBlat+VRV3XIVzr2DDDBCfqa+MkfPBcEtVKwPgI9t2aNNFbDU0rkwMXprLTFBHf0Y
 nt+8r+pyc1XKZowU2yyv80+dbPuaSucOO+WSkPb+0QISdpDeQX1/wZ4cB8t7I3d1e0lr3nH
 R5V3lM7cwDQnfBjXVNHWA==
UI-OutboundReport: notjunk:1;M01:P0:5bhJv8J2OGo=;ZBETUUeNsvA+bNyZsLDctmrE4Ci
 VNDBMXJbuQPe7WnDRBw8a9smwIt2csDdlY8wbKnE5150/EyKn66iF0ODABsdUnt4GC2RS+WSy
 b+b/3TWDhUcgesOyPO79j4PVgvjX04DbrVZp2j+wEP4PQfE5URMuen5XpH34pzdKgJI5AsHkZ
 tPmznAunU8Es1MZFi0cNTHrRd79r4r49itOe8kmzhHPQxc7QB3Om1ET/J+bJ6ZyrVVN84HbPb
 YJ0mJvqoX6W9pyMirDi/rtnQfsa7jD2HOQ8u4FJt44NYnpTTUwXdKnio+AQmN+Jy6zQnXKfqA
 paPStnUQMjtbsVKyqmZean4CncQWIuSEe72LftAj2ULOtRJiN+3cCKgDhyIKrcfSY/C0iWpCW
 tTsFdhuAa8MkK6p/8GpBmUcahHu4WYkQd36Bsm4HCyuSTudCtHF5kgXeShpU0UhbMZWNRtMvW
 Sw+Cq7xVMn45H4peqQvFNGr0s0X+K0mMQwxtHIKqTcDCYhx5flcO7klENn3bzn35upPaS+xfH
 DnhhVRiI6/VQRnDAUXdeIrSsl0uYhQ49iz1pPAD/rN0skP+YCZ9V5X0X0DaiZNgi9064QJ/3y
 QWhrmdMICwlc0DhV7BBS1s1CQqXf5AEst4XeiESVkyIIXT/NfpqbhetdD7oIZd3lBhKneWikG
 bO4m3fdXZ6m2Ir8iiNYKkUO8LhN5Ask1tXfj5w5+e5lIaNHXpkAM5WVPFw6pe+IpWR3IXdY8T
 r8W0Aw0HcOf48IokgZpyEcp7mGZMOivg/F/3iyVME7OYmRaPeD5IHPgTvsG0wBvmKqNSxrW9f
 tbXeGjWBepPZBZVc/rH6+K/ip2vkMjg4AAQ5wn79qM1cLAK3JKLj3QNEQdSzRgFqRndoGVr7R
 N+7dUMEG5nbRdi+jTjQ9jrrdl87/dAoWIM87YeLDJCydtvYIqn8A/XumatwbOeS2+NUDBlQJ0
 N/xWaLZm9Ve/3BdWHFKKWqGMlx4Frxd1zYVIx26d6NRfsLDUzffNLlRXosLuXoYsRaKG4s0As
 B/EE8IB51sro9t+3QXckaetTYNUcn/jz/DN1CJE1FYZKZWpqPkfzUH2K8e1lw0rDV8RidzVYq
 z3dLObUl/fXIgf2I1sbc7T/lLYSFY1S/fwxwgDpA724dZ3zVOVY+0FpkGyR2mK/VmNUdJIjLB
 NxADpxeNBcoVdPwdF3shkwk4SFJOUxBDphve2zIy7i8yANf9IXm1MntdCi/X+CgzAOTuT4D17
 JfrkEdw4evviQkdPf/GOcML+8FFbgufinNoUrUxZDGxwNUvZSLt3edGSbihGXCBGrFtTY3E4P
 DMY3gHis1hHjh7UYhtvyrLPqSVI0iM8Yrpx/QhT6iUkuzRWTKwxNgNAl6HMPeg5qLqYyU37KO
 si25ZX68rA9gyA9xrX35TmSLVfws2fiEH3bXFELauXlw56YcREtGnML3ieyJYyUimFe2zDz13
 /eSjihIPt+sUTqgocXCdonc+ATj92iq/+J7UaWwv+0c0acl4MVpLaaN2iIN67PSh47kzZ0fRf
 UTNqmGbeCIzZtIofmsQBtoCaGESix/AW0fL0nRPHNntUHk4fo6Fq6QO6BscYVBwNSiNpmXbc1
 I2xqPLppGD+mpJ2PjvbiqHy6RPw1Sb4I+ZRZ+2lgofywjrTf56sL57rpjOUbeQjfC3npYFmwQ
 lxhu205icW+uUX07siFFyT0nvRVjVqEceoXGuxHC9AIl6ApUq3w81hPKL03e2Gzcf4vVfHBRN
 WhDwa/gaxINH3m/810WY7zAtaWmx285FaBYLdM/VHNhL5Jdg76Dx8LIVfq6hJ5Od2/9DCxC92
 qGc/MR56TBqZLSvgisq8VBPwrW/vUj1lD42UyizA38vMKJIsPEhfzAm4byhGx6ULSYhJxP5Cr
 J2nx8J/O8jAB1egxOlPS6aZVf+6vnAK+wU0HbXPhk4Li2rDHrh2Wrqjq7ibK2G2FElBgvIBT8
 HhpwXdpW4fZueNLuzFhT+zXBLC8nvjTVJJFI+UEL0gDIUNyI/sM4Y9oQNLOIHtzwz78grQOtR
 EmPTM83fz1hiMdQO8+YZQs8QMA3EH+Q3A0AeDjm53QNBC/DVrYsYzREXGb6qTH+tK79nnjsQO
 VxPUEILAQjgyCZZ+/viXC70ZUuTbsP20oH81R0tijivlz8mT3uWQ2d2N0iCR5QTF/dGJyIp+6
 uxqGIaOpFKfMMrN6Vg2v6vjm25FexBpZsEzXGFSbE7BwksUPzy7sAyCh5P3OCxADNzXcuI8yw
 h71A3iI5AvI9K6wjjiqv6GTF48PcLIx1zVR9yao52FcNQfbRskuiXwcOX5Qfvz9mKkaORlIdb
 wx/5S+XlHtLeS8YEiOpZtHJVmjB/gcP39+5l5I5lAY8VogRiTFwXrM9FE2XKwfgJSiiy+Bjp9
 3dnViDZdWNj/rLdvLLjWpTs7lIdTwC+YFZrvBwi/1tbzQjniObmluJvwj7YULwC4kaAQUT1k4
 EoQJ9gJBM48BdZge+876p9ajQ1NnrABcR7aKgs4L6ulT/7jbEprtXQhetNoqVH6Zllwf128P1
 dfYSSR2czPZ0xTSdDJ4S6fK0eKFM+Wpz4npr4o0iilmR51x7OyLFMuA+MoYKbqaN54MicdFUe
 TczOr2qqYbpPLMkHzCe0GbI2tyAfumOww8+KSOCJF6eI1JM5umW+QVxp+R9xGI7nIw326S3jF
 kl+o5D0rPZAyj4uqk0inOJwsl/CdgfQ3MTr0bk0c1wD7JBSkAbep9arjwmQqUdyv8aj5lcKAj
 dBao8i382ze4s71y9Xs8aibisnTwsATeMEK5UeBgM5p83NwHUAiMHw94i3+3TrSlAmeP9NOp5
 zcvmheI0HNrEkbMpUzV4LoXPwLSxm6ydHlaEJ0Ne84jWkOQX8iTypDr02yl6eotRzE9bjqe6v
 qRYSsrIlobx3AVTZ4JM22d2kem+vCZXz9hTyoyTHWdoiU42+9p5xmfGkYGTTvsTrTLVo5rZ7L
 7xyLRvql2AXB5ahAU1ulQ3e/7wd4LegMrjAFtGbojlSqT9VwlTjFZt+Nz1S00oesX5E8u+6MH
 5sIedfEQiXKwVCJcC3R8xhF/logkKmG/oZlgwKLFeemFxN8LSyNd+P58TM7PzBW+wVoJeaFd1
 VDPquLO7Sa0JwtNLnSMZz1zPmEgkMvXS4fe9/VMm7QjEPfAxcvWC4jXDCmMK7tvg044ky4TpL
 4p8B18yDuU9QGoHXt5nsk+3hvwlR/bwj3U/nubKuaWoL2xOEiLdM8nealW0fCxIPwKujSelv9
 TqatX9qpeKVyyEzcbc6HAYaoGzZMm04y2dYUUFHWcAxqFQIM6yt5FB4AhdRrs/6wMNfzHjePj
 Cd/Cmd7EWicOuGtz0fTbyObRLhPlIa9fG2g6UO/r1ii2OWvU23l3k3H+MYffFWqWC8EUzgVr+
 QNGn3miY+VqlcrkEPKKiq5p7SzNThrDhpz7+U2SB3C7RFfQcykJShs8l2PU8DdBE7tZrufhQt
 UMDr8lkeGfzpmdy4h5UV9SGPsrVAHaq/eRrsDKlbHNcyWF81+EDpWEMCtdnppWAqP9LPwf3H5
 bIjeJtrFcUtOE+6BcbZ8knaPNHZpdA2490iAjyn2Hsz4E8mhGqwfb0wr9suseJFkC9oD5pJPW
 O0afMB6mD0UB48ruXg28xOS9ijIUrSRT63qmLBZqo2fVBJdlmv8QOjnXtaCJtgSJoJk/lzAig
 VruJECeBlRkoQapu+aC+SV1TZLBFjDooSss8gs0KaUyYgYIeK0B6zDkBX13b0G5Ttarz+FwL6
 vU2cgx5xZmvC6Ausa809YNfvyEZ259BQWrrWatF74RFvmkzr4WDArvwCgjBe2T9oom8iMoZ0b
 H/PVEbybkJvwqYea/Bso99XoFwhjRT5IG7Go8r1DjsjA7T6snSR7n5aJQXAikmoAbfQE1CyPE
 xEpZPaHE7uZ6DlJLuGf5bxtWMR+KIwwYndZQY8fMgPDvZZ6FkO0+ko8cPQuD170mwqBLQk9XT
 Ki1C+JPSZgO/5UUa5sp6//GqvuawXbQo2mPCBPqyqYNEa2xoyljbpTa70+jQ+gcmdaf/WrWgp
 OapX5022Eya6Mf3WaS0O51PdgY1DKJy2z8JFPltTo8CreWrEwg119fFnXijrsLatX632Vzhvk
 am5rcj7Bk5x55mmvad31iJmrm7BHhbYd17AqFzMqShqODc6MfiR32Zf27RfJApa46imeJJGEh
 oOhE3ilVWxP3+r33lmMz3FavZkNzbEgV1kJTQ9Q1xAe4wQwy7lPzBDE9tzsUSrYoPhM45brON
 QtFXFTU++Qtc6WgrrvDZBOl5Nngr8IAx9pGxRdH5XLPm2VkuzGetcXRPeqzQCfq0UwJrRBj8W
 v+GvAKBnHJNcHNdTCcdLieqszxu3nG1hqEC3kyqe52HkKrRR8u5D321kw5xT4ZPJOBylK2KbE
 +oyiZ5li0wiHp9pDII75sBiHDjMJjdyu9hB6yKfBDk+eWRhmXcfSjrsiQ1FipojmYnBLKhyrI
 x+AdslzhwRCBZzpuGLBtt1UjAt7CkOdDaAboSsNwdUVCetPIrqQuPYgGbcOW/eKCG+T/0w/he
 hCFMkhpUzT+dcwlqcOkIaktp22BwFBFkVP7IYrW3OOjP9vyHOWHVPmZdQBQHMiNEJHJpO3xMY
 /wKtgL/rsrXA/22WSn0paCATq5FsIL3vTk9/wHz78VICQbNAEMBpQcX3qMh7MHRy8+9Q2atoC
 ASBV2CHwV0PWiDfUSSz/Av/yhyy+a29sABEG7Fr3c30vykkwx92dBXIXWfk++8YW1fn7y5D7s
 Dz34nGMUcbhcO3Y1668d9H0exKd5nIAGbMrNQK6Kp9U4Jdpu5X2McRsn/IhbrH1DkoKqxQJos
 8BWOcl7raUH98NpsnPHf/mLs3g5bbsiqdKlVpTxE64IHRo8zg0jt6ZTJ+aUPZnF8120yEawmw
 KOJIdx+4zvd8aOmn5PzeAPdIHibOgd94wKan1P5LNtSbICRLpdU/fQyWZcVuqx+wAFa5h4tdM
 ll+UKKUtV2jgLb3l+Bm89t1wK8Ei79MWZ5eXzF68pHoXto4qjTVHwLHCNJo0PggIXSfhb9Xh1
 OHLtFv6rxaKU0GmYlvTomB+WRKp3ro+2WOFpr3n5ii29BehSU8UgO9rVE2odFZksOM4m/4VzV
 RR6rRM4ycL+gidgjFlz3XhaWVaIPcBh9jzm5VqSeQyv9ds1KT4yxQ/53fxpVggdi0A7cc9YfP
 znw/BLwufzOFk2Zjv5zOJpwK/8dKIVL3bMhWSy6epum+7v9rX0neU7ajdIzkUliYHZB8D0g8R
 PzBmJrGZgF7rKed44PR4k7XFVs9O+B+tPFMWehy/WCH7HMvbWmOpzeV7agCYyYWu7sCDsw4VS
 PfZNSl2kD0yWriCDJOhnjbrV0/iJA5sCHDeNq7tYjA5MozI7PUa0IyTMrU1jWkW7K4ohzy2Rn
 KXlIHL8ox6WiARgikJw6qZi+q/G6Noe/krmIa70U9QG8XkXUwcildpVEnTD052hJvHKSVsXJZ
 J+L5uUzEpgfjuZpsS20qzKeuIhxETWzEOkbswPOPX/o6Q+v3UqNkts+xOZA+sGVgG6LhtyuDS
 o4mPQkqyknVq4QHl6YEG9D6tGetkCSt//q52JQBW6mGWB9iO0QjPXz/NwWr47RV65MpLINYh9
 J+oltG41Lxg5Iiui7GFd0miS49yiCEAQSZyFe1ZPxqA7wWlIVSfhpvYJ8VV3bf8k0I3BPY85d
 71jLwm9kjjGCUHBJX13r1vutsoL3Wp6MY3zMj00+SnBTndpSD8pFkyDNi6H7gfDZrJpIqMOoC
 X2fnVA5P1sleBM68RhiVm+lQYCVfVfCz9uMnFUeNkzuPGKz/mf+AoWDji8GLASZmqgQN40YG5
 a+5uc8xG4nqduNX/LNL+ePszIUFrTK3a4sX75o967UPUZRTDJYvjbVZ7YvZa0kSp7QVH4rWjl
 9KURX8Vi1Y+sFrU+Byq0FFyZ/JhP4kRQPIdWLZV21dfx0zXZj4oYXIIIyE3vlv9/2F5Et4T0o
 gl5fEsMKUk0hahJLolLjG4RhxiodjVeLswCT+GC7l1RCWSKsW78F8r5Qy8omeVzhyTjbkwviN
 9NwDsE+vqCFMamTRwKQvyxW7uBdWN6tfOnMc7l2lSkPvo3XKtEa/gYZ4rJrP1X9+Skg6NGqEX
 FkhsAqO3NwFsyKvFih1fWDs2qvza5EpR+CV9Q5w5BZwxvMGcaYL7DUfUKk633suVajG2AtEG3
 IeCYgZa55eAiKrz+wlQ3zwZksWYJ8fQhiXZgpUgWOQ+7iZMcdH8ksdO7g9j70/riB2sfXAhe5
 1QZb8yOrj+7cOj6g6QjlTpIOZNGQmMTn7VYWrIwIkcCvRhlTmQ4f5F+IfLOqQgrIHaiHB0DPD
 /hPuWKltQnFnJkLPXswRGPIrSDiKIz4prFIDcFPPzuSwCagwEwme9Xxe8vAjYXRSbXsBFNyQi
 p2LeMs27UabWsJ4vO72gpJBgcqMFLuzeHmv8zkaVAd9z3UGv/K4cm4oAAw4Sd1wPpO0dkdvfx
 t/ke7ayRQAKSyLW4ZgV0Z82dHBDx70Mwk2rJ7kyO33fzdN0IqlcUMkb8yNFhz7+KgoIYQPZCt
 oc+v1UjbWvzqUEND8YGyEc7hmU34SsJJ/aGB5g8Aqt5OBSbu3fZTH4yRSpM1sUrhS3ecZzQL3
 t2/lU38PIABC3y9DlSIA=
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

HDMI connectors set up through drmm_connector_hdmi_init() don't expose
the colorspace property, so userspace can't signal BT.2020 colorimetry
for HDR. KWin, for example, doesn't offer HDR without it.

This series lets drivers declare which colorspaces they support and has
the HDMI helpers create the property and force a modeset when it
changes. dw-hdmi-qp on RK3588 is the first user.

Tested on a Radxa Rock 5B (RK3588) with an LG OLED55B87LC in KDE
Plasma 6.7.5. Only BT.2020 RGB is tested.

Changes in v4:
- Set the VOP2 color space from the connector colorspace, so YCbCr output
  is converted with the matching matrix (Sashiko)

Changes in v3:
- Move colorspace handling into the HDMI helpers (Maxime)
- Let drivers declare supported colorspaces instead of exposing all
- Split into a series

Changes in v2:
- Fix possible null pointer dereferencing requested by the Sashiko bot

v3: https://lore.kernel.org/all/20261018123037.19560-1-jan.claussen10@web.=
de
v2: https://lore.kernel.org/all/20261011142733.7806-1-jan.claussen10@web.d=
e
v1: https://lore.kernel.org/all/20261011132024.2833-1-jan.claussen10@web.d=
e

Jan Clau=C3=9Fen (7):
  drm/connector: Fix typo in colorspace error messages
  drm/display: hdmi-state-helper: Force modeset on colorspace change
  drm/connector: hdmi: Create the colorspace property
  drm/bridge-connector: Pass supported colorspaces to the HDMI helpers
  drm/bridge: dw-hdmi-qp: Forward supported colorspaces from platform
    data
  drm/rockchip: dw_hdmi_qp: Set the VOP2 color space from the connector
  drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020 colorimetries

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c  |  3 +++
 .../gpu/drm/display/drm_bridge_connector.c    |  4 ++++
 .../gpu/drm/display/drm_hdmi_state_helper.c   |  3 ++-
 drivers/gpu/drm/drm_connector.c               | 17 ++++++++++++----
 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    | 20 +++++++++++++++++++
 include/drm/bridge/dw_hdmi_qp.h               |  2 ++
 include/drm/drm_bridge.h                      |  7 +++++++
 include/drm/drm_connector.h                   |  7 +++++++
 8 files changed, 58 insertions(+), 5 deletions(-)

=2D-=20
2.56.0


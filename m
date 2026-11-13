Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3F606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=u8EmjHoD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB0A10F00C;
	Sat, 14 Nov 2026 16:24:59 +0000 (UTC)
Received: from outbound.pv.icloud.com (pv-2005a-snip4-11.eps.apple.com
 [57.103.66.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7381610E4D0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:16:02 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-6 (Postfix) with ESMTPS id
 62EDF1801B20; Fri, 13 Nov 2026 17:15:52 +0000 (UTC)
X-ICL-RepId: 01a1d5e8-99b9-70ee-9274-c2d0c6a69ba6
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tawheed.cc; s=sig1;
 t=1794590162; x=1826126162; bh=tBz0CGsSO8Y0L5vFYQnYGkjpR8lPwZ5lNwEzHdELXr4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=u8EmjHoDdp8GMbROFI+lllGp50iJIqkomgyzjZ5Q1KllwikhnlFb2R2ic6vJU3iasiFqkfjMeYeXfAIjCYERz5GkF3c0lQ00l3lexJWGibP/V6ZamLvHCnAuhXf5Rgf81ibq7N1vmIOmkJFvalcXJ4GFCAMLlVaHqYsklf3S8jZYxj79mJINmAl27WvlFkYeYNaCdj4tdS7mq7GaujWoP/0aQ6TR2tbeDNHzjHTA82Xrl04SNIkqDNOFuP067ld57HbM7TlJM00O8DCI+Oh5DuGEqEUYrn8Ew7fdyOXY7uz/nb2B2BPM8a35+5zzO3KZOT02Pb5tpZEkNfweR168CQ==
mail-alias-created-date: 1711150425226
Received: from DESKTOP-HUABEFD.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-6 (Postfix) with ESMTPSA id
 918D01801B61; Fri, 13 Nov 2026 17:15:50 +0000 (UTC)
From: Tawheed Makhdoomi <_@tawheed.cc>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Douglas Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel-edp: Add LGD LP129WT112684 panel
Date: Fri, 13 Nov 2026 12:15:40 -0500
Message-ID: <20261113171540.446-1-_@tawheed.cc>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=I87w19gg c=1 sm=1 tr=0 ts=6af745cb
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HxOO8S7qDNDRVQTpMkN7:22
 a=0OSefl1wAvM1iDVUJ7Ah:22 a=VwQbUJbxAAAA:8 a=kr8jYOqCoWP1efnyqfUA:9
X-Proofpoint-GUID: M_PNZHOS99GjYu9OqssTlEtd5IGxRrde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2OCBTYWx0ZWRfX0/ks+Waq9qYT
 fN+b77VujlVsexUEpSeUKjWqy4otdigcdHBh3/WihbCxS9Sz5kuCzikReENsfYlraZGGgP2lLNV
 yk2gXpN5zr4QRuuZ/5+S/022IC8bcIWFh0YMWwBs8LEOxogEFR6ZFvBZfQCI0xhYtnoiEaIbNCT
 m+t2tlwCL58DXaVVdDkxar+We0ecz6dy2Eu+88WAvsdrE57vPa9ol2R4nkj9wjHU96MKt9d7qH2
 +dqFsg0J3Y7NgBXaZVliqxIZQmBeK1l8NjYHVXKbZdZWnmOeraAGzIbUhRaNyZbNoCrqTWL+4TM
 /5fDOmgEKmSbDZu6TwYWJqdtXLGuwVT7cFPwbjoMDNcXZ09KURQVNXu+Di9lkQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2OCBTYWx0ZWRfX54YFGxE359vc
 ijBW+Jojob1hnzUZ1hOoKNJ3pxbQkYvTb34Zd57X09neHgsPrTE0hEUpJTor4BGL3m2rOByNSC5
 9jdeWz5XenRXisiMdnbDNKK/vJkldGg=
X-Proofpoint-ORIG-GUID: M_PNZHOS99GjYu9OqssTlEtd5IGxRrde
X-JNJ: AAAAAAABThJ3j+bTqVM0/YzE43oVZsczGDHvY2JBimkv6NXaeDFer5vcRaTqwdRS2EunOX
 yCSu95IVQASfdSRt+mQs58V2oebNjxc7Ut0V+Nvo351jKJJ343jDGiKq/Myj9ulIkQGqn2
 CKD7EcDzTHnWaZOelGs7raMLAykf4fBNlHv3pVPmkWXmzZ2VwnokxHhWaRudGzGEf97Umq
 0UCrKGg0j7bV8RBcpQHO2DT0C+QMqAznIL5RN+rTyhOEOTp/vu8Aw+aZzlldIEuUTFaY6T
 9R+Ec3F3WsBmiNs0KYTXIlFYfpctzV98uM4gjR9Dd22XAPOU4A4gaGNGr/VQxJfwFKvypr
 pepkAsrldvJXV0pdMRjZXxcq+gRuokI8+89nq7WKYLcbVGPMrDXNo2a5JY03FNq+Pa9OeM
 81N6CiLTqt5PqUUAl6SDGeBlgVomtguLHdM3NUzfANkuKTzlaekhgcdJhGr6ppOQZWBBmz
 /EbFUu95tmDnvCGJjvGhZKlJ2yupReNUrxF504WVwyBCzrSgmUwwo0YITIxRccBpyNEqv7
 niQP4dX8P9d8+Jr0WHojNxNQ6duMGe7SCSgOwExhwyzOYwKdyRLHi7AKV77p51M7tBsAtp
 wl6EGbEVg6ok58D6ywANoe35jaN5pIvVfPFh9dKxmk1128Q3E8/XzgqiuPhaYpn1mrnxc+
 rxPEtQYMVlJdefypAmS57dkep+uIRUnNpdB5ODZOVj1l7Ppnr0HIT4ok749jKcBHmEV9R/
 /X6eh+ozdE2heBvezAgGzA4Pr8zrBjp1GiKYMX8bhc7C4IqAQjjpmISLAp3oEzr4hcI2W+
 6FL7aQ7zBupDvAoUKeJMHmux5eGdg53tf4MHS90SSyDZKl9Lr3zydKmLuDLikXWK0JpYa3
 MSTbEGRdBNFUqwbXmJFKSB4gvn58A1Bv3aer6lLLHGvD67YVHGdAsz9o+D+Bi3RZ7uf59R
 7OWaJn+DeXnM4TK4ewkhqZC+WdnKshA1KGn/n2n0kYcrLxJdZhrADWFXzD5xwGBpf4TGht
 dE5pdXzvKqm8mrFK2wghM2L2hPi7C1kP74bRzspSEYKXxGLQpYEWr21zUYv0fKuTjAQ0K+
 wSRrGXZ+3723q7ZJQSzP9mbgwJq0Y9BVP6i/Jgp/sPoJBkKwkPy1WfsJfY18nwwoWNLMC+
 zoktM8VVR289MomM5lII+W1zx/oA3TMK6NG7syB0W/Wh5dFIuLxlLHWYA3GQVS766NVsV7
 R6wOBO0gLXiJRV76WD05CBUInBRB5sesm8miLbGjOGumPuJtvd3jLciIPvosjRIiyQ0wI4
 got/sjyiTm7uovyLTgTe5bjc7i7svKIXH+DLNg2YP9mJdzpu+lpQSlh/GiXVLsumgjzJXW
 NRR/283TNEnfKt+j3paIhajZAqfFaNQxVw==
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the LG Display LP129WT112684 12.9" 2880x1920 eDP panel used in the
Microsoft Surface Pro X (SQ1). Without this entry the panel is driven
with the conservative fallback timings and probe hits the "Unknown
panel" WARN.

I don't have a datasheet for this panel, so the timings are a guess
based on similar panels: delay_200_500_e200_d200 is what the other LGD
12.9" panel in the table (0x06b2, LP129WT232166) and most other LGD
entries use. With this entry the panel is detected and the display comes
up on every one of the 38 boots logged so far on my Surface Pro X (SQ1).

EDID, read from /sys/class/drm/card1-eDP-1/edid:

00 ff ff ff ff ff ff 00 30 e4 55 05 a0 28 09 00
00 1c 01 04 a5 1b 12 78 03 ee 95 a3 54 4c 99 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 de 8a 40 78 b0 80 37 70 30 20
55 04 12 b7 10 00 00 19 00 00 00 fd 00 1e 3c 00
00 24 04 0a 48 14 14 14 14 00 00 00 00 fe 00 4c
47 44 5f 44 56 31 2e 30 5f 0a 20 20 00 00 00 fe
00 4c 50 31 32 39 57 54 31 31 32 36 38 34 00 41

  Manufacturer: LGD
  Model: 0x0555
  Made in: 2018
  Alphanumeric data strings: 'LGD_DV1.0_', 'LP129WT112684'
  DTD 1: 2880x1920 60.000 Hz 3:2 (274 mm x 183 mm), pixel clock 355.50 MHz

Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
---
Changes in v2:
- Include the EDID in the commit message.
- Say explicitly that the timings are a guess (no datasheet) and how
  they were picked, as Doug asked.
- v1: https://lore.kernel.org/r/20261112154444.417-1-_@tawheed.cc

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f7add22cc..8f7d7a3b2 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2190,6 +2190,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x052c, &delay_200_500_e200_d200, "LP133WF2-SPL7"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0537, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x054a, &delay_200_500_e200_d200, "LP116WH8-SPC1"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0555, &delay_200_500_e200_d200, "LP129WT112684"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0567, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
-- 
2.43.0

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6512606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=U0RRA0lU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B968112543;
	Fri, 13 Nov 2026 13:43:49 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 15:53:26 UTC
Received: from outbound.pv.icloud.com (pv-2005h-snip4-11.eps.apple.com
 [57.103.66.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2888E1121C9
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:53:26 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 768A5180023D; Thu, 12 Nov 2026 15:44:51 +0000 (UTC)
X-ICL-RepId: 01a1d06e-e6e7-7d0f-a699-1dc6edd59094
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tawheed.cc; s=sig1;
 t=1794498292; x=1826034292; bh=hD9EHOp1sqfWQCZ39a9QuXn0Z2yLfe+6MbzfqSYgeyE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U0RRA0lUgFOyB41rNpiZZkRwodU3wb0FT71dBwqqysCK5mtaxFQY9XfQNZzBj82hogoEjCPqTvO7bZW36GHI2HUKU5Eq4BfsDJLi0feTORWolWwNazXVlGAu0jKu6BzVusopclrfqlYikEvRUFwqrJ33dR66EqfhMaUGKrwqK9UQgTNqpuCXLa5LoypbeGBDDPBIc/REz5lboatdwq75ZwlLMH3rXgRKdW8k3/CIJM03ul2TxMbYy8380BLCpWm2olOyHQFpJS8QS2gb3dmwNS7VzddFBfQGr2Ao80NaaI6qQjlRytjbajG+KSz2cqpjBJUjk4PhaJPlxJIR+4Jtqg==
mail-alias-created-date: 1711150425226
Received: from DESKTOP-HUABEFD.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 1E3E818001D6; Thu, 12 Nov 2026 15:44:50 +0000 (UTC)
From: Tawheed Makhdoomi <_@tawheed.cc>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Douglas Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add LGD LP129WT112684 panel
Date: Thu, 12 Nov 2026 10:44:44 -0500
Message-ID: <20261112154444.417-1-_@tawheed.cc>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MiBTYWx0ZWRfXxU6LO3ZEY1JI
 0jqgvJJC95obiYJYKmdUAN8Q0t5TZ9UtHxrmIzplPBsoNrVkBl7AnomRwI+O8QV63v7gL3lyg2L
 yx1fLr31FTkmXnrSU7CffWilmQo1C0S9MUi7OIma7mm3foqhP7bhTYjwV8M5TvPIxgG/j96LdLV
 8LHZ9DDOKl+aEUMhj6JVMjk1FbkAxkoTlk+LnOQDUWYUcNKhOz8ZFJYyqVIb4sT9j32Hy4581GO
 i+Knrt3ajweAZk+MvKHDxNZ4iOTJWYz4Ngzal7dynopzT0pbKfKRj/X8Hvhfibzxz3pCfCy9P8S
 mMm2CrID2ndmdhHT3vi95Rih1s+JRrgUbHwyDygsroM7D3UXM6kcoWNulZenbw=
X-Proofpoint-GUID: Fo9oz_V7p-lADEa_ELg97zHVp1OsVTt3
X-Authority-Info-Out: v=2.4 cv=BY7VE7t2 c=1 sm=1 tr=0 ts=6af5def3
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZXJPI2V5j2xcGEkMas8A:9
X-Proofpoint-ORIG-GUID: Fo9oz_V7p-lADEa_ELg97zHVp1OsVTt3
X-JNJ: AAAAAAABe8jkH0cKRXDJQLKW8TDcwG8DSnePrNj1QOFZqDaJ8H3m3gcDu4Gtmk+GCou4nz
 htim1rMOr0xBSM1DYTZ2C3qMXqdvNiu63kDttaGu6iBvI8/poOfCJ+yBmNqljQyNF/TKHy
 WL/y6shbUkCRK3VsYhN4Haqb6w+seHOwTvi6/kEMFQwmqmfkRKHc8UppwvC75jKxil0vy5
 MSmDlwH6WI/kGPa5l5/CH/HK/dpNcPb3YDAeJFrGn1K8C/VeBnfmVE4QmgWBwZNgEV0dPf
 SZgckG7LYqYPxW65V+x9NkUklUl4MlkyXzyNmM+v5jh5P0eqiBD0+u5zb+cR+wzAzV5e1z
 mARSVLzVldHl00JtT2uY2ylbqge0q1qy8AeWgoxUQoUA9UkUuwZa5AGJ9hxWp0TidYJOKK
 cJ0scOKBCqXuGCIh5+8wbqDBuwmfsIQyUO+HAMJuzMntMw9alj5JhECuBDCJzz1BoWyJvY
 EErv02IuWy/Fw4zi5tEryTN7rdyOraQTu4Mhy4AfN4Po6aasn36kUqv1osz9sOaqXnpr+Q
 QSKsMwnd+AoZQtTucC2AuuzitFFBJguzapB+N6NS4DGOadM9tTAdbTMmDBzBcvsFHxVyAi
 lueX2G8OiMAuRb7LVVVZ27jpG2ZKIPVLKQLkt5ztQiHCfHU8KsSvGa+rusWeaiv2zxZkmD
 GsA59iXesL4GMA9j5AZGq4X7Au23+xCqxxkOJ7EoXsjcacwwkcJ5crbaiDvTxmScvmkTAb
 +Xouid+HhLqJ5Wwb6dy9LJqRbhrTnP/g673WNkVspULRKizR9im2sXzC8cVV3hOm3WM0Vj
 qkb7JRX93EO/4P7yl7DUE0EV+Di2CJAv3Xl/jhULoeGZTlFr4Ur7G1Sw+VaWgOz67ncbnl
 le2vj48ZoxByh0Jss99YNcgmuA8zbzUGuaFJi/f/PC44fZHDFEHfMAemyR1JzcHaamf6zT
 jyvZSYHVVr57FZFChfsxU2QmAr5ISHkHth5QKGgwuObdifpTk6BBNXuVdBqdOjQTmGNBqr
 eQMkDwD+f44sFPNs+l5oCTpCt19lvR2xnVjw15FNMkxJeQVl3QvTsjgkjjssAwgUgrTlw+
 t4xiIZ4ex8S4/5I84D10nVY6rnstKlDIgCEbuu0TjOi4af4MduyPEo9zDQ5bY6YM+49jDD
 6TCPQNOFBmlz6jNlxGT/AdkQ+v6y/q9GiSNRrx9vJwUBb6zVgnGKgBtD+uvpZ396zwWJWA
 PEaMrlZ3uLLG5WZBCag/hSRIWtV8SfKHrowe+ON5qIrUg+DoRUqw0Cp+7Q+djylgs72iOf
 Exc2l/ComzdOCouKlmTZMHxvq1CVqvo2yvzabNgWMRTc07pSyg7SZF3VyBBKnchOgE3vmp
 Ef2A5lLUySM252NsiX7OLQ7ROWY=
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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

Add the LG Display LP129WT112684 12.9" 2880x1920 eDP panel, used in the
Microsoft Surface Pro X (SQ1). It uses the same timings as the other
LGD LP129WT* panel already in the table (0x06b2).

Without this entry the panel is driven with conservative timings and
probe hits the "Unknown panel" WARN.

Panel ID: LGD 0x0555, EDID descriptors "LGD_DV1.0_" / "LP129WT112684".

Signed-off-by: Tawheed Makhdoomi <_@tawheed.cc>
---
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


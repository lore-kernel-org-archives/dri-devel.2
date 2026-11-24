Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD3606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TXJHGXMT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=byeB9yUY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B6E10F8DF;
	Tue, 24 Nov 2026 23:13:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D13510F8CB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaYL51654121
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HqCM6POh24DebYJfAVl/naQ7YT8IqWCIOL1KDFWTSR8=; b=TXJHGXMTnfwZqEzN
 nu2QylxvWvjQ5f5Wv4NQVsxMdE1sC3EyF2z537BIQthfz3Xs7rdQBDAYG/Pe8IFg
 zzPC0XPK6zi2DoBBquRLtUmoWNrBkvxKiTFymvXXl8YQRdy3WaVWzXyK/mUHxmYM
 mLG9gNcU5Gp/JuoDuQpA8iMu4GtJttJMseWBnPa2n07x0uk9IFNkLICMvloFQahw
 TeSG24+SS4p+YbRwMFv8ZrkaRHLqf495/X0h17jEbqgQo3yG2QdZTMVQcyMQU0+Z
 bzXfrUlLj2wXfUA/EaXYhZ8Yo7VxX1X0cAMRxwebOmNthxquIYGzlMMUdQrfUdTA
 dQAv0g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eyd993y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-92109408212so105829046d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562008; x=1796166808;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HqCM6POh24DebYJfAVl/naQ7YT8IqWCIOL1KDFWTSR8=;
 b=byeB9yUYCqcIil00nYv4/bff7ei57rLSL2OgB9c2g7Wdd4OE8831vlH/+aJH9acfJv
 OhBjDuvgU+ZoylkQuuZhe85qWc9AycLMPL1KAZhIl/fU/aRZaR8qzSg8W+gWJnIX1apT
 B/0gMDfjWf7BYSOUf3emhjk2bF2yqZLwjnixVDg67Lxt2qD6qu1Hl3M0vbAMSWs9K+ah
 kFWolsplUJZ7+Lvf9Wt1AmdRbrC4967kipianyEGkfAxKYoz18tKSF3ttDhVwoy1avnL
 JgzJNzI++zPafya+lQ0uNdcJESRbP+VRa/LnepmEq5CVZTOA+Z2Vgw4gSGrKx0G3aJCH
 4Ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562008; x=1796166808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HqCM6POh24DebYJfAVl/naQ7YT8IqWCIOL1KDFWTSR8=;
 b=I9yFjDV1mMLiMS2V0tccGOoMcaFqAJaTLLslSMfrBNnsFTLbvIBa3CcbufRpgAAwsV
 B/PbupcQPeueolh0erPdvyj1xWXBe1VziUe2CCYaI32AugIPT6WNXuYG62EM66Cx6jYi
 tPDusJKn2TCv+zaRoRwYFX8xSFSa/VmYwSVOEuQcXIaP04JSWujIOJ4ozsDph1J9ahu8
 T6eAADrJ+xTMn/9zLM68OEqbWQJnaHjEIDle4jqTstrrwMK/Z/f4krDyFO04PTHgmFTu
 udHuELo0e7NvJxAAWfzetptBOZMXEOh6uFLChlwbjERsrU81BpvO7nNFklwteDZA/PPA
 W3Jw==
X-Gm-Message-State: APuU4Z/KpX5LouJ3RxRnvncwNQnAc+PzPYstfdxuf0KljQNME56Q4QKb
 OZym5ggC6HWpNzePqe6jS77fwpYZx65MNP1tt0JWR8sAe9E4nXdneO5y8BOFjqaTBNmzLP+ZBEs
 LhzXyc3SxL4PorbtsWNthfw8KEVT21jARxbjt36SsauJo7gCmoVc3UGLo/mkbhjzKmANFlrU=
X-Gm-Gg: AZFdTZdjZhXETFBXtkbKpkqjFH2k3EkwivqgUTvOY5gL8ty2HqoeG5NZ8dP6EXWwSM5
 lRpcCfcLxPlnCz5aQYLrPT3e4GV0+X4/ZW0bEJZsAzrEBJkGIpYofdzMx5OIY3cscTbjrEFf1J8
 +N7vZBLHBcFxgbwVb1cUMPJxOQLsX6C+xkSHB0aZp8s32OL88fAMSGc/BfPtuYWXu/GHEQoY4ob
 z7vJmQN1ipwI4U/brbDJ1Nnd7Oftt08he0n0wohVXN0pRE3QDeuPb+Qcwkjm9NpBpUJjXifa/eQ
 JG5B96MpdX/XiDvSjRn+bCwps4FrIpJ/K+5yjbJhxqC9/N3GeFDzaRhHESelTJjcAvbwue7romF
 qRzRF/Qe47x2dnPianEpd8/IcTLJEASqJ7wW9Tg3/fI+99PYL5deUlU5UBGebFQ6wkcAEX8nlKn
 KA/HYOLOd+MLiDGRGuWlvSYtksr0R7hXrGV2M1gcYX+4WByZ0g4Uq+IB1Jj6oAkg==
X-Received: by 2002:a05:6214:3189:b0:91c:6e6a:f1ad with SMTP id
 6a1803df08f44-92134763915mr302416276d6.0.1795562007825; 
 Tue, 24 Nov 2026 15:13:27 -0800 (PST)
X-Received: by 2002:a05:6214:3189:b0:91c:6e6a:f1ad with SMTP id
 6a1803df08f44-92134763915mr302415676d6.0.1795562007336; 
 Tue, 24 Nov 2026 15:13:27 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8056b207sm43708401fa.37.2026.11.24.15.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 15:13:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 01:13:16 +0200
Subject: [PATCH 2/2] drm/bridge: lt9611uxc: report a failed firmware update
 as a failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-lt9611uxc-fw-verify-v1-2-7aed8dec8018@oss.qualcomm.com>
References: <20261125-b4-lt9611uxc-fw-verify-v1-0-7aed8dec8018@oss.qualcomm.com>
In-Reply-To: <20261125-b4-lt9611uxc-fw-verify-v1-0-7aed8dec8018@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jMRBbYL6cdhmXY4Meo0eIrw8TiKLiu9TSeLGpMZfndI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrBhoS2Vsep9ofIp8In2D1C1ZspGR9wpw2dSf+N
 lIxdS0dpj6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawYaEgAKCRCLPIo+Aiko
 1YjUB/wMKKjoY7T6WM9ZUnnxPiFMUvgDQZBHz0CtMRkEtt6QhqtewOOBQmCiJRjazOC1UHcWnDT
 zVzXMF8R1dkLCjq8aTGGBcyNGwxB9loIb0hhomL5X1nEXLphjiynZdPT7+klzUsxeB5fL3RQpYq
 fI1/hUJJ1crJ7EoG8O/JkknAZqy//r4h2OrAB/WZsQRhsY3cIbW+c5XuZfKf/NLIGx8adiErBea
 mr431cB+GIriGpH87LQWpT7s1NkgjmC5j8FlbIBH7PBYjHYuXgMpCp7UriRNOmgY5Ctdv0ae51R
 EIGjp/Kf2EiuBe9qmZ+x7oXFExXNwbLb+6Mm+8JkVNUJ1SOK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXytpMV3/NxGBe
 5X7ymYa0IoV0Uf2Xmoze9+bSY4X4/B4RMdFaWZmaTzkJ78eKhfI5+aDo6UDuyYZEIqZ4KlZV7x8
 wSiqLuiZAayOT9AsRBuUht7lfd4wxcg=
X-Proofpoint-ORIG-GUID: fxeiMoi246JUMksqqFYi70HM-lQLoIFR
X-Proofpoint-GUID: fxeiMoi246JUMksqqFYi70HM-lQLoIFR
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b061a18 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=oFi8kr63Ec_tsN6m-mAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX47OIfZzMwRQU
 +1hQhCUXv2/+giME4N0mwDHh+EZTJt/bsxfm6MJy4oRWCuF/EODHGSfgOoTytetMttcz0LGKN3b
 e7lsIqOOonh6GLEtZ0AaN+DytnTI0ZF9sn3FxvCjz1QWrnZNMrhJZ/9es312rbovl2iDQNGyzka
 wCq12zK9EChNzZWFTpMTL0d9IkcLZFso3je7WjwQPsPdSP9af3G3fhkbLtDhPzFfydpEXmB0V8w
 dUg5e1hrI56jCXNPlUEpvQD8x91KAubI7NNKMkxc3KGUidhjrDS+EfZsWs8ISsgm4qm5WZ57vAV
 m26iuXWJeseY7i/OCwXjte+PY0svqTQCrCouq8ob4zr22XQnvw8xS53aBDfVm2ElkMzTPnCLpDX
 Kk6vd5OvY06J2tebvfIyuwCEWbcrxBbGzEaL01FtTX0Ko5Kvc41SJM1MPlxmBjan3nd8qe/k/xX
 p66ksgBDiQWtP7+Dk1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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

The check after flashing is inverted: memcmp() returns 0 when the read
back matches the image, so a good update is reported as "Firmware
update failed", with a hex dump and -EINVAL to the sysfs writer (and a
failed probe-time update for a blank chip), while a mismatch is
reported as success.

Treat a mismatch as the failure.

Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 6a7d479e86f6..8992222c6a5a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -691,7 +691,7 @@ static int lt9611uxc_firmware_update(struct lt9611uxc *lt9611uxc)
 		goto out;
 	}
 
-	if (!memcmp(readbuf, fw->data, fw->size)) {
+	if (memcmp(readbuf, fw->data, fw->size)) {
 		dev_err(lt9611uxc->dev, "Firmware update failed\n");
 		print_hex_dump(KERN_ERR, "fw: ", DUMP_PREFIX_OFFSET, 16, 1, readbuf, fw->size, false);
 		ret = -EINVAL;

-- 
2.47.3


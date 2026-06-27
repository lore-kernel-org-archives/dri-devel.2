Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD1CC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBAEF10E529;
	Sat, 27 Jun 2026 21:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzkntlIh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QybrVuJW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BFE10E529
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHoOXS1701101
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XxJ8BgvxnJnJe46I133iwqxEq4xBTP4CnjZaeRd4FwE=; b=AzkntlIhQ7Lba9Wy
 QuN8jv9XLkGTp2YVGfDLu8FTYkkrnx1iP8FmgwkL/m30X1K2824TiOgdDc7y25E0
 rVlKXqT+GDgiMliiLlDO8grIjgeu2H+AZl/xHYcWgr2sq89PT3ZmQp/OYYsB4YXN
 FEr6zahuXzDbYUXy3l7omSr4dqT/BRrXPD5i6B79+2V1zisvxBcDBUoV/TtAuakg
 Iyn5A4OZ7KL66zpHUIPS64YiOuSJQ/SVn76EB/vrDKatYtgpZWIWArthoQ4YuT2A
 CQ7LPb1rW6oVlIXawt3X39ZslPSHfptkXt1u9iGtY+hu1kb7n4+Yr1eN14nSYv0x
 ToGl0g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27331nve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30ba395b047so6979355eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782594310; x=1783199110;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XxJ8BgvxnJnJe46I133iwqxEq4xBTP4CnjZaeRd4FwE=;
 b=QybrVuJWLEt5C3LehKm2UCFRUD9p8ZwP1aUlNlMqsqm+Dzges66ijoogNQX+QolWVf
 H1Mpv5kRc1HQLPUfPkpA04Z7RrjlNnIRh885aW8rf0vHefMeC+6Y2SRFogVpSZa3Fk09
 LhtXU5Me/RjfyBMmyR6lwWacfw1+ahlrGq+sNBfWxVfLzAepio/VC2OHFU3lScbm5fKb
 UA41AcbL5p5kkMUB7/ggRYHSXOzIaHaytRH8ZN3NTUx/jNbgDsKa8e2gL8wcYntNXn/H
 UDffPWvst8sDq2lCEt8oDt/t5HrYulEkekQGz5ku9UI+vLrSIHthSH5BbvcAtZuekOLR
 4JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782594310; x=1783199110;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XxJ8BgvxnJnJe46I133iwqxEq4xBTP4CnjZaeRd4FwE=;
 b=M5rKL9FK5jjbcXSfVmVSIUJkKWR7/gFVfRWxTGXXCYoc2ujSHchVhDvzgufINTbgFS
 lX9rwKjMmz7w8MsI9ix4g+xKZpuBBlqotZC9P7SPhKGP/xHywAlAIChbvidD/8JLDAzN
 rWb0e+hSPeeeXoJ2OPYq3OtBfWBqRv8MM93JxBuwtghHNu2MOxl3vZmBQNiz2SGG8wME
 QGCIaeyOnbMfYKQevGBSX33qKsZqo9TszMuO1WIqOCFg6TviqMxcy6uG1x2LvUmmW9Tg
 UW1odig4JYepY58YffpnbebZKebSrs9E0DgVNfuyxPZJ+lyn2sRwF2XeuZ4nR57a7O9A
 CjPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+IfH5E66V9fo33F3GNLztpkIZH8WWW60Oy6ekfNhjiJj/S6DYVBE5PtTtpGoPci7jQ/4MdVZhfVQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz/7r7KKi8kzoV6JdmecUkfi6y02xFU4DNcYtqTQ7SHi29JkJ1
 KiBB5Le259+NIxqatsbQCD8GxvgcY9Jer4uOIOIBuVygsH4/p16kZGuwnc0oLQoMaUvdPOKhmA6
 HshFb5x8hRO6IfPVIJPTgw/nwWaU3GEzfgHn8WkBsBGntbUYiTlBs1FGynPopCFe98ZteFpE=
X-Gm-Gg: AfdE7cmE61/LlWvy6le37JUUAqIcjlBbtRHJd5ja0+LQXUxJXnyLtRWGcjpGwpJDLjs
 XzawxCE6d4h2y2tVyLEgNDE9WyVL2uSIx4Brk5SJRgjwVWKrPsJj/Gup/IjUQgMg7Ifwr2VkA6N
 bp+63SH497AXnH9ikjS92whrbnfpzI6ttAo9EHJ++Qqm3DyoZfnMMO3S3QCZmoxpQ8RMfAys+id
 DFwgFwwjFAWkHbf/mpn8XrFodOljl1bOzEb7DkeD3gGGfF+hoj5d6ET6JBLzfEVQ2Qyy3VZulwL
 3Nhybkdd+PwNoQqBRL9Oq+dp1KOnrTYA3i6Ig5i9vM7tfkDxUQN9pGv+u7idREGvVWIof2oOAwT
 9ZDEZ9qkdUXz88aDlzA8udmZcB7yxs3ZxpMjt
X-Received: by 2002:a05:7301:6003:b0:30b:eb75:8a5a with SMTP id
 5a478bee46e88-30c84e0bb96mr12179912eec.25.1782594309773; 
 Sat, 27 Jun 2026 14:05:09 -0700 (PDT)
X-Received: by 2002:a05:7301:6003:b0:30b:eb75:8a5a with SMTP id
 5a478bee46e88-30c84e0bb96mr12179890eec.25.1782594309281; 
 Sat, 27 Jun 2026 14:05:09 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm34561999eec.8.2026.06.27.14.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 14:05:08 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 02:34:40 +0530
Subject: [PATCH 4/5] drm/bridge: lt9611c: fix chip type initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-hpd_stable-v1-4-13d8b732c4c6@oss.qualcomm.com>
References: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
In-Reply-To: <20260628-hpd_stable-v1-0-13d8b732c4c6@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a403b06 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lwkqCOk8tsuKzwstaJgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: dz-2VKqH5lU2UYRtSHPGnOaVeqUROp4a
X-Proofpoint-ORIG-GUID: dz-2VKqH5lU2UYRtSHPGnOaVeqUROp4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX6QtUViLIWLRu
 Di8ei6XTOiSKz8nhVZyIsWYkCdQXUwb0kTv7DlQ0/ksMv2IezBYAjzWK+iQi753nSxgkphKPq+K
 qx6v03nqBVa45v1FyHdMM5gW9LJHc51Fbo9a6Iahv6pkstWBueANz+SDNJ+BKnA7LK2G2uK1UKW
 owqLy0jQ57hLtYlWnJGkuvx12UbBOVvmR6mdSRVa0Yv9cFnpvH44evuzCe+bZD/B0NGZSWU73+j
 aBMeKjwwSeRvJCZt8/wZ/3XM/DS2KzQ/+3LnQMQXEj6VWi0XastlG+VwLlDld909HbXp90UP0IZ
 jVyv0Zb2oNCUPm2HCrk16Wkw+uKPhF/0N/tU0Of2/G1xgJdN01UXpNrJKAp4R7KMdDYczCgaJ9I
 V0CO1vhXNtc1XHs2zHJ2yBsTmOMLN/0uxPwlDT6HaA13DrEisjWnDjdor71z9o9GMA6LGahrQ3H
 ArLaR2RK04gx5Wfx3rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX/o46WQKXguZA
 jx3rk0JnmolqXuH9xzj84WZQXhXGFS2/55xgEcVYNs8hv8DS+4XMslCX1RbH++0aL2hZicjCIqv
 ATqo/+Mj2bn5i1M5QsUjcSl+Fq9vlsw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270187
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

Remove redundant assignment of chip_type from I2C match as it
is derived from DT data when available.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index 4c8a3829a4be..d35a246e2d01 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -1105,7 +1105,6 @@ static int lt9611c_probe(struct i2c_client *client)
 
 	lt9611c->dev = dev;
 	lt9611c->client = client;
-	lt9611c->chip_type = id->driver_data;
 
 	if (dev->of_node) {
 		lt9611c->chip_type = (uintptr_t)of_device_get_match_data(dev);

-- 
2.34.1


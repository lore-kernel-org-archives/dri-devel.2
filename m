Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31732C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0DA10E52B;
	Sat, 27 Jun 2026 21:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dv52hyv2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TpYUhBDH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B66410E52B
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHnfcV1702951
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oSmQ9iy2HKQayEyMzktHFshcgJ0D0TLyzl5tyDtVnvo=; b=Dv52hyv21RlDQOa5
 01abtd73BIBn/XFpcOFiqcC5ytlvzudt2U/Bz4YiP1ONmVitv6JMBfX79+h99cZo
 cxu4W2Ut/+W4dT6fxA0hS08O57i6vd96lpDETkLuz8KfyqwrR8YEU6JgVY7RlwSg
 pF7DWmPj2KWCy8L5Dos0kw7DcedMR3F+reYTj/n1lGPQLsg0spEcLWgvugVL6aUy
 GJ0sqm/AD6r7JgqtHW9QA4PW5jDT6kdq8LHlQ2/N7JoaLR5Yu1TsTWix4k/bKMI4
 abxdM/Yr/pqEmpkucXVFUBrPcPsxeuvAU88ai0Yw20MmMpWPtF5z86NsoX6zSK6J
 7t3Qfg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27349p1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:05:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so2371197eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782594316; x=1783199116;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oSmQ9iy2HKQayEyMzktHFshcgJ0D0TLyzl5tyDtVnvo=;
 b=TpYUhBDH9F27elijIdKCD/jXNvIKIrPoVR8gfbgv241QmQ3u0HX6lZ+c7VEnxNGfYy
 LVIEiwDhMBNoeF0ghva3M4gZ4sNLEH+KF7s4We+Nzsg196Gut4ARQAHpy1Phrb5/3s6v
 /vyrKcTVgWcYU0Yn/aYbYz9sdba5iSdZYTMxhAsur1ZvlEs24YuEPpajpN2OCkcBDEtg
 wG2inyihwQRV/E7nRzOwZ24QhnyIcYeXwbk8BW+9HG2ABpTQPVW5ZwWAEG6BfLJM7Di7
 ZE+efEh4eZstu7c5HffUKz7wluErBbZb4BIsXAYCoYSDeUDa9zVv7dkq6m0ZI/sLhhVn
 UngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782594316; x=1783199116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oSmQ9iy2HKQayEyMzktHFshcgJ0D0TLyzl5tyDtVnvo=;
 b=eEqsKhCyLTJ8RdzdH/jkObSrdyO/3Ab3KrHH3nVijU/BCJ62byTK3ndem2qhCcA2Jl
 VWgklJBh6O9Hi16nqD/LR2kF3VuwtmZovT3tfVQcOII1zs1YlEML8Xl7zKGMwURjHMdF
 SXYAJPR+pI0sB38+TmwqY95yz1XG3bTdBQXgGMlV+oiexDts7k7owygktFfNBQOu+IXz
 AD/OEY6Y0GQRh8ymZuTvQB9zXLG14Ce8TCMAh5jUoCgeyhVcDrJecj88mK+Wk7Jz4QC7
 vhOIKuZFYhPMjw4I5c5RS+NrH04JG0tJUITfL1G+LcdNpqBe1Wc7Xlq66jvIGJIJ1xfL
 cLSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQBOreygJuXrrbHUe83okmW6MU4/y67TgjtXIGmGpeqtNLpuICWFfx6UPG0jaf8m78mwjODx8kzPg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDS1ahMjyBYq7lsPCZr20SWtZbX9+llEaz1zVxZ510R0Vc0mse
 aKBqRpiyUE2HM2MK0QX7cbvMbBLRc6LhMCLQmPmJ9zCYLjGfiJ1Np50jMWnEtTKXyg1by4Hn6oU
 /j+vBREJ4ui5A0C8d0Ve+tWiaS/HiDJCUzGtiGlA6iOqhLO1pHwNzxfncQpHWLF3Js5fmm+s=
X-Gm-Gg: AfdE7cntcHcQWGRUh8XOcFoUTp59iVDd/uUntw6/FW8r1P9XUiYKozarjzlpS9AB4YL
 vlF5sN45O0NHgZcMdzzIYCwPQhjjuwBO7uF+HCAJw1NM+jfzEvkLQr7ZDH4aYiwcePg5AeA9kfF
 vIlqdGetFpFMkPX0IdoZU53ZGZRzycUiVTApS9XzG2XwVH3TIZTGGOb3jhnTyqcFSULc5GzBy7i
 NNmI9HgvI5C5CZhsVN9JXMfiErNkky+tfoC1Mz+hacgUK1AGw7VMBfMQDMiw1mIWjoXcpeSMoMs
 Fuy0SYRvMfSBj1BuzRKTrt+cpWLapUahtdwLjaA5ABKHBm5GcRbcOiJMmBjkamIOR5cipkHD96I
 9Mtg1R8WNK6fWMMVXXsX5PButUnZFLZ7UEOKv
X-Received: by 2002:a05:7300:a944:b0:30c:a1ef:8173 with SMTP id
 5a478bee46e88-30ca1efa9ecmr5698846eec.5.1782594315706; 
 Sat, 27 Jun 2026 14:05:15 -0700 (PDT)
X-Received: by 2002:a05:7300:a944:b0:30c:a1ef:8173 with SMTP id
 5a478bee46e88-30ca1efa9ecmr5698815eec.5.1782594315126; 
 Sat, 27 Jun 2026 14:05:15 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm34561999eec.8.2026.06.27.14.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 14:05:14 -0700 (PDT)
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 02:34:41 +0530
Subject: [PATCH 5/5] drm/bridge: lt9611c: clean up probe error and remove paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-hpd_stable-v1-5-13d8b732c4c6@oss.qualcomm.com>
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
X-Proofpoint-GUID: Ndn0M-9oZVdW6kdHto6usBjIKnDq7MxH
X-Proofpoint-ORIG-GUID: Ndn0M-9oZVdW6kdHto6usBjIKnDq7MxH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfX3QccxECzIQgJ
 B20TrjPhnmkS34fuKQivhI1Sh/ccab3VO2bF/Q2+oenRPjcpxG7H3qj++Q7psHP7pN7+c2a3bWn
 5DbsAHQjSGxDjKiZYMVlkksZwUMatLw=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a403b0c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=y5bMiojGMRREAqb1X40A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4NyBTYWx0ZWRfXz1wPAJ1CGUDR
 RVMjcdV1p8hn1H+nsy2FoBE1onniAXuTYRlKB5UDbbObBCaDSvOOvz/X08XVfFbPwxEGj0Uekjg
 52RWBw4C+dqQa7ZRhAdrrjzH+gpSnLwFmUWqwG/lDN0Wx4Ff6FrnFJJVdt3swy8/5wOu24VVcOz
 aUCE6FpnkecqUVIHb+XhZ70Ur+ffkSflva7Mq3s+sdiEWCXxrG5FXM33P8IrFJzgSb3NuuFMuly
 q39JYqvbw/EVNxgLnlOKywhxol2qi7DwrUz0pL8tkBb+hUkoxPncCdEWTEOQrxKif8mD3taioYf
 2pmVk8BNlwwPNlJQs0YyH30m8RFH9/bdUO7y29aXhsYfeMQsvutrw7nKpBETKf+YdzlfgySiDEa
 Jf7UIL5Dvc7taqRhB5S+Tsd0MFd+zg2fvKxoPmNNHp+EKfO6mPoToeZqj0pW2yAEd9fIg7psiQZ
 9R3HqkKrPg2M21BdQ7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606270187
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

Remove redundant cleanup of IRQ and bridge resources.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611c.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
index d35a246e2d01..30828bb9b3b8 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611c.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
@@ -1234,9 +1234,7 @@ static int lt9611c_probe(struct i2c_client *client)
 	return 0;
 
 err_remove_bridge:
-	free_irq(client->irq, lt9611c);
 	cancel_work_sync(&lt9611c->work);
-	drm_bridge_remove(&lt9611c->bridge);
 
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
@@ -1252,7 +1250,6 @@ static void lt9611c_remove(struct i2c_client *client)
 {
 	struct lt9611c *lt9611c = i2c_get_clientdata(client);
 
-	free_irq(client->irq, lt9611c);
 	cancel_work_sync(&lt9611c->work);
 	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
 	of_node_put(lt9611c->dsi1_node);

-- 
2.34.1


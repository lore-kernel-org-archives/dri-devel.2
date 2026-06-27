Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5706BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DA010E519;
	Sat, 27 Jun 2026 20:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ll4PDjc3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jh+XCidn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF0D10E519
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHoOH41718772
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bBK0vTWlhFC
 CNtUWJ1YrElmwXHYZPSUBiQlpdCF5gcM=; b=ll4PDjc3laz0J07ga1GNk5J7E/F
 XsbmeFdvw8x7EepcC3AocWk5egBnw9u0ku3r2AomaoAbmpMpSUpmV86ir4K+7xRN
 x2OBOJNbwZaILaMOIpUOj9w6FfR7c2Ya79pIB2VC1aODSyQJrrcUrgnwuZR7t7hS
 cQ4dGI7go1Wjs/yt9eSR0UZjfZcA5gZo96osGC9Cq29xyUaBzI4bNeaPrFKn1GhL
 6pe2I3dS6J/JOlJe9FnkL3YUfY2ytKp3hCBOyiS0J4UKNQdbAVPcC9jL0MOJmsr6
 PEqrDAV/qrYUUkty501i3tAu/8MPj4p7SpnDVe6ZF1kVKPn9F8orNd8JsZA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27081nvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so8220482c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782593053; x=1783197853;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBK0vTWlhFCCNtUWJ1YrElmwXHYZPSUBiQlpdCF5gcM=;
 b=Jh+XCidn2UXDo4fgp2nZw/yCHCTP5Z43FrIg2VlvPPz0pqQUbGqj7FWHPABAZ9ynFa
 Lc4wCuNDd+wttDsMOYW+2a2MUg9WPvQ6BEZMniRjKGTHNZXQv4FvhUmzAWjkbdNQLbtS
 +XyYF5HgWWUld0JxvhY3R5G3lOlFl99rtdq82cc52+k0gq3ncpEl1nfjdPO1wfwKu4kQ
 1F/UW2NcuwDyzFj0XLKz3s61FETOHRvqMyqlLp+HofbGo+OIHcRfFc8tC15NXZbCNALe
 HMQTv86QLSkAULbrcFZmfq5C8EbolK5UcXU2yMPWqvNnDmkeOEyAWj3ZPZkCPdn7Y2ft
 WtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782593053; x=1783197853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bBK0vTWlhFCCNtUWJ1YrElmwXHYZPSUBiQlpdCF5gcM=;
 b=L+v9SbQoUnNwRluKlWMMRYVer8d+flxfRrVg48A3J87mURDXCRdPDzOuCfDF+C06DB
 Jm6ysY0SjZVWZ/wUmjKlmIUGpnkYfPYWIqEeDoPGoHJfNgmiprs9sYUIJO5ym30GB9Bs
 VVE37QIB8Ts+HrzvyeOtyYMwgC/pzt+kxrabapDpvshDloa+RA04yZin6oCuFdU6vFCy
 DeJQcH+lltihNG4UEbYM/GkKtAp+7SR+YR6smrzlgTJ+h2WdIgSNtaudEgNQyRRuHzFp
 KGjp0rB42iQK/eejWGYicnOjLtYluqWOmHb32WphnqaEJfmjYlV7EAIdOFix2c4CRW9O
 V7ZQ==
X-Gm-Message-State: AOJu0YyFE1pWfzoc4TbPIbvLqUfLVmBqAC1FwXi2xYpeEEyLsVl9P9XS
 Y3fdEYwvRp4nTg8AIhn14Q8mDek03d68e7C+E0nwiG7+Apqtbda5/eaqX+QWjVqbqYhs3PicPlp
 dHa0Je8kbwbm9u3jJOqgo1wwpAdlnOkR9GwRKkDyc5aZJctkWKeaLYfwsMOavty1OYCdvZFM3X9
 tPsMo=
X-Gm-Gg: AfdE7cnIHsJeB4l+0chAb4rWb9zNEKof9ew7U2e6uWhwvUXyV9n5ebPVUEg/rU/wVp0
 DaXmDioIV5QFMYVRd0Ae0r3tpUZGKl6e1IHDaLso0Nhvgq6py0QAnU80qcErLWnYa1/tL8dsIyt
 /zQdXTtiTEFKkHWYsLKVlHRBLaLdHO2+prOWP9WO+aEEIFL3xTb/fAQx1vy4+l4dXprwyLBjesR
 bwZYAJy3326zim0k550PaQRGUn5PFKgIIkmY3D0+COzEL1EuTcZdePa/pBRHEUWSQchm4NH+NU5
 uHN2NKUvVlTtqHEFF0kRvQDXWdNAHuYQ0hUSrLlB4kghGU7VkhMX9dyi0KWYgZVNRJT+P2TtUCe
 bVyUsWCQTIN3uDxt9V5e6b5KJtI8BTZcSSy4E
X-Received: by 2002:a05:7022:6095:b0:139:ed59:4b77 with SMTP id
 a92af1059eb24-139ed594c08mr3916271c88.39.1782593053251; 
 Sat, 27 Jun 2026 13:44:13 -0700 (PDT)
X-Received: by 2002:a05:7022:6095:b0:139:ed59:4b77 with SMTP id
 a92af1059eb24-139ed594c08mr3916255c88.39.1782593052697; 
 Sat, 27 Jun 2026 13:44:12 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm16882963eec.6.2026.06.27.13.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:44:12 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 5/5] drm/bridge: lt9611c: clean up probe error and remove paths
Date: Sun, 28 Jun 2026 02:13:57 +0530
Message-Id: <20260627204357.3336040-6-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
References: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a40361d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=y5bMiojGMRREAqb1X40A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfXysDUgwN2zw7v
 qjVa8u4RlSRLkLGqLVLv74MRyiRVxTrGchybjbqTc2ziAgO44YDWsTbVAiURRL31LqyXduUzQLe
 xLkrYlYFM4B4oqXOlEfRCj4UWKXdb7sEg5nrlpKo/ihZu87KFz+R648+RXhg7mGA12fN7MZ/k74
 idlWbtrkK8onkwI10DTBZbg0OB9xql4No2POarUaDCtJV8yRb7e2F3kG1qaVDZa03vSMVzkHiVb
 xwlPfQjcQpP27WYkQ4QZQgwpyfIb0LOEHLQoc/5FosXjK/eB/nnmtMExj6D5n6Rmhv8YFxJ+WcT
 xGiamTk6/FJqleociPHqqi8s2UoUy5HB/omVt5s4lz9NxRNdzNhImTNFkmEbS2FEc44yajjnIZX
 0auAdPYadHxdVdHtVR9TZXPWX61jEuF4qiS9wheIZ53NY4Gd1pgC5/fWfGuwRL0DELc2EvLF8zK
 xC5ERZ+hXPwlGcZxqUg==
X-Proofpoint-ORIG-GUID: nsmuj8aHvPhPFaIpszTYHRNwQH-dlwZu
X-Proofpoint-GUID: nsmuj8aHvPhPFaIpszTYHRNwQH-dlwZu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX47QEH8gVdgtH
 QbWNSBPwok9PW5dcxCzQTUbmjrjcp/tJFHL2SfWmyQVP2sirLTVTV6q7lnB0vR4sOyuVadpag1c
 bofaN9mtuYZuRXWiA7YII2JODmB+PH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606270183
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

From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

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


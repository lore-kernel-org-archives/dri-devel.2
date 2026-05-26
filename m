Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5C6CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5908810E37C;
	Tue, 26 May 2026 11:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieXacd1k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VvisURFs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EECF10E37C
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8ANjZ691606
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WnPeFnYm50V
 ptjiqnHaSpsB7Y9ad0zWN9mmwwejDdiY=; b=ieXacd1kjQV1C42FyHkFDsqQtEn
 kACdYNlJ11If5SV3Y/M4Dgo7reYLEDmuzrOHpOr8mmkJagPuU9Aq77QCD6t9NUcx
 OSmhMJKJ1CKi5nd6oyhuIUXgbLG074OF7LypFU9R1tfGSpUN+Iq986bMmRKup0pb
 dQtngw6iS0DpDoM07RzyjCB4dBcbAehKxFwCtNobXxwNGkrXjz5zlEegf1hG4IRu
 4c/Go+4HYcxY2YnKsUrCg4iFBxm2oSMamiZLH5IEEstSNOWEva3sBRAvjjhqC4Sp
 YADyAD4PRqD5qb0QZL+noTk5zmS/otzW9K5pogRrzgKkMxZtm6+Kcl9qkcg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2ktar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:11:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-366344513a3so21156420a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779793896; x=1780398696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnPeFnYm50VptjiqnHaSpsB7Y9ad0zWN9mmwwejDdiY=;
 b=VvisURFs/VckxKMk9kd+PIgrzr6l3JV6TE6ahy8DFpPB1WxRjXygUclME3E6V+nQ5C
 5llJ1JDHT9TMwiI1yoTIzHhCzubetrMgSD3avFi1puDn8wPH+h38mI3gsMo8qprYTExk
 ZYWwD8PTHX1ktk/NUCQdiqff5R9NfyF//wQO3PzynPH7XVXqAM5vDsu15WOfumTSXfce
 nd08ebFgTVJpRBd93H4QQmpMkqZBDoe0SyibaeFPJODGpqyUkIkBiX99xGO/vvzO/mj4
 Ondpou2etOYnmF79GROdeT+3W/r4HqBAFI4xkekUSc3oH94I6GN4cYQHpEcLIR48aju/
 VQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793896; x=1780398696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WnPeFnYm50VptjiqnHaSpsB7Y9ad0zWN9mmwwejDdiY=;
 b=Ed34/h4LiLJp6tJfNF+GXdJiRUPuOOsvbxHy8BO3nX2zCY4EQSIB/rF0V6CjMVB9os
 LQGqpUCakTiclrKoCNGTM5Y5+Ki8PRrAjxH+JlN9l1Bq+gloCXXKGlBbG/3aiD/BcARM
 Q2sNZuKcAlkJ/XY4OrMOm6w3orkBnIDWNo6V/biZn2pCelKby/YlXIbjzM5Y9KmnYnN8
 5i3JaxVtN3e7dweNx2gZIdEq1SkrDk7yR4mim5diKzQ8IeaymrcDlkMsqW+KzHPn0zqB
 B1PAbJKzGhMkXX3bP2xbbT+BzZYvoDR0zaI7Zrcrjb1VXqmewesPKENYRcnFU6l16E0o
 026A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wYB7re6fxRoEBh+bzZQcDttnOE5AiIW8UL6AzWL2PTro9nbSjFAHhpJAAoSXMh0rdEyOQOYkgbA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGtFH/ty2kKfIBcXs6rQ7rRqfTnCMtVMl1qFcFh7Jh7gpHSe8u
 NBJcsFlIF+Y7TmVj4XgawAI1UtdPh96Az/K2mjMmzJnj8EqiqBmhT8iEbHC51tthRgJo90QLmIK
 fkYxtpX8GshlSrFLaHa41RF0M0DOZMfJ4HkyZPP5h/JNYGG3oF1jArjdYCBO6H10dQoMSSpc=
X-Gm-Gg: Acq92OHMhpn0kp24aBd67g36NcdialNY8ZyhxYu+AQQiZxAybIBT1IUlbZ3+g3CWpYr
 PC4zd0iJDneZTUFzHfA8aykXHCkIRprT5rA1PorFxKscE04uuASMnkh17w2tVDjMLtlH2IcZhtW
 0d6+5c3PYlqDj6xdC5x7hiVOMSvy+Lua+O+3co9FFt9I1h8dEXmJoAVeCPtlMQNYy/oQA+TVDWY
 fRJSNPbHx2Jo1mcmFNGZJXimzqBn3NgW3rBpnHk22hLrd3nH36spoT7Vz6D3063ewmdj6uwS2Pw
 ii3SGo1DTEwaDy0krqbzihgL46Xl7nRcGhYtpKJt6wAIxW5ED/w4N3Y3psyNRvXdl5bxm3M44a9
 BpHn65ZOAoskWa5KhcfutOriTkKmiLRDSTSx4PmqYZaDljVnW9CLo0ZtVyGgbMps0IBXrn+Lhee
 l0sFnBq0lGEJSwMv0V6w==
X-Received: by 2002:a17:90a:c106:b0:369:7003:4e2d with SMTP id
 98e67ed59e1d1-36a676090bemr17128813a91.17.1779793896392; 
 Tue, 26 May 2026 04:11:36 -0700 (PDT)
X-Received: by 2002:a17:90a:c106:b0:369:7003:4e2d with SMTP id
 98e67ed59e1d1-36a676090bemr17128775a91.17.1779793895824; 
 Tue, 26 May 2026 04:11:35 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4ce6bsm12104253a91.11.2026.05.26.04.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:11:35 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable@kernel.org, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v6 1/5] misc: fastrpc: Fix initial memory allocation for Audio
 PD memory pool
Date: Tue, 26 May 2026 19:11:20 +0800
Message-Id: <20260526111124.515-2-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
References: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HFSkcNKz139NiLSpHbcwZSn9XMvU7ci9
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a157fe9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Rm9GPb-2FwNFOyaWfJMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: HFSkcNKz139NiLSpHbcwZSn9XMvU7ci9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfXzNOYQbqpXxz1
 7YR1PtwErb5wcTrfYK6kXeXK/CBOmPSYG6VHwqYLuJcJllQI/MdWbWFrHFyXZQcf4GhG1/PfE34
 A6Gbc8DjCdGGZXbEuOJPcMbnrQfXoH9GDtEk1UE/3GSsdqQYCUsX1VlKXca2icfFZvKbdZ2g9u2
 gh+AoX+f7UJekLJ9jvdPuFkoCu0PeEroGfD8fuA8DjD0SGb8daLfCjqVPnNSzwn15zOkpYoAx+d
 nOYRAFoguDDkLh39uj4HbcIatLpmDPKlAoJjvNIr5rNHXLhStYzm1gURlTewsCM6RJ0oTpsU8zG
 Y2LbzVosjsvc+1Q5dFE2Jh4DbQhM3/3wm+rqnYYhpg2F0oCqk9yQosR6wv/ZP6NWd1oq9A51S63
 z2bUYCVLSiEpbTOGdDr3UkyODthsHL3SXeWaEqzdt5H+gxH4hm2qE912IMXh6s2Zej/uNkyg3Ah
 uRqRUZNqzcbD/pH8jcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260097
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

The initial buffer allocated for the Audio PD memory pool is never added
to the pool because pageslen is set to 0. As a result, the buffer is not
registered with Audio PD and is never used, causing a memory leak. Audio
PD immediately falls back to allocating memory from the remote heap since
the pool starts out empty.

Fix this by setting pageslen to 1 so that the initially allocated buffer
is correctly registered and becomes part of the Audio PD memory pool.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5524354f3ccc..80a636962357 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1373,7 +1373,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		err = PTR_ERR(name);
 		goto err;
 	}
-
+	inbuf.client_id = fl->client_id;
+	inbuf.namelen = init.namelen;
+	inbuf.pageslen = 0;
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1396,12 +1398,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 				goto err_map;
 			}
 			scm_done = true;
+			inbuf.pageslen = 1;
 		}
 	}
 
-	inbuf.client_id = fl->client_id;
-	inbuf.namelen = init.namelen;
-	inbuf.pageslen = 0;
 	fl->pd = USER_PD;
 
 	args[0].ptr = (u64)(uintptr_t)&inbuf;
-- 
2.43.0


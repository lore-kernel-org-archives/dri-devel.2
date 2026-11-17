Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800E606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K5EX1VGn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAThtIDz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D0610E58A;
	Tue, 17 Nov 2026 09:40:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A1110E58A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:39:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AH8NFDO721412
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L/i7IYiuIaVVWbjkdWvvY+6fiNJJwG9zMVxNqhNCzTY=; b=K5EX1VGnwQ0lHazX
 Qn/VB1nIWA0KwSp42sUqG0nCachWGe7zVf6S6RujqTdQ60QB6tU7WFT3Kq6Rh7jb
 Xt2zUSkwApWzF5N6slRgZUlGIalfmVJNXPh9/yIr0Ns6Sjz9U9s2Rvt7KzTfgHJU
 XFu5wAnAiPGUDW7s7elNoC3oqmQjhyKQoKtXoxGb5pQfJKvvrZ84p5xXeBh+WaR0
 jAxPJddCH8d9YFIEJyoyn9Pyv42SO7lmDb31HJRklDoVasfcHHpFsS/CaPEhqSiP
 cGQ9dM9+qarHoXyS4NWKIe8EKR5RIU/VYCmUGf6cQEoEYBQOHZaLsO/+5S7PVq59
 DUSy3w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kcc89ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:39:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cddc4bde4adso2159107a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794908396; x=1795513196;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/i7IYiuIaVVWbjkdWvvY+6fiNJJwG9zMVxNqhNCzTY=;
 b=SAThtIDz9BEO4dexuAR9YfPaAlbt1V/EzgfzNiLvoAC/rbVF7C7svf1qhNrcSFuCXu
 VFbKzpKpYmyhLzLsUv0bxxg4i9cVhDVARlZ0DIJB6ROkMBrgBBXhpfYRGudWgVkIylQJ
 TY7GMb7xp3/WrAAUGEPZHoD3CYe4c+AmbZaBHsGs13jzDDW9/6YQOs/DzfWdgsa1TEbC
 N+mGu/n3veeO90mt69pDOZ4WlZTULHYallIsHN8N2Ib2LmDCB1pkYASWcQOWTofYriKy
 iz8sWjZCQxO1iT7KW+odeclvniEiUEvUjySTyF1ZVHdAfAu9mH2Oh0tLMn9eKK4J1747
 ar0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908396; x=1795513196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/i7IYiuIaVVWbjkdWvvY+6fiNJJwG9zMVxNqhNCzTY=;
 b=YwLj4fxpoMnfMCl0UBPUpd76NgmxLPPXg1Qt1N9pB4ThaFZ445vTVm2AqAAs5tfP19
 j8nIOS1mkARn/DOq4BxKB2NxcMqBZQGb1NGpwZDspvZnbhRUAlOYMVayhOZxmUnS3luH
 0aPPS51okkp3MtoqoOsUVfBar9WXHOoYIpqGpkQSrX4WVeMu65yAsWtLHwbxX8ujhNn3
 1LzTsmFH6vC74E9z039porDQpB9GTYhKO/7K0P+4Ya+C4r/zEuGDQ7df0LwLxw6Aehmi
 sYvN6tkk2Le7sma/ZygwR4ejHkuy7U+W4uQb7UQj64RmN8H0AsAi2Vcw04FsMdig39od
 PL6w==
X-Forwarded-Encrypted: i=1;
 AL+hErHJr59MtVeyRTv+303qZlzWmhbUCANWBQFg4AwWTj3Kj5yMVOT+ivHK4yzGAnjJtQnb6tP/KYA+fsM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PQE9wFmgpZTLTe2EPVdED2dxAoz7uklvXmQEfPYphR4RW1R8A
 tIahP/1IKBZnSytvdhBjABJwa7GKnBnKJt9cLyiLKMnc28BU0GX3KPvtfEmACxfxw8wIK0WfuMQ
 9yBNo0dw5sTeuM32LwwWxojz/PjcCsb4ig+pNoXD7gB6lzVrxdVoVxsZ8OP7xn7yigcgXVEM=
X-Gm-Gg: AYBFou1vu9HGsjtjcmo4eLj5p0KzkIv5yh9bbYNpyXxBQxbpytTGOD0H26LphzD7z9q
 qN7mVODhTVFyWX/jLyEEQGknUqieaWW2Mo8qGzumcT8d45mgGH7TBFZJ5nL3ojcCKcKJgUNf5es
 CtyR+aWi8TygfvnREaRU+KQYkGo/dEwEgb+6kxOh/lOkShieuDzws5jQdB4Hw4vhthiWscAEWiH
 y1cgd+akS2xGDNFUqyEUVZFt0J0c9o3vkRB0dl9TFBmcHl59DGXqgq2Qpina51HeGU/tKqe244X
 tBM8E3Nm/HrV7jdnO164cCYr+92VIVET5cpowm37eR3Q4sLHby6IdjCO7MDHYcLRZwQA8uuRn1/
 FHiMrahxzmY0dSi3twEtDAQc0IoobkaBlARRyWsZxQi4lp1xruIRiyqL7Vg==
X-Received: by 2002:a05:6a21:200a:b0:3eb:aedf:a93f with SMTP id
 adf61e73a8af0-3f7a81bc2cfmr10369231637.47.1794908396088; 
 Tue, 17 Nov 2026 01:39:56 -0800 (PST)
X-Received: by 2002:a05:6a21:200a:b0:3eb:aedf:a93f with SMTP id
 adf61e73a8af0-3f7a81bc2cfmr10369219637.47.1794908395509; 
 Tue, 17 Nov 2026 01:39:55 -0800 (PST)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc160bfabsm5299078a12.4.2026.11.17.01.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 01:39:55 -0800 (PST)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 15:09:45 +0530
Subject: [PATCH v4 1/3] misc: fastrpc: remove dead context drain in
 fastrpc_user_free()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-interrupted-invoke-v4-v4-1-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
In-Reply-To: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfXxUib9OvXD84y
 BkERHxCf8JTBebO9ZuVIzay1XzaMPevc7cobEO7W8033xE4+jtSWFVO2GfYDMSa9irKXTXwyCcc
 m8PJ9Z5xkjEZYjgBbl6eBGW01lWPcPo=
X-Proofpoint-ORIG-GUID: 8Br5O4ROSE3smpsybJqyz2_8CmyGaW8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzOCBTYWx0ZWRfX+dUOylBxmmPG
 0RYktcg136G5YRiEcb7BdjUMuqEmnk8B78oL+/AxHBMHZvDfKYzmfHgqIs2ynAlmRnOqrxOGkmw
 uMu16rumnBnEfJSdblJ/jrq9piGoi4brCQLYSrDp8MB7pJG9GqGcZY6uhNgWYCUTH1PLzgt1Ic6
 VXYcqTe4tBQ76U7ZRoiKlV0cjXE/CT9roq8AvKZX1xKgk1jllJ7P6fBBMrZzejlnUeDlJzfLh7r
 B91O0mHoFMKjfIPwwGVdjQSxspJD6UxNAaN+9ILxAfRSZBKzZB2CVODbiSz+xXiTLNrQoJpD/bo
 woxc8Vc/caqbnVFEPvMWGS+p+arF934vFtd/fCTqq4LmxszFB9PSt9dcKSfn1LxY/8U2sLAq+pg
 3A+vZ6CuYJ8ktVh+/b05hNv/uNrt44meAUxre6t3+WOmZZ1O5eZ30Zh/DvRJvx9dTyK+wjkqLqj
 TEni5667yUyWeMbS2gA==
X-Proofpoint-GUID: 8Br5O4ROSE3smpsybJqyz2_8CmyGaW8g
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afc20ed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=J-4xhamgBsHxLUkLQesA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170038
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

fastrpc_context_alloc() takes a reference on fl via fastrpc_user_get()
for the lifetime of every context, and fastrpc_context_free() always
unlinks the context from fl->pending before releasing that reference
with fastrpc_user_put(). This means fl->refcount cannot reach zero -
and fastrpc_user_free() cannot run - while any context is still linked
on fl->pending: whichever context's release happens to be the one that
drops the last reference has, by construction, already removed itself
from the list a few lines earlier in the very same call.

The list_for_each_entry_safe() loop over fl->pending in
fastrpc_user_free() can therefore never find anything to iterate. It
has been unreachable since fl's own lifetime was switched from
file-close-synchronous teardown to kref-counted teardown; it was never
updated to reflect that the list it walks is now guaranteed empty by
the time this callback can run. Remove it.

Fixes: e85eb5feca8e2 ("misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context")
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9e760f68bc..bb0c304196 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -568,17 +568,11 @@ static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx);
 static void fastrpc_user_free(struct kref *ref)
 {
 	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
-	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 
 	fastrpc_buf_free(fl->init_mem);
 
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
-
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
 

-- 
2.34.1


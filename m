Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B597CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB57510F4CA;
	Wed,  7 Oct 2026 08:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pogUkvGf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6OBkV5c";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1141310F4C9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:45:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jd123194040
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 08:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AlccGoJu5Sh
 8UcW87OTOUg2Yc8FQiJCvyD7DYkY7fd4=; b=pogUkvGfEg948zlTB2IBNAzfnwn
 aDMDoyAAnvFd1u62vcpjdOQQx0m6pcBiJjA2nZBQ7+5xkexUKkUvowpaD5xBwDFZ
 AkiKgl+f4Zgp6Ja2bIXyrC/t6t9GtZ3AGYClskhnrndSqa9QusVJQHgHtEjQL/tq
 Ivk5xTjhdIRY0rVM/LP/smG2FHlEK/8K/eQwjx7RqGa18oj2wIwwg5SnzpHakO6y
 9UI6TU2eCVUvUm/jicNt3gjP092A7GsT9OcxefOlXkJH60Lz+FYdmsJoSu4CjakG
 47b7Wix6i/xB2+8Q0IsqU3Ae0ycARKwczjHVBNzLhU4mS9a2+BezVmaS8Pg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541ukf18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:45:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso3711534a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791362703; x=1791967503;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AlccGoJu5Sh8UcW87OTOUg2Yc8FQiJCvyD7DYkY7fd4=;
 b=I6OBkV5cyxuOzKO+y9IiG+JkIV6I354FCdbO4Bu4gGwPzwQ8eeOyMX1CsxTpcVtptp
 9W5ytlJ2JWtRdNdghztQuBu01/t316IMCmC9X/k78J2K3vOZuYvW+gbTXb36QJhXX+Hm
 lggHI8FIYhtjPSOOtWU4TLDXX++EOcrYmyMpkE8gS46//pm8KHW5rVTru3fT9Pedm1+c
 w92VT8brRJi71d6CFRnwTskHY7c/xg0XYe7j69vSJU126bJDHAj0KusYodo+Uw+KAG85
 /uJ8xJFfyfV/xpAlETYBRy2blU7vZKpQ2xHgXKaaPDC9rFwWxhlqPDpaQiV/Z//oSuz0
 C77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791362703; x=1791967503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AlccGoJu5Sh8UcW87OTOUg2Yc8FQiJCvyD7DYkY7fd4=;
 b=Il/dF/sVyZSj7QH2/NK4o2C1tszQu2g/1mJ+32FOMybmHPfq5Lj09Zrgdh17yVb3bo
 EAMOF4awEatCwmftu7Q7JhTiRc/30YYbrPOH+oCfkpYPEZtEfleHxaZecXoExqSjsw4U
 L56qx6gDVjD6XGEj4yUKyO2otyw7GWVQCOBFnW1/MCTO/bxBU8El94ETv9PAfaE9dRUP
 1o3tvVsKNBhkeg/ijOLr49G/fo9gzKtm11F3HBcoBcthjqosCS+iq9Tm8UmKi9SbvufP
 URoTgde8sT13UmCT3gj4dy15+hxBIndOo+t0EX6G0Q92IfCWkMv0Y1wGpA/vCoBRviLj
 FMlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAmxA4jcVmgvqwIu8WvPMMuNWoRqV0dU8Yq/HicpuvXOyg3R5Fuar3nRhICjZ/8RgGaQbAlDRoq6U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mwTjE4w+58U0HvQM5QqLEQ7IpD9b661z2hXUuGzY2KDZOjzqq3
 qHO/Mqp+lnOse9b0PslFBTf+0H8qTeQdU6M6dF5coQ8MZ9sEUE5LmZUxfM3dHy2Im9R6b8JYJGv
 2G7fcozTKW+3b5TZLAFGFnMz3kZqWGfhil0k6mVup1p67G7ypDLf/EkcdhtinzlZPJMV7uB8=
X-Gm-Gg: AYBFou29myaO3ZhUX8AHEhuv2u3aNSAusSlL9751BfZ9MTzVTYzrCcdGocJLT4KgFgY
 VRYzn4o0NePhvJtpb5HUUR5eYZNEqBN6JWGaLJUw5kJLDvV6/AbmZlUL4x+DFxWtybxFk5vC92k
 kTiPcPO3iM6jp5srQv/YoT5cjkpifwXczZMXpvv16tAnydzOVdNPtBR4ZbOlwvW+z+UG3a8Garg
 htkFDF8lHUVl4P+SHoRloyLR8uU+y9cpcA4ueeInMdiTkbCiheWOyi2KV13G9V9lrQnRZdfjHZM
 1Y/3WGhSI/X4SWcTk3kn+qFxv6p4j1sDvPDIiXAQPO75TZovLzUx383rJP3iNG3OblONFvx7N0y
 Htyzp/gMMcJC5XW3mZzc5tRn+mJgTVDKrK0ASfjej3AG97CJWoP/Sr+E/IGQDEXqrE4cG0nI=
X-Received: by 2002:a05:6a21:32a6:b0:3e1:2632:ead1 with SMTP id
 adf61e73a8af0-3e1340952e6mr1635439637.43.1791362702860; 
 Wed, 07 Oct 2026 01:45:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a6:b0:3e1:2632:ead1 with SMTP id
 adf61e73a8af0-3e1340952e6mr1635424637.43.1791362702508; 
 Wed, 07 Oct 2026 01:45:02 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a8b0616esm1075091a12.6.2026.10.07.01.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 01:45:02 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: [PATCH v1 2/3] misc: fastrpc: wake poll-mode waiters on SSR
Date: Wed,  7 Oct 2026 16:44:46 +0800
Message-Id: <20261007084447.922-3-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RewSx2M5N7L4i0GNTrokK0EQtxW8FdS8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfXz3EBokiGum/g
 fgDfev6NWwCpF+Oav9eoN0vb1y5b3525bBm5Kn3nrYZ7V2uO9cEotMYcT5+3YhThyYRdU0FVGvo
 LQH/Ffz50YauC+EhbRS6FJV0jp4ZRcE=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac6068f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lWAaA6wL40FgRWs9ITUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfXwBPYBoYfOQFn
 C21Xoin8w5MzmZ+DtWTddA37IV0toLfalv77fR0JkMuisrmkAfwVSIxwntjGOEcPsw89w2Aqwzx
 e5NuJIFmUPAv+rlpdnGO/iULv5clo1y9Mh6+44okQpFEiu6+i92w+ZXvTWJbqqYMHUDzXHcM//D
 /XymbkE7QW8+G/eqtL/uJcjx3p1yxbUSRbsD+vpGG4WgOiyT7SJiR9zLM7AwNWXJ0oWdq3j0s+l
 olIMvU7pCNEt1MMlOnMfBShaQ3cu4D5gZgQWmdHzAwwrWlgusgZ2M94nvwXOFRP0zLn+yUAWDyi
 XrnDRHzuxnOQx9qDCVs4lgA4n0YvJoTeoYeUk9+pFS4CFp9/caQEKLb52Ue1ByGaYRb/+oWs88k
 K52BXzctmubJPSrYZUjtoi6IBeWeLB8gB+xe5rfcX2e0Gxp+rOvPwJ/Dko8o7Ci3LujSuXK7XJK
 TMYiUkSNOWzljEG+86A==
X-Proofpoint-ORIG-GUID: RewSx2M5N7L4i0GNTrokK0EQtxW8FdS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070034
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

fastrpc_notify_users() sets ctx->retval to -EPIPE and completes
ctx->work for every pending and interrupted context, which is enough to
release a thread blocked in fastrpc_wait_for_response().

A thread using polling mode does not wait on that completion. It spins
in poll_for_remote_response(), whose exit condition is:

  (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done

Since the DSP is already down, it will never write FASTRPC_POLL_RESPONSE
into the poll address, and is_work_done is left untouched by
fastrpc_notify_users(). The thread therefore keeps spinning until
FASTRPC_POLL_MAX_TIMEOUT_US expires instead of bailing out immediately.

Worse, the poll address lives inside ctx->buf, so a polling thread that
has not been told to stop is still reading a buffer that the SSR
teardown path is about to reclaim.

Set is_work_done along with retval so polling waiters observe the
termination on their next iteration, exactly like completion waiters do.

Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 05b2e7e4ad3b..c54c450cb571 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2663,6 +2663,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	spin_lock(&user->lock);
 	list_for_each_entry(ctx, &user->pending, node) {
 		ctx->retval = -EPIPE;
+		ctx->is_work_done = true;
 		complete(&ctx->work);
 	}
 	spin_unlock(&user->lock);
-- 
2.43.0


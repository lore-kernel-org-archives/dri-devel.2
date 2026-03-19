Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD351075262
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FB110E861;
	Thu, 19 Mar 2026 06:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fkZp3sUq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hG+FUBH3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7522810E861
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5XMUf3573721
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ql/OBlsnmzWsbfZsETPUc9XH7il2mDmKIxDrs/rob/k=; b=fkZp3sUqKr59AwKU
 3uQq48p13b4vR6gBonGwvBmVjwn5n/YYbgRKQGX/vBwXiktFUhq81HbCwNCW7GQx
 AdJs03ZGTM2ggM9Ddue2sEYze0QrekcBpIPDuNn7Ltkon6+8QlbiKXCY6n1yinIk
 7Q/ecDZD66cnqUXbXDBqF2m83V4D9ky0+88t9zU4Zx66m1bl/YWl7wQMlgRyhDjA
 FrnWi+RtiXSskMjCJU8GZbxZRXIz/m/QouIEaYH4gHB2p7aIax9sfstropJL1srf
 i3/C0sB0dbhVo+s6P9F0xG9R3rMmVg6qeZgTKbfAyH6a10Tm31j/HtI990NGnQy4
 +/BQNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r8nd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b069bfa817so10005555ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901920; x=1774506720;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ql/OBlsnmzWsbfZsETPUc9XH7il2mDmKIxDrs/rob/k=;
 b=hG+FUBH3akq2xFc5eqJmTTTkE8tafvpO6k83lsXnbXgKJz/zCEtd16F1x7dbw/H0TH
 4k5+4z5xzi+N5esAsO6tKh3SEvyr9l72pvfw8pyfIDZuB4McfZQIop22t3DtQJ+SmMgz
 UMv0NN/97zhkr7nCqzHvg8m5RJvKwEH7puXhVVee7jyvtbq2fshWTOBFLaP8qMrEBfSG
 85wtZW2i3yriRRZ4ZMJ+mBt8axzLbiOxieu0ngfB1d8/ztH/xuwZdyOYo6fcfGgZ8dSo
 sWip8EPVmrFFq38uJ/Iow80x1Jw0QlbKO+3NoJbGXy9XPAX/Y0Q7nqSd9b0amTVWY008
 0E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901920; x=1774506720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ql/OBlsnmzWsbfZsETPUc9XH7il2mDmKIxDrs/rob/k=;
 b=GdfmLEDrqAbvSOeiLIRjL5KVhMru4LdfNDweIIqGEaD8BJJ4REttOM41ONG01bg32j
 WniWq8aJODGdfmNJ4HNPlutsdp3KY4EU21ZlFo2PQRzeaeXvuziBPzviOEzf5E6CYfG7
 anqn7sazEXegbishTUps8GEZFhTo0JjB/Lty+qWlqJs+7+yML6bw5QGrzfQyAOV/KM7X
 m9RYCHmuG77gMPd3qiJaPqsIvJERz9x+oHg1TpmA806BfWlZ4n7PtFEXIRvonYXXeKZZ
 Xr15ulxl1hYNmU5Zh8fnrEgJRNQfdajD6BngxMsUglA0RCLFkewZJpwzdQbF1LmVze1d
 lSjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz/7rU17lRXsgVWgBMUsPUUaOM9P4+7/J0FSZsvxdXMeZRz2Qram1knzwyfciKGGX3JjKTHLYH+6c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz46hFxVNbGsy8XctJO+wlbRYoUkgQtsD6aVRTqfSC3fw2hSG/x
 LPIDcu7FAU5w0ggK0kSpn517wBd50xy9BLc02nMvZg0rNxy75nB+h2LQ7hulxCND0DNk22FfgiW
 tKSVI8ir1m67R/x6KRAQg48xEjMrTQJTNNhU8vyN88oW2jv+YMWfo6QthzLidMlWP/G4pC74=
X-Gm-Gg: ATEYQzx/PwzaxJG+ztEkGQGYA1czIaRmbtx9IVOqyKBzBT8gDorNZBG4nkotj1S2nJY
 RNdohOUkBFiWNThEsHBvmullLNkJppqhHXr3j7QNua/ZhqDPndUKS06EXpUxboNnGqcX9lIV2h/
 OOe675HjVjysVk9nB2peuY+K0DReOw+e/mafCuZS+s5hAcG0W4P9i3goXQUkUEIbgv5OLSeQ6d3
 eEUsbMRI3146Jo4S+yUMF3jgF8Y42irbUHkI6vJxz9VH0G5CVIBmypLz79X8Kgq1Y9str6P+OAf
 S6OTeBl6c/QN++jwlUoTRqIekQoZvRXTpcCuCBaMTAsaNbVb/VHYQvX8je8gWzYLk1JNAwlsAB9
 V/n22Lll/IybVZN0KOUBtIcvNBVSSG0ysTTdt9qcX/2kpBNQmRVw=
X-Received: by 2002:a17:903:3810:b0:2ae:a429:fc42 with SMTP id
 d9443c01a7336-2b06e400620mr66595395ad.40.1773901920345; 
 Wed, 18 Mar 2026 23:32:00 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2ae:a429:fc42 with SMTP id
 d9443c01a7336-2b06e400620mr66594985ad.40.1773901919866; 
 Wed, 18 Mar 2026 23:31:59 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:31:59 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:43 +0530
Subject: [PATCH v4 3/9] bus: mhi: Match devices exposing the protocol on
 the SAHARA channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-3-47ad79308762@oss.qualcomm.com>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=1219;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=IdXz01mR4Rs8f0RYsO8zVitGxgHIzvaHiQFtik+wHJE=;
 b=e9fMzcaKKjCxCsbrxlVdE5UJdojNscTn2zbL9SlQlbqh9xy1a1pnb+eD2q55B5TwUBYiq1GVm
 7P07BMMwHXWBaY4PRv2kbaKxxJwiZycQYlSC1IZL7WAdxVcWpfcgiJ/
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: NEBuSAdnPimHOWWvsgAdy19TfoUs4qgO
X-Proofpoint-ORIG-GUID: NEBuSAdnPimHOWWvsgAdy19TfoUs4qgO
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bb9860 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=O3MGeqbvIhhX5qxHWLUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfXyqnkQJdmsYPg
 qFBzc7hHGx2yuA2ThL18rA3Cm8nEyjTOj8WYFfPEKfuCn+wR0BWpOqz8PUSjfToTM4WzM8H+6Vf
 SeUv6HuIf0QXaEtCnQbt8Q+c2c2VkH2nD770Y5mJqeTMZfl2k7m4QmpzWd4zPEBzhuOcL37TDe+
 f7LIqs1v1+F1Vuc4pRtoV0xME8h0e3i0pcCwJHVNy2zXjplTOgIOoindj5NTU99d9hCUqNQdMoS
 7pJav+l8Y3H6xr29m/JHvnfmaRNp2cskOXYTHBpPdkDQZ7Gpqp+JUY3r/28qN6/9NJLSl7mXQnR
 CLLlYdYu1HqkFHyDR5szDNLUthNYEmWcQOQ4preHRnoKT9lNq/pBMr4UC8sCryWOsUrAwosEvLo
 2peeSeU08DBoqEhIPtmNMGl5O3cooZu8lw6tfKDtdlnZAbWiFD8QjAF8Hz4NB/NP5YJBFmPa2Vq
 SRwr3EFQe5yc5qlxTKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190049
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

Some Qualcomm devices expose the Sahara protocol on a generic SAHARA MHI
channel rather than a QAIC specific channel name. As a result, the sahara
driver does not currently bind to such devices and never probes.

Extend the MHI device ID match table to also match the SAHARA channel
name. This allows the Sahara protocol driver to bind to devices that
expose the protocol directly on a standard sahara MHI channel.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/sahara/sahara.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
index 8ff7b6425ac5423ef8f32117151dca10397686a8..e3499977e7c6b53bc624a8eb00d0636f2ea63307 100644
--- a/drivers/bus/mhi/sahara/sahara.c
+++ b/drivers/bus/mhi/sahara/sahara.c
@@ -911,8 +911,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
 
 static const struct mhi_device_id sahara_mhi_match_table[] = {
 	{ .chan = "QAIC_SAHARA", },
+	{ .chan = "SAHARA"},
 	{},
 };
+MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
 
 static struct mhi_driver sahara_mhi_driver = {
 	.id_table = sahara_mhi_match_table,

-- 
2.34.1


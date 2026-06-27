Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6EDC43602
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81FA710E51C;
	Sat, 27 Jun 2026 20:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTiLTP86";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGA2IQiM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199910E519
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHnK6f1732805
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S6xxxfMDXAN
 erFbo1uReydPIpgfTLhmvDaY3AGwCAeU=; b=PTiLTP86qMBE4tCJ36jYlrb/bMe
 n3IosNhRLixuLEsSvTMR4b+kq3DPcfOSjeNqstHZvPRAy/jYSI7WYnf8vxNm8blh
 VIXEmzqcQ7lknqopUhq72ZfzcZr0WJBv8ZJB85xSbxNI1cgJSa06ckaJbAGjmlJw
 x7rXTHJDeKNitt5NpMI9UjKSXOlzNTEpBVHKyz+l28MXIr7H7yVhDgAs9FBjfMei
 WpdPq6KnLqvpkF1VsHUj+h3RhzHf6Pt6Z2BJQn7UenHSCIEkps+TNEIBJqr7viM6
 4uT5/XuYbzY+H0MzvOya0WmSEwiI+bhorqUnuwTgJr2nAnr1GESWBOCPxaA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuhnyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso1289432eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782593051; x=1783197851;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6xxxfMDXANerFbo1uReydPIpgfTLhmvDaY3AGwCAeU=;
 b=hGA2IQiMh6Dnp7xfFmzKUaICFOg2Lbp4gPsBWfn05oWBZ/o0eFe19LPwyp+SQxO7nJ
 34i3i/bgeo8f/HOGBX6P/Ff6bhXVu1LQB2hgAsE7SfCx7gD7nWBw3rBAh4gOkPokUqm/
 pP5prz24u1UgxjbHZn/as3IyPiOto6fEyns/DUDSGHel+394T0tPoDZl1V1Q/EJgx5iw
 whInqmbOd3jKmd9aJJHjPH7Mz8ViKxYFI+zTxzghyCaCdgqKbxHmYNEOdKYPva8Ojiw3
 wDab4b1bVU6ioEP7fkSZr9jloYJ/udlOt0Vqnq0UaedmxEz0R6jMA11ybL5iDG3qmH/O
 /4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782593051; x=1783197851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S6xxxfMDXANerFbo1uReydPIpgfTLhmvDaY3AGwCAeU=;
 b=oIwm8hep39ihZEmWk4rkPLQDdFhKH84E7nL+yCta/ZNi+C9/9e0RQxMpH9j4gL1BA0
 UmyhLLFO4DO2O/Xh9vMsV9CkxpnXwheYt5ut0yQenuwxs7efN8FrlD9XpGiHLhukQbu4
 RZoie+TuRQQCLoMKFdbgLKv8fy+wvlKhDF5BzuEge5lUOFAiGzHmWu7IBciIebM6yygk
 ZxkRmWzl5mp7T/GOt6N50sdtekTdnRFHY1rK+Pnd7y3mcS0IEl2nRr5MMauy9ECkaGZP
 sfkcabPcezssr89tYUFES3E9ZZAmiQvmRhQHAqGNXxmjH0dPKMQIu8WDyBNwqnpdiWvR
 d8Ig==
X-Gm-Message-State: AOJu0Yyfw72gzHgYu+UgTl1r+LZGvLHQo1/f97xyH3lQAdj6jTDDeun0
 PouUzI0a5oXxdaiIQFgnSWMD65g7AX5FuvUrnJAsRrpC6U3w9Jja6vHbFxeqdjpBy4a+ayf59dp
 1EsyPkOUaDh4a1XcglDC7m4lRkRE0KEHsPFu+Lb4L70/RQ+xd0STsZHXNFZs4MQWVlNEsgrgplg
 fXh7M=
X-Gm-Gg: AfdE7cnbQC/PYKTaGCPJh2ee+Co2w0ljhatXaqD7uiPqNBYP1VaszQBpFM78NQBKpwW
 12tQP0bRI+xoXToMrWKTjKrzroGdCW1U1ns4ARYhS5g11O6dtVQwMVKb9e6tgml8YAPsxLfGvC4
 LdBhdK7vAxt7pBqPuDiCHSTZpPmZNnYiRMJe8qldb58ftpPi/WS7ZadRBmzazYlyIIFWehvaCIs
 Z5kELNFu1u5tzMxC7I7bPs3YlAXpfDW06fvUHKrNdikA8YNevwHdWki46DcVaLrt9ov1ekxvSpO
 gbMMmC4jl8F8ueVU6PlL0QU+G2xpBrrRedUQ/tHcVwbOrSXvfR5wYH6G3WUHUa1NFp9Nc27mHS3
 mlKuF+xiGke3DT7S2y2RdgQq/fCHMTSDtQKbV
X-Received: by 2002:a05:7301:37c4:b0:304:de43:130 with SMTP id
 5a478bee46e88-30c84b2d00cmr11262297eec.2.1782593051056; 
 Sat, 27 Jun 2026 13:44:11 -0700 (PDT)
X-Received: by 2002:a05:7301:37c4:b0:304:de43:130 with SMTP id
 5a478bee46e88-30c84b2d00cmr11262269eec.2.1782593050357; 
 Sat, 27 Jun 2026 13:44:10 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm16882963eec.6.2026.06.27.13.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:44:10 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 4/5] drm/bridge: lt9611c: fix chip type initialization
Date: Sun, 28 Jun 2026 02:13:56 +0530
Message-Id: <20260627204357.3336040-5-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
References: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dfg15sSKMSqREPu3ZKXtadbe1dKbynA9
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a40361b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=lwkqCOk8tsuKzwstaJgA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: dfg15sSKMSqREPu3ZKXtadbe1dKbynA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX9hZpYCikB0Vt
 TlU7LO/4sKFozCPcpU3ASI7GXo7WFBJPhP9fM/948b3TmCdLWLUVRYnqmyObrhTuTFMBLFtomcK
 9vzqUtxbsYHmwlrvnXPkFHc6JChyBExj0OLyA4JaD3UJMFetIFeq+4QV8m+wKLZC3oj68dX8iS7
 EWrica6VD6slNah5kr4fyJZ/lEZRh9rNk13ZXOZINE9ZoGnWGjtJjP76k491KBtP1YLTZI+Ytlj
 sayTa72tZWarWJ5QdiBNCQWbcFTDD2OCweikIqJAJqnZSKGg8pLlPqvYKn/VE7LjcH9fqk0sTsc
 UOiyz/8h/RLrki74Sn+4Wz0ZALIwWgxQn+Lpmh3BMdJPVoVpbfvzJeu/jWrrcx/us4qtUu6MTSz
 FUw5GTCt0RG9s1xpslosPpUem462Z8HMgYPQPT1Fp7Dz6hYOiRqkmcc5cWuX+gP3FvwR5mtVXVN
 zrwBTbkkIp226IIaZ5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX9viYVbImA94z
 BDUAZv1HAhYHliGGgzAMZ0bqEwtgpms21OquvcKc3KL2OhVef6e39BTRN2i5FSxC2mYad3Iu+yw
 QvwTKh9QO9gjH4JhL1+K+ifHxgH+vzs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270183
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


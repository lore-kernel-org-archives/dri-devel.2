Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAE606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WxdhQ6Xk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gg16DzEK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BFB10E910;
	Tue, 10 Nov 2026 04:57:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7C110E910
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A6HN2275504
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bLZhGhd54Eh6JFGUE7YuY2ODMIuxGuZYuXSHcnw4ktM=; b=WxdhQ6XkDhcOOeSE
 P17r5CQhmNPkhAroiEynqNkL91aSHU5Tu18tnWXsvO2f97MTyAGGzrqaFYGIw8WL
 maO/Xl5TvTxkW1RATLyqfrEabizXvX3WYZKBGMfAdCmqwAV3AJ6cmxposD/uklv/
 Yxw5e6E9r3rbGYvQgVYoZkI5byUo6y/YciR1q9AfLhkzoOyHYR4ucbU1yRlfbM8z
 6Uv0n1U/9AYoLXAJlRq30VleSNxYkNuG95UTKZSX79o9ZVd4PU8Ccv7rWqdK2wKh
 yYPVFgt5Eklzl/xnKRkFB4PRSB9ECtiHGF9+4epk/SpHNtRp4898wVBHuAF7YFa4
 IeLXsQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5bh2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so351656985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286605; x=1794891405;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bLZhGhd54Eh6JFGUE7YuY2ODMIuxGuZYuXSHcnw4ktM=;
 b=gg16DzEKJTF5lTBzND9OM7m1tdHp5LgPhU9qxOuRAApqfE9ZDx8Ls3YaRGTtIrnpP6
 SkQ8/mf90Wvg95xgmXBver3HxHg3Z3s+Y9g0P2YHu3U7hP2UPb6YAy3JOTbtNunvjdyR
 y4fO2587k89lK6MJNTOaPiYM27aslMWsHTFUcCPYCUDnr/45qUXqC378bNdbLxiVEF2u
 +VyEemwyzMd3+h33ZGalEZu3lJVUIDu3VViS+JZM4hxF90XTbzCffBQ/5UgCe9Oh6D5B
 IsnwAWwyeVSfYOnp2NK3nxpdP8NctLwm0okozW7UBcoa9RMx25l5OolPh5rusQdsSqOk
 APxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286605; x=1794891405;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLZhGhd54Eh6JFGUE7YuY2ODMIuxGuZYuXSHcnw4ktM=;
 b=sCkv4BnPtiCWv4gNGoS6ct4aQi+Y/LYOXROfspPowDQq0TfznnM4CZnQ/QtHzsL9JR
 cCHVaviRADGJk71KriWHzxj+iSTdEWr89MfJj+ME4v431ZrSSJwm19SHqaRoUuTxn7Qm
 Ace4rzAdLenCV9CActJpB5QnefsAPFp6/M9eDohzAXHqD9lmLkZY5zFSpJNTJca5f1YH
 Mz/bAfheGCOu5y9FopZ0NhyiFUPKh9yn9Qw4dOdQeizaS5jWBarY0G8rwymWO2KZDfrU
 8bGz39p769oj938GjTYH9ujYGBLoBBVODYzY4xrqj40pVuvlQqYph5zJSqPNICkD7fit
 7fBw==
X-Forwarded-Encrypted: i=1;
 AL+hErHqVcRWSAjVzca2EuPNlZHyOyOKEypqspNHpZ0HTf/zo404oQiWBDCizr7UNqVRwV9X6BzgpyHj/ZU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/XJdVF0D391nXUtWA7/iRPS/zXmAKqj1YPyZxIA4I1c1TL7pUa
 uRFdXBXyGM4UE54uyDXENlYEmD1e/3gAvNea2xPXX+u1S6td58WL8nkyfInynr4xX+mJEtG5tGv
 5LXvThHCNsblUus1gN7xFrR0aEG3HXw8p7H1Shz397OISI+NHgRLAuvWdO115WWSTNvYRWd4=
X-Gm-Gg: AYBFou1oZcHgkBMbaXg/TH377RP3bATnqajoRlKyJ6iXofD7GY6EH7a12dRaOHi3rGS
 7cZUQFsQxcuSGtRVa2bPPOhQYrXAoRc38POvYCJd8LsA7AsMrbEdg3JRI7qkA1aL7wrvQMy4XTr
 LTxepsZf8UFkfdNMbMpOZZVXISmVhtJ4NZivEniOYU+636ekKrIiqLCUeEcuLQ1orB10vWjg6RX
 83uSx4o1UWd1A5UoXRHjxHGRgC/iV5YTWCaBlAKhsmTEbISei4fn1FfdvCtWAnnwMrxXlPmjl1E
 ORWAsFXqWbRcVf044mgmfKLOllCrBN5epsbC8NpIVrV+5Km407aRCF9avKA6jMzS7fwRijSkCnR
 Yzk/WC2v1WffijFUUmE8HWKL426GnJZKBcsU4mNNyI3JzFMU90x3LRZwPlGVqpiwJU4zSefreTN
 mwlt3Nj5frgMLvjsA3tWLHUxJXR99XCx8DzpGj
X-Received: by 2002:a05:620a:4610:b0:93f:565f:e40 with SMTP id
 af79cd13be357-9479f31a225mr262557185a.65.1794286604696; 
 Mon, 09 Nov 2026 20:56:44 -0800 (PST)
X-Received: by 2002:a05:620a:4610:b0:93f:565f:e40 with SMTP id
 af79cd13be357-9479f31a225mr262554485a.65.1794286604262; 
 Mon, 09 Nov 2026 20:56:44 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:43 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:48 +0800
Subject: [PATCH v8 27/29] drm/msm/dp: ignore IRQ HPD latched together with
 an unplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-27-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=1164;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=bfFHW5pac45fv2G/tLtozJ4WL3CywVJbvdGmDCdZZ9g=;
 b=9cbHRITB8rdqKvOioGVspyl8NOFunJMJu9syJCGcN6BNUDfuVhjXb/O6LBqe871chXyLkpnlx
 nRDi1g01szgBfSLz7Ia7qm/D0i4Fex+Cr0K8P7UCZ5sH5GHWQRIbFai
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: iL5q6WPBRRrWG_KQlPIgTKDHK_zT-SF8
X-Proofpoint-GUID: iL5q6WPBRRrWG_KQlPIgTKDHK_zT-SF8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX/vYZ741DPzjh
 AUKYCoRpEPu6hHfB4ZabRUy5Juaz7yzDaP58uKYF6leUXzzdn5Pg+TRkQ0ItXzp3u/4DF29XiKT
 EB6Kl2mk2Ki8z3WDBfeQlenOcchE4cM=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af2a40d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GWmhsmQFvB3G8ctGRoAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX6BcRDin7W6oM
 SY0DNGTAXI14IzhHA+yiEZdwsVUMQBU6sb+NsnxcRK3O/VywRNKo0tAqf4EgZNKDaotN82PJjAg
 MYr/0FRxtgA6VWbl0osrlf1g+qTtgZAdHdsoJpS1paYb6iFKKO5+8tceSdKT4hsiMYTpEVGefJ6
 tM5sWy9t6z0NvFJoWNzoqqEKLJLj/N90arcb5EQqvypEaG/+KYFqzTSKJ494KPOkC/j/zvZB4J7
 3ePKCDvHkMTbCpRJJsS8Nolv6E0gzU06dy36LWnv3CRFKF3/fG1ARp2UvE3Bp2w3PFmUtq7JB+/
 0M2rkIt38342OfmKprLnuIAMJJjiucYMUSGQLVoNxBcDGq5dhPXSAhV7d6q9LbduxBIII9lNBpc
 HzADKmoaPQru6+DqtViwX828RrKQHVzmqYpwvSas1bmKd824PpxidlMDB/DWmABsNOyNi5LzYb6
 TZO2wYhx8vgoyA9hc2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

IRQ HPD can be reported with a plug or unplug event.

For unplug + IRQ HPD, ignore the IRQ because the link is being torn
down and the IRQ may be stale.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 40b2f6e120cf..8e30420a017f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1131,7 +1131,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
 				      connector_status_connected);
 
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
+	/* Do not access a link torn down by an unplug latched after an IRQ. */
+	if ((hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) &&
+	    (!(hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK) ||
+	     (hpd_isr_status & DP_DP_HPD_PLUG_INT_MASK)))
 		drm_bridge_hpd_notify_extra(dp->msm_dp_display.bridge,
 					    connector_status_connected,
 					    DRM_CONNECTOR_DP_IRQ_HPD);

-- 
2.43.0


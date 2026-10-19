Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B40606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=M2T3KOyg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ImTJo6T4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5724B10E68C;
	Mon, 19 Oct 2026 21:38:47 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E87B10E682
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:30 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLc2Om1358592; Mon, 19 Oct 2026 16:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=nK0/S6QNy1aBZkVM9RM1B/7LVpgvEWtjMumOszWhu
 R4=; b=M2T3KOygINZQZLNX2ivrHni5LqLE4dJTEuGV6Et7BKN3KoIqiu28yuIe7
 Jepvv5+4YSwIKWb2TPPbrCrPbaJUOd1f2BhaDJykIS5xjIv3+msqVFleRiBDlGVd
 dbOOk/QUnQOJSIdoIc0QrTv/oM6egAXICxYlyKRa5GCBPe0XFM8zZ0X0Pr4OoVcy
 KmHISp9uOANtd/2Q4bo0dzScKIXcAiXbzo4rJu7bTOH1gT/gxthU7oMpkB/ZrUul
 O3KiSTxwhepHB3ULhEJSnMOi7Cm6/WM9a0aAoCCxeBX+F9p07NA1KX5a9QclULT0
 MDERajXOm/dTy+IJrbQs/fkOvzKpA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd6158j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9vLRx0Ie3vw5ZqU4BQ9w/Lh1WNxdKxW3t0dtJPt5RgVZGVQYwtn/zlOQBY9eCY8y5jTkb6r4Zn0jzE2zo2rEzuPyi2UQWnR7RXI7t3xUKrCuIrkO5dmmfZo9lxn1mdyDfsC8x6A3MAY8CBj7+9Zpvvs/1r1iNjpzBYra/p0D2IrmieYeNTLJMuurHD0PStvJ5sQMLQr1w1PIH0R6vLtwq0qWOsQIFJyY70Hv61NZ1/HHC0AHRixph8UvT6S6+ZHzhxin+SddCrvqwHQmX0eixLQ1zDjo50tNMOhBwgsgkLHvbpI4kweA/KwLYbj9VffqbWSpfXep0wPQgzetfPXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK0/S6QNy1aBZkVM9RM1B/7LVpgvEWtjMumOszWhuR4=;
 b=cehEf0vI9RFdFZuiQXUchZxU5UnTzmb7jRUpDQS0ZPshcAUKY/3e2NbTW2yaeY2Cy/gW0hDxXq3T6/RG9pfywm27RyLtMNijeP2nV3/Ybw8wmEea7AznER+ot11MsCU9EzbwXgx0OPu5U7W+dGzRdLN8dM0XqXj1inMuDmivlVdPqsFGg8WO7pm+Q8CFiMRY56XMftxvED/eH5RdNoGFTuyah12/5nJqoZYTb3U1V8MDkckj4c/FdTMZ1GHSZrH5gFB8DpNGC+HLhmq3rhEGHWybRJ4vhyso66+e+UCG6aQrCPFhMJH7hEpLRcyBRcLlS8iNDM19nid8PArwAsZ3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK0/S6QNy1aBZkVM9RM1B/7LVpgvEWtjMumOszWhuR4=;
 b=ImTJo6T4GjcQ430nYXmjjyli15+mEJJcrqgaTuJm15srqDh8UQdZyOzBvgEj41pXP9iR7X05lMR8DqQCbAiiUu/GJaLohmIq9fkLjUHHnXl1jn7xDY6mJLwtEvx8mEZeffjmU8yluf8YuGgfybVwz0e2qGrYA97MuKKjNx04x60=
Received: from DS7PR03CA0348.namprd03.prod.outlook.com (2603:10b6:8:55::8) by
 DS0PR10MB7294.namprd10.prod.outlook.com (2603:10b6:8:f6::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.13; Mon, 19 Oct 2026 21:38:22 +0000
Received: from CY5PEPF00000E7A.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::17) by DS7PR03CA0348.outlook.office365.com
 (2603:10b6:8:55::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:38:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY5PEPF00000E7A.mail.protection.outlook.com (10.167.247.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:20 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:33 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:33 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbWcN3576925;
 Mon, 19 Oct 2026 16:37:32 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devarsht@ti.com>, LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 03/14] dt-bindings: display: solomon,
 ssd16xx: Add Solomon SSD1677 controller
Date: Tue, 20 Oct 2026 03:07:15 +0530
Message-ID: <20261019213726.4145532-4-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7A:EE_|DS0PR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f2af24-305d-4008-f6db-08df2e294ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|56012099006|921020|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nvR2fhXjBYt2Ehuu5EA8XDnKt/GxOt2newzvhC/JoRaLQfQgNm5Kyusa3flkqzRZDqxGU7qai9MLXNTNKLOqbQeUYyq/VeZoDvLApihQat1Qr8aqDdPqg0w+l7ZHbdWYfLkIlQfMaWxxBkxjHisQVl3sirfX7VrnOrRbwePi0jmW4xEUeDr7LLXLqCsDf8+qaeg5TJ2ah9Nx4gAXXn4hJm/PLGBKdv+wmFRMe5+yUSzYofdqqu03PWghfDEQuVRpVBJvQ4Ypx3eHxng3IeFcxEEyjg4LQ/l7KZOug5n4ZKIRqPz+F/Fx6ZVDL/4CCFg1jkgJ9nUnsISNsxzCL0nZ8x22rXVs/PjSEyZGMFCMvCrzVjlsIdxsZr83AXWw3nba99Ru4DRMwTVS275efm6oiEG4UhwpV3JmwjiGxEfkdwf7ifYUYnXA9TcsRYvGzOgh4wmMMQiujeM2ASv7+KGnmj31mbqId8AoqYrHuw/pIfEYxowAJjAKvW+xx/x8iLllWamPY6nxkDZI3IgiOnfkxi/kSZJIM0OJiVDL3VxIkvAheE5DfuV28s1mGZRpb3c36iVKngGPWrVtFUMJTN+naU28xfpMZwWUOuK1G6bZbdO9BDy1zmrHFjggXAIJG4NlfyWr55KxbcvYO5FWts2BKPIsstT9A5Yyb85xqIZ9KVT+esXMc1NCfam1caahjxo17dvp7EMD5UNsWmrWAN8amptiUGV8cMae7nvfJGXdupiy8rcHk56Iun4v8egqxM4y
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(56012099006)(921020)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zJRzgn8drsq0geaxeP2+Dxwa3b9VYtRS44QEe48tfjP09wkvleA6AE7c5XH+SL0MgBRYQ4B3x9ZKpt/yxh16R6EMtV6ZSX7IBv1acFX3iy2lzUlMgW63ulqdaqBFzK61YUn19V1IgJ6CAp+BoWM9Ad4rP3fEEIoQV/VEschURPrb1xy2T/swJaIFF/oO6K8B7GyTI3I0OSFEIy8juB+iLQPBU9cZBB++iYFGrSUUro7Sgks6mnHXqgcfHq573OPt73rqnZzCZ+uDwlfGCM89b9VAGtFs5ZogTukRl9BbLorkBlCPuKxYPfJkndxD+mSKx9Tj3HBNHR8tWa/9aTG3SEI58G8F9B44LPrkFM+wO/uUTEIHY+1mcKIZ4eOb9HhE9QALZqQei/XnMR8la10ZUoFaEFALjYXcNSt0mBwVBrbhwheUqlU0BrBp0/5nxO2u
X-Exchange-RoutingPolicyChecked: AFPrw39dQT/nqgCywYvhvtoVso/dSY2m8xPc2FLVsS5xHPOmcgIQqKcTrlg7qk/YS0pdrReR3En3f/0xE/Z9ccHAHbNZcPXk5tBItJ2CG+agXrhYkvNH61lgy6WH8bp2BfXWAkbzTmtsWMEDqNzKT2r5YwDth7qXcxPVMlrtHxlw6VqoseHqegmscQ79uekO6HDwcRC/vFiZTa4THJcyhUFiUwmzrLdGd6daGI3xHa6yQ2K2k/ZOgFbR1d5Xnf9p8jygmbpFj9cJv/d3Nc/9knZTGNKH+Z5AoaxzJF45XsoWVIKvYlDwIKM3g+GpvUzwbRDFZQNxz88X62XRJOYshA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:20.6761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f2af24-305d-4008-f6db-08df2e294ba6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E7A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7294
X-Proofpoint-ORIG-GUID: Vmlu8EvVI5iUeT8J4kW1oUuokf0pm8jl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX4obk/FE8SDX7
 oUDDSue5GIlfGjRGbZ1raJcgcQpNb7QI61QnaAYv6igdkWtgFZfJdpAUJIw+TLfUxkmThX2LN4Z
 Ge38AxbM2wMKS1xR7z3ONTKZcWtlNB7fPe0GlNhWTuPSGaOYXZGFfwJz/QQnEhXZMVsdNXbLCLW
 1AhqpoW20qcAW0vWwOSfjjN8PDJi+Rf0GLJgQrEHj2W+C7Qqyo3HCZ0WvJVgaKQJLceMjlYiO8Y
 Hg8ra+hGYQGBTSAbPc7XQ0FUbZnqetEgtz5ijeHBnVGvIxECi6U+caJxMKZEfnonLoG/O4dNNV+
 hT/YojJ7li3liBqpZYu5AC4TQjiXVQHMKpS/Ivyyslv1spfNyCUFiEJ3HIRToNkc3vSReexXX9H
 71ovLAtgUfHsztNSnI0Le+voCD3tsL1wimzQZPDnWmP+CnZoXjBDvhpSfG6r6rM/ynUZsORKd8v
 OcGms6+ygwxNlWItArQ==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dd1 cx=c_pps
 a=DKBbczBT0NfZzOMt9NccUg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=vCvBjx8nneoXTcRTK9oA:9
X-Proofpoint-GUID: Vmlu8EvVI5iUeT8J4kW1oUuokf0pm8jl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9ml4t9191PnJ
 ucvGnrhd5f3xp+6PvHTtDtxjZyMojXrRGDUHfZhilf803dZbvto7dCEi/0CFL53LBrAVUDk048u
 LNlHWwxwt3RIdXTJgSjeKYDeTWfJdSc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add solomon,ssd1677 as a compatible controller string.

The SSD1677 supports displays up to 960x680 pixels with 10-bit
pixel-level X/Y RAM addressing. It shares the same command address
space and GPIO interface as the SSD1683 but differs in addressing
model, deep sleep behaviour, and initialisation sequence.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Only add the solomon,ssd1677 branch, as the previous patch now already
  uses oneOf for compatible
---
 Documentation/devicetree/bindings/display/solomon,ssd1683.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
index 2e2aa195fb1e..df8d9ff821a7 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
@@ -31,6 +31,7 @@ properties:
               # Good Display 4.2" 400x300 monochrome e-paper panel
               - gooddisplay,gdey042t81
           - const: solomon,ssd1683
+      - const: solomon,ssd1677
 
   reg:
     maxItems: 1
-- 
2.39.1


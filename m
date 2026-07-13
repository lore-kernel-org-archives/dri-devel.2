Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF4CC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8815010E5E4;
	Mon, 13 Jul 2026 13:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N0XqD7/Y";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CbeEP21r";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D8210E5DF
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:35:43 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66DCDVsS3527146;
 Mon, 13 Jul 2026 08:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=hUNSJ0MsLvYvCsee9DDBxXNWoAhSC66CI4Flh3U3/
 0o=; b=N0XqD7/YI9fdSv6KJ1K8QBt5tTalTrPp6jjRDXFyybd+Cag0a8FU8l+tP
 I+xQlGpHjl4J4wcG7VHK7mU9BCt0ElVnmgUALFdASX9QnuUUWE2jBHB9x8xEk9Ip
 uXHOiFOweE3zzOyxA6YJ7YXV3GFQMakYNMujfndJE3U1Icz9UfBvfYyFg0pYTCQ3
 nFRjRJ3KJjNvShIPePhPOGe5c0VZF/WN+IjPwxnMVBK1blkKn6z3K1z0DA5tXSYy
 GgzujF0A6PrOumW1qFu1HhBP9mLbQMBxLLiqhkQlCrzDrxxT+0iDQoBHT46IEYOa
 QK/1oqjoQv50UwlIlZxhdlOcJxT3Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fcxxegqs4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 08:35:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wqp8+GD0oOn++xgpAC6TyW2H3q8g3RsCZpaM+gXRgUEb6GrxudOptX/qqo9OKtRJhwdTUsLaY+M1TzhxGh0dEDWLhv6Hc3M5cAiKTSKmWlEWbdUnUISUzeXPRJGPKGUcZ/N+DrA3L7APxldNToHMPzuAqvvWj+FJSjA9h0J/wi1kiXxoZWNmevu/1Gmm2HDLqiupbSIKOzKNNKi9Ql/oY0RIZI8hWwy4a5qp41NuXOjY5NPqB/3DNZMVHDlTqasIhXAQ//h11lj+fzF1gkPA8Q5GjmcOVyYhbiGKWMo+aXUE6i9vnNxGmkG2zQs9X9W9Quv0r3ffoaGajX4jYuVmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUNSJ0MsLvYvCsee9DDBxXNWoAhSC66CI4Flh3U3/0o=;
 b=xMMs3Vle95gFuHWPVmIjiYHWz7Ox59gJAejiXDE0dqRGR7a4fJ56sxbkO1Sngxy9V1NB+QRFTr5F67pyf7KrBjJx2GfJSFSE8lOVfEZOV9Gnt17AYyXadqGIsBisDunlAwjOLOCpR+ZJzN1RAfE1DE4iT+7vXPYRMhOS6syijnCNeimgdN68TXzlBImt6PF9yMWPHJF7k5/xyFmnuS2U8YMQKLPGs3md3+BEv2+x0TGYNI0fzr3YSl/LSREZt1HJBzV2KMo47EZxEfiUqAM51uL0SrpKaPQ3e+bZAFoeUu0JWJK3JqYx3mp+a3oo4jYqsb2o/Op03QKzcfxfrZ2NZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUNSJ0MsLvYvCsee9DDBxXNWoAhSC66CI4Flh3U3/0o=;
 b=CbeEP21rMR3VjuY2UGmaeTJCUbZiXrO+QD2QukE9lZvr9D/1VXIxKuMZiSunqV1l40Q0Yrdxg1G3tDMUPZehX+0phwjXM076Ea6t+fsey8OMr8E52CulXErfs0GPtbupa+/CCir8LJ92bYGAocu+9weXLicN3Ie7S5vZOpiasNg=
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 13:35:29 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::1f) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 13:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 13:35:27 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 08:35:23 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 08:35:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 08:35:23 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66DDZIni2302399;
 Mon, 13 Jul 2026 08:35:19 -0500
Message-ID: <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
Date: Mon, 13 Jul 2026 19:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260617020926.114947-1-zaq14760@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: aecb053d-e606-421c-85da-08dee0e399b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|23010399003|22082099003|18002099003|4143699003|3023799007|13003099007|56012099006|921020;
X-Microsoft-Antispam-Message-Info: jE6Q47fw0Tl1VQvvA04P05WZJAxZdrW0BaBkVF44F2hRGIQTqRxcqE4qOhGt5NudFUcESW83/t/Bidpg3HttIR6/XXDE0QsiSNeSl6C3OqQpRSYRcp3q8n5EISwFhq90uaJ1alWY54yCn4W97pQ8C4ukCcwD/KJhSlLivydy8+u/CQV7dQWfdU09ez2Ndd94hPux6mhmdlNSXNV7Jrsn4Wwq/hfE7JKzD+2nsfejKxTxlRfSIQ6IDxoy3Thenz3Pvjc/loE8xMexYjYrhzqenHqaMgLQ9FTQbt8Kb0cXFUp8+enkPk0gULY0ZqTTxyhEURPrmIgZsSuhlfbjRCTrwOWh9BERIsbMOj+Y0jhyXYNgmwjtdR9EIWX+cADkyijISrS6zhp1N/axlDIjLKLBq49tSFWe1xmZHCyaP9U7rVuLPydP6qguxKtx6GTu4fELdctPD8XKRHG7mQtl0lXxh3eRZ2e5QcrR/5Jrf5GHyic36qvMXnFNF+j7rYdQ3WC5zFWCVdvZswcpmWUH00R4IN8eZfdrBQ9/5M3e6rex5guAXTHXiqBAKVPCo9fQKWYdzmhUhSwRbLklMQf7BfTZOCGcp/S+ufUJZ8eZ44dR/kPGAvNBzDFL5RFKvGCXgZJIEWDV4Ym08rsrkcl9x2GsSZ/9L9o0Sq6ZyGi9fZHINLlgM3NrsGpssrilZh8URc8QLnKfZzxsEmaIArUeL+SiKWpLCigJDtd8nEG9+71MnNqtvYtAwV0gOMbrE7lMQy0n
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(23010399003)(22082099003)(18002099003)(4143699003)(3023799007)(13003099007)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7xHCebvVYY4SKI/jNmx7IdYXmV8vd/Lw45pLoo2qrEcjLxPH39iq+Ak3KIIFVIBYHuuO1TKxD+TbrsRKLGG6ksM5Gyv/A+pBJOAaexy+4Hm7D4YFHgMKruNEmmRr2jjO39S+33e7ENh8aE2oC5F0wOCbInTTcNTWATe2XLY5BFIYJkQwZFuQD+9mk47fKx1ypfaBQwf2PPYhYgR9PI4hGD06qWQ/Ui16o5SFxU+Fy6U3jHNr2IxL639dfjA2FGRvUYY9Gq0MbqPw4y2ra2gNtrnHbR+wNdXzqaSL0s8SKZqG9U19DSIOdsB3VpQrgBOzuQVrJnS74hwQtCggq6SDvMx+SyH8XEW5fEaPGudim2bq0P0HqlgJHxu5hKg79hbz50f25mD89W3CB8kb+Mrm42sQUvWQaq/Hv5Rv9UUlZDrihkyIvJyRQlQryacokjVH
X-Exchange-RoutingPolicyChecked: adMqmNfdpKqkQbRu+xLzaUS48ttIJP819pa6nRuhxfKisQ5A04JqUpOfgf7BsNMwI0AARbLJVygjKOPtBpwFgidP8s+90N/jCurNHlmz7it1v/m6x3Jm1Pz9oCCsdo904JIk4uoHT2lxHL/QVs9vmD0VYVQF/dgKjqjgEL/gStDJwNSDc4csTQ8EKYhbE41u/0w320yAmkrp4wmfDZpoh2IJn6dw0Ti++I7Ex7n29veiOeaOPhIiavWRrQf35WyTq5CMTuJHjkeRt2ILuBardQoYYfBjnBlTvkqcz8kADByaMYdor2LN8SEx0Vv+btdDvMCOoGOniGkL4PHI4pzJJg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:35:27.2639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aecb053d-e606-421c-85da-08dee0e399b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0MiBTYWx0ZWRfX/p8mCFFkgJI8
 zyu+ZbW4UUAIcw+3K6Uex/XI4sIIQGVevNDQi7wH9AbN/DB1SkhA28B+7r4d6rybm+GYOJsl4M8
 wxEaMDPLGMBIjsg4DeAjyImso+bALMn9dDtqvBZj+PrA7k46cMM+VEFBXx5xDFQlfipBhdb6ofD
 YUzG5FwFdxHKx4w/cy0uwKi1rtc8yyg39IMZpQuzMaUl3D0HKjo51I5X8ciNQMuNfZUkOAI0tsY
 DtG+PJsgaGgne/VkcljLZbAAYTWGLOBIj7QRusW9E4jciaYNaK108zjNRQTdOSXX69EOMJ/0ygx
 I5jUeHW+6kfkbVftM40I1pK6t1skwV0cUuVEoN0godQDZe8ZUaI1s/4Ix4tDTPVv/RuKJjS9EUf
 O0l9V+tEBDFnnpgbJoCQfPzofPwbgoe61yQtUu7lR09dR0zyXBgecBTTt7veLIF5yF6uKF0R7Aa
 0eaY8sC2DlYytdVRwHw==
X-Proofpoint-GUID: S_SlJAonwsRLHpSvTbzi8n3fupH9KnJc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0MiBTYWx0ZWRfX4URuZYdP7bwo
 9bqJVnHwhgYoHFj447XCNX1KrZ2wbs2K8RbCmxOGyaJ5YJlrdfqXlcvM6Ol3zLjg23QSDaijPTG
 3q/NqXW5cXqpkgvDa9yHNAa39KFd43g=
X-Proofpoint-ORIG-GUID: S_SlJAonwsRLHpSvTbzi8n3fupH9KnJc
X-Authority-Analysis: v=2.4 cv=Frk1OWrq c=1 sm=1 tr=0 ts=6a54e9a6 cx=c_pps
 a=CM6yQ3ajfX3ct242QRRZiw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=nB2TrFpfzR2c5x_Qo34A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130142
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

Hi LiangCheng,

On 17/06/26 07:39, LiangCheng Wang wrote:
> Hi Devarsh,
> 
> Thanks, that sounds great -- let's converge on panel-ssd16xx.c.
> 
>> Yes, I will be adding SSD1677 controller support in V2 of my series,
>> hopefully that should help and after that it's just a matter of adding
>> panel entry for your pixpaper panel. I can share you my branch with
>> ssd1677 support once I have it ready.
> 
> That would be very helpful, please do share the branch once it's ready. I
> have the PIXPAPER 4.26 hardware here, so I can validate the SSD1677 support
> and the panel on real hardware and report back any quirks.
> 

Thank you for your patience. Please find my V2 staged branch [0], which 
includes:
   - SSD1677 controller support [1]
   - PIXPAPER 4.26M panel support [2] (based on the SSD1677 datasheet 
and your series [3])

Please test it on your hardware and let me know if it works as expected 
or if you encounter any issues then I’m happy to help with any 
adjustments needed.

>> additionally I can quickly add boilerplate pixpaper 4.26 panel entries on
>> top of my V2 series referring from your patch so that it switches to using
>> standard ssd16xx commands and ssd1677 quirks wherever necessary and you can
>> then validate and modify.
> 
> Thanks for offering. If it's alright with you, I'd like to take the
> pixpaper-426m panel entry through review myself on top of your series, using
> your boilerplate as a starting point, since I can carry the validation on
> real hardware. I'll credit your help with Co-developed-by/Suggested-by as
> appropriate. Happy to arrange it whichever way is easiest for you.
> 

Certainly. I'll exclude the pixpaper-426m support patches from my V2 
submission so you can handle the review and validation on your end.

Please feel free to test, modify and  confirm it works on real hardware 
with "mayqueen,pixpaper-426m" compatible from this series. Don't 
hesitate to reach out if you need any assistance or have any questions 
during the process.

> I'll also follow up with the 0xF7/0xFF test result so we can capture the
> correct SSD1677 update-sequence quirk.

I will continue validating the remaining patches using my non-pixpaper 
panels and plan to submit a V2 this week. Please feel free to send the 
pixpaper patches on top of my planned V2 series.

[0]:
https://github.com/devarsht/linux-next/commits/ssd16xx_7_2/

[1]:
https://github.com/devarsht/linux-next/commit/f80210f9440234e8890d400e827b0f7a5cb2f6eb

[2]:
https://github.com/devarsht/linux-next/commit/fddef0b92a085845f07f51dbc7623c08cbad8c8e

https://github.com/devarsht/linux-next/commit/c953e26d06e201dc523ed764ffba083bca49e922

[3]:
https://lore.kernel.org/all/20260529-bar-v3-0-5c2ac1c751ee@gmail.com/

Regards
Devarsh

> 
> Regards,
> LiangCheng
> 


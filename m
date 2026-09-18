Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85536C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCCE10E963;
	Fri, 18 Sep 2026 17:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O3jUzPfl";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aODnCr/o";
	dkim-atps=neutral
X-Greylist: delayed 1475 seconds by postgrey-1.36 at gabe;
 Fri, 18 Sep 2026 17:31:01 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EA410E987
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:31:01 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoirf398002; Fri, 18 Sep 2026 12:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=nwENsrdrro0I/oZSzKZ1CiDepwQJjvpzMcLFY7YS/
 XQ=; b=O3jUzPflTWRe+5YHzK+ZhHUOM7VNrYANsijS3PpBUmJGEgdUvbTzGRocH
 8QdH0UXc4YvqT4O9SZTumxz8iUCCU5ohfLCijlk7c71wfer6KUwgmG5s2b3HB4xp
 TdgnrlV63MhtNNQd6KXezfL5jtvoM62rMPPAplxCS3Ln743FFG6I6giYWfCN/ovB
 0m6j6tyqOvmFnrM9AtalojRpVriP5qtiDmEALMPdCd2Ijs9Nimvob85b/0/ZH0zs
 N6erNTPYBy84Q2jhTtoK6zdpGHxKRhkcz9K76JQYhYFOjTpI2IO7OKiSGDn8FbGM
 3d6+mr/VRlvnKHU+97BlEiHbh0oTw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs70ygyfx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 12:06:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXQAsn9bndF6QRvYkOW0MKCQXZI0VDDwx+ZBW6ckvIZsNdiHYjvzf4xEpuX09c2TiAlz1GvpSE5U38mbioA5yeAX7RuOpFTEL4R50zgSSs1c2otQqtlgGrmTqZyNhUyqD16qI9H/yL73lZP4mxQ+Xeqc4CzkPU157HUsq7tm9XAAKMUltlHGhq1++cGl4x5kFBMBsiXuloaImzV1Lcsl1xxYJfBdgsix7K6MHQPHqKwpRZCLk5T0DqnoAxh/VbUKVT4ywNR7VK0O0r7Wx3T6kuqzvlRGxOLaikD5HXN2VjvWmISVjHSku9LygwXOxlfauM9pgzFR6CNkq2ta8cabLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwENsrdrro0I/oZSzKZ1CiDepwQJjvpzMcLFY7YS/XQ=;
 b=dAaQQ9tuF0yLyoxe9dUM4KzkVJ9lLdEcquP9zvMGfgs4BjSPc6CNB4Y/wRVyIY5SQrecDGSd2zpxxpod8j+T8mvdBR0ww8J7HfXCcOAu3G77oOD3cRRo5yendnYj5YoDw+jI4dXPLnl/Av3GJI1PUT8DkM3Rq4WYRiURstsS8TJYsuQj1/kfuCtjc3jkDrQ8MdODZ1Kb+eC339RQU4bb3zQdNMyyPHWzcBHE7ztrcJ3x1q5JBihXcDl+aFdqZYf/x7rTLMtvZwQdjCuni3OGS6Ys2OviR6gdBV86G5ElnZGosBSRe2I8Xie1dc5Wwhy6guhuoBzkLxoyV6ewa3zofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwENsrdrro0I/oZSzKZ1CiDepwQJjvpzMcLFY7YS/XQ=;
 b=aODnCr/oZ4xkX9EKjN7Luxg+bTGOcwDormhlM+f7iLvKmCZnTgJrPy2jsIRET7BFiMtXPGYNLTrKwfJ7OjMPwLn/gGvCV5Yy2hgqq0nm37oNv8awuv0nA1W0NOsHXY0mObcyhr+86sRbBTp1zdWyW+O/1RYxDSBqDqhSjtNskoI=
Received: from BN9PR03CA0949.namprd03.prod.outlook.com (2603:10b6:408:108::24)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 17:06:14 +0000
Received: from BN6PEPF00000075.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::1e) by BN9PR03CA0949.outlook.office365.com
 (2603:10b6:408:108::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 17:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN6PEPF00000075.mail.protection.outlook.com (10.167.248.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 17:06:12 +0000
Received: from DFLE20.ent.ti.com (10.64.6.57) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 12:05:14 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 12:05:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 12:05:14 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68IH59BG2091421;
 Fri, 18 Sep 2026 12:05:10 -0500
Message-ID: <44927324-295e-4528-8a66-2cdd4a52b1be@ti.com>
Date: Fri, 18 Sep 2026 22:35:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>, Javier Martinez Canillas
 <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Wig Cheng
 <onlywig@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
 <20260917025644.1262504-1-zaq14760@gmail.com>
 <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
 <0259fb51-acb8-4b07-a6d5-2fe25fb0de9c@suse.de>
 <CAFOAJEe_7Cqo_=NWPGyYBTu3mD3CjPMC92ZZR6qHPjAhQws7pw@mail.gmail.com>
 <1f59a88c-b0b0-43d7-ba2f-4c50aae87ef4@ti.com>
 <20260918062518.1824876-1-zaq14760@gmail.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260918062518.1824876-1-zaq14760@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000075:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 9976b632-7e4c-4871-7aff-08df15a724ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|921020|6133799003|10067099003|5023799004|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: TEVHjl7hXWH66KUyyW05USl3a2PyKdepzkX+MDzaPL83EMDgGkiBLlcAxwhI45MIkBxepcYTspJkBgRlYEUFcO9OJqC+m1H0jHlipB6YKDcxbb9r9gEVHt/JH4Loyvhz33E6Lep1PKc6njD0DwF8urUAsgJ36DNUqWMkpG5X2WQp+rRL+DTpmDsTVc475tokvRd8ym+MGj10mOzn884mpkFDtAm68X+AqjcG8x4BiC/NfNYzmT5wVpaU1pALR8lLjNZb37xxl55eAFITAMbwyBu5Ust+IIKzPQBIWZCOEmx+GNE8ksNalfL79Q/UYFlx1dfXfyja8UZxXzFk39q97e3tcSTPdadrLggBCK02i+Jw1voaSLYhK+E7+9/6rxAxB2brlsm/hORO+BlfgNT+7zhOuqPODeDGsmKK81XO1mh4boA2hKc9jo04uWoDa6mDf4pCmK+vuUfcCQYgN7PqXdDEM67zhXHZTc5u/zVadZagDgpg4aVHgPMXUAsOTiV7Bo4/vzV0JuIfO8j7Z4jGeJDvhC39Cn8ToWBAH7eHQdpu+uJgGdb6a6e0j9LAGjGH4ZqpxnIxk2PqxaClH9LgU+tPHl0+h40wR84ysPQYZYn8OpH5J9xzy0mArYajuEMcsj/A44bijEcdw6FmU69CHvvg47B4APWFFU/AkxuPbHwXamV1uRjC+QxzHQYAY31qDit1WVqCurToyAhXkG4wR0qiTJ4Hbw93N1pFkHMnb4z4Hu/d2+ln+C/kLrzzXlC6
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(921020)(6133799003)(10067099003)(5023799004)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NgBqDogT4h7lcl2GZm/Sg8BG81hL6p997AxO595ytDyFe4QkPRt957ZMkatjbxDQ2Qrld8nVhETTrUDGUamx9BhJeUnMCcI30aJACr/Zh4hSnGrqaVLmm8NCWKhhWks6+X1bYfInvVwUaDZNsWZE4Ar63vjDrI/YsVi0ec3X9jIeeCkmBD4a1uvHrH2teGn8qvd1VIlxDTI0Q8ZikxoZ9Ibk9v9P7mdCATK8qW1aSUVWOhoWEt1VU7bFaQsF+ylguk4rr3QXlHQCMhLrHsrtkiWG8QSoqpWeuI9VMJOUlgEjpkuWj+P2m4DNJ0pYFphp+IBk0LDlYn5Z7CzWA3+L0wnYPdupuNdZVfsvNUUKuhD4ZTOJ9rKoagHFHdrPe1omCJo/lYIUv29+IkfCD50RKG/2Y2KeaxLP/SQS8i86m37ye25VJ8TGGHb9159T7q78
X-Exchange-RoutingPolicyChecked: fvn3OqyGKKuq7bo7qGYoPPBc+tZsirgBNLw7S0z/g/KUba9aqmZtXBOHeAtJbiis+IZ+aSsT0twAWtQRTPGQmme7JVXT6ic9+yILMB8ElMcNn+F1RyhgTPVnwaMqsVwcT9dQaa/5OnkVslQCKbW6BozIGzJZ6AQ+16tlqMTRKflX54o7K3w1iUGiytmURjgVJVPfgzhIvOA1GvlDOaPrQfsrkFOMuvJJkrR3aVQGEA6KYIu8qbMclqFQBpyWfMo/lQGJ/60DljRcyivMJXeb2Zx/qE+PA2M8bkskNw2Yo44NVRtNq7pXlKrdpHc7Wa+Dwfl0P/Tjqz57RNyIqtkf9g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:06:12.8701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9976b632-7e4c-4871-7aff-08df15a724ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000075.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233
X-Authority-Analysis: v=2.4 cv=VKVIDNPX c=1 sm=1 tr=0 ts=6aad6f88 cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8
 a=aqTlLvIN0OOY5lzlLKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfXyYaWoELaY9aw
 l9uROdXETG2WU6SRCNOIOEt8RPj4EluuyT8Z8+UqgEd8mmcGwCjuADRAjq9Tne40YEjCHyigwSQ
 hWD6NvzZIKiOGDB8TZTzxcMyjmVhnBxOreor47/xG3rha7P9Wo3Wy3spnG0hayXCtBxNOJJZ7jZ
 QjxnJ7WziXoR+Qo+HMu63j24MHJZ8/vEXNTp+s5yQn/gVQj1qgrJLmMrpTVwLyyiKEOUYAhhYDU
 9bua4T0YwP9cUfvbzV/lcHrCkHOhjdOYCiZHeVfSfcvdgh+Y5tO4oRNEFaSXGMEPayFUnkLlFH9
 bYyLiyBuEneFn9hyVjP9zUspUNX6RIDzXJzfIHc5CAbumhDTurgZJtQSYv6V4/uN/4ZVaTFAQg/
 HKWV2wPfns/45UNs8eG3DOBq4wqRm2bzg/bryL6zojLnXV2DjkYfID+twUZ7yXsAMmvf7NEgege
 5Htx2esZ0o3cX+0pGUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfX5Ar090a2zPVb
 dELI8/yuaJW/Mkkt4HmZxYkx2+ulhdry0mjQIj1BL9r94YuZQE/GmcjI8FhOAh+DYrtkmM+X+Tj
 PuvUmDPu7LiFjead0CHkzZpBkAFnG1o=
X-Proofpoint-GUID: _vhxCNUx-1okUsSJmootNChgnhHpqx8B
X-Proofpoint-ORIG-GUID: _vhxCNUx-1okUsSJmootNChgnhHpqx8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180245
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

On 18/09/26 11:55, LiangCheng Wang wrote:
> Hi Devarsh,
> 
> Good to hear from you, and thank you for picking the fixes up.
> 
>> Kindly let me know if we are aligned on this.
> 
> That all sounds good to me, and I am glad it is moving again.  I will test
> v2 on the PIXPAPER 4.26m as soon as it is out and send a Tested-by.
> 

Thanks for all the help.

> There is one thing worth settling before you post.  Back in July [1] you
> wrote:
> 
>    Certainly. I'll exclude the pixpaper-426m support patches from my V2
>    submission so you can handle the review and validation on your end.
> 
> That is still what I would prefer: the 4.26m is the only SSD16xx hardware
> I have, and its binding is already acked, so I am in a good position to
> validate the panel and to look after it afterwards.  Unless you would
> rather it went differently, I will send the panel entry and its binding on
> top of your v2 once it is out.

Yes I don't plan to send the pixpaper-426m patches from my branch as 
suggested earlier, you can send it on top of my v2 series as discussed 
in the earlier thread [0]. Also I am glad that those patches helped, 
thanks for validating.

> 
> Please reshape the three fixes however v2 needs - they were written
> against your staging branch and the driver has moved on since.  Two small
> requests from my reply at the time [2]:
> 

I need to have a deeper look at those patches, I had also been modifying 
driver as per pending review comments and fixed few issues around 
rotation too in my internal dev branch, so would want to see if any of 
those changes fix similar issues or not. I may need your help and reach 
out to you again for help with validation on pix-paper once I ready the 
v2 code. Also we can discuss direclty on #dri-devel (my user is 
devarsht) for faster alignment.

>    Please keep them as separate commits if you can - git am preserves
>    authorship; if you fold the first one in, a Co-developed-by with my
>    Signed-off-by would be appreciated.
> 

Thanks for sharing those fixes, I need to have a deeper look on those 
patches as we discussed, but in general :

If the patches are bug fixes then as per kernel patch guidelines I would 
have to squash it to the patch introducing the bug to maintain 
bi-sectability and avoid issues in an intermediate patch, in that case I 
would try to attribute your contribution either in commit message or via 
co-developed tag as applicable.

If the patch is adding a separate feature on top of existing then I 
would keep it as a separate patch as you suggested.

In any case please be assured that I intend to credit you for your 
contributions.

Also since the driver is not merged yet, for any comments or suggestions 
on the core logic, please feel free to post it as review comments on my 
v2 and that way it becomes easier.

Regards
Devarsh

>    I maintain the existing PIXPAPER MAINTAINERS entry - would you mind
>    adding me as R: on the SSD16xx one, so I stay on CC and can retest?
> 


> [1] https://lore.kernel.org/all/8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com/
> [2] https://lore.kernel.org/all/20260731035705.3198816-1-zaq14760@gmail.com/
> 
> Regards,
> LiangCheng


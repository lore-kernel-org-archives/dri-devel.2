Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E60606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=T27Z0gPA;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=hGGSNwO3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16E110E4B2;
	Tue, 24 Nov 2026 10:23:01 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143B610E224
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:22:48 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AO84ApN1303064;
 Tue, 24 Nov 2026 04:22:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VQjLEjwCc18BrhgJGrV3AqJpYF/qFL3t8Kau/rr81
 hQ=; b=T27Z0gPAQqnP1/zuwkTJ42aKQw1F+EX252z4JaorZ2WyWgA0jmpwZMlcj
 yHiVTYMDa6mzllhkYT3pKlGg0YSWf539GVSIopUkgaVxTzVglxkDQV01sPcz3qhN
 yyWn2Z+1vwZzwhw1JFE52aB/YoqPldISk7Bm+jcZLlPrzDLoKU1oxu+mxk4PSCfz
 wD39NWb7MKB2GSh6Yxj5MJwpfNeFn+/4WyzFwttQQhFGgT8kyqdrLRpLPmWLUy1a
 RV33R9XlIGrB/BqQijEKSxLPKQz5MlWpoDQF0fK4loJDu/LtbUSLyHpE+A/s+0TB
 gguZus/wF6rII7keFsNCRKpOd1a/Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j50h82pk1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 04:22:07 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK/V5KjNYVZpdciS/NPolVHmpUopRBZYZrbvEXYrm+Itf3aykA0A7QFls35gWsOYn77PWBmQ2M+KJ+rWYfvgBL4mT34M40cpsdLjaJXjVlbLA2ppMeQPKkG1J9z7Z0yRQ46pbJrsbXrbgOfd/fumj6a6RKFKSu82hz52K3ETnG3vR3uxbcKevA0g9HLTBNN3wrq7mNnU/v16U3KX7c35exnEhs6IBAAshRrFJZ3ZtbqKva2/Vf+aS9+s7brX3Ei+QPgaqvkYYVwm0fcbs3rjqdbMPljqSe3h5muH9E0F75pOS8GbWQFAf2OwJ6BwGuF7k9aF9kcFTqhAdbcNAL303g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQjLEjwCc18BrhgJGrV3AqJpYF/qFL3t8Kau/rr81hQ=;
 b=d9gGihaoZsiKILaJVJwqA7KnoN4IJSMBRbMVE5AjWrlMxFwWirL2qNFhUkbVPq0KPDq1K5GxhHKWhmhQEMTKbcn/bK90DPnEDiwWmTqJxZILzzXPDd+pellZY9G6Sgy1Zny7Hh9HSc/ujOC8Xp1FRFYgi5otP6ozqZi6XngeFkuCgz4wseM+pdE84lYN5ak5K4ZzbYnI3gqZKKY1WF+/qSq1gMiTHHJ/zo6yqgd5bri1IcHMp3NOymvvn46H71YOlm1xRCDtLXRIe5YGJQT+YRph2dlBUnW5BGTm1uOalAA9Ut4wcubcSe4NzDQO4Fhc7J+XlVUr87DzGMyDtcuZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQjLEjwCc18BrhgJGrV3AqJpYF/qFL3t8Kau/rr81hQ=;
 b=hGGSNwO3AZ2y4iudHJNA9ZZjm0Yc8o2nDhIcWVkeSOmG5Yv5q7bJ6dc0QrTduWesTWCWtkKOZv/MdptdsqxI8Lgomxu5jcelKKEKuh1XwVSfgSjB7HbABJECrttr+1Bz0CFokPe6Uid9WdgEQGw8g8X3S1xaqw5DdPTJkA9Ed0o=
Received: from CY8PR10CA0021.namprd10.prod.outlook.com (2603:10b6:930:4f::9)
 by CH4PR10MB8193.namprd10.prod.outlook.com (2603:10b6:610:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 10:22:04 +0000
Received: from MWH0EPF000D8950.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::47) by CY8PR10CA0021.outlook.office365.com
 (2603:10b6:930:4f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 10:22:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000D8950.mail.protection.outlook.com (10.167.249.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 10:22:01 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 04:21:14 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 04:21:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 04:21:14 -0600
Received: from [172.24.19.16] (ltpw0ewr2k.dhcp.ti.com [172.24.19.16])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AOAL8621419832;
 Tue, 24 Nov 2026 04:21:09 -0600
Message-ID: <3c658714-4b23-4f87-904a-43778b7c5b37@ti.com>
Date: Tue, 24 Nov 2026 15:51:08 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Benjamin Robin
 <benjamin.robin@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <y-d@ti.com>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <mripard@kernel.org>, <tzimmermann@suse.de>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <devarsht@ti.com>,
 <u-kumar1@ti.com>, <sjakhade@cadence.com>
References: <20260601095041.3042950-1-a-kumar2@ti.com>
 <f1089720-2a8e-4f0f-b995-fc7ef0836da0@ti.com>
 <73ebfed6-a3ad-4134-a8b9-d17213442fa9@ideasonboard.com>
 <oN6DWNeSTbeo_5NexR3j3A@bootlin.com>
 <e40cd28f-eb52-4205-a799-8340b59c0a60@ideasonboard.com>
Content-Language: en-US
From: "Kumar, Abhash" <a-kumar2@ti.com>
In-Reply-To: <e40cd28f-eb52-4205-a799-8340b59c0a60@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8950:EE_|CH4PR10MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c88b3dc-5cfd-467c-98c4-08df4a14c7b2
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|10067099003|261102123227099003|261021121427099003|56012099006|261022075727099003|4143699003|261009223027099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|18002099003|6133799003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: IZ2QC3rcbsd/tLxE8HR3b3u9SCf+Zy8AFHZLPyEvL5fsIn3kw1e0fi9Jv6heNylxF8x5OUb7oKBRtBb3AyymHph46EOK6mioJncvpEtkj1pBHT/pDoR/oanxwKr8DwM1QQYhhZh1fIPtoHOS8SAXUyGWp1VHm0krym+xkZwSASK/uluP1Gs9kIR4W4lLkjJ5nMxkGK6YN+u3zphD+7lsu8S4uhsn6HU6LyMf692Z1YS09EoDtf4LnhUal2TUxMO0L0I9eD61SqS3mzts0uArDrEi9m8QCDWxFGRueUxOe/NQym86PXmP5hUBTAPCOcbLKbM/kUEmRcFGIc2RcTOMMH5Fn27AtZzZ1gYVo0KTlUBkwZLFPiAlKeZPKQ5qHVlIzeUzQQhylKjl8Cz2YsyoQyfh1GLtA89DO40xaKMa8QsyzRfSg+oWp0r+sCMguV4BzZuAli1g0WwMM8wNl8rqLn6mxgpuIlwrJ6RlpSxBN/LV6Wk5vW/7ulFRnplN6CSwcml5njVVk0G0CfQCEeW0q0JZ0T9TBsMMPVzE+IIzBFoVeAXXKVx43cAIUnGB19FDmjocP8REuoOTF6kU6r9RdgDYHdJh9GYytiBGEFWIC/1P2EwSszEvLuGONg7K9JSRoNs7NA2lchjDWS/8AdhSFjao2mPkx4T75z1xRUU41NM=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(10067099003)(261102123227099003)(261021121427099003)(56012099006)(261022075727099003)(4143699003)(261009223027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003)(6133799003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LtjdR6Qt35fv3wcVJEydeCgeLyKj2uirR05+hj5WjCaqPXn+45HSGySluAQIPdBw/TTTsvL52uEcmPKXD836Al60jnGTsXxq+1J8m5i3CHWuULjJoroIUIV3woORp0ELK3OmC4/cHWkAg8XZNEqW90BHuAanQuDpCe+JTlekQJJdavQkhx/MfN7e+ldG5BkTyN1w/t87/MkKBXkqY+pWWaO5IKNkmbhojf/ZKnH3moYW4wNHMhju/uDgUXwCDe7tBfmbU6EuxN3KYybXNKSOh2z+kpa+cGRddUg2294EMXOsC+XTIF+LqSjNOo0jeWktUQ4VG4iXhnD6QQ5+iEHCQLn0n3DEBX5DIuPoGmiulT3Fs0WITi6Wr9e7wjLL4y/sWLXkBBdYDyWmqHFxxtJbpbOX4oV2ecJt8M7JA442Jos0huuhpwykqk1FA/Cse6Ka
X-Exchange-RoutingPolicyChecked: G2PfgdejJhpq3MpzEiNy3ZWkorDB+ANzq2Twa/kXP7e0dsiSMEuOWu8eqPGGc2EGw3c1fRFUDTTbAOmo6z3f5gxfY6da6oGe6haSDdxR5mKeraaTXQYIZupEWZeHb/e0pqJMTi5efhzGWVYf912Cp7dlIn3nzmLSAH5HhuLN83J2eZA4E/sujf35a1vhqiUeSaathS3KT5iDGPgS07SbBUkfSvZiB1GO2dm7lVMOrlUR589L2QDJkA/nGoe2bjP8gWAAHDUtbiQY4yflrCZB31iWDA4me1twrZ8UWNMZ1a0pdlUxbEGH1mnBV4rpOxNqvDSJ10o0YMPKco39bxVyCA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:22:01.8832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c88b3dc-5cfd-467c-98c4-08df4a14c7b2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8950.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8193
X-Proofpoint-GUID: sd7UeNXi2n3qD0uyuWr252oRkwKS_8ZC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MCBTYWx0ZWRfX+C9tbQdLHtyH
 44rHbMAhkS4IrN7aV/dez0XHMN4dj2TaQMxvMvg7SYvOqaRgL1+kKO4GXrIDVlmUra/MrByOJLP
 urcqkDShh/EdnheXVr8xNg8/A2biFwFEDfk/cHstWlXmn/+yXqokvx9jpFQcqMJ1ss4RRAGGdEV
 io+0fpX3wFewTDbJhkq0bHfWYvBXgT9IQD4aW9JJ+0l18ebubm/KWnyAfcQVu59gUCzdtRkLcZc
 ke4DyHL1q/1rlQeu3y+CED8znyxz/sdVxV/2MYV7HOUJcOewwPRYe6Wr8b9jFYJYIb7fR+cyZnO
 r7naPp/tdsB54WMEhM97pw1IMQJXJlV5FyHbhqprt4vXR8BLXbcEh2m5Xyk/5mYUtI0mD1ySkWx
 fuDFt0/3wWT8YRs7Vdwjm8KBy5hm2ntHYxS9i31GM8jvPJrI18upgPJ5Pt1WoRQHt0oMAg1H8N6
 cDa6hlQv9R/ccjGQiBA==
X-Proofpoint-ORIG-GUID: sd7UeNXi2n3qD0uyuWr252oRkwKS_8ZC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MCBTYWx0ZWRfX9RGc3+2+uXPY
 BJevxjsFgbqsb+VE0Q15iNCQ1bTcGTbYLFDPZkgtiiLWDH4/EhWN7quDc7SMsAEg2PjeMkzt7rb
 5eSiw7I36p7ZzRBUB/4+SytJykxCG7Y=
X-Authority-Analysis: v=2.4 cv=WNTqzXsR c=1 sm=1 tr=0 ts=6b05654f cx=c_pps
 a=XX75RHJXRTy/mnnqXKIK7Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=lB_PhG3i2QB02WJqKkMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240040
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/20/2026 7:26 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 20/11/2026 15:11, Benjamin Robin wrote:
>> On Wednesday, October 14, 2026 at 3:25 PM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 06/10/2026 11:49, Kumar, Abhash wrote:
>>>> Hi,
>>>>
>>>> On 10/1/2026 1:10 PM, Tomi Valkeinen wrote:
>>>>> Hi,
>>>>>
>>>>> On 29/06/2026 13:32, abhash wrote:
>>>>>>
>>>>>> Hi Tomi,
>>>>>>
>>>>>> Thanks for the review.
>>>>>>
>>>>>> On 18/06/26 14:19, Tomi Valkeinen wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 01/06/2026 12:50, Abhash Kumar Jha wrote:
>>>>>>>> Add system suspend and resume hooks to the cdns-mhdp8546 bridge
>>>>>>>> driver.
>>>>>>>>
>>>>>>>> While resuming we either load the firmware or activate it. 
>>>>>>>> Firmware
>>>>>>>> is loaded only when resuming from a successful suspend-resume 
>>>>>>>> cycle.
>>>>>>>
>>>>>>> It's not clear from the patch if this is a fix or improvement. It
>>>>>>> sounds a bit like a fix, but it doesn't mention any kind of 
>>>>>>> issue in
>>>>>>> the driver. So, why is this patch needed?
>>>>>>
>>>>>> The driver lacked support for suspend-resume as stated in the 
>>>>>> todo on
>>>>>> the driver, So the patch adds this improvement.
>>>>>
>>>>> The patch doesn't remove any todo lines. Was that just a miss, or is
>>>>> there more to add wrt. PM?
>>>> Yeah, i will remove the TODO in the next revision.
>>>>>
>>>>> What does it mean it didn't support PM? Does the driver not work 
>>>>> after
>>>>> suspend-resume cycle? Or does the driver prevent a proper suspend?
>>>>
>>>> When we resume, the cdns_mhdp_link_up function fails.
>>>>
>>>> Failure log at resume:
>>>>
>>>> [  55.329452] tidss 4a00000.dss: PM: calling tidss_resume [tidss] @
>>>> 1053, parent: bus@100000
>>>>
>>>> [ 183.381228] cdns-mhdp8546 a000000.bridge: Failed to read receiver
>>>> capabilities
>>>>
>>>> [ 191.391548] cdns-mhdp8546 a000000.bridge: get block[0] edid 
>>>> failed: -110
>>>>
>>>> [ 193.392713] cdns-mhdp8546 a000000.bridge: Failed to read register
>>>>
>>>> [ 261.415544] cdns-mhdp8546 a000000.bridge: Failed to read register
>>>>
>>>> [ 263.946153] tidss 4a00000.dss: Timeout waiting for framedone on 
>>>> crtc 0
>>>>
>>>> [ 391.991358] cdns-mhdp8546 a000000.bridge: Failed to read receiver
>>>> capabilities
>>>>
>>>> [ 392.026847] tidss 4a00000.dss: PM: tidss_resume [tidss] returned 0
>>>> after 336689133 usecs
>>>>
>>>> I guess it is fair to say that the driver does not work after suspend-
>>>> resume cycle.
>>>>
>>>>>>>> If resuming due to an aborted suspend, loading the firmware is not
>>>>>>>> possible because the uCPU's IMEM is only accessible after a reset
>>>>>>>> and the
>>>>>>>> bridge has not gone through a reset in this case. Hence, 
>>>>>>>> Activate the
>>>>>>>> firmware that is already loaded.
>>>>>>>>
>>>>>>>> Use genpd_notifier to get the power domain status of the bridge 
>>>>>>>> and
>>>>>>>> accordingly load the firmware.
>>>>>>>>
>>>>>>>> Additionally, introduce phy_power_off/on to control the power to
>>>>>>>> the phy.
>>>>>>>
>>>>>>> If you write "also" or "additionally" or such in a commit desc, you
>>>>>>> should stop and think if that part should actually be a separate
>>>>>>> patch. Also, why is that change needed?
>>>>>>
>>>>>> The phy device could be powered off while resuming. So we are
>>>>>> explicitly powering it on.
>>>>>>
>>>>>> The phy driver api also recommends to always call phy_init() first
>>>>>> followed by a phy_power_on().
>>>>>>
>>>>>> "Some PHY drivers may not implement `phy_init` or `phy_power_on`, 
>>>>>> but
>>>>>> controllers should always call these functions to be compatible with
>>>>>> other PHYs"
>>>>>
>>>>> It still sounds like a separate patch to me: the current driver is
>>>>> missing phy_power_on/off from the probe/remove functions.
>>>>>
>>>> I will add that as a separate patch
>>>>>>> Overall, this sounds fragile/hacky to me.
>>>>>>>
>>>>>>> The first thing is that usually you shouldn't use system suspend/
>>>>>>> resume in a bridge driver. When a system suspend happend, the
>>>>>>> display pipeline will be disabled, so this driver will get an
>>>>>>> atomic_disable() call, and enable when resuming. You can use 
>>>>>>> runtime
>>>>>>> PM hooks if you need resume/suspend hooks.
>>>>>>>
>>>>>> Thanks for the suggestion, I will use the runtime PM instead.
>>>>>>
>>>>>>> The second thing is the PD notifier. Is there really no way we can
>>>>>>> see the state from the MDHP IP registers?
>>>>>>
>>>>>> The other way that i found was to read the MHDP KEEP_ALIVE_p 
>>>>>> register
>>>>>> twice to know if the firmware is incrementing the counter.
>>>>>>
>>>>>> Based on that we can decide if the bridge is active or not. Do you
>>>>>> think this approach would be okay over the PD notifier?
>>>>> I think it would be best to be able somehow to ask this from the 
>>>>> HW to
>>>>> find the true state, instead of guessing it second hand from the PD
>>>>> notifier (which also doesn't tell us the initial HW state at probe).
>>>>>
>>>>> KEEP_ALIVE_p sounds fine. Or what does the mdhp IP do if you send a
>>>>> message to the firmware when it's not up? Say, if you always do
>>>>> cdns_mhdp_set_firmware_active, what happens if the FW has not been
>>>>> loaded? I would guess that there's a timeout, and that could be used
>>>>> to find out the FW is not up.
>>>>>
>>>> Yes, there is a 2 second timeout if we send a message and the firmware
>>>> is not up. I would prefer the KEEP_ALIVE_p method, as that is a better
>>>> indication of the
>>>
>>> But that's a driver imposed timeout, and it sounds rather arbitrary 
>>> (and
>>> bad). How quickly does the firmware usually reply? What would be the
>>> situation where the firmware takes e.g. 1.5s to reply? I would guess
>>> that if the FW updates the KEEP_ALIVE_p every N us, it would also reply
>>> to us in that time.
>>>
>>> In any case, changing MAILBOX_TIMEOUT_US would be another patch.
>>> KEEP_ALIVE_p sounds fine if you know how often the FW updates it.
>>>
>>>    Tomi
>>
>> Hi,
>>
>> I wanted to check on the status of this series, as I'm quite interested
>> in it since my series [1] depends on it.
>>
>> For my use case, the suspend/resume support isn't essential, but the
>> calls to phy_power_on() and phy_power_off() are.
>>
>> Thanks for any update.
>>
>> [1] 
>> https://lore.kernel.org/all/20261120-phy-cadence-torrent-ng-v1-0-da2db7125cd7@bootlin.com/T/
>>
>
> Yep, it could as well be sent separately. Abhash, are you working on 
> this still? Can you send the phy power on/off as a separate patch.
>
Hi Tomi, Benjamin,

I have posted the phy_power_on and phy_power_off patch separately here:-

[PATCH] drm/bridge: cdns-mhdp8546: Power on/off the PHY in probe/remove 
<https://lore.kernel.org/all/20261124101747.2432344-1-a-kumar2@ti.com/T/#u>

Thanks,

Abhash


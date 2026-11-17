Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637FC606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RqF7pwZn;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=JbWXW9ds
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE54010E350;
	Tue, 17 Nov 2026 10:24:20 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8B310E350
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:24:08 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AH93tUl3664744;
 Tue, 17 Nov 2026 04:23:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=IqAb7rtPQYaSpa63N3MJtjSpwcdc0/xUnVl9YcCxM
 kE=; b=RqF7pwZnUS0fEdoNZdY8n2MsYPXJKNUAccPo8u35PrtXWJQOwEGURsDIk
 XPFYS6V7enAD06swfOcgScPldOpbPPgnFDobPNpO6uc+REpO2rCii4VjcrPl77eV
 poiqPFMnSsE9bbN4wA7hYZpP2w5SSqVZ8hgpDgfUPuE+ypAYwGef2nVJqaDBmD6z
 Rxc88igqoG30MNqbNRX5Sy3grviuS9g0F1TCCegJQ5qyEJPhrzyQjVaX/MWJhCUw
 WJTqwrsHUN2BEdEcft4p49uHbdr/C7FE7mdGpVaYbWjgGCLlhqMD4xnqypq1DHnn
 3+3I+NvTxF98PEmcdILgkqyeOBWgQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by m0380145.ppops.net (PPS) with ESMTPS id 4j0kye0csr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 04:23:46 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr2U7JhHHJkuEDSBOMB6CwQFXG1Wv6DfjU/oIdZdo3804kUPL/sW7BCXUnZGSs01Efs+HeQZpdAkJBJDEmfu217iWTd0kYdlHcyNCmUZycLf+lTlh1LYE+ufbD3a/AzBGYiwtKZ6jwuuHIqeNGw4goz50ht/Au7GVSjln5PzbFdaieZcWlevlcpMKJkBhdCmlF3hE3OXdxs8gLlTh9f7BIxLzgG0pzcTzAGKzCIlfvkI+nN03Qgw4RVLIRH//jC85kOdd2HZd+ZhsGaipPhpnK8nkAsj6wtUI6wPn1KRNsBsPuUwlYonw0DNYxQqhq5th5PZXKTwhLxffZS5P0KiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqAb7rtPQYaSpa63N3MJtjSpwcdc0/xUnVl9YcCxMkE=;
 b=XZLau4yruXgzIUJc4tpj5wp/ZJgqvclTiyfRelOlIQqizNK4Upn5L57s8Ekty8o9svbc24QMhNUCfHf1vviHe3twZZKSN97XK0ep4RMMySfNaIz4Ba/ElTGBzBVMqArnDslRdyWZRTnqqY3RaMPpdD0ovVD6l7LeVlkUEJ0YGV9jQCj/6ReqFD6oc8XupLebZkz9YLU41Q3hYPliGezTebuXSzdnyBO203OapP1XevWoYHzxqJqRrYWHs+9XdgL410BZazZ+8VHrQGNNJxKRc8vKSeBXlmEHeXuBRI06YrA0WImlmffLb0PCM8f0+EBgEC6ynuCJwfGSxCMYqNU+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqAb7rtPQYaSpa63N3MJtjSpwcdc0/xUnVl9YcCxMkE=;
 b=JbWXW9dsbRXABLtX72n2YjmR6AiwBoQtS38mbzYllHD0M1g2B8rPDSQW+dVy+QrxVngut7o6d/B6GiORkDMQjfpBckcOTTFdgzJWkOqFSRDLQttNG/r8S8OpvWPa27MHN6HAL9Y7av0fGl5DuFvlvCM03tjDwqh/Q0ADb65jjZM=
Received: from CH0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:610:e5::8)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:23:44 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::8f) by CH0PR03CA0243.outlook.office365.com
 (2603:10b6:610:e5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 10:23:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 10:23:43 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 04:23:34 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 04:23:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 04:23:34 -0600
Received: from [10.24.53.80] (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHANQ1H2713888;
 Tue, 17 Nov 2026 04:23:27 -0600
Message-ID: <f9ccb586-8505-40aa-956e-ca40a8a0759c@ti.com>
Date: Tue, 17 Nov 2026 15:53:26 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Add no-hpd property to the cadence bridge
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <h-shenoy@ti.com>, <panchuang@vivo.com>,
 <kees@kernel.org>, <r-ravikumar@ti.com>, <sjakhade@cadence.com>,
 <yamonkar@cadence.com>
References: <20261009064024.985688-1-y-d@ti.com>
 <692d174e-eea4-4b5d-97f8-384de96e4eb4@ideasonboard.com>
Content-Language: en-US
From: Yashas D <y-d@ti.com>
In-Reply-To: <692d174e-eea4-4b5d-97f8-384de96e4eb4@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ0PR10MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 267452b3-42e6-46ad-62d0-08df4494db94
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261102123227099003|261021123027099003|261021121427099003|56012099006|4143699003|10067099003|18002099003|22082099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info: N3t32q40Mp3hT891AYn1QFY9EKDL2EzV9EDJLa6ELWqYfCp9ci27yU8xDKYdL/5PJYVfgskihwQ470G/asOFplePIasmsEp2F3VogPXSGiX8/3hP8FLUxwJgo/SPOnC5OgxgkCeceYfeZDGb1e71KWECYob3phUnFkUWKHUpLy/QSIYvkRWa2Q39dOSYsRqzlVRxftXgoYH8WdaqadWlj4c0aIMWFJ/wzOV2LBdLjE871bxJGkT9I5SY+wbE2slgtILJzzqjShMaJgSsGrjN48Tio8wdJEt/nox9mlVAg6kJH7dIp8yKz5cZdjaA1AB99RXsWY2jDeTiO+7UW1jCT5wemlzIp2uIjQAbvSFTS1KlZfwMWIJfAYiCsQ92AnjvGQyZrCRxPf4NkPTTy5iTZaG2ov/dtznrU81lLYXremuC761ldv44eP7kILAaMp2jhjUU4RYms7Dv9dpDaOnxT4MxxOIf/Xotn1O7mj2c2FeTbta1c48bBswCOjBDOCLAPG7G01n7i0fpFqd+OmU2Iuw9vMv/x8P6bAvqWpxXS1eVv4CK2BG70yKQtQyBuzYqzDyyfnwg06J/NiSD/lXVG6CK/HKwZPgQVk/kjHICjRwuaROAi3mZdlXzbENd5zaVMxhnT8FixSt+T5CdAKNSUw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nl1U4vuRdxYKwgCXfRasvMoXicDvtprpv89l05BUSMHWpG5BN41IeH4NwuFw6Dk3dICeBN5jNuG+Pap4rXvoGNCrOwS3Ma3nS32HaZ0JTFEAgft6S/hr8bUyYkq7CNsoClRR9PNbrbDCrqmZrPyY4YcTZ8DnWcdURRsymefQhz/JNl36RXSThUguFNTD+4wZNoQMCJSS8Hk9gjVe+2S6YLjFEHWkVzXXe5m+W3y+MgjTkBUHDm23kgF6ci8SaCXTm+CnLy2arc4WVi1tqKyyoI9ERHm1rVi4rDvGxUpTsJ/5/PWmBZqwzX5rVCLd/1sjN3lfcG4X+A84aFjS+oGs8avlcglW5sO8RaHKmeAZoNAfinMEVUbU4d7JGWFWbFoxy4m48ryMYQyOaZ7Dibe9/0HiQLFkWKd9nxGJwlZ8HR/m4sUp+gvhsvIX9028YwWf
X-Exchange-RoutingPolicyChecked: LO4xfv7ThSdbFVMRUtBO00flPVLs9wr/6xrND1g1nceEVRT1aEZrW+UsC11AZPgTPLYUpsaNjagnfOErZLYg7m7/9UaYNPgrC2YfiCJVYmUY2d5JOqGHpbh6HMalWl0L/Z/wc03Dv2s2GDqUJF6WrSFvKNJcJcXA6LUf7psY77P0Rct9WVqjuE22m4jf1xgEWGLGCDmLY67g47qJ95UuWOWo1JuAEY485EYbMCVFvIjDp5gr61Z/c8Yvb6sH9Bn9hKIwGKWnKfHdc9DeDl6KcAOqZ/pOG5r2yrN8UKODZYSOAK9dieLjbngBRy4jc0RDOmP23z+NzjF49muY2SSIQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:23:43.8439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267452b3-42e6-46ad-62d0-08df4494db94
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Authority-Analysis: v=2.4 cv=bsTZl0ai c=1 sm=1 tr=0 ts=6afc2b32 cx=c_pps
 a=gTn3qzDU66SAkKtIq75K5w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=7hyQLHfocGzWXWNVGLkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NLIGS3v00gDc8fdehq5TIwOHM7GNRGZ8
X-Proofpoint-ORIG-GUID: NLIGS3v00gDc8fdehq5TIwOHM7GNRGZ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX30ykljqBQx5M
 2lAq4NxAFkoUK5+6pDB6Q2vnYdZj9ZF8tEp+7IMw+BPn+SNFJUAXvqevyPp6DE4bGTOsca1ZvAO
 QwWX19Dxe1FJiF1eQZzKtwSOfyIJBYQNHG4Rx6ccdYJf87G6gjuuY2dbVSXUlQ37gcgY6OUlF0B
 f4wTQjyoxCXp4YuxaeO5S0IcjY4dNP9H7v+lYyIa/1ORcJtlhpjSFsrxbHi46w9jtCWhu3I/YDv
 Cs0OIHomtRkb8+QTNu5l3sIb36VMZwEBCrdtr+sL1rm1LjpNjDsVjCe9rrWHCHRAcHzKbmKRovd
 IF6Q/31YgpE/hvDyHHqXpH4UVDnjRIIXepTXFDyPiF7k1e29qnzDpyn8vB/jcD7hQHkNL+4tdKP
 B2ftHL6A6BgNo7iR4IHmWTPXX0UpdubdTRA0oNJxtJ3j0Oj+kUSASQZ0JHIq/oEmvLgHOenzCWY
 fg7zFFqeTJMr/T5Xwsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0MSBTYWx0ZWRfX4zk1BKoK/mrw
 4grMthC4JPoymWEiQ8JXtfXUvaHXr7+RoKquHBWzzCl0SBMjK3UcgcA2eZVh238NpHPZOjV1V7R
 C6AWfizJ5WIMMxD2oNJyIZxb0yzGWXs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170041
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 16/11/26 14:37, Tomi Valkeinen wrote:
> Hi,
> 
> On 09/10/2026 09:40, Yashas D wrote:
>> This series adds 'no-hpd' device tree property support to the Cadence
>> MHDP8546 bridge driver for boards where the HPD line cannot be used for
>> hotplug detection.
>>
>> On TI J721S2 EVMs, the DP0 HPD resistor is DNI from factory, so the HPD
>> signal is not physically connected to SoC pin AA24 by default. AA24 must
>> still be in DP0_HPD mux mode for the MHDP firmware to operate.
>>
>> When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted and the framework
>> falls back to polling .detect() every ~10 seconds. Presence is detected
>> by reading DP_DPCD_REV (0x000) over AUX, with an early exit when the
>> monitor is stably connected to avoid re-programming the stream each poll.
> 
> How did you test this? I can't get a picture on J721E EVM if I apply this.
> 

Hi Tomi,
This patch is only applicable for devices with no-hpd like J721S2, other 
devices like J721E that has hpd should work normally like they did 
before with their interrupt paths. I tested it on J721S2 and the display 
is able to come up with this patch despite not having hpd.

Thanks,
Yashas D
>   Tomi
> 
>> Changes since v6:
>>    - Reverted back to dev_dbg instead of dev_err for the normal hpd case.
>>    - Picked up Acked-by from Krzysztof Kozlowski from v6 on the 
>> bindings patch.
>>
>> Link to v6: https://lore.kernel.org/all/20260802153825.1570435-1-y- 
>> d@ti.com/
>>
>> Rahul T R (2):
>>    dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd property to
>>      the cadence bridge
>>    drm: bridge: cdns-mhdp8546: Add no-hpd property
>>
>>   .../display/bridge/cdns,mhdp8546.yaml         | 11 +++
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 69 +++++++++++++++++--
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
>>   3 files changed, 75 insertions(+), 6 deletions(-)
>>
> 


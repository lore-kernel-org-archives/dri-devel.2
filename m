Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2286CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9662810E843;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GKxjNxRD";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vOBymiLZ";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C58410F9F8;
 Fri, 25 Sep 2026 11:17:18 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P5JRPj2451762;
 Fri, 25 Sep 2026 06:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XIyx2SAahJf3wBURGFcC5TZG1ryA3s9g/CkuGeMFh
 lc=; b=GKxjNxRDbQHlUND2kZwf7k/hub7EfV97Hb9ZG7iUSTypCbcksU2m6ne9m
 LfXR/7UFyrfSyW3m4kis6kkaNJNgUlzMjQPB2IPUtMN4pZ6ycqbpexq0Yq7quoem
 3BOMvavBu3mcFlNpxzvOGbu+zydxCic/5eYYaPTYPJfvu1A4efE3E1J+r+mij0yg
 3RkBAo+IJgLhfINs+B4xQmj/O3B10df7NMV2myYEFckp09Wk01dudc0EqfghjmkC
 QfGU29swSzac6Vak9JOegD+USlfgLXlTq0dlolPKy/VfVq9CitWv/kwYGoljVvUG
 Au4kQR8SupGts5d9MuQi9xaVCI6CA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gwjq49ks2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:17:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNV9aewLlgjvXVk4XeRuvv+zjotlEmrlFSeYO/KE+TftqqqTuRDvD/UQumkvzRcbu2C5P22y8ZFvR1MhU75vIAnU87i1KQ1fUtDPZvxcpH2NGCKb1Dhss46JQTcAokve5Va4YMIRNm1JWcGicRURSoGtpLFy7BMRbTdZjzFEWb4NUe4TlckP2dZwEQBUMBuVhsebEvVtCkUGStsECLyahE7TUWrdMf1Qy9FIq6laSt/q1yDQ5gQ+iK86SQz92y3mRW8eUwtjgD26usZVEUoYzoy1NI1EOre43XagXFzXMp2XPtuHHDhSO+SVWtdfGnm8u4J+PHHPqHpFZ/aiiHQBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIyx2SAahJf3wBURGFcC5TZG1ryA3s9g/CkuGeMFhlc=;
 b=k4BzNtlxFj6Tya6QBJyXAWj+TQ2E+H1d4RlYQD+iVc0Alh+3QfWLhxiF9SpacyKYeG6TluWE+dRXx+lGbQ1u7cKSjwh2Ozqog5dde7ASjZg/Jclilm+R3rdPZ+oNmrfUupT1uFPOkJQoDq9n6QT78VE3bJkSVIoUhjA9u/isX3iWSV3ivf5RjpW7gUJQSUmFbnGLeweO7aOMQ4WY23fTl1xl6yIS4w3zOLgX1NJAD3VGJkuZIzERU8B4T73JX26RmPlnrwgfmohnMSLthrkOtpoXI84uo9jPLkfc//pXv0uUAdhNX6qT4xoLXJOZuI28IKagxgCCaxXZKMoWKhxBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIyx2SAahJf3wBURGFcC5TZG1ryA3s9g/CkuGeMFhlc=;
 b=vOBymiLZ6uZF/NLXRvq3yPBK2UJ3fhFElphq1U/sfwGjdoddAYASlJUMg4rueyLODPljV9VMs+xAB2kMIRj44z0AkiiVpDdGAgSNyHrsey+wbFyZhjp1CeCw5MisdtYgfRYFmohoFRTMbxcK+zeqVKFH8pdLkCaCWiYWzfmgV3E=
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Fri, 25 Sep
 2026 11:17:03 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::53) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 11:17:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:17:03 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:16:47 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 06:16:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 06:16:46 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PBGe7E1744494;
 Fri, 25 Sep 2026 06:16:41 -0500
Message-ID: <386f23e4-d573-45f7-9e2f-fe47015a4761@ti.com>
Date: Fri, 25 Sep 2026 16:46:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap
 <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, =?UTF-8?Q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
 <Ritwick.Sharma@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <arZB2s3HOBgSRuE4@ashevche-desk.local>
 <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
 <arZIqk6wgV_LF0rg@ashevche-desk.local>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <arZIqk6wgV_LF0rg@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fa3369-8d66-4725-5051-08df1af686ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|10067099003|3023799007|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: iJfffragE+BgmbL9nEkv6fmYcUDJIP+KoPQOBKOjDrXjpZx8kSsx8vvQU/gAV+EspRQIhR0dYDZLHFT9vJWbz2yWeAQNcbDXLTBNyDg40zMKsiACzz415WLwAYRS3wCTKBaJ2ISHwXVYObR6LKz0wkpG7dUFJ5MQmne+UM7wyTEl9oiy4L3xNJaaEkci7yNspt7g9ppsKtYCPm0JtB867mTRRmLgSJG6Nd8fb+o8vaiXxfCoEls19ssf1j1ODZVMJdd7qf4hVpFzpAIL4Dn9ti1RlvyhJBs5Oyk0dZ6pWRePMsbf3IaIiONJ9DPkXRN56ibzW/uTqN2DghuzNiYHaoaRexM+fl9EUq8u3R+eu3vd2Gn4fe3tThqNzexWEIajW9xOhW0hy9+lXf6RBUrbolAaeENNMGoNvAeMgtEQ+D9SWz7HgxbpgheKz6IgyHH0LHLBnXz2BBfV2ZRcKCviRFWiRudEF/b1g+EY16KB40JYVeR5hXvFST+fkUKdJ/PQA6fvCKktKByA+dMeUiHHRn5xav0vGil1PuOrNNtq4gW7ucLwoYDgBznftrgTaNUjtZ5iCQ8U/v+lk4vefljJLGIkMpqwhhNEra0d3NJbkyDio+N2tw95D3XnIongwAlHlHqB4+d5LBjieQ2B1UVYsbSc9AjU95QWdqX7M5bfVOrYkx1hN6ZDVZCDwSJp996icXm4IukFeMYc2O3JtU32QQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hrcVSue++rJPdOIZSM2+S+4FLcriMRx7pBK5z8po66JBFfOzOr7iDFG3HqWDEgjSMmAI+X5gRCXAn7+dQ0vS6Xv+e2+69Io4OMx15M0caGFUnxwF6kZwYWpLgmjSzaO0GgW9qS0Lq9mEoEn1TvquW3PqJW7AHgv/+8+zjupCgISSO5yzBZnEJqPtGMneA9RPZ4zrFqOJ/hVuleesIJl14O7RYgn37YgZizb+sYvtzjWru/pjRDr8+zKPDlMHt+WFbQA8Js6YP+vZUPZpVtXESlBkhmkM1h5b60QOAzMofhshgqWoJP0n3ewYjizHSRQaCy/LTiOCXCA2YKeIxkvUwWqZIjhu8v8pMzh7RHx3bnyYaK6pqKATYh+WxygMk9YO+f7g3Tw8QpYT2SFQSw3mcZl5oRrjXDOu7Tx96A0g3zcN4j3GHrvExpRi9oFJKf2F
X-Exchange-RoutingPolicyChecked: BaBWYcSWWjJmBic3yH9uHmRUaf20PwyWLGypKEOFkcmsVlp3blPbz2TUbmgkHwnHzIU8bc+Dy/gBncizhHZSpxTgr+v3G31U0NXCcCgEQLRCUsHHsEtqQi9XAmP4o8JT6Ti/AkxcRKBoUfHENzJw4X3c4yRi+yDBP3vOYf7nw3MjhQKLcwdghNMI7gA3YJWIrofC3Hg9Y+n16S0KYaRxD9zNjEGua/AazBQy2kM+ULmSU79nMQy8/yQMWn3lYEDjoRDmGNmCR2wVw0JwAK2K9tyw2F8dqT4OkdEWooSL1POz1WKGKkFviidaUmuoW27FQnJz71p9bTeI3ihiLdFGRQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:17:03.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fa3369-8d66-4725-5051-08df1af686ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Authority-Analysis: v=2.4 cv=H+pOUOYi c=1 sm=1 tr=0 ts=6ab65833 cx=c_pps
 a=1mmXF8F6+aLADKsbn3w/2Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=i5NoCwuDJtL8YAqGO14A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sPz7Fcvq_K_iC271kGx_1cc4zqfdtcMn
X-Proofpoint-ORIG-GUID: sPz7Fcvq_K_iC271kGx_1cc4zqfdtcMn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX8RaFa6jeARxp
 L2D6IU1Fknk2HlHUVOR5WjMk5RDwUwAWJob+WglV56CUS+aKoby/7laOEr3WgQdvQC3Cj+ItW1h
 I/vdOoXJZe/CV6xLbcim4AQ84aZRJdI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX3aXZgA8eF4IZ
 IGDtOwRZNB/4xONemNGf7T8aylZT2SNTcBYqvbEF2V89u7qMz4ji9JI7dQ+rSjPtizhXsr3s6ym
 wSt35Vn5EZxGqheqRxKmFGNFPIO9N0MzOn2GTyb3V2WP1CcoqbbWbFO9gFOblfkiM3Sjz/l/WDX
 UgXv+PM1YobpgJ+byutpoDAmJYB8sYNfifcrpU48h2J9VcV37Xnal+tHOfcxKZ9oTkctmMD+8Q9
 yXoIgTbeB3e65ird9ymE4y4IiZXtdKudCu/CCxpP6oFYSiPzoFg7THD6JMReSsDrjtK9aygzjuK
 EnMX1pmwyeOiHuhUU2uS8szAio3nRedk2Z0P4TfqyY3kiGbSfCx+GuoehFNIdXkWW1cXYW9CvzA
 YyS1Td8cZ2myGgDYfJh3cbwg8Y55R33MD4U2glJbPxdKkejrGwrT1j0cB1sIhpLCHgv0zDq/fyJ
 bs7ONtBOgZ8aFZ2lfsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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


On 25/09/26 15:40, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 03:29:27PM +0530, Aniket Limaye wrote:
>> On 25/09/26 15:11, Andy Shevchenko wrote:
>>> On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:
> ...
>
>>> Still doesn't look good. The current register layout may be left as is. What
>>> you need is translate it in the respective regmap callbacks in case we are
>>> enumerated on the different IP. Also possible to have a different regmap
>>> config for the different HW where you translate them only in one place.
>> Is it confusing to keep using existing offsets in regmap_read/write() call
>> sites for TDA54, and let the regmap silently handle the translation?
>>
>> Given that we do *not* have any new registers in use on the tda54 version
>> that were not there in the original one, I guess it works... will send a v4
>> as per your suggestion.
> Depends on the mapping. Your series also forgot to provide the differences
> Check this as an example: e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi").
>
Ahh sorry about that, will remember to add a clean mapping in cover 
letter of next version.

For now here are the structural differences:

1.  Reg offsets  Existing        New TDA54

     [DW_IC_CON]                     0x00           0x2c
     [DW_IC_TAR]                     0x04            0x30
     [DW_IC_SAR]                     0x08            0x34
     [DW_IC_DATA_CMD]                0x10            0x80
     [DW_IC_SS_SCL_HCNT]             0x14            0x4c
     [DW_IC_SS_SCL_LCNT]             0x18            0x50
     [DW_IC_FS_SCL_HCNT]             0x1c            0x4c  /* same as SS */
     [DW_IC_FS_SCL_LCNT]             0x20            0x50  /* same as SS */
     [DW_IC_HS_SCL_HCNT]             0x24         0x54
     [DW_IC_HS_SCL_LCNT]             0x28            0x58
     [DW_IC_INTR_STAT]               0x2c            0xc0
     [DW_IC_INTR_MASK]               0x30            0xc4
     [DW_IC_RAW_INTR_STAT]           0x34            0xc8
     [DW_IC_RX_TL]                   0x38            0x84
     [DW_IC_TX_TL]                   0x3c            0x88
     [DW_IC_CLR_INTR]                0x40            0xcc
     [DW_IC_CLR_RX_UNDER]            0x44            NA
     [DW_IC_CLR_RX_OVER]             0x48            NA
     [DW_IC_CLR_TX_OVER]             0x4c            NA
     [DW_IC_CLR_RD_REQ]              0x50            NA
     [DW_IC_CLR_TX_ABRT]             0x54            NA
     [DW_IC_CLR_RX_DONE]             0x58            NA
     [DW_IC_CLR_ACTIVITY]            0x5c            NA
     [DW_IC_CLR_STOP_DET]            0x60            NA
     [DW_IC_CLR_START_DET]           0x64            NA
     [DW_IC_CLR_GEN_CALL]            0x68            NA
     [DW_IC_ENABLE]                  0x6c            0x04
     [DW_IC_STATUS]                  0x70            0xd8
     [DW_IC_TXFLR]                   0x74            0xdc
     [DW_IC_RXFLR]                   0x78            0xe0
     [DW_IC_SDA_HOLD]                0x7c            0x5c
     [DW_IC_TX_ABRT_SOURCE]          0x80            0xd4
     [DW_IC_ENABLE_STATUS]           0x9c            0xd0
     [DW_IC_CLR_RESTART_DET]         0xa8            NA
     [DW_IC_SMBUS_INTR_STAT]         0xc8            NA
     [DW_IC_SMBUS_INTR_MASK]         0xcc            NA
     [DW_IC_CLR_SMBUS_INTR]          0xd4            NA
     [DW_IC_COMP_PARAM_1]            0xf4            NA
     [DW_IC_COMP_VERSION]            0xf8            0x100
     [DW_IC_COMP_TYPE]               0xfc            0x104

2. DW_IC_CON bitfields:

     DW_IC_CON_MASTER BIT(0)                  BIT(0)
     DW_IC_CON_SPEED_STD                 (1 << 1)       (1 << 4)
     DW_IC_CON_SPEED_FAST                (2 << 1)       (2 << 4)
     DW_IC_CON_SPEED_HIGH                (3 << 1)       (3 << 4)
     DW_IC_CON_SPEED_MASK                GENMASK(2, 1)  GENMASK(5, 4)
     DW_IC_CON_10BITADDR_SLAVE           BIT(3) BIT(8)
     DW_IC_CON_10BITADDR_MASTER          BIT(4) BIT(9)
     DW_IC_CON_RESTART_EN                BIT(5) NA
     DW_IC_CON_SLAVE_DISABLE             BIT(6) NA
     DW_IC_CON_STOP_DET_IFADDRESSED      BIT(7) BIT(10)
     DW_IC_CON_TX_EMPTY_CTRL             BIT(8) BIT(11)
     DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9) BIT(12)
     DW_IC_CON_BUS_CLEAR_CTRL            BIT(11)  BIT(14)

3. To clear INTR,  Read DW_IC_CLR_* reg    Write bit to DW_IC_CLR_INTR

As you can see, it's an entirely different mapping, which is why I had 2 
independent enum -> reg offset maps instead of offset -> offset 
translation.
Similarly, selecting a CON register bitfield layout too.

Let me know what you would prefer based on this...

Thanks,
Aniket


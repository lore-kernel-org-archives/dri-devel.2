Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2B7CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA4A10F343;
	Thu, 18 Jun 2026 15:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YJWfn4jY";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BEwr2SoZ";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E4E10F343
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:42:58 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IFHS2T1004202; Thu, 18 Jun 2026 10:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=40+MlNEtyIg4/LHlr7w6b2HBMLswccnJ4iaJDQog7
 BQ=; b=YJWfn4jY8b1/aH/hu5gJv81LGF7LCj9zasxe+4CNs9duUrOv3mybBSGPv
 Lo8PXvJz7vCk9M2Hl/zr5KEcZprxBsPBxOs8dHB1W8BMevdJeFkCdXZbRIYkB9gm
 eC4Dvf02sg7YLjdrMOSRyEigpll1+EyJKc7LKdkc6PWLBB1DjzusimLw9C6LXkqb
 eb/X3NlwgwuOf0MCvpzqi99TOCmSPOKmWhwm7ick7v8z5wLuGJjR3rS57ncEjARp
 gYrXd1HgxLVpyj0YMzVn+1Fr/3qdbVmJPEP9TO9vcf4K+Fuelf5Dpw2OlBhE2XRr
 Rp1nKWnX/wupSkEhqv8yYKgaTCzQw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4evfuxsdus-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 10:42:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+WndVOUwAkztXeUtibyh1hkPcHoYWFwV0M7/bLWAzGFLQc3qS0u5bTtOLhWOypTIjVi4NWD2ZtaGhAy4R4a5FyEn381/Es7B03xsh7rACM8QvJOS5BE28T2C1cSraBiu381GbNkK58PA93ITDvJ3C86g3mfHOiXPdGNGC1h8bn78tjTJCdbxvtY/DYI+SaUVzz5vU655Txy/ql0dGwePrT6kr7ratjw4Gb3BcDCev8TEWqmK6XrxTUUvaZ4RtjO2sPwRARS7iBxkC1t9PE7TKNeFK8k5umFKT060ccySCzjvHp4qSQf8qLvKK9BLgR8QWK0HLOwOU34ZJHeU3l6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40+MlNEtyIg4/LHlr7w6b2HBMLswccnJ4iaJDQog7BQ=;
 b=cnSy7WN14vPzx/xx70qRDUffYtG9nyYae6pcULAKpXpMdKe5ZtJ/k50VaF9H1PlJG1LLX0vrh0UvfUQ6W5XGhVlC387lZ9fGRVx5Zy+Xa//JBTCAWfs04Zss0eS1euyhUnhJv4UX8z1FlKaNIodDBIIyW4nKcUAqktT3EjOHAAqAKzdhixvuVmknsK/8VbfWarwTXi9TVsHejwuTidZGb/qzjQwtLoypvnNlihcG9iekSceGWyjoFujdXxkgfQx3sNQMQ1GjVXQSWlO3QlJ6kGFncTspgLnO0raT48qFGBDkMUH2ufFeeNT3Eb6IK3CCY1ks/9MxrO9rDDH6CEJTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40+MlNEtyIg4/LHlr7w6b2HBMLswccnJ4iaJDQog7BQ=;
 b=BEwr2SoZAy4nNduu2iFLnAJHaySohfxrA4+6+2pRJpAVHk86ZsCmlMfJSaIYzUf6rDdT4rn3h/TOIgk1RbnztPSHMUc5My1hKoBIjy3ygZI9hbbminbRqlpN4nchtQ0RsUvPzYZoArc54JIVgpnHT+gbYL++ty0WLEXl6mPjzQw=
Received: from BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18)
 by PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 15:42:41 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4e) by BY3PR05CA0043.outlook.office365.com
 (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 15:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 15:42:40 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 10:42:18 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 10:42:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 10:42:18 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65IFftvT128733;
 Thu, 18 Jun 2026 10:41:56 -0500
Message-ID: <e14de1da-5d1e-4086-a713-246ebc15603e@ti.com>
Date: Thu, 18 Jun 2026 21:11:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/tiny: Add DRM driver for Solomon SSD16xx e-paper
 display controllers
From: Devarsh Thakkar <devarsht@ti.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>,
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <afd@ti.com>,
 Sen Wang <sen@ti.com>, LiangCheng Wang <zaq14760@gmail.com>,
 "Aldea, Andrei" <andrei@ti.com>, "Judith Mendez" <jm@ti.com>,
 "D, Yashas" <y-d@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
 <20260430183311.2978142-4-devarsht@ti.com>
 <9b35f7c0-f326-4f42-bfe2-82160495bd53@suse.de>
 <eccf407a-c469-4744-a56f-aa7366c58be3@ti.com>
 <182a7cd1-09b0-4ed2-bcb7-0924adb30375@ti.com>
Content-Language: en-US
In-Reply-To: <182a7cd1-09b0-4ed2-bcb7-0924adb30375@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: b3229645-9931-40b0-b9af-08decd503b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|6133799003|22082099003|18002099003|18092099006|921020|3023799007|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: w/mBhnR3t13/gGubZ7oFbsVb3RSa/RKb7euHqY945ubttAXuXjsRI3CznPQOB6PDwcvBzK7px7bf/7xGWwjjRBS3auo/rBlNB+w5QrocA6HOMPtPbno8t7gUBEsCZvTmvOnJeT6O5Tfd1XYDvamze76wGr/lkKV0kpu5mcnNY2v99v9hBkyI6HRVRw3AFwzysfK8Y++v+pf+AO4VVUgtK/9pwjc2KPE3BkBqEiAj7joalfd9HY9rEnOL5RUvkiLYVirDYVcMMgXjlzmhI9fIaLpNRaOrMGUV40yW24nn5O/vW14Wi8kXBGGNdFXhk9GhUIbnZBznTDw+ZKFNjiKSunqbEY4xKgt3+QHgyDBmXmlINaWKXkfJ+2hk73PgtLTfkG3vh8l3tWEatvWN6o7P3s97DCnE1+ILbEeN9rgnzJTiHce1Ljsr0NeKiwoly00DPBVCED1B/UJpPhEbHZpLqyHx/2Hzzxem1TgmIR7U4Qx/7UwAQF4f3IC3dqnLJ3i8ALVHP6QOvk7hJ2e1vEd9Vlc39QHfhfMU0jj3nqxa5mppqyC+sgY6mQoYWwJ2RYKm9y6lgx+E+CHx1tBiG3VntKxWidk5CjuS5L9a5KdzOEA72qV0wXWwZ/mLUjOCQu6wMLc88SH8HQIid3t6XaWKRGF+4vGvefhNv5Thh0XO9tiVWPN+bdX4OknnR/oKkaTaSC8ly2bmH4niGJob2oPlhEAvBysc+g3nlFmDQxzZy64=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(18092099006)(921020)(3023799007)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jsl+cqAh4bfyTuMKO6RHOYsX6nYyFDJtD3Yl3it4sGxV0bBD4vWjni15b2RwfZ4Si7wFPaBT8JZ+3jduyTSQuTQriBNTAQLcLGVk5nFWqkt17mV7YH/M3XAn2mK4KR1Md7GSOyNdIhPyb98uIg6HiU6Ms5EPdMrLgCNK839Nud1qFBxZgCYyIcLM+KKjVlEghQpn2R4oQEmJc/hH7vq7dDFMd66o9e/6sbwj6gUVfXDj+4uIy6ps1sutvHh5uKxgj05BacRe7UVl8VrZsFt3uy08RkURQfSlncizBjgqwkwcjFmBsxN3FjEbziySCnIynDO29mQ9G/K5c9jxS3SY89IzsI9l/Ujqox2OJm5hNqKolXKbdQ8mFTivco+H6PrR5HJEkKC6mNtF/+SAoYZKbh7wKx+ntUoQcR+xogzryX+Lf6HhJPA255gHOj6H+FR0
X-Exchange-RoutingPolicyChecked: LGoBh9xIRoiaUC33vwF2nQ1kil2LD/1b/Y+/FI2HQHH3VJUdmORd9VBKuUuR8D+hj1FGVEGoOVlIdsMbRxf44+5rXZgGoy77lXnQlW43QcOulasAVa5N1tz9ShhR0Ii2/xprTdGnbmTwcEvnDecyIAcu7VEo1n7hkkUKm9DurObHqbpp0gkqrLX5tBWx9azgJJibIlOIchZRahb7AkJAS/Qytp4lhXfxsCzFsrZwfsrSvEzcMKh1UJsv+vWj5ekhADVO3yeDUXAsU44ojHyPSAGcRohF+0Oji0qZGNwp9RiW6fgGCvkev1sA1ShMoZHW/iQrR1JtAJAb+K4Immph0g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 15:42:40.4137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3229645-9931-40b0-b9af-08decd503b13
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfX9ms5r9oevzo9
 l/67uF/WVDWdPNTTrIJN6Q9XGxq/7zv5k78HE7zt8tqFVme7IRIkZ0wd+JtdBn5sfJ3zmfKTKoP
 f05mPhSN2On+ft4beb6Nm7PzqJARLM0=
X-Authority-Analysis: v=2.4 cv=DOy/JSNb c=1 sm=1 tr=0 ts=6a3411f9 cx=c_pps
 a=2pTyoxkMaluYXS6DGsynPQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8 a=M-04zTVm1aisEaLQfEwA:9
 a=pxpBcc7xTjV5Jc1i:21 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=z2U-W3hJrleVIN9YIjzO:22 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-GUID: DwTek-Yq_XCmQ-vJyhU2xJqCYMOoGIQg
X-Proofpoint-ORIG-GUID: DwTek-Yq_XCmQ-vJyhU2xJqCYMOoGIQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfX1Q5K1UwBksKX
 AkQoarCxxaZpIQQl+h/vQEyPbWwrhGb8G0nL0O7sR1zSPYaF7uHbHmOY2ERhmnwavdURKneQZnX
 oQ7d1wvrUedx70MskPxdmm9Tp0Y6QWh5pspTxe7hc23FKimcnE0M1GMOzvFrFRN30lV3scNGWlK
 Hgdlt/ENswi9psesKJDEYz1P08YtBTOwqjRLLFY63z1O4zJlz3ywzVrE5Sdr/O0R3IC6+KIuMo+
 Jm6qKkYEwqsG+4VMs95efNzRA1Q0noGkcmfkh68y0J/Sdt7/7zTdRb5nRKtf9YIJVWJZqdC3ljn
 GqUrl/mZA/usXzcbqNj7UonGTjAdXn2uXtur9Ub5r+GoFAnG5yUps7VeiJ98EgK5ithcO69Mb9N
 H4ucNV6Jh2RAPSS9bhTN9KRZf/8Mypw5hMP7Eq0LByE/no6WTFxv+EClGeOGnuqOTdQ+xVQ5f2r
 1/dVYCkJdkBb72Ow1Fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180145
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

Hi,

On 17/06/26 17:17, Devarsh Thakkar wrote:
> Hi Thomas,
> 
> On 08/05/26 21:42, Devarsh Thakkar wrote:
>> Hi Thomas,
>>
>> Thanks for the quick review.
>>
>> On 05/05/26 12:35, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> thanks for the driver. See below for a review.
>>>
>>> There is support for Solomon SSD13xx in solomon/. You should check if 
>>> the new driver belongs there.
>>>
> 
> 
> Just wanted to follow up on my response [0] to to your v1 review where I 
> had addressed your comments/questions inline in the thread and had a 
> couple of questions as I am preparing a V2 patch for the series which I 
> am planning to send soon.
> 
> Would really appreciate your thoughts when you get a chance.
> 
> 
> 
> [0]: https://lore.kernel.org/all/eccf407a-c469-4744-a56f- 
> aa7366c58be3@ti.com/
> 

<snip>

>>>> --- a/drivers/gpu/drm/tiny/Kconfig
>>>> +++ b/drivers/gpu/drm/tiny/Kconfig
>>>> @@ -215,3 +215,16 @@ config TINYDRM_SHARP_MEMORY
>>>>         * 4.40" Sharp Memory LCD (LS044Q7DH01)
>>>>         If M is selected the module will be called sharp_memory.
>>>> +
>>>> +config DRM_PANEL_SSD16XX
>>>
>>> Just call it DRM_SSD16XX without the panel. In DRM, things named 
>>> 'panel' are usually built around struct drm_panel, which doesn't seem 
>>> the case here.
>>>
>>

I see drivers/gpu/drm/tiny/panel-mipi-dbi.c [0] using 
CONFIG_DRM_PANEL_MIPI_DBI [1] in the same directory, and that driver 
does not use struct drm_panel either - the only drm_panel reference 
there is a call to of_get_drm_panel_display_mode(), which is a DT 
display-mode helper unrelated to the panel framework.

Given this existing precedent in drm/tiny/ itself and also for the 
reasons explained below as this driver houses both controller specific 
and panel specific logic, I would prefer to keep DRM_PANEL_SSD16XX. 
  
  


>> Oh ok, I preferred DRM_PANEL_SSD16XX since it also enumerates and uses 
>> panel specific data/compatible such as this driver supporting 
>> gooddisplay,gdey042t81 and more can be added too (just like panel- 
>> ilitek* for e.g.) unlike controller only drivers which need to be 
>> linked to separate panel drivers.
>>
>> Do you prefer to change it to DRM_SSD16XX_PANEL to not conflict with 
>> DRM_PANEL* drivers and for better context or still prefer to keep it 
>> as DRM_SSD16XX ?
>>
>>>> +   

<snip>

>>>> diff --git a/drivers/gpu/drm/tiny/panel-ssd16xx.c b/drivers/gpu/drm/ 
>>>> tiny/panel-ssd16xx.c
>>>> new file mode 100644
>>>> inde`x 000000000000..b232837c54ff
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/tiny/panel-ssd16xx.c
>>>
>>> Again, remove 'panel'.
>>

Also for the naming too, I'd prefer to keep panel-ssd16xx.c similar to 
panel-mipi-dbi.c [0] for the reasons mentioned below.

>> Yes I can remove the panel, but I am just concerned if it won't 
>> mislead folks to understand ssd16xx as a controller only driver, 
>> requiring a separate panel driver to interface with ?
>>
>> Basically panel-ssd16xx naming was chosen since this driver houses 
>> both the ssd16xx controller context and also the panel being used 
>> along with that (similar to panel-ilitek-ili9881c.c) and i did not 
>> want to confuse it with a controller only driver (similar to 
>> tc358775.c), if it is overalapping a known pattern reserved for 
>> drm_panel drivers do you think we should rename it to ssd16xx-panel.c 
>> instead or you prefer ssd16xx.c as more appropriate one ?
>>

Kindly let me know if it sounds okay.

[0] : 
https://gitlab.com/linux-kernel/linux-next/-/blob/next-20260618/drivers/gpu/drm/tiny/panel-mipi-dbi.c?ref_type=tags
[1] : 
https://gitlab.com/linux-kernel/linux-next/-/blob/next-20260618/drivers/gpu/drm/tiny/Makefile?ref_type=tags#L8

Regards
Devarsh

>>>
>>>> @@ -0,0 +1,2548 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * DRM driver for e-paper display panels using Solomon SSD16xx 
>>>> family controllers
>>>> + *
>>>> + * Copyright (C) 2026 Texas Instruments Incorporated - https:// 
>>>> www.ti.com/
>>>> + *
>>>> + * Author: Devarsh Thakkar <devarsht@ti.com>
>>>> + *
>>>> + * References: https://github.com/Lesords/epaper
>>>> + */
>>>> +
>>>> +#include <linux/delay.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/property.h>
>>>> +#include <linux/spi/spi.h>
>>>> +
>>>> +#include <drm/clients/drm_client_setup.h>
>>>> +#include <drm/drm_atomic.h>
>>>> +#include <drm/drm_atomic_helper.h>
>>>> +#include <drm/drm_damage_helper.h>
>>>> +#include <drm/drm_drv.h>
>>>> +#include <drm/drm_fb_helper.h>
>>>> +#include <drm/drm_fbdev_dma.h>
>>>> +#include <drm/drm_fb_dma_helper.h>
>>>> +#include <drm/drm_framebuffer.h>
>>>> +#include <drm/drm_gem_dma_helper.h>
>>>> +#include <drm/drm_gem_framebuffer_helper.h>
>>>> +#include <drm/drm_probe_helper.h>
>>>
>>>> +#include <drm/drm_simple_kms_helper.h>
>>>
>>> Obsolete. Anything you use from this header should be open-coded in 
>>> the driver.
>>>
>>
>> Agreed, will remove it in V2.
>>
>>>> +#include <drm/drm_print.h>
>>>
>>>
>>> Please remove all of the parameters below. They might be nice for 
>>> your debugging, but they do not belong in the upstream driver.
>>>
>>
>> As mentioned previously, had kept these params mainly for legacy non- 
>> drm fbdev based applications.
>>
>>>> +
>>>> +static int rotation = -1;
>>>> +module_param(rotation, int, 0644);
>>>> +MODULE_PARM_DESC(rotation,
>>>> +         "Display rotation (-1=use DT, 0/180=landscape, 
>>>> 90/270=portrait)");
>>>
>>> Please remove this. There is a rotation property in struct 
>>> drm_connector, which stores the rotation. IIRC it can be overridden 
>>> on the kernel command line.
>>>
>>
>> As I understand you are referring to below fields from drm_connector 
>> struct, please correct me if I am wrong here but I think the rotation/ 
>> orientation functionality supported by ssd16xx controller does not 
>> match much with below model but instead matches what is done in 
>> drivers/gpu/ drm/drm_mipi_dbi.c (although that does not support 
>> runtime rotation) as explained below  :
>>
>> drm_connector (rotation specific members):
>>
>>
>> 1. panel_orientation (display_info.panel_orientation):
>> Readable from DT via of_drm_get_panel_orientation(), overridable from
>> cmdline. However it is not writable by userspace at runtime (which we 
>> require). More importantly, when Weston reads panel_orientation it 
>> applies an output transform and then attempts to offload rotation to 
>> the plane via plane.rotation. This model assumes the plane can 
>> geometrically map a 300x400 source framebuffer to a 400x300 CRTC i.e. 
>> hardware scan- out rotation. Our driver has no such hardware as 
>> explained in detail below.
>>
>>
>> 2. rotation_reflection (cmdline_mode.rotation_reflection):
>> Cmdline-only (video=...:rotate=N), no DT path (we require both DT-path 
>> and runtime suport). Also I think this is strictly for in-kernel 
>> drm_clients and also It currently returns false for 90/270 unless
>> the plane has a hardware rotation property.
>>
>>
>> Both paths therefore ultimately require hardware plane rotation that
>> this driver does not have and both seem to be supported just 
>> statically i.e. cmdline or dt property.
>>
>> Our use-case needs to support runtime rotation configuration ours is 
>> not a mounted display but a portable hand-held device (https:// 
>> www.beagleboard.org/boards/beaglebadge) and we have an accelerometer 
>> in our device which can detect panel orientation and based on 
>> accelerometer reading the drm app can runtime set the custom drm 
>> rotation property to switch to new orientation dynamically.
>>
>> Also our driver is fundamentally different from a GPU display pipeline 
>> or controllers supporting transpose function. The SSD16xx display 
>> controller has no transpose or rotation function but instead supports 
>> different scan-modes, so there is no hardware path that can take a 
>> 400x300 plane and transpose it to a 300x400 display output. The 
>> controller is a simple RAM writer: the CPU writes a byte stream over 
>> SPI, and the controller's internal cursor
>> advances sequentially according to the data entry mode register (command
>> 0x11), which selects between X++/Y++ and X--/Y-- scan directions with a
>> configurable start position.
>>
>>
>> For portrait orientation we therefore change the DRM mode itself to
>> 300x400 from the original 400x300, so the application is asked to 
>> provide a 300x400 framebuffer.
>> The driver then writes this buffer column-by-column over SPI to the
>> display controller's RAM. Since the controller supports different scan
>> start positions (cursor at origin vs cursor at maximum address) combined
>> with the appropriate X/Y scan direction, we are able to correctly render
>> the 300x400 buffer onto the panel when it is held in portrait 
>> orientation (90*, 270*).
>>
>>
>> This means the CRTC mode must reflect the logical dimensions directly,
>> exactly as drm_mipi_dbi_dev_init() does via mipi_dbi_rotate_mode() for
>> MIPI DBI drivers. Accepting a 300x400 framebuffer onto a 400x300 CRTC
>> (as the panel_orientation + plane.rotation model requires) is not
>> possible: drm_atomic_helper_check_plane_state(DRM_PLANE_NO_SCALING)
>> enforces src_w == crtc_w and src_h == crtc_h, and there is no hardware
>> to perform the geometric remapping between the two sizes.
>>
>>
>> For runtime rotation changes (which are required as the panel is not
>> physically fixed), we therefor wanted to use a custom drm connector 
>> property. We can look to use the standard DRM_MODE_ROTATE_* bitmask 
>> (not a custom enum, that was used in v1), we can also look to check if 
>> driver can triggers a full modeset through the normal DRM path, 
>> connector_get_modes returns the correctly dimensioned mode for the new 
>> orientation, and userspace receives a mode-changed event with the new 
>> dimensions.
>>
>>
>> This is semantically what MIPI DBI tiny drivers do at boot (fixed from 
>> DT), made runtime-changeable via the custom drm connector property in 
>> this driver.
>>
>> Maybe, I can try to use standard bitmask instead of custom enum to re- 
>> use standard macros :
>>
>> drm_property_create_bitmask(drm, 0, "rotation",
>>                  rotation_props,
>>                  ARRAY_SIZE(rotation_props),
>>                  DRM_MODE_ROTATE_0  DRM_MODE_ROTATE_90 |
>>                  DRM_MODE_ROTATE_180 |DRM_MODE_ROTATE_270);
>>
>> but keep it as connector property?
>>
>>>> +
>>>> +static int refresh_mode = -1;
>>>> +module_param(refresh_mode, int, 0644);
>>>> +MODULE_PARM_DESC(refresh_mode,
>>>> +         "Refresh mode (-1=panel default, 0=partial ~300-500ms, 
>>>> 1=full ~1.5-2s, 2=fast ~1.0-1.5s)");
>>>> +
>>>> +static int border_waveform_init_lut = -1;
>>>> +module_param(border_waveform_init_lut, int, 0644);
>>>> +MODULE_PARM_DESC(border_waveform_init_lut,
>>>> +         "Border waveform index during clear/init (-1=panel 
>>>> default, 0-9=enum index)");
>>>> +
>>>> +static int border_waveform_lut = -1;
>>>> +module_param(border_waveform_lut, int, 0644);
>>>> +MODULE_PARM_DESC(border_waveform_lut,
>>>> +         "Border waveform index during display updates (-1=panel 
>>>> default, 0-9=enum index)");
>>>> +
>>>
>>> Please remove it. Only the panel default. If you have panels where 
>>> the default is known to be incorrect, you can add specific 
>>> workarounds in the driver.
>>>
>>
>> I think the most of these params are kept to sane defaults but they 
>> may change w.r.t use-cases and each panel can be used in context of 
>> multiple use-cases.
>>
>>>
>>>> +static bool border_refresh_on_every_update;
>>>> +module_param(border_refresh_on_every_update, bool, 0644);
>>>> +MODULE_PARM_DESC(border_refresh_on_every_update,
>>>> +         "Re-send border waveform command before each display 
>>>> update (default: false)");
>>>
>>> Pick a sane default.
>>>
>>
>> Yes driver is picking a sane default already for this (refresh border 
>> on init once with white border and keep it as floating in later 
>> updates), but just a back-door for the application in case it wants to 
>> avoid ghosting totally altogether or has specific needs w.r.t border 
>> handling.
>>
>>>> +
>>>> +static int clear_on_init = -1;
>>>> +module_param(clear_on_init, int, 0644);
>>>> +MODULE_PARM_DESC(clear_on_init,
>>>> +         "Clear display on first app launch (-1=disabled, 
>>>> 0=partial, 1=full, 2=fast)");
>>>> +
>>>> +static int clear_on_close = -1;
>>>> +module_param(clear_on_close, int, 0644);
>>>> +MODULE_PARM_DESC(clear_on_close,
>>>> +         "Clear display on app close/CRTC disable (-1=disabled, 
>>>> 0=partial, 1=full, 2=fast)");
>>>> +
>>>> +static int clear_on_disable = -1;
>>>> +module_param(clear_on_disable, int, 0644);
>>>> +MODULE_PARM_DESC(clear_on_disable,
>>>> +         "Clear display on CRTC disable/DPMS off (-1=disabled, 
>>>> 0=partial, 1=full, 2=fast)");
>>>> +
>>>> +static int refresh_mode_init = -1;
>>>> +module_param(refresh_mode_init, int, 0644);
>>>> +MODULE_PARM_DESC(refresh_mode_init,
>>>> +         "Skip baseline establishment on first enable (-1=disabled, 
>>>> 0=partial, 1=full, 2=fast)");
>>>
>>> Use 'disabled' for all of them.
>>>
>>>> +
>>>> +static int color_mode = -1;
>>>> +module_param(color_mode, int, 0644);
>>>> +MODULE_PARM_DESC(color_mode,
>>>> +         "Color mode (-1=panel default, 0=black-white, 1=3-color; 
>>>> 3- color only valid for panels with red plane support)");
>>>
>>> 'Panel default.'  Colors should be controlled by DRM clients via the 
>>> framebuffer.
>>>
>>
>> As mentioned previously, say user-space is only supporting and giving 
>> XR24 or XR32 format, from that we can't infer whether user-space want 
>> to drive display in B/W mode or color-mode.
>>
>>>> +
>>>> +/* 
>>>> -----------------------------------------------------------------------
>>>> + * SSD16xx family common: commands, data values, and bit definitions.
>>>> + * These apply equally to SSD1673, SSD1680, and SSD1683.
>>>> + * 
>>>> -----------------------------------------------------------------------
>>>> + */
>>>> +
>>>> +/* SPI command codes (common) */
>>>> +#define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL        0x01
>>>> +#define SSD16XX_CMD_DATA_ENTRY_MODE            0x11
>>>> +#define SSD16XX_CMD_SW_RESET                0x12
>>>> +#define SSD16XX_CMD_MASTER_ACTIVATION            0x20
>>>> +#define SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1        0x21
>>>> +#define SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2        0x22
>>>> +#define SSD16XX_CMD_WRITE_RAM_BW            0x24
>>>> +#define SSD16XX_CMD_BORDER_WAVEFORM_CONTROL        0x3C
>>>> +#define SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END        0x44
>>>> +#define SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END        0x45
>>>> +#define SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER        0x4E
>>>> +#define SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER        0x4F
>>>> +
>>>> +/*
>>>> + * Data Entry Mode (command 0x11) AM/IDY/IDX bit encoding (common).
>>>> + *
>>>> + * Bit 2 (AM): Address update direction: 0 = X direction, 1 = Y 
>>>> direction
>>>> + * ID[1:0] when AM=0 (X-direction modes, address counter advances 
>>>> in X):
>>>> + *   00 = X decrement, Y decrement   01 = X increment, Y decrement
>>>> + *   10 = X decrement, Y increment   11 = X increment, Y increment 
>>>> (default)
>>>> + *
>>>> + * Rotation to data entry mode mapping (actual implementation uses 
>>>> two modes,
>>>> + * with scan direction controlled via RAM cursor positioning and 
>>>> manual tweaking):
>>>> + *   0°/270° → 0x03 (X++, Y++)   Landscape/Portrait-CW: cursor at 
>>>> (0, 0)
>>>> + *   90°/180° → 0x00 (X--, Y--)  Portrait-CCW/Upside-down: cursor 
>>>> at (max, max)
>>>> + *
>>>> + * The pixel packing in convert_fb_to_1bpp is grouped by physical 
>>>> layout:
>>>> + *   - Portrait (90°/270°): column-major packing, rightmost column 
>>>> first
>>>> + *   - Landscape (0°/180°): row-major packing, top to bottom, left 
>>>> to right
>>>> + * Hardware cursor position and scan mode handle the final 
>>>> orientation.
>>>> + */
>>>> +#define SSD16XX_DATA_ENTRY_XDEC_YDEC        0x00  /* X--, Y-- (X- 
>>>> mode) */
>>>> +#define SSD16XX_DATA_ENTRY_XINC_YINC        0x03  /* X++, Y++ (X- 
>>>> mode, default) */
>>>> +
>>>> +/* POR reset value: GD=0 (G0 first), SM=0 (interlaced), TB=0 (G0- 
>>>> >G299) */
>>>> +#define SSD16XX_DRIVER_OUTPUT_CTRL_DEFAULT    0x00
>>>> +
>>>> +/* Display Update Control 1 (0x21) byte 2 default (common) */
>>>> +#define SSD16XX_CTRL1_BYTE2_DEFAULT        0x00
>>>> +
>>>> +/*
>>>> + * Display Update Control 2 (0x22) individual bit definitions 
>>>> (common).
>>>> + * NOTE: BIT(3) is NOT common — see SSD1683_CTRL2_MODE2 in the SSD1683
>>>> + * section below; it has a completely different meaning in SSD1673.
>>>> + */
>>>> +#define SSD16XX_CTRL2_ENABLE_CLK        BIT(7)
>>>> +#define SSD16XX_CTRL2_ENABLE_ANALOG        BIT(6)
>>>> +#define SSD16XX_CTRL2_LOAD_TEMPERATURE        BIT(5)
>>>> +#define SSD16XX_CTRL2_LOAD_LUT            BIT(4)
>>>> +#define SSD16XX_CTRL2_DISPLAY            BIT(2)
>>>> +#define SSD16XX_CTRL2_DISABLE_ANALOG        BIT(1)
>>>> +#define SSD16XX_CTRL2_DISABLE_CLK        BIT(0)
>>>> +
>>>> +#define SSD16XX_SPI_BITS_PER_WORD        8
>>>> +#define SSD16XX_SPI_SPEED_DEFAULT        1000000
>>>> +
>>>> +/* Maximum time to wait for the BUSY pin to deassert after a 
>>>> display update */
>>>> +#define SSD16XX_BUSY_WAIT_TIMEOUT_MS        6000
>>>> +
>>>> +/* 
>>>> -----------------------------------------------------------------------
>>>> + * SSD1683 / SSD1680 specific: commands, data values, and bit 
>>>> definitions.
>>>> + * 
>>>> -----------------------------------------------------------------------
>>>> + */
>>>> +
>>>> +/*
>>>> + * Deep Sleep Mode values (command 0x10).
>>>> + */
>>>> +#define SSD1683_DEEP_SLEEP_MODE_1            0x01  /* RAM retained */
>>>> +#define SSD1683_DEEP_SLEEP_MODE_2            0x03  /* RAM lost (max 
>>>> power) */
>>>> +
>>>> +/*
>>>> + * Temperature Sensor Selection (command 0x18).
>>>> + */
>>>> +#define SSD1683_CMD_TEMPERATURE_SENSOR_CONTROL        0x18
>>>> +#define SSD1683_TEMP_SENSOR_INTERNAL            0x80  /* Bit 7: use 
>>>> internal sensor */
>>>> +
>>>> +/*
>>>> + * Write RED RAM (command 0x26).
>>>> + */
>>>> +#define SSD1683_CMD_WRITE_RAM_RED            0x26
>>>> +
>>>> +/*
>>>> + * Border Waveform Control (command 0x3C) byte values.
>>>> + */
>>>> +#define SSD1683_BORDER_WAVEFORM_LUT0        0x00  /* GS Transition 
>>>> LUT0 (black) */
>>>> +#define SSD1683_BORDER_WAVEFORM_LUT1        0x01  /* GS Transition 
>>>> LUT1 (white) */
>>>> +#define SSD1683_BORDER_WAVEFORM_LUT2        0x02  /* GS Transition 
>>>> LUT2 (black) */
>>>> +#define SSD1683_BORDER_WAVEFORM_LUT3        0x03  /* GS Transition 
>>>> LUT3 (gray) */
>>>> +#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSS    0x40  /* Fix Level 
>>>> VSS (0V, black) */
>>>> +#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSH1    0x50  /* Fix Level 
>>>> VSH1 (+15V, black) */
>>>> +#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSL    0x60  /* Fix Level 
>>>> VSL (-15V, white) */
>>>> +#define SSD1683_BORDER_WAVEFORM_FIXLVL_VSH2    0x70  /* Fix Level 
>>>> VSH2 (+15V alt, black) */
>>>> +#define SSD1683_BORDER_WAVEFORM_VCOM        0x80  /* Follow VCOM 
>>>> (-2V~-3V, preserve) */
>>>> +#define SSD1683_BORDER_WAVEFORM_HIZ        0xC0  /* HiZ (floating, 
>>>> default) */
>>>> +
>>>> +/*
>>>> + * Display Update Control 1 (0x21) byte 1 — RED RAM control.
>>>> + */
>>>> +#define SSD1683_CTRL1_NORMAL            0x00  /* Both BW and RED 
>>>> RAMs enabled */
>>>> +#define SSD1683_CTRL1_BYPASS_RED_RAM        0x40  /* Bypass RED RAM 
>>>> (force RED=0) */
>>>> +
>>>> +/*
>>>> + * Display Update Control 2 (0x22) BIT(3) — "Display Mode 
>>>> 2" (partial/BW).
>>>> + */
>>>> +#define SSD1683_CTRL2_MODE2            BIT(3)
>>>> +
>>>> +/* Composite CTRL2 sequences for each refresh mode */
>>>> +#define SSD1683_CTRL2_FULL_REFRESH (SSD16XX_CTRL2_ENABLE_CLK | \
>>>> +                    SSD16XX_CTRL2_ENABLE_ANALOG | \
>>>> +                    SSD16XX_CTRL2_LOAD_TEMPERATURE | \
>>>> +                    SSD16XX_CTRL2_LOAD_LUT | \
>>>> +                    SSD16XX_CTRL2_DISPLAY | \
>>>> +                    SSD16XX_CTRL2_DISABLE_ANALOG | \
>>>> +                    SSD16XX_CTRL2_DISABLE_CLK)  /* 0xF7, ~1.5-2s */
>>>> +
>>>> +#define SSD1683_CTRL2_FAST_REFRESH (SSD16XX_CTRL2_ENABLE_CLK | \
>>>> +                    SSD16XX_CTRL2_ENABLE_ANALOG | \
>>>> +                    SSD16XX_CTRL2_DISPLAY | \
>>>> +                    SSD16XX_CTRL2_DISABLE_ANALOG | \
>>>> +                    SSD16XX_CTRL2_DISABLE_CLK)  /* 0xC7, ~1.0-1.5s */
>>>> +
>>>> +#define SSD1683_CTRL2_PARTIAL_REFRESH (SSD16XX_CTRL2_ENABLE_CLK | \
>>>> +                       SSD16XX_CTRL2_ENABLE_ANALOG | \
>>>> +                       SSD16XX_CTRL2_LOAD_TEMPERATURE | \
>>>> +                       SSD16XX_CTRL2_LOAD_LUT | \
>>>> +                       SSD1683_CTRL2_MODE2 | \
>>>> +                       SSD16XX_CTRL2_DISPLAY | \
>>>> +                       SSD16XX_CTRL2_DISABLE_ANALOG | \
>>>> +                       SSD16XX_CTRL2_DISABLE_CLK)  /* 0xFF, 
>>>> ~300-500ms */
>>>> +
>>>> +/*
>>>> + * Standalone LUT pre-load sequence (0x91 = ENABLE_CLK | LOAD_LUT | 
>>>> LOAD_TEMPERATURE |
>>>> + *                                          DISABLE_CLK).
>>>> + * Pre-loads the OTP LUT without triggering a display update. 
>>>> Required for
>>>> + * FAST refresh mode (0xC7) which omits LOAD_LUT from each update 
>>>> cycle.
>>>> + */
>>>> +#define SSD1683_CTRL2_LOAD_TEMP_LUT        
>>>> (SSD16XX_CTRL2_ENABLE_CLK | \
>>>> +                         SSD16XX_CTRL2_LOAD_LUT | \
>>>> +                         SSD16XX_CTRL2_LOAD_TEMPERATURE | \
>>>> +                         SSD16XX_CTRL2_DISABLE_CLK)  /* 0xB1 */
>>>> +
>>>> +MODULE_IMPORT_NS("DMA_BUF");
>>>> +
>>>> +enum ssd16xx_controller {
>>>> +    SSD1683 = 1,
>>>> +};
>>>> +
>>>> +enum ssd16xx_model {
>>>> +    GDEY042T81 = 1,
>>>> +};
>>>> +
>>>> +enum ssd16xx_refresh_mode {
>>>> +    SSD16XX_REFRESH_PARTIAL = 0,  /* Partial refresh (~300-500ms) */
>>>> +    SSD16XX_REFRESH_FULL,         /* Full refresh (~1.5-2s) */
>>>> +    SSD16XX_REFRESH_FAST,         /* Fast refresh, skip temp load 
>>>> (~1.0-1.5s) */
>>>> +};
>>>> +
>>>> +enum ssd16xx_color_mode {
>>>> +    SSD16XX_COLOR_MODE_BW = 0,     /* Black/white only; RED RAM 
>>>> always bypassed */
>>>> +    SSD16XX_COLOR_MODE_3COLOR = 1, /* 3-colour BWR; RED RAM used 
>>>> for red pixels */
>>>> +};
>>>> +
>>>> +/* Border waveform enum indices (0-9); mapped to HW bytes via
>>>> + * controller_cfg->border_waveform_table[]
>>>> + */
>>>> +enum ssd16xx_border_waveform {
>>>> +    SSD16XX_BORDER_LUT0 = 0,  /* GS Transition LUT0 (black) */
>>>> +    SSD16XX_BORDER_LUT1,      /* GS Transition LUT1 (white) */
>>>> +    SSD16XX_BORDER_LUT2,      /* GS Transition LUT2 (black) */
>>>> +    SSD16XX_BORDER_LUT3,      /* GS Transition LUT3 (gray) */
>>>> +    SSD16XX_BORDER_VSS,       /* Fix Level VSS (black) */
>>>> +    SSD16XX_BORDER_VSH1,      /* Fix Level VSH1 (black) */
>>>> +    SSD16XX_BORDER_VSL,       /* Fix Level VSL (white) */
>>>> +    SSD16XX_BORDER_VSH2,      /* Fix Level VSH2 (black) */
>>>> +    SSD16XX_BORDER_VCOM,      /* Follow VCOM (preserve) */
>>>> +    SSD16XX_BORDER_HIZ,       /* HiZ (floating, default) */
>>>> +};
>>>> +
>>>> +/* SSD1683/SSD1680 border waveform byte encoding for command 0x3C */
>>>> +static const u8 ssd1683_border_waveform_table[] = {
>>>> +    [SSD16XX_BORDER_LUT0] = SSD1683_BORDER_WAVEFORM_LUT0,
>>>> +    [SSD16XX_BORDER_LUT1] = SSD1683_BORDER_WAVEFORM_LUT1,
>>>> +    [SSD16XX_BORDER_LUT2] = SSD1683_BORDER_WAVEFORM_LUT2,
>>>> +    [SSD16XX_BORDER_LUT3] = SSD1683_BORDER_WAVEFORM_LUT3,
>>>> +    [SSD16XX_BORDER_VSS]  = SSD1683_BORDER_WAVEFORM_FIXLVL_VSS,
>>>> +    [SSD16XX_BORDER_VSH1] = SSD1683_BORDER_WAVEFORM_FIXLVL_VSH1,
>>>> +    [SSD16XX_BORDER_VSL]  = SSD1683_BORDER_WAVEFORM_FIXLVL_VSL,
>>>> +    [SSD16XX_BORDER_VSH2] = SSD1683_BORDER_WAVEFORM_FIXLVL_VSH2,
>>>> +    [SSD16XX_BORDER_VCOM] = SSD1683_BORDER_WAVEFORM_VCOM,
>>>> +    [SSD16XX_BORDER_HIZ]  = SSD1683_BORDER_WAVEFORM_HIZ,
>>>> +};
>>>> +
>>>> +struct ssd16xx_controller_config {
>>>> +    u16 max_width;
>>>> +    u16 max_height;
>>>> +    u8 ram_x_address_bits;
>>>> +    u8 ram_y_address_bits;
>>>> +
>>>> +    /*
>>>> +     * has_temp_sensor_ctrl: controller supports command 0x18 
>>>> (Temperature
>>>> +     * Sensor Selection).  Present in SSD1683/SSD1680; absent in 
>>>> SSD1673
>>>> +     * which uses command 0x1A (direct temperature write) instead.
>>>> +     */
>>>> +    bool has_temp_sensor_ctrl;
>>>> +
>>>> +    /*
>>>> +     * Deep sleep mode byte values for command 0x10.
>>>> +     *   deep_sleep_mode_level1: lower-power sleep, RAM content 
>>>> retained
>>>> +     *     (MODE_1 on SSD1683/SSD1680; used for runtime idle / app- 
>>>> close).
>>>> +     *   deep_sleep_mode_level2: maximum power savings, RAM may be 
>>>> lost
>>>> +     *     (MODE_2 on SSD1683/SSD1680; used for system suspend).
>>>> +     * Chips with a single sleep mode set both fields to the same 
>>>> value.
>>>> +     */
>>>> +    u8 deep_sleep_mode_level1;
>>>> +    u8 deep_sleep_mode_level2;
>>>> +
>>>> +    /*
>>>> +     * border_waveform_table: chip-specific byte values for the 10 
>>>> logical
>>>> +     * border waveform modes (indexed by enum 
>>>> ssd16xx_border_waveform).
>>>> +     * The encoding of command 0x3C differs between SSD1683/SSD1680 
>>>> and
>>>> +     * SSD1673, so each controller provides its own translation table.
>>>> +     */
>>>> +    const u8 *border_waveform_table;
>>>> +
>>>> +    /*
>>>> +     * Display Update Control 1 (cmd 0x21) byte 1 values.
>>>> +     * ctrl1_normal:         both BW and RED RAMs participate in 
>>>> the waveform.
>>>> +     * ctrl1_bypass_red_ram: RED RAM bypassed; waveform driven from 
>>>> BW RAM only.
>>>> +     * SSD1673 has no RED RAM so both fields carry the same value.
>>>> +     */
>>>> +    u8 ctrl1_normal;
>>>> +    u8 ctrl1_bypass_red_ram;
>>>> +
>>>> +    /*
>>>> +     * Display Update Control 2 (cmd 0x22) composite sequences for 
>>>> each
>>>> +     * refresh mode (indexed by enum ssd16xx_refresh_mode) and the
>>>> +     * standalone LUT pre-load sequence used before fast refresh.
>>>> +     * Values differ between SSD1683/SSD1680 and SSD1673 (MODE2 
>>>> bit, etc.).
>>>> +     */
>>>> +    u8 ctrl2_refresh[3];     /* indexed by SSD16XX_REFRESH_PARTIAL/ 
>>>> FULL/FAST */
>>>> +    u8 ctrl2_load_temp_lut;  /* standalone LUT pre-load (no display 
>>>> update) */
>>>> +};
>>>> +
>>>> +struct ssd16xx_panel_config {
>>>> +    /* Data Entry Mode - controls X/Y increment direction for 
>>>> landscape (0°) */
>>>> +    u8 data_entry_mode;
>>>> +
>>>> +    /* Driver Output Control - third byte (scan direction) */
>>>> +    u8 driver_output_ctrl_byte3;
>>>> +
>>>> +    /* Default refresh mode for this panel */
>>>> +    enum ssd16xx_refresh_mode default_refresh_mode;
>>>> +
>>>> +    /* Default border waveform during clear/init (enum index 0-9) */
>>>> +    enum ssd16xx_border_waveform default_border_waveform_init;
>>>> +
>>>> +    /* Default border waveform during display updates (enum index 
>>>> 0-9) */
>>>> +    enum ssd16xx_border_waveform default_border_waveform_update;
>>>> +
>>>> +    /* Whether to re-send border waveform command before each 
>>>> display update */
>>>> +    bool default_border_refresh_on_every_update;
>>>> +
>>>> +    /*
>>>> +     * Default clear-on-init behaviour.
>>>> +     * -1=disabled, 0=partial, 1=full, 2=fast (matches enum 
>>>> ssd16xx_refresh_mode)
>>>> +     */
>>>> +    int default_clear_on_init;
>>>> +
>>>> +    /* Default clear-on-close behaviour (-1=disabled, 0=partial, 
>>>> 1=full, 2=fast) */
>>>> +    int default_clear_on_close;
>>>> +
>>>> +    /* Default clear-on-disable behaviour (-1=disabled, 0=partial, 
>>>> 1=full, 2=fast) */
>>>> +    int default_clear_on_disable;
>>>> +
>>>> +    /*
>>>> +     * Default refresh-mode-init: -1=disabled, else skip baseline 
>>>> establishment
>>>> +     * and start directly in this refresh mode.
>>>> +     */
>>>> +    int default_refresh_mode_init;
>>>> +
>>>> +    /*
>>>> +     * Whether this panel has a physical red colour plane (3-colour 
>>>> BWR).
>>>> +     * false: 2-colour black/white only; the RED RAM is always 
>>>> bypassed.
>>>> +     * true:  3-colour panel; full-refresh writes to the RED RAM so 
>>>> that
>>>> +     *        red pixels are driven through the red waveform.
>>>> +     */
>>>> +    bool red_supported;
>>>> +
>>>> +    /* Panel-specific display mode (resolution and physical 
>>>> dimensions) */
>>>> +    const struct drm_display_mode *mode;
>>>> +};
>>>> +
>>>> +struct ssd16xx_panel {
>>>
>>> Better call this 'struct ssd16xx_device' and the rsp variables 
>>> 'ssd16xx'.  As mentioned, the name 'panel' already has a specific 
>>> meaning in DRM.
>>>
>>
>> Alright I can do that, I thought folks won't confuse it since this is 
>> not importing drm_panel struct.
>>
>>>
>>>> +    struct drm_device drm;
>>>> +
>>>> +    struct drm_plane primary_plane;
>>>> +    struct drm_crtc crtc;
>>>> +    struct drm_encoder encoder;
>>>> +    struct drm_connector connector;
>>>> +
>>>> +    struct spi_device *spi;
>>>> +    struct gpio_desc *reset;
>>>> +    struct gpio_desc *busy;
>>>> +    struct gpio_desc *dc;
>>>> +
>>>> +    enum ssd16xx_model model;
>>>> +    enum ssd16xx_controller controller;
>>>> +    const struct ssd16xx_controller_config *controller_cfg;
>>>> +    const struct ssd16xx_panel_config *panel_cfg;
>>>> +    struct drm_display_mode *mode;
>>>> +    u32 width;
>>>> +    u32 height;
>>>> +
>>>> +    bool initialized;
>>>> +    bool reinit_pending;      /* HW re-init required after 
>>>> orientation change */
>>>> +    bool init_refresh_pending; /* First frame after 
>>>> refresh_mode_init enable */
>>>> +    bool first_clear_done;  /* clear_on_init has already fired once */
>>>> +    bool display_cleared_on_deinit; /* Avoid redundant clear in 
>>>> atomic_disable/master_drop */
>>>> +
>>>> +    int orientation; /* Display orientation in degrees: 
>>>> 0/90/180/270 */
>>>> +    enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
>>>> +    enum ssd16xx_color_mode color_mode;     /* Active color mode 
>>>> (BW or 3-color) */
>>>> +    bool fast_lut_pending; /* LUT pre-load needed before next fast 
>>>> refresh */
>>>> +
>>>> +    /* Border waveform (as enum indices) */
>>>> +    int border_waveform_init_idx;   /* Border waveform during 
>>>> clear/ init */
>>>> +    int border_waveform_update_idx; /* Border waveform during 
>>>> display updates */
>>>> +    bool border_refresh_on_every_update; /* Re-send border cmd each 
>>>> display update */
>>>> +    bool border_waveform_pending;   /* One-shot: send border cmd on 
>>>> next update */
>>>> +
>>>> +    /* Display control */
>>>> +    int clear_on_init;    /* -1=disabled, 0=partial, 1=full, 2=fast */
>>>> +    int clear_on_close;   /* -1=disabled, 0=partial, 1=full, 2=fast */
>>>> +    int clear_on_disable; /* -1=disabled, 0=partial, 1=full, 2=fast */
>>>> +    int refresh_mode_init; /* -1=disabled, else use this mode for 
>>>> the first frame */
>>>> +
>>>> +    u8  *tx_buf;     /* 1bpp frame buffer (mono + white) */
>>>> +    u8  *tx_red_buf; /* 1bpp red-channel buffer (3-color panels 
>>>> only) */
>>>> +    u16 *tx_buf9;    /* 9-bit SPI expansion buffer (3-wire mode 
>>>> only) */
>>>> +
>>>> +    struct drm_framebuffer *last_fb;        /* Last drawn FB for 
>>>> reinit redraws */
>>>> +    struct drm_property *rotation_property;
>>>> +    struct drm_property *refresh_mode_property;
>>>> +    struct drm_property *border_waveform_init_property;
>>>> +    struct drm_property *border_waveform_update_property;
>>>> +    struct drm_property *border_refresh_on_every_update_property;
>>>> +    struct drm_property *clear_on_init_property;
>>>> +    struct drm_property *clear_on_close_property;
>>>> +    struct drm_property *clear_on_disable_property;
>>>> +    struct drm_property *refresh_mode_init_property;
>>>> +    struct drm_property *color_mode_property;
>>>> +};
>>>> +
>>>> +static inline struct ssd16xx_panel *to_ssd16xx_panel(struct 
>>>> drm_device *drm)
>>>> +{
>>>> +    return container_of(drm, struct ssd16xx_panel, drm);
>>>> +}
>>>> +
>>>> +static inline struct ssd16xx_panel *crtc_to_ssd16xx_panel(struct 
>>>> drm_crtc *crtc)
>>>> +{
>>>> +    return container_of(crtc, struct ssd16xx_panel, crtc);
>>>> +}
>>>> +
>>>> +static inline struct ssd16xx_panel *plane_to_ssd16xx_panel(struct 
>>>> drm_plane *plane)
>>>> +{
>>>> +    return container_of(plane, struct ssd16xx_panel, primary_plane);
>>>> +}
>>>> +
>>>> +static const struct ssd16xx_controller_config 
>>>> ssd16xx_controller_configs[] = {
>>>> +    [SSD1683] = {
>>>> +        .max_width = 400,
>>>> +        .max_height = 300,
>>>> +        .ram_x_address_bits = 8,
>>>> +        .ram_y_address_bits = 16,
>>>> +        .has_temp_sensor_ctrl    = true,
>>>> +        .deep_sleep_mode_level1  = SSD1683_DEEP_SLEEP_MODE_1,
>>>> +        .deep_sleep_mode_level2  = SSD1683_DEEP_SLEEP_MODE_2,
>>>> +        .border_waveform_table   = ssd1683_border_waveform_table,
>>>> +        .ctrl1_normal            = SSD1683_CTRL1_NORMAL,
>>>> +        .ctrl1_bypass_red_ram    = SSD1683_CTRL1_BYPASS_RED_RAM,
>>>> +        .ctrl2_refresh = {
>>>> +            [SSD16XX_REFRESH_PARTIAL] = SSD1683_CTRL2_PARTIAL_REFRESH,
>>>> +            [SSD16XX_REFRESH_FULL]    = SSD1683_CTRL2_FULL_REFRESH,
>>>> +            [SSD16XX_REFRESH_FAST]    = SSD1683_CTRL2_FAST_REFRESH,
>>>> +        },
>>>> +        .ctrl2_load_temp_lut     = SSD1683_CTRL2_LOAD_TEMP_LUT,
>>>> +    },
>>>> +};
>>>> +
>>>> +/* GDEY042T81: 4.2" 400x300 panel, 84.8x63.6mm active area */
>>>> +static const struct drm_display_mode gdey042t81_mode = {
>>>> +    DRM_SIMPLE_MODE(400, 300, 85, 64),
>>>> +};
>>>> +
>>>> +static const struct ssd16xx_panel_config ssd16xx_panel_configs[] = {
>>>> +    [GDEY042T81] = {
>>>> +        .data_entry_mode = SSD16XX_DATA_ENTRY_XINC_YINC,
>>>> +        .driver_output_ctrl_byte3 = 
>>>> SSD16XX_DRIVER_OUTPUT_CTRL_DEFAULT,
>>>> +        .default_refresh_mode = SSD16XX_REFRESH_PARTIAL,
>>>> +        .default_border_waveform_init   = SSD16XX_BORDER_LUT1,  /* 
>>>> white, clean clear */
>>>> +        .default_border_waveform_update = SSD16XX_BORDER_HIZ,   /* 
>>>> floating, preserve */
>>>> +        .default_border_refresh_on_every_update = false,
>>>> +        .default_clear_on_init    = -1,
>>>> +        .default_clear_on_close   = -1,
>>>> +        .default_clear_on_disable = -1,
>>>> +        .default_refresh_mode_init = SSD16XX_REFRESH_FULL,
>>>> +        .red_supported = false,  /* 2-colour black/white panel */
>>>> +        .mode = &gdey042t81_mode,
>>>> +    },
>>>> +};
>>>> +
>>>> +static void ssd16xx_wait_for_panel(struct ssd16xx_panel *panel,
>>>> +                   int *err)
>>>> +{
>>>> +    unsigned long timeout_jiffies = jiffies +
>>>> +        msecs_to_jiffies(SSD16XX_BUSY_WAIT_TIMEOUT_MS);
>>>> +    unsigned long start_ms = jiffies_to_msecs(jiffies);
>>>> +    int busy_val;
>>>> +
>>>> +    if (*err)
>>>> +        return;
>>>
>>> This is good. It'll simplify error handling in other places.
>>>
>>>> +
>>>> +    busy_val = gpiod_get_value_cansleep(panel->busy);
>>>> +    drm_dbg(&panel->drm, "BUSY initial value: %d\n", busy_val);
>>>> +
>>>> +    while (gpiod_get_value_cansleep(panel->busy) == 1) {
>>>> +        if (time_after(jiffies, timeout_jiffies)) {
>>>> +            drm_err(&panel->drm, "Busy wait timed out after %lums\n",
>>>> +                jiffies_to_msecs(jiffies) - start_ms);
>>>> +            *err = -ETIMEDOUT;
>>>> +            return;
>>>> +        }
>>>> +        usleep_range(100, 200);
>>>> +    }
>>>> +
>>>> +    drm_dbg(&panel->drm, "BUSY became ready after %lums\n",
>>>> +        jiffies_to_msecs(jiffies) - start_ms);
>>>> +}
>>>> +
>>>> +static void ssd16xx_spi_sync(struct spi_device *spi, struct 
>>>> spi_message *msg,
>>>> +                 int *err)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    ret = spi_sync(spi, msg);
>>>> +    if (ret < 0)
>>>> +        *err = ret;
>>>> +}
>>>> +
>>>> +static void ssd16xx_send_cmd(struct ssd16xx_panel *panel, u8 cmd,
>>>> +                 int *err)
>>>> +{
>>>> +    u16 word;
>>>> +    struct spi_transfer xfer = {};
>>>> +    struct spi_message msg;
>>>> +
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    spi_message_init(&msg);
>>>> +    spi_message_add_tail(&xfer, &msg);
>>>> +
>>>> +    if (panel->dc) {
>>>> +        /* 4-wire SPI: D/C# GPIO low selects command mode */
>>>> +        xfer.tx_buf = &cmd;
>>>> +        xfer.len = 1;
>>>> +        gpiod_set_value_cansleep(panel->dc, 0);
>>>> +    } else {
>>>> +        /*
>>>> +         * 3-wire SPI (9-bit): bit 8 is the D/C# bit.
>>>> +         * D/C# = 0 means the following 8 bits are a command.
>>>> +         */
>>>> +        word = cmd; /* bit 8 = 0 for command */
>>>> +        xfer.tx_buf = &word;
>>>> +        xfer.len = sizeof(u16);
>>>> +        xfer.bits_per_word = 9;
>>>> +    }
>>>> +
>>>> +    ssd16xx_spi_sync(panel->spi, &msg, err);
>>>> +}
>>>> +
>>>> +static void ssd16xx_send_data(struct ssd16xx_panel *panel, u8 data,
>>>> +                  int *err)
>>>> +{
>>>> +    u16 word;
>>>> +    struct spi_transfer xfer = {};
>>>> +    struct spi_message msg;
>>>> +
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    spi_message_init(&msg);
>>>> +    spi_message_add_tail(&xfer, &msg);
>>>> +
>>>> +    if (panel->dc) {
>>>> +        /* 4-wire SPI: D/C# GPIO high selects data mode */
>>>> +        xfer.tx_buf = &data;
>>>> +        xfer.len = 1;
>>>> +        gpiod_set_value_cansleep(panel->dc, 1);
>>>> +    } else {
>>>> +        /*
>>>> +         * 3-wire SPI (9-bit): bit 8 is the D/C# bit.
>>>> +         * D/C# = 1 means the following 8 bits are data.
>>>> +         */
>>>> +        word = 0x100 | data;
>>>> +        xfer.tx_buf = &word;
>>>> +        xfer.len = sizeof(u16);
>>>> +        xfer.bits_per_word = 9;
>>>> +    }
>>>> +
>>>> +    ssd16xx_spi_sync(panel->spi, &msg, err);
>>>> +}
>>>> +
>>>> +static void ssd16xx_send_x_param(struct ssd16xx_panel *panel, u16 x,
>>>> +                 int *err)
>>>> +{
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    if (panel->controller_cfg->ram_x_address_bits == 8) {
>>>> +        ssd16xx_send_data(panel, (u8)x, err);
>>>> +    } else {
>>>> +        ssd16xx_send_data(panel, x & 0xFF, err);
>>>> +        ssd16xx_send_data(panel, (x >> 8) & 0xFF, err);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void ssd16xx_send_y_param(struct ssd16xx_panel *panel, u16 y,
>>>> +                 int *err)
>>>> +{
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    if (panel->controller_cfg->ram_y_address_bits == 8) {
>>>> +        ssd16xx_send_data(panel, (u8)y, err);
>>>> +    } else {
>>>> +        ssd16xx_send_data(panel, y & 0xFF, err);
>>>> +        ssd16xx_send_data(panel, (y >> 8) & 0xFF, err);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void ssd16xx_send_data_bulk(struct ssd16xx_panel *panel,
>>>> +                   const u8 *data, size_t len,
>>>> +                   int *err)
>>>> +{
>>>> +    struct spi_transfer xfer = {};
>>>> +    struct spi_message msg;
>>>> +
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    if (!data || !len)
>>>> +        return;
>>>> +
>>>> +    spi_message_init(&msg);
>>>> +    spi_message_add_tail(&xfer, &msg);
>>>> +
>>>> +    if (panel->dc) {
>>>> +        /* 4-wire SPI: D/C# GPIO high selects data mode */
>>>> +        xfer.tx_buf = data;
>>>> +        xfer.len = len;
>>>> +        gpiod_set_value_cansleep(panel->dc, 1);
>>>> +        ssd16xx_spi_sync(panel->spi, &msg, err);
>>>> +    } else {
>>>> +        /* 3-wire (9-bit): expand u8 → u16 with D/C#=1 in bit 8. */
>>>> +        size_t i;
>>>> +        u16 *buf = panel->tx_buf9;
>>>> +
>>>> +        for (i = 0; i < len; i++)
>>>> +            buf[i] = 0x100 | data[i];
>>>> +
>>>> +        xfer.tx_buf = buf;
>>>> +        xfer.len = len * sizeof(u16);
>>>> +        xfer.bits_per_word = 9;
>>>> +        ssd16xx_spi_sync(panel->spi, &msg, err);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void ssd16xx_display_update(struct ssd16xx_panel *panel,
>>>> +                   u8 ctrl1_byte1, u8 ctrl1_byte2, u8 ctrl2_mode,
>>>> +                   int *err)
>>>> +{
>>>> +    if (*err)
>>>> +        return;
>>>> +
>>>> +    drm_dbg(&panel->drm,
>>>> +        "display_update: Setting ctrl1=0x%02x,0x%02x mode=0x%02x\n",
>>>> +        ctrl1_byte1, ctrl1_byte2, ctrl2_mode);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, err);
>>>> +    ssd16xx_send_data(panel, ctrl1_byte1, err);
>>>> +    ssd16xx_send_data(panel, ctrl1_byte2, err);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, err);
>>>> +    ssd16xx_send_data(panel, ctrl2_mode, err);
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_MASTER_ACTIVATION, err);
>>>> +
>>>> +    drm_dbg(&panel->drm,
>>>> +        "display_update: Master activation sent, waiting...\n");
>>>> +
>>>> +    ssd16xx_wait_for_panel(panel, err);
>>>> +}
>>>> +
>>>> +static void ssd16xx_hw_reset(struct ssd16xx_panel *panel)
>>>> +{
>>>> +    gpiod_set_value_cansleep(panel->reset, 1);
>>>> +    usleep_range(10000, 11000);
>>>> +    gpiod_set_value_cansleep(panel->reset, 0);
>>>> +    usleep_range(10000, 11000);
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_preload_fast_lut() - pre-load the OTP LUT for fast 
>>>> refresh mode.
>>>> + *
>>>> + * Fast refresh (CTRL2 = 0xC7) omits the LOAD_LUT step on every 
>>>> update to save
>>>> + * time.  It relies on the LUT being loaded upfront via this 
>>>> standalone sequence
>>>> + * (CTRL2 = 0xB1: ENABLE_CLK | LOAD_LUT | 
>>>> SSD16XX_CTRL2_LOAD_TEMPERATURE | DISABLE_CLK,
>>>> + *  no display update).
>>>> + *
>>>> + * Must be called when:
>>>> + *   a) hw_init runs with refresh_mode == FAST, and
>>>> + *   b) switching to fast refresh from a mode that did not leave a 
>>>> valid Mode1
>>>> + *      LUT in the controller (i.e. previous mode was not FULL 
>>>> refresh, which
>>>> + *      carries LOAD_LUT in its own CTRL2 sequence).
>>>> + */
>>>> +static int ssd16xx_preload_fast_lut(struct ssd16xx_panel *panel)
>>>> +{
>>>> +    int err = 0;
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, 
>>>> &err);
>>>> +    ssd16xx_send_data(panel, panel->controller_cfg- 
>>>> >ctrl1_bypass_red_ram, &err);
>>>> +    ssd16xx_send_data(panel, SSD16XX_CTRL1_BYTE2_DEFAULT, &err);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, 
>>>> &err);
>>>> +    ssd16xx_send_data(panel, panel->controller_cfg- 
>>>> >ctrl2_load_temp_lut, &err);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_MASTER_ACTIVATION, &err);
>>>> +    ssd16xx_wait_for_panel(panel, &err);
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>> +static int ssd16xx_hw_init(struct ssd16xx_panel *panel)
>>>> +{
>>>> +    int err = 0;
>>>> +    u16 ram_height = panel->controller_cfg->max_height;
>>>> +    u8 data_entry_mode;
>>>> +
>>>> +    ssd16xx_hw_reset(panel);
>>>> +
>>>> +    /* Software reset */
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_SW_RESET, &err);
>>>> +    ssd16xx_wait_for_panel(panel, &err);
>>>> +
>>>> +    /* Driver output control (0x01): MUX ratio and scan direction. */
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_DRIVER_OUTPUT_CONTROL, &err);
>>>> +    ssd16xx_send_y_param(panel, ram_height - 1, &err);
>>>> +    ssd16xx_send_data(panel, panel->panel_cfg- 
>>>> >driver_output_ctrl_byte3, &err);
>>>> +
>>>> +    /* Internal temperature sensor (SSD1683/SSD1680 only; not 
>>>> present in SSD1673) */
>>>> +    if (panel->controller_cfg->has_temp_sensor_ctrl) {
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD1683_CMD_TEMPERATURE_SENSOR_CONTROL, &err);
>>>> +        ssd16xx_send_data(panel, SSD1683_TEMP_SENSOR_INTERNAL, &err);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * For FAST refresh mode, pre-load the LUT once here during 
>>>> initialization.
>>>> +     * FAST mode ctrl2 (0xC7) omits LOAD_LUT on every update for 
>>>> speed, so the
>>>> +     * LUT must be loaded upfront. FULL (0xF7) and PARTIAL (0xFF) 
>>>> load LUT on
>>>> +     * every update, so no preload is needed for those modes.
>>>> +     */
>>>> +    if (panel->refresh_mode == SSD16XX_REFRESH_FAST) {
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_DISPLAY_UPDATE_CONTROL1, &err);
>>>> +        ssd16xx_send_data(panel, panel->controller_cfg- 
>>>> >ctrl1_bypass_red_ram, &err);
>>>> +        ssd16xx_send_data(panel, SSD16XX_CTRL1_BYTE2_DEFAULT, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_DISPLAY_UPDATE_CONTROL2, &err);
>>>> +        ssd16xx_send_data(panel, panel->controller_cfg- 
>>>> >ctrl2_load_temp_lut, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, SSD16XX_CMD_MASTER_ACTIVATION, &err);
>>>> +        ssd16xx_wait_for_panel(panel, &err);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Set Data Entry Mode (0x11) based on orientation.  This controls
>>>> +     * how the RAM address counter auto-advances after each byte 
>>>> write.
>>>> +     *
>>>> +     * Implementation uses two data entry modes:
>>>> +     *   - 90°/180° use XDEC_YDEC (0x00): X--, Y-- with cursor at 
>>>> (max, max)
>>>> +     *   - 0°/270° use XINC_YINC (0x03): X++, Y++ with cursor at 
>>>> (0, 0)
>>>> +     *
>>>> +     * The convert_fb_to_1bpp packing is grouped by physical layout:
>>>> +     *   - Portrait orientations (90°/270°): column-major packing
>>>> +     *   - Landscape orientations (0°/180°): row-major packing
>>>> +     *
>>>> +     * Final scan direction and image orientation are controlled by 
>>>> the
>>>> +     * combination of data entry mode and RAM cursor position set 
>>>> in fb_dirty.
>>>> +     *
>>>> +     * The RAM address window and cursor are NOT set here; fb_dirty
>>>> +     * always programmes them (with the correct end-before-start order
>>>> +     * for decrement modes) immediately before writing frame data.
>>>> +     */
>>>> +    switch (panel->orientation) {
>>>
>>> As mentioned, use the connector property instead.
>>>
>>>> +    case 90:
>>>> +    case 180:
>>>> +        data_entry_mode = SSD16XX_DATA_ENTRY_XDEC_YDEC;
>>>> +        break;
>>>> +    default: /* 0°/270° */
>>>> +        data_entry_mode = SSD16XX_DATA_ENTRY_XINC_YINC;
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_DATA_ENTRY_MODE, &err);
>>>> +    ssd16xx_send_data(panel, data_entry_mode, &err);
>>>> +    drm_dbg(&panel->drm, "hw_init: orientation=%u° 
>>>> data_entry=0x%02x\n",
>>>> +        panel->orientation, data_entry_mode);
>>>> +
>>>> +    ssd16xx_wait_for_panel(panel, &err);
>>>> +
>>>> +    if (err)
>>>> +        drm_err(&panel->drm, "Hardware initialization failed: 
>>>> %d\n", err);
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Clear display by writing all-white to both BW and RED RAM.
>>>> + * The ctrl2 argument selects the waveform (full/partial/fast 
>>>> refresh).
>>>> + * Border waveform is set to init value before clearing, then restored
>>>> + * to the update value to preserve the border during subsequent 
>>>> updates.
>>>> + */
>>>> +static int ssd16xx_clear_display(struct ssd16xx_panel *panel, u8 
>>>> ctrl2)
>>>> +{
>>>> +    const u8 *bw_tbl = panel->controller_cfg->border_waveform_table;
>>>> +    int err = 0;
>>>> +    unsigned int data_size = (panel->width * panel->height) / 8;
>>>> +    u8 *white_buffer = panel->tx_buf;
>>>> +
>>>> +    memset(white_buffer, 0xFF, data_size);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, 
>>>> &err);
>>>> +    ssd16xx_send_x_param(panel, 0x00, &err);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, 
>>>> &err);
>>>> +    ssd16xx_send_y_param(panel, 0x00, &err);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_WRITE_RAM_BW, &err);
>>>> +    ssd16xx_send_data_bulk(panel, white_buffer, data_size, &err);
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD1683_CMD_WRITE_RAM_RED, &err);
>>>> +    ssd16xx_send_data_bulk(panel, white_buffer, data_size, &err);
>>>> +
>>>> +    /* Set border waveform for the clear operation */
>>>> +    drm_dbg(&panel->drm, "clear_display: Set border init waveform: 
>>>> 0x%02x\n",
>>>> +        bw_tbl[panel->border_waveform_init_idx]);
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, 
>>>> &err);
>>>> +    ssd16xx_send_data(panel,
>>>> +              bw_tbl[panel->border_waveform_init_idx],
>>>> +              &err);
>>>> +
>>>> +    /* 3-colour mode: CTRL1_NORMAL (read both RAMs); BW mode: 
>>>> bypass RED. */
>>>> +    ssd16xx_display_update(panel,
>>>> +                   panel->color_mode == SSD16XX_COLOR_MODE_3COLOR
>>>> +                    ? panel->controller_cfg->ctrl1_normal
>>>> +                    : panel->controller_cfg->ctrl1_bypass_red_ram,
>>>> +                   SSD16XX_CTRL1_BYTE2_DEFAULT, ctrl2, &err);
>>>> +
>>>> +    /* Restore border waveform to update/preservation value */
>>>> +    drm_dbg(&panel->drm, "clear_display: Restored border update 
>>>> waveform: 0x%02x\n",
>>>> +        bw_tbl[panel->border_waveform_update_idx]);
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, 
>>>> &err);
>>>> +    ssd16xx_send_data(panel,
>>>> +              bw_tbl[panel->border_waveform_update_idx],
>>>> +              &err);
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>> +static u8 ssd16xx_refresh_mode_to_ctrl2(struct ssd16xx_panel *panel,
>>>> +                    enum ssd16xx_refresh_mode mode)
>>>> +{
>>>> +    if (mode < ARRAY_SIZE(panel->controller_cfg->ctrl2_refresh))
>>>> +        return panel->controller_cfg->ctrl2_refresh[mode];
>>>> +    return panel->controller_cfg->ctrl2_refresh[SSD16XX_REFRESH_FULL];
>>>> +}
>>>> +
>>>> +/*
>>>> + * Clear display on new DRM master open (if clear_on_init >= 0).
>>>> + * Guarded by panel->first_clear_done; master_drop resets it 
>>>> unconditionally
>>>> + * so each new client session gets a fresh clear.
>>>> + */
>>>> +static int ssd16xx_clear_display_on_init(struct ssd16xx_panel *panel)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (panel->clear_on_init < 0 || panel->first_clear_done)
>>>> +        return 0;
>>>> +
>>>> +    drm_dbg(&panel->drm, "clear_on_init: running, mode=%d\n",
>>>> +        panel->clear_on_init);
>>>> +    ret = ssd16xx_clear_display(panel,
>>>> +                    ssd16xx_refresh_mode_to_ctrl2(panel, panel- 
>>>> >clear_on_init));
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    panel->first_clear_done = true;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Clear display when the displaying client exits (if 
>>>> clear_on_close >= 0).
>>>> + * Called from ssd16xx_drm_master_drop().
>>>> + */
>>>> +static int ssd16xx_clear_display_on_exit(struct ssd16xx_panel *panel)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (panel->clear_on_close < 0)
>>>> +        return 0;
>>>> +
>>>> +    drm_dbg(&panel->drm, "clear_on_close: running, mode=%d\n",
>>>> +        panel->clear_on_close);
>>>> +    ret =  ssd16xx_clear_display(panel,
>>>> +                     ssd16xx_refresh_mode_to_ctrl2(panel, panel- 
>>>> >clear_on_close));
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_pixel_luma() - return ITU-R BT.601 luminance (0-255) for 
>>>> one pixel.
>>>> + *
>>>> + * For colour formats the result is (299*R + 587*G + 114*B) / 1000;
>>>> + * for luma-only formats the luma byte is returned directly.
>>>> + *
>>>> + * R1 is never passed here — it is already 1bpp and is handled 
>>>> directly by
>>>> + * the callers.
>>>> + */
>>>> +static u8 ssd16xx_pixel_luma(struct iosys_map *src,
>>>> +                 struct drm_framebuffer *fb,
>>>> +                 unsigned int x, unsigned int y)
>>>> +{
>>>> +    switch (fb->format->format) {
>>>> +    case DRM_FORMAT_XRGB8888: {
>>>> +        u32 *line = (u32 *)(src->vaddr + y * fb->pitches[0]);
>>>> +        u32 px = line[x];
>>>> +        u8 r = (px >> 16) & 0xFF, g = (px >> 8) & 0xFF, b = px & 0xFF;
>>>> +
>>>> +        return (u8)((299u * r + 587u * g + 114u * b) / 1000u);
>>>> +    }
>>>> +    case DRM_FORMAT_RGB888: {
>>>> +        u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
>>>> +        u8 r = line[x * 3], g = line[x * 3 + 1], b = line[x * 3 + 2];
>>>> +
>>>> +        return (u8)((299u * r + 587u * g + 114u * b) / 1000u);
>>>> +    }
>>>> +    case DRM_FORMAT_RGB565: {
>>>> +        u16 *line = (u16 *)(src->vaddr + y * fb->pitches[0]);
>>>> +        u16 px = line[x];
>>>> +        u8 r = ((px >> 11) & 0x1F) << 3;
>>>> +        u8 g = ((px >> 5) & 0x3F) << 2;
>>>> +        u8 b = (px & 0x1F) << 3;
>>>> +
>>>> +        return (u8)((299u * r + 587u * g + 114u * b) / 1000u);
>>>> +    }
>>>> +    case DRM_FORMAT_R8: {
>>>> +        u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
>>>> +
>>>> +        return line[x];
>>>> +    }
>>>> +    case DRM_FORMAT_NV12:
>>>> +    case DRM_FORMAT_NV16:
>>>> +        return ((u8 *)(src->vaddr))[y * fb->pitches[0] + x];
>>>> +    case DRM_FORMAT_YUYV: {
>>>> +        u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
>>>> +
>>>> +        return line[x * 2];
>>>> +    }
>>>> +    case DRM_FORMAT_UYVY: {
>>>> +        u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
>>>> +
>>>> +        return line[x * 2 + 1];
>>>> +    }
>>>> +    default:
>>>> +        return 0;
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_pixel_is_white() - test whether a pixel maps to white in 
>>>> 1bpp output.
>>>> + *
>>>> + * Uses fixed threshold of 127. Pixels with luma strictly greater 
>>>> than 127
>>>> + * are rendered white.
>>>> + */
>>>> +static bool ssd16xx_pixel_is_white(struct iosys_map *src,
>>>> +                   struct drm_framebuffer *fb,
>>>> +                   unsigned int x, unsigned int y)
>>>> +{
>>>> +    /* R1 is already binarised; avoid the luma computation 
>>>> entirely. */
>>>> +    if (fb->format->format == DRM_FORMAT_R1) {
>>>> +        u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
>>>> +
>>>> +        return !!(line[x / 8] & (1 << (7 - (x % 8))));
>>>> +    }
>>>> +    return ssd16xx_pixel_luma(src, fb, x, y) > 127;
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_pixel_is_red() - test whether a pixel is dominated by 
>>>> the red channel.
>>>> + *
>>>> + * Only meaningful for formats that carry RGB information 
>>>> (XRGB8888, RGB888,
>>>> + * RGB565).  For luma-only and monochrome formats there is no red 
>>>> channel, so
>>>> + * the function always returns false; callers should use 
>>>> ssd16xx_pixel_is_white()
>>>> + * to obtain the BW value for those formats.
>>>> + *
>>>> + * Returns true when the red component exceeds 50% intensity AND is 
>>>> strictly
>>>> + * greater than both green and blue (dominant red hue).
>>>> + */
>>>> +static bool ssd16xx_pixel_is_red(struct iosys_map *src,
>>>> +                 struct drm_framebuffer *fb,
>>>> +                 unsigned int x, unsigned int y)
>>>> +{
>>>> +    u32 format = fb->format->format;
>>>> +
>>>> +    switch (format) {
>>>> +    case DRM_FORMAT_XRGB8888: {
>>>> +        u32 *line = (u32 *)(src->vaddr + y * fb->pitches[0]);
>>>> +        u32 px = line[x];
>>>> +        u8 r = (px >> 16) & 0xFF;
>>>> +        u8 g = (px >> 8) & 0xFF;
>>>> +        u8 b = px & 0xFF;
>>>> +
>>>> +        return r > 127 && r > g && r > b;
>>>> +    }
>>>> +    case DRM_FORMAT_RGB888: {
>>>> +        u8 *line = (u8 *)(src->vaddr + y * fb->pitches[0]);
>>>> +        u8 r = line[x * 3];
>>>> +        u8 g = line[x * 3 + 1];
>>>> +        u8 b = line[x * 3 + 2];
>>>> +
>>>> +        return r > 127 && r > g && r > b;
>>>> +    }
>>>> +    case DRM_FORMAT_RGB565: {
>>>> +        u16 *line = (u16 *)(src->vaddr + y * fb->pitches[0]);
>>>> +        u16 px = line[x];
>>>> +        u8 r = ((px >> 11) & 0x1F) << 3;
>>>> +        u8 g = ((px >> 5) & 0x3F) << 2;
>>>> +        u8 b = (px & 0x1F) << 3;
>>>> +
>>>> +        return r > 127 && r > g && r > b;
>>>> +    }
>>>> +    default:
>>>> +        return false; /* No colour channel information */
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_convert_fb_to_3color() - split a framebuffer into BW and 
>>>> RED planes.
>>>> + * @bw_dst:  output buffer for the black/white RAM plane (1=white, 
>>>> 0=black)
>>>> + * @red_dst: output buffer for the red RAM plane        (1=red, 
>>>> 0=not red)
>>>> + * @src:     mapped framebuffer memory
>>>> + * @fb:      DRM framebuffer descriptor
>>>> + * @rect:    region to convert (must be aligned to 8-pixel boundaries)
>>>> + *
>>>> + * Each output buffer must be at least rect_width/8 * rect_height 
>>>> bytes.
>>>> + * Pixels are classified as:
>>>> + *   - red:   written to red_dst as 1, bw_dst as 0 (black)
>>>> + *   - white: written to bw_dst as 1, red_dst as 0
>>>> + *   - black: written to both as 0
>>>> + *
>>>> + * For monochrome formats (R1) where no colour information is 
>>>> available the
>>>> + * source data is copied verbatim to bw_dst and red_dst is cleared 
>>>> to 0xFF
>>>> + * (all-white = no red pixels).
>>>> + */
>>>> +static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
>>>> +                     struct iosys_map *src,
>>>> +                     struct drm_framebuffer *fb,
>>>> +                     struct drm_rect *rect)
>>>> +{
>>>> +    unsigned int x, y;
>>>> +    u8 bw_byte = 0, red_byte = 0;
>>>> +    unsigned int bit_pos = 0;
>>>> +    unsigned int dst_idx = 0;
>>>> +
>>>> +    drm_dbg(fb->dev,
>>>> +        "convert_3color: fmt=%p4cc rect=(%d,%d)-(%d,%d) path=%s\n",
>>>> +        &fb->format->format,
>>>> +        rect->x1, rect->y1, rect->x2, rect->y2,
>>>> +        fb->format->format == DRM_FORMAT_R1 ? "R1-direct" : "color- 
>>>> pixel");
>>>> +
>>>> +    /*
>>>> +     * R1 is already monochrome — no colour channel exists.
>>>> +     * Copy BW data directly and leave the red plane all-white 
>>>> (transparent).
>>>> +     */
>>>> +    if (fb->format->format == DRM_FORMAT_R1) {
>>>> +        unsigned int src_pitch = fb->pitches[0];
>>>> +        unsigned int width_bytes = drm_rect_width(rect) / 8;
>>>> +        unsigned int data_size = width_bytes * drm_rect_height(rect);
>>>> +
>>>> +        for (y = rect->y1; y < rect->y2; y++) {
>>>> +            u8 *line = src->vaddr + y * src_pitch + (rect->x1 / 8);
>>>> +
>>>> +            memcpy(bw_dst + dst_idx, line, width_bytes);
>>>> +            dst_idx += width_bytes;
>>>> +        }
>>>> +        memset(red_dst, 0xFF, data_size); /* 0xFF = all white: no 
>>>> red pixels */
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Use fixed threshold of 127 for grayscale to monochrome 
>>>> conversion. */
>>>> +    for (y = rect->y1; y < rect->y2; y++) {
>>>> +        for (x = rect->x1; x < rect->x2; x++) {
>>>> +            bool is_red = ssd16xx_pixel_is_red(src, fb, x, y);
>>>> +
>>>> +            if (is_red)
>>>> +                red_byte |= (1 << (7 - bit_pos));
>>>> +            else if (ssd16xx_pixel_is_white(src, fb, x, y))
>>>> +                bw_byte |= (1 << (7 - bit_pos));
>>>> +            /* else: black pixel — both bits remain 0 */
>>>> +            if (++bit_pos == 8) {
>>>> +                bw_dst[dst_idx] = bw_byte;
>>>> +                red_dst[dst_idx] = red_byte;
>>>> +                dst_idx++;
>>>> +                bw_byte = 0;
>>>> +                red_byte = 0;
>>>> +                bit_pos = 0;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        /* Flush any partial byte at the end of each row */
>>>> +        if (bit_pos > 0) {
>>>> +            bw_dst[dst_idx] = bw_byte;
>>>> +            red_dst[dst_idx] = red_byte;
>>>> +            dst_idx++;
>>>> +            bw_byte = 0;
>>>> +            red_byte = 0;
>>>> +            bit_pos = 0;
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_convert_r8_to_red_only() - map an R8 framebuffer to the 
>>>> RED RAM plane.
>>>> + *
>>>> + * Used when the panel has a physical red colour plane 
>>>> (red_supported == true)
>>>> + * and the framebuffer format is DRM_FORMAT_R8.  Pixels with value 
>>>> >= 128 are
>>>> + * treated as red ink; the BW RAM is set to all-white so that only 
>>>> red ink
>>>> + * appears on the white background.
>>>> + *
>>>> + * Hardware orientation is handled by the caller via RAM counter 
>>>> positioning;
>>>> + * data is written in normal row-major order here (same as 
>>>> convert_fb_to_3color).
>>>> + */
>>>> +static void ssd16xx_convert_r8_to_red_only(u8 *bw_dst, u8 *red_dst,
>>>> +                       struct iosys_map *src,
>>>> +                       struct drm_framebuffer *fb,
>>>> +                       struct drm_rect *rect)
>>>> +{
>>>> +    unsigned int src_pitch = fb->pitches[0];
>>>> +    unsigned int width = drm_rect_width(rect);
>>>> +    unsigned int height = drm_rect_height(rect);
>>>> +    unsigned int data_size = DIV_ROUND_UP(width, 8) * height;
>>>> +    unsigned int dst_idx = 0;
>>>> +    unsigned int x, y;
>>>> +    u8 red_byte = 0;
>>>> +    unsigned int bit_pos = 0;
>>>> +
>>>> +    /* BW RAM: all-white background - no black ink, only red ink 
>>>> shows */
>>>> +    memset(bw_dst, 0xFF, data_size);
>>>> +
>>>> +    /* RED RAM: R8 >= 128 -> red ink (1-bit set) */
>>>> +    for (y = rect->y1; y < rect->y2; y++) {
>>>> +        u8 *line = src->vaddr + y * src_pitch;
>>>> +
>>>> +        for (x = rect->x1; x < rect->x2; x++) {
>>>> +            if (line[x] >= 128)
>>>> +                red_byte |= (1 << (7 - bit_pos));
>>>> +            if (++bit_pos == 8) {
>>>> +                red_dst[dst_idx++] = red_byte;
>>>> +                red_byte = 0;
>>>> +                bit_pos = 0;
>>>> +            }
>>>> +        }
>>>> +        if (bit_pos > 0) {
>>>> +            red_dst[dst_idx++] = red_byte;
>>>> +            red_byte = 0;
>>>> +            bit_pos = 0;
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * Convert framebuffer to 1-bit monochrome for e-paper display.
>>>> + *
>>>> + * Supported formats: XRGB8888, RGB888, RGB565, R8, NV12, NV16, 
>>>> YUYV, UYVY, R1.
>>>> + * For colour and luma formats, Otsu's global binarisation method 
>>>> computes an
>>>> + * optimal per-image threshold from the luminance histogram.
>>>> + * R1 is the controller's native format and bypasses conversion 
>>>> entirely.
>>>> + *
>>>> + * Output layout:
>>>> + *   0°/180°  landscape: row-major, left-to-right, top-to-bottom
>>>> + *   90°/270° CW portrait: column-major, rightmost column first
>>>> + */
>>>> +static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
>>>> +                       struct drm_framebuffer *fb,
>>>> +                       struct drm_rect *rect,
>>>> +                       unsigned int orientation)
>>>> +{
>>>> +    u32 format = fb->format->format;
>>>> +    int x, y;
>>>> +    u8 byte = 0;
>>>> +    unsigned int bit_pos = 0;
>>>> +    unsigned int dst_idx = 0;
>>>> +
>>>> +    /* Use fixed threshold of 127 for grayscale to monochrome 
>>>> conversion. */
>>>> +    drm_dbg(fb->dev,
>>>> +        "convert_1bpp: fmt=%p4cc rect=(%d,%d)-(%d,%d) orient=%u° 
>>>> path=%s\n",
>>>> +        &fb->format->format,
>>>> +        rect->x1, rect->y1, rect->x2, rect->y2,
>>>> +        orientation,
>>>> +        (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 
>>>> 8 == 0) ? "R1-fast" :
>>>> +        (orientation == 90 || orientation == 270) ? "portrait" : 
>>>> "landscape");
>>>> +
>>>> +    /*
>>>> +     * R1 fast path: 0° landscape with byte-aligned rect.
>>>> +     * R1 is already 1bpp so landscape rows map directly to output 
>>>> bytes via
>>>> +     * memcpy — no per-pixel computation needed.  rect->x1 must be a
>>>> +     * multiple of 8 so that (rect->x1 / 8) gives the correct byte 
>>>> offset;
>>>> +     * if not, the generic pixel-by-pixel loop below handles non- 
>>>> aligned
>>>> +     * rects safely.
>>>> +     */
>>>> +    if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 
>>>> == 0) {
>>>> +        unsigned int src_pitch = fb->pitches[0];
>>>> +        unsigned int width_bytes = drm_rect_width(rect) / 8;
>>>> +
>>>> +        for (y = rect->y1; y < rect->y2; y++) {
>>>> +            u8 *src_line = src->vaddr + y * src_pitch + (rect->x1 / 
>>>> 8);
>>>> +
>>>> +            memcpy(dst + dst_idx, src_line, width_bytes);
>>>> +            dst_idx += width_bytes;
>>>> +        }
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    switch (orientation) {
>>>> +    case 90:
>>>> +    case 270:
>>>> +        /*
>>>> +         * Portrait (90° or 270°): column-major packing.
>>>> +         * Each portrait source column becomes one physical RAM row.
>>>> +         * The data entry mode and cursor position control scan 
>>>> direction.
>>>> +         */
>>>> +        for (x = rect->x2 - 1; x >= (int)rect->x1; x--) {
>>>> +            for (y = rect->y1; y < rect->y2; y++) {
>>>> +                if (ssd16xx_pixel_is_white(src, fb, x, y))
>>>> +                    byte |= (1 << (7 - bit_pos));
>>>> +                if (++bit_pos == 8) {
>>>> +                    dst[dst_idx++] = byte;
>>>> +                    byte = 0;
>>>> +                    bit_pos = 0;
>>>> +                }
>>>> +            }
>>>> +            if (bit_pos > 0) {
>>>> +                dst[dst_idx++] = byte;
>>>> +                byte = 0;
>>>> +                bit_pos = 0;
>>>> +            }
>>>> +        }
>>>> +        break;
>>>> +
>>>> +    case 0:
>>>> +    case 180:
>>>> +    default:
>>>> +        /*
>>>> +         * Landscape (0° or 180°): row-major packing.
>>>> +         * Each landscape source row becomes one physical RAM row.
>>>> +         * The data entry mode and cursor position control scan 
>>>> direction.
>>>> +         */
>>>> +        for (y = rect->y1; y < rect->y2; y++) {
>>>> +            for (x = rect->x1; x < rect->x2; x++) {
>>>> +                if (ssd16xx_pixel_is_white(src, fb, x, y))
>>>> +                    byte |= (1 << (7 - bit_pos));
>>>> +                if (++bit_pos == 8) {
>>>> +                    dst[dst_idx++] = byte;
>>>> +                    byte = 0;
>>>> +                    bit_pos = 0;
>>>> +                }
>>>> +            }
>>>> +            if (bit_pos > 0) {
>>>> +                dst[dst_idx++] = byte;
>>>> +                byte = 0;
>>>> +                bit_pos = 0;
>>>> +            }
>>>> +        }
>>>> +        break;
>>>> +    }
>>>> +}
>>>> +
>>>> +static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct 
>>>> drm_rect *rect,
>>>> +                struct ssd16xx_panel *panel)
>>>> +{
>>>> +    const u8 *ctrl2_tbl = panel->controller_cfg->ctrl2_refresh;
>>>> +    struct drm_gem_dma_object *dma_obj = drm_fb_dma_get_gem_obj(fb, 
>>>> 0);
>>>> +    struct iosys_map map;
>>>> +    int err = 0;
>>>> +    unsigned int data_size = (panel->width * panel->height) / 8;
>>>> +    u8 *mono_buffer = NULL;
>>>> +    u8 *red_buffer = NULL;
>>>> +    u16 ram_x_start, ram_x_end, ram_y_start, ram_y_end;
>>>> +
>>>> +    /* Process full display area; convert handles orientation 
>>>> traversal. */
>>>> +    rect->x1 = 0;
>>>> +    rect->y1 = 0;
>>>> +    rect->x2 = panel->width;
>>>> +    rect->y2 = panel->height;
>>>> +
>>>> +    drm_dbg(&panel->drm,
>>>> +        "fb_dirty: fb=%dx%d, refresh_mode=%d, orientation=%d\n",
>>>> +        fb->width, fb->height, panel->refresh_mode, panel- 
>>>> >orientation);
>>>> +
>>>> +    mono_buffer = panel->tx_buf;
>>>> +    memset(mono_buffer, 0, data_size);
>>>> +
>>>> +    /* 3-colour FULL/FAST: populate red channel. */
>>>> +    if (panel->color_mode == SSD16XX_COLOR_MODE_3COLOR &&
>>>> +        (panel->refresh_mode == SSD16XX_REFRESH_FULL ||
>>>> +         panel->refresh_mode == SSD16XX_REFRESH_FAST)) {
>>>> +        red_buffer = panel->tx_red_buf;
>>>> +        memset(red_buffer, 0, data_size);
>>>> +    }
>>>> +
>>>> +    iosys_map_set_vaddr(&map, dma_obj->vaddr);
>>>> +
>>>> +    if (red_buffer && fb->format->format == DRM_FORMAT_R8)
>>>> +        ssd16xx_convert_r8_to_red_only(mono_buffer, red_buffer, 
>>>> &map, fb, rect);
>>>> +    else if (red_buffer)
>>>> +        ssd16xx_convert_fb_to_3color(mono_buffer, red_buffer, &map, 
>>>> fb, rect);
>>>> +    else
>>>> +        ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect, 
>>>> panel->orientation);
>>>> +
>>>> +    drm_dbg(&panel->drm,
>>>> +        "fb_dirty: mono[0..3]=0x%02x 0x%02x 0x%02x 0x%02x 
>>>> (data_size=%u)\n",
>>>> +        mono_buffer[0], mono_buffer[1], mono_buffer[2], 
>>>> mono_buffer[3],
>>>> +        data_size);
>>>> +
>>>> +    /* Set RAM window and cursor for current orientation. */
>>>> +    ram_x_start = 0;
>>>> +    ram_x_end = (panel->controller_cfg->max_width / 8) - 1;
>>>> +    ram_y_start = 0;
>>>> +    ram_y_end = panel->controller_cfg->max_height - 1;
>>>> +
>>>> +    switch (panel->orientation) {
>>>> +    case 90:
>>>> +    case 180:
>>>> +        /* 90°/180°: XDEC_YDEC mode, send end-before-start; cursor 
>>>> at (max, max). */
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
>>>> +        ssd16xx_send_x_param(panel, ram_x_end, &err);
>>>> +        ssd16xx_send_x_param(panel, ram_x_start, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
>>>> +        ssd16xx_send_y_param(panel, ram_y_end, &err);
>>>> +        ssd16xx_send_y_param(panel, ram_y_start, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
>>>> +        ssd16xx_send_x_param(panel, ram_x_end, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
>>>> +        ssd16xx_send_y_param(panel, ram_y_end, &err);
>>>> +        break;
>>>> +
>>>> +    default: /* 0°/270° */
>>>> +        /* 0°/270°: XINC_YINC mode, cursor at (0, 0). */
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
>>>> +        ssd16xx_send_x_param(panel, ram_x_start, &err);
>>>> +        ssd16xx_send_x_param(panel, ram_x_end, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
>>>> +        ssd16xx_send_y_param(panel, ram_y_start, &err);
>>>> +        ssd16xx_send_y_param(panel, ram_y_end, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
>>>> +        ssd16xx_send_x_param(panel, ram_x_start, &err);
>>>> +
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
>>>> +        ssd16xx_send_y_param(panel, ram_y_start, &err);
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    ssd16xx_send_cmd(panel, SSD16XX_CMD_WRITE_RAM_BW, &err);
>>>> +    ssd16xx_send_data_bulk(panel, mono_buffer, data_size, &err);
>>>> +
>>>> +    /* Re-send border waveform when: every-update mode, init frame, or
>>>> +     * the border_waveform_update property just changed (one-shot).
>>>> +     */
>>>> +    drm_dbg(&panel->drm,
>>>> +        "fb_dirty: border check: every_update=%d init_pending=%d 
>>>> border_pending=%d idx=%d hw=0x%02x\n",
>>>> +        panel->border_refresh_on_every_update, panel- 
>>>> >init_refresh_pending,
>>>> +        panel->border_waveform_pending, panel- 
>>>> >border_waveform_update_idx,
>>>> +        panel->controller_cfg->border_waveform_table[panel- 
>>>> >border_waveform_update_idx]);
>>>> +    if (panel->border_refresh_on_every_update || panel- 
>>>> >init_refresh_pending ||
>>>> +        panel->border_waveform_pending) {
>>>> +        u8 idx = panel->border_waveform_update_idx;
>>>> +        u8 border = panel->controller_cfg->border_waveform_table[idx];
>>>> +
>>>> +        drm_dbg(&panel->drm, "fb_dirty: Sending border waveform: 
>>>> 0x%02x\n",
>>>> +            border);
>>>> +        ssd16xx_send_cmd(panel, 
>>>> SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
>>>> +        ssd16xx_send_data(panel, border, &err);
>>>> +        panel->border_waveform_pending = false;
>>>> +    }
>>>> +
>>>> +    switch (panel->refresh_mode) {
>>>> +    case SSD16XX_REFRESH_FULL:
>>>> +        /*
>>>> +         * BW full refresh: write RED RAM BEFORE display_update
>>>> +         * to avoid a post-BUSY write timing issue on some
>>>> +         * controller revisions that silently corrupts RED RAM.
>>>> +         * RED RAM is then bypassed (CTRL1_BYPASS_RED_RAM) so
>>>> +         * stale RED RAM content does not affect the output.
>>>> +         */
>>>> +        ssd16xx_send_cmd(panel, SSD1683_CMD_WRITE_RAM_RED, &err);
>>>> +        if (red_buffer) {
>>>> +            /* 3-colour: write red channel before activating */
>>>> +            ssd16xx_send_data_bulk(panel, red_buffer, data_size, 
>>>> &err);
>>>> +            ssd16xx_display_update(panel, panel->controller_cfg- 
>>>> >ctrl1_normal,
>>>> +                           SSD16XX_CTRL1_BYTE2_DEFAULT,
>>>> +                           ctrl2_tbl[SSD16XX_REFRESH_FULL], &err);
>>>> +        } else {
>>>> +            ssd16xx_send_data_bulk(panel, mono_buffer, data_size, 
>>>> &err);
>>>> +            ssd16xx_display_update(panel, panel->controller_cfg- 
>>>> >ctrl1_bypass_red_ram,
>>>> +                           SSD16XX_CTRL1_BYTE2_DEFAULT,
>>>> +                           ctrl2_tbl[SSD16XX_REFRESH_FULL], &err);
>>>> +        }
>>>> +        break;
>>>> +    case SSD16XX_REFRESH_FAST:
>>>> +        /*
>>>> +         * Fast refresh: LUT pre-loaded during hw_init; BYPASS_RED_RAM
>>>> +         * so RED RAM does not affect the current output.
>>>> +         * Write RED RAM BEFORE display_update (same reasoning as 
>>>> FULL)
>>>> +         * so it holds the just-displayed frame as a valid 
>>>> reference for
>>>> +         * any subsequent PARTIAL refresh.
>>>> +         */
>>>> +
>>>> +        ssd16xx_send_cmd(panel, SSD1683_CMD_WRITE_RAM_RED, &err);
>>>> +        if (red_buffer) {
>>>> +            /* 3-colour: write red channel before activating */
>>>> +            ssd16xx_send_data_bulk(panel, red_buffer, data_size, 
>>>> &err);
>>>> +            ssd16xx_display_update(panel, panel->controller_cfg- 
>>>> >ctrl1_normal,
>>>> +                           SSD16XX_CTRL1_BYTE2_DEFAULT,
>>>> +                           ctrl2_tbl[SSD16XX_REFRESH_FAST], &err);
>>>> +        } else {
>>>> +            ssd16xx_send_data_bulk(panel, mono_buffer, data_size, 
>>>> &err);
>>>> +            ssd16xx_display_update(panel, panel->controller_cfg- 
>>>> >ctrl1_bypass_red_ram,
>>>> +                           SSD16XX_CTRL1_BYTE2_DEFAULT,
>>>> +                           ctrl2_tbl[SSD16XX_REFRESH_FAST], &err);
>>>> +        }
>>>> +        break;
>>>> +    case SSD16XX_REFRESH_PARTIAL:
>>>> +    default:
>>>> +        /*
>>>> +         * Partial refresh: both RAMs used for transition waveforms.
>>>> +         * RED RAM must hold the PREVIOUS frame (= current display
>>>> +         * content) so the controller can compute pixel transitions.
>>>> +         * Write RED RAM AFTER display_update so it captures the
>>>> +         * just-displayed frame as the reference for the next partial.
>>>> +         */
>>>> +        drm_dbg(&panel->drm,
>>>> +            "fb_dirty: partial pre-update: mono[0]=0x%02x (BW=new, 
>>>> RED=prev)\n",
>>>> +            mono_buffer[0]);
>>>> +        ssd16xx_display_update(panel, panel->controller_cfg- 
>>>> >ctrl1_normal,
>>>> +                       SSD16XX_CTRL1_BYTE2_DEFAULT,
>>>> +                       ctrl2_tbl[SSD16XX_REFRESH_PARTIAL], &err);
>>>> +        ssd16xx_send_cmd(panel, SSD1683_CMD_WRITE_RAM_RED, &err);
>>>> +        ssd16xx_send_data_bulk(panel, mono_buffer, data_size, &err);
>>>> +        drm_dbg(&panel->drm,
>>>> +            "fb_dirty: partial post-update: wrote RED baseline 
>>>> mono[0]=0x%02x\n",
>>>> +            mono_buffer[0]);
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>> +/* 
>>>> -----------------------------------------------------------------------------
>>>> + * Plane Functions
>>>> + */
>>>> +
>>>> +static void ssd16xx_plane_destroy(struct drm_plane *plane)
>>>> +{
>>>> +    drm_plane_cleanup(plane);
>>>> +}
>>>> +
>>>> +static void ssd16xx_plane_reset(struct drm_plane *plane)
>>>> +{
>>>> +    drm_atomic_helper_plane_reset(plane);
>>>> +}
>>>
>>> Please avoid these wrappers.
>>>
>>
>> Understood, will update in V2.
>>
>>>> +
>>>> +static const struct drm_plane_funcs ssd16xx_plane_funcs = {
>>>> +    .update_plane = drm_atomic_helper_update_plane,
>>>> +    .disable_plane = drm_atomic_helper_disable_plane,
>>>> +    .destroy = ssd16xx_plane_destroy,
>>>> +    .reset = ssd16xx_plane_reset,
>>>> +    .atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>>>> +    .atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>>>> +};
>>>> +
>>>> +static int ssd16xx_plane_atomic_check(struct drm_plane *plane,
>>>> +                      struct drm_atomic_state *state)
>>>> +{
>>>> +    struct drm_plane_state *new_plane_state =
>>>> +        drm_atomic_get_new_plane_state(state, plane);
>>>> +    struct drm_crtc_state *crtc_state;
>>>> +
>>>> +    if (!new_plane_state->crtc)
>>>> +        return 0;
>>>> +
>>>> +    crtc_state = drm_atomic_get_new_crtc_state(state, 
>>>> new_plane_state->crtc);
>>>> +
>>>> +    return drm_atomic_helper_check_plane_state(new_plane_state, 
>>>> crtc_state,
>>>> +                           DRM_PLANE_NO_SCALING,
>>>> +                           DRM_PLANE_NO_SCALING,
>>>> +                           false, false);
>>>> +}
>>>> +
>>>> +static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
>>>> +                    struct drm_atomic_state *state)
>>>> +{
>>>> +    struct drm_plane_state *old_state = 
>>>> drm_atomic_get_old_plane_state(state, plane);
>>>> +    struct drm_plane_state *new_state = 
>>>> drm_atomic_get_new_plane_state(state, plane);
>>>> +    struct ssd16xx_panel *panel = plane_to_ssd16xx_panel(plane);
>>>> +    enum ssd16xx_refresh_mode saved_mode;
>>>> +    u8 saved_border_waveform_idx;
>>>> +    struct drm_framebuffer *fb = new_state->fb;
>>>> +    struct drm_rect rect;
>>>> +    int ret;
>>>> +
>>>> +    drm_dbg(&panel->drm, "plane_atomic_update: fb=%p, 
>>>> initialized=%d\n",
>>>> +        fb, panel->initialized);
>>>> +
>>>> +    if (!fb || !panel->initialized)
>>>> +        return;
>>>> +
>>>> +    /*
>>>> +     * If a rotation change is pending, skip the update here — 
>>>> crtc_atomic_flush
>>>> +     * will re-init the hardware for the new orientation and redraw.
>>>> +     */
>>>> +    if (panel->reinit_pending) {
>>>> +        drm_dbg(&panel->drm, "plane_atomic_update: skipping (reinit 
>>>> pending)\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (!drm_atomic_helper_damage_merged(old_state, new_state, 
>>>> &rect)) {
>>>> +        rect.x1 = 0;
>>>> +        rect.y1 = 0;
>>>> +        rect.x2 = fb->width;
>>>> +        rect.y2 = fb->height;
>>>> +        drm_dbg(&panel->drm, "plane_atomic_update: no damage, using 
>>>> full screen\n");
>>>> +    }
>>>> +
>>>> +    drm_dbg(&panel->drm, "plane_atomic_update: calling fb_dirty 
>>>> rect=(%d,%d)-(%d,%d)\n",
>>>> +        rect.x1, rect.y1, rect.x2, rect.y2);
>>>> +    /*
>>>> +     * When refresh_mode_init was set, use the specified mode for 
>>>> this first
>>>> +     * frame only, then restore the user-configured refresh_mode so
>>>> +     * subsequent updates continue with the configured mode.
>>>> +     */
>>>> +    saved_mode = panel->refresh_mode;
>>>> +    saved_border_waveform_idx = panel->border_waveform_update_idx;
>>>> +    if (panel->init_refresh_pending) {
>>>> +        panel->refresh_mode = panel->refresh_mode_init;
>>>> +        panel->border_waveform_update_idx = panel- 
>>>> >border_waveform_init_idx;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Fast refresh (0xC7) omits LOAD_LUT on every update cycle and 
>>>> relies
>>>> +     * on the LUT being pre-loaded upfront.  The property setter arms
>>>> +     * fast_lut_pending whenever the user switches into fast mode. 
>>>> Consume
>>>> +     * the flag here (once) before the first fast-refresh frame so the
>>>> +     * controller's LUT is in the correct state.
>>>> +     */
>>>> +    if (panel->fast_lut_pending) {
>>>> +        ret = ssd16xx_preload_fast_lut(panel);
>>>> +        if (ret) {
>>>> +            drm_err(&panel->drm,
>>>> +                "plane_atomic_update: fast LUT preload failed: 
>>>> %d\n", ret);
>>>> +        }
>>>> +
>>>> +        panel->fast_lut_pending = false;
>>>> +    }
>>>> +
>>>> +    ret = ssd16xx_fb_dirty(fb, &rect, panel);
>>>> +    if (ret)
>>>> +        drm_err(&panel->drm, "plane_atomic_update: display update 
>>>> failed: %d\n", ret);
>>>> +    else
>>>> +        panel->last_fb = fb;
>>>> +
>>>> +    panel->refresh_mode = saved_mode;
>>>> +    panel->border_waveform_update_idx = saved_border_waveform_idx;
>>>> +
>>>> +    /*
>>>> +     * If this was the init frame (which used border_waveform_init_idx
>>>> +     * inside fb_dirty), arm border_waveform_pending so the normal
>>>> +     * (non-init) border value is sent at the start of the next 
>>>> update.
>>>> +     */
>>>> +    if (panel->init_refresh_pending) {
>>>> +        panel->init_refresh_pending = false;
>>>> +        panel->border_waveform_pending = true;
>>>> +    }
>>>> +}
>>>> +
>>>> +static const struct drm_plane_helper_funcs 
>>>> ssd16xx_plane_helper_funcs = {
>>>> +    .atomic_check = ssd16xx_plane_atomic_check,
>>>> +    .atomic_update = ssd16xx_plane_atomic_update,
>>>> +};
>>>> +
>>>> +/* 
>>>> -----------------------------------------------------------------------------
>>>> + * CRTC Functions
>>>> + */
>>>> +
>>>> +static void ssd16xx_crtc_destroy(struct drm_crtc *crtc)
>>>> +{
>>>> +    drm_crtc_cleanup(crtc);
>>>> +}
>>>> +
>>>> +static const struct drm_crtc_funcs ssd16xx_crtc_funcs = {
>>>> +    .reset = drm_atomic_helper_crtc_reset,
>>>> +    .destroy = ssd16xx_crtc_destroy,
>>>> +    .set_config = drm_atomic_helper_set_config,
>>>> +    .page_flip = drm_atomic_helper_page_flip,
>>>> +    .atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>>>> +    .atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>>>> +};
>>>> +
>>>> +static enum drm_mode_status ssd16xx_crtc_mode_valid(struct drm_crtc 
>>>> *crtc,
>>>> +                            const struct drm_display_mode *mode)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = crtc_to_ssd16xx_panel(crtc);
>>>> +
>>>> +    /* Accept only our panel's native mode (landscape or portrait) */
>>>> +    if ((mode->hdisplay == panel->mode->hdisplay &&
>>>> +         mode->vdisplay == panel->mode->vdisplay) ||
>>>> +        (mode->hdisplay == panel->mode->vdisplay &&
>>>> +         mode->vdisplay == panel->mode->hdisplay))
>>>> +        return MODE_OK;
>>>> +
>>>> +    return MODE_BAD;
>>>> +}
>>>> +
>>>> +static int ssd16xx_crtc_atomic_check(struct drm_crtc *crtc,
>>>> +                     struct drm_atomic_state *state)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
>>>> +                    struct drm_atomic_state *state)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = crtc_to_ssd16xx_panel(crtc);
>>>> +    int ret, idx;
>>>> +
>>>> +    if (!drm_dev_enter(&panel->drm, &idx))
>>>> +        return;
>>>> +
>>>> +    if (panel->clear_on_disable < 0 || panel- 
>>>> >display_cleared_on_deinit)
>>>> +        goto out;
>>>> +
>>>> +    drm_dbg(&panel->drm, "clear_on_disable: running, mode=%d\n",
>>>> +        panel->clear_on_disable);
>>>> +    ret = ssd16xx_clear_display(panel,
>>>> +                    ssd16xx_refresh_mode_to_ctrl2(panel,
>>>> +                                  panel->clear_on_disable));
>>>> +    if (ret) {
>>>> +        drm_err(&panel->drm, "atomic_disable: clear failed: %d\n", 
>>>> ret);
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    panel->display_cleared_on_deinit = true;
>>>> +out:
>>>> +    drm_dev_exit(idx);
>>>> +}
>>>> +
>>>> +static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
>>>> +                       struct drm_atomic_state *state)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = crtc_to_ssd16xx_panel(crtc);
>>>> +    struct drm_crtc_state *crtc_state = 
>>>> drm_atomic_get_new_crtc_state(state, crtc);
>>>> +    int ret, idx;
>>>> +
>>>> +    if (!drm_dev_enter(&panel->drm, &idx))
>>>> +        return;
>>>> +
>>>> +    panel->display_cleared_on_deinit = false;
>>>> +
>>>> +    drm_dbg(&panel->drm, "atomic_enable: %dx%d\n",
>>>> +        crtc_state->mode.hdisplay, crtc_state->mode.vdisplay);
>>>> +
>>>> +    panel->width = crtc_state->mode.hdisplay;
>>>> +    panel->height = crtc_state->mode.vdisplay;
>>>> +
>>>> +    ret = ssd16xx_hw_init(panel);
>>>> +    if (ret) {
>>>> +        drm_err(&panel->drm, "crtc_atomic_enable: HW init failed: 
>>>> %d\n", ret);
>>>> +        goto out;
>>>> +    }
>>>> +    panel->initialized = true;
>>>> +
>>>> +    /* Clear display on first app launch if configured */
>>>> +    ret = ssd16xx_clear_display_on_init(panel);
>>>> +    if (ret)
>>>> +        drm_err(&panel->drm, "crtc_atomic_enable: clear on init 
>>>> failed: %d\n", ret);
>>>> +
>>>> +    /*
>>>> +     * If refresh_mode_init is set, arm init_refresh_pending so
>>>> +     * plane_atomic_update uses the specified mode for the first frame
>>>> +     * then restores the user-configured or panel default 
>>>> refresh_mode.
>>>> +     */
>>>> +    if (panel->refresh_mode_init >= 0) {
>>>> +        drm_dbg(&panel->drm,
>>>> +            "atomic_enable: refresh_mode_init=%d, using for first 
>>>> frame\n",
>>>> +            panel->refresh_mode_init);
>>>> +        panel->init_refresh_pending = true;
>>>> +    }
>>>> +
>>>> +out:
>>>> +    drm_dev_exit(idx);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Re-initialize hardware and redraw the current framebuffer when the
>>>> + * display orientation changes at runtime via the rotation 
>>>> connector property.
>>>> + * Called by the DRM atomic helper after atomic_enable/disable have 
>>>> run.
>>>> + */
>>>> +static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
>>>> +                      struct drm_atomic_state *state)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = crtc_to_ssd16xx_panel(crtc);
>>>> +    struct drm_framebuffer *fb;
>>>> +    struct drm_rect full;
>>>> +    int ret, idx;
>>>> +
>>>> +    if (!panel->reinit_pending || !panel->initialized)
>>>> +        return;
>>>> +
>>>> +    if (!drm_dev_enter(&panel->drm, &idx))
>>>> +        return;
>>>> +
>>>> +    panel->reinit_pending = false;
>>>> +
>>>> +    drm_dbg(&panel->drm, "atomic_flush: reinit, orientation=%u°\n",
>>>> +        panel->orientation);
>>>> +
>>>> +    ret = ssd16xx_hw_init(panel);
>>>> +    if (ret) {
>>>> +        drm_err(&panel->drm, "Orientation re-init failed: %d\n", ret);
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    fb = panel->primary_plane.state ? panel->primary_plane.state->fb
>>>> +                    : panel->last_fb;
>>>> +    if (fb) {
>>>> +        full.x1 = 0;
>>>> +        full.y1 = 0;
>>>> +        full.x2 = fb->width;
>>>> +        full.y2 = fb->height;
>>>> +        ret = ssd16xx_fb_dirty(fb, &full, panel);
>>>> +        if (ret)
>>>> +            drm_err(&panel->drm, "atomic_flush: display update 
>>>> failed: %d\n", ret);
>>>> +        else
>>>> +            panel->last_fb = fb;
>>>> +    }
>>>> +
>>>> +out:
>>>> +    drm_dev_exit(idx);
>>>> +}
>>>> +
>>>> +static const struct drm_crtc_helper_funcs ssd16xx_crtc_helper_funcs 
>>>> = {
>>>> +    .mode_valid     = ssd16xx_crtc_mode_valid,
>>>> +    .atomic_check   = ssd16xx_crtc_atomic_check,
>>>> +    .atomic_disable = ssd16xx_crtc_atomic_disable,
>>>> +    .atomic_enable  = ssd16xx_crtc_atomic_enable,
>>>> +    .atomic_flush   = ssd16xx_crtc_atomic_flush,
>>>> +};
>>>> +
>>>> +/* 
>>>> -----------------------------------------------------------------------------
>>>> + * Connector Functions
>>>> + */
>>>> +
>>>> +static int ssd16xx_connector_get_modes(struct drm_connector 
>>>> *connector)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = to_ssd16xx_panel(connector->dev);
>>>> +    bool mode_is_portrait = (panel->mode->hdisplay < panel->mode- 
>>>> >vdisplay);
>>>> +    bool orient_is_portrait = (panel->orientation == 90 || panel- 
>>>> >orientation == 270);
>>>> +
>>>> +    drm_dbg(&panel->drm, "connector_get_modes: orientation=%u°\n",
>>>> +        panel->orientation);
>>>> +
>>>> +    /* For portrait, swap dimensions so clients see logical size. */
>>>> +    if (mode_is_portrait != orient_is_portrait) {
>>>> +        struct drm_display_mode *mode;
>>>> +
>>>> +        mode = drm_mode_duplicate(&panel->drm, panel->mode);
>>>> +        if (!mode)
>>>> +            return 0;
>>>> +        swap(mode->hdisplay, mode->vdisplay);
>>>> +        swap(mode->hsync_start, mode->vsync_start);
>>>> +        swap(mode->hsync_end, mode->vsync_end);
>>>> +        swap(mode->htotal, mode->vtotal);
>>>> +        swap(mode->width_mm, mode->height_mm);
>>>> +        mode->type |= DRM_MODE_TYPE_PREFERRED;
>>>> +        drm_mode_set_name(mode);
>>>> +        drm_mode_probed_add(connector, mode);
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    return drm_connector_helper_get_modes_fixed(connector, panel- 
>>>> >mode);
>>>> +}
>>>> +
>>>> +static const struct drm_connector_helper_funcs 
>>>> ssd16xx_connector_helper_funcs = {
>>>> +    .get_modes = ssd16xx_connector_get_modes,
>>>> +};
>>>> +
>>>> +/* Enum values for the rotation connector property (degrees 
>>>> clockwise) */
>>>> +static const struct drm_prop_enum_list ssd16xx_rotation_enum[] = {
>>>> +    { 0,   "0"   },
>>>> +    { 90,  "90"  },
>>>> +    { 180, "180" },
>>>> +    { 270, "270" },
>>>> +};
>>>> +
>>>> +/* Enum values for the refresh_mode connector property */
>>>> +static const struct drm_prop_enum_list ssd16xx_refresh_mode_enum[] = {
>>>> +    { SSD16XX_REFRESH_PARTIAL, "partial" },
>>>> +    { SSD16XX_REFRESH_FULL,    "full"    },
>>>> +    { SSD16XX_REFRESH_FAST,    "fast"    },
>>>> +};
>>>> +
>>>> +/*
>>>> + * Enum for clear_on_init, clear_on_close, refresh_mode_init 
>>>> properties.
>>>> + * Value 0 = disabled; values 1-3 = partial/full/fast (refresh mode 
>>>> + 1).
>>>> + * The +1 offset allows a single enum to represent both "disabled" 
>>>> and the
>>>> + * three refresh modes without sign-extending the DRM property value.
>>>> + */
>>>> +static const struct drm_prop_enum_list ssd16xx_init_refresh_enum[] = {
>>>> +    { 0, "disabled" },
>>>> +    { 1, "partial"  },
>>>> +    { 2, "full"     },
>>>> +    { 3, "fast"     },
>>>> +};
>>>> +
>>>> +/* Enum values for the color_mode connector property */
>>>> +static const struct drm_prop_enum_list ssd16xx_color_mode_enum[] = {
>>>> +    { SSD16XX_COLOR_MODE_BW,     "black-white" },
>>>> +    { SSD16XX_COLOR_MODE_3COLOR, "3-color"     },
>>>> +};
>>>> +
>>>> +/* Enum values for border_waveform connector properties (one per HW 
>>>> mode) */
>>>> +static const struct drm_prop_enum_list 
>>>> ssd16xx_border_waveform_enum[] = {
>>>> +    { SSD16XX_BORDER_LUT0, "lut0_black"    },
>>>> +    { SSD16XX_BORDER_LUT1, "lut1_white"    },
>>>> +    { SSD16XX_BORDER_LUT2, "lut2_black"    },
>>>> +    { SSD16XX_BORDER_LUT3, "lut3_gray"     },
>>>> +    { SSD16XX_BORDER_VSS,  "vss_black"     },
>>>> +    { SSD16XX_BORDER_VSH1, "vsh1_black"    },
>>>> +    { SSD16XX_BORDER_VSL,  "vsl_white"     },
>>>> +    { SSD16XX_BORDER_VSH2, "vsh2_black"    },
>>>> +    { SSD16XX_BORDER_VCOM, "vcom_preserve" },
>>>> +    { SSD16XX_BORDER_HIZ,  "hiz_float"     },
>>>> +};
>>>> +
>>>> +static int ssd16xx_connector_create_properties(struct ssd16xx_panel 
>>>> *panel)
>>>> +{
>>>> +    struct drm_device *drm = &panel->drm;
>>>> +    struct drm_connector *connector = &panel->connector;
>>>> +
>>>> +    panel->rotation_property =
>>>> +        drm_property_create_enum(drm, 0, "rotation",
>>>> +                     ssd16xx_rotation_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_rotation_enum));
>>>> +    if (!panel->rotation_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->rotation_property, panel->orientation);
>>>> +
>>>> +    panel->refresh_mode_property =
>>>> +        drm_property_create_enum(drm, 0, "refresh_mode",
>>>> +                     ssd16xx_refresh_mode_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_refresh_mode_enum));
>>>> +    if (!panel->refresh_mode_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->refresh_mode_property, panel->refresh_mode);
>>>> +
>>>> +    panel->border_waveform_init_property =
>>>> +        drm_property_create_enum(drm, 0, "border_waveform_init",
>>>> +                     ssd16xx_border_waveform_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_border_waveform_enum));
>>>> +    if (!panel->border_waveform_init_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->border_waveform_init_property,
>>>> +                   panel->border_waveform_init_idx);
>>>> +
>>>> +    panel->border_waveform_update_property =
>>>> +        drm_property_create_enum(drm, 0, "border_waveform_update",
>>>> +                     ssd16xx_border_waveform_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_border_waveform_enum));
>>>> +    if (!panel->border_waveform_update_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->border_waveform_update_property,
>>>> +                   panel->border_waveform_update_idx);
>>>> +
>>>> +    panel->border_refresh_on_every_update_property =
>>>> +        drm_property_create_bool(drm, 0, 
>>>> "border_refresh_on_every_update");
>>>> +    if (!panel->border_refresh_on_every_update_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->border_refresh_on_every_update_property,
>>>> +                   panel->border_refresh_on_every_update);
>>>> +
>>>> +    panel->clear_on_init_property =
>>>> +        drm_property_create_enum(drm, 0, "clear_on_init",
>>>> +                     ssd16xx_init_refresh_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_init_refresh_enum));
>>>> +    if (!panel->clear_on_init_property)
>>>> +        return -ENOMEM;
>>>> +    /* Property value 0=disabled, 1-3=mode; field is -1/0/1/2 → val 
>>>> = field+1 */
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->clear_on_init_property,
>>>> +                   panel->clear_on_init + 1);
>>>> +
>>>> +    panel->clear_on_close_property =
>>>> +        drm_property_create_enum(drm, 0, "clear_on_close",
>>>> +                     ssd16xx_init_refresh_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_init_refresh_enum));
>>>> +    if (!panel->clear_on_close_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->clear_on_close_property,
>>>> +                   panel->clear_on_close + 1);
>>>> +
>>>> +    panel->clear_on_disable_property =
>>>> +        drm_property_create_enum(drm, 0, "clear_on_disable",
>>>> +                     ssd16xx_init_refresh_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_init_refresh_enum));
>>>> +    if (!panel->clear_on_disable_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->clear_on_disable_property,
>>>> +                   panel->clear_on_disable + 1);
>>>> +
>>>> +    panel->refresh_mode_init_property =
>>>> +        drm_property_create_enum(drm, 0, "refresh_mode_init",
>>>> +                     ssd16xx_init_refresh_enum,
>>>> +                     ARRAY_SIZE(ssd16xx_init_refresh_enum));
>>>> +    if (!panel->refresh_mode_init_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->refresh_mode_init_property,
>>>> +                   panel->refresh_mode_init + 1);
>>>> +
>>>> +    /*
>>>> +     * color_mode: only expose 3-color option on panels that 
>>>> physically have
>>>> +     * a red plane; on BW-only panels the property still exists for
>>>> +     * consistency but userspace can only set "black-white".
>>>> +     */
>>>> +    panel->color_mode_property =
>>>> +        drm_property_create_enum(drm, 0, "color_mode",
>>>> +                     ssd16xx_color_mode_enum,
>>>> +                     panel->panel_cfg->red_supported
>>>> +                        ? ARRAY_SIZE(ssd16xx_color_mode_enum)
>>>> +                        : 1);
>>>> +    if (!panel->color_mode_property)
>>>> +        return -ENOMEM;
>>>> +    drm_object_attach_property(&connector->base,
>>>> +                   panel->color_mode_property,
>>>> +                   panel->color_mode);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int ssd16xx_connector_atomic_get_property(struct 
>>>> drm_connector *connector,
>>>> +                         const struct drm_connector_state *state,
>>>> +                         struct drm_property *property,
>>>> +                         uint64_t *val)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = to_ssd16xx_panel(connector->dev);
>>>> +
>>>> +    drm_dbg(&panel->drm, "get_property: %s\n", property->name);
>>>> +
>>>> +    if (property == panel->rotation_property) {
>>>> +        *val = panel->orientation;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->refresh_mode_property) {
>>>> +        *val = panel->refresh_mode;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->border_waveform_init_property) {
>>>> +        *val = panel->border_waveform_init_idx;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->border_waveform_update_property) {
>>>> +        *val = panel->border_waveform_update_idx;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->border_refresh_on_every_update_property) {
>>>> +        *val = panel->border_refresh_on_every_update;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->clear_on_init_property) {
>>>> +        *val = panel->clear_on_init + 1;  /* field -1/0/1/2 → val 
>>>> 0/1/2/3 */
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->clear_on_close_property) {
>>>> +        *val = panel->clear_on_close + 1;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->clear_on_disable_property) {
>>>> +        *val = panel->clear_on_disable + 1;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->refresh_mode_init_property) {
>>>> +        *val = panel->refresh_mode_init + 1;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->color_mode_property) {
>>>> +        *val = panel->color_mode;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    return -EINVAL;
>>>> +}
>>>> +
>>>> +static int ssd16xx_connector_atomic_set_property(struct 
>>>> drm_connector *connector,
>>>> +                         struct drm_connector_state *state,
>>>> +                         struct drm_property *property,
>>>> +                         uint64_t val)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = to_ssd16xx_panel(connector->dev);
>>>> +
>>>> +    drm_dbg(&panel->drm, "set_property: %s = %llu\n", property- 
>>>> >name, val);
>>>> +
>>>> +    if (property == panel->rotation_property) {
>>>> +        if (val != 0 && val != 90 && val != 180 && val != 270)
>>>> +            return -EINVAL;
>>>> +        panel->orientation = val;
>>>> +        /*
>>>> +         * Flag hardware re-init needed. crtc_atomic_flush will call
>>>> +         * ssd16xx_hw_init() with the new orientation and redraw.
>>>> +         */
>>>> +        panel->reinit_pending = true;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->refresh_mode_property) {
>>>> +        if (val > SSD16XX_REFRESH_FAST)
>>>> +            return -EINVAL;
>>>> +        /*
>>>> +         * Fast refresh (0xC7) omits LOAD_LUT on every update and 
>>>> relies
>>>> +         * on the LUT being pre-loaded upfront.  Arm the one-shot flag
>>>> +         * when switching into fast mode so the next 
>>>> plane_atomic_update
>>>> +         * loads the LUT before the first fast-refresh cycle.  
>>>> Clear it
>>>> +         * when switching away so a fresh pre-load happens if the user
>>>> +         * returns to fast mode later.
>>>> +         */
>>>> +        if (val == SSD16XX_REFRESH_FAST &&
>>>> +            panel->refresh_mode != SSD16XX_REFRESH_FULL)
>>>> +            panel->fast_lut_pending = true;
>>>> +        else
>>>> +            panel->fast_lut_pending = false;
>>>> +        panel->refresh_mode = val;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->border_waveform_init_property) {
>>>> +        if (val >= ARRAY_SIZE(ssd1683_border_waveform_table))
>>>> +            return -EINVAL;
>>>> +        panel->border_waveform_init_idx = val;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->border_waveform_update_property) {
>>>> +        const u8 *bw_tbl = panel->controller_cfg- 
>>>> >border_waveform_table;
>>>> +        bool changed = (int)val != panel->border_waveform_update_idx;
>>>> +
>>>> +        if (val >= ARRAY_SIZE(ssd1683_border_waveform_table))
>>>> +            return -EINVAL;
>>>> +        drm_dbg(&panel->drm,
>>>> +            "set_property: border_waveform_update old=%d new=%llu 
>>>> hw=0x%02x -> 0x%02x %s\n",
>>>> +            panel->border_waveform_update_idx, val,
>>>> +            bw_tbl[panel->border_waveform_update_idx],
>>>> +            bw_tbl[val],
>>>> +            changed ? "(arming pending)" : "(no change)");
>>>> +        /* Arm one-shot flag so the new border value is sent on the 
>>>> very
>>>> +         * next display update, even if 
>>>> border_refresh_on_every_update is
>>>> +         * not set.  Cleared in fb_dirty after the command is sent.
>>>> +         */
>>>> +        if ((int)val != panel->border_waveform_update_idx)
>>>> +            panel->border_waveform_pending = true;
>>>> +        panel->border_waveform_update_idx = val;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->border_refresh_on_every_update_property) {
>>>> +        panel->border_refresh_on_every_update = !!val;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->clear_on_init_property) {
>>>> +        if (val > 3)
>>>> +            return -EINVAL;
>>>> +        panel->clear_on_init = (int)val - 1;  /* val 0/1/2/3 → 
>>>> field -1/0/1/2 */
>>>> +        panel->first_clear_done = false;  /* allow re-fire on next 
>>>> enable */
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->clear_on_close_property) {
>>>> +        if (val > 3)
>>>> +            return -EINVAL;
>>>> +        panel->clear_on_close = (int)val - 1;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->clear_on_disable_property) {
>>>> +        if (val > 3)
>>>> +            return -EINVAL;
>>>> +        panel->clear_on_disable = (int)val - 1;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->refresh_mode_init_property) {
>>>> +        if (val > 3)
>>>> +            return -EINVAL;
>>>> +        panel->refresh_mode_init = (int)val - 1;
>>>> +        return 0;
>>>> +    }
>>>> +    if (property == panel->color_mode_property) {
>>>> +        if (val > SSD16XX_COLOR_MODE_3COLOR)
>>>> +            return -EINVAL;
>>>> +        if (val == SSD16XX_COLOR_MODE_3COLOR && !panel->panel_cfg- 
>>>> >red_supported) {
>>>> +            drm_dbg(&panel->drm,
>>>> +                "set_property: 3-color mode not supported by this 
>>>> panel\n");
>>>> +            return -EINVAL;
>>>> +        }
>>>> +        panel->color_mode = val;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    return -EINVAL;
>>>> +}
>>>> +
>>>> +static const struct drm_connector_funcs ssd16xx_connector_funcs = {
>>>> +    .reset = drm_atomic_helper_connector_reset,
>>>> +    .fill_modes = drm_helper_probe_single_connector_modes,
>>>> +    .destroy = drm_connector_cleanup,
>>>> +    .atomic_duplicate_state = 
>>>> drm_atomic_helper_connector_duplicate_state,
>>>> +    .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>>> +    .atomic_get_property = ssd16xx_connector_atomic_get_property,
>>>> +    .atomic_set_property = ssd16xx_connector_atomic_set_property,
>>>> +};
>>>> +
>>>> +static const u32 ssd16xx_formats[] = {
>>>> +    DRM_FORMAT_XRGB8888,  /* 32-bit RGB with padding (preferred) */
>>>> +    DRM_FORMAT_RGB888,    /* 24-bit packed RGB */
>>>> +    DRM_FORMAT_RGB565,    /* 16-bit RGB (5:6:5) */
>>>> +    DRM_FORMAT_R8,        /* 8-bit grayscale */
>>>> +    DRM_FORMAT_NV12,      /* YUV 4:2:0 planar */
>>>> +    DRM_FORMAT_NV16,      /* YUV 4:2:2 planar */
>>>> +    DRM_FORMAT_YUYV,      /* Packed YUV 4:2:2 (Y0 U0 Y1 V0) */
>>>> +    DRM_FORMAT_UYVY,      /* Packed YUV 4:2:2 (U0 Y0 V0 Y1) */
>>>> +    DRM_FORMAT_R1,        /* 1-bit monochrome (native, 8 pixels/ 
>>>> byte) */
>>>> +};
>>>
>>> Why do you have all these formats?
>>>
>>> Only export the modes your panel can do natively; plus maybe XRGB8888 
>>> for compatibility.
>>>
>>
>> I wanted to keep YUV formats too since some apps such as camera apps 
>> (in case we want to click a picture and display over on the e-paper 
>> badge directly) support only YUV formats but yeah if it's too much I 
>> can remove them from driver and instead have the conversion in the app 
>> itself.
>>
>>>> +
>>>> +DEFINE_DRM_GEM_FOPS(ssd16xx_fops);
>>>> +
>>>> +/*
>>>> + * ssd16xx_drm_master_set - arm init refresh when a new master 
>>>> takes control.
>>>> + */
>>>> +static void ssd16xx_drm_master_set(struct drm_device *drm,
>>>> +                   struct drm_file *file, bool from_open)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = to_ssd16xx_panel(drm);
>>>> +
>>>> +    panel->display_cleared_on_deinit = false;
>>>> +    panel->first_clear_done = false;
>>>> +
>>>> +    if (panel->refresh_mode_init >= 0)
>>>> +        panel->init_refresh_pending = true;
>>>> +}
>>>> +
>>>> +/*
>>>> + * ssd16xx_drm_master_drop - clear display and disarm init refresh 
>>>> when the
>>>> + * master client exits.
>>>> + */
>>>> +static void ssd16xx_drm_master_drop(struct drm_device *drm,
>>>> +                    struct drm_file *file)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = to_ssd16xx_panel(drm);
>>>> +    int ret;
>>>> +
>>>> +    panel->init_refresh_pending = false;
>>>> +    panel->first_clear_done = false;
>>>> +
>>>> +    if (panel->clear_on_close < 0 || panel->display_cleared_on_deinit)
>>>> +        return;
>>>> +
>>>> +    ret = ssd16xx_clear_display_on_exit(panel);
>>>> +    if (ret)
>>>> +        drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
>>>> +
>>>> +    panel->display_cleared_on_deinit = true;
>>>> +}
>>>
>>> No, don't overload these. Just remove all this. Clearing should be 
>>> left to the DRM client.
>>>
>>
>> Yes, the choice to clear or not to clear is left to drm client 
>> depending on drm property setting done by drm client, the driver 
>> clears the display. It would be difficult to update all different apps 
>> to pass a blank white buffer to clear the screen and what if the app 
>> gets closed abruptly (as master drop callback will get triggered), 
>> then in that case the current driver logic ensures that screen gets 
>> cleared. In normal LCD displays if app gets closed abruptly, the 
>> display would have gone-off automatically as signals would stop 
>> getting transmitted but in e-paper panel the last display context 
>> would remain and I think it is driver responsibility to clear that if 
>> that was the policy communicated by application to the driver.
>>
>>>> +
>>>> +static struct drm_driver ssd16xx_drm_driver = {
>>>> +    .driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>>> +    .fops = &ssd16xx_fops,
>>>> +    .name = "ssd16xx",
>>>> +    .desc = "DRM driver for SSD16xx e-paper controller family",
>>>> +    .major = 1,
>>>> +    .minor = 0,
>>>> +    .master_set  = ssd16xx_drm_master_set,
>>>> +    .master_drop = ssd16xx_drm_master_drop,
>>>> +    DRM_GEM_DMA_DRIVER_OPS,
>>>> +    DRM_FBDEV_DMA_DRIVER_OPS,
>>>> +};
>>>> +
>>>> +static const struct drm_mode_config_funcs ssd16xx_mode_config_funcs 
>>>> = {
>>>> +    .fb_create = drm_gem_fb_create_with_dirty,
>>>> +    .atomic_check = drm_atomic_helper_check,
>>>> +    .atomic_commit = drm_atomic_helper_commit,
>>>> +};
>>>> +
>>>> +/*
>>>> + * Use the RPM commit-tail variant so that 
>>>> drm_atomic_helper_commit_modeset_enables
>>>> + * (which calls crtc_atomic_enable) runs before 
>>>> drm_atomic_helper_commit_planes.
>>>> + * Without this, the standard commit_tail calls commit_planes before
>>>> + * modeset_enables, so plane_atomic_update would see initialized == 
>>>> false on the
>>>> + * first commit and silently drop the frame.
>>>> + */
>>>> +static const struct drm_mode_config_helper_funcs 
>>>> ssd16xx_mode_config_helper_funcs = {
>>>> +    .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>>>> +};
>>>> +
>>>> +static int ssd16xx_alloc_tx_bufs(struct ssd16xx_panel *panel)
>>>> +{
>>>> +    struct device *dev = &panel->spi->dev;
>>>> +    size_t frame_size = (panel->controller_cfg->max_width *
>>>> +                 panel->controller_cfg->max_height) / 8;
>>>> +
>>>> +    panel->tx_buf = devm_kmalloc(dev, frame_size, GFP_KERNEL);
>>>
>>> drmm_kmalloc() here and for the other buffers.
>>>
>>
>> Understood, thanks for pointing will fix it in V2.
>>
>> Best Regards
>> Devarsh
>>
>>> Best regards
>>> Thomas
>>
>>>
>>>> +    if (!panel->tx_buf)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    if (panel->panel_cfg->red_supported) {
>>>> +        panel->tx_red_buf = devm_kmalloc(dev, frame_size, GFP_KERNEL);
>>>> +        if (!panel->tx_red_buf)
>>>> +            return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    if (!panel->dc) {
>>>> +        panel->tx_buf9 = devm_kmalloc_array(dev, frame_size,
>>>> +                            sizeof(u16), GFP_KERNEL);
>>>> +        if (!panel->tx_buf9)
>>>> +            return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int ssd16xx_probe(struct spi_device *spi)
>>>> +{
>>>> +    struct device *dev = &spi->dev;
>>>> +    struct ssd16xx_panel *panel;
>>>> +    struct drm_device *drm;
>>>> +    const struct spi_device_id *spi_id;
>>>> +    struct drm_display_mode *mode;
>>>> +    const void *match;
>>>> +    enum ssd16xx_model model;
>>>> +    u32 dt_rotation = 0;
>>>> +    int ret;
>>>> +
>>>> +    match = device_get_match_data(dev);
>>>> +    if (match) {
>>>> +        model = (enum ssd16xx_model)(uintptr_t)match;
>>>> +    } else {
>>>> +        spi_id = spi_get_device_id(spi);
>>>> +        model = (enum ssd16xx_model)spi_id->driver_data;
>>>> +    }
>>>> +
>>>> +    if (!dev->coherent_dma_mask) {
>>>> +        ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>>> +        if (ret) {
>>>> +            dev_warn(dev, "Failed to set DMA mask: %d\n", ret);
>>>> +            return ret;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    panel = devm_drm_dev_alloc(dev, &ssd16xx_drm_driver,
>>>> +                   struct ssd16xx_panel, drm);
>>>> +    if (IS_ERR(panel))
>>>> +        return PTR_ERR(panel);
>>>> +
>>>> +    drm = &panel->drm;
>>>> +    panel->spi = spi;
>>>> +    panel->model = model;
>>>> +    spi_set_drvdata(spi, panel);
>>>> +
>>>> +    spi->mode = SPI_MODE_0;
>>>> +    spi->bits_per_word = SSD16XX_SPI_BITS_PER_WORD;
>>>> +
>>>> +    if (!spi->max_speed_hz) {
>>>> +        drm_warn(drm, "spi-max-frequency not specified, using %u 
>>>> Hz\n",
>>>> +             SSD16XX_SPI_SPEED_DEFAULT);
>>>> +        spi->max_speed_hz = SSD16XX_SPI_SPEED_DEFAULT;
>>>> +    }
>>>> +
>>>> +    ret = spi_setup(spi);
>>>> +    if (ret < 0) {
>>>> +        drm_err(drm, "SPI setup failed: %d\n", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    switch (model) {
>>>> +    case GDEY042T81:
>>>> +        panel->controller = SSD1683;
>>>> +        break;
>>>> +    default:
>>>> +        drm_err(drm, "Unknown panel model: %d\n", model);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (panel->controller >= ARRAY_SIZE(ssd16xx_controller_configs) ||
>>>> +        !ssd16xx_controller_configs[panel->controller].max_width)
>>>> +        return -EINVAL;
>>>> +    panel->controller_cfg = &ssd16xx_controller_configs[panel- 
>>>> >controller];
>>>> +
>>>> +    if (model >= ARRAY_SIZE(ssd16xx_panel_configs))
>>>> +        return -EINVAL;
>>>> +    panel->panel_cfg = &ssd16xx_panel_configs[model];
>>>> +
>>>> +    mode = devm_kmemdup(dev, panel->panel_cfg->mode,
>>>> +                sizeof(*panel->panel_cfg->mode), GFP_KERNEL);
>>>> +    if (!mode)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    panel->refresh_mode = panel->panel_cfg->default_refresh_mode;
>>>> +    /* Default color mode: 3-color for panels with red plane, BW 
>>>> otherwise */
>>>> +    panel->color_mode = panel->panel_cfg->red_supported
>>>> +                ? SSD16XX_COLOR_MODE_3COLOR
>>>> +                : SSD16XX_COLOR_MODE_BW;
>>>> +    panel->border_waveform_init_idx   = panel->panel_cfg- 
>>>> >default_border_waveform_init;
>>>> +    panel->border_waveform_update_idx = panel->panel_cfg- 
>>>> >default_border_waveform_update;
>>>> +    panel->border_refresh_on_every_update =
>>>> +        panel->panel_cfg->default_border_refresh_on_every_update;
>>>> +    panel->clear_on_init    = panel->panel_cfg->default_clear_on_init;
>>>> +    panel->clear_on_close   = panel->panel_cfg- 
>>>> >default_clear_on_close;
>>>> +    panel->clear_on_disable = panel->panel_cfg- 
>>>> >default_clear_on_disable;
>>>> +    panel->refresh_mode_init = panel->panel_cfg- 
>>>> >default_refresh_mode_init;
>>>> +
>>>> +    /* Module parameter overrides for border/display control */
>>>> +    if (border_waveform_init_lut >= 0 &&
>>>> +        border_waveform_init_lut < 
>>>> (int)ARRAY_SIZE(ssd1683_border_waveform_table))
>>>> +        panel->border_waveform_init_idx = border_waveform_init_lut;
>>>> +    if (border_waveform_lut >= 0 &&
>>>> +        border_waveform_lut < 
>>>> (int)ARRAY_SIZE(ssd1683_border_waveform_table))
>>>> +        panel->border_waveform_update_idx = border_waveform_lut;
>>>> +    if (border_refresh_on_every_update)
>>>> +        panel->border_refresh_on_every_update = true;
>>>> +    if (clear_on_init >= 0 && clear_on_init <= 2)
>>>> +        panel->clear_on_init = clear_on_init;
>>>> +    if (clear_on_close >= 0 && clear_on_close <= 2)
>>>> +        panel->clear_on_close = clear_on_close;
>>>> +    if (clear_on_disable >= 0 && clear_on_disable <= 2)
>>>> +        panel->clear_on_disable = clear_on_disable;
>>>> +    if (refresh_mode_init >= 0 && refresh_mode_init <= 2)
>>>> +        panel->refresh_mode_init = refresh_mode_init;
>>>> +
>>>> +    /* Module parameter overrides panel default refresh mode when 
>>>> set */
>>>> +    if (refresh_mode >= 0) {
>>>> +        if (refresh_mode > SSD16XX_REFRESH_FAST)
>>>> +            drm_warn(drm, "Invalid refresh_mode module param %d, 
>>>> ignored\n",
>>>> +                 refresh_mode);
>>>> +        else
>>>> +            panel->refresh_mode = refresh_mode;
>>>> +    }
>>>> +
>>>> +    /* Module parameter overrides panel default color mode when set */
>>>> +    if (color_mode >= 0) {
>>>> +        if (color_mode > SSD16XX_COLOR_MODE_3COLOR)
>>>> +            drm_warn(drm, "Invalid color_mode module param %d, 
>>>> ignored\n",
>>>> +                 color_mode);
>>>> +        else if (color_mode == SSD16XX_COLOR_MODE_3COLOR &&
>>>> +             !panel->panel_cfg->red_supported)
>>>> +            drm_warn(drm,
>>>> +                 "color_mode=3-color requested but panel has no red 
>>>> plane, ignored\n");
>>>> +        else
>>>> +            panel->color_mode = color_mode;
>>>> +    }
>>>> +
>>>> +    /* Parse "rotation" DT property; swap mode dimensions for 
>>>> portrait. */
>>>> +    device_property_read_u32(dev, "rotation", &dt_rotation);
>>>> +    if (dt_rotation != 0 && dt_rotation != 90 && dt_rotation != 180 
>>>> && dt_rotation != 270) {
>>>> +        drm_warn(drm, "Invalid DT rotation %u, defaulting to 0°\n", 
>>>> dt_rotation);
>>>> +        dt_rotation = 0;
>>>> +    }
>>>> +    panel->orientation = dt_rotation;
>>>> +
>>>> +    /* Module parameter overrides DT rotation when set */
>>>> +    if (rotation >= 0) {
>>>> +        if (rotation != 0 && rotation != 90 && rotation != 180 && 
>>>> rotation != 270)
>>>> +            drm_warn(drm, "Invalid rotation module param %d, 
>>>> ignored\n",
>>>> +                 rotation);
>>>> +        else
>>>> +            panel->orientation = rotation;
>>>> +    }
>>>> +
>>>> +    drm_dbg(drm, "Using %s orientation (%u°, %ux%u logical)\n",
>>>> +        (panel->orientation == 90 || panel->orientation == 270) ? 
>>>> "portrait" : "landscape",
>>>> +        panel->orientation, mode->hdisplay, mode->vdisplay);
>>>> +
>>>> +    /* Swap mode dimensions for portrait so clients see logical 
>>>> size. */
>>>> +    if (panel->orientation == 90 || panel->orientation == 270) {
>>>> +        swap(mode->hdisplay, mode->vdisplay);
>>>> +        swap(mode->hsync_start, mode->vsync_start);
>>>> +        swap(mode->hsync_end, mode->vsync_end);
>>>> +        swap(mode->htotal, mode->vtotal);
>>>> +        swap(mode->width_mm, mode->height_mm);
>>>> +        drm_dbg(drm, "Mode dimensions swapped for portrait: %ux%u\n",
>>>> +            mode->hdisplay, mode->vdisplay);
>>>> +    } else {
>>>> +        drm_dbg(drm, "Mode dimensions unchanged: %ux%u\n",
>>>> +            mode->hdisplay, mode->vdisplay);
>>>> +    }
>>>> +    panel->mode = mode;
>>>> +    panel->width = mode->hdisplay;
>>>> +    panel->height = mode->vdisplay;
>>>> +
>>>> +    /* Acquire GPIOs. */
>>>> +    panel->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>>>> +    if (IS_ERR(panel->reset))
>>>> +        return dev_err_probe(dev, PTR_ERR(panel->reset), "Failed to 
>>>> get RESET GPIO\n");
>>>> +
>>>> +    panel->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
>>>> +    if (IS_ERR(panel->busy))
>>>> +        return dev_err_probe(dev, PTR_ERR(panel->busy), "Failed to 
>>>> get BUSY GPIO\n");
>>>> +
>>>> +    panel->dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
>>>> +    if (IS_ERR(panel->dc))
>>>> +        return dev_err_probe(dev, PTR_ERR(panel->dc), "Failed to 
>>>> get DC GPIO\n");
>>>> +    if (!panel->dc) {
>>>> +        if (!spi_is_bpw_supported(spi, 9))
>>>> +            return dev_err_probe(dev, -EINVAL,
>>>> +                         "3-wire SPI mode requires 9-bit word 
>>>> support\n");
>>>> +        drm_dbg(drm, "dc-gpios not specified, using 3-wire (9-bit) 
>>>> SPI mode\n");
>>>> +    }
>>>> +
>>>> +    ret = ssd16xx_alloc_tx_bufs(panel);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ssd16xx_hw_reset(panel);
>>>> +
>>>> +    ret = drmm_mode_config_init(drm);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    drm->mode_config.funcs = &ssd16xx_mode_config_funcs;
>>>> +    drm->mode_config.helper_private = 
>>>> &ssd16xx_mode_config_helper_funcs;
>>>> +    drm->mode_config.min_width = min(panel->width, panel->height);
>>>> +    drm->mode_config.max_width = max(panel->width, panel->height);
>>>> +    drm->mode_config.min_height = min(panel->width, panel->height);
>>>> +    drm->mode_config.max_height = max(panel->width, panel->height);
>>>> +
>>>> +    drm_connector_helper_add(&panel->connector, 
>>>> &ssd16xx_connector_helper_funcs);
>>>> +    ret = drm_connector_init(drm, &panel->connector, 
>>>> &ssd16xx_connector_funcs,
>>>> +                 DRM_MODE_CONNECTOR_SPI);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = drm_universal_plane_init(drm, &panel->primary_plane, 0,
>>>> +                       &ssd16xx_plane_funcs,
>>>> +                       ssd16xx_formats, ARRAY_SIZE(ssd16xx_formats),
>>>> +                       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +    drm_plane_helper_add(&panel->primary_plane, 
>>>> &ssd16xx_plane_helper_funcs);
>>>> +    drm_plane_enable_fb_damage_clips(&panel->primary_plane);
>>>> +
>>>> +    ret = drm_crtc_init_with_planes(drm, &panel->crtc, &panel- 
>>>> >primary_plane,
>>>> +                    NULL, &ssd16xx_crtc_funcs, NULL);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +    drm_crtc_helper_add(&panel->crtc, &ssd16xx_crtc_helper_funcs);
>>>> +
>>>> +    ret = drm_simple_encoder_init(drm, &panel->encoder, 
>>>> DRM_MODE_ENCODER_NONE);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +    panel->encoder.possible_crtcs = drm_crtc_mask(&panel->crtc);
>>>> +
>>>> +    ret = drm_connector_attach_encoder(&panel->connector, &panel- 
>>>> >encoder);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    ret = ssd16xx_connector_create_properties(panel);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    drm_mode_config_reset(drm);
>>>> +
>>>> +    ret = drm_dev_register(drm, 0);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    drm_dbg(drm, "SSD16xx e-paper display initialized (%dx%d, %d° 
>>>> rotation)\n",
>>>> +        panel->width, panel->height, panel->orientation);
>>>> +
>>>> +    drm_client_setup(drm, NULL);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void ssd16xx_remove(struct spi_device *spi)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = spi_get_drvdata(spi);
>>>> +
>>>> +    drm_dev_unplug(&panel->drm);
>>>> +    drm_atomic_helper_shutdown(&panel->drm);
>>>> +}
>>>> +
>>>> +static void ssd16xx_shutdown(struct spi_device *spi)
>>>> +{
>>>> +    struct ssd16xx_panel *panel = spi_get_drvdata(spi);
>>>> +
>>>> +    drm_atomic_helper_shutdown(&panel->drm);
>>>> +}
>>>> +
>>>> +static const struct of_device_id ssd16xx_of_match[] = {
>>>> +    { .compatible = "gooddisplay,gdey042t81", .data = (void 
>>>> *)GDEY042T81 },
>>>> +    { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, ssd16xx_of_match);
>>>> +
>>>> +static const struct spi_device_id ssd16xx_id[] = {
>>>> +    { "gdey042t81", GDEY042T81 },
>>>> +    { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(spi, ssd16xx_id);
>>>> +
>>>> +static struct spi_driver ssd16xx_spi_driver = {
>>>> +    .driver = {
>>>> +        .name = "ssd16xx",
>>>> +        .of_match_table = ssd16xx_of_match,
>>>> +    },
>>>> +    .probe = ssd16xx_probe,
>>>> +    .remove = ssd16xx_remove,
>>>> +    .shutdown = ssd16xx_shutdown,
>>>> +    .id_table = ssd16xx_id,
>>>> +};
>>>> +module_spi_driver(ssd16xx_spi_driver);
>>>> +
>>>> +MODULE_AUTHOR("Devarsh Thakkar <devarsht@ti.com>");
>>>> +MODULE_DESCRIPTION("DRM driver for Solomon SSD16xx e-paper display 
>>>> controller family");
>>>> +MODULE_LICENSE("GPL");
>>>
>>
> 


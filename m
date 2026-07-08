Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356CAC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6945910E575;
	Wed,  8 Jul 2026 06:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c8AwILXt";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F5RyAcpa";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D469210E575
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:36:16 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6685BlOq627148; Wed, 8 Jul 2026 01:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XgGymhqQ7TMMPY4orG81N97yV9kUvZLvE774RS3s6
 1Q=; b=c8AwILXt4zWJQI8a75bIS/2PvWqsprpLBh+nO5rYeNWZeOUGiUp3SX31w
 PpROPgrehO//vlIPo1P7g9ttBunzlTJn7IJADi+dFVXK33AAhDitNK2xs/pdkCdK
 erMRb0AKgxfl+2NkgF4T+b3BXHRGFrV259XMU0kKv6ZMfhjaYjc3QC14fL4mSRaM
 Ujx85YhNHf3nZzvdeB0edp4x0NVWH8RRGd+KLcBZ2pc+xz/7Xv3zcn8oiJ5io3Pe
 1KxzAc6QR2KKHZdKiFwSvdd981d2VYIPDgmbf+CepNcMLg62yxtxIPZWuTkCJCv/
 2cRiXQJP2pR7hbn5VxkFbQgcq1iFA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f94m7d2hh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 01:36:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdBEDi7VZd5ZktJGP3jJcXGvjKN6MYM2E1otRBHitxdGwsivL+7aAURX/flA1D+2ho2Pr4laTgbliF1Ky9J+SR/E2gJSXIFi8XyCytDSqGUwDWL+GpvF6DfCI0pfonQcHZRfV6a46b9t9ZUMa3pwU1D8UHo1b7YOV8WK/ZBvymgnXB3U7F++qFej96D7l81Kei3yR9Pxl0Vc4GclDjVHpcrYIvAGolN8pgzvLPIMndfjZOLLDPmzGg2PcxYqS0t66YCDSIK7ZeCnZs213eKnm1DqMRp1GTLuf3HaEb1xHQ0Lf0c6K5+pHvbQwEjLlS1Jt8UUxFYOH6IQEi/gTpcr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgGymhqQ7TMMPY4orG81N97yV9kUvZLvE774RS3s61Q=;
 b=AFElopExZJ5yint9tqBDnhJXhiFtqrmBAS1cM6qXSG1UL7cnif7Nzs5PzFfcwQqFbx5EoT6UxLs/EQFhGJIiFhxUymK1N/4SMM+kh6c3uB0PEhZBCNcYm2XrpXwbh0AZroYHo5+dU3X9XOppOzCAAshvUIXCDbPmtPDfL7HUdfgwqwh/PD1YHq7FcQf9Wv9zwn8piII0Yt6XZlV7VOnUhJVDrdBjRFHDvUH6fCYeuapcb3qqlvyS7kc6tuqAFIwGmc9S9wFHJOpyR2IexMAv3PRLrO/Oi2lIagelfo7Ffm+fjFgpGYqlmoU0bJCFCo+b0bEGtcnRN2fsKo7XEJfIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgGymhqQ7TMMPY4orG81N97yV9kUvZLvE774RS3s61Q=;
 b=F5RyAcpauQHRKfUsgH2MqBDN1B+cTb3Vd4h5cqhhmUw2n+crerMVaDkSHv38ZIOWiLKMJODA74BiM69RF5tfXCTbOKa82R+CFW/knSJYnkF6KY8klMRFRCUp/ijfXKV9KqmOWhnt74tOuTRjk1G8sxxdCMZQeaKvKM/BzUfnKOM=
Received: from PH8PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:2d0::20)
 by LV3PR10MB7937.namprd10.prod.outlook.com (2603:10b6:408:21c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 06:35:57 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::9e) by PH8PR02CA0017.outlook.office365.com
 (2603:10b6:510:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 06:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 06:35:56 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 01:35:53 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 01:35:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 8 Jul 2026 01:35:53 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com
 [10.24.51.87])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6686ZlYg2124653;
 Wed, 8 Jul 2026 01:35:48 -0500
Message-ID: <4cdc9944-9486-461b-b637-702921a4367e@ti.com>
Date: Wed, 8 Jul 2026 12:05:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] drm/tidss: Add support for DPIENABLE bit
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-10-7fefdc5d1adf@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260529-beagley-ai-display-v3-10-7fefdc5d1adf@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|LV3PR10MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d16a0ba-5934-4fc4-03d5-08dedcbb2a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|1800799024|82310400026|23010399003|376014|921020|18002099003|22082099003|3023799007|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Di++5lGbNV2MVqRyjHS6Ukjq/F5FgQgwF9oHBB2Cg6d8XCG2gFTl09BpaL/NyvkEQqmDSxJTD8LeWgsnOIwGIXeG8KhRza9D/kwMybRYHrLl6UNmpzYx2SdtelC4Uwxm7TFf1DP5mr75qMfHrLvScBfjWACiil9PTRIRPM10H3OgZAwhBDeAhnwwjLW+GKE5CFl1Sr15CnEhGF21qNy/94PFeFtd6I9wVHv5WIHPpYekIoD69257l5y2ffWImluC0HW7ZW8araU5HqnlrSwhKmL7Bb4lYZ7usFUNKuVAQV6J+zBuprTPW/JEm76fR6eZLa68hRIlSUcQXv3MWWVad5XGjir+kx0xaL6FePldrSf04bkfxGdemsWmw2CN6LecZf2waekjOZSTrvDMzOV9yxymyjNbdaJGc4m3mA4N62ei6QkK8qTMbSzqoFGM8MXgHA02WI/C4JJyEj08786zM6tBEYAMzRRYdR2/wLe/PJhEmaRSfpQetaUSr37QutibXMIU5m6BScPdW2TIBIJUd7UEz3fiVeCCXmT2d6wPqR2OJnsQtu45EtuMzOl9gqGLhffEUq3fdfygcIquDi3kbwpiEtaS6sUFM+atYR551tq3PsrgVbXYX7BmfWsy7yKser5vk8I9B7pxXnZYEaBgGI0bvH4QKUxSA4KwrKwz+qnkzX2Di/38vVqPWL8ZJdOTYcJ+ZzEtU2KD2Qc0JFy34CextR+HslokOmQr0eCapeG0jVIj6F2bNHPmc1Me6hSs
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(921020)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ulV+OBRobZNnNHs5WeiP3dVaPmxHJPMhytUJA5tG/Y4RYoEY5YjcQ7UFLbPJytUfdMHbmgp9fYwC43/uhzjS+44+VlHWll677GxC0PdAiLIPAaVdum7Qq4SKKt31dXuXDlmvrNGn4z7Qs/hhv/AjcNTMKtopvf7PagVEhpGOd29Ini/3mdHbUiuEYUh4mI+X/k3RDgXzJm7rwQj4jrrmxvX5GJa9deCDHbyF4gBwqG2AS2xgC91VGgax8xvyxWdxfG/seuw47up/jfvwS/d2+VaKwfxzu8Yco3dLFXSPwI2kZ0gSxYQHCHRtQQ6aef/ySBraZbnw3h3SLiP4rjLZIBsM3aPMOOg3hGxbU+GlgYF+KoT1HNJvTf5nEijGlnDCrwD3b/30y7SJwONjszaoE/J6Z4e8ceEnfjD7nSV0uL2937DmR7i/RpZjsEQzvuXN
X-Exchange-RoutingPolicyChecked: nCXhERC1tepJv1Cnvmm1KSPKIHSDQtS/MAuIGUV0N79+2aIxi0vVBnSW0r+Tb5AgDYNk4xavmlzUgV5BnDWFno+MOufBRa9DWzLi8Aw9/2Y5EAGd6YmpVN7rXm3p5TRXPKnUnd1s/5ZvK6hFR3kKl7BkZxPEmEyAVyW1guMKo9hi0sNJm5peOpwxz60ABFIiZ25H0SQyI9n49G2iHL9P87TVSLyLdnTSrDMjS0mdhy50mV8RXHk9KCWvKVuK89foKCGuXHhbD4WZx8ExjyHSW9LiQvnkEp4m7VIB01DszMlQ+1e5WxEkpxbsChfKu7ZNiloOxuMrVNHHmrd/F8hXCA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:35:56.1730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d16a0ba-5934-4fc4-03d5-08dedcbb2a6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7937
X-Authority-Analysis: v=2.4 cv=f594wuyM c=1 sm=1 tr=0 ts=6a4defd2 cx=c_pps
 a=+v7uXpzEFv5PX1YPhMLqHw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=vqHznLqP4jQ7SChzMA0A:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: fq349C4d0Px9rIiNujwSRlQkWCOlmkxm
X-Proofpoint-ORIG-GUID: fq349C4d0Px9rIiNujwSRlQkWCOlmkxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2MSBTYWx0ZWRfX7rmsAatiE4Z/
 gHcEN4DwSf9MYx6xT9wSNZIWSAdvHmdHTAsfQCAlaNWte59atAokDgtRcLPnkIJrArZy1Njsxa2
 SJhqDq8Y4fca/aSl880J6sTfuGxCMAZEQANm2+2ZS35M/yeZo00o7TJKafefOJmIb0rdC2jZnoF
 WAl1BE3vdFQmKriVVEHStYNynI3yZV/bPAkDing+y2roL6lUPWZSkfWsioWyPv4tVmR6YT6xacs
 1crJ5Plfj+SK9w2KQ7byPGN1fETw8F27LwzNaNTc+o4pWGnnQnooeXYepOAq7Hm6sWTFYUrO73t
 Ch8qyEJIWnvGgL7DjryXeh9QvlLupZfWXU+AcdNOLefgzDOyE81vj9pq/drIt/D2NJf1T0iyZlg
 qVEULO6vVubPD2ewc5Wc5V4zl/DLXBjloPJG7nKd5fwjlXXaktBkKy54lpEsahiIcRCd+Fllrl5
 yFTxs0RDnvALBUYeY3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2MSBTYWx0ZWRfX8FEONdkDrJU6
 uk1hU8Mi8+dyh0e6DbzCS+zDYCpDg5EgtaxlCQgw+UpdFhZla1uN0fV9TLkN5yJUam0R0yveicu
 S8Su5QnYC5Fl1YK7EE9y8xgVzRECR8c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080061
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

On 29/05/26 14:15, Tomi Valkeinen wrote:
> Many (or even all?) K3 SoCs have DSS VP_CONTROL.DPIENABLE bit described
> in their documentation. This bit controls whether the DPI block is
> enabled, and is set to 1 by default (i.e. DPI is enabled at HW reset).
> 
> However, in almost all SoCs the setting does not actually do anything,
> and at the moment the bit is not managed by the driver.
> 
> The exception is AM62L, which does have DPIENABLE connected, and
> disabling the DPI block when it is not in use provides power savings.
> 
> Let's add a new feature flag for this, 'has_vp_control_dpienable', and
> implement the support.  Disable DPIENABLE for all videoports at resume
> time, so that it is 0 by default. Specifically enable and disable it in
> dispc_vp_enable() and dispc_vp_disable() for DPI output.
> 

I think in commit msg you probably mean to capture 
dispc_vp_prepare/dispc_vp_unprepare instead of dispc_vp_enable() and 
dispc_vp_disable() for enabling/disabling DPIENABLE bits. With that 
correction in commit msg,

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh


> Tested-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c      | 23 +++++++++++++++++++++--
>   drivers/gpu/drm/tidss/tidss_dispc.h      |  2 ++
>   drivers/gpu/drm/tidss/tidss_dispc_regs.h |  1 +
>   3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 08342a9a5e8c..1b8d52f10673 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -442,6 +442,8 @@ const struct dispc_features dispc_am62l_feats = {
>   	},
>   
>   	.vid_order = {0},
> +
> +	.has_vp_control_dpienable = true,
>   };
>   
>   static const u16 *dispc_common_regmap;
> @@ -1210,6 +1212,11 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>   			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
>   			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
>   	}
> +
> +	if (dispc->feat->has_vp_control_dpienable &&
> +	    dispc->vp_data[hw_videoport].dpi_output)
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
> +			       DISPC_VP_CONTROL_DPIENABLE_MASK);
>   }
>   
>   void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
> @@ -1226,6 +1233,11 @@ void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>   
>   void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
>   {
> +	if (dispc->feat->has_vp_control_dpienable &&
> +	    dispc->vp_data[hw_videoport].dpi_output)
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
> +			       DISPC_VP_CONTROL_DPIENABLE_MASK);
> +
>   	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
>   		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
>   
> @@ -2445,10 +2457,17 @@ static void dispc_vp_init(struct dispc_device *dispc)
>   
>   	dev_dbg(dispc->dev, "%s()\n", __func__);
>   
> -	/* Enable the gamma Shadow bit-field for all VPs*/
> -	for (i = 0; i < dispc->feat->num_vps; i++)
> +	for (i = 0; i < dispc->feat->num_vps; i++) {
> +		/* Enable the gamma Shadow bit-field for all VPs*/
>   		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1,
>   			       DISPC_VP_CONFIG_GAMMAENABLE_MASK);
> +
> +		if (dispc->feat->has_vp_control_dpienable) {
> +			/* Disable DPIENABLE for all VPs */
> +			VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONTROL, 0,
> +				       DISPC_VP_CONTROL_DPIENABLE_MASK);
> +		}
> +	}
>   }
>   
>   static void dispc_initial_config(struct dispc_device *dispc)
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 6f53d554259c..0fbfb86adfbf 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -92,6 +92,8 @@ struct dispc_features {
>   	u32 num_vids;
>   	struct dispc_vid_info vid_info[TIDSS_MAX_PLANES];
>   	u32 vid_order[TIDSS_MAX_PLANES];
> +	/* The DSS has VP_CONTROL.DPIENABLE bit */
> +	bool has_vp_control_dpienable;
>   };
>   
>   extern const struct dispc_features dispc_k2g_feats;
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> index 4cdde24d8372..4246c72efdd5 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -230,6 +230,7 @@ enum dispc_common_regs {
>   
>   #define DISPC_VP_CONTROL			0x4
>   #define DISPC_VP_CONTROL_DATALINES_MASK			GENMASK(10, 8)
> +#define DISPC_VP_CONTROL_DPIENABLE_MASK			GENMASK(6, 6)
>   #define DISPC_VP_CONTROL_GOBIT_MASK			GENMASK(5, 5)
>   #define DISPC_VP_CONTROL_ENABLE_MASK			GENMASK(0, 0)
>   
> 


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3841DCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B56311220C;
	Thu, 15 Oct 2026 16:15:13 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0710E518;
 Thu, 15 Oct 2026 06:52:51 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F2VA7G272307; Thu, 15 Oct 2026 01:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=sDcd8Swntsh9/ui
 9m50q7kINHKgmLYurS4Fkc/Uae5E=; b=VTkeNAImDrmpiYfm6+HCKzBneqkaf3R
 QZISRZj4zb9v4LXlPzx8bK9bxUbYeBnqBqGOM058RkTurTpoDB1tnu+FP+8fhciq
 wFxxhmxhnK5FcAeFQ08rJMxxDpFOiEkptt3ou6FFxI6Ikmh+MnKRoXD+8NlUmZya
 +DEMTh6lZg9YWDGyJebqj6z6xWGPbWbtj84e86P381FDtU6nsWUXR4o7k0/1TaNf
 sKNUifeDg2KqTuy0FD/kPJhLDKH4SX/HqYugyJhnpC1ClcpVW1PZptTGH9z4bt0W
 WMuMGMteFlTuCsq9OMPh2ruB9BY2Ik1q5ehBTf+N2xftX4ScZgZZuzA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hag1jban7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 01:52:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjF0cBqV0/5wbojnJ561wFZR3+tRIZ+Cx3CbWFrRsPgITlaEn+gGRjo6W11KRKeoYW2GZ/gGDZkBVlWOrAWorBBTyoMO22FDIG12Yvn3P7bB3ZoDwIC7ShfBHGwozJQ0UMkZsJtoWcARLauHTpbYEhuEFnTOA6Q+p1GlK76Kcad4DYJSEqRi01jOO6DsX7YMV7vVIYFHLJpeCUvmkDYUbzWRY0vF15xj43mwFHBNFIMVL2s5TL6FIKJHMrYrg/hX09hmK/dlq34KXo26Wz0oq3mX2S2Mjd+kJoQaqjePbZnJs8WJwwqhMlwHK3tFzdN1KX2BcjYBm6U05ggN/YT4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDcd8Swntsh9/ui9m50q7kINHKgmLYurS4Fkc/Uae5E=;
 b=o/H752VgXJ6xLFAge7eub5W4JtT9GtcBWyztyRUz+Te5232Zf0nnKkeDgs/jluoYbIpNXnN8l80ZNoh1khgpXPmr8y3KJryy9vjsSbQ/rDBPZ40RIoOuEv4coHiyZLtHbWEgieVcOrbjljBUQa18Wp7XNJboSHBYEVOVhNmk1JSL3y+OjZVUtCtx2EU94LY2mSFFZwDMoAmHiwYCi6BN8otMC5YqtJxWy4tYzNOGlQnahs5TQ5142D4l0R5dsvSrPjkHVXEaH5weDp6slEqBmaJ+3HHZIwCP/raTJ6yp8i3DWl4+dob1nW3jIV9UelFZd1V8+FgcPoUra6JD38xbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=debian.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcd8Swntsh9/ui9m50q7kINHKgmLYurS4Fkc/Uae5E=;
 b=OCMVlUIg0AYimo8bACEN3eKYYA4su9+uN0/EHeveQsDEgLlsWv+ZIoCVixY/rsserPDiQKcNbYUJMT94tXUiy0LqhKBWeRxLqwf01884aBblXiOLX06cVT/K8zmUYmCOT/nxKhSYYCWqRbVkeHZQtK0zEKqGNSJA1m7cqGGZ/zs=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Thu, 15 Oct
 2026 06:52:25 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::a3) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 06:52:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:52:23 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 15 Oct
 2026 01:51:28 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 15 Oct
 2026 01:51:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 15 Oct 2026 01:51:28 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69F6pKEO3868599;
 Thu, 15 Oct 2026 01:51:21 -0500
Content-Type: multipart/alternative;
 boundary="------------anY0L0xxhj8LiX2Zll7l90gR"
Message-ID: <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
Date: Thu, 15 Oct 2026 12:21:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
To: Mark Brown <broonie@kernel.org>
CC: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap
 <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
 <Ritwick.Sharma@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, "Breno Leitao" <leitao@debian.org>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a2f0cf-9046-47d0-ccd1-08df2a88de0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|36860700016|82310400026|56012099006|4143699003|261009223027099003|18002099003|10067099003|22082099003|6133799003|8096899003;
X-Microsoft-Antispam-Message-Info: yu3VDfnPuzEKb7VD68742EwPhn56kTsKlP1oQ4Vedz9jwc3oUWLTwdiXkSlke2RSisCfuJFKf1maIW3x0rOI1ioXUR7I07bctRHeX78LgWa648cv3YdVv7yyyGH1xv0qhNk6AnixubVMq5zONodWo1r2DNM1Lmv75LB3jcVZfBwdg4yHhblD678r721VZwYfi8X4DWvT1vIB4pwmzL7zYYW16HsL7O/gQla8xw6+qvGdYIrb1iHwbi/KVgX+y96zoFvD8GpLADwh6sSEpucEJBw42P6o7MEmGh6vtRk1uMyXB/rwL9UTZuancNHz+wMpMe8grwpyyyhv06UQPVOE3QElfqk0sooMEr+bBwvSFgQN0v/H/V62SlI/074Z2L0RMMxrFYxGWyda7Wvu5ZzMtl+2to2WPsEqiK8B1+PcG+ljYfahdPCFL48LYTrkDkJJGXIFmkN15/Zc+cG8qPwyPOgQQRWvapNwtIvKaR71k8mBj+Vl1Hvfmzb1fpIRaCCiF8pDsbSEltn9/i+NOpYz0yyGQ8WElsLvKkpelERDiqsTzZNi0f8ZYD8SJmOBTkUzwFiTK54p2axJAeH+Mq+tkBeSyph1BFRWt4DX9JovZ29PC28cXMaKA1YpV6LRaGRt0TeXJm5CdWI8IFnX/UO4NIdtVO3JRycAUzCCtSREq2TxV7p6Rf1VonmtpX8Flusa9SGUo4r1c9qtdW15gwhxcw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(36860700016)(82310400026)(56012099006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ja+wk3VBOis3XWEzzL2BiJX9bpVTYmc4lKUu7pG2uDUXiG4V90fVDzoSO+Jk0ilBaIe1Z1h/u6QXh3SuQBnNodyuDbRLxTEMp6CHfdB5Xkv2ElJGGKWDS5JTIVl3WgPRI2bpY+TdBOb+wFJBrePAihlg+i/2d+wsBFgRFow1LdSmL0G3TpIjZCphibz+djzfjZj0/9pPhKFuXioKfsJU+Wn/NgEzKfhJ6duqo9nMPHt7WExuAPrZATPYSzx+BdAmPDJk1okYbs8XsH6xu9tObFUo8VJIxjfTHuDZJZOsHy3Usq6+2VGOAxKTf4fWFpUd8m1Zstz/G/0oJE1hGlpRYkj1B9Beg69UvhZB7XLY3d77k1SNmN0RdQmSYNiXti5pD1EhwbIfsH50Bup7uLqU9TegY7cRzj/chM1SOlmcrgRMSisRQ/XvFlfJYvdDon2A
X-Exchange-RoutingPolicyChecked: Ik74b7Po0T/dzyu4xG8wZVVYMkA1Gx78WRePURPXterDYGym3gSLImzN8YRdriGSaQ48YRoa3yU+bnlm6hdwueb5/v2fwLNu4vyIT1Iyj+t7JH4TAY3AG0OvCX/Fwy0cOh7XxvRncbF/PxAFvCpwoqcWvHLI4mResBAOoXD7mszUD0I1/Nz0dOsfiDnF6nv3lnOq2POhWBjdvEMiYDdRoOHfs2X3GngqUaW2ecIqDmTL5LhgvQQSBAzdBF5Mlmc6tTmrV4rbFEFrSZh0srhAM3OFUVaftWlR9ZJAD+4aIEtBqvaANhw1QBX2RYx7/0dUD/AYuqpejyG09iJ0oAHK8g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:52:23.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a2f0cf-9046-47d0-ccd1-08df2a88de0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-GUID: Q5CLtBOqfq_3ztMLPX3jqoSR-SkggGf7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX8lADwUYSQEke
 VPkhog1pjpOAFA3XefHPveYS7rPZz5CVf9xVhP/1/3LKJSO4BDWD8v77IamhS5qhn4Xrg2FMs1n
 FSfGidb9iyDGjphLZtPswCkuxt/9sWCD5/SqOr3bjJm2fI8iQs05kzWm7n3xrsnG/VQe5tAT/CR
 O0theZE5YlPfVpRc2FMK/KyKuZp7KbVmn9CnPRi9sLvPcQvYQY0mqgAr8dwZdqGOjmAgDPnx9Xp
 Q8awiCNG2w1MwkNr99tK4EacCbman5e0YgUHo9fLLIn5M/qSduNWnfsxMRgHoYPl7QlOgUMKIIK
 WasF14qxScpFKGP3UkYoz26d5syrMOpeJ7NAxbHGIIP+1JE3uhyG61oy2nBW/bFGX27/jHWc6Gz
 /0wLRZm+pZRGeWqSP+jDzduAe0XTC5d2rVPtog4LsA0w5nCwEt8w6LKnrgWu6F5vvywEAKqs5ql
 HfiBMjwnWJaEQQ7wnDQ==
X-Authority-Analysis: v=2.4 cv=ZsZ4uN7G c=1 sm=1 tr=0 ts=6ad0782c cx=c_pps
 a=850PSMRYHTBgLER2XRwgFA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=-rZrdg_vjpv_L9B4Y50A:9 a=QEXdDO2ut3YA:10 a=qNABUOcEAAAA:8
 a=-ZaJo44-T7x-aGz8m1AA:9 a=z2RUCii4QkltUfWc:21 a=_W_S_7VecoQA:10
 a=3ZKOabzyN94A:10 a=Ytm653ucTKQjCvbzLygB:22
X-Proofpoint-ORIG-GUID: Q5CLtBOqfq_3ztMLPX3jqoSR-SkggGf7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX1jgNBqEQf+N+
 +UGnA4wv/FRJdtj/v3LNooUsaSUUCTqs14vJPGbFS+6nQXjNCllIKKeCSUtf/yBZJGlJ0N7fRXF
 ybWLcwWzrsKPYejru0ocWtX5Gls51xs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150026
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

--------------anY0L0xxhj8LiX2Zll7l90gR
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/10/26 22:40, Mark Brown wrote:
> On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:
>
>> Add new compatible and update driver to support Synopsys Advanced I2C
>> Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
>> this controller differs from the existing designware i2c (DW_apb_i2c
>> [1]) in its register offsets and some register definitions.
>> The new compatible updates driver logic due to changes in register
>> definitions:
> I'm working with a SoC with what looks to be another instance of this
> new version of the DesignWare I2C controller - I saw your discussion
> with Andy and the conclusion that a separate driver would be good.  I'm
> really keen to help out with getting the support for these IPs upstream
> however I can, not sure what your plans/thoughts are there?
>
> The I2C needs of the systems I'm using are fairly basic so I should only
> need a small subset of the capabilities that'll be visible in your
> systems, the only thing I can think might not come up for you is that my
> systems are servers so will be using ACPI rather than DT.

I am planning to send next version in a few days... aligned with Andy's 
suggestion for a separate driver. Would like to get your reviews once I do?
Let me know if you had something else in mind.

Thanks,
Aniket

--------------anY0L0xxhj8LiX2Zll7l90gR
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span style="white-space: pre-wrap">Hi Mark,</span></p>
    <div class="moz-cite-prefix">On 12/10/26 22:40, Mark Brown wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk">
      <pre wrap="" class="moz-quote-pre">On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add new compatible and update driver to support Synopsys Advanced I2C
Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
this controller differs from the existing designware i2c (DW_apb_i2c
[1]) in its register offsets and some register definitions.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The new compatible updates driver logic due to changes in register
definitions:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm working with a SoC with what looks to be another instance of this
new version of the DesignWare I2C controller - I saw your discussion
with Andy and the conclusion that a separate driver would be good.  I'm
really keen to help out with getting the support for these IPs upstream
however I can, not sure what your plans/thoughts are there?

The I2C needs of the systems I'm using are fairly basic so I should only
need a small subset of the capabilities that'll be visible in your
systems, the only thing I can think might not come up for you is that my
systems are servers so will be using ACPI rather than DT.</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p>I am planning to send next version in a few days... aligned with
      Andy's suggestion for a separate driver. Would like to get your
      reviews once I do? <br>
      Let me know if you had something else in mind.</p>
    <p>Thanks,<br>
      Aniket</p>
  </body>
</html>

--------------anY0L0xxhj8LiX2Zll7l90gR--

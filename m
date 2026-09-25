Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0E9C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7639910E83B;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iH3oKhoP";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a/tRYWNa";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9F910E250;
 Fri, 25 Sep 2026 09:34:16 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4aO4v1175293; Fri, 25 Sep 2026 04:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3E6SM4I7tSRsQPQ19aNAvZiIGP92vEDcSMNMd4IRk
 EY=; b=iH3oKhoPMQGMl4cOs586F4iKMq8AZCdWuSQCk31TCRfcj0Bd40AhojWbS
 HWUpDTTKaIM5ioODLFXUdZlU6Mnvj8kAYU+mpd2y0S7oyVEc0fjaryuqpT6uyyp/
 c7T1SuAlOTcG6aQ9eH3SLZlhXqDsvhzg64FSe756BMtkoMyZ5t47qz/HtK2lEKP0
 XnrGEbVJy2ufMO7NuMKI/s49vQpJKIzNzrAzDW19RNHdzrN5RL3qLWo3cJX9o/gK
 +g8sss32safDaZhaY2evyR4P1sWDpvHRaMkxjW+qdxn58bOgZGRPiLoFeX0o5aev
 +enNpAb2jaVC9E7cZ04Eqr1G8aRMw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gvwm38n92-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 04:34:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DShlOTtZcrFtQlA5UVqi+onnlmHkcnbM9OHEO3TxDnKcDu/snI887oE3lH8v95ayc/DHXZ4k0RdjchEtTD3KtnojxYsxMYDh+ebqzC6xYprkvSerYPgXO3FRtVldaa/smwRoZe409aQyL4vpaYIFPlzj/6zya2LmFjl46u678+tgJPFS5QNblxKdI/CTgRMsYSeS+4ZBd9HsX9qj5dY/HfAlGe0CskDKbVnVf6F0wv7DKYMIw/t/m4aQDNMLlvutL1ZHK5pFUzPcR1nxT6vEgfCXuTvUP0A3zPPcqBLy6w61poagQDZvwSeuUCnG/2u4ICq2BsXRhahrq43TvLn8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E6SM4I7tSRsQPQ19aNAvZiIGP92vEDcSMNMd4IRkEY=;
 b=NC+MlmYLgF79xGwS2JypFUI9+PQ8n7ArrZBO7Qk7DEiAXtxJrci/D6EBYhtSSHP+cWFj6d3clI0+AxTB/q06nhElcWLGAKVrNeDsPUbdZB9mIn6w5nEJVCRGA2wKz94wMjp36e9kimHeziN6Bgcdto6wX2y5Pv32Z7ExiPxbQsrQtVEeHxzoyxSJSsKpKwkTngDberZWJS+kZRc6ffPUalw9+ri0OqusfDU7x64XeDMza/b0qQ6DLR5lL5kz8BqUyiXxTsuY4R1FyLtvPZsBPhQ4mXFplo2lsz6Ek0+3pAYmidPFF451RKqeeDx55cgU2SwI00VMz49Kiq1JIqHVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E6SM4I7tSRsQPQ19aNAvZiIGP92vEDcSMNMd4IRkEY=;
 b=a/tRYWNaaBIxHuQao3e/pTJLmJk5mn0ssMd/Ax4f4kU7GAR/N/YwBrotdmdDUE3ru2W2QbIbruvpyP5T2f6i3ORxNUxf0/bHM0h5/yvltNflj+w7ueH5VCNQxSdDnmGMAVN1jRcRO2Bi6wVOZOecl77O/sDoFpOiAIzd3DJnvQw=
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:34:11 +0000
Received: from BN7PEPF000000A5.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::aa) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 09:34:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN7PEPF000000A5.mail.protection.outlook.com (10.167.245.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 09:34:09 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 04:34:01 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 04:34:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 04:34:01 -0500
Received: from [10.24.51.24] (psdkl-workstation0.dhcp.ti.com [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P9XwX31600494;
 Fri, 25 Sep 2026 04:33:59 -0500
Message-ID: <5594cdb2-93c6-4b6a-83d4-c35aabe9e5d2@ti.com>
Date: Fri, 25 Sep 2026 15:03:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] i2c: designware: Support per-variant reg/bit
 offsets and intr handling
To: <sashiko-reviews@lists.linux.dev>
CC: <dri-devel@lists.freedesktop.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <20260925-tda54-upstream-i2c-v3-2-544d74e992ff@ti.com>
 <20260925070941.C58B51F000FF@smtp.kernel.org>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20260925070941.C58B51F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A5:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe1ab15-bcf1-46f8-32d0-08df1ae8270d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|13003099007|4143699003|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: UeuldAZINAeUSKtFh1n8K8c16TKoaaqTk88OApcRJnO1HeoWWMhfaoPJ7vbFS3gWBORRYc7pjE7Qq38CrkTzJP9Wlg79IbGIWoTMtkkf4bXOl+xiRi0+eaPdp6dwkqFHdUWFRzuiEBiVBtkwYabV+XmJrHlsDaUPUoqk4to4xBxRwn2MJgyskkYI3XhA47iBhcDnNClng/ZK2XEyExgZVJb4MiRsnm1douEtI3cdMLqA0pUn/HHgZYLArwxLzqACeGiCNj1nQIfoQU3ia/3kpXd7jUjQlWCUCL1I769ysqFbWsYdtZ6y3fdo3B0dEXBK+OEj3Qsw4owR9t0d3Uq/gCcn/2TdAASkaveICiqPynpuTqBeRFDsvgUgoJ78RVhR4P+TxMA+yAqb96+o+FpFE9ZDbdkBbDOF0GKNigZ0bNsuYcjZahft7EAZKoBnXbe8+/mfqjXNDyRPOdTaoqDUfOfpA9S+6yUdIs5ahYtbvsPQdJR6y325YwvU9BVZL3+yN5UbYjGbbcOaECSGVDMlLc6Mop+5iUgxnYnGGYnv7wHzHWTWsrRdwHJce1QHtKQ+5Gympo2D1pP6iywPLLkxPhQlFd2IL+wfXWbp9MqOWA+OEFi1KVNRRCUO1Rn5y9ZqqQuT7R3TvtS96UIUlsLCrH91WZnYQKQrBdlEWuqP3mI=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(13003099007)(4143699003)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QguaoRFfQqTjm1nl/kq4tP8vX/Fmx2ZEyN132HxGcRWMtD5EsN/o2SB3yJdEUOgX04Mw8Dx21xJiuUV45i6cvpF6F2m/VPFkOuesx3qESVbgw7sgcJ/0yzXmIuRSoNM7rqLIGaR7TH/madN0SszSEHTtDT2GYOxDBI9b2HDJiSdVNbM8r2bytnDIUy4J25HnwyMgn5OrXol6Nfu5d4wGI2rZqC6Ld16bVw8/3iJmIomuXIiBzJA6xB6ukWhuBE7MZgbf36kWs3OcHg7tmlBN4PqQ68tfKtHR4Z1c0fuQiXQ3KndiPJ8dj2R+OFY+QPm7WNg1St2wjzHVEqRfZDZBpTSTtAZQXOrF7GC9/FztFRu4OuemYbL0ZE/xyQucY+YOusYCH/EVF0RTkOnzMSq95nJb5E87A8U2PAlQelOVJ0QCkG+/+mIvmyIxRJvw5hWC
X-Exchange-RoutingPolicyChecked: o/lRrU/JiCTZWY69BRw9FY4ubvqLuJ+qWeNQkNjH21ezpuZEepSMSyfXjGHpdzJB9PDW1JfOZ4OJCdrw4rZUSYyWb7gbB4WGzsm36xV6CZowdrOR3tOnOOVfE813+h+7xptfwC6InqqMB+QxHBcTp1FfjHqTuBtWDxmb1x2XpAEnCwA1i/Ut7whsXTIG/1yzGUmhw8+yDxfAoM4NbQ6ooGTUP5gg4CNrAtTcgjEChjnVZfBJFNJl2ieEDVPnK7eTnMIc0OvzuNiriF562NkH8HSwOAJYlRr+Nl96GtKnD0JMcbE6l0Gi4k4kBrvr3+vqUKNtEJj8ms9asVd3oKKjZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:34:09.8629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe1ab15-bcf1-46f8-32d0-08df1ae8270d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
X-Proofpoint-GUID: ENVG1xoPilm3yVgduJcSBlAhGZwCBXPc
X-Authority-Analysis: v=2.4 cv=EvdHPicA c=1 sm=1 tr=0 ts=6ab64015 cx=c_pps
 a=ZfP+Ya0swgQO+W9lSFUZ5g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=G7YHkjnZpCtBf7_akjcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNyBTYWx0ZWRfXxdT2zaNhUvaC
 z25jXvmKrFHf6lTfnrKsnD8YxvCgMzCrUKv3iS2ogUS4eO2lwQtL5z2cjMAy67WR5laPDNSHqQL
 tOp7h39qDpjeYQwnbiTHhynvvtXWPCfUp2PL2VPh+lKGgimyMZoSIdv9N5s0uplS4Svd32tu3iX
 Lpj2p9wU3crkQiXLxEnYf7mZs74MtKHWb0qIoaJ3bAAtbuNqMnh9Q7BIQyvecw/iR8SyDDeWzcU
 sWFbnHJlFadpMiHweqjUKOpOz/JotL4QaO10/1fW9wf5scsbUgJKvNw8tEKSLCdga/AV5B7KmbO
 1K5AihNcnkCl3kJuGuKc+ffu+mq2/r34wiwzvNGi3hJl5qJhSakFfaxavXFs7qlR3Tup8r4Uuny
 SXo+beP+vFtDBkQIkWvuey0rYaN2GShnDYTv2HmaEkm8j/CNxfP/e04szdDCmGSxephcylAjsmI
 bSYwtQ2g/Auwdo7qHug==
X-Proofpoint-ORIG-GUID: ENVG1xoPilm3yVgduJcSBlAhGZwCBXPc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNyBTYWx0ZWRfX4EWy4o9qJGnK
 L6cO+jw1mwExxbyimvP1CwLpGvLBrrWY6JHa2pD/j5XRb9iHVoHB0bT7rJCXxWkS7OyCJpgcIGL
 b5y4l2Y2qnw9zz/kWoAxQNuPbh+5Jag=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250037
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


On 25/09/26 12:39, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] i2c: designware: wangxun hardware register access broken
> - [Low] i2c: designware: dw_i2c_reg_offsets array bloat in header
> --
>
> commit 5382481b0ab458e2922590488d443f56e4cc2c8b
> Author: Aniket Limaye <a-limaye@ti.com>
>
>      i2c: designware: Support per-variant reg/bit offsets and intr handling
>
> This commit introduces support for per-variant register and bit offsets,
> and interrupt handling in the DesignWare I2C driver. It changes register
> offsets from compile-time constants to a logical enum, resolving physical
> offsets via a regmap-based mapping table to prepare for different register
> layouts.
>
> Link: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v2-2-261785e58493@ti.com/
> Link: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com/
>
>> diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
>> index 53f37f18a7229..994e0e5ea623f 100644
>> --- a/include/linux/designware_i2c.h
>> +++ b/include/linux/designware_i2c.h
>> @@ -11,48 +11,103 @@
>>   #include <linux/bits.h>
>>   
>>   /*
>> - * Registers offset
>> + * Logical register IDs. Each ID is resolved to a physical offset via a
>> + * per-variant table (see dw_i2c_reg_offsets[] below); regmap backends
>> + * (dw_reg_read()/dw_reg_write() and the Xe I2C_REG() macro) perform that
>> + * lookup so callers never need to know the real offset.
>>    */
>> -#define DW_IC_CON				0x00
>> -#define DW_IC_TAR				0x04
> [ ... ]
>> -#define DW_IC_COMP_TYPE				0xfc
>> +enum dw_ic_reg_id {
>> +	DW_IC_CON,
>> +	DW_IC_TAR,
> [Severity: High]
> Does changing these constants to logical enum IDs break Wangxun hardware
> register access?
>
> When the Wangxun driver's parent (txgbe) provisions an external parent regmap,
> the I2C core skips its built-in regmap initialization:
>
> drivers/i2c/busses/i2c-designware-common.c:i2c_dw_init_regmap() {
>      ...
>      /*
>       * Skip detecting the registers map configuration if the regmap has
>       * already been provided by a higher code.
>       */
>      if (dev->map)
>          return 0;
>      ...
> }
>
> Because the parent regmap hasn't been updated to expect logical register IDs,
> it will pass these new enum values directly to the hardware. For example, it
> would pass 26 for DW_IC_ENABLE instead of the physical offset 0x6c.
>
> Will this cause the driver to read and write to incorrect register offsets on
> Wangxun platforms?

This is a legitimate miss in current version, and will be handled in v4
similar to how xe_i2c.c is handled currently.

Will wait for a bit to see if there are more reviews on the approach,
before sending v4.

>
> [ ... ]
>> +	DW_IC_COMP_TYPE,
>> +	AMD_UCSI_INTR_REG,
>> +	DW_IC_REG_MAX
>> +};
>> +
>> +/*
>> + * Default "snps,designware-i2c" register offsets, indexed by
>> + * enum dw_ic_reg_id.
>> + */
>> +static const __maybe_unused u32 dw_i2c_reg_offsets[DW_IC_REG_MAX] = {
>> +	[DW_IC_CON]			= 0x00,
> [Severity: Low]
> Does defining this static const array in a header file cause binary bloat?
>
> Including linux/designware_i2c.h will embed a private copy of this 164-byte
> array into every translation unit that includes the header.
>

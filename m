Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786C9D35175
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD43610E8CC;
	Wed,  1 Apr 2026 10:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j4yMFQ42";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9DC10E332
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab1/d+/ney8gKqM8lqloEwl2+hkJnBXGAbMrgOVoOYhksZ4HhomSgGRTH5hlHCnhePwXeurmREnq15MlOP4HKRKAv+I/2/DUPWHIBBW6CUL4WN23bLiMqmPBHiIfbZoFTdog6A4nEPyX/Zj3u/irktqDgP/CCXFyhJcU7lvqI/W5TWZG+6wBodx38xI+YARkt6RpLIF4cho1480DiSdz58Od7shwiTrZPONzbxGzoXEui1xJS0k8m22DXqXl5QP+t/E+/rlzrDkHyBy7YkjKwzGeb0742c2qZwtbbVWMW0R4O6tW5TawF1Pla95Oai4qq7sNd7FFdX8uLUNaGQ1mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWDClyu3F4h/MmxH6W5dAq9CKeXmVZtCO9GbkSYOTUY=;
 b=WcxysJfDnjNH/LmUFePqVpqpXEdIjnxGVFKeLpDZuYsQU0Jbs/RgNLTQ9C+2EE88lgm3gsMb+LS8BPd7cpeVteil06ZUPldWqZNn7eJSeIynrWTQfy3EVIpOjieL9zHwKtpM0uTGrneN+bVv+hkoUfxy0xbGD6M1ztVdL02gBSX8zT748JN6G+fcfWL0/yurTW2yiggLkjYQGKqlFgn2s2oITN8QUSFb9rMEFId1UKXBQn4c/VJpqznbUYZwKl64tP9VcNWnrS3oMu/5UlGZ4O2thWAA1EuY7Nu0C4MZlQsHSXH1rd93fCAdhrv+3JVg9MZgu/C+JuQWnrClq4PZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWDClyu3F4h/MmxH6W5dAq9CKeXmVZtCO9GbkSYOTUY=;
 b=j4yMFQ4282bnl80+fo+72IVEiqANLclV7ts+DPRc4ra/nYna8P7FXxzlPQkYDlA57iEHinIXubsSbUJMsA6tw3IzmVcgFIWrb7DJOMEAJSyrDraKV8yMxLtPiZ62wl0rsF0hXZR7l3dCQ3JmMik3un4q0fwCwKRu36gF0mcSTNgSjYfOhDKzqW/TfaCPFwTEEtztgNg6iDJuiP5BCQD8DlM9mdsEWqMx+G8TnTadlssprLRqGnAPlYNikV0ytyVyfZ2ketkstvQppY8ZnvzQP8K9q0GLXwQ7bQdbQ/SgPHb1eK+X8j01DGy7mE4cEitmDJ8VXDyGlIatsr/1tJFWEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:55:07 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 10:55:06 +0000
Message-ID: <bfaab7b4-9e0f-49a5-b1e4-6b5cfed8e069@oss.nxp.com>
Date: Wed, 1 Apr 2026 13:58:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable Mali G310 GPU support on i.MX952 board
To: Guangliu Ding <guangliu.ding@nxp.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260401-master-v2-0-20d3fbcd19d6@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::14) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 6744c99c-56e2-4b99-3484-08de8fdd22aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|19092799006|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YRziH3gUln1320tJaLa0hVW6PeKSJzHRo+QEiIVflbowVt5YSHJy5PiOQfTDkmSun1a3VAMUGamtTlz8wB/NPXNdzXKg9si6VS/At9hLzwEfLOZ1Y1g72E+YmqxghcejQAAB2d0mI4H5GiXjLQe5Vs3v+dG5wZaAH1MQ8XAxF7HRbogVXe7kE2OELBaGFCgTPUwJECwHQoa0O/evL+XwqR8EGilZvOAbOl2kdRmpqTvpPVu6B6kzThxNq4HojWxDKN71r6ixLVdk/q3BBfU4OILSIuQYet/o5ZA5IzsNs8Ey2vZFHq4gzmKY7/5RHMtVKET0Cfupttcx7drcUahjyYQkLdiYaCR/CsoclpMq7TIBnhBhyzFOpUjE5/kSe+seBJjcV1e0Q30e7GJz7KXJfA9xaWu7ijtCco86w7NC9XJ6YLRypxaySW8BNtxIk/+CIQRpkWSe4QAdYu+vCUzPvH08QQ9QdRNanOYG7alh2k/m3o92eIUlsmjeLIQ9iOraf3qJeGmvvwlynEKHPdKgxjuiB5ev7xtiZ6fjGPDhlpXYZImRScqqjhB8PVC65SqRlxWsEY8jHUe/CbuxMjGBM+gN8W5YlHURiUA/1hfWAK1VepXaF6H0mdjbJ7AX5TAgi6Qdc8LUIILZcfCeV87ijCG2v0Pja1UNAQHYCIN3Ywnj+biS9uL5lgr7X33T3tQ/BRQcQR0451eG6Fg2yq1GyxYwMAg9bA0W915KcH7PcAgWWleSu6QNBzSL7X07HxP6+2LGgpz62j6+LVfWGi96TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12316.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjB4TXlkNTNPTmRFVFRlSGs2RTBNWTh4MFpNTFBwMUdKZ0tkQ2tLbkJlNUZ2?=
 =?utf-8?B?K3B1NnNBcE92RjFMbEU5YW45eUdoYXJsdXg0Tkp6U2hadTVtb1RRR0JpQkJy?=
 =?utf-8?B?U0txdHpja2NtbnM1cUZxeExiN3loc1RuNC9zR1pmUm9MazhrVEdJVkN3bjBO?=
 =?utf-8?B?OHBab3l2ZVNZNmhQUlZ2aTdkRlpqNGtWSU1rZmIwUEVqY01HTHExTzRtN1Mv?=
 =?utf-8?B?ZlQwVEM5cnNNenpyeTRtTW1mRTZGNmtxSS9tOXNOeFNLTGc3ZTFPbklmMUtM?=
 =?utf-8?B?MGR5RFpxYnd6ODNQRldxamlBOXNoQ0FsbmxNUUpzeFZ4QmRMNm1vS296aCt6?=
 =?utf-8?B?L004RWZJM0JpWW5xbXpVSWlLdEZjNW1UQkNRcGtrMXBRQWNZMUx3SEdMaTFh?=
 =?utf-8?B?bWVvdmVqZ2JSNXJBV3hhQ0VhRjU2NHM4WHpGTWpTNlJLdVJOWTRRN05UM2Jx?=
 =?utf-8?B?Y2ljdVFMc1JZOFd0MWhaMXl2dFpWMksxVFZrMHJZYWRLMlI1U3MrV2cxWGFt?=
 =?utf-8?B?MFpld3QrQVpIbzU2UHkwTVlnbHM5VDlvS3dTTG5nd0hWbUpzcVFjVUUyYVd1?=
 =?utf-8?B?cWg5c0kyM3VlbE41K05jQ2NwQlB4dGFCTGh5aTVzekJZanBsWHNBTG9ucXVT?=
 =?utf-8?B?Qm1lTHBleVZNUHNXaEEvUTlpa0UvNERMMUZHemdiNWdvRmF2ajlkZkFOWG9D?=
 =?utf-8?B?a1RoK01pbUJBbTl1RTVZb2t5UjA0bXRKS1VFMlNNaWQ5NURPWHFwa3RFREtU?=
 =?utf-8?B?VGo0YXBCc0YrYm9URVJSUlU3emF2TXI3VWdnSGhwZE9IaVZGbS9ITWY4MEI3?=
 =?utf-8?B?dGxzeWwrSGVMVmZTQjVsK1ZTR2J5aURPUDcrNUVOQnpOQm8wdlUyMDR1TVpJ?=
 =?utf-8?B?dnI1Z1BnU0x5ZUVDTUlvYllPRDE3SEJlMTh3SWJ5aEpIQWs2SVl3a0R3YjBO?=
 =?utf-8?B?VUplM2VWSnVjN0pDYk1vaWJBWEVNTnF6RTBjNDBDZWNlNVNaWmtCS3o4ZTVv?=
 =?utf-8?B?TlJMVDM3eGZsRTl1WGNQTEh0V0JFako3bkVVdWNVWjhvemNqM2ZGUlI5K3BQ?=
 =?utf-8?B?U3k2VEk0ZHdYS0JyUllTWjZYMHdMQVZTK1FrNGVUanBlbDA2Um42d2FPMER3?=
 =?utf-8?B?UnBEcnRxM2Z5cFBFQ2ZhN1Nsb081cEFDWVFreFUwWjBJMlVTUTFOZ3YzbU1E?=
 =?utf-8?B?ZFhQYXV5bmJRQWFpNit1KzkyQkpUNjU4VCtBUFZ2REtMcmhMYjl6TklxSWts?=
 =?utf-8?B?d0NFUDNGZDJYOHpDNGxSU210Snk0WlNnYnVQcS9lQlBqc0N6eHU1Ykg2SG5X?=
 =?utf-8?B?VHhiaTVaajdZLzBTdkJlOFpsQ2NkaG05b25rQW90VEhNMmM5b05GYlFSaUNE?=
 =?utf-8?B?c3JrVHJqUmYyL1ZNbkVqajlCOFp6dWJMclU0WnZVWUtJMDBDbTF4Z25Rd0dG?=
 =?utf-8?B?dXhnaFJOWTA0aFF5SFJ4aEUvYS9mbWFOV3RvWXRJTkdRaWd3YUs5YjRLRHM3?=
 =?utf-8?B?c0c5M2NlNk1VSXp2VkFLYmVob1FUZVpZMGZYWGxGZFM3U3U5Rk5wMnVsdWl1?=
 =?utf-8?B?T0I1bXpsOCtUeUJ0cy9KSlNmZEV3VG9nNys5R2ErVUJSTDVLSmpVbzNjM0Iv?=
 =?utf-8?B?RXNabVZSd2ZaQzRCRGx1Q0FBRklvenpEakZvQVA1UWJXYXhFL2tRcCtWSFVR?=
 =?utf-8?B?TzkvcDFtL3Q2U2VrUEpqRVZjMlRQT1JvNHhzZ1htVnpRZ0p5cWh4ZU1SNTRk?=
 =?utf-8?B?aDQyREZ1RnZRaCt5UXRqWWtaaXJtYUxHZGhsUnBJSHBjTSszaXBjZWhqWG5R?=
 =?utf-8?B?YlA2enZDZkd4aThvcGRiNmRQTDVZSkxRVzYvVE5iR1FzMzFpVGNFUERnKzdV?=
 =?utf-8?B?OVppanBYb0tVZGNpei91TDZNOUl4ajFUcU5uRWd5VzA1WjkvRzVTWURLUzRM?=
 =?utf-8?B?NnlLR3pNYS9ZK2w1dnhMS21xTHJMbU1MTndYbU5WUlRIMVZpQmwzeXlQUzBQ?=
 =?utf-8?B?R3IxV1dYb1NYOHhmM3ZGM1pqb0dsNzB2clI3ZDloK2R2eEllNXpPQWpyS2Za?=
 =?utf-8?B?N1lUVUhXTEV3REg4R1RvR3RRc1VPSUhiSG1OdWNoZERpOEZxYVUzd2FXM2tp?=
 =?utf-8?B?azkwWGZjMWduaXNOR0xIVHZRc2x5cjB6UkNOcHdtSVA3cHM0aWtOMWF6Q054?=
 =?utf-8?B?eDM3S25pb3o2cGFOMkFkelZmYnBUZFpEUmEzaENONUJIT3dYODVTMU1RWCtI?=
 =?utf-8?B?eGowUk52WWk1b0lQcncrSVJiZTJnczJWWHozcW5tMHJSZ1ArazBXNE5telJo?=
 =?utf-8?B?aEhramFUSENqa2E4WkcrUFJOV3Jya0JTaGZVa01yWnJnQ3dkR1dVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6744c99c-56e2-4b99-3484-08de8fdd22aa
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:55:06.7657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Mpelm2CGJNma+KoclF/K4ffX1q4hjw9SluM1PSsKxTCn4Ru0qupFggWecpYkb6C1UWnboEPwvPsTXtLqogzmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
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

On 4/1/26 13:19, Guangliu Ding wrote:
> This series enable Mali G310 GPU support on i.MX952 boards, the same GPU
> IP as the instance on i.MX95 boards.
>
> Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>

Please wait until there is a resolution to all the questions asked

by reviewers.

Otherwise, this v2 is just useless.


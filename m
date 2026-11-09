Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0433606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=czaO+EoR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF91610E16F;
	Mon,  9 Nov 2026 07:29:20 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1811810E16F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 07:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCs3YODH4qARMzl8s2soX4X23nbTAHwnMQLMK+rkC7KI/FU266u7oiIDD4QXuWmPQx3qxzAowN0/Wo5CEws6pJs0XJMAnvuHMFQrwv1pYFBADNQ7TIwarV6Dg50ZqnkWoY2aNiNn+ceAoVEuywoIL+Hq8eVAfd9JKAVYZ1FrmGLENabE4tY4/aC+5lh3zxbNoOSbGHyzYcW+FwDzNW/Shx4VZxKJPAaDSUf/ZYO8+Zm+vtLTNZv+myYYOqmVgPRp1BCq82y1tCJrxMn57p6nWR6by6VRRSoYE3ZRuwCGkraVXRr2OHZkFkyDNkiJ7StADC8VFlwFFToYAocSz8V0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9Ad4iRJT/fw75/RL/AvKQLHREdrHlt5oK7Is8L5AyQ=;
 b=AFZKJ93NES+P3u3IvDWOMH5pt9y+Zru81WaJkAlITMcz8Udy3ZAhuVI9Ofgh4kN2HfDhxuJ39sWpuXUqkbf7DmGGiEmIKMSHxPHDSqVqTVDt1PHnSi5RFuPIZ/Ez1JfRs/+kvtrY6yVaoL5wDm0CX8gBeGvOiGM1ljB8hMJOjdz+O4w+lWCTY8oG6STxMg5Q+O3AvwNT3zOF5UZ0V0NP2c9xw1T64v1XEMx1dqP/atg9ATFH3+AUt2UTUfOymFzKVcXopTvghxWCcMnZ85dIcr6Izr/t7E5MQVSibPyYS2Omc2Z1LjSlbsWe+jvq/bOjRTaCN1HNYDD/R44rBgc1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9Ad4iRJT/fw75/RL/AvKQLHREdrHlt5oK7Is8L5AyQ=;
 b=czaO+EoRmipm4qkdkqv0Km/jU2bOz438o2lCGNxLEMJqpC8M8X3rCAEMHERxf/z6H3m+aFSuv5yA8yTXe8qv8HmWsBU7poioGt9RaXeHmQp8pUIXTzOgnlPCnFbSMymXVdq3+gA4F0c0KoLjkDq+JMhO5TQTxmEyOz/FfU/4CDA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 07:29:10 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 07:29:09 +0000
Message-ID: <6314f17b-214c-45bf-bb2d-7050f1f0a889@amd.com>
Date: Mon, 9 Nov 2026 08:29:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fbdev: remove the Xilinx framebuffer driver
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, git@amd.com
References: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261106170902.3656809-1-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6197f1ff-6b18-4952-4af7-08df3e3324f1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gkLRr/INTPMMR88HCCtaXdn52E5JiXGqIyS6mXu0300t5vZtm1vn6i0192drIy7hJdp/uadoJ7XRpcJaB1RRy+kTfGS43xNB0AIC1U3/7EKfiXNVxR1kKv65uOIsQMKJLH/IzraCWriHLquTdTfqqS2uBA4yYN3F8wQhlZrnEBOKLXtN1yYJ/nGs2cHiZOTdxRRo83zTMHqh6sdFDWXovbQgr0aDT9/nILYMGZofzVC/lUWUvjkIofoZ1MNW+/kpFndPiLQ3TgPacgCnSTtTOY+VNRdl3I9UGLO/1wsjxRZ21i4uKaHT0JSQH/FGkV9+TRJUxdzSrNdayjIK/VlAt14o0jvDzyZGphcHINAqseOQsK3m2FwY4L7R0t177lUp7b1pTaR21kpG/ZcMsw+MbjoT9BG0+uF3RV7wi0oxJQHFIsKWDZRT+Y/9QNA/PRkXnm+R1vvGPu9yWSo+ZfuIXhsrIUKLqtBerE+JU8g+grbmPqDhswI100KtoLu46PI8NKZfW9W6UWA/3dLZNLad0wdqwNA46+nTCa7LJ3VC0iA9iE23pQnAKYT0JctSDZpQU4PnbtR3FjhX7tLRUKTQkKEDSRdGkHdA1h7AwiRLdgBpT2suQGb+H9SuiaBsJZTUEn7dFTqx5mucFcEX2zAc0NCCbNhMzz+GYu/X2wCO9JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDB4WFBGZUhkM0ZqT1ZmQzRQRVlueWZ0SnRwelcwRGhaOVI3SHNld09FYW5R?=
 =?utf-8?B?MWF2V0p4TlR3L3U4YTdQQUQzSXVnVGlhMTd6Mk55b2xpcFdSSmtzUjV4bFhS?=
 =?utf-8?B?T1RJMlIva0VGVWk4OVJBaUErV0NKZlFHaFhkVHF0aWR3enlrWlRpbWlWdEtx?=
 =?utf-8?B?UGU5WTE4QlQwS3dJQlFwVHc2bHRDMWplTktrWUM0TWF3V3czZ3p5anJFSlRO?=
 =?utf-8?B?WkxvRHR2OVZSMXBCKzVnQ1c3Y0YxSjNnejJwbVYyWUMxeHZGOXV0UjVaVzN5?=
 =?utf-8?B?MlFVdG1rSW5lbWZ6b3RxL2Y3UFZkbVNPWEpVWkdneTJoSVYzQTd1YmpZS1lR?=
 =?utf-8?B?U3VybXpYcHF0ZkpTOEJScm5GQ2svQ2NYV0Z2L2NYVG5INFI3VEhzdTZIM2Nj?=
 =?utf-8?B?MzlEaksyaWZnVWF5M0I0bG0raWNqZWRpUTZMRSs3WSszLzFzclgyVlF3dXV1?=
 =?utf-8?B?eCtvYnZpV1hMOHdqZDFCRHUvTFQ2V05naEFQVlZhYmdBQkNhWkZaWVBpenlV?=
 =?utf-8?B?dVZZaUVVcG1lNGFNRXZoSlFFQkJGYU9nYjhna0h6RUJxTkQ1bXFkMTQ2bW44?=
 =?utf-8?B?UnJ1SXpZNHVIQTRqaFNHSXFVYytibm14TS9OcXU4bEFNVWZPTnV4TW4zaVM0?=
 =?utf-8?B?YWV6bXVZdmViOTNFZjMzY0FmYUt4TWdQcXdqYjA3RlZLSXFQL0pyRnNpUEU1?=
 =?utf-8?B?My83bC9HeXlzN3h5V2tIWXlwdzVrczl4SGg3OUhaUmhYQmpBY1BQc1M1dmpt?=
 =?utf-8?B?TzNudjQ2VE1EUVV0ZklNMG90aXY3VFNGdVhRZU5YWWMrWjhMOStrbjZqWm80?=
 =?utf-8?B?T1pPNk9GQzVWbm1VYlFBZTd6VzBkY3l2azB4ZUJaR2hwdGJsVnlkZlRMZnJC?=
 =?utf-8?B?VGIwdEM2eXlIRlFVZG9WOS9rVUpmZml5K0wrR0VGUEJrdmpnTCtFeUpydDBW?=
 =?utf-8?B?WU5KeE5wRTh2bEk4V1NneXc2azh6dmVvK09KL055alNJZ0tVNG1GaS9nYlF1?=
 =?utf-8?B?V3BvelNyZGRiNVhoclJSR3A0ZzhoZ21nSG9meTFkNXc1cEpEN21UOUkyak9N?=
 =?utf-8?B?YVhBd1JwUFV2SUorUlVQZzQveWJCR1Q5OVlrcTd1NHVaOFovTzNkUldHNGZ2?=
 =?utf-8?B?T3ZuMHVYWjRJVWNNaUs0bHR6SFNGR3pVejg3dkFXVktLY3E2UkltVmdETTZx?=
 =?utf-8?B?MEJXekVvWmxBc2dLNWFtNkhzS2ZIbllHaHJFdVphUENMQXFKR01jaFJobSsz?=
 =?utf-8?B?ejg1SGUyRlliUHVHWGFwbmtidG43dk50ZzNSakIwU3lCeU9NbGRRNGVLNldR?=
 =?utf-8?B?ejlhUFJ1V3BMYlhoSjFqSDArUlF3U0Y1L1NhTHRmMGFrRWxwclR6UUlBUGtn?=
 =?utf-8?B?c1owR0ZhYTEwVko1STV2eVp0ZG9sTWhtUHBqcURwSFVHN2UrSFJpbFJzM1Vy?=
 =?utf-8?B?MFlyYlJOYlEwaGxJb3krM0tKREx5V0V2T3Q1TExNcEVIUkE5eHN1RWlMZ0Vx?=
 =?utf-8?B?RG53UHE4ZGFyLzVueXBRWElVeEJDVEJjWmZmUW9vVjdDenR3cXQ0a2dTNFBN?=
 =?utf-8?B?UUlyaGkrMlg2RUJQVEp4MjFkNmRpOGhtYUpGWWVxRlBQQmhOQUdRSWZodWds?=
 =?utf-8?B?WG5GZElQSlNyb2Q0Z04xcklodVArVmwxcXpPdGlDTUpYbSt2OUo4TTNML3dU?=
 =?utf-8?B?NjRPZ2ljSlcyOGdwd09lZTZyVDNaL3pZaTd1YnZVU1V3OStvNEpRM00wRDhB?=
 =?utf-8?B?QjNOejNtV283Z0tuU0Nkb3B2RTdJNTFSYXlmLzNiaGpXQVc4d1ZsSWhkV3hG?=
 =?utf-8?B?elE1bEMzdDYvWWJhWlI5VlJGMFhwUE1Ba0ZEai9JcXRpcVlsMXJyQ2JSZkVs?=
 =?utf-8?B?dzl0OE5lRUlkdFM1emNWWFlyaG5NcWlzZzFDMTZYUVYydWdNdUFaaUpmREl1?=
 =?utf-8?B?elhKY2kxRnc3SUVKRXRtTktnNjRYWlFJWFlDOUVveWU5bXNuYkJlSENsOStp?=
 =?utf-8?B?OHJGeDc5YkF0bFVOczJXa2lsMkRxeXRVU2s1SWtjZ002S3NsNVpsTGc1K0k1?=
 =?utf-8?B?MlRGVlk0WWNiVEdDb3hscktlZzNMMms4VmdpQmNYNHZzVkhVL2xTVDR3VHMy?=
 =?utf-8?B?ZEc2SitzK1hDcVNvaGhaQm9FMHBoaHRMUmRzbGRMbW96OWJlK3V1dlc1ZlJX?=
 =?utf-8?B?bnZCR05BV0VUSm55SmhlVXYrQnhiZU50eWxlZE4weVk4cXZjTU5Jb1VjWWFD?=
 =?utf-8?B?ZHMwSVpVSTlnay9sZHZwMDJ5RXFXU01QUU9ub3FyNzVURXJVeUxxaUF5T252?=
 =?utf-8?Q?Zhns6kZmK6TJGePILq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6197f1ff-6b18-4952-4af7-08df3e3324f1
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:29:09.5814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVSIkHZ0KadpjW32EWi0cPtQeLz2pJdhKoJ0FCXsAh2Npx1+yCsF+7q69An6vwyx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 18:09, Radhey Shyam Pandey wrote:
> The Xilinx framebuffer is legacy soft IP for the ML300 and ML403 reference
> designs, built with the long discontinued Xilinx Platform Studio and ISE
> Design Suite. Nothing upstream carries any of its five compatible strings.
> Patch 1 removes the driver, patch 2 its documentation in
> bindings/xilinx.txt.
> 
> 
> Radhey Shyam Pandey (2):
>    fbdev: xilinxfb: remove the driver
>    dt-bindings: xilinx: Remove description for framebuffer IP
> 
>   Documentation/devicetree/bindings/xilinx.txt |  13 -
>   drivers/video/fbdev/Kconfig                  |   9 -
>   drivers/video/fbdev/Makefile                 |   1 -
>   drivers/video/fbdev/xilinxfb.c               | 502 -------------------
>   4 files changed, 525 deletions(-)
>   delete mode 100644 drivers/video/fbdev/xilinxfb.c
> 
> 
> base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8128FC79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 14:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134C910E3C6;
	Sun,  6 Sep 2026 14:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="WmQcaXOZ";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010000.outbound.protection.outlook.com [52.103.33.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60A610E3C6
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 14:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzqMLool3Q0vdh4RQXgP4Q9MCppU1I4pMlUSvEdlFjvhbURd0gLBeZ2uyDOWR7Eayh1V68TS49HzlIhv8X8h8YS3lzXiNXyzQePp4qU9X1IRt++CaRkFit2m9NogAORTd/w5zyAsuAkv1neV1N3RJU6WzkqVGNlcy5xaxM5gJARWT3Tlq+CqdQh/5v++Z6vJY3XN141/swcbH0xegkbucS488S+eqbc9pZi4HOYXREYSCmuTj1/U/Qg0YayUsim4GLrd0TA2Go2Pi4ZP4hHu6oMK4Hm9x9RBB6S343ml+MswIomRwVh34b4tK30UFGh1FciOYAuY1Or/jUzangGblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzI1LZ1mIgzQwxc643uFKHNs0UVgxvCwY4LtOBXAtJY=;
 b=CpWDkokogLX4Z0PxRlMnRdXWQ6X7lOdcCvjmlDd5bQAwUorJx1C5c57n3P0WNuV6MXuHoStwsJRdOeB1H1evtxLH/pX3gfsgibJMhiHCacWCXa6pHeHhpBM1fUT+Q3B93phjh3LYGgaGy8sUYqy32VlgUEo9irDlCqOjbWssELus3Sbs9OpWzjdiMxkd/v9aeoGoTDGfCJDFEYoZ/Gt/K5CCPG/J1ptWXoFzhm0ylr1Xa1KyNbD64a7HpRL1nU6hCBf2NQ14cdrrOXDSifvy6feVQCcrWQIhPy3bTtPsdgVUY5NmGUWh54PMa6kvTku+XkcyZ6Uwi0dAGSNDhJi0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzI1LZ1mIgzQwxc643uFKHNs0UVgxvCwY4LtOBXAtJY=;
 b=WmQcaXOZun3zOCEpWoz1pREAqFr/VgQYhq7vF5op38sPsJ7nV+BtujpMZDtPxPiOe5k7VSLHZMAr2MyBgIAcVkQzDvoeldk0JtS8Fa6GXLTeZMjlQwHz/KWc7uLDmGgCvOSUoD+NB2D1VUO/v+2uhNyaihDPJfD36G+17KSI2dSnRrecB5daivOHTaCefmwOtvsJt5K20DYCZ7ElcIa2wmdm2ukEI9EKHxz523LEPCBPvySEI421jUDBvZlkOj92YoXFOE2hED5Bdxm2/kSVWTGfNyOyIMlQ6hMFFcPNcKLzcO4t5gulSw1UMfWfsEPI5nPgLIpJugYCN956Te1RPA==
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2dc::14)
 by VE1P189MB1006.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 14:39:17 +0000
Received: from VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6]) by VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 ([fe80::5271:c467:5d5f:ede6%3]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 14:39:17 +0000
Message-ID: <VI0P189MB36875750152960821EAFA52FE3B32@VI0P189MB3687.EURP189.PROD.OUTLOOK.COM>
Date: Sun, 6 Sep 2026 16:39:16 +0200
User-Agent: Mozilla Thunderbird
To: detlev.casanova@collabora.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, dri-devel@lists.freedesktop.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, kernel@collabora.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2dc::14)
X-Microsoft-Original-Message-ID: <d378ea74-7a48-4536-ae31-f0899f3ded35@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3687:EE_|VE1P189MB1006:EE_
X-MS-Office365-Filtering-Correlation-Id: cae2f151-3bf4-47ee-3724-08df0c24a123
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|15080799012|8060799015|19110799012|51005399006|24021099003|25010399006|5072599009|4140399003|6090799003|40105399003|2607281247196008|260806224601699006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzlseldpMDZrbXpaMzF0SGFCV1d4OCtvWW96cG1xTzl1UVo4dzNVTkFvR2Ns?=
 =?utf-8?B?eE9oM3NLeEg3T3JsMkdvREpaRHJKY3I3ZE1sNjg0dDJEbDB6SWZwdmFBMXJY?=
 =?utf-8?B?WUVUOUczUnZodFFGTnVKNWREdmVReXZsOE5hZ3UvamRJQXpPVGt4M2VhMGpV?=
 =?utf-8?B?Tmp4RHM3UU84S1dISlo3K0tkYWtDQ3lIQWNUSU9lS0dnWWhKWTl2Y0ZVb3Jn?=
 =?utf-8?B?MEJDY1ZOVlNsdVM4VGdXemxxZ3ZuenVuMURvb3U1aUMrajdHMk9lMXYvYmhG?=
 =?utf-8?B?elJOaTFoQ0pBN1RDOFNzRGVFL1dKSVNWbnI0U2dQcGpsU2QwUkNyMzVHbzlK?=
 =?utf-8?B?eGk2amhzOWxCZHhra01jWUtmWk5qcFQwTFR0Z0l6U3Y3ZENVdk9KYU50dGR2?=
 =?utf-8?B?V0dZVThmWGIyNFV3angzMEJXNXB0eXdQZ0dwaENZWWxNYkx5K1Y4eWN2OHFo?=
 =?utf-8?B?eXA1dmhXbmQwWjdKQk5jMFRuakVDbnZWNlRoSnBHRzFDVU9WYnY1Z042RkNC?=
 =?utf-8?B?R1NCYUd3Znd2S3RzaWNPd1VIcmVBeURDTk90TGhjRDNYOG9XbkRzTWFITzRJ?=
 =?utf-8?B?MGd3YzVjM0pHRjNEQ3QxckJDa0dTY1lzYVgreFZOYnlLYWVEYzY3N1F2ZThy?=
 =?utf-8?B?eDRFN0g1N1V2N1BIb3FQc1VYQnlSKy95TE8wbTYwQnJkUTcydTF2YlhXTVNU?=
 =?utf-8?B?S3NMUnFOb3RKUHVja1VvcVNnT25SbDIzdXkyUVR6WXBFZHgzSTRhU3NIWEF2?=
 =?utf-8?B?TFo4bVI1eU1nVXc1SXdYbXZrcEZmYzEyNTRFVGZRNG9iWHZUd285d3BoZGF2?=
 =?utf-8?B?ZXVUaXcwNTBmZElUQlJnanVncW9TbVAyOU5pa095Z3VlSnkvbG95ajlaQ2xG?=
 =?utf-8?B?dnZmVkpHaVA2MldLcCs3M2FMODBUcDQ2VEVZRFgydnRHbzBXUzNzYStGd1ZE?=
 =?utf-8?B?d0RJcm9IdFlsSXFRS0ZkcnhnUjBuNjhLM3dpNmgxdXQzQ1JJTWl2ZTFzRGtV?=
 =?utf-8?B?ampJOG9aMmpYS1VRY3VoOThHMUdMQzUrdXBVbnRoTmNKV0wzZ0pyemh6Y0Vo?=
 =?utf-8?B?dFBmeVd6a2FJS1RxeFVLQ29iNkNjTTBKbThvakNVR2V4d3A5d0Zjdkgzdk1i?=
 =?utf-8?B?OXZYMG4xNm1ITUk2Vjd0clB2Tk1qWjZGb1FjdU8zSm1VdEV0NXZZdkp3ZVo0?=
 =?utf-8?B?T0hLMEkyYVYva3NsVll2NXF4TjFJMkFOWU9kQTJFVy9nelJ6NDhWRXZEYjdN?=
 =?utf-8?B?TVlaakVVVGFxNjVTNmNraUMrTzdsd3V6elU1YkpoeHdvcWJaYlFwakRnSVJv?=
 =?utf-8?B?dDhJUGV1ZEZsN1cxU2txcW9BQVQ1Qkl4aE5DcStDQ0lPNGx2SCtSVXU2OU9o?=
 =?utf-8?B?ZWhoNG9NVi9nbUE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0d3djdlWnh3ZTBUdEJNTytSR1ZIVDRnR1ZNQjNLekpmd1llVGdFeEtrSTEv?=
 =?utf-8?B?YkJGQXNzTWVsNDUrbmhIRVRJdVkzVER4cHN4cE54TUJ3VXNSZkFwR0NwK3M5?=
 =?utf-8?B?dVdwN3RrdTZPRGtzb2Z0c0d3eHhEb0xyaXoxbGwwYkpYNnZPUXFyOHA4ZWVU?=
 =?utf-8?B?L2JabmR2Z3RvLy8yVHFSTE1WQWZ1OHkxRGpvTDdLWUY3b29DVEhVOXFFbVdI?=
 =?utf-8?B?a3Zoc2tBTTFLZGk1eUFSSzVIY0NzVXVhdXhOV2pJakxVT1FJZVlBb3JQYkhR?=
 =?utf-8?B?anhrUlN2bnl6ZEZQeFJQaWtzRmtYTlNtaWx0OHJGckdtMllycVZXRzNQenhK?=
 =?utf-8?B?SnBvbWI0a0ZacU55eUFuREcxb3laQ2MwTzJML1dBb2phSmEwc3J4Sm1SSVF4?=
 =?utf-8?B?WjgrWVZTZ3BkV1VwR3FJRmhHV0hBRGplRWpHbm9ReGZWdUJmQTg1LzJVamJt?=
 =?utf-8?B?aW5tMHdPY0I2NGNKK2NtWlFDZENLTDhVMVJQQ041RXE5QmNDbTdyQlJ0VVZZ?=
 =?utf-8?B?V05jZ2crdWxENXRUczIycTdBSzkzNDE0MGwvWFZ1Wkx0cklUaTZsWXpsV21p?=
 =?utf-8?B?a1BhQmxPbW80RWVVbWNyRjhtcXZmNTBSUmlvWXZ4cDVmR0VSNjNXTGpJYlI5?=
 =?utf-8?B?dDhseUQvbXkwcGFJZGVFczUzTk9CWVNWeDdMRkhhSzE2SncxZWxoOTRWdWdm?=
 =?utf-8?B?ZytJeW0wSEpTUFJidTFvaW9ORlp1eTUwb0NVZURwdGM5anJqSHZuaVhLRnpB?=
 =?utf-8?B?TDc1dmE0dXRwRkJQc0VRQnc4MUxjQW9CdktuTUI5ZE5WdllTdnZTdEd1VFJE?=
 =?utf-8?B?R3lGcUJHajNURmdmVXJBTjVCRThPck9rUkt2V0ZOSWtYeWliN1J5WjAxSXVM?=
 =?utf-8?B?dHNjNkVZMzNseEIxbzVBdndDV0VTL0N6YWlaVkpFZjAxM2xudHFUbDYvaGxp?=
 =?utf-8?B?YkhtWFJpbzNrZmdTUERsWTJUWkRKVWhFdGYxdzdZaHZ4U25rdkJiRUNoOUZr?=
 =?utf-8?B?RXhzeTUzKzVEMmFta2pOSUtIV3hkenNzKzZNcGt5MWRhNVJBWHFSU3pqK2lE?=
 =?utf-8?B?T21RdVl4NnhGU3hjNzJ1ZjQxNWRiM2U4N1NHY21jUDBrcTc5MTRVZ1BjQi9H?=
 =?utf-8?B?ZDc2UExjelRTdmpUc1hqOEltK0RUdjdjTlJQT3RuWXh1STh0LzI4RGR0eWNo?=
 =?utf-8?B?emJPQUhWWEhwQThhRm9zcWZKUEpXMjkxTTBaYzBTUGluMUlZZlBTUTJXWERV?=
 =?utf-8?B?TExUQXp6M1gwVGgySG1YMFNCZHhlQ2s3MnY5clhrdkl3VjR2ams4M0tZTGFE?=
 =?utf-8?B?TEk5NHBtd081K0VBM0tXeHk0NzhJRXo3RzFRUVdyUngxODNPcjNaM21yZ1Zt?=
 =?utf-8?B?cmxVZSt1N04xUFIwaHNEUU91dVVBRm1CWkFPQ1RQUmR5cityVGVyeW9rME1o?=
 =?utf-8?B?aWRNU1pseVV1MTIrSTYvZlc1dS9GaHZmTmpZaFo3TStjakZMb0o4SUpubGZJ?=
 =?utf-8?B?dHZGZGQ0UDZPMlBhTll3OXZLdXViVnRoYmJENU1jaCtQNzZ0ZUlMK2l5cTJt?=
 =?utf-8?B?UXdhbVJKQkgvMjJONVN4ZzdkblJ1SFZDekpWeDBSZ2pqQTVkWU9vcE1VY0pz?=
 =?utf-8?B?TWNsMWNRWHk3cDJ0MG8vT3pzKzlrdmR2UjVnNG50MnRENzY1WThuTmVMZEp6?=
 =?utf-8?B?QzZXY2JTbUF2cDBXQUJGQzJnRnZMSXZSTEd3cCt2MFgxVVN3UDBFS3BtTk0v?=
 =?utf-8?B?Rm15TzBlRWF2NU52clFaY1UyNE5wdjhDOTlwZ085NUo0WmFudENnY2kxMHIv?=
 =?utf-8?B?V0w4V29IazdtQXQ4bm12cmpLcTNsQUtkcjlnWlp3NkxIN2NVQXZlK3hic0Jv?=
 =?utf-8?Q?uB0Jmx2lmgLSm?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-b25a6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cae2f151-3bf4-47ee-3724-08df0c24a123
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3687.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 14:39:17.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB1006
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

Hi everyone,

Another month, another reminder.
Or is there some reason why this isn't getting picked up?

kind regards,
Maud

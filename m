Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21205606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Q0pI7Jua
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EF811204C;
	Thu, 29 Oct 2026 07:59:11 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011014.outbound.protection.outlook.com [52.103.66.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DE810E6CA;
 Wed, 28 Oct 2026 17:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjnDgkXGFxMGuxV1A3VRVlLAd47fAzJOXcMRKBeE1115IOXSkm3h+KPG1njZlkEM/MImDel/nA+IF9Yi5f8aVWUfUrlqnWueTVCnNF1tUhvMlYzUFlcRHvAHRg/v3P/rHKUjRO3zuVfGw5aH/1vDXxLN/RgVICLkoMq/vkrkzTU/DvSyXmccQj//jw/8Hd53jrRKJ4iLSWZ5/pv2NRIBrmZuspfLbFOdiqSxv2z1PF5bFen+zJLJcUy5dj6M5qgP33tZVBMXiFJOdX7++IJlyoje43svUJ3z1fAcX0FFgN5n0obnUOKx1bnOnBDk3CeEO+wzkqfhDZHMF5Qk7RlfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4hzMB1si+6blEe2VXoDa81ATnUMHdu3V+j4DDJl1Zg=;
 b=AQuugZvXtIqLqzMORFypstr3s2N7+h06phs01nfQQEAeCbQQ+Lv6JUJ8v5JqPkGxC0LKimIsmtmoA2mXaQhmGRe9UDx6TwoWlfpeV9k47qt62NmzNgRBXZAMG4SvOMYUC6n4CSXjt+aLnrNzmyvl8O+wW0xJWidAi8bo967KCTpFzRNEZXEdSb/xCu3lMoLHbmCz7ExnEfivwMaIN1GV3YlQB3JXIJmcAQ1+wJQ8EcjxBxVLb6a7mCEselUJ0sUV8lhV0VjYg5i8lsd4mHGJwGK2068TwZ6CSKDBm+jcjyQAPbU8NJ1WdW3ikLtTF4FKi+zeg5ijvJgqfQLZzaWYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4hzMB1si+6blEe2VXoDa81ATnUMHdu3V+j4DDJl1Zg=;
 b=Q0pI7Jua4C7J/lcMApzXyuHkZi+RAAbWQBoadayd+m0pASPN4VvB2x6dU6K5agNCtb/SnEzBQV+LkTLXpfGfn3q/rmIcWl2owJLcpp374BiEqssimjy+Wao8QVmujnZyxsnNmL87ZTn0N+bYlQ4P300IpipVbeTugRAnpZm9YYZFLfedS24auf6+8BoxAP2HV3n0g9bwIrdE3Sd5MEpSogcL9XP/2zzXVIpfIXOEtL0W9SsGNlVlTCOl6jw4fmnrYONB2OoTbymxfhvY/Rlb05FotSqq2kZwxX/so7toJliTOWPluxBlyUXmcVQQsVmQogY7i+o9wU3E8uFnWEgx3w==
Received: from TY4PR01MB14006.jpnprd01.prod.outlook.com (2603:1096:405:207::7)
 by OSZPR01MB8153.jpnprd01.prod.outlook.com (2603:1096:604:164::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:53:24 +0000
Received: from TY4PR01MB14006.jpnprd01.prod.outlook.com
 ([fe80::dc34:4880:849e:e4bd]) by TY4PR01MB14006.jpnprd01.prod.outlook.com
 ([fe80::dc34:4880:849e:e4bd%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 17:53:24 +0000
Message-ID: <TY4PR01MB140065214AE2B04B2A7D9235BA66F2@TY4PR01MB14006.jpnprd01.prod.outlook.com>
Date: Thu, 29 Oct 2026 04:53:19 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/5] drm/msm: Attach a driver to GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
Content-Language: en-US
From: Akisaira <akisaira@outlook.com>
In-Reply-To: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0066.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::11) To TY4PR01MB14006.jpnprd01.prod.outlook.com
 (2603:1096:405:207::7)
X-Microsoft-Original-Message-ID: <f87e4d81-2b44-4c05-a4ec-93d985d6de1d@outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14006:EE_|OSZPR01MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9858ef7c-f928-42c2-62f7-08df351c5c4c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24071999003|19110799012|5072599009|6090799003|15080799012|23021999003|24121999003|25031999004|39105399006|22091999003|8060799015|20031999006|24021099003|25010399006|4140399003|3412199025|440099028|12091999003|25131999003|40105399003|41105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TS9hOEVsSkMyMk1zT1B3aVZhUlN0YlYxelNYV0lGZUQ2enlzYm9YK1h0d3pM?=
 =?utf-8?B?K1Vjdi9ZYWJENFYvZUZnTU9iU0FLUUd4KzMzUmZabzE1SjFmQjVNYlhOVmVh?=
 =?utf-8?B?TlJPNzEvb3NqL29nNTVqOWhaM0xsaUlnMHNjenNWZkFFRFUzdU1GTkVTNG4v?=
 =?utf-8?B?cEJNTG5PVmZ2SEVxVWc2V0owbFpTVHdhOWRPMVlmclorUGMwcHBSLzdQc3Rx?=
 =?utf-8?B?TmpUN05OSEdkZzVmMHRhUEpQWjVYUEVnbks1UzhBalhFbGpCQ0RwenlueUhE?=
 =?utf-8?B?c1oyQmt3dklXVGlUc0w2SEJEWjRHR3VFK3B6TVZDb1JGRWNGVzVHeExHUVRw?=
 =?utf-8?B?dWo3V0ZVanJvckR5OHNBUm1sY1lkNEpZN0k3SXZiS2YySlUyQytEV1crYVNH?=
 =?utf-8?B?QlQxWDNWelVJMlJ2bjY5SUR1VWR5Y3pQRW5Eb2NvdWJGS0RLNm9ud2loYkJn?=
 =?utf-8?B?b3JFbGpyR2xWWGVKQzNKUUN5ZXdraWFscEc4a01UQ0lXR3k5bXErdHRuODFU?=
 =?utf-8?B?cFhWQjF5V2Jhci9SbnVrZ1YwSlJNcXhPL0Qyam9NTi8zWVlnV2o0SVg0VnBk?=
 =?utf-8?B?WFgwV002Sm1nZTBSY1lUV3FweWg4VVhrcnlmcVVpNEdWbFl2RjVtV3gxaC9W?=
 =?utf-8?B?U1JhbEN2R1I4MlNuSmlML2hZQi9UbXlDTVBMVWp4RUpLUW1VcUJsb09wbGFP?=
 =?utf-8?B?bHdGdDBZK2VXVGc0RWtDTDcxWlU1a1NaZGt3WXFoL0hFQWtlY1Nyb0xiZWFs?=
 =?utf-8?B?MFVOTU9aVXozNkFPd2ZIMzV1b3lyS2NqVVdNZjAxbGw3NHV5Q1lsQlZMUVB0?=
 =?utf-8?B?QUxhVVNodVdXTnUwRXZJN0h1cUorc0svK21VaUQrRUw5VkZGUWRNand5R0Q2?=
 =?utf-8?B?c2gxUE1mN3ZxY1NERmFKRkpURHErZ0w2Q1pGL3lsZ2VhWENxclhZTFBwbHpw?=
 =?utf-8?B?WjRFZTlBQVQrTmpWbXpVSXBUUUQxVzZGWWloazZaRjR5YkJVdG5lYlNVdHhD?=
 =?utf-8?B?dlJQdjlGdDZieU9nZzlGelhLQWIxbjcwRjBwbHRmaU5LUzhsN3ZPZ2NVMVha?=
 =?utf-8?B?cGRIVXlVTzllTWswU045ZVNhOEhTZHJWVjF6UmI5RlV2UHc2bGRnRjRlSmRL?=
 =?utf-8?B?RnBrUlh6R0c0bEZlOFFDcXVKcXFhdTZ3QzdodWJOVkRJMjREWDJ2UW96S1Vs?=
 =?utf-8?B?YTdOQ0hLaWNwN2VUM3VidlZiQ0dWOGFFS2FQb2pOeUVTRjd4V0hubUl5Rll3?=
 =?utf-8?B?OGRJb3JFeUFJbkR1NU1pSjZqSWJrV0ZPMjg1TmVKb2wvdm1TbkQ3NCt6WEFR?=
 =?utf-8?B?MlNRdERVUUh5Z3hVeHJmMEJSaTNZNEFqSXVheXRrUWJUalE4aXJZNTdqMzFw?=
 =?utf-8?B?ZCtuOUZLWFpsVHVtZjdvV3htcXVOMXI5dzNqN28vRGxyRXlYcUZzamhtWitI?=
 =?utf-8?B?VEVMd2F3Rzl6b3pPT280TjFESml4anFCblZESHYvSmp5a0lvdTgwUEFyNTNO?=
 =?utf-8?B?SGR4MkpZcmlHaUdVNzJNb1gralJkNFlsR2gxSFNHWFduWVlnYTdWZEc4VzZQ?=
 =?utf-8?B?Y3dlQXVPWlFIQm1LS29RZVJ2MGhKQWlpWEVKZEo0SUxRUFNXUHVXRXltOXV5?=
 =?utf-8?B?VUNEYS80VWRPbWVONXFKVnRQVHdsUnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGloZVEyRGJHUGs5U0IvdzBRSUUxeWIxdFBtanUxdkQ0ZVRiWkVzYjVXZTVj?=
 =?utf-8?B?TTZSUVhCQjU1OFppK1dYelBKaTZoVExmdGY1dFo0VlVUUnRyN2RHYWEyS2hy?=
 =?utf-8?B?eEtDZ2wwcGRkSEI5bWEyZHhWMEJUWThSNExWc3VZL3VZWVFIdG9jNUROdjRR?=
 =?utf-8?B?VFh0SmZqVmtRV1JndE5VdHBHMHhzWjNhQ0VFamlua0tnTzFNM0hYOG5sTXR6?=
 =?utf-8?B?Qk55MktTWmlrSS9ZV3VIRDhGN3NQeDhxQ3BTaUJ5S21kMHc0UXpHNktleHNp?=
 =?utf-8?B?RXZudTVBTnlESXpoZkFpbStHTHI5SDFqUTBhdjlMT2xLcUkxT2daVU0rZXFP?=
 =?utf-8?B?cWIvdDdyMmRmNk0xT0xUSEU1MElHNmZLUnZONWFVTXFqUHhCMHp3L3RUQk5q?=
 =?utf-8?B?WGR1WkVMNXpqZi9FVXZtVXI1ckVCZWtPQUV4M0Vzd2hFQjE3TmJGVWtEajQx?=
 =?utf-8?B?ZHErejlRSDhRakFwRkExS2QvWWFCa1RkaDl4M21HcUZaL0lYbnVGaTJwb2FP?=
 =?utf-8?B?Ui9Bb1lXd0pyeEtzWUlxUVhPS1FWdGhQOXoyeGVuQ1A5R3p0cUZZTjJmYWhB?=
 =?utf-8?B?a1hTeDFDZUJaZ3ZrK2ZscGVkaXVoQVIvaTlYRW02MTBMVVBBbU9HL3NHaURa?=
 =?utf-8?B?REhzSVVRTWFPd3NmQUJnZ2NGckpmZDIvb2h4ZFlSVmFERDRGL3lpa3NhSGNH?=
 =?utf-8?B?K284N1JWWkNseUZOVW10ejRHMDY5K05rcE82WFpjRm9NdFh2WTBHWndIcHhS?=
 =?utf-8?B?TXdQMFpmaWlSb3k2SER0WC9VMUh2dWFNRFd3dFRLOGpZcFJTZ2c2UHlyYll2?=
 =?utf-8?B?RGVTR3ZQd1hWQ1BMc3ZXMnJJWG9XNDE0aUdmR3ZzaXBoRG5FTFZIQnJpcTNz?=
 =?utf-8?B?VVJxZHREL2hZMzhFRGtMSVJpV01Eb3p1UnljWXlzSnI4ckh4V2Nqc0kxUFJq?=
 =?utf-8?B?SXBNTmxNWTMxVlBkRmJ1UWJnYys3Smo5L1VaY1FVak9xejFwTVBJUmhlYlUx?=
 =?utf-8?B?UU53QlJkemtnTnZZUFY3RWdKV2J4SW5jcXZFN1paa3d1S1ZSZlF2SkRFZ0JK?=
 =?utf-8?B?RExkQlVGWDlVUWFpSDd6NkRmTmhHMkNqU0RDbXRvYmVaa0xTYjhqTkxJVEVF?=
 =?utf-8?B?QkVqVlFpeWpELzBjN0RUN3NzSEJvVjdjbUVDNlcrNjlYRXROckJtVVJDN0JZ?=
 =?utf-8?B?UzJDbVNzT1loREZ1cXJlOGxNdjVEaUFHL0NWTmFrUWcvSThFbm9WSERoeDgr?=
 =?utf-8?B?R09oL3VDR3FWYmxGV0dRUWtIMTU3c2lIYnBSTjhDSXJVTVVaVDJERkFmYkxl?=
 =?utf-8?B?K211Tng5MjBPWUczRHNDREtqc3lUd2p5TWJtblBtV0M2UUJGVXJISWhyK2NY?=
 =?utf-8?B?OUd1NUR3ZEdHNzRxRXUxQlc2UEkzc0dIQ3hLSXBtMlhxbG1obWZZTURQU3E1?=
 =?utf-8?B?RlNoVy9hS1d6MUhlZ1d1L3hCMWJKUmlYOVUzbE9ld3hFQ2RGK25uaFNObHhy?=
 =?utf-8?B?bGY0M04xeG5wTzVLYTRkbVpicG8xeVp5ckdOaEc5NU4zVXgyZE4rNnMvZndU?=
 =?utf-8?B?ZVZJLzBYTXJWNmZPbndQRU83c3pCeXVxV3BlZjVEMXc0U29DNVBDRXhVSXdx?=
 =?utf-8?B?WnlhUkFuVTZqNVlYT0o5d2F0bmhCSURha0d3d1V6R0FmQVJSZ1hEQkdyaXZw?=
 =?utf-8?B?RXV6WFNvZFVsRjFpRTVPZGlRY1p4dTdibzhXRERrQTAzcDNWbkFkdTlOOXZZ?=
 =?utf-8?B?UWhFVXc2cC9GR3hUeHZqTE0xQUE5Z0prTXV4TzFYbGZuVUxjWmljVldIeWdo?=
 =?utf-8?B?ZFRXUjMraWEzRjRlNm9tY2l0SXZsUkRLQ29pUm9LUDZ4bGY1M2Q4RWVxMjlh?=
 =?utf-8?Q?uSVcRT+kBORv+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9858ef7c-f928-42c2-62f7-08df351c5c4c
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14006.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:53:24.0137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8153
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, May 13, 2026 at 02:22:55AM +0530, Akhil P Oommen wrote:
 > With the introduction of sync_state in the genpd framework, any consumer
 > device of GCC and GPUCC which is not bound to a driver will result in
 > bootup warnings like below:

Tested on SC8280XP (Huawei MateBook E Go, gaokun3, Adreno 690) running
Android, on top of v7.2.9. Patch 5 needed a small fixup there:
a6xx_gpu_init() declares the GMU node with __free(device_node), so the
explicit of_node_put(node) at the end goes away.

Without the series, GCC and GPUCC report

   gcc-sc8280xp 100000.clock-controller: sync_state() pending due to 
3d6a000.gmu
   gpu_cc-sc8280xp 3d90000.clock-controller: sync_state() pending due to 
3d6a000.gmu

and six unused GDSCs (ufs_phy, ufs_card and the four
hlos1_vote_mmnoc_mmu_tbu_* ones) stay on unless
fw_devlink.sync_state=timeout is given.

With the series, 3d6a000.gmu binds to adreno_gmu, both sync_states
complete without the timeout, and the six GDSCs are off. The GPU works
(ANGLE on Turnip), GPU and GMU runtime suspend when idle, and a game
session followed by five s2idle cycles gave no GPU or GMU errors.

Tested-by: Akisaira <akisaira@outlook.com> # sc8280xp-huawei-gaokun3

Thanks!


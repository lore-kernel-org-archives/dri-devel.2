Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B607DC982D4
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AF410EBD5;
	Thu, 17 Sep 2026 08:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NR3yqCIC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43DB10EB2B
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIyk4Fy5tJIkeXYRdn0FFryBl4QBZK9ka/z1usYYM+4q844gfgi/IM+quPELbbiczkz2pBoczREuyYaFgwWW2zrNGcXfwj3Xp4tFp87MW7mDtzf3JJX/1rg6N5P/+tYPnMBqsBsLi1Mz0g+0JGGCHzmnlPoWn71tPeyfi9eaPLjPhONtGM3+eXqYMgbTbcA7MOgZcp82J0f85WmkRT3EerpjJPil7RLU/+CPdp/xrtKqs31vEml9GEXVh9khW3Jbm7T5hLGYs8+xkvbYxEx8u8C+J8024fOuglukB5InqAdhzkMMhRF2FJ6rUNJtowu4NxpxPEaqjr1xNoaLlVfnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCga0IpoMR499KvlGY4mjRCgKYEye/e53Eomi+aiD7w=;
 b=iB7BG5V8jz6pLv682cz0762y+4XcZHxlqZmyJ6lD6HWJNTxi1e8QA0YC8MqpS6q2eNrWvACDnSNmDP4GD26JKZLV17ss7NDuxQeIemWcsHdSUJVVqqHp8Z0J56bscsW8cTARDLDJjb930PtVtc0gHV9lYwN5F+szZgP2X1nJy7+HIwswTmQvUrJE6sPw3dhHeN6LmkB+LSe4bJCH1iZAtsaueVbT7yZK8Pzkm6ND1skS+2VuZSSHurAJbibIcwhTnHLxLsJPEPv6BMGTwCd7hwEYXXvHLvGNsduk5YP43phNWcJsg61xFjPuGc70tPmf4TSmwYW6ns9RIyYUUtmM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCga0IpoMR499KvlGY4mjRCgKYEye/e53Eomi+aiD7w=;
 b=NR3yqCICrPKxC2OM74Kb8yeFJNILQZERdzwXT2laN4L2GUTVoMI16Tne89kh2N/DfZHfZzp1yokq9syB/eYwtyUZDJdEed/cBjygkVCKykMj2ikbnIIhNTCpi61CRjqnJQw0vVuOdMa62zyc3AG2j5In1cdIb8F8+NlucQFaJXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 08:11:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:11:29 +0000
Message-ID: <6f31d927-c598-4033-aff9-0f8b2c5590e1@amd.com>
Date: Thu, 17 Sep 2026 10:11:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
To: Davidlohr Bueso <dave@stgolabs.net>, "T.J. Mercier" <tjmercier@google.com>
Cc: sumit.semwal@linaro.org, phasta@kernel.org,
 benjamin.gaignard@collabora.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
 <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
 <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
 <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
 <CABdmKX2GU0Eby=SEeALzeEp5ragEjU3Fw468Jv1yykD1Zdrgag@mail.gmail.com>
 <d8d3af91-4f21-44ea-bc90-339fa1adacf9@amd.com>
 <CABdmKX1YtyFM_MoMbPr4JUCXCr8TGPVbXUrAoQRELpp54cK-0w@mail.gmail.com>
 <20260916162255.jv3dqacwtgfiv5kd@offworld>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260916162255.jv3dqacwtgfiv5kd@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:52d::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9162aa-06af-4aac-6bd8-08df149346d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2PjRYw7QUd/M1BCwv/CwPs8sfwIFlBUc9coUlF4IKL5u+nhK7S9l8iCifR45PbGPPb89sgslfDpSnLqi0S84V9L7xAJjTwmbSCX+9wAY4XEYdSWepd38MKXtnNq03vZ1no/bLP8ZGI1zqp2V1nx3IpAS4dnf0R6BED/KwmmKmSzCf8zK1vyL29FhtoNeHiPaO0T+ndSFODzazJVj+gdGUyhDepHOBkggecwbs8o4r/gYzsYVmJ8fCdRPmycLnFYc0FBtNv8FZm8bogQJFCRLuRFALu1rZFtZo9uR8gtp7PiTbin1FrnZ35Rwy9mHDCDohEHT3EOYK0Px5xEuoFnkTLOVy9aA1vBtivcMnfXbqTkhTbI6vUnmZl5XaGwh/PDmcZGddN2/FnKDDB2A+4N7IJKHBi8PlNaHBnnAmtNS7iOLXV5xmuEijBZAp6JehlOXU4bt4hxK4kNozDSnnXg4Q+arKSUYrphWjRbE5WVHCuOMCZ2YYOvK17rEp3PTdHpJ8gpbK9VG1kVV+x/1ufe5bBcUZKKxk7FqycmcvoMepkh72M9UsnL6NGyZZNbU80BmU9LL1u8c7sixZzRiEp9k/ffZOtmBVUtu3rl4niat7a9CPCXwQBIL2uvJYl3MqTUv41PfgSEuX9hGSc+r+UzmwkHxOU6fi9ERy8MS0ieGfOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU5LUEo4bjBPa01nKzlvdkpYWmhnU1huWUVEcTlZckQ5cG4xTDdMT1VweXUz?=
 =?utf-8?B?WjBwUmlvNDlqRXc1cnU1OEhJMEE3ai9vVkpvb3QzeU1DOWtQL2JmL0FrVG0y?=
 =?utf-8?B?aDdRYm9heHJHNGkrWU5SRDh5QjJSZGpGV014aURMcHFzSjQ5YjNRakRPYTd5?=
 =?utf-8?B?NEk4cXp4QWE4RUhaalBoQS9zdWxjTW1xWGk3U1ZXUGcxYUpyU0JyNU11Qjhy?=
 =?utf-8?B?N0M2eE5QejRHNzZDQmVsK2xGTXJScjNjZC9XZU1WQ3RIUmdnSWlBbmtmTGhN?=
 =?utf-8?B?L1VDZkQ3TlNFTjEyZXYxbW1YTTdGYkNiWjRvQkFScFNESG4vaGw5SWZucWZX?=
 =?utf-8?B?VGtucE9NUnlTR3dsS1ljNzdmRm5ZblhJNStuWjZ3UzlhdXlZRUxCbS96Wkxn?=
 =?utf-8?B?MHVoSi9mc1VqVGxWN1hRVnhhUXh0SFN6dzcyOEhMeTFwQUJsdVlCVmYzUG01?=
 =?utf-8?B?Z0swa2h1YlB0LzAyYld6d2YyNEJac004dHExcjU0anZjV0ZBU1AyY0RBWXVk?=
 =?utf-8?B?bWg4bG9EWnovNHBGRDlQM3VZY2x2NEJyRXJDK1lTQUZmWnNtU01BNmJORGRs?=
 =?utf-8?B?N25oL3I5YVg2WFg4V1BmcVlKNVFDUy8wTUNrbmpYZEtQV25MVHB4eDJFZnFt?=
 =?utf-8?B?bnB6eWg1MEI5ak1WZVFtL1BCeXBDTVY5QTYxMjRnRHE5S3B2MkpBekZPYkQx?=
 =?utf-8?B?ODhvWkJDK2ZUUVdOR09YMzJsTDlJTFFZRDh0UFhLc1pncmgwSURxUnQ2Ni8y?=
 =?utf-8?B?Q3k3eXkrelYwTkdySDJZb2N5OEd6WkJnb0kwQlozY3F2TVBHWlIwa0dYVk1K?=
 =?utf-8?B?dnlXV3o0VEpNNURwVTkyK1Qzb2ZTMXBKWDJvVm56KzhFb2hvSTV0SUFwR1JK?=
 =?utf-8?B?ZlgyL01FZXZmZXd2TUNlazhDdzJQNmtQYWRLUXhEUk4vMnZOaVczTHpsOWs0?=
 =?utf-8?B?ZGtLNCtaKzJHSnBIUWJ3T1ZpVWs1UWllek5iSHF6ZUlrSUVnblZBYzdVZE9E?=
 =?utf-8?B?bEtCa1ZpcEp0azB0NEFaeFFmNHdrUzBpWWtlOU9ERTE3ci8zbG1SbVZ5S2px?=
 =?utf-8?B?M1lubERudDY1aWNBdm5LZTczc2drQ2swTGlOSWZxVnNCbHhFK3AvNnYybmR5?=
 =?utf-8?B?OUJ1YkVzKytoU1kvUTRic2ZhdlhhNDg3bW90L1h0a3BHc21DYzBaLzNLUlp2?=
 =?utf-8?B?b0dzUVA1RHk3bUcrWjRmK3VwKzV0S3JaTlZpWGNsRHJnSjFDZDNBc01KK1pC?=
 =?utf-8?B?OUhYbGhJWTcxZlVTblNEN2tGNFJVcEFKcXh0Ykx6RGtZclpLMFhUTUdJZDgw?=
 =?utf-8?B?OGpmSVJBREhVTmNMM2RsSmNFcnFrODgwc2J4b2xKRHkvaXorOGFWeTdxSVZ3?=
 =?utf-8?B?Z1NZUjd5aUc0NnBpVmNtMjFVSFdjMlRXVVNMM1lsdE1FOGJtdDhsNGV6RjFu?=
 =?utf-8?B?emRyYS96cFlBSkFadzBaeHlSR05LOEFyZ0lLRHQrYkQ3R3ZtNXBxSTN5ckJu?=
 =?utf-8?B?WEd5MEZQaEFaMEJNODdTNWxjN09zSTdDMnQ0aEhxUklZUjkvemZzeGFzWG9o?=
 =?utf-8?B?VEdWV0NOK3RXS0QxeXAzbGdrc2pOZ2FwR2NoTFpYZ2JXVGZyYkQzeG8xc2RH?=
 =?utf-8?B?bytraVF0VVpxR28xMlA2RnMrbDlUdmRkRkF1N1FpMk0xNDlBZm4wdmNRRmcv?=
 =?utf-8?B?ZXEyOWtHOTVNZDhqNTZGWTBCU3laU0NVQi90blVuMjU3VGRyUVZMeUFkNlhz?=
 =?utf-8?B?MndEcVNieTVwcHd6Smk4QmdPWG05TmdMU045dkxTYk1VcC9TNkdndUpFZnhT?=
 =?utf-8?B?WTNhcUV5bG01aW9DTXNuQkZZWmVGRTY3Mm5LQ2ZMUG8rK21nMVpDc2lHSGFL?=
 =?utf-8?B?aFgyWG1YMFhKK2M5cmw1UVAyRnpzY2w5cW01dTR6L1JlSkQyYkF4em5QUmxO?=
 =?utf-8?B?c1dnTFo0V3d4NkVpMlZZc1NOZ1A1Skg5TjNDdGltS3VIY05Xc3hlZUM2Z1ly?=
 =?utf-8?B?ZUVtZ1ZSRG9UQUxIc3ZLUUE4QlRyc0g4Vm5VQ3RIQk5xVkpWaGRiT3Qya1Uw?=
 =?utf-8?B?bG9xeVpEcjlUWlBpZnZDQ3I5UHkrYnpNbTJrcTYzS3FHSGxkdHFxZkdrQjhr?=
 =?utf-8?B?OXM4WXdBOFJvMVJrWHpvMWh3NUVqU3BJQ2ZudnJQR1RvVndhRm1KUWJ4QmUw?=
 =?utf-8?B?L24wZzhLc0ZGSzhEd2VqV3pNcTAyU2JsYkt5R2RXcllNOTR5QnpHS1QyRTM0?=
 =?utf-8?B?SERaZ3dDNHM2NnpkTmRnRmRmdlNsZVEyVFl5WDlBMDA2Y3huTE1CMFdFMDFM?=
 =?utf-8?Q?apbgf8FpK3AKy4i9f5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9162aa-06af-4aac-6bd8-08df149346d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:11:29.2344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYQwNmiu8umWQg/y8G1FRD2IB9NP0sv47oooOkP7V9ZGyQCqw8r8/vj+H/qdxRMV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

On 9/16/26 18:22, Davidlohr Bueso wrote:
> On Wed, 16 Sep 2026, T.J. Mercier wrote:
> 
>> I'm not sure these patches were motivated by Android (based on x86
>> focus in the commit message), but Davidlohr would have to comment on
>> that. That's just where most of my experience comes from and what I
>> can share details about.
> 
> This series was motivated by exploring new use cases for dma-buf (such
> as kvcache), not really for Android specifically. I was counting on
> the cheap/one-time 2Mb attempt (current high order semantics) to not be
> a problem for potential performance gains. As for the x86 I tested here,
> basically because it's what I have on hand, I had no idea ROCm was a no-no
> for system heaps.

Well the problem is that it does work, but gives you unstable performance and people see that as a bug while it is an intentional design decision made to keep the system heap driver independent.

So yeah it's a trade off, it should just be properly documented.
> I am fine dropping this effort.

It's clearly good that we talked about this.

When something is changed here I would rather say that we have some #ifdef CONFIG_ARM around the existing code and use the PMD_SIZE for all other platforms.

If functionality isn't changed I think adding at least some notes that this only works optimal on 4k ARM platforms is clearly a good idea.

Regards,
Christian.

> 
> Thanks,
> Davidlohr


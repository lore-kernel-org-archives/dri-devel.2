Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FCFC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 17:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5FE10E442;
	Sat, 19 Sep 2026 17:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lOnPuqzD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD91A10E2D1;
 Sat, 19 Sep 2026 17:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1iLCs+k4imYrJaTxMTdLj1W/rcjgNXNo0zSmabVrwj5RCkJr37yEd/91eujwh9JMGvD0g56OWuL45kfXGmN40DvvW3TZC+kztdoSYp4ly982UgjpJ4P/JwN2f1DP0JTwAIxH54zyNzlPlYTpYXSc5HOc9mFeF/LhbSNaT4R3VxpWXaG0b0lez4BfsF19m7lqBjkVp4V0ux/iST7KVxpsixtS54kg0O8m0XsIn3QZdV0P8JcthfO5yvnTOBoAoaaRjrmAvOMxqn2k4UGeQmzdp69cdEVqGyv7zvGfv9ON5C/aJIQZjz0C68kXmgsx4CZy+Jdx7uIpatqe0fAh/YqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G70Bo+i1CGRX0mOu9i7R72n+hpuJi9VqfffaddyHCM=;
 b=L8kwbjOOGGHlgxxWKbgx0YBdpJWoTMcy5aMNH11dZWOhncTwRdekrUDcc6KYVjoZWVlTPGpbjoMOLImT0OQxaHSla9qkwAGT3VgNgpCIaNPCclez7IEfrQFJUAkOa5mupRd18LmJqqzmnIxPhoz3ft7R+FZMy4tXz5kUufgO+1IMgNkZfKyKrU5IUAtAdhLQ3AD0fVxoQjv4EM8ejC1bwE0UdniZe/RpiDOyvrXI1jBELpolILxMXtsmW25d5q5AbjuiMNgxoHn2niBxSnhpYhJgryHS1xYNE57fbmAuVZJYZhHxktqHbmSeGB/52RUQU90fST5ZFq59hsPixFGDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G70Bo+i1CGRX0mOu9i7R72n+hpuJi9VqfffaddyHCM=;
 b=lOnPuqzDP+u32BCI9GvndPeJNsNDRi1pxuD79n9XnjsNCTC26aQ8JD3uu1youCVulWuF9WB456Jg/mS4sr4aqTAFXR+QFLiHekOazEK1uDKqUjGM99xTNXyVxBIOUqECX1BdtNndb1WxInEA44+tqbZZEMUqCoWm8VQ8EQt5hwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 17:04:48 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 17:04:48 +0000
Message-ID: <8fd336cc-6dae-4a9e-97d0-0c5eddab589c@amd.com>
Date: Sat, 19 Sep 2026 12:04:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/edid: Honor overrides when DDC is unresponsive
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
 <1efb1842489bc50e87ab0476e3d3ad861d6ef807@intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1efb1842489bc50e87ab0476e3d3ad861d6ef807@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:408:e9::35) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e44a8f7-cdc3-464b-9c76-08df16701ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|3023799007|11063799006|5023799004|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: rWITfpJ8ubdvsZCTvUQvVNw0imghtErHQAtzMLHyiLH3Zp5YXCSaZXQH9+REbdpdwKu+tMWJaryc+WHq2YgAFI3nNZ2ApEBur1Nx/84NlfLQTK2zUYFVbKW3Zyf+d4T0x6Aius254YZiJ0Lo5gb8zTXLm3UHLNHy4fa/dVxlah/624hj8E09XNXpmQlD+F8m1wghFuXxrZ8Q2LFMQDaooxgQROHYNiItsPkty2vvtbjlPlFekQL78yFk9r7rzLFhU1E26nRaxJ2q05ucrwX14SJ7hXeBn++a9eREiveNxSQuns9MgBZElmNogzE2veuVzMa+GiG7BbjaHhM6dhb1C3qwEsen1wyQA6+e2zCYUgw2FV02ZBxG4ygK/YFGCroDoD/oKtea2M0To/xq9GX5zfveqDFGRXqT/Y5Bv2VgSpQcpK02fn5vI7bPAj4r49AF9v8zG1ocE5XdQggPABKNjy3YicZlfAVoWg58sXSg1NQ9DtOLGiCVherYnAmZXvmLakRmVWHE08DjQ72NkVAWAmvnnjZlAdY6OFfVIPxTP4oNnBP0su6FFZCk30+nxvwqUMLgorRnIWhhI2IHMTA3DlWMrAeJMWmhifma6LItvXtIHOPOUbm51mgapHdr8y+jACONaIfV+pmG4q3yeZqg2zwDba218vitJJrYvlRI7kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(3023799007)(11063799006)(5023799004)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZBZjA1enJ0OHprVnk4bm4rZTVWZThaaXJ0WGxVMitGTWlLUE13RjVMOWt4?=
 =?utf-8?B?SVZyY1YwSjEzQ0NQWWwvTjNkN3VrL1FOMDhUZWdHUFZoL1k4NkYvR3JacjFq?=
 =?utf-8?B?OUFKVHh3eXdZTWFwcEFtUTdYWjdZOWdsRnFKSncxZE5wZzV2Q1RGNkhrQW5a?=
 =?utf-8?B?RTZTZTc4M2lNRWROTzFJZElKdU1zL1FIUVR0WUNjN1hPVW1oQkdiZW9Cemly?=
 =?utf-8?B?c3dQcmxLYVJFdkVlcS9qZUpDcTU3ckFkeHkzRkRHN0t5Y0NqT0F5Z2RNKzRj?=
 =?utf-8?B?bkswK2Z3eWtTZ1oyWm5EaDFzRnJ2eVgrVEd2MUtlenhKZUc4dDJxa2RGMnk4?=
 =?utf-8?B?aHdBNlFIaEZOSVlKUVB4U2VRdXR0aVhvNkpqak1FaW9WZWVpeTQweW9OUW9h?=
 =?utf-8?B?ZGR6TEdIS2xRMEZHTEFIc0sxOXBmOWtqZ3Fhd0JSbTlZeWx1MEJIblZUbjkx?=
 =?utf-8?B?MFRIUmxiVGpjRTVaczlQMFptVkc2a2FpbEczWUhiZlJJODEzMFFvL3Joa2w1?=
 =?utf-8?B?Vm0wN2FTa2g0NXl3Z21GaS9sbXJ0eFFTWTAyQ2liSUZRR2NJdFlXV2UrTDVi?=
 =?utf-8?B?TXlnZmY1QUQxWkl6ejE2OEhsbGRlL3hKQjU1WDNYdEdpdHE2UDFsdjgwa0t2?=
 =?utf-8?B?d1picXVGQjA2Nnd4bVRlZWlvekNWNjFramRsMzA0bytzeTlEZUtDNmk0S2Jr?=
 =?utf-8?B?aHJlYW9jTlRrd1NTdGlpVlRjVXhKRGRvV09YcmpGQ1JoNjE0NFBtdlVpb0Zr?=
 =?utf-8?B?ZGlkNkI4Wm81cUtaQ3RiR1BuQm9IU2RlTmFrWkxOVkdsaDhXTFJnM1IrSVhN?=
 =?utf-8?B?Q3EwSXgwTGhlb2FJSHdhSldhUEpmbVlRV1BObGRTUnVCeEpTc1FzclhSSDZT?=
 =?utf-8?B?S09oOUpSM08vR3F2aXBnU3NPZUJKZS9JVDg3bmpzSHBXM2Q0cm81UDljamIz?=
 =?utf-8?B?VmYvSE0zaGp2VzJMbkxYeHRYZzNZdHdjdGJVeFptNXM0cWJvWHdyRVlxQmhG?=
 =?utf-8?B?ZnZFUlk3U1BMT2tLanpqWWxlQUJBU0p2NU9nVDczdjBIL21kM0dIekgycEwz?=
 =?utf-8?B?cDhxdlRtT2NKMGpxbXhxM2hQRFVDRW9Ndmt2QnVJRjhFWE8zNDdUcHB6UlVD?=
 =?utf-8?B?NXB1eXJjSGt4ZUJwcy8vMFh3Q1NyZmI2Tk4wbG5CWisySUlFWUd1TlNvMmFi?=
 =?utf-8?B?K0ZDNVZraHA4SDBZUHlYbVVMWWlkc0FEdWs2RWxCSUl5U2xuQWFhMkpUeUJ0?=
 =?utf-8?B?bktVOWQwTzhHSnZMR0EzazlwRmZWZkFPa1VLMGU4engvZlkyZC9LSEZxZ0Jx?=
 =?utf-8?B?ajFBWHBnbUM5aFU4V1BtYW16T0xnaDhRK2xaZVA1ZW9Wd3VNYktJYjVyVXhY?=
 =?utf-8?B?OWZlOVlRS0cvZDJnWUlMalhjb2VZNEF0NW9QeC9ZUXJNczJEMWZPb1ZxNTAx?=
 =?utf-8?B?MS96R2F5UzdPb2FlbUE2ZFUvSFFsSXdaNmVsbTFxMEtjZEM5S3V0TVhhN3Iz?=
 =?utf-8?B?UUdJaThaM0NYbE5tMGEvc0pudmI4VEp3K1NXMkxUNjlpVUx6U29RQml6NGpM?=
 =?utf-8?B?dFhvbCtIajFvSHRaMGR2Q2tGRkxJRWtlOU5SSjRQMmxyYVUvazhTdmZWYkli?=
 =?utf-8?B?MjcydTN1MlQvMlhuVWszU0orcDJzWWZVczlFZ3EvZThiOWpacGlXVXAycWxh?=
 =?utf-8?B?V0pENzMyY1hPVzAwUk1ua05PWTdPM0s2S3cxaGFhZzJDb29pSHU0WklIT1Jt?=
 =?utf-8?B?WGZBMFhIOWE3dDdPVWx4UTNGaW5uU2JRSEVjTFlVdjg2NC8yZmNoV1pwVkpJ?=
 =?utf-8?B?T210ZWFSSlBuZXQ1cnZ0aVJMRksvS1N1dVBvRFppY040ZytHOHRhZnpYTjcw?=
 =?utf-8?B?RU15ZFovVWxYeGI5clFyeUV6YzY5UURlRGQ4MHFMYzRNU1BIQ2ZvNWlHa01o?=
 =?utf-8?B?UzJ1YmFoamVNakpLeFQ0SlY5UGNQQVZteHJuREJKajlUbHkxR0ZyY0w3cDAr?=
 =?utf-8?B?eW5Kak5EY001d21EQ3JCZEoxLzl3NG5lVHNwaHgzY2QzaXlKK1BRbGpScUVJ?=
 =?utf-8?B?NG1pUUkrQUhGdVY1SStGb0dtbXhuV3NoSlNjbzNaSW5xajR3cEd5ZDJuRU91?=
 =?utf-8?B?bFgrRmpGek93bGZmWk84d2FxVXhSeXJLMGJvUFBsTG9NWlhSVVdkcjNsYTk2?=
 =?utf-8?B?SkRlRDRuUUsvbE12Y3RvT1V5Z1dGUzNyS1Y1MUlSU2o4SmpRODFnN2VQeHl4?=
 =?utf-8?B?OWkxSlNLZlg2NU9UQTA2QkdhSk9sWnJwQlVsMi8wdWJKNFNOTGF2eGNkWGtU?=
 =?utf-8?B?L1VZTE1pMHlId0hsQlRNcmRzNkhyNGZCVXBaMlhCNFpmUm5MQ3F2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e44a8f7-cdc3-464b-9c76-08df16701ce2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 17:04:48.8179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNPmMFvvr2hihdI5qO/d5pxpCp3DEZBTdA963zNOA5ZMHRKrjG64VM12k8dS87HqkaEYkPtI/5RHCdiKo5gwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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



On 9/18/26 04:41, Jani Nikula wrote:
> On Thu, 17 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
>> DRM's EDID read helpers probe DDC before consulting debugfs or firmware
>> overrides. This preserves connector-detection semantics for drivers that
>> use a successful EDID read as evidence that a sink is connected, but it
>> prevents drivers with independent presence detection from using an
>> override when DDC is unresponsive.
> 
> IOW, your use case is that you want to use an override EDID with
> reliable presence detection other than the DDC probe, and don't want to
> use connector forcing.
> 
>> This affects AMD Display Core, which establishes physical presence from
>> HPD before attempting to read the EDID. When a connected sink stops
>> responding over DDC, the configured override is ignored and AMDGPU falls
>> back to a 640x480 mode.
>>
>> Add an override-only EDID reader that does not access hardware, then use
>> it in AMD Display Core before trying ACPI, VBIOS, or DDC sources. The new
>> helper preserves DRM_FORCE_OFF handling and the existing preference for
>> debugfs overrides over firmware EDIDs.
> 
> It was quite a bit of work to unify the firmware/override EDID handling
> to be the same for all drivers. I'm not exactly thrilled about exposing
> a mechanism to *only* get the override EDID, just to allow drivers to
> deviate from the unified mechanisms.
> 
> The goal was to plug in the override at the low level, hidden away from
> drivers, to make it as close to the normal case as possible. One of the
> follow-up ideas, which I never really got around to, was to do the exact
> same validity checking in _drm_do_get_edid() for override EDIDs as
> regular EDIDs.
> 
> I'm thinking maybe we need a way to allow drivers to define a
> drm_probe_ddc() alternative as a connector callback? If you set it, you
> can use another mechanism for presence detection than DDC probe,
> otherwise fall back to DDC probe. It could be used in the regular case
> too, if you have a reliable and quicker mechanism than DDC probe.
> 
Well I guess the real reason that this deviation in amdgpu exists is 
because of the ability to read the EDID from ACPI.

See dm_helpers_probe_acpi_edid() for what it does.  Should we bump that 
up to DRM core so all drivers could use it?

It was added to admgpu for consistency with Windows behavior - Windows 
pulls from ACPI first.

But if there isn't appettite for this being used everywhere; yeah maybe 
switching to a callback might work too (I haven't prototyped it yet).

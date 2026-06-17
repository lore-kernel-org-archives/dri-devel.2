Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E896CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3006E10EADB;
	Wed, 17 Jun 2026 18:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+dyTtRc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A0F10E30F;
 Wed, 17 Jun 2026 18:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t45kjADzQFuAzbc+A5w0NtsnKmLcPoOpRQmFUZwv9X5Xj7H2gKJs79OLouTLfJYJNpqXPV2uSc6aTsh0CwfaRorJzu4wF9tIHCN+K7JAubHJm8aOmYcRoNFoBTMwAj66em1+wyZ7lyK+02ct6rf1U4cUvocZ5pvrcr//bx4n3+6o4uXPZm9SPH/Lp8c8tszA4bY75wf2bTYfxTFDU3xXRC+gUN26zJ6AxkDTUGxHH0xKFLUtWizbpAmQhEwrj/FfUyugyFDhAF7J2Rh5PsTXV2Z3xrw+wXJUqyV6+6jdAXB+yDLTHMqsi3GGAldF/slWuscPvC33zVhPC/k3ZFE8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeAD/A7xDXwvxnFcmB4HHt0KnhFBtya2Thq6l6C/swI=;
 b=asyxRMAPVeoy2nEamat56TtUkrEFvy0ocwUJpE3a3nroQcyZTy/AXRWbVGbTXm+wy5mnOypW+p6J2tNxIHDm5y0hdjOT+6xoH2pLjedugZQLHb93pBtCKzdw0Ga+6hzjRUUMd0pJyJGllxP/HssDRO4HqQ6AekeF+8SSVV1RGh11gWtmHJo/t4uU+fhstd4rHVodcwPnMolLr6RmaJ/VvzpqL0oH3+yM7j/Mu+hIa6xQwLzyhZFaeUZgP0n1WHF3Lg6QrQMEtbU0CSn84WpUUPH+wA968yvEs4keVnUn66pADnuv8L9O6/JeqYg07pcIUAYQj1cw5AF+XgsZ5Rf1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeAD/A7xDXwvxnFcmB4HHt0KnhFBtya2Thq6l6C/swI=;
 b=S+dyTtRcY5MTzYVuXO2P5JETVfHzLQGtsaQfjb7EUy+qfXyLTCBP0CaqAdYyl3ps+8vnv+P1wQ549BEDhvUf/Kie+iPsqIgP9IA88lx5AUFFLl6bItLrBtx+Y0tUBmHV0h375ayv8mdreneb8hAVwrRXY2JDBdPB1xyn+REUk+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 18:40:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 18:40:22 +0000
Message-ID: <359d55b0-d1a6-494a-a9d3-9afce5c8c8d7@amd.com>
Date: Wed, 17 Jun 2026 20:40:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: initialize ret in UMC error record fill
To: Ruoyu Wang <ruoyuw560@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260617183737.1101458-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617183737.1101458-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afa243b-a87e-461e-40fd-08decc9fe34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H80ucHM4/VT7xRym/JCEh517pLHwCO0/oMPD5qRHoSC6J0tEDb12oUyfWUt5rRdJFJWxJf0cmHXFnEOJxBL6IR+hMNTK1cFuhiK/4zKBf/PLuycx52nngdZN5uZikyXLqaV0+klXsjqcZb6HEErMdRGqRkWDruvZRnltB/4o4n9+Z643grNP68yZBKXyAncjmeD8MlCu4Fd0wXJJf2WCCluQSFu+/tY7UzDGYtlR1b3RFZvE5BABfY/lwJrjPV8lgNu34gun76ZQpLz1EpIHOvpmg2mN8SLYjYMpUcqhi2fnveNDcONO/Z6IH+dNMMwJONqlf0Bz7lXQP1Td7cRWaAFsSPhw0Tn1Wy2iHlHZWwB9if2GyWGfBR7Bjq618tOz0TGckODa1AWcreVKfeAbWt5o49JjEb9pw1VsADJiR1qDg0W4e5Q4HARPS7MUt8g/C1of603+n/i6tWm1UFJJ8viY1TIwQubslwJ5uYt0NykpSRP2KiY2tGmVDkh8SUSuZmNJEzVEblFu1GWH+PP247iGfqGZbFqCTVbo2pPpMrfJPiKst8B3kDVkCUMHIhQN9BZg1nui2mk2mqrWEh3hRQSMufBttElb24XE8/mbU/O7/ccQuBlsxTDDlNZXAusj0jwo4gwbQESWYRfNCLNHrQ+8OAp83R9AOA23gvEuRCaIVB4KRXOvU7kJuNZJDYn1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFMZzdSbE9RWElURldXcEVwRTgrZ2JVNFBUblREbWxaV0VMM3dINEJQY29U?=
 =?utf-8?B?YldydkozRUZvVDArSEE2dEovcktNSnpKVU1jK1BjUDFiQ0NhMzJBQmpZZWt0?=
 =?utf-8?B?UnZhVTBkUmFiT0xRMlVzOVFVWFJPU0dabXpWOUdnT1g3SElxQ3N1dWNHcCtC?=
 =?utf-8?B?ZCtEa1hJV1poVVVDQkp4ay9xR0hWbVFiaE9LZ3NEQVM3WlIySTZqYTVDNW52?=
 =?utf-8?B?UmNLRE5kN1lvWDEwNGh1QStXcjZtYnM4VW5yc0xsK2JZanNDalh1TGQ4NU9a?=
 =?utf-8?B?UkNMQ1Z2N21tblpiZ2lRZ3NmYnZBWE01RTVrN1p5U1dGdnFRUDlJSkg5Tm02?=
 =?utf-8?B?b1BjdkRxMW5hOHo4dDA5MUpaYXMyYmNCc3JWcXA0c0VQMmpIRSsweE9ZeXQ0?=
 =?utf-8?B?UUsyS2RETS81WDM5NWJZRTIyTURFWE9ZS0MxQWJJeXIwY0VDQnZUL0FPVzhK?=
 =?utf-8?B?R1lxbk5qbEwwaks0RDIwTzJ3ZjRISGI4bFBwd0VUQWlERkh5YTZnbnVIYWFn?=
 =?utf-8?B?VlpnMjU1YTNtZVg4OFMxVVg4TjdmakFRY2dVdlRBeUtpMGZBeWppdDYyVW5M?=
 =?utf-8?B?MGZiakpNd0pjZWNsSnN3QTR6ZkNxUHVWZi81UmgrZ1VaY1dSMEtBamhHV290?=
 =?utf-8?B?ZGhncDJvd3pJTzhNZDhvSWhKeWxEOXhqL0RDNFl3b2Y4VTdEU2Z4YnN4RDhO?=
 =?utf-8?B?NUl5Qm02WnkvNTF1WXFUWnNTY1FvZ214TU9pWCtyV1BqVVozTXpwc1h2eUNI?=
 =?utf-8?B?NmZqT1dhaS82aGxyd0xLVFlDc1hBSkkzSk5XbElUK2dRbEV2L3IwMVZkVTUy?=
 =?utf-8?B?S2V6MVczblNGdFM2dUx3WER2c3NqQ1N1ZC94enV5S29wdVlkWmhuMnFSSXZm?=
 =?utf-8?B?MVp4Tmx0eUFEQmlzRWFVVk9hbUtQMkJwVFUwZ3RFNDJjYW5LN05oLzlkRWR6?=
 =?utf-8?B?elNYZlNIVzkxeFZrQXJGTzB1bUlrYWpyV1JYL3R6MjRkY3RadWFzRjczVFpB?=
 =?utf-8?B?Y1JVWTh4VkpPdWtwSExGaGdMejBhK05OTWtiNC9EUkRMNzVEeUZLeUlld3ha?=
 =?utf-8?B?VittWjhXMERVb2ZwSTVObDJHTHVaR21CVSs0ZGo4UU1OUjA5T2dXNFFxdm5y?=
 =?utf-8?B?Y3hwN1FiY2dhc29ld1AyV0ppSDNRS3NuNkxBYUVvekd2bGZWWlZuQ2VEN3Ri?=
 =?utf-8?B?eXFxS2xqYW9jZXdRVlpFZHNhZU5rb3dBRGxmOFgyNzQvSEdmZmFQQ3pSa1hr?=
 =?utf-8?B?YzNGSk5paHJFc2pSVjNCRHNOZWVqMi9IRWdmdFVRK2NidWdDakxRcXJLQ0di?=
 =?utf-8?B?ZWQ3Tk9raFhJbmo2eDJVVHNyTjM0MGIraDRiUEUxeU0xVzVWYnJkc05sbDBY?=
 =?utf-8?B?V3VzdmZhVzNGTzNUdStSRXY4TkI3eVNQSWlZM0FOeTA2alI0eXN0ZVdHRkZB?=
 =?utf-8?B?M01JeEVEdWs3cEViWXFjQkFXTlhVRmZ3Ny9RWjVGMG1PYjBEQnowaTgyNC9L?=
 =?utf-8?B?WE11Ymd5L29LZFgwa3VwZlhKdXhFZUlKcEl1ajZPc1QrcnczWU5FRkpPS2d5?=
 =?utf-8?B?dzFVOHRKRFhWSzJNeXFhcS9IcFZtV0k5c29heDJFSjAzaC9STWpsZkZ4RCtF?=
 =?utf-8?B?bXlSNEFvUzFtS1BFV3JZei9oVEd5bHBhbVlMQ1Z1OHFKNjZ5NDl1b0NES3R2?=
 =?utf-8?B?U2xaRjJ2cTd3cVpqNy8xdkV4RFVSeDVDRmlMdnZhNTJMNnkvRzdqMnp1S1dR?=
 =?utf-8?B?M1IzNnpqdUJTazhFVythUVR0VDJCL2dTVHg1Sm9POS9HMmhjN3NleGhHTEp5?=
 =?utf-8?B?TWgzb1A2cG1uMlgxdk42S2dGSER3UVp6Q05acEx5ZGlsYzBxWllQby95T2Rv?=
 =?utf-8?B?Z3N3dFNOb2FXMlRCOHprbVN2dVFVS0FjemxUdmx3M2ZlMXJ5Vmk0WWo0STJO?=
 =?utf-8?B?R3d1aVNQWjFBUmFzem5aZjBXTmxYbFlrK0QxVHJsSDRiaVB0SHpSc213S1dH?=
 =?utf-8?B?WEFkUjh4MHQ2TXNuSkdsU2RoTjY1QTFGM3pLYm5UL2svRVJ3Q2g3bHhkU3Ev?=
 =?utf-8?B?TXpZcWVTUUdjSVJrMVZWVVZEMkUxTG96dC9UMGd4bFhoNm1CTDkzaytlNDh3?=
 =?utf-8?B?c3ZSekFaNDhoaEt6T2l1TnUvVjllK04wbk9BWTc0M2JIYXU1Q3RoMm9kSHNS?=
 =?utf-8?B?NGxLamsyT3oreDlSUzIxbTJwYVlXMnlTUGRhTFlYRUR6MklPWEVHZ0ZNdlN6?=
 =?utf-8?B?b0hQa3VXNTY1SEkyUzBMT0I3VTJsMVRhRTNnZFRqM1JPZUV5ZnJpbGFxZ0dt?=
 =?utf-8?B?UjI2a2M5RWNoM2ZBajlxL2h3RUcyUEw5bTVGOHo4UkcxL0FPSnhkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afa243b-a87e-461e-40fd-08decc9fe34c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 18:40:22.1208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N90einRXdbDpns40VbXuz4woAug9tqB3J2rDIgUboXd8C4r0I2OYt27qxIPOdrz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

On 6/17/26 20:37, Ruoyu Wang wrote:
> umc_v12_0_fill_error_record() returns ret after walking the pages
> reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
> return zero, including when its temporary allocation fails, leaving the
> loop skipped and ret uninitialized.
> 
> Initialize ret to 0 so the zero-page path reports a deterministic status
> instead of returning stack data.
> 
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 14092150336a5..77a9f6a47d428 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -681,7 +681,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
>  {
>         struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
>         uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -       int ret, i, count;
> +       int ret = 0, i, count;

That is usually considered bad coding style. Better initialize the variable directly before the loop.

Regards,
Christian.

> 
>         if (!err_data || !ecc_err)
>                 return -EINVAL;
> --
> 2.51.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFF7C982F0
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57B610E6A4;
	Mon, 21 Sep 2026 12:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTx+vPu5";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E806D10E6A4
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltLGKIs49XW8zSKVFK3BgzodcVpQBXQpwVpkthWoHxl3uiKEz7Zzroxq+mMFKxcMYmIYCLPM8JNaBmEb4BEolCIbfwvXcavOJEpynS5DwxEs8EI48I1p+UNdipHNw6Niuwm2l7x0EgxkMoGlI0FrF3UoR6PAGpu/Q5+zH/vcshAr0omMTyO6816w9z6tjc/5ugAUAfL9Ab12VAoPiI1X3oCCJ0/eoiXUwiIJ5r+H1R76tai0KQree9JXvzRZOV1x/qPz2Y3qC3A3TrUoBjp8+9ba9PEcNr+b1BW8n/M/kVs1a4e2J89HQF9AwFJ1/Ol/YC//iKa3gUzXwSHC7LQ8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB9MG4AjVFUqwXNxnsfiVXtnBjhJpbYV4Uk2gKZAAwA=;
 b=BIY2cx2F/khAlJGkm6HozKKqCe+ZUDmvQCk0uGs9GyKsHx45j4v8ndyKhyw21og8Nsr5Ad7LwnIa4ctsG2pz/leniXIRgQ5WMBallg/WVeO8sfojgAVlpjbyGA+7+oDC+4Pnz1gwsriBYkXPc9xgIDTXMWovObzVUBXmL/hKASP+gT35DechCrDfc78BL0ogoMsZRdQeSLoS43M7bOvj3oqsA9MveAx/rnWJSHV/ZhWfjO3OehsG1vzDRzR9xaVRUEW/gQwH1HfvBljdbNe5hY/WH9vb5yzJgdOiI5RqywnKoP4r7DCfF4J4INSF+atoMoLJnFyuzochXYmcRHnc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB9MG4AjVFUqwXNxnsfiVXtnBjhJpbYV4Uk2gKZAAwA=;
 b=LTx+vPu5eR0eTzqENJWhXUdJNsUwgTnqHW+HOZcs2u7yQ0y+7GNHLnIRiVzMKRA04QJahfb/m7jwk3TOfLMPHDgmjWp+pp+rv5z7WfjDuuqZdCLb6gAMmTZ8UonxCXRPqoE6OS57nf1Z7FWTo1nYdEvJ+Bufl1D9CpRKCVFkwDQbj40jq9syMbIn9YGahIMOzZN3C+A53iNljstP3UgbQdLmMpNeaiitbHL4pAAnd6IlkPo9svMaLtQ/WGudTLKz6IgRMuwpIX6ui1S3kXziNA/iMDtbdo0k3luqlX+f/Og8SltO2FhUIzIrm87tgiyhlQDUYkTAgy07PN5Q10wG2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB9532.namprd12.prod.outlook.com
 (2603:10b6:208:595::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:37:59 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:37:59 +0000
Date: Mon, 21 Sep 2026 09:37:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: kevin.tian@intel.com, nicolinc@nvidia.com, leonro@nvidia.com,
 leon@kernel.org, dri-devel@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h v2
Message-ID: <20260921123758.GB1487657@nvidia.com>
References: <20260921123613.683042-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921123613.683042-1-christian.koenig@amd.com>
X-ClientProxiedBy: MN0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::10) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: f34031db-ba64-4839-1196-08df17dd2b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZB8oIYQ6i2NZKoTfyGEpb/0x6BwIgw7KrqIGkKYGJsDB3fEybqjgx+65Rv/Nw6nxxisTH5+V6ayJZgcKCkn1q4Ge5i6AP+3pQAVj9Sjn6xzZRrvPaowIxoazebWTAE3ULKWN+8OfNAkpesk3PbnCi3S4fpAOJRxMgC3KCguUUl+i0w7cSnJxoR3ReUFGePlDZaSOP3lJBNFLuAGto7msL0rEoFJAYO7JXcpW9MCvnXAeAwknXn5jhPlLz/srx9+sA2XTBi3+FkuKvT4X1IUrN5dAscVdvy5dJ4sXkKRlu5lRYyPObc2urFFnh3SGDvKBhAleThXdyVdSnp93W5Hh6cE1oZMHRVQjoEzjcRHY0DKux1Ivn6vjq5Rw4GRV3Vg2MFn+SXjeaVcbdDEs4ZsJ2+8q4NHIUqkeGdMQQH7vSPwZKAQrwLC7r4cRTnX1EJ3f6EI8aVOsLvPd6ZI+RawaByJdnHNdlLHcAenFx7lMfLyO2DUP1cFqf/sKeQcoY4oJilwGhTyXLDH0xs5w9abgKQtpDqRep5FkE3lNijii+31Ye68fyxHlMZ73uVi/FJtx2U+CkFKWYTauxaDErEIW0GRKjHq2hMktCBP8jwge/1TYvUXK12T+gCuHHAuY3y0KVkFdgZ806134e+tG9+TMo9Ti/+icayzYUVDniY7ORVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNkMkJhb3lSYVp1aHU5b0toRkdVcjllUGxMa29TYjZRUFVPWlN5QXcvZ3Bw?=
 =?utf-8?B?eEtYWmhEcktxak1FNzhCZDJHNHYrdkduczBVUThvTVRzV0RFUE5CeE1GYmxE?=
 =?utf-8?B?MjFXOHVyaTViVkNNbEFUTSt1YnQrc0VscEtSOUkzb1BSMFBtakZIa1BFSDlw?=
 =?utf-8?B?c0tXT0JmOHFvdVVCT3MrRi9uN3UxWTJoazh4R3lDSFVzTzFJMXQzZ1R5V2xG?=
 =?utf-8?B?T3ZOdG9qL1BXZS9aZERxbnZKcDNkMmo3dytsRjFFNlpabFhxVmZrNm9hYzVQ?=
 =?utf-8?B?TlpaYW1xNnBPUm0yWEJuTmJ5d3orMU14OHpEVUVHVjg0Ry9YSER3LzZOZXF0?=
 =?utf-8?B?bTNRbnBuYUg4WTRyczRLVkEzd2ZaaTQ1L29rMExGSTF4UWlJbTlxV2FpWFlt?=
 =?utf-8?B?TjN0WE9JcjJ6dnRUOHN1NGVpcVhldzVVZk90bUNXNWwwbzZCd2k5Z0pnUlRu?=
 =?utf-8?B?YkJ6UHRNZnpvRWZMSUthb041KzVZcGVqRFdhZkhvZThScVlpcGpGNjNwdmEw?=
 =?utf-8?B?RjdoTE1abXBQeHVUVUVSYnEyaE43WmpSWTVwTU51VjFEc2dGcGF4d3lpTmZZ?=
 =?utf-8?B?MXNJc2xiaVFqWDRMb1hEMmFMSmd6cDdaYmIzNTZUcG13OWlkNlRXRnlwRGdo?=
 =?utf-8?B?QTdGQW9CM0xaWlJzb2orRjFGWXQrbkFEdWFhNlBrbjVXN043T1FsVXpOK1Fp?=
 =?utf-8?B?ODNQZ0YxTzdMMnYxZ0xXQitQbkZTSkQrQXlpSUd5WmVpSXRDMU4rOGIvaWhV?=
 =?utf-8?B?cjVCbW4xRFpLYnNBSUt0eEp5eTVzTmkvMFo3ZFdKRW5Pd2lvZjd2T3BpKzF5?=
 =?utf-8?B?L3FYUHRGTUdkMFgvRHdyVHBaV28xb3M3djJKT01meE5JN05YWHpock1VcHhL?=
 =?utf-8?B?czRlbWdOM2FpaThTb3h0VTdEa0t3V1JmeTI1d1hmakg4NTZiY2h4SG83SmdX?=
 =?utf-8?B?ai81Y2c1U3RkY1ByaDk5cWlxUWcyRml0V1F3WUkwUm1MLzJZVy9rekU2UGZY?=
 =?utf-8?B?QWk3aHJNbzB4VkpSZGpyMjNKeFFDUlVtNzZlUVJ4UVhpa3FHZXFWWUZIWXhY?=
 =?utf-8?B?bjZJYmRuVFFKaFhGY2dYQXZmWU5OdGxnTzdTekl1QWQ5Tm5TVjJIVFh6cFRk?=
 =?utf-8?B?alhnb1Via2Vhbm4wNnNubWVVWDNmYkdzWE94dGVCZ3B1Unc4ZzVWbVJHV0xM?=
 =?utf-8?B?ZWtOaTV6aEc0T0pZZENqK0NFU3U2YkdWRWN4bFFrc3JtcDQ3ZkFkZ2ExOEF1?=
 =?utf-8?B?L0FHemFWWmZaR1pFUTZGWFdielVLVTN1eWZORVBaemFibXpsNHUwVDF2eHJh?=
 =?utf-8?B?V1phK2Z3cDYrRDZVV3BDWlorT2JqcHRyeGl2dnVOL3E0SzVYMnZxM01jNEo2?=
 =?utf-8?B?Z3RoVHVDMis5R1JjNVIxMzVmYUVpL0xtVWRrSmpGK0xVZU5JUi8yUVVndU9a?=
 =?utf-8?B?ZWVyZUlDN2NlSnN3M3R1Yk9YNWFZYnIzT2Q5ckNwTkRJQlpkb0dvaVQxcVdW?=
 =?utf-8?B?ZVBmbWtHUDZCbzVzOStkQnZWMm5xVVRoOUIweUFwV2w3VXByTm1XbXNsUUFh?=
 =?utf-8?B?Sktydko2TlpKeXJoTDdLeHpVa050VXJqK2xUR1ZhQXRyYXZFd2lHYlo4THVS?=
 =?utf-8?B?MXJqMW1iRG1xdWhHZXJBS2pGM2MzYnQ5VjNKb0o5V0VwaHllQ0NsNUU0SjVF?=
 =?utf-8?B?WTFpQzNoRUQ3a1lwYTFVNFRjUmEzSWNrMmM1ZnZDbTUwVWg4Tmp4Tk81eGdF?=
 =?utf-8?B?MEZIVVltbWlyRUtZdklTMjVYRzcvVkh3VVlUU0d4cENoc2VicUdxSlpGeXdx?=
 =?utf-8?B?THhWczcvTkhOWjhWU0Yya2NEWnEyZjJrYnY3TWw0V0ZlbHg5d3lFQmU0MU1C?=
 =?utf-8?B?T1B4MEo0NWN0dGxRcW0zTkdyZDFUZThjcEhMS3pRMnA2WHJGbmxPaFZGekps?=
 =?utf-8?B?Y2lZR3p0ZHp5NnpiODU1TW5jc3FRL0l5bUJYRDJVRVIwa21BTldaZDk2RUpi?=
 =?utf-8?B?dHlYekt5Q3oyRkhualN4WmFLUVJkR0cxQWowR1FWTXJlNS9kL2x6OEFlZG8w?=
 =?utf-8?B?OHZtTmVCUDM0dmJOL05zQ1pJMWQwWmloS2FjWSswZ1hmZGhCMEo5MlJiZmtU?=
 =?utf-8?B?V3M1REVEZy9MRVBZUCt2eWZqMno2TDNoS2lCZXM4aStUbFZvRXYrbWpaNTBV?=
 =?utf-8?B?eFhXM01Wd2xBWHRBZEcrZVlRRStMQWE1ODh0OWtIT0Y3NndISVBJRDVVeUdn?=
 =?utf-8?B?ZStwWElmeWw5Yi9JdFZ0d3Fxc2t4SzVCUjBWVVdiWE5HNU0xTTJMNWxsdHhP?=
 =?utf-8?Q?+Cv6K0VoaJVGLCD7A/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34031db-ba64-4839-1196-08df17dd2b37
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:37:59.1103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GesknKI8CIHAHCB2u4KUyYUvTipMMjLgYKr3uatjiAmDbb9srqaz6squMvfU/6Vp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532
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

On Mon, Sep 21, 2026 at 02:36:13PM +0200, Christian König wrote:
> That is unecessary here and creates an unwanted dependency to the PCI
> subsystem.
> 
> Use forward declare in dma-buf-mapping.h instead.
> 
> v2: switch to forward declare
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/dma-buf-mapping.h | 2 ++
>  include/linux/dma-buf.h         | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

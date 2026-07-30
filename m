Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8615C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB1410E0EF;
	Thu, 30 Jul 2026 04:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNE7v9tp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F44410E0EF;
 Thu, 30 Jul 2026 04:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0iFo71gz2sXBNSn2fDmtgoQQU/a6+nvQpSn5dunJhST0F3cuVIQ8N3op4OJNuM3Vv6cW1phQ8oeozsHJ3G1NnbAuBweA9Bc2ODkE8Q3u4eKVGgMEjG6mZ73Ntm3eyWVAI/4k2DyifBiJ+IMGebeODztn0TJ7dQqW+mYyXtw6w/Izx7x3gYPi9k5WALhuvx82RrqL3ovbGYWhs3oLbiOwnWcW9cbzuQUnnbdxjWDv4Eymv7DEG4gXoZEqnUlU3KJaCzI41wOdWpHMjWdtA97jQHSeqrkVcal8We0MEKXysCZherpn/Q+tfKw997e3CYjyUyMtOq9YAMtZrMpETbnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7R//oSYObjIFWtQsetccxE31BgIRu3oQNmAW35718A=;
 b=Sa1fgbo2xLdlg4MvAv0k8FUBu14WFRlFqn89DgN/nxM7ubpOn99sYfbPO01KLSipTbGa74jj108xKWWG6W1WAm+owD5gphOe02uLybA40CTBKomslkGZ6HT6KGypGfchs8mmh0hftXeFXPr5pLYy+AZSCNTnsRS5VUMHIsxj45mQj7dG4cBWcMfms/C1AvAHH0UC4Oz0Uwc3NfM4zfoIvz9oxQ0UWjZuTMzs0Br2t1ZusCXORU4uH1TJK0Fyt/fiApG3JDNnWN7P+rO0zN21Xk9izfDEHijWRNiMQikfaUysWrL7mgLTKzvsSuJKaDJjrvAHUlz+djw2o9xAQFs5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7R//oSYObjIFWtQsetccxE31BgIRu3oQNmAW35718A=;
 b=sNE7v9tpJyNykYpSUVRjczGEjtHM7IytQU0eyXxDQzQPMcHOIwLFGpwCfxDiLIbJ1rybAHBW60/l1bnyM++x+iWhSimu0/AknnEWy6DA+riQSERNk59IaEZZCIMSu0sU2c9mzAXzMc7YsCC/0DOoFhmLRduqssS3Dezwwv2wamhnSxkJOvI4rT7oiyvS/iZiVDMmy1zkoxWEw0HcaMvILse53K9lhTEWcfSALydNkqPrkXhwoxoOQ3k9WLrmaGqRM8pjpjANwLkdvF00luZF+8X9ZIZNSOaIGm+7YVy//Xli0n889a+Zbyf5kWBvOOn4rDfg4uX7vf9qziqOA3vq7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS5PPF18A985A10.namprd12.prod.outlook.com (2603:10b6:f:fc00::645)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 30 Jul
 2026 04:12:25 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 04:12:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 13:12:20 +0900
Message-Id: <DKBM2IZI8KU6.W8TAA6TOR5R5@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/5] gpu: nova-core: split FbLayout into FSP and
 non-FSP versions
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
 <20260724-blackwell-fixes-v3-4-01aa6a54e3fd@nvidia.com>
 <DKA9BUHLJY6R.9PNR3BP9FSBI@kernel.org>
In-Reply-To: <DKA9BUHLJY6R.9PNR3BP9FSBI@kernel.org>
X-ClientProxiedBy: TY4PR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:405:379::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS5PPF18A985A10:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2ef2ae-8926-44c8-edca-08deedf0c2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|7416014|366016|56012099006|18002099003|22082099003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: IjM0lU3wi/juwubmlm/FSIEW/8RD7DphWnOqYaTCih2EPBQ3tsUJ9AdcM1eDicvHK56s19/JPvFQShEGpER7lIeKTfdcNoj5meMtipz2/c0bg9kzHL9T6xFndBjZmLp+XGS9GZ5Tu/x7febPZ7SaVL2PH+U096m9reh8IQjCggLp1avtBi5wcd8J7iCJ9TAy7518b4d7v3mqvutxUii+aOl+FkoLPIQKlQZNOlkOy2Ifwbe/WviA+4FckQgSttp5dV5VaypvX44Jpm7ONBImk0RO4Jl7Ld7KLVbNRECB+vSN0qZOKTLG30ObYicCW+40u1lsBB9QT7PLuuEnco3LQmgMgmneNcEqVoqZF6OxotHvCcSPlDYxrOsSuyfYjMguZ1N+b0eweMbR0jHwkOWzE5h+uloCXLKv8oIBuIo7G4wyF5hUclOpBvOurOISmVzPtduaGWYykQjvo1Vpyi8TZtkoe9LhT1JNUXlY3TpWF8Vx7Ycvo3S/3y6YIx71Z3JeKw1G4ncg7VRtl20o3xvsjDbyLcdjWY3Gk2JG1LpV+tCk/cgVYyU6XmyMjYUTECldcqA+5J/r+eAYuMImOG1cs32LGypZ6DgZez0BfXCz6kgmfuQP7TfvNTPiTf7RLCKXx30517cj0PFT2pZGvKI05p4gtI/M8nE8B50l2kJIjQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(7416014)(366016)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WitoeXc4NkxKaTkxOVBhd1FRMVRpRUZsWFlaTFAreVRLc3RXWHpuU08xTENw?=
 =?utf-8?B?Mll6WGVYSElEclNwaTZzU04xMXFPTHdNTVhhUSsrU2hibEcrMjVFTnllMHpx?=
 =?utf-8?B?NW02Uk1rdHllMmlVMkErMlJyRjFWckpBM3hQUG1SMUtjVVprUnhhb3k5M2dj?=
 =?utf-8?B?d3ZsNVFuM2NFL0lmc1JmeCtVdWF1VUthTEdQeUVEUU5jcnNIdHJwOXh1WVdi?=
 =?utf-8?B?Q2JILytFNFN6UEtRM3lSVE5PeDQ3c044dXZWWk8yY003SjYwOW9XTklPRXl4?=
 =?utf-8?B?emJERW05aUFBcXNRTXRNcVI2c21VVnljcVNJU2FTd0J6b1l6WmlsaXFCc1lX?=
 =?utf-8?B?M29JTlRBZk1IeFhxb05zcDBsbTJCcGhzMkczT09zTmpwS1dNbXMrZGpSc1ky?=
 =?utf-8?B?VGROZWo0bUpGM3FRYTJ6MGlaQnFnTlpFay96KzV2SVRSdkFGdlhpaVFQQXg4?=
 =?utf-8?B?YWhIVEtuY054dk9zc1BoaWliVStxRnVtVlRDM1RQa2VuVWUyRXVaSTVnbTNo?=
 =?utf-8?B?ZTVxbWRFTGltZkU0UldJcXh5SndpT0JCRjFXSHFiVDdjWFdEdGxvam9XZVVr?=
 =?utf-8?B?TjNBNGVjeThyazU1S2crNnoxWC9ONFNUdTRpZU9EWGFmRlhnVzhyOVZkSlRa?=
 =?utf-8?B?U1BoL28wNDVFWVFJdk5WSVJwbXgyWVpheE0vYkdoN0dRMjRjL3JuT2RrRXd0?=
 =?utf-8?B?ejM2ZFJBRTZNeE1sRldXaElNeWNDS2J0LzJvaWxzTHlKcmRibnFMV056Q1NL?=
 =?utf-8?B?eWFldWp5L3FrSzFRQjMwMEZ6enNIZElKMnpFQjhZWnhkVnBYeEVxVEZ2M1k2?=
 =?utf-8?B?TUIrSkl0VXB0QjQySVdrY29vcUlxRHZzWHNvelJCQUlTZkxQRjl6am9BMFlT?=
 =?utf-8?B?NGZSc1EyM3V2eHBBQVpBcVN0Z0dIUlNwUVJhcGZCeFdZZkx3VjJwWDBTTVlW?=
 =?utf-8?B?N2NzUVBkbFJuV1dNTFI5dXdQOTNYaVN2bVUwZ3haYStWWmRoUUNWNThRYzUr?=
 =?utf-8?B?MnFBVlc0YW5lQWk4V0R0ektJVVN2RmdqRTREdTgrR1lpMUdqQWdyMEFXbUJj?=
 =?utf-8?B?U0x3Z0pGM3d0YWJsZGVBeW1sL01JeGpGc0pWSWk4bkJidzc1RVVPMklFYlVu?=
 =?utf-8?B?MjFJdFF2NTI0dkN3bGpScDliME5wOEtSa0t0TWo1SUprNGEwckNnVzhUaHFh?=
 =?utf-8?B?YVNQZDNjejZ6TjdrT1dtRHhmQllxQjVnMkJDbFZtTjFyOUx6V2kwK3l2Smlk?=
 =?utf-8?B?dG9SamlZbTB0UWNIcVVYSSt4SFRiTmllMUJISHBWVm56ZUM1WUg4OU1EZGRR?=
 =?utf-8?B?VlI2MnloL2hyQ2ViS0w4bzZ4bXh0dUFnSVFCbDFTK1E5dGFDRzl6elY2OTlz?=
 =?utf-8?B?N0RkYStkQjl5YTJVdVQ0cGZBRVJqdkdFL0hnRFhjZHdzVTBEOXA1MnFUOVZp?=
 =?utf-8?B?U3BlNnpVVFY1SE5nUWc1NXBDVEFJNWp3dnhROG05bWlzYU8rTE5kQU5sYXpa?=
 =?utf-8?B?Wk9XOFFmVG91b1lwU3V4VG5aaWJZdEdIaGhZVWVvY2NTWTdJaUIzamMweGVq?=
 =?utf-8?B?UkVaNkVyZEVwN2hzSHV6MUw5UU1hQmhCUlRDQ0VpYVZ1VXhwVjN6RmZhZml4?=
 =?utf-8?B?Qzdzaytuelc5VTFtQ01EVTVLK0tuY2ZpZ3p6UFFFMkVFVmJ0K1RVanpKUHFx?=
 =?utf-8?B?d3NGcURlalFGUnpyNUtHNVBUT0pqSW5vakU2MGt5V0hRM0o0anRKM2UrWlYr?=
 =?utf-8?B?MElza29DQnhob1EzZ2F1NXJBZnUramx1d2pzRUw1dXU5dy9HeWwzOHdsaWJk?=
 =?utf-8?B?aXJ2UHFZWDhEbHNNZ25GUVNkVnczZ2VQV1VUYnU1QUs2cE80QW5LQllmbzhw?=
 =?utf-8?B?R09aczFxNVlwaGg2cWZOdnBpUGZiQll4QndtZndzbTVxSUgxTE50d3M4eG9u?=
 =?utf-8?B?Q2pmNi9xYW56RWVlWC96RFZyZXZlaUI3M1R0cis2RUwxRHVKaTBPZTd4MGYw?=
 =?utf-8?B?UjdiakE5MEwxend5ZHFPUWJYOE5tMFV1MFMydjJJbXJIT002OEpzSFJtSnBS?=
 =?utf-8?B?NFZhQ002dzdpK015R3Mwakp3L1RIUmI0YzlTc0d0MHplem5pOHBXZEplMkxJ?=
 =?utf-8?B?cXVBblk3a1hJeWYvMnptM0RQbGQ4cHh5Y2FWRWR3SUlmMFdTVmJDUURYWmlh?=
 =?utf-8?B?cHNyalNtUWNJQlBEWU4vbFFUTzBMd3IvYlB0N21GeDVHb3BUTnU3ZHBRLzZ5?=
 =?utf-8?B?MGlkMmlmTllGTlVwc21Wei9Gd1Y0Q1FLOVFaU1ZpcDlJK3FuR3M2ckVVNWZH?=
 =?utf-8?B?Y2lQRFY4eHN1R2ptbEZQYXlKRFRmbFNka2hiZEN0VUJZWjI5THZremlkNk44?=
 =?utf-8?Q?k9oJeaySsKsP+mjq+7y1Z2DgZhaTyWyiVtVwFTowFZgi6?=
X-MS-Exchange-AntiSpam-MessageData-1: JFD/tP8KQY0f9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2ef2ae-8926-44c8-edca-08deedf0c2a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:12:24.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP4/P2Drsq+IMtfsUmG7vRZrA2OHJLpmkOxUKLaxgku98fKBTLR02yA8U9aBGPhskE6bUUrVplTP1TrEB+BpWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF18A985A10
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

On Tue Jul 28, 2026 at 11:00 PM JST, Danilo Krummrich wrote:
> On Fri Jul 24, 2026 at 8:56 AM CEST, Eliot Courtney wrote:
>> `FbLayout` is currently used for both pre and post FSP architectures. It
>> contains ranges for each region of framebuffer, but on post FSP
>> architectures, only the size is actually used by GSP. The offsets are
>> not decided by the driver.
>
> GSP may be a bit fuzzy here, it should be ACR, right?
>
> Also, maybe we should be more explicit and say that with the FSP architec=
ture
> ACR defines the location for each region and the driver only has to provi=
de the
> corresponding sizes.

Yeah, you are right. Will do.

>
>> +/// Framebuffer region sizes needed for GSP-FMC boot.
>
> Some of them (e.g. frts_size or pmu_reserved_size) seem to be hardcoded b=
ased on
> chipid, architecture or FW version; could this eventually be handled by t=
he
> firmware as well?
>
>> +#[derive(Debug)]
>> +pub(crate) struct FbSizes {
>> +    /// FRTS size, in bytes.
>> +    pub(crate) frts_size: u64,
>> +    /// WPR2 heap size, in bytes.
>> +    pub(crate) wpr2_heap_size: u64,
>> +    /// Non-WPR heap size, in bytes.
>> +    pub(crate) non_wpr_heap_size: u64,
>> +    /// PMU reserved memory size, in bytes.
>> +    pub(crate) pmu_reserved_size: u32,
>> +    /// Number of VF partitions.
>> +    pub(crate) vf_partition_count: u8,
>> +}
>
> [...]
>
>> +    pub(crate) fn from_sizes<'a>(
>> +        gsp_firmware: &'a GspFirmware,
>> +        sizes: &'a FbSizes,
>> +    ) -> impl Init<Self> + 'a {
>> +        /// VGA workspace size to reserve at the end of the framebuffer=
, in bytes.
>> +        const VGA_WORKSPACE_SIZE: u64 =3D u64::SZ_128K;
>
> I assume this could also be handled by firmware?

Yes, I think in principle this could be handled in firmware (although it
isn't now). A middle ground could be providing via TLV metadata.

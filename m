Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A86606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RG5s9psN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B93010E0A0;
	Fri, 27 Nov 2026 06:48:54 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25A710E353
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kay+howfthVyV4BIQtUTRoyKCpyJR4rLssv59Otu9VJX+3S1Ny+xfmLihhMu1TE6r0oH+FDRPPUfUeYSyB80OFbSPdavVH+naGCs3BJZvEdl23HmVAThHfcjGKX59hEQO1Ahs9cjoIjbLQ3RlGEnz12NG7FVoJkg0V3G8cOXYJKrjGmpOQNm65UjRYGjE9cW070Js6aSN2cqMe0J9jJZZef2AGeOX5PDglosX8973/9YlV8yMeGC1Gcuv0Lg/nAdlrjWtjfxJwTku3kif4vDHoghwFsCpfJzg6N+9hQcH7++jegdmz31xzfOJlVPdvYstXa6tEpGVil7OCW+/L39wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeM4a0qv2EAFfd0UPuBotUueDOH5Q1bDea8n//fc7hU=;
 b=uIqOqA/pO+wx7cx/knafRiydDi5GopVAXFJ9FeL2nar/E5uc+5JYA0gAZoX1aXIX6r6fza8+tLax9a5dh34dF0mEcSl1NZJcZD9y8iYUqmi1oYJSdgvf2ypjeY5cLn++m7Wi2DaANG24xu8n5l7HxciI3FucILtbhOUDDBUHsJ/lPZ3j9SKOAe2FcWQ3TxRxU7N9Hv+XKg0BQJwIPisuv1uP87+HTY+ljoG9Y7Qs6x9OWVHk+XMMg7bfM7Paq+OEggZ/+FGwe7cCfk7x8GzAWMOHR7uKJ1UEmpl/wJnm2RoBBZ+QhWHRcOWyxAKE6kyvog1lnEnW20xCalt/FB1dSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeM4a0qv2EAFfd0UPuBotUueDOH5Q1bDea8n//fc7hU=;
 b=RG5s9psNXCqCBRFfab24YZFngk/XcEqKKkSZvIIXkAhwZhuTkeY4UVC1+elA7TG1JQ9E7696qDH0qBUxEh1EYo0hlX1PFFY7nzdea0Lvii7u76yeh5cV0Qckb+lD9KlpNsU3pXUaAHJGwA0mlafL89U8pl2/ObCOGMCdnr2F6Y0wyFd6fbJing2hcfSWy5bjE3eiQZlxPVsHXrzDYYtIYhtQaVVNeo9UPq02zVRUPibel//ZdbsyDkoVG2AXBa574kItID49O+wh5QBA29RNdr6rgY8abOEnwqJUCWdhoLtCn8FlAwsMQZBfYgw9LEz+z+wG9NKw3l8yZonpUCCK9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 06:48:42 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 06:48:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 15:48:39 +0900
Message-Id: <DN5SJKX0FEWG.2JDWL46J9ESV4@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] gpu: nova-core: falcon: separate staging data for
 DMA from its location
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
 <20261126-boot-rework2-v1-4-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-4-99a1dc6c7cc4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: af7c52ae-7058-4fe5-d1de-08df4c5279a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|4143699003|18002099003|22082099003|3023799007|11063799006|10067099003|56012099006|261102123227099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: NPhucYv84tXYnNjNJ+uvpWMI5+JwEEs4jMfWGDsbnIP5LXfrQseY0lDmoarbiHCN3jE4+ZZDUUP8n3UizDXKRUvRyk4iZ2wwvaKbo7LP0vO1Bp9bABZTGG9kbn4Wpyl2L7YjbnmRmmYEsuU2LePyY60IRkPkfNFgu5X7r/3PJLFjRp8A/i0MSddeAA7xldiW7JtTGoixUDm/llU1PRu7iK+CManX5ExPXtqKJ1h6g0bSz5Tb0EKMBO0jWQC9ytChYSX0FcvBzrRg9sH796ELjV5N3k7PmxwE84uUrFGCHTPOWvn32itOU9q+o2AdVRUT5Lzjh3+jYR+QKUyP4c0gMdWL4CNtyIUyDM6nUg1GRZyoeeYheMtDumc5FX50MOLH55kcF8aNSA/Ql9+fAvQu9yyVeZzKF1YHTlFKZcsFGcjuUJ07pRbOOEvQpXdytB4ecO95dVbbQklMTYZVzO3b9rPNMccdPNNjpjMl9uO1RRTzNRXLXcF+g1yR89ltIZROXnH218ktv5FpbCmCCVyll2SAh7R3+sH94/D9ObQJPSeh0qiVEboQiTcmDcGlHw6CWrjQOsw6/lFyshil2GlAcTpaHY4GizpXOIMlFnAaYPqSxzuJtvqzXmPMPJSoM1Mh6lSTNL+Og89H+na/1vQowH2hGUkM5zkQY3SCXFQPvV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(4143699003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006)(261102123227099003)(261021135927099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VlbkhiTGpIcEErdmM3THlBT0lPOFNKVXozYU1UK0JmYWFvc010dDFVM3Q0?=
 =?utf-8?B?aDRTMHZQbFZ4MGN3THhieGcvWFlCZVlzSDk1Yy8yYnovNHZucnZucVIrUGF0?=
 =?utf-8?B?S214Z2EwekNwZXRuS1VWM2lEcSsrWTd5M2NOdlRSZFBPZlE4SDNBdUhXOTAz?=
 =?utf-8?B?WUhmYkxXbzY5ajI4bXBiVmIwdlZjRVA1SmFnMGlySnNHWTQwZzQ0RGZOcGEw?=
 =?utf-8?B?WkU5dUZXd0xFTlpCeVcwUWtXVC9VbVJvSWVQTUZ2MmVXUzNUcVRmclorUzdL?=
 =?utf-8?B?SWRCVGtrekN4VWEvL3c1Q1BuQnlzcFM5c085c3VzOWZOcjRPcXIrZEgwdjVy?=
 =?utf-8?B?UEY2VEpSTmVabEswQmRKVTcxaVhjM0YrMGxKWkhYenRZRUlobklzb3pMOG50?=
 =?utf-8?B?eUwxVDhQVC90M3FlOWVVd2FzRG81OHVjQ1hhMXVwNE5ZYm5zQzVETFJiTFBE?=
 =?utf-8?B?K0dzaU1Fai9EdW9wcmVnbjUxanY3YUE4VUVpbE1JSGJDRTFUbEJPM09oei91?=
 =?utf-8?B?OTlGaVM4WHZ6Nmk2Nk1ZK05BOXBaTEQzTldnTkhSV2lvcnJYZlZtSzVZQWF4?=
 =?utf-8?B?ejJLczFZaDVyb2pmQzRQUE5zVFF1cklRdjhkdEl4Zmlydi8vSXlDeXBNbEdK?=
 =?utf-8?B?Q1JxcjJsT3UwbUlkQ1IrejMzRGJyd3ppY3B3OE15Z0Z6cC9oa3pDZmZPczF1?=
 =?utf-8?B?ME1zc2dWYkM0eExzNm5NKzZ0eDNYZGJMbUNDZENYMkw4SHlud2QwbVQvSkZy?=
 =?utf-8?B?ZDlQc1JlaW8zTkdiSDVyaVNlYVhuWDdKcXgwVncvR2ViM2Q5a1FseW1ickNj?=
 =?utf-8?B?YVhtai9FVlJSSW9sdzVva3RlY1JUYm1wem5BUmdvaHRLazhZUlVRNngzR29O?=
 =?utf-8?B?bjFkQ2kvWGZmS1B3SW5yZmk5Zm9KK3NhbHVDM2p5RlZwa2ZqRmtaUXFhbGVm?=
 =?utf-8?B?QUw2ZFdRWll1ZXE4eWJtYmtaSHJKTTFoVWc1S1hiS1p0OHlhMGg0SUtrWTl0?=
 =?utf-8?B?ZVZ3SDlrQlBpait4UzFZUWh6ZnVzektsWVI2Y3RFQW9SYmZUbFlyS3l5UEE2?=
 =?utf-8?B?dW9GYXE0RVBTeFVxVmZwTzFRZ1ByQ1lFZnd5OWkxbUhCUHFVYlErTHNMUi9n?=
 =?utf-8?B?d3dGS2RkVUo3R1BHTjJHNGp0Y1BGTlJKM0N6d2xwSWNXbFBuM3ltR1NXNFY2?=
 =?utf-8?B?V0NuZGVUWk5FSXhya2FEeWZzTnRlSk91WFJiNmdxcnRabWJpZUp2ak0wNEFa?=
 =?utf-8?B?OExVOU83VVFVYUplUzcxSk1DQTV1ejl6VG9VVi9FWTFESGZIZUpwRG1aV05M?=
 =?utf-8?B?T3NRVDlJYTJPY0UveUNqbnZQR0dyR3VLdHRsYW03eUxDM2MzM1ZVR0tlMzAv?=
 =?utf-8?B?K0RBclJtVVBCaDZBaFIvWnpObEozbmNVcWpGcWZJREFuNFVBNFFmMVdPU2ow?=
 =?utf-8?B?WWdSRmlORnlWNTA4blk4VjNqUi9qT3pRZEFEY2NpdnNXdXRzcXExTm1IbUpz?=
 =?utf-8?B?MmYzM1VsVWo4Q0tkeXR5N21WRXRNZmxWbzNVajhaSUlBVGpoVmJkVndQUlgr?=
 =?utf-8?B?NURUMThCMTlzcFZiakNEOUZYa2ZCOHFDeTZWazFaaXU0WExqdHNpVDZTVmhS?=
 =?utf-8?B?UUVkc1RhSklDYkJLZklEQjJjU2ZaQ3UrVUkwYU1pN24yVDVJSUFjWS9ONUcv?=
 =?utf-8?B?aU9GZG9rUFR3OFRnWG9KRHppblhld0tLdEs0SnpEM2o0S2dmLysyZ3p0RVhk?=
 =?utf-8?B?SzJzV0hYcExLQ290RlVFSzNKSW01cStkc3RQc3FrNlJrTC83dTloUkY5bncv?=
 =?utf-8?B?NjZqWHhPOFcraXRsVVdoUS9od1FERk03M1lmdVhDcDVNa2NTbmtadC9sQmJh?=
 =?utf-8?B?cEtWa2tCY0szRTVvNzlzRS9zUVRLZzcrRUJWZ1M1dUlFdzJpZldTZmxrN1JC?=
 =?utf-8?B?SmU1V2FXa3JUVTFHQ2tPZGdpVEJKd00wbXJYNDlCbXhxd3p1cHR6U1ZUa3BP?=
 =?utf-8?B?VXlZaGFKRFYzV1FONnVQWlN6Q09YdGtmTnpOQlYwN0ZhbjRUMkV2YU55Tjl1?=
 =?utf-8?B?dTdpdUpacHFUZHIwU2RqdjJiU0V2ZDNVVW1wZjlzbDJjd0Z3eU8wMHRzYWlJ?=
 =?utf-8?B?STNDYU9KKzZZZW5KVUhIK2NqUzN0a2tEdG0xQnRQZ3pVSU9KUVM2dkNvVmdU?=
 =?utf-8?B?RUtIVzRMMjhNajhvZFJ3T0xRaTZOWG9Pc3gveDNNbFZ5MitIQ1l6UDRiRGto?=
 =?utf-8?B?T29IOVdPekY1VVJSQ1VWSXJiTlh5Z0kwZ05uQ1E3TkI2OWxrcmNMbmlSbmdz?=
 =?utf-8?B?UWx2M1hrRUxEVUtJcXJlL1NOU2FRQlBEdUFSSXZhcVJNM081SG1CSWQybkZ3?=
 =?utf-8?Q?yQcf84ORMipFpY6xf550BKZDF9albDED1bfncKmv3jS/B?=
X-MS-Exchange-AntiSpam-MessageData-1: z+if35kAMt46/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c52ae-7058-4fe5-d1de-08df4c5279a0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 06:48:42.4976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC/cE01tDes/qC3LvfzGx6zQtWTsRcmiG6XFuQdaIsbe8SjGZhZywG05vVD6gurkrvOe3GZejgWrNpgJXIbZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 5:20 PM JST, Eliot Courtney wrote:
<...>
> @@ -208,6 +198,16 @@ pub(crate) struct FalconDmaLoadTarget {
>      pub(crate) len: u32,
>  }
> =20
> +impl FalconDmaLoadTarget {
> +    /// Returns the data that should be copied to the falcon from `blob`=
.
> +    fn data<'a>(&self, blob: &'a [u8]) -> Result<&'a [u8]> {
> +        let start =3D usize::from_safe_cast(self.src_start);
> +        let end =3D start + usize::from_safe_cast(self.len);
> +
> +        blob.get(start..end).ok_or(EINVAL)
> +    }
> +}
> +
>  /// Parameters for the falcon boot ROM.
>  #[derive(Debug, Clone)]
>  pub(crate) struct FalconBromParams {
> @@ -219,6 +219,21 @@ pub(crate) struct FalconBromParams {
>      pub(crate) ucode_id: u8,
>  }
> =20
> +/// Denotes where the bytes of a firmware segment are.
> +#[derive(Clone, Copy)]
> +pub(crate) enum FalconSegmentSource<'a> {
> +    /// Bytes in system memory.
> +    Sysmem(&'a [u8]),
> +    /// Bytes in the framebuffer.
> +    #[expect(dead_code)]
> +    Framebuffer {
> +        /// DMA base address of the segment in the framebuffer.
> +        base: u64,

That's not technically the base of the segment, there can be zeroed
bytes before the segment starts because of tagging as the falcon will
add `va` to `base`.


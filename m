Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F2CC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BA310ECC0;
	Wed,  5 Aug 2026 05:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAHOkMYG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDFF10ECC0
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBk7L37rVbxryVtHRIhsX3U0NoUIsncXGCowhHZQlplRYAkE84b8J5ZLbUk/Ca4AeHmH+RhkcdI51bxyXUnLH9L4QjA/grf7PREIPkExvPjRerwVoIIBRpcZqKfE822pO6V4m/QPNjY50H/kKQVifAkCYOfRP//0sjFBXxIczujYs/Pb5/iDf6ctb/WRxhoZzHPCzQet4d/Jz5E99ikSxeRaNGvO4qfreMP+Ou4cgQ0Bcjp2n6P2Gz488w2fcxoxEkZviF5hVPJsNeOUMBBghATUkm43XtjH8quvrILO5gqSbBRWPmffCS61GuEdg3btt+Zn0WtEORE1qr8kw2+BXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n96w/FstKjvwZkYvuVbB8JZgxD7hxC+y+t1AcdKR0/k=;
 b=wIyFg6QXx2COUge5tcdD3Ql/x05fG8eF5ggPuSHGOCWbsltzb5RJYqYB23d9EkJ/qpZ5PF619mkeh62X770BLZRKFLxyta2h/EfKhcM8OyquZaMEkaQS5KpthtlcFoBaFSENVUwaGFic7/0QE8sNw578HjiTH1nwD0i3vn8KHZQEAXOYKuwMfk/YfzmmxXHvjcO4TAMdzc4wRHoEPddCPD0SwCHD1N6NJu89zDOeT7oK9DMnz7MGipzQ7HgBDIvxppKpTd02hPUayay6r3uojnblLSfxX4gI+DRs7xYbVhc0h9zQyZpfL9ESiyHDyzfbKxBpgsK/779rfXjnTHRutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n96w/FstKjvwZkYvuVbB8JZgxD7hxC+y+t1AcdKR0/k=;
 b=BAHOkMYGznYjHPbXQC0xk+c0Tm187YgRZtHCHWaLy5Pydn1VgN2q+5XzJgcShJ+ifiPLuYrkl/i9q8H059jJsmeHEUhykMAD/s4N/z3/kDfGSrKWCWpdtfooOGEob9Y6Kk/LdNx9OBIM51ZEtJHFw7I49DmaG6K4uBuiFJFPfGx1+DdaLyIjRUEPr6SumqvzSD+D0FiSBKrUf4DeQ4KX5RMuwfTm/gtdoaDxBFQEqWnPUSUh5fRCtYp3dt43ozE+t0FChTB9u6pqRVvP+EhjWsriKoYJjNuQwTi8Q52i/CODi03a92PyjgD9xgOW6UEeEqAUe2an8u/joSX+1u9JWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 05:48:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 05:48:56 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 14:48:48 +0900
Message-Id: <DKGRVNC5Z5DO.1HG4P13U4UJGN@nvidia.com>
Subject: Re: [PATCH v4 0/5] gpu: nova-core: blackwell follow-ups and fixes
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
In-Reply-To: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:405:370::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0e04b4-be2e-45a0-0b18-08def2b53d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: CqK9b+Cwa7Mgyp8+C6ZisusaKtoFVkvCQ3Wu0PqTXnY1U9ICr5R3vNHAWh4yz4Q6RYhdXzHLoq/zvVWT2a1e41aLHb3as7+NwzbsowyBSTMbDnVXmtOCa+qXXYC4Y9KB/6T+dj9h8JxB5YmoRJJPJdIulXZweIJ+1pRGsv1/HvD3SH51jB+EStOCJla7/ZyJ1EtncnXSKqgccKMSDGccLaAyh69fzTZlDBfWe52XX02ILgLgiorPBlTDvZquDtao3Tdtu9Ut/LGIthRQ6Tw4ghIl3jWVrIgyY7N4s1/OXpP2fLEIHvC6aSsWGnn/AYwYieiIHV9MLIWr+y2LBeaS3VPGCcnNk7TmaaqKCpLqhPcXibQ9K4mvMNKkvM82025FCsjYPFNbgcCDhPbtEi25EKoa2oDcGXqtaJ4+RkY/JBbiXnxZnNoHQBWTk5AWEHXK1HXB9bOMYO7eK15PneSONho9+SwXO8xP9iYYsMIY2DkwdPBY3fXLg7K6ulPBzd+RweiXuUcaM2dX2PKE930jSSgi4qG8PvfwlTgi1eCdl/x7r3Q1FD5ea59QnNbvRdN/2t9dqCe7tPS+Tw+8MYupH08bAHRurM8xo+US1KQacsSlQyxPPI36zszIWNKypVjXdRnAECVR5RHGQTtzJRmdCFQ5fTbEPgZ0kwyjohJ76ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJqYXR0QWxCa1hGTHlObUVLTVB4UkxFbUIvbjJVb1dHR2RwWVBnRjVqYVha?=
 =?utf-8?B?YjkxQnM4aGt6dGlGRFM0eVg0T0hMQ3EzSzY2MG91ZDl2cUtXNjJkYkh4R2tN?=
 =?utf-8?B?RDBMUm9NUEZRTjlKTnlCTVN3T2RXd0tEUzFXbkE3YmpsczdsZGViTm8yR082?=
 =?utf-8?B?cVpOT0dkcGw0cmtWMVUxdE1FS210VmxKMFJMM2lrTmdFbGQrdndmUnRBWUpm?=
 =?utf-8?B?U0h0cmgwakZ1TDhJUnZtSW9hc1l3VGJ5ZUEwYWpkUnZnZ0JYYWI0VzZVNi9O?=
 =?utf-8?B?NVdvblRLekdUOERUN2gvZW80MUNyUU0va2FEaTNaVFFWVmZRdXBOSVRFM3FG?=
 =?utf-8?B?bUZYbDNRWXFWTDErdEsvSXdBTW04TVhDYmN5Ri9UNG1yNkVaWnRBdjhiUWtk?=
 =?utf-8?B?cmo2azF5K1pzR0NlWXJCWFhOUkxEUmRNbTdwUG5KdmpHamdJMUY0TkgwVzZJ?=
 =?utf-8?B?MHFCOWJFWVNHTFhNcUVtSFRHR3RWc1JXOWZwbFJlTVJWVEpuekdkSmJJZ3RG?=
 =?utf-8?B?SC9EQXdLOS9LNGVWT3pQZEJXbDh4WHl4eFdEcFhYZkpGdWpHMEFqRnRxVm1Q?=
 =?utf-8?B?YXpSWmFYQWpYVHN1cHYvcGxVeGdFREtBalFFNWw4QjlEbmVNVCt2ZWQ3L0VV?=
 =?utf-8?B?dHphQ01UcGFpVVhXSlhMSXBXMU9lUGtmTTVob2VidXgvS0I5Rk1uaTFQZnBz?=
 =?utf-8?B?OGxoMlBIR1pONXdsR3NwUGF0Tk9mOHpwZ0x3a1VneFpFM3JiU2V3QjhVb3NG?=
 =?utf-8?B?TWdzMTdVcGRidXpEUWNJaVJyd3pSVGRPMTVsVkdnSTF6MjlTdno0Q2Rvc0J4?=
 =?utf-8?B?UURjVUVua1d2ODBKbDMxTHVvSVltWkxuNy9OcmZFNDhNYzBJSUhNSVZja1hF?=
 =?utf-8?B?SUxYazdOZkgwYXNZK21Cb0pMb1VNN0RmRXRqQ0JJZG5NV3ZNWmhOZXBrZ2ly?=
 =?utf-8?B?Z3owUW9UNDJCZGtqaVBRZlRUN3pMZE1FaFg4eGtpTDhyRStTTC9XeEthSXcz?=
 =?utf-8?B?bmllSGxBV0ZtL2NscVBsMEF5N2hJb25wa0JWamdJY0JJZmxnNG5oZHRsNzUx?=
 =?utf-8?B?S2FuYkVyaWQreGxOdVBQeTRTZmdnS0daN0U5Q2lzOFBQSWlzQ0VSbjNpbGRI?=
 =?utf-8?B?aW1pVVhMYkRCdStPVG5PeGUwWUhOd1V3dVR5QlR1QTEzV0ZuMGJSWUpWU3dG?=
 =?utf-8?B?UHNOVUJFdzJSSVhsVDZueEpKYmVhTW56Y0VVMVlLUWxGNjB6QlgwRFh2d1VR?=
 =?utf-8?B?N3NBRFlqbGtrMTY3V04rcWsxemZIR2pDeC9ld2V2YUJDQlFlS0lwM1R0bzhj?=
 =?utf-8?B?RW1tSC8zUFc4M1Y3NE1jWmQ4SFk5SVBzc1pKTXF6UitNQ0VBVVpMRXlBNGEr?=
 =?utf-8?B?RUJ5bmNFMGZvMWs2VEdOalhaSjVFczNoYUZUN0VDSEc1SWhOamlwU1Y1bVRi?=
 =?utf-8?B?NXBBVmhZOWgzM1BocVBrTGtyeWhycnZYZW15UXFXMmZRRW1JeWQrbS9rYUJR?=
 =?utf-8?B?cDdlaFViWTNGRklYcCtXWTVpeERIaUpnVkpmVE8xUzZmRXFIdzZuZDNrUmhR?=
 =?utf-8?B?Y2RvT1pkaVp3VFcyN2cyUGVWeWN2TVhuY3JEU2VjUno3U0VsdmRXMm5pVzFy?=
 =?utf-8?B?LzQrZGJOVjZYYm5rT0FTTFNaTm1CL1dMRUtOa3ZVMFUxSmpmL3cwZHpDbEg4?=
 =?utf-8?B?WUc0MExTdnY5N2JCckhZbzJlTGt4YW9Yd1NNUjJKcTlUSDZQaldIYmVKK2RV?=
 =?utf-8?B?RmpZbXMzWXlmMHlQbHRsOXdZNFBNcGlia0E3V21EWGpld3dwVWFhWFc1WVhP?=
 =?utf-8?B?eEROTUtYb09DMmFNRWhaOS92eG9yaStsaUpOSG5hNFlHbjA2OEtJK3JpcmRq?=
 =?utf-8?B?ZXRjVWFCMXduZk5KSHVOYUlPTEJhVWloak9NbXorUE91Z0JXSlRqNDIvSzZ6?=
 =?utf-8?B?bE5mQ1haQjE4ejlacWM4SmgvUmRmeUcyeFhJVHliMWpvQUFDVUZoc2ZpNXVx?=
 =?utf-8?B?TW5mak5TNEtOcHZJRTE4NkIyMUVGekRVRW1WOVo1ajFmVytqclZRSTVvbEJr?=
 =?utf-8?B?OTRNTE1mc2FYMUJlVXBjdGRZODNYa3Q4WVE1dUJnTmVxREdtSmRRdXo2ZTdq?=
 =?utf-8?B?ZHFtWlhBR0tOcDJESXBrWVNGYUlnZjBhRHk2S0hkY1VTUUhjeWZhMENneEU2?=
 =?utf-8?B?dGdHaVMvTzNwWExnSXg0OVU2Tm9PZnVXTkhVcy9VZ1JPNFVVcjJZRkNIbWJj?=
 =?utf-8?B?TEJEeWs3UzN4aUh6S3FEMk1STzNzaFl3dExTdWVJWjJjeEhFVHFSUVZvb3Ns?=
 =?utf-8?B?dTF1L0c5YzkxSmkzWDRpRGQyaG43KzJNemE1MTY3ZnlVd09scnFHV3g1SjRp?=
 =?utf-8?Q?gZaBeq4yx/BxMTXq7FAnPoq7qD4wmt+Z56XgS++j//3Jc?=
X-MS-Exchange-AntiSpam-MessageData-1: MSnfM/cBUV+vtQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0e04b4-be2e-45a0-0b18-08def2b53d2b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:48:56.5184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+t63UOZT7lP5vp2oLr+1+wR5wDl1L5yGb9RNEPS+/E3Ay21wbJJTgXy6X7mcsrizzLwLRu6ceg2WtRDpNMmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

On Tue, 04 Aug 2026 14:41:11 +0900, Eliot Courtney wrote:
> Make FbLayout code more obvious and correct.
> 
> Currently, the frts vidmem offset is calculated based on the non-wpr
> heap size and pmu reservation size, but AFAICT this is not right. The fb
> layout actually looks like: | non-wpr heap | WPR2 .. FRTS | PMU reserved
> | ... | VGA workspace | It's just by coincidence + generous alignment
> that the values happened to match with something more like pmu reserved
> size + vga workspace.
> 
> [...]

Applied to drm-rust-next, thanks!

Tested on TU106, GA107, GB203 - all booting and unloading successfully.

Edits on patch 1 done after offline confirmation with Eliot.

[1/5] gpu: nova-core: correct FRTS vidmem offset calculation
      [acourbot: add comment clarifying reason for testing pmu_reserved_size.]
      [acourbot: make fb_end_reserved_size() return u64.]
      commit: 5c9deba5578db5a3ea05be8a3e4a59ecb08ee76f
[2/5] gpu: nova-core: rename heap size field
      commit: b2bc53d34435043001223cbbd9429b0b6d71bc59
[3/5] gpu: nova-core: return non-WPR heap size as u64 from HALs
      commit: 744e168d62fc50b362a4835f77feafd417b965a1
[4/5] gpu: nova-core: split FbLayout into FSP and non-FSP versions
      commit: 6e46097f4d616a0f81083ae2c112efbb1473539e
[5/5] gpu: nova-core: pass WPR metadata ownership to FmcBootArgs
      commit: 528aef3a4bdd85137de9ec76bd02eacdf8160bb5

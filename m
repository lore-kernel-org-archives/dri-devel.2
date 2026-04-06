Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46353F46C66
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 19:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7C410E082;
	Mon,  6 Apr 2026 19:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWC4zfjS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C255F10E082
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 19:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiVc9UR0RfX2Q7dJ2YVQdRHMReearrp2VKju/1ww1N5bcyM/YKU1DtDK6nuRwQzm6VWT8QxwqWCj1JRhZJYHgf8qdS+Ydq70sJR3tX3uDCRHjuCypktrMgp38Fnb5Sb02mtAttn6XTuP5DKoAYvYwHy3V0EkkZx8+mI1AJyJTxYOsYAtQ76VGfjgiiVEHuoIS/h6MCXAUoc0N04r4l5cP6ZZjzsE9J9L/z/Fd2Fadu86WBsexB3+ygjBgoKKJjJBdmqXgvbhLrcscqHQ3tNKV6zjF2zkULB3SZKi7JEBu0NJQVsrfuqcy+dSyH2hcjcqLmrDy6wfVnnoAcbkCHa2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5l4fwcbKT/wJxetqgOM9zaXc+Tt5mL8QiyaDD9agvg=;
 b=W8XBiMCFl7pq1sT5XlydDd+1KtCuxnX7Vur57xJElymcGQiZlCgB4Au87XZ5pzwxJwa/QgOPJmS/o43NtfnuBcHxHgvRWAMpgniv8SSPEY4h7kIimop7k1ERt+MA09XVznKdFSi1zvSdpQ/J+vLqAUHV1N4F16XOJ239pFmNmq/cGpVXxf3lxKsKDagCvorZZDjmrYXP0j5L23woqyAB2/uOfh15QY99MwmRA5WKN21252rbghKairWf7vThDtUso+OWuNTG5GTFN6hPpTen9C1i22oetcNG/VEAHKk7RLGG0WAOtlYZGRyCyyXSwtzbCAH5RsG3QTOdCIAzK/q7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5l4fwcbKT/wJxetqgOM9zaXc+Tt5mL8QiyaDD9agvg=;
 b=XWC4zfjSpjVIpspJlgNbeFa8P9/wqYtMp4nZVZr3MSXKpeK7+0q4LDBf/e8je3pUL03Cut2LdhiYUQYh2abBPisRN/ojdhVY0FtL/H6O+UreuEQvSWzxmz/Hwj5NNw1HHlaT23jUIiKrt6/Mb7OC5erBA9J/npW2bvF6rtwHF0s3roEvQITFyiIv9yJF7RdzV2a4w1gxs0XXNhYy58OgJDCBDdTy90cGo4fCOemMdbtMerMWL9e6BW1SMY7TWyE6+mL+ufgRgSBidkTm2SMr70sajUuiIy1vsKREb5Zhqcmy0eq5YBsiGmOuxHj19RhzBQ7vZyZExz3WQN1UxTO4ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Mon, 6 Apr 2026 19:06:01 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Mon, 6 Apr 2026
 19:06:01 +0000
Message-ID: <f776f9ad-8788-4f34-b929-0ed3e9d158e3@nvidia.com>
Date: Mon, 6 Apr 2026 12:05:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] gpu: nova-core: gsp: add NV_STATUS error code
 bindings
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-1-f3101093484e@nvidia.com>
 <fd010f7a-6d0d-4faf-bdea-23bac608f03e@nvidia.com>
 <DHLY21KWINJP.32YXNJEUXBE9T@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DHLY21KWINJP.32YXNJEUXBE9T@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e91721-3122-4704-4dfe-08de940f8b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: FO4dtE+JevFqr7Kb09xAA+j0LcUVhCFnNpe9aukKkwUD8MAT3yFwRo4zy/iamD3FnU0uJOan/qfmfnj2nGTE8TINoPYZ6PN2MjSiWf9tQZwhnXCBHLivZ5/w+u+fypMa2zPfFk8Ti18bRyYt5JzWk/h6c2DWNci4TlBXHh+mC5m7zrYkITFfkpCBNj+o9sYwvb/eVeVxk6xgzRj2ZZ/k0UU7qYiVONSxx708wbocbk19+/lSKq0fT9JbSpYQ1+j4lmMP+ZaO3e+7dU6dqwrTl71DUvxjH+yWeiJi9ilMu4+vSLMLCr6q6OjOscmxrNG2NAhINqI+EMoFJeKyEy7sRy/635gE4R3hprQ3WbRGeby+ymJKLOB6OlEbftSf6LRoOR1+VKGNJrML0mZwfFUp70r/zFnDw2U6JUOCOgVvi3wXnK+bJ8ZocJNR2ovQAA4gdZ5quKYzuZKvR3eWwsvLx37KXU81XbGbvs0lHKMqhOmOnPwTklevmci1FURj7mjpjakBAiqCaa0/F1qh06gVecrWuik3Bgzv9RV03TIaktjA9rLC4zE2RDVjpOQLaOwyZB/uFuwc+bFNMgEw3j8XEbN8SPPPpx69gXh3U5rxez/F1Y2G61uEbrpHD3B8zWqcXuNrLtJo9K7LiG8j2/AiSUFoyhEKXJ1jLHw+eRHAENfaowKKjEvDTxK6VbAmr7h74Oi+B9+kmrXwiB7f/p6q9iy934gvXp8X1JCqJaTaHVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZ4a2pzQ0tma2VibU9UZks3N0ZIalZQUlEyV0JBeGVaU2FnUy95SCtPbzdl?=
 =?utf-8?B?Slh0b01PdXA3QzNWTXZkK21uV1U5RVNnbG9xaVB6bWdXTzRLQnJoRm5GME04?=
 =?utf-8?B?QTJGdWNLUXVpNm9hd2lWSWNkRFdhK1EvN0RWT1BmMUxVMzdTb0VTMXE2V2hF?=
 =?utf-8?B?QVZERkNpdkV0UlZRT2g2QTcySWduQmJxM3ZRM1RWUTl4QnJ6ZStDS2VMTXJW?=
 =?utf-8?B?dldvd0hSMlRaY3JVVm5wN0dTeXNhTGl2UWYySGpxaXRtSHo5Q0pVR1cxdlhK?=
 =?utf-8?B?OXFWdkdqYXNmbHZpZ3M4b0xBQTFlQnE3VXRsS1FTRnFsNVFCWmxZTEJJM0Rj?=
 =?utf-8?B?c3ZKbFlyODNKckdQOWV0WmI2eXpONjkvaTlkeFFSSnk4b2YxQllCV2xLVmQy?=
 =?utf-8?B?VzJUUlUvOWtoTmpPNWYzNlFqT3dSRDIxdi9qSmE5eVA5UEVJV1hyL1FkbUZ3?=
 =?utf-8?B?V2lMTGVhSkdFZjhhakg2ZytRNkw2YUw5ZFZmUlYwbUQyMzh3MHVtcTMwZ0s0?=
 =?utf-8?B?STB0ZktzZE9sdjcza1lDVUtDK3NiTkZQU1hEVkllekZ4K1l3UW5IR3FVZ2xZ?=
 =?utf-8?B?QW84RW9IQU43aGZOR2p6TW5xOHVBOUhWamxHZlJiSFpqN0NCTVA3Mld6SHpH?=
 =?utf-8?B?TFNVMTV4RUlBc1dtcks1RGREZkdDNnA0dzVvVU5zSzhkUDBlekRBMXh0RWlt?=
 =?utf-8?B?cFVuMzlUaSt1d21ZaGJqUHg1K3g3SVIwQXF5cjI2eUtNTS93Q080OS9JS0dx?=
 =?utf-8?B?SmpkUjFCWmlNaFNkSmJOS3lMTVJ4elFSdG5GeUwvWDBkZ1ZCNEh4UGh3bDBs?=
 =?utf-8?B?akFJdXcvU2kvRHhHa1dac2Y4djRUb3ZaMlBlVWk4TVpnelZZajc0MkNmYUFI?=
 =?utf-8?B?UStYNzB0d2xNYkdHQnNHUjhRSmYwbE5nWE4zdEw5OWJ6UVc4Tk5DYytNU3A5?=
 =?utf-8?B?SWk5cjZUbVEwbFZMVUJMaG9aUGtIbVRNSWZObnVydFZpenVVeWw0RTNBQmtF?=
 =?utf-8?B?ektxak5POVR4dnhBbUsybW5TTWVRREcyNXBPZkRVUW9xQkc3SWRzUFZjTE14?=
 =?utf-8?B?eWpWUkVvcThzVmZraWpDTXB2TzE4UWJwbkpDR3kwd3RvT3lxOXFrNnNVaXlH?=
 =?utf-8?B?QW90UkVGbXN4UnUwYmJ6bVJ0ZWFRRlpRYnh0NXdvYlY0TDVhU0V2S0NBV2RQ?=
 =?utf-8?B?dnV1TjlrV3Y4dFNtR1VpY3p3cU5QUVRQNmdFc2szbi9VeDFSOEtjdVNmVGdh?=
 =?utf-8?B?bTB5RzJvQXNBSU11V1NBam9jall5bkZjQVBvYllMMkFrSmd6S08xYlF1aVlU?=
 =?utf-8?B?clhWdUh2SVQ2T2Z0Y3pleWJIa0p2UmZPMDErV25yTnRiL1k5bUI4VzZjejY0?=
 =?utf-8?B?bVNJc2FjWXUxU0lDUGxJaVNMcXRSRElHZmc1RDZOdDZpTW0rbStEK3BSWnpE?=
 =?utf-8?B?WEk3YW91RHZWY2l2QW0vQVgvVXdOYlFiMmxydGVyOWRuTE80bTlqUDJjSVRu?=
 =?utf-8?B?YnJSazdIWDZvdnZaY2ZFUGZnTSs5L0pCcURXRlA5WlRPUk9MMkpsTlg0NWxs?=
 =?utf-8?B?UUN6azByTTRNVi9MeDdnaUV0TDNERGowZ1dIaFpjT2Z1MmNaSjdOWHV2c29t?=
 =?utf-8?B?a0VMYVg0NlVYRmdwWVpKdnlSa085UkZpUjg5OXA1ZHExb0VSdUljLzlsSW1T?=
 =?utf-8?B?a1Zna0UvdEk5L29sL3Z2SE5rajZWdFZIWTgvcWUxMTNsUE5JRThpQ1pHeCsr?=
 =?utf-8?B?aWtZNkdzOXA3dVExWkkvcE1jNm5iTDlRQ0VZQTRDTkgxRmdNdkVmUHFwTlhh?=
 =?utf-8?B?Ty9lSmxvNWt2cVBDZ0NmdngyYVNPdVFtSGRYZnNJZEtEd0FnZFdxSmxFODJN?=
 =?utf-8?B?ajZTc0tiYnlJWEQ1ZTBvQ2ZTWmdsMXRNdStwdWxxQWZHdVExWC8yYmtjcTFO?=
 =?utf-8?B?NDFnL0dEVTFQVmNJZHJRRlZDWURGSFdLZzdIWVd2RlhRRVB5bERVdDMzK3hX?=
 =?utf-8?B?b2xmSlUzd01OVkh1eWUrYlFwbDF2OENCQlMzZkFKK1EzRXNmL2tYRGRKRWJx?=
 =?utf-8?B?bm1rdXRVR3JTQ0dvdXY4amQrVUR6cWZ1SFpvKytYbXQ2S2RlMTUrTVo1V01w?=
 =?utf-8?B?b2NSdnRNN004NFlvb0UvUkJtTUxNOVY0bmdlaUF5YVRiNGdQUFJGKzIrYlM1?=
 =?utf-8?B?dDdJaDYzNjJPUFZ1MytiUk0wdmNTUDhMTVhZTVhkWVJTbUJ2amlnS3dEeGJ0?=
 =?utf-8?B?aXEvd0M2dGQ3K3NKVHlXNVBHTDZ2VStUR0pNR0w2WjlmRkZnN0NwT2lSQ3o3?=
 =?utf-8?B?M0hodFEwRjJUTUhjUjloZmVQT2R5OFQyVHVTTW54c2N0SHpmcC9xQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e91721-3122-4704-4dfe-08de940f8b2b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:06:01.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c07t5/nCiAWfp/czft0G3xlL1Yf4Jr74n0bATZeMHiAzV8/+QF1zNm+TRVBp/2PaUW8Zm52DIszab/P3r5u5ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

On 4/6/26 1:54 AM, Eliot Courtney wrote:
> On Mon Apr 6, 2026 at 4:55 AM JST, John Hubbard wrote:
>> On 3/25/26 5:13 AM, Eliot Courtney wrote:
...
>> Which brings us back to a feature that Alex Courbot and Danilo have been
>> asking for, and I've been treating as "nice to have, maybe next month"
>> for apparently too long. And that is, generating Rust bindings directly
>> from the GSP-RM build system.
> 
> Sounds good to me as long as we can generate this mapping at the same
> time and have it fail if a new one is added.
> 
>> I think it's time, yes?
> 
> What would this look like / any agreement on what the shape of this
> would look like yet? 

I think it's a change that is inserted into the RM build system. If
put in the right place, it should be fairly clean and straightforward.

I'm thinking that it should be done now, before proceeding further.
If possible.

You can do it, or else we can grab someone with RM experience if you
don't want to go there yet.

thanks,
-- 
John Hubbard


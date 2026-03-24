Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB4F532C4
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 06:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C0810E0DC;
	Tue, 24 Mar 2026 06:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OmWZuzXH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F21B10E5DF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuBoIjHNOpO4gBy9OpyIJkr7xA7BZPpzcbAJr9repSlDo+x1spUPy7raVfpcvfxrC3a7p2lj1rABga3RadiX9w7+nvLiZsZM1pFMojQzkMZF7Q06YMTh7/SzsRCx0nBPXkZg1EP2oWCR38VkGTGBTf+U4twrN55WONpGTScW3xQDD5Os8LfQCAjF39Hg4I55+b73S5b46JUgvqs6fOtSl+TW1tUQ1uDoW7UPy2YCMIAIOfeS9UVi+++Vg4EXiWHIdaufgrXCbA68g/wD/Sah/6QyEJPimxwneeYRdtxF8eKm4RfhkGNRDloQ5q0u5Db0+bdPhLNvTfr58LbmLRUkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nzfOK2ABJDiqDeAKaaHnD5CPQs4Oa/r+i3ROiQKuQM=;
 b=QPHjK3MNfvNNkB8f5jc7uk0QiDp+vDcgU6/3WjdJluWCDbrhaOmHytzYTZcu6ub3W36+rDmdJZJ8EmCtIyJRsLmQEILIhUp9FwWoBD4ORRRJj0qXTiL3kKeSPHu0a3EQQmDcGsiU1djwppjtWQs9oubOJx/FMI99PoAgmXdJObPT6ayPB0fRitfq9lnRpmhiJ4ZQ5hq8GIyG1QR5hRBbKYKwPt2qG8VMSpE2tJqAI3mGos8vE8oO5Xznu4cN98atpVQmGgMpLbuzYfm/6jQMkqRfrb4Yp1ax0R+ZDt/exmFSHLRHDa1PyE/GcPeRAOoiFx1CTnPfeurLcDfC144mLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nzfOK2ABJDiqDeAKaaHnD5CPQs4Oa/r+i3ROiQKuQM=;
 b=OmWZuzXHQbWaSCOAkHfBPDBtK4JBmy3Ahzs3XPIObD+yp2IoSXi+waCayePxTQktmi/xNoZYCXvvoIzbmFh71W9KI4kmbH6VjtQxsnxDycmA4NvWx6MXZLz4vA+/j8Hun+dPbNKfGamzZBuF0GPOzBOmKYeIuPppgdz/avicQQY9uT/6p4UUkgrAGBLMntWZxEhaBZih50DMxfDAXq7VLmnD0P75wy/Bwf7x82oG84yQ4/twUhtNlGD0NUR0A7HqjtK2K1DDht4SWu58HvKmItDLcoOIKpZO2LKkbABpILKToQcvPlEFybM8d/a+fevKOmXzLsEbsZCdpBuL8kDMlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 06:58:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 06:58:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 15:58:40 +0900
Message-Id: <DHATG57FSPWK.2JHCQCTYBUEBA@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: gsp: move Cmdq's DMA handle to a struct
 member
References: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
In-Reply-To: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
X-ClientProxiedBy: TYCP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd7299e-2f54-44ff-fb3e-08de8972c9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: id42Jk0Ms3G8NJZO88H/749p9mErRacl2H5lsriL1kYHYHvoPjPELlbV5PkU+2RDnPSUORnyy9fAHvsWp2nZM9BXjofh3oHQ/Q6Gw/49rYht4bB+rvAh5LlK4tNo7QHUDRnk5fEcghxec+juZJ2F+1SEjpwkEm9HnWxjRsjXdqv/gpfT99mbn4SCEDjpWgIsprC3796hZxYJ1moU1JKYg4cFXur0pQ5YMofa5HJGakXByyTLMU4GfYzDDD+KOwkhppgwa2+mAD112SXoE3etnEWtFMCuubKOgn+jPdgj87+BcK7rUXozWMsmZmFeMQWJWpEmvLPllI4aQDKN3FAr7zrNemRUPkdTwwkeuhWuAkKlfARZMKgIv/C3qPUDALW4nPUdKyYjnjCdczE9/1adnk3YC1IiF+3bUYGIg7yB+uDkoajgYEedvOPthaxl/Vc7eWTvaCu1w+MNHnvswdilXUoWSkmgby7Re6xV9Q1krzCBHyzVtp1PP0ft3A7j0bsDc56OD7V5tj/ypuYRCZECD3ZRQ4GqDpiUB8yxLnyQTcJyXID2gMnlf0M/tK51vQNj//FKYwFam+4NYij8GSHUAgAEtT6ZS6oc60BDH6qZyBXz21oJ0YKgzzTDUxDM6yQDd+D2FvE2mrIpjUvw4r2Y3AqZJBpah72d5vXqAwgHKVdCgRfiKaispBSSTXtWIk4PKzthaCbYZPW761KjNOzooE6s9nAMxnL9wjLOLS6DZn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9remhDSTNjMmVaSUgwdm1tUHI3U0ptMjkyTUpNRUNWRHE4ZE85aHhncjln?=
 =?utf-8?B?cnFoN0U4dC9SSitueW5JNkhTQnR4NHBnUHdTZTY3TTdMdEhDdW40QWRIRlVw?=
 =?utf-8?B?SVRBVmFBSGZ4NXNSZG9xNGhEUzUzY2szemUzZ082b2pFL0p3RjNKbzhyMmpw?=
 =?utf-8?B?emlLV3lEc25wYkFScXk3d2NoNnZtUyt4dHlwOGF2c1phWWtIOS9BeFhySU03?=
 =?utf-8?B?QVc2cVZKWkoyN3NtQW16dithMzRHN1o1OC9wN0dMS0RwWDVKN2Z3dkpQd0lp?=
 =?utf-8?B?NEJsT2c0a1lkdjVJam0vMnJzTi93N1BWSUlNbVVIb1dwOEcwbEJyWkNyOUM3?=
 =?utf-8?B?M3hJNVl4ZlRkYnlXODF2MkgvSGJMUEV3azZIRFB0dXBBazc4MW83cDQ1L1dq?=
 =?utf-8?B?SGhjcTBQeEFBZ1A5dTJpU1Q2OU1zYUp6MzFuZklISGY0S2kvSFlMSGlTK21a?=
 =?utf-8?B?MVNwYlZaRFY2S1dYTm1hM05VVjlnbGE3ay9uQk1xNm1WTnZTUThhaEoxS3Qy?=
 =?utf-8?B?d2hmVnphQXhpNlBkZUJpbFRjY1JpY3ZOajEzZXFLVnRoME14c3FtQWdnbEsv?=
 =?utf-8?B?ZFpxRVp0YmdmaVNLbVpSNWRjUGhkclplaVZMVTY2K2x6blRmcG9wRGtOS0NS?=
 =?utf-8?B?NXU3MDVZRDJpSVpmS21YS09MNGFrelIvR3VsYlg1TkN3S1JnWkpmbTBUVVFR?=
 =?utf-8?B?OWkwbURnV1JSUXEyVEpXbU4yWnBBeURxT1V0QTMrOHIwQ1pOTUdPdjlnL0dn?=
 =?utf-8?B?Q3lDaDdEOG9uOUF5V20ydHAxckttR3l3eXVHQ0ZJVUlwNjJicU5LRUpHQmRD?=
 =?utf-8?B?Wm1EWElCR1cvTWZpSnFocXcvV3BYWGc4UWw4elpIV2dMN25NZWlqT3hFR0hE?=
 =?utf-8?B?OWU3WFRwTTFVL21iUmoyUFFtRVdCa0wvLzJsMnBEQ0s1dEl3bXVQWUJsYzBJ?=
 =?utf-8?B?dm8wSk9EQlZWVG9VYjhHdndkQnU5YldxOVlwa28zTmZQUmRZNktVYzFhdmlQ?=
 =?utf-8?B?SlBHMDIrd3NqQ1F4THk3QWVpbWVpRlhFa2xob3VjN2U5Ym91SXRycUc5cEp0?=
 =?utf-8?B?RW9XY1EvQ05uU2dzSXd4R2ZpcWlBVENSY2t1YS9NcTVTQUJNblBSa2ZhOUdL?=
 =?utf-8?B?TGhDM3pEcDNVRDRlUlZyR0pEckg5SFQ0MU9EbCtPNHNaYTVRZ0hLNklJVlVQ?=
 =?utf-8?B?Tk1XRlVnV3hkZ1MzcEdvVTkrQTVTQ2FPRWVoRzYvSWVESCtDbmg1aE1VR1l4?=
 =?utf-8?B?U2RzM2pmc2VTL25lSFJlWVdVTVF4SVJMUkFqUFpZa0xDMG5lMWhXR09BZUFk?=
 =?utf-8?B?UDV2bVBrY0Nuc1dJVExteERGb1o3Z24yL3ZpYml5RGs3MGluR2ltZWJHOCtO?=
 =?utf-8?B?ZnZyc1B3RTNWeVNQZVpkbS9kMjdreU41M21mejBrZEFhOGpXTThZQ1FLRXdC?=
 =?utf-8?B?VUNTK1p4WVMvbGFzdm41V1JYRVNLZ282dHpmaWVzSkhXZXNSdWVWK2VDSzFw?=
 =?utf-8?B?MTZ6TUFwNnhXNFRmem5lSzVYTEovbk5MUFJNK3UyRGsxMkk1Ylo1eW0xL1M0?=
 =?utf-8?B?SWFtTmJXVEJWRGYwSGgvMytpcmtTeU9wZUt2aXJTbWx5QlBodjJCQm5lM1ps?=
 =?utf-8?B?SGtlellBaHpOYWtrd0pSemhST1RzazFaS3lEZG9nYnlrR2dRWTNobUtVK0Y2?=
 =?utf-8?B?RFVaSmkrTEF4cjE4SEV4ei9yZmZiOGxVNUh0THBFQnFlUUJXcFNGWHdQUGVJ?=
 =?utf-8?B?V2hxQWRwMGljVzJqdjZYcDZ4ckp2TXF6Z1BuUHF2T2lTSWxab3VCd3hCTHJG?=
 =?utf-8?B?NjJ5N0c2QytMN1YzblRiZGR6OUxHSmRkSnNkbmZqUUVjTmRoNGhQdmtzT1dJ?=
 =?utf-8?B?UGowT3pzeHluVTBjYy9wVmVhbTVGYjNiTTdTVVpYSG5leUlUaTI5K1pMcEFZ?=
 =?utf-8?B?VEpvTWVFRkRIUkpPWE5LajR5TEh1U1dVWU1PWjBGQjA4OVpyMGJBM0FQSHBZ?=
 =?utf-8?B?WnVpSk1oWDNWUlJ4VVFlWk9heWNlU3ZOaUZXZjhNY1o3MG5zalZtNU1CQU5Z?=
 =?utf-8?B?SVh1T0x4a29ncHlhU0xUM3h6bmZpY3ZDVWQ1d21NS3lqWXVoU09BZnF1NDVM?=
 =?utf-8?B?SzRBUlNTbVFJUVFKTGdNODlnUDJ6MVl6OW5ucno1N1NiUWZ6blVLNGxSK0pY?=
 =?utf-8?B?aTFIYzFCQjNIZUwwTjBaV0d5TGY1TG5TNVJCQ243VVVXSDZHODhwcVo0UFVs?=
 =?utf-8?B?V21HMFZwR20wNGxvb2Njd1dBQWROZjNUMGhkeTJwZFhyQUNoV1VRMTcrYXV0?=
 =?utf-8?B?Z25SbXdlVWpuelFUMTBRUEg3TzZ6d2hQWm9LTENKMnN6cng5MFFMaDlFc1Z6?=
 =?utf-8?Q?blsQge3jsZlHc7dml0WSQeM3pSYFW+LrVkmzpb3HOgxNB?=
X-MS-Exchange-AntiSpam-MessageData-1: 6ctKK6lGw44GzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd7299e-2f54-44ff-fb3e-08de8972c9c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:58:44.1943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T120LHzbzDie4RLF5sdmq8p0ybSkHWCoeK63TwsJX86Ip76BoEVzl2yWetp4vSX/EnAm2GOIQzo1l4A7eMwL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

On Thu Mar 19, 2026 at 3:00 PM JST, Alexandre Courbot wrote:
> The command-queue structure has a `dma_handle` method that returns the
> DMA handle to the memory segment shared with the GSP. This works, but is
> not ideal for the following reasons:
>
> - That method is effectively only ever called once, and is technically
>   an accessor method since the handle doesn't change over time,
> - It feels a bit out-of-place with the other methods of `Cmdq` which
>   only deal with the sending or receiving of messages,
> - The method has `pub(crate)` visibility, allowing other driver code to
>   access this highly-sensitive handle.
>
> Address all these issues by turning `dma_handle` into a struct member
> with `pub(super)` visibility. This keeps the method space focused, and
> also ensures the member is not visible outside of the modules that need
> it.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to drm-rust-next, thanks!

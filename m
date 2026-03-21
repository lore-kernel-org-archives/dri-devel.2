Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76763108B8FF
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DD710E2C3;
	Sat, 21 Mar 2026 05:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChpGqb69";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF0210E2C3;
 Sat, 21 Mar 2026 05:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roduKNbqGkAX7V0wjDLdtG/tMAijzwTMjawtwcetz33HNTUdOSZlTcCT96EqS6RXDIUNygS9plQdXKEFL5LJ93eBDLpkZKPjQLoQwxycZUhROMYTmb/ymM9P4bR11Ap53BT/c+s0Y883D5DztJvBk30V2G74Tu97PIKI/rLOjFB9/PF8Ob57iEXaE5z934YWG8a7RS8peQD8zU6Uoh/LSB8QeYKgZvtXO6umkT+BbECrUcYLpe28kkEz2stHiE3XWEaKu3SAjAucMVvrGmluO5J/GDLaoW/Xj5xXLXxX0kARv3IFUhStzSbNQ/dMQo+Vr/uGSRmdpLMZGq4tcpVm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBh+MpW8iBqIB2Eay09xnKkDj4CNNXmpAHc83ECmmUQ=;
 b=QEcRaSsTU6/Yl2+iNHc5LC6vCmQPQPJLMHIz5ENfc7pKQU3HTxobuaXsk7G8OGNNvS1QsjXJK3lvVPSbsyfYQlCQrYZP0UZ3a71kWEsmFCQF5YSu/hT4DTal6l38pqAYR2awBYwkrfuVIOgAeRTtvg9Xdr35xKUcKKVMSgErxrobmazdEyVJkQjPhMCpPxXfRPnW8QCo8z3978WZdON8XD/q6xZwE86lMOhhB4YgzThLawPNxDJSYqAtKIme+y8ufabOQuBPW1X1uyKd6ocptnzIyZwjiVqdaWtNASJ4WJ7MZ2d9ybUObNFQbu7jiPaFnd4xvaBYI1zVSpxfSvGXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBh+MpW8iBqIB2Eay09xnKkDj4CNNXmpAHc83ECmmUQ=;
 b=ChpGqb69WlwKF8bLLa5EDLg2zZtcJLbqlDqa7hltzACZS039sQfn8RO4j1mFh4NwY+kkk3k/yR7j8aErr+5VvOEqsvIV3W3l3OTT2fTG5wYeAiX3o0J2xdR/jmzxRubgG4W2h+LPUV81AkDYHIwgmTkwByernx0PlmzpXjbC553pNeA13uit4qbVNmARBTsupuFfJD6mCvc4zJ+iXdrwMZJ7j7fGnzzRBsoIjAVaAnXFBZ4B2MEcV3tOatZ1VlvYd9Z/GSjpA3kd0bvM6MADGwMjfm5eKSHpUt4rpIxDw/Kb6pl2V3sZ+C0Oe3/U1OblHKNLVOeupxH5jAmuA+Bwrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 05:14:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 05:14:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 14:13:58 +0900
Message-Id: <DH87CCNRR5EC.2SK3IT6N6Q8V5@nvidia.com>
Subject: Re: [PATCH v2 0/8] dma::Coherent & dma::CoherentBox API
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-1-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:1::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 595047c4-4d36-434f-bd76-08de8708aa62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Mae85k5rDDtJr023CAMICMBXtV6CN410B95FdbzXrYuHGAG1iFK3L2lMVFHEzQL2VmN7GYVbhCmAizBfcHKBkuNAi2E7dNJkvFGbxwhik0Xynr7FbXHfoKFKEz6zT6QPLk6c/+YHWzAxcQWHKD/rK3abvDY0iRkTTOw3Nq0zNN5kDromb6VQEkS79oOEK2goB85XVfbPK8VG/S7hFyNFYcXISCva80pO0n0GgpDMhjOn/msz5aG+JNWnbJ4JeMnMVMry0j/6Q6e4HTlGemWjjIDJUtfb8au80L1QHbSDka/M5vgyYlhXRmcK+vIu01nPYi0JoULOIl6Uk5S235Otkhsvk6zznLGdG61nK5VzD44n3uoVPnE8bg+ZT0oF+DympahVGpRZx0D4wQ5D1iTMLN3kcmIFJe7dQgcUu1ub5CS16DUIW4iCKA40NiKbkqCq3cBIsDBoeIZeEC16MeYY2MmK5f1pCgnMIN3IjD31yY93gIt98QBVkRY/8+uT/mCjnzSTx6OT7PN/ldBiTyxU/56b1Qsr1FAGWzA37aEoFKCyekZJ3262q9VNOyqt1wAQZgtnV5fY2HMa8CyGjad4k5H7BH+rXOHYrfyAnE5Qt5RhdvrqsvfNhfS8JX/1wfGvl68EUhBr57T+6ms5T81rNsPePwokrcs3lja9m08eHgx6mX5dgy/fkiKcnYTRCz15UmPAHs7KKwl3w4Ltgs2liysMxVJTuqpkDgDTxuId2qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhFTVgraXNRQlY0UW9QTXdMdnFsNGpWcTVWcm1lcjNVOXUrd3AxNUd1Y2Nu?=
 =?utf-8?B?Mis1UzByOExnSEVQL0lqV1Bwb0dBME4yTTBZNjcxY1g3azBOWFRNZ1o1d0Mz?=
 =?utf-8?B?Yzh1M29kczRMcDFGYmRhWlpWYVdDMG5ORzN3a1JqekxHYjluQ213MC9zR25N?=
 =?utf-8?B?blFuYWtBUUxyVDczemxsL2NrRHl5V0MrNnFUdSs1Y2t5N1Y1M2V4Ni8xbEVF?=
 =?utf-8?B?d29oRDlqWno5Tm4vcElSakg4QXpldWNwT1hKTUFlOVFDMjFFdTdoRTdhRHJs?=
 =?utf-8?B?clI1TDNzUWNxNmhlQUdvSXE3N3Y0YzRrak1SS0M3WFFKYUNOWUdQc2FBUmoz?=
 =?utf-8?B?cjRsUGZrR3FXWE5ua0dNM3hDTWxZcmhXR1NtcERhcjBVT0c4U1pIcjRSeDk4?=
 =?utf-8?B?M0ZKT21mOFhOMjVuMTgzWWgya3VReFZPLzdXT280NC83b2cycS9GUVN0eHF3?=
 =?utf-8?B?cXJwTHBEVHBGU2RxRm1XQ3d6NXRxRW11cmlBblJUNVJPNXY1Zjg4NlpUa2pU?=
 =?utf-8?B?NTZZSkVkYXp2QTlLTnBMMjNmRDhpbnFYWDFhclhqUFhkQk02eVlneWF3R3pz?=
 =?utf-8?B?N3JjL0FOT0MrSDBpaGZTWDY3SUwzcHlEUSt3azhqSW5wUDFSYlhQYWlERi9J?=
 =?utf-8?B?V1NYZzZQc280aGhKUG5DbHFOZTNSRWFkNGFjeEtFWE1uaytCYjI4MkZ2T0NV?=
 =?utf-8?B?YVg1enFEb0dYZGlOOGhobUN0TDdQdHRCazNZOURyZ1ZtUWd3TzdqMXpVeUlV?=
 =?utf-8?B?UHJ0dlhJMnBPbHhEZWlnQndVcWhFK2JMUVlWbnd0OFdobjF0TjVXaGd1Mlhm?=
 =?utf-8?B?MzFwSFFUL0xQVU5hTnZBY3p5dDEyR2FidGFyaDErcVgvQ0MzeW1CU3dHVEpG?=
 =?utf-8?B?eHlaYlJUVzQ2aDVkUjhiRUVtem92VHhCbHhIZlowOGRUdDBlS0NpL1F1RkRU?=
 =?utf-8?B?cmF3M3dzSDZHSytEc0N3QkJVWU8wSGdRanZGL3FidVFYMDUxWTllS1B2WW45?=
 =?utf-8?B?Tk5VbzdKK2hCUXJtN21nS1ZuOHdoQ3lKNldaeHdrTTRPUUdqN25LQVg5MG4y?=
 =?utf-8?B?NjI3NU84TFRMT01IdVVMUW15dXlLaDNRWmJQVzZkcUIxTkpuU0pUS294RFpt?=
 =?utf-8?B?dkVVS2V5dkFVZDh0M3Y4QkRkUnJZQTVGNFJVckVIVWpPOUtTWEozYm9relJw?=
 =?utf-8?B?aWF1Q3JPMms3RzRaQ2hxUG9oUEJqUFFTUkszc3BPbVVDVkRHNDdyQXRmb0I1?=
 =?utf-8?B?L2FwM3kxSlBuNGxUNWI0em5rb0lsRUhERnJkVVJMOVBPR0JCQVVSNnVzNFFY?=
 =?utf-8?B?b2NLZXNvNUJmSU5YcUNEYW85SVBNRXB0TlhhcUFSM0hCWkJvSmZ1UGlnNUky?=
 =?utf-8?B?ckdSVUdsMmlIRWNZMkQ1S1RKQVR3d05XbXROSHN6M29zbGVueGdjeGt3TWJR?=
 =?utf-8?B?SlFjRW9GcEJod0ZUd05xMFdUZnZQSXU4SjZxRmRLVmlMNXdKOUMrWncyelUv?=
 =?utf-8?B?WHZTU25GV2hzbkNxSDkzaTlOQmhwTEtYZ3cvSk9sd2Z1dU1RbFFJcEJ1ckFK?=
 =?utf-8?B?bkxSemltMktMQVRXZm13QXlGdDdpM0VXbWkybFBkWTFwaVJ6WUhpRnMvbURr?=
 =?utf-8?B?emJZZFlXSHQ4K3Z3REhRNUREc2N4RG9QYkxJSVE0Mk9qbGhuYWZINU5JWTE5?=
 =?utf-8?B?TWUzVndrS2hWWEJxdnVTNU9KaTZTeXFkbXp4MGVZbVFmZlJ1OTVtMU56VlVk?=
 =?utf-8?B?T2RhT3ZjdEM0alJjcWgrRnVzdS9SbnVSNzYybXp3SlJUbXhjdnNiYjFDU05M?=
 =?utf-8?B?NHRmelc2TnFwVm5aQUhBd1gzeG5DWEFDU0xPRGhhSEE3QUlSbE9na1lkcGVE?=
 =?utf-8?B?WEc0YkR3VEJYeU9pczJvUXR1UEE2KzR2RE5NTzJHeXRXU3ZQb0wvWWRiTG9U?=
 =?utf-8?B?clFPTTZIZzhya1VFUUt4dFhMenkwTkNwdEozV0JyQjc0MkZQUnVkUUVxNHN6?=
 =?utf-8?B?MEo3aUZVTU1rekpVSEVLdkk5enk2Tjd4cjFvUCtKVjV5d0xNVVhtVjM5NHlq?=
 =?utf-8?B?MlZqSWJaT2FkdTBMNWpDNXNRY2d0eG1hbjVMckQ5SUpJUCtweXIrRjh0Z2NX?=
 =?utf-8?B?RzR3djk5MExiQlRZVG1iTjRQay9MN3FhMFRtQjdUaXpYblgxQjRqc0g0c0cv?=
 =?utf-8?B?OU5leCs1RVpDekppK2w1TWJGYUZ5U2lhUUFXby9OMnhRZVVKMnZGVFVpY3FH?=
 =?utf-8?B?SkFWZHJLN3RGUzdsTjN0aGVmSzFTS2l5Rk9yeGdEV1NGL1lRbHdHU3B1ZlBM?=
 =?utf-8?B?YlVkZ1hnT3VsYVBvMmJCV0tLdHhTVndraEhXaVEzRGdEdWgxMFpxS240emNZ?=
 =?utf-8?Q?gNhO+jGm53U07CU4Q5oSFdQr5pRVQWVSsotvNgw7ArnFY?=
X-MS-Exchange-AntiSpam-MessageData-1: Uj05gVumTVLzOQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595047c4-4d36-434f-bd76-08de8708aa62
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 05:14:02.4038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQPlNvyRXj4KAQx51XeEpKLeWVDbxe1VekuhNxhqsKxiBa5ANUCf3yyhFOVr5J/MkNFbwiqwJwkiu48vl5t20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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

On Sat Mar 21, 2026 at 4:45 AM JST, Danilo Krummrich wrote:
> This patch series introduces the dma::Coherent API Gary worked out in the
> context of his I/O projection work.
>
> Additionally, introduce dma::CoherentBox, a type that encapsulates a
> dma::Coherent object before its DMA address is exposed to the device.
> dma::CoherentBox can guarantee exclusive access to the inner dma::Coheren=
t
> object and implement Deref and DerefMut.
>
> Also add Coherent::init() and Coherent::init_with_attrs() so we can direc=
tly
> initialize a new dma::Coherent object through an impl Init<T, E>.

The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Based on this I have been able to remove nova-core's `DmaObject` and
consequently its now-useless `dma` module. It's indeed much nicer. I'll
submit the series after some more cleanup and testing.

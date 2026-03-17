Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62AAFD876D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FCF10E3C0;
	Tue, 17 Mar 2026 13:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlfdAPxu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FF310E3C0;
 Tue, 17 Mar 2026 13:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIWxlD6cLfKyGnSZRD9yeHZgC0+Y7BkrwkG+kW8MHCDtNRSgD+nxZmsZzqpGdAMphQQCmLj5/+TIBTN5dPEFZ7gKBjPCPYYRVaI0Ilbu9OkxWsQsG5tPr1PWToWDLe6Hh/eIDELajsGeHT0ANDJ/owYFKs38Hb7lFr74Oo4ogQijyxKce6FTsVaZpNuvdYVvGUbmclwa13FXRJD8bdLqiuT4D/CrzDMVtvDn6VlI3sF694/1tsDnY0P4zDQtFQj20s+g3lKkT7H/dfaNpSq3P3HgPGQzmiBHjr9C3+lI4s0AEAxW+2meQlVyd1P7SENyZbUKSpBt6Z2HZckvuVF56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp/y7tBfQmT5wBUuX3TzevFjxhMwBPiOg76aryv31+4=;
 b=kucz6vcK3qv0REKgToDgn6xEN4CdX94vQlXbSodKpaAGba1VlRIq7taD8iXvo1m+bYa9z320Z5OOWk74NMmFntSU8m6shgAWAgjj6rSIfZgelXXuE8dmg6p3FOOVmO83od/p2HF52QW27IPzJJWXTz6AubMQPimacJW7gQAX3POmJWbPVEi0+AlMyKNNwTCSwj6tnHgJSsks6+4ZdlV+p71VTbW447wLtyHe09gAbMcM2OjFk+a6dnhxklDsDsGw1bXOy5rKoLonODu+hGMBGwzfck1Z/IC4DfsCaE7cUMO1e4qMtfjjxYVoqioMA2KH66Q81IwSHVB/gS0e9CcHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp/y7tBfQmT5wBUuX3TzevFjxhMwBPiOg76aryv31+4=;
 b=VlfdAPxuI2ojHRRKoaAOZsxdm0KlihFAnXFYSMJTyLwhXiXVrzbKmXGDfRZjcyNmRvul1VXNYkq/GCp2xBVisBgVC2M6iwG+vYqTC4/tW0/CGcMBDzYGJajROO7vshK6eq14x4AxW8wGTo9oyoD+6WFskD034j+RkjJPAALwfJ6lMTkdPTvn1nglkyLM1bCt/b3MsKQ3uTBr0C6Y4iD0VD0vTDHMuMMiH8KjuFZ4ZSutVYt3NxETaAGc2xuiWMcnvOg+pbYd7jd/kmPm9Fgtk4kv68jIIjxL9a7GIHlCXc2lVpdfEaxLxTdzeMJaS5IaEKPRMEEtNeJY7wfWmWybag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 13:41:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 13:41:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 22:41:43 +0900
Message-Id: <DH53MXEAVB0Q.2SXHCQTW8WG2Y@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>
Subject: Re: [PATCH 6/9] gpu: nova-core: generalize `flush_into_kvec` to
 `flush_into_vec`
References: <20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com>
 <20260227-rmcontrol-v1-6-86648e4869f9@nvidia.com>
 <093ca23e-7081-42db-a202-0a42c51741a3@kernel.org>
 <DGYL9FS1Z00X.2HEJ96J8R3OK4@kernel.org>
 <DH46IKESDQ3B.2GEUC479WDK3N@nvidia.com>
 <DH47AVPEKN06.3BERUSJIB4M1R@kernel.org>
 <DH4OM17DJ47V.3NJG7G02O7P1L@nvidia.com>
 <DH4ZZD12V0R6.2G7IIL87QTK0S@kernel.org>
In-Reply-To: <DH4ZZD12V0R6.2G7IIL87QTK0S@kernel.org>
X-ClientProxiedBy: TY4PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:405:379::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: fd102abd-0150-4021-c25d-08de842aef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zBDtWaP+anD8aGy9h6eNV941mpmR+l68v7YIOFqprXMS7bKO0gcgwqbLQ/PGg4g69U8N8SP39aneXdr2MNBItun8ExtnIRv2Lf/iAeFbLBG9HQZnnEXvIF0V+zoN/xU60MKGU/fFgvYXmaO5yC9iixRKTEXTRNwU0bX0Gt7v2qEf9ePIE5bQtZiXwlE0QYqQoj2SyQ18CxIAqEQo5LtDbPENIL3+RUrbXeHnrzY44zPUr+PeH53RkLU3qnqM7+ZQrOT/cB9DfYgdo5l0ISXQ/IkBA8whp+AqHuZr+MUOGchSec/mF7QBNjL/Lwl3vWsOenng/2Sc/9NqzyXUsjjiM/faRLmU5Lz7Tge2JlDgcA2Sapu30wYg9BeMG9D/TSZcglVJLDAQvi/KyaGE5OstBQMv9N15wZMycvBYfAmyqL0X46/Zgs3oJI8EOHQuQftWKWIzx0br8zWM2ZdiuvG20optOKuxgkQGZ2pAowQObNxzHF988PHktMUZi6qKLDDhPfNH39kNIm+MCIULgNxeTsGYOQLrZsRPuvJMst8h/yVXSvlh+33vP2KT7VaxxlCHUQMSGgLGdp5hMtEkyxZ2n0hEByA6+Znhiot8i/GHJ68fg00gS+8NK5yuh1iLJNm44EUutlvvya7jE8GLgvm0nSrVJhGSNJwx/qxBrzUaJ+8fdSWKgB0beHMdbGFLtFsM/xLaLPVDZQpK7VrkJ9THGIRNqBxhC9NxMK9i4nGOwec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWR6Q1pyMm1OMUxvSXlZcUdsSlJBM0RxSHpnRnZNbDFOOXBUa2FhRGgrSEpx?=
 =?utf-8?B?ZVh1ajRRalV4Y0tlb2ZiRWdyUXJwNnNyYVlyblZpVGN5WUtwNXhHSUwycjZP?=
 =?utf-8?B?UmVjdnRkUC9yV2M4ajdmUnBOdUh1anZyMzVEVURHOUlQWkgyMWVUNm8wVXRV?=
 =?utf-8?B?bWQ1djVDeHlWUjJUclp6Q2dUOUlnejVRRmZWd3o3TXkrNTZnbW9pdmQzNGRz?=
 =?utf-8?B?NEN5ZlAzU0FqUUZQaHRFVGpMVTJsc3MyUXlBb0w2ZWVrMmdhTWxHbzJCVGg5?=
 =?utf-8?B?MCtYTTI0cW0reWhQVVV4Mzhvbi96aVVQbmhjZGhTYk9HSWpwaTBwMldQaTNy?=
 =?utf-8?B?MXA5bGh3cTV5eXhoZlF3M3hROXNWZWJmNmg3MzhlTEJjWGVhSUQrOVVCazR5?=
 =?utf-8?B?MGNpTi9XUmtvUVA3SEZ3MktDdm1pNEJVc1FGbGVFSFdTTFlRcjhhc3I2Y2VF?=
 =?utf-8?B?aWovSnJpdHZ3OE1lcDJQckNoVWdXKytJNllLVGNlSy9Ja0NzM1FkTGtNQUhm?=
 =?utf-8?B?TExEbThrRDJ3aEJjbXlsNG1rNDNtYWNKUngzVlgrVW1JZE9ER0VzeWtoay81?=
 =?utf-8?B?T3BHS1AvY2I5K0xkUjMwMWg1U214THBZbHl3T0tJWVRzaHU4NUxJZkc2Wkdy?=
 =?utf-8?B?M0JVSmVJVTFBSHBqNW04cTlOYWFRYkNIK0FRSG8zL3dDekJ6ZXhqUmdmOWZv?=
 =?utf-8?B?dnFCYXlRRHZXZTJSdzY1UzBJQkNxVjdXeTd5L01STWQyWTB2b1NXTlRVVlFn?=
 =?utf-8?B?dExsOU96MldGcUNEYytFSkJMZFFoZ04xZ1UrQVp3ejk1WnA2bHErQ0U5elh5?=
 =?utf-8?B?WlpOeGVwR2dEY3U0bVRZdWVpR2Z6RUZzL0NOa28zNHJDdHpSMjhGY0JUbHI4?=
 =?utf-8?B?RC9Cb3lSSnVJcUdYUWNjNmd3NjcySTFBdEZCdXBjNjRtTU5ZUm4vZTBPN2hn?=
 =?utf-8?B?VzdIMFg5WUhUOE5KUldHVllpRU1XZVJYbnhYZkZrZFN5eTlJQm4xSmp3eEcw?=
 =?utf-8?B?aDIraTJxcjI4bEc0VHFPWENkNjEyd3BhUTlyQjRUbGJxMHJtVnVscVpPTC96?=
 =?utf-8?B?cENiRjVKbnkzdURINkUzdjhmL1BNK3pUSnZOYWc4ZnloYVE4QVdlUitDWFhw?=
 =?utf-8?B?b29zSC9LeVlPTUF0bnByeGpRVE5ISGx6aGhWNWJ4RDdaQnduZ0dFRzhKenBE?=
 =?utf-8?B?UVZCcmpjNmsremlKSk5kMUcxNUNSTS9hUlkwWFZFdmc5RjV3aHhhQ2xaYXph?=
 =?utf-8?B?Rmt3UFFvdUZUQmx6N0lXQ09SOC9YZUNXUjc0YTZRYWZJK09pck5xQWhMLzhw?=
 =?utf-8?B?Mkc5OUw1b2Ixd3ZjZ0pkUUVNZFZvMGtUWlBKOVZ0c01GdkhLN3NteGZ2cCt5?=
 =?utf-8?B?YUdCcFdKVmRCSjhlLzhwQUl2SXpsRDFRbkdnVm1ab0NSRFFsZE9PSkpkSmFT?=
 =?utf-8?B?bmlBZEhua2FzcjAvbmt5VzN1ajl1MTBsRTZzak9yUlZGUXFLK1Z0b1dNMVpR?=
 =?utf-8?B?L0NMZWxGUFJKYUFYRTlHL1FZejlOc0xMbWo3TytzVVVYVzJPSUFTMTNXN2NG?=
 =?utf-8?B?ZDErcU12UkJFRkRrdzlnb21MYjZZUFV6VnN6RGlvSTA5M1UrWlFCQ0p3dGdj?=
 =?utf-8?B?L0tucUxjelZYTmdkU2RGZTlBV1RFS0RiYTZvdkFFeEdqK21TMmwrbFJDSG84?=
 =?utf-8?B?bCsrMUVpaHhQcldOQjJXcDkxQUx4b0ZVa0VGSVRBYk5nSEpLVmpNQW52dHpT?=
 =?utf-8?B?WVB1enVWenZwUHpVeHIwTUsrdEoyRVUwQjdOTlZ4WWhOWUFySTFrdnZzRUFZ?=
 =?utf-8?B?aS9sUFBybEdKcTRNZVM3Rm1haWlVQzU0RlZhVFhVaXM0OVBvWk5kaSt0cGF3?=
 =?utf-8?B?SDhVOS9ocWVhbHZJV2lZbThJTnJ5Ukhic3RVOFlHMTVUVWdadXA1TEhJZ3Ey?=
 =?utf-8?B?SDZGa3VjSHF5Kzdldyt5bHJVU1lQV25LdkQyRkgwWXdxQk1MVXg3cjJVMStX?=
 =?utf-8?B?dnVjVjRGUnBQTDgrMnJzZ1JGWEtXMStrUjI2RSsvK0NRR2V1VldOUU9qZlAz?=
 =?utf-8?B?eHpjQ2I2bWYwQy9adVhmODdobi9KNlNiZHFJSHEzN2pucjBSVDJqenVpT1pS?=
 =?utf-8?B?Z2MyeDZYNEMzRU5GckZyVTl3QnNpWnRXcUw5TWJGVkVpOE53amU2WjQweW8x?=
 =?utf-8?B?UjMraTNTeE1OYkZwd01EMkxYaU1wNHRoS29CdmNOcTl5MFU4Q0w3cXkxa1Q4?=
 =?utf-8?B?MU5xZERVRGJXNXZHQnpyMk8xbXV1YnhDMXAyTDQvOURzcjIwTGhsV2Q0eldT?=
 =?utf-8?B?cjBnQ0VBSm5rSk1PV3Bwa05Nd3NvbTBtcElzamh5cy9LN1NyWTFrQ3IxZkNM?=
 =?utf-8?Q?4PBcdvWkMgc9+e2O70EJqG61ABVEzHhRJnKOqY0C8oJMU?=
X-MS-Exchange-AntiSpam-MessageData-1: IKBPf0pQHV4YXA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd102abd-0150-4021-c25d-08de842aef2d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:41:47.6200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v13ZMCOmBeYdvNjNd7HW3Rd0hWoN2OhCCU/pjZKk5X3AvSyJNEH5oqMF4lmwEa+pVCPeoz52YRCdrBQEqi7AhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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

On Tue Mar 17, 2026 at 7:49 PM JST, Danilo Krummrich wrote:
> On Tue Mar 17, 2026 at 2:55 AM CET, Alexandre Courbot wrote:
>> We shouldn't be doing that - I think we are limited by the current
>> CoherentAllocation API though. But IIUC this is something that I/O
>> projections will allow us to handle properly?
>
> Why do we need projections to avoid UB here? driver_read_area() already e=
ven
> peeks into the firmware abstraction layer, which is where MsgqData techni=
cally
> belongs into (despite being trivial).
>
> 	let gsp_mem =3D &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
> 	let data =3D &gsp_mem.gspq.msgq.data;
>
> Why do we need I/O projections to do raw pointer arithmetic where creatin=
g a
> reference is UB?
>
> (Eventually, we want to use IoView of course, as this is a textbook examp=
le of
> what I proposed IoSlice for.)

Limiting the amount of `unsafe`s, but I guess we can live with that as
this is going to be short-term anyway.

>
> Another option in the meantime would be / have been to use dma_read!() an=
d
> extract (copy) the data right away in driver_read_area(), which I'd proba=
bly
> prefer over raw pointer arithmetic.

I'd personally like to keep the current "no-copy" approach as it
implements the right reference discipline (i.e. you need a mutable
reference to update the read pointer, which cannot be done if the buffer
is read by the driver) and moving to copy semantics would open a window
of opportunity to mess with that balance further (on top of requiring
bigger code changes that will be temporary).

>
> But in any case, this can (and should) be fixed even without IoView.
>
> Besides that, nothing prevents us doing the same thing I did for gsp_writ=
e_ptr()
> in the meantime to not break out of the firmware abstraction layer.
>
>> This is guaranteed by the inability to update the CPU read pointer for
>> as long as the slices exists.
>
> Fair enough.
>
>> Unless we decide to not trust the GSP, but that would be opening a whole
>> new can of worms.
>
> I thought about this as well, and I think it's fine. The safety comment w=
ithin
> the function has to justify why the device won't access the memory. If th=
e
> device does so regardless, it's simply a bug.
>
>>> I don't want to merge any code that builds on top of this before we hav=
e sorted
>>> this out.
>>
>> If what I have written above is correct, then the fix should simply be
>> to use I/O projections to create properly-bounded references.
>
> I still don't think we need I/O projections for a reasonable fix and I al=
so
> don't agree that we should keep UB until new features land.

I have the following (modulo missing safety comments) to fix
`driver_read_area` - does it look acceptable to you? If so I'll go
ahead and fix `driver_write_area` as well.

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/=
cmdq.rs
index efa1aab1568f..3bddb5a2923f 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -296,24 +296,53 @@ fn driver_write_area_size(&self) -> usize {
         let tx =3D self.gsp_write_ptr() as usize;
         let rx =3D self.cpu_read_ptr() as usize;

+        // Pointer to the start of the GSP message queue.
+        //
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
-        // - We will only access the driver-owned part of the shared memor=
y.
-        // - Per the safety statement of the function, no concurrent acces=
s will be performed.
-        let gsp_mem =3D &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
-        let data =3D &gsp_mem.gspq.msgq.data;
+        // - `self.0` contains exactly one element.
+        // - `gspq.msgq.data[0]` is within the bounds of that element.
+        let data =3D unsafe { &raw const (*self.0.start_ptr()).gspq.msgq.d=
ata[0] };
+
+        // Safety/Panic comments to be referenced by the code below.
+        //
+        // SAFETY[1]:
+        // - `data` contains `MSGQ_NUM_PAGES` elements.
+        // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ=
_NUM_PAGES`,
+        //   inclusive, belongs to the driver for reading and is not acces=
sed concurrently by
+        //   the GSP.
+        //
+        // PANIC[1]:
+        // - Per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`.
+        // - Per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`.

-        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NU=
M_PAGES, inclusive,
-        // belongs to the driver for reading.
-        // PANIC:
-        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
-        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
         if rx <=3D tx {
             // The area is contiguous.
-            (&data[rx..tx], &[])
+            (
+                // SAFETY: See SAFETY[1].
+                //
+                // PANIC:
+                // - See PANIC[1].
+                // - Per the branch test, `rx <=3D tx`.
+                unsafe { core::slice::from_raw_parts(data.add(rx), tx - rx=
) },
+                &[],
+            )
         } else {
             // The area is discontiguous.
-            (&data[rx..], &data[..tx])
+            (
+                // SAFETY: See SAFETY[1].
+                //
+                // PANIC: See PANIC[1].
+                unsafe {
+                    core::slice::from_raw_parts(
+                        data.add(rx),
+                        num::u32_as_usize(MSGQ_NUM_PAGES) - rx,
+                    )
+                },
+                // SAFETY: See SAFETY[1].
+                //
+                // PANIC: See PANIC[1].
+                unsafe { core::slice::from_raw_parts(data, tx) },
+            )
         }
     }

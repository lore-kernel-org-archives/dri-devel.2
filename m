Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57747CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AD010E4D0;
	Thu, 21 May 2026 13:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZZ8XMx6";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E66410E06E;
 Thu, 21 May 2026 13:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDPGhg8JpbNuKLNZ1NCvWCBlAmACvP7U8BQGdZEdu9qchPDEwYQK9DnC4JreX2sZhvEqnZZyP4rq8paVvP5b18Obp0qOZcQZ3Ke8/tEBkV0wQgDjX+BiSsBqN6HNW61dxFIqheITqgDgc5p1FFoJJWzLS832vou1A8z3E80gcZ7XejHAqYG8fjKkdeKevC3faQd5s6vJJn3FpmB4EWWCRu6hhzhecJpKYvCXNbuRO6QnILQhYS661mAgIjZBWAAikSty+dtghjYQEDQzi26fP5NyH+nJdIxOh1hks5zK5dpEVfB9aFOMVWYhaLrBth0E0XGHjX9lDrXxtiL/54Ylqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXWDm91DoXkI6u/vLFFvMh4QXVj0e9mlu66ApJACHhk=;
 b=nPrWdTuvQPE6DvHAWxGZ7YRjYwIKHN+0h0RlDAx6Wh0MzD7du76dPw11Qu94/NSuAWskXvCx4xqM8e6LMjf2ax0KP80e1pfVvAs4ENropXkKmlMbiIEd2H0zyxWD6vC66mDc+WWHG7ljymeRlndy8C+WdeDy+c0wsfUN0mPiiW/JNcilGlriMiFlvBBSYFU4ta6h0nRXsJbg7wYRBB8pTk9ZyODjNMVoqBvo09NHIpRsrur/fTyMymQmRVfWb+0gGrnXVGX/lhS8+D2ydGbZcy4D6bJEfjZuDp9cAgXODbNvDSn+Vbzk2YWg65pt7r1xVQNvkSTN1ZZeNqkuxj81yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXWDm91DoXkI6u/vLFFvMh4QXVj0e9mlu66ApJACHhk=;
 b=fZZ8XMx6YgEugvJiT2iK6JEFImpQuMZj84Lakj8bzhA/6GCBALucW93ot25KIoYt3Ips7n11teE/la5PaU83+jSo1IXR81BbPL+P9eZo5dgJlmzKJ99SfUNAJlg3FXDPwJr/XHW3+hXwhsYIUDVce4NWvOsBmT1ObfpBK6D+CPw9BaUKKDUMoq9sV7TULGHsTlP5/BapSGpa0Is4KGXy32UhYVrBZIBm+ryjpBUs9Qge9rMA2qX1ewH/wiCZea18+cslbMvgEcJ+TIt/CsjBJh17fLgO/gjP2M1gVVigwVMpF5pUA7fmGVxToZRTE8k5Wqoowab9nwE/DesSHWqgJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 13:05:01 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 13:05:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 22:04:58 +0900
Message-Id: <DIODK73THOGE.EROPFHMO2YHK@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
 <20260515-nova-unload-v5-7-c4d6250ad160@nvidia.com>
 <DIMAVKJECLKH.UXLZASCKVJK0@nvidia.com>
 <DIOAZCL9W7F7.J3WV406BXTY8@nvidia.com>
In-Reply-To: <DIOAZCL9W7F7.J3WV406BXTY8@nvidia.com>
X-ClientProxiedBy: DS7PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::23) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9dbe9d-7575-45bc-61e0-08deb7399102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|4143699003|3023799007|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 1CXbY7zBVK8Dk+zNwnTTfqzDnArq+gm14KqwWtEevsGWfw/7+kyoAC5pDimsm9oCErrAgzBGB7VL1WODE+/JZHByrwin2weqq5y2i03/rtwTLWSex4VkTKDvELHwK23soRTh/uY5rF0cRDbFBqXGDQlzHbvUBHid+4fxovk8YF9o4WqHN36J+P40MxaT8C01aGqRirolnhmrRFewax6HoRDRo0YOX1ZegI5aqxRhJ2MnRl5RK1cpBR87X//JX1dUcqgOBPoAij11kH/HFQ64QHIE/m6tj38bUYXIK5lrL4Q7wGc58CrMMms+hoZvi7HFle01kR+uNBRIZ69hvFAQDNYMy0FpR1uMIK6yRRsHIcrYQBDcFMPVYzTnQl77y/cs0+3QOZMYOOmE1ApkGP4gBvC4H4c7CQAMo/4WGrwyELVZrCCJwddTWBUi9H27T9l6MFyBuXEqwBxXvCENJjgpE88J5T0Uuz/MHRi9QKOHx2Jk+KwWxcl63nmDSWaQ9kibj9V8KJMp/4DGxj0P9SaEgamzGgBUFb3UUKyXXDzJE7QcOHhEojP4B9ME3MsF/dZcSnYVrag/cdPBof73OjyobjgKbCHsLfg29VnBxRngPyIB8H6+usLxQGp5u1Y44tOg3LaFFqSnX8VEYU3CP8SHLn9pp38c2C1vnJddm+E5k4aZUluLrsJX6W0M9FrdMGED
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(4143699003)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2QrZ2p5MWJ0OEFPMlc5REpWSGZSbHhaS0F6R3U2WGRqc0lIUWpVSElEeXdB?=
 =?utf-8?B?dXVPdE9hU1FWbDYyaG1XMDJQc09vNnE5bUxkeDlTV0xXRE5uZW4zQzV5ZW5x?=
 =?utf-8?B?ZzJ0cUp6RFgvbVZjWGQyWTFWS25EZDNQOXFIalY0bGg0WHlrSjRBN2tBcExL?=
 =?utf-8?B?MkVTcGJ0ejZORnBtK2FoQnFaaGU0U3psT0V5QnRLcXg1Y1h6WmQ2ekRxbmtv?=
 =?utf-8?B?VndXbHpxU1BPTmlKbWVvUUdybGVuYVBmdzZvSStqbjNHc3VzcUQ3VWVhSzE1?=
 =?utf-8?B?Y0xZNkdtQVh6anZ0KzV4aEd3SWcvVy9wZEFyTyt0bEhXc1lvWHZud29yaWdj?=
 =?utf-8?B?aU9jVDMxK0tNMlBrTEkzNktqRWFOODA0L09RVm5YRSszVXZJUk0vZW9DTUN3?=
 =?utf-8?B?UWJvSzlJVlBsQ2VjT2R0dHJzWk1aMzFOUGQrS2tsSlRabmQ1T0RPY1lVaWRs?=
 =?utf-8?B?aUFNU1doYkpsOC94VEh2cmVHM0xqdWxmdFZJNTdqSEZqdGRqNXBjTmxGNlRH?=
 =?utf-8?B?VzVVTldJYTEwN04zaDBZSkJ1dnhoSzZYbjVmM2IweVhqQ3IwTyswVzNEZEhh?=
 =?utf-8?B?TDhWTSswdXZKZFQ4cER6NW9VWkpkYk9Na1N2Qk9ocDVHSko0TEFYdkszcXNJ?=
 =?utf-8?B?MkU3dUNkS096Zit0R0laeWQwbHRGMDZ0SmQ3Rk10K2cxQkZwQlQyci9wMTBt?=
 =?utf-8?B?R21UUENlVVIxdjd3ZGV3b3ROaFV4dVV4Z0F1K01PdFhLRC9MVngrdFpnR2JI?=
 =?utf-8?B?dXo2N01tN0hianljZi93dnQ1MGVXaXRjTVNuT3lINjFSMUZ6bjRLNkdPUW9t?=
 =?utf-8?B?ckFLbUFqT01UVXF6SnJyY0E0TlByekJRRGIwb242cDRpVitaYjljNUVRdXNF?=
 =?utf-8?B?ZnBXQVRBcGV1dXdsaXdOZlpjdHQwaDB0ZkNTVHZoMmY5a01UeWtXRDZ3ODRx?=
 =?utf-8?B?TEEzZXc0ajNHeE96bnlwMzI0NmFrdFZ3aU9LRk1ZMHBySHNGNzJkSVJRQ2N4?=
 =?utf-8?B?MytETzhxSkZrK3JEbDZ2MHFIYlFVQ0xUYWFnUXJLRjhVR1c4MmRVdk9jdk5R?=
 =?utf-8?B?WjhicHFQS1orOU1yQy9ma3JYUDdtVmtqYS9JZithY285NndHem9RdVBCRWd3?=
 =?utf-8?B?S0w3SVEvbGFxOTVBSVNKclkzUFdxL0dCTEtwTzhZZXVTY1JBQkNNLzRrSmlS?=
 =?utf-8?B?cEtHN0ZNWHRqakVSU0JLRU9jdWZONFoxR3JsVGdjNDNKVlpBc1RsczNNU09z?=
 =?utf-8?B?bmVTOEdXa3RoNktGTlNNbmJqZk9CMlRtQm5zdGVRdGlxekZkRVFKd3puM29Z?=
 =?utf-8?B?SmhSM1k3blFPVjU5cm1qUTg4NWVmbk50cUovQmNiaitxb0pqV2kxN3Z0T1JE?=
 =?utf-8?B?OUdMeEE1WXpuU3UxNlZtUkxlRVR1c0RIMmRCcFJRcDhCV0RLWFMrVFZWQ0RY?=
 =?utf-8?B?MDFaUlRaQlZoMCs2eXlhbHdxVzAwYlpCMnIxUzFFWEx5VVdmRjZTZEdqRDRx?=
 =?utf-8?B?SCtnd2cva0FJV2lMUmp4VjZRMzBXVHJJV0NReDlhdEhtakkwdzcxazdmcU1T?=
 =?utf-8?B?VHNzOVB1eVplejZMc1dxYzRZdCtGR2MrdFF3MnBYV0Y2TDVDd2ZrK01ZMWM5?=
 =?utf-8?B?a0VDTWVVMElPRzN6cFEvV3NIWUo2WjRVbXRyS0VxUDZHckF3d0ZwbFhianVN?=
 =?utf-8?B?MDNZK21Qam45NWs3VGFGQlh1enFnaUt5VzBhVXk0dG1TamJndjdVczJoR09r?=
 =?utf-8?B?OHhFSkJ4cE4vQ0tROU1nUkpmUHVqbUpNejByOUgvakZUTTJtQW5JbE9VMzRD?=
 =?utf-8?B?UE1vQzN2aVA2U2ZLK0o2U0N6MWJXSnh1SGhJaGF0N3BxV3hCamxRMnpLSHgw?=
 =?utf-8?B?TTRGSW9wVjBZMGI4dStqSGhOdVg4c3pTK3NhY2dJT0wxRnplL2VsMzh1VnNU?=
 =?utf-8?B?Z0JwbzZ0eTVhS3lnSEVoUVYwS1FLaFBTTzl6RGdacXFkaU1oV3RYU28vS3ZV?=
 =?utf-8?B?MUs3R0dsMzFPMFYwQ0JxVkV4bzlHUitxMU1NMzUzNzdacDV0V3ZPTWlEeWhP?=
 =?utf-8?B?Um9UamVZalY1NFF4RVladmJEVERKQTJ2MkZnOTdabGFkRkc4VEMxMzhSOS9N?=
 =?utf-8?B?cTBYaGZoSHpEZXEzNEdnWVMzV2VwUHQwc0ovTkZUTjkzSU0wQzNLellQNU9C?=
 =?utf-8?B?OTJvWUMwdEdsbWUzMDhFRDlsNnNRa1RKeFpsNmgxQ2ZpOVRTM0tTM3dMc3hv?=
 =?utf-8?B?bUE5T2NpYk1iMnNrdW1HVy9tR3prQmFnOVlEUjVQS213Q2xHcFBQZUFxVDNv?=
 =?utf-8?B?M2MrbGJ6WjJNTWZwMFZtK3p0dXFmbnpzNW5tY01iZ3Z5YVB0ODVOZ2hFM0xk?=
 =?utf-8?Q?l54quJeCPWgKHJsvXKjFjq5ooevX6YVPao1GjSMdnVTAb?=
X-MS-Exchange-AntiSpam-MessageData-1: Hsui2sa5NvYcJQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9dbe9d-7575-45bc-61e0-08deb7399102
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:05:01.0854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfrT23JEU7g/Lr7LMpRSpFRoCBzVlrWChVyPRCUa3kXbiqEMs4lcBysKYjm3by9njZAWwYqm7y2eueBskA54Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

On Thu May 21, 2026 at 8:03 PM JST, Alexandre Courbot wrote:
> Hi Eliot,
>
> On Tue May 19, 2026 at 11:33 AM JST, Eliot Courtney wrote:
>>> =20
>>> +        // With the GSP shut down, reset the GSP so it can be restarte=
d.
>>> +        if let Some(unload_bundle) =3D self.unload.as_ref() {
>>> +            unload_bundle.run(dev, bar, gsp_falcon, sec2_falcon)?;
>>> +        } else {
>>> +            dev_warn!(
>>> +                dev,
>>> +                "Unload bundle is missing, GSP won't be properly reset=
.\n"
>>> +            );
>>> +        }
>>
>> It feels a bit odd to me to (conceptually) allow the unload bundle to be
>> run multiple times. IMO, ideally we would be able to take() this. Since
>> we don't have a mut self though we can't unless we add a Mutex or
>> something. If we do, we can update UnloadBundle::run to consume the
>> value so it can only be run once, which is nice. WDYT?
>
> I'm a bit on the fence. On the one hand yes, we typically want the
> unload bundle to be run only once. On the other hand, we can also
> imagine than `unload` fails for some reason (say, the GSP refused to
> shut down when asked), and the driver decides to try again sometime
> later. It's not what we do now, but doing so would technically not be
> incorrect.
>
> I would feel strongly about enforcing single-shot use if this had safety
> implications, but here it is just to enforce something that is already
> structurally guaranteed by the driver core and that, in the worst case,
> returns a runtime error. IIUC `boot` has the same problem as well - it
> can be called even after the GSP is booted, it would just fail pretty
> early.
>
> With that in mind, I am not sure it is worth introducing a `Mutex` just
> for that. We could also use a `Cell` as of now, but since `Gsp` will
> probably need to be `Sync` soon that also won't work too well.

Yerp I think that is very fair, I was hoping you would know some better
way to do this than what I could come up with. If not I think the
current way is okay.

>
> But there is another option: store the `UnloadBundle` into `NovaCore`,
> and make `NovaCoreDriver::unbind` pass it to `Gpu::unbind` and by
> transition to Gsp::unload` as an argument. This would address the issue
> partially, as now unloading can only be initiated by the driver. And
> here we should be able to use `Cell` as `NovaCore` doesn't need to be
> `Sync`, and implement single-shot logic without a `Mutex`.
>
> The drawback being that this complicates `Gpu::new` a bit, as the unload
> bundle would now need to be passed as a `& mut` reference to be written
> to, i.e. an output argument which is not super idiomatic to do imho. But
> I'll give it a try to see how it looks.
>
> I've addressed all the other comments, thanks for the review!


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6051CD5BD0
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 01:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2593F10EB47;
	Thu, 28 May 2026 01:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/f6oNwz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EC110EB47;
 Thu, 28 May 2026 01:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcATyT9L8cRfLZUKrwR28YbzT1SBz+bIyEPPYEHotCiub5xJvl0etqFGKLooqFwz8+RJzha/3B9E5VvF88PUDq/oTyMSiTflX1nnRHhIMN0coJWXo0/xRn9WcZZE7RVDPs/8pzVRdLzdK1TW6guItbBINNGKRaqj/r1BQiunH4PuohSXlIIW095QeGfaLpD6Z3/Cr5/12vK73tCxzQ0jXlUSXIlWuhjqfbCJZglaIu2uC9DOQ0WnwOYZWZiT+G1aKtP5Tq4l1QhkdygwGlQPN2F8nx0jWrbh6Rr8Pcti3cHP3EpzVqmMprvQtKGSUiCEQIiE8Ey1EOIjJgbzAOM4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuqB1otiqi8wza2VVwyj56jVn/Rpra+o2YalbZzWQxI=;
 b=VFMx5dZMScNgtKxLHgT79HA/+TQdSWWcJJAN3urHRKC95Q+nmHd/A+IpHsEdqOE1wMbczlgPVAR5odt1+S2Fjh0ylIgaNmVStfVJAEL/rIiRMVxdvkpwSwfzr9g62GBAuYyjF6nycV0dSvp+ebOIjEOFWRfBFCNPOH08B2IYdJvYeP1lj4DE/Eng4hGgD0OrEg5fyqqK4yWxT+8sEPqxTiMfYiIAJB7YiiLIpxSVZEPjWj9AGyDCbR6P8CDhAyGv01OSIgrKwLhHm28by0MbNS9Dhn1jAresE+elleqbcV5l576j0kFf8IlpVfQVZwuW/akvYROL1xWtVQN6c4fgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuqB1otiqi8wza2VVwyj56jVn/Rpra+o2YalbZzWQxI=;
 b=s/f6oNwziNfutTVimE8VVjiGMJMo4qcB26t0tCBtd3LHtv4vSolCpvWLIQ7+wcnniPlfcak1yBNPTcGjyhFOcWO7ND7WTYyOoEl5jOoGAp7ND+BKJLj1SFn/8u28zFrLK5Udffxi8ybYzaV95oIh/BoJhq3IAymW8VQwp7EsbDI7LKPz30kJmaewGROihysOZOVE1ejEjIDpt8VjGORY+Ub7NXc3RrkI9sxU8g6Cj6WEZhHJJ6Boq5VVleiAXYvMYVGPemdYnIzq/jLvKyoTikZ0hSz3xZzMV3I5nHFHNjvlQnYCphcf92UpQub+tUZvxt8MvsRTHquskfprzl1c9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 01:51:15 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 01:51:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 10:50:49 +0900
Message-Id: <DITXLUSX8J8Q.3OXYXGUBILQB2@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v6 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
 <20260521-nova-unload-v6-7-65f581c812c9@nvidia.com>
 <DIP0EROV7VSK.1WYD6SKNI05UD@nvidia.com>
 <DITIJ7IIAK7L.2PKIBC52OS7AG@nvidia.com>
In-Reply-To: <DITIJ7IIAK7L.2PKIBC52OS7AG@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0207.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: dce596ee-0637-4291-d91b-08debc5b8fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|22082099003|18002099003|3023799007|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bDoKhqfDePlMPz+fgb/VbwExavJcXzhrXU57Mks98W4VHCDUt6JZ0ldlW40ei0kyyKwZHvHH+RhTaaQT4EoUqLHhpLMUWzzQCE5kSsa28gCBjTncfZPXhkim/DeU0tDB0lqYxeUU2RY1BMMntZWvbMOsg9R3bX3Mh5bcS3uMdlhBbaCQRmAK5Bw2bOaHDi7Ji/KlnraNW/JrSzVgk1p90PfpgIsCWpxbNIpuXljZEKoqUrrOWXBI9ymZ+YsgqszSwnVsKdqHV34HdgaZYZZuvInJhAMyKJj7lyn9V8BpIHY+3eiRgKkmYuLX1a/WogSyDE3MkzTQ87lSho94vXc7OhpIOBBSI0+26heE7svRqtCWQzeuHzD+N2oLTdBBgbKTk6pt/VH3NQIdi+3WGi+kFQEN76+kfIaxNYjFH4fsNssDkmPxWSnsSHfExjaaQ9PvLxZajStD71pvlz7TQatcK7RxXTWMvy36NiTPg6NvZgas18JDjYkt04fdfQWSWs/LlBWWrfsbjv7ezkMBKAxJP4wMO6Y8b/i+t5BJywnZHCS2GstSo0cmEn/DiMB+Jilh29M043VJQU/ZPnj36THj8Iyglx7Cg+bfwtOVejaBl5TQlP3EU3MbOkf4zXPiBO04UUV9yl93OiVG72xzALcnYPwf+FVdllY32NEjl6LzIK2VK6M0mpq6MwCnd2aCg2vA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhUQTA1MDJBVFZVZTFxb3Blam5GOU1yZVE0YlpEQnFXZ0dEM1Z2QTVIS01o?=
 =?utf-8?B?cEUxczBBSUt1ZkJLenBQcys5RVB6Zzd0cDc1ZXFJNm5zNHgwc05QRWZoRTlP?=
 =?utf-8?B?UFkwaklIb3kwZmNoVDB2VXNaZ1JabkF6ZWZreXpYczBwNnIvbG9ZcG5nM2FX?=
 =?utf-8?B?MEtCUjZ3QTlEMDVMVmtKb01BQ1FPb0RzWnZneDFIREtsWldmUVk3MXpHcTNq?=
 =?utf-8?B?ZjJyaGRGNmxUS2xUdS94eXV5UGpwV3dnZi9tNHVEd3FtVURZcENITVI5aFpl?=
 =?utf-8?B?cHlkVjdnS1lRT2ZMMU9ESVRWRHZiMC9IaE04WnBsV0xsTnkrbWZJVTIwUlBa?=
 =?utf-8?B?NlpGSlJZSkdOR3ZUc3duTFdZcTNwRllIdmIwTlNoQWhIVzMzVFp2R1NUYVFo?=
 =?utf-8?B?SUJ3SWtmcjZESzJOZCtDczM2S0pyellNVWlEK0tubkRPanRsUWZjQURuQnhY?=
 =?utf-8?B?T2IzVDI4RGF4L1JFeTRlamYrSU00VFVHVmhRdmpJM0s5azY3ZVRraWtaNElp?=
 =?utf-8?B?QThHeHU4dG1sZE1jcU5ncndYZU1iMFBKWC8xK2R1SEcrcy9xa2gxU1QvK2FS?=
 =?utf-8?B?c0wzM2tweTFTTW9WUkN5R09MV295V0wrME9YODdzdmVtMW5UQnRibFpCcmlM?=
 =?utf-8?B?eTJ6Rmh3WEVQdXB4azRwWnUyS3JGWVc5M0pianIvV2IySzI1YkQrcnUvMk9h?=
 =?utf-8?B?UDcwZXdzV3ZOM1hRbEZNTjZTZjhGMXorYWVKcXVLM05aQzNLVEw0UXphckQ1?=
 =?utf-8?B?NWxJb0wzVkFCSDU1OURUZEdBU1BYT1hNTllyMHplYit4b1I4RHVlem1vZHhF?=
 =?utf-8?B?TDNIbDN4NlRCQWVDMHB3cFpteVpIRFJIZGFFUDNzUnZ5TWpzb3NjNUNlTUNN?=
 =?utf-8?B?Ny9oaDB0MWZkcW42TUFRdGlYUG1pVGlNaytQeTRUZ0JIamFBRGhxVXdDblNO?=
 =?utf-8?B?WFlmTzYrVFA1TFc0STNwZytuMmZiOU9HQnVUWUIwVGd2M1NkVW5IQllvVmNX?=
 =?utf-8?B?dzdIdUJqY3JHNWQ1cDhLWC91MTVsS1hWWXpZUjRMamZFME44MW94QW9IaXFV?=
 =?utf-8?B?dTh1akFCdWhmNHoyZ05JTzMrMm5icGFPcjBiR085ZjdDQWtad1ZHQndpTVpD?=
 =?utf-8?B?K2Jwa2NNd2pGL3hnVFUreHRWZy81a0xNQVliUnBZQk5PL3Q5bkM5c3c2bElr?=
 =?utf-8?B?R1kxcjNHZmJqWHFUSUlvV1NBQ3Y5U1Q3WWFJbHpXOTQ5SjJaa2JnaFgrVHdk?=
 =?utf-8?B?OWdvZkxUeVNhYjczU1hpdE9zaWRZWG0rdFQrMWRXWWhPdyszRmZFOFoydXpy?=
 =?utf-8?B?NmdwRU5BZjNDWk1GTEdjSHNtaFNTVnpsWVkxbjBMNU90cE1Ga1owZkZhSlla?=
 =?utf-8?B?UUJpVnJSckttbHl3Nmt3dkVPQ09LRGNMREttUGtmdlBQZERBNW1iSGpxVDVu?=
 =?utf-8?B?cXg3cmhEOXlvTzV4WTZsbGV5QS9STXdoT2lhR1NpK0ZkMkt4R3licHZxV0dv?=
 =?utf-8?B?blQyNUx5V1ZDeS9ocHRKMjJQMkhSV0FIUmhEdVNPMG5iWXZ6U1N5ZmJHS2g1?=
 =?utf-8?B?UE5oNVFOaytqUzJOMUVhdGF6YlV0UHk5aGV5dXVQZnNyc0M0QlRkT2g3THFr?=
 =?utf-8?B?VEV5WEFQSHhLczN4MTZRWFErMzFCTFp0OXVzYXAvbC9QZVNXb3ZXdEY2cGNK?=
 =?utf-8?B?Tkk4Skx1VmRjcDhCbXI4Y2VYUGFjcHlsQnJ4UGU5NTBWSStLNHdWcjNXTUJj?=
 =?utf-8?B?NEQzd1NxdXJ3RmVKeWFxeEFmN01uSitLanZIY1QyY1VqdFN1Z1BlNDRNc0xu?=
 =?utf-8?B?NG1kZWQ2andXNmhrU2ZFUWNKQUw5Mi91T3BtdmExV0EyZUV4S0hGNjFzaTln?=
 =?utf-8?B?L0FDMFVSNy9xb3RZODBSSEpzNUR0OE5NS0tEZklmcE1KWWJ0L0hrT0hsQmpZ?=
 =?utf-8?B?ZmxRNnEwaTQ3WWxCSHFiRmRoQzRuVzlDOFU0RmR5bXNVVUNOK1JGT3hoNU03?=
 =?utf-8?B?YStNeGFJazIwWXJjcm9XSEV3MDlIcm83OUlFTzJLWks3cmZacWNqdG5Ub1ho?=
 =?utf-8?B?Q0FaMjlGNUZBZjRCakQ4NWRvaVFXcGE1RE85SXU4RG40Q0wwWmNiVU9TZXlj?=
 =?utf-8?B?bElFVWxZeWEzSkk0TGp6YnAybkttSVFNeDdYRXZabGl2b2wvb2xDREJqdlZj?=
 =?utf-8?B?NWtSY2pYREo4WTJma1EreVZsc0xHTEhXcGNLMTdSQ1RtNkx0QWNlOE4rYTZG?=
 =?utf-8?B?QmFYUVVQZWg3NDNNZ1RjR0grd1VMbGpHOEFmdkZPOUh1RklydE5yejhPeStJ?=
 =?utf-8?B?d24yZk5Jbzhad1dEVmUyZGgwdDRud3BHZXZrMmhlVFIwMjRVTFBhdVFmQlhs?=
 =?utf-8?Q?L49wc0YKnuYtwHx7Et83UkjPg9pxxO6fXgIf01wr+P4nm?=
X-MS-Exchange-AntiSpam-MessageData-1: R+aB0C1tCkjZsg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce596ee-0637-4291-d91b-08debc5b8fa5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:51:13.4839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taxB//q5MMGqxXZpRvnyGGTnDW4FeJ2NKtSgHfaMEFgxnbYQq5pXqDAI9vEoJ3a7uYVdtWbLNtl0TgBhcRfLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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

On Wed May 27, 2026 at 11:02 PM JST, Alexandre Courbot wrote:
> On Fri May 22, 2026 at 3:59 PM JST, Eliot Courtney wrote:
>> On Thu May 21, 2026 at 10:50 PM JST, Alexandre Courbot wrote:
>>> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
>>> memory region to store the GSP firmware, and the Booter Loader loads an=
d
>>> starts that firmware into the GSP, making it run in RISC-V mode.
>>>
>>> These operations need to be reverted upon unloading, particularly the
>>> WPR2 secure region creation, as its presence prevents the driver from
>>> subsequently probing.
>>>
>>> Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
>>> the GSP, so they can be executed at unbind time to put the GPU into a
>>> state where it can be probed again.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>
>> After seeing the bundle moved outwards, I realised that it has the same
>> issue that SysmemFlush does, i.e. if probe fails it does not reset the
>> GSP. A lot of the time during development I will break things badly
>> enough that probe fails, so it would be nice if this is supported. OTOH,
>> this gets the probe suceed and unload case working which is important
>> and this is a definite improvement, so for this version and the previous
>> version of the patch:
>>
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>>
>> I also had a brief go at making this work on Drop, here is the diff on
>> top of this series. I can send this as a follow up if you would like
>> after cleaning it up, or lmk wdyt:
>
> This is clearly better. It guarantees that the unload sequence is run
> when the `Gpu` is dropped, while preserving its one-shot nature. Also,
> no `Cell` and no awkward output parameter to `Gpu::new`.
>
> The only blind spot remaining would be to also cover the case where a
> failure occurs during `Gsp::boot`, but that's for `Gsp::boot` to handle
> itself imho.
>
> Would you be ok if I folded this into this patch for v7, with your
> `Co-developed-by` and `Signed-off-by`? Then I'll also try to tackle the
> `Gsp::boot` failure scenario using a drop wrapper or something similar.

Yerp that is fine of course. For Gsp::boot it should handle unwinding if
there is a failure but I agree it is orthogonal to this case, so
addressing in a follow-up SGTM.

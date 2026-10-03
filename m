Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3DBCA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D22310E027;
	Sat,  3 Oct 2026 01:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYEjQtRk";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0705310E027
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR0QoyvjdMcqzbl5L1bySdkYi3cvdQ5AY0aIvFPEx285e5O3eZbuTlD0opI/GydGza1rYIT1ZKiPHb21hcsV9cq/Sj8ntdN49UpRaUsEsFIio5imeD4HAItUUh6MxG3t63w+sn5wzvAFR+8zOYJxJ0vW9XBSq65u31JJa0ZU1dh4mawfmOeYCtVmijOarriE7yEKCdjOxvKjlTYx1WCu/Gwuf+zJHnMl4EbTt9TOdoIWIql39eVPXyory6TNU0/piNSqC4iSK/2Y/a98U+/iQ0FgrSXilKR+xejbgCynmvJsqusrWnyQJaGBbkhyyPljQTUHogv+bTeKQr3FngQD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ2wGqfdZcsExFQs1t/crp9XjAHoT8maiqXMI3z6P1k=;
 b=UHiWT+pYKYqd39MvUkYLHX4exY/EGx5HJj9kSXmPkfPYWvY3KSVx89n/P79awrwntWs79Zjfac+WaxI3z+5fuZQiAiNaNz1SYABDaK8Ty/bOAmIp5ltaeKJ+AciQsHdK6LM/Tsd5nfomp9N6ImnMu+QRm4Xddy7wQpUzE19qmtcMxzDdopuvpvYq5uw41n0WepzNhHmwCX4oQEOCKM9/gD28jGqHbDgvIjbH4CyA3KF0a8m79UOHfH2C2SjVxErA4XJfMZ6++ns6FDwLCnO4trL2FgAgE3KfHs41BmP7bIG3zinD4eDmIA+XMUwFzlvGt/ilD1AT1ThfQrRJHpHlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ2wGqfdZcsExFQs1t/crp9XjAHoT8maiqXMI3z6P1k=;
 b=aYEjQtRk7dM2hIcxbthEmv4uggrDdvalq2rxo/Kk0sfgaSwr51xYCcfuyDN6vcPlqcNW28/7wUghcmpfIZT4a21hbWauGff6OjSWGiYfc9TwZmTj+oUjrv3cWq8Fh4lijYumaEyht2izZkcFQvkjqqb/MBxdk0Vzd3znvu/MFTm/AN+jDA0gKYFay6HcAMxzyitnpWRi3n+NrQ9GT8s0zBvuodPk4r+EcOO/n4i0UnnkHxD68dDIpv+9e1V2jQfdpeF1R1XI5EWW26jmdQNevXmlRI6xLNXcyZPirjBssoqYNeXQ4OnRYJlZGD0U4NK7wPQIqUzeWAlskFlqAArDWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 3 Oct
 2026 01:51:55 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 01:51:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 10:51:52 +0900
Message-Id: <DLUTSDP614AJ.2JU6SDKECJOCU@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Robin Murphy" <robin.murphy@arm.com>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Matteo Kloiber" <kernel@matt3o12.de>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
 <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
 <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
 <20260927224446.1053037-1-kernel@matt3o12.de>
 <DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com>
In-Reply-To: <DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com>
X-ClientProxiedBy: TYCP286CA0289.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f6d5f1-0fc4-46e3-83c3-08df20f0e6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|7416014|376014|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iC0sApzAJXxOev1jar5GMC4M362srcrr2/mdBgwPt030g5cloHg4f9MBWHmkJ/YBEvZu96Ys2fN7ojLIFJHTVSTP12SjccvQ2YLkniqK3EjVw3hGOO7o80poQAo5kkIcQnMKN6iK8tZsIHPMKCrz9yD1mjQLSCNKAsrY3NtRfy9GFFA+NZ5aOHj+aQ/jph1Uh1QCXAeXVqEEKVrNYbKV0/O2p8wnBhSbq2dW7mnDp4XFIE3gpf6eJyEeFhCVtWMBkAtoQlZQxsPjQYr0Bdh050TgJEms+wGTwP7tr67bu8a7gDccqT9uKTWVo2UYTzX99evMP1HWcwXO5fhYDPe/hTGr38FyhVZORt8JsnbXOQr4Ku0plcGhN+NZnyup/NapSs6DeBv8UFzxqApXEVjZ80viI/3tR/i1a6nCWR9HtBaamPoJKtFt3SGb15Mee+w9T+Swrf7fAQQ3AwJYyVhtN1bULQFKN2R6kJZXcbh83EOudX4tZYLteWgiwFW5EoJVtNMvLX4kAi2JXip9L2FsWx2c8ffyAyRCgjw6nLiZ+snVAdu41cDjOS09X9iAGVYZ0fnWolFNRzKc1tBuebsf4/7zowWdhQzcI9gZz3cQcfJiqR4OJeJXymF4AkRLjL2QIGw+KqfA3xM1cca1Fk7YWn2DgRkFzOi08K5FRMuYWys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnN5aEZPRGRrODFPU2FTbUlhdWMrNGVJZUE5SmVlQXNnK09vLytHMG82S3Vj?=
 =?utf-8?B?bFJXZE8vb1dNS3dYeEdxK3Y3MHN4d2psVG5OZXE5aHRYbG5xU00rODF5ZkRG?=
 =?utf-8?B?SERBTTBSQXNoU0Y0ZVE0V0tLcVdycHJXcnhqQkkzU0d4N243dmFxSjV6Ymli?=
 =?utf-8?B?Z0hVTncvNmxEL2ZCa1NOaytNTHRaLzNtNGFCejE1Z0xHblZBaEdJc1ZsMnVS?=
 =?utf-8?B?bmUrSmtvQ282TENpTmtsMkZEemJQSlZnMFRNUFZyT3N2cEJNSnRpejQrUFJl?=
 =?utf-8?B?cHFFTTdlVkhsbDloK2ZYK0xQWFRxWVhrWldaQTdsV20wK2JsUlJKMnNGWnBw?=
 =?utf-8?B?TTZXc2I4OGM2QXFFS2RPU1FTMkJLV2FUVUhEK0lqcmJDVGpUYnRkTVRtV2Ux?=
 =?utf-8?B?NjMyVm0wQUZSOVk1YTVvazhjV3RZTWF1YVIvNjltSE5uQ1JPY2VLSEdaVkNy?=
 =?utf-8?B?ZzZzaW81YUZLdXdDalc3Z3lRRGd5VndtMzV5NlFhQ25Dc0pTczc3bFRtYklN?=
 =?utf-8?B?bnkxZm5KYkdJczZnS1Z4VHRwVjZwRGFpVE1ZSUJxQ0Rob1RZUHBrTlNld3hl?=
 =?utf-8?B?TWdaMEc4eCtqTUc2cHk4TytHK3E5bUtLcHlZT1k0V1BvNjMzbWlNSmJESUw4?=
 =?utf-8?B?TUh4QktFeXVyS0hwQmsyd1hhbUpWRGh1SC9maXdUZlhwTHg2Q3orSzFkZHBh?=
 =?utf-8?B?UW1vUmJxNW03YVRhc3ovMkJsQ1VHQW12OVRyMEkxczhXRGhNSVB5KzBEVzM0?=
 =?utf-8?B?SVN4VmhBRkFUcTJFZzZFVTNyZll6SnovZUJoU2NzQ0ZJTnZJNlBhdXVCK1dp?=
 =?utf-8?B?WlF0R3JwZGNCSXNFY0NsSzd2OWZrb3pJcFZiMk5MUHpwTXdRd25MM1ltbGt5?=
 =?utf-8?B?ZzJCcEFBY2lqSDcybzZGUms2Uk5aQTVDK0gyU2lKRGNXQ1NBOG05eVJPYi9v?=
 =?utf-8?B?ZHRzc1IrVlBLT0RRY2VwMEhTZ3V1eFM0SUpkdXN2eGUrdW5KMVp0eTBVSTgr?=
 =?utf-8?B?M3ZtZ0FCZTA1MlVyMXlQTExVR3cwOXhhU0FuTzAwM1FBOXhzRW5vUVJYL3Np?=
 =?utf-8?B?QmxDb0ZoSEYvS3E3SDBMbGxoZDFqaGZjZjhYdG5BRCtITDBjVlh5U3I4TFIx?=
 =?utf-8?B?Y0lxQTR1a3lRS1lZK3dWcUFPOTRqT3cydTUxVElXTjhCTEl4cUNvRGxLWVVj?=
 =?utf-8?B?WkNtUXNma2EzSVI5cEYxbkVHdXRhS2R1Y3FTT3BBRXVlS1hpWnNqRjJGVmtj?=
 =?utf-8?B?bzVPTmpjME11Q3l3ZmJTTTJRK2ZyemZZQnJldGJHT1NxV05xLzVEVWNidFJz?=
 =?utf-8?B?TDc3SWFjcEtZWUQ5cHd1WmVHMWtTRk9IeFdsQzZ6UjZ1MTZhU3dFNEh0MjVz?=
 =?utf-8?B?RWFvdnFOcVpQQXE1eWdFNlU5cC9ZM0l3TTVFVWpyRXBkVlZxUER5ZFYrb00z?=
 =?utf-8?B?SGJBS1UxTkRmM3VmWDhTMVJDR1c5anhXc2lWZU56blgvT2FuSEJkeEQrZkdG?=
 =?utf-8?B?V21XSERVUnBUdFFPKzhSNWRPL256OERzTmhZNHNzVE5KR1I1MnBLbHNCNWU4?=
 =?utf-8?B?b01OeHlaVTZpWEJlNEVZS0VyMlJGSjdXbm4xVVhBSDJrdzBHa204UzR4anZq?=
 =?utf-8?B?YXhOYWt0am83NWpZQ0dwcTBVWnJUc2h3OEZSaEF1SFhiSWNZRWdGRWphVFIw?=
 =?utf-8?B?enJGbDFFY1g5QnRmMTNFaDlSZXhxY0V1bVZLMXduek8rYzhsQWZRY1NsTWlj?=
 =?utf-8?B?ZE96RzlYakxmTlg3dW5aMGN0ZXowbGM0ZzlFd1VBSnZNK2xKekhIa0V1NFpR?=
 =?utf-8?B?SVNWTFBzUDN2Rjk5T05aSlFVOEtsWVozeDFGcTd3ekI2UDF5NE8ySUNncCtF?=
 =?utf-8?B?WkEzRW45K3Q0c1pmSkxZQnJHSGlrR3FvUUl2cmZPcWlySXhBbDVLR3lwbzNu?=
 =?utf-8?B?WTh1RUNnbW1FU2k4bzhNbkgrVE8rVDVXSUxxOEpSVDR5TGc0TkNVWW1FcWhP?=
 =?utf-8?B?bWlDaW5oV2phM3E4QTlzRGpnUzV2SWRaNkVodUJJUDA5Zm5UakZCY0lHNisx?=
 =?utf-8?B?dGk5TWNsWGI0VGxUUGM5YUoyVzJlcFQrdGd1UytJNmRYOUg5cUxLdHk2ZmJ4?=
 =?utf-8?B?L0dGL0N2K1RWeVlXdFB6Sm5PMjEySVUzcmM4Nk9JWTdPbUVzNzhNUlVZYk1G?=
 =?utf-8?B?c0JmVmJmRzdNTlZUdy9PWTlHektPTk1tQlFrcWE3MndBS3lXakNxVVpYaW44?=
 =?utf-8?B?V2ZTTUxnS0tLZDIvd25XYmZ1VWx4Q0QxTXJNTU15NXlVSVB3cmg0dXBxU0dL?=
 =?utf-8?B?NFRZSHBLVHZaaWN1VnVJV01EVTlkMm5VR0w0dC9pN1NoMVcvdVgvNE1KSVFu?=
 =?utf-8?Q?0r7r/pHjko6rlsKcFgokIZ4uB4EswAucYcxSr/mM4NxgY?=
X-MS-Exchange-AntiSpam-MessageData-1: qW2AKgg8G3TMNQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f6d5f1-0fc4-46e3-83c3-08df20f0e6c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 01:51:54.8419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1jizDDVqAP54Z0nz3R6SeOs+CjSzrMGxE/E5Dd1ITVz5SajDhFlGZQidaOuG1ylxfifAAnw/k1AC3Qsd+ZBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

On Tue Sep 29, 2026 at 12:05 AM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 7:44 AM JST, Matteo Kloiber wrote:
>> First of all, thanks for merging my first two patches and sorry about my=
 late reply.
>>
>> What I think Alex meant and what I agree with is that the new API should=
 focus on
>> making semantic bugs harder, not to necessarily make it easier to write =
safer
>> drivers. That being said, I think we can do both with this change.
>>
>> The key change here is that we introduce a structure that defines dma
>> parameters for a device. This structure deliberately has no default
>> implementation and new fields should be added even if they require chang=
es for
>> all dma drivers.
> <...>
>
> Thanks for the detailed plan; I think it mostly makes sense.
>
> A few details that we have discussed offline with Danilo:
>
> - The `probe` methods should not take the `dma::Setup` token directly,
>   but rather a bus-specific struct that contains it and can be augmented
>   with other capabilities. Drivers would have to deconstruct it using
>   the `..` operator to make sure code doesn't break if we add new tokens
>   to it.
> - The token should not assume default parameters and only call functions
>   corresponding to parameters explicitly set; converting the token to a
>   handler means the driver acknowledged all the settings, so we should
>   not make any parameter mandatory (the doc should of course detail what
>   drivers *should* do).
>
> With that and your plan I believe you have a solid basis to send a
> RFC/PoC. :)

Stumbled upon the notes I took while discussing with Danilo so sharing
the extra info that was there:

- As a consequence of this, the `DmaDevice` trait is likely to go away.
- The name of the capabilities struct is not clear yet, but something
  like `pci::InitTokens` could work (because it would only contain such
  tokens that reference the device).

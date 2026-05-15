Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2480CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 02:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A8510F3B2;
	Fri, 15 May 2026 02:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="edubf78M";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91F010F3B2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZIt2EGXNsWbfsdPPhGMmZHl9BEh//YX969l4rKSNytQeIayOVnBSAJ6yA05QhHYM7K72/IJCcm8hLNrC4WnccYsLZocbHUWV2KYEePS4H8beGd4mRWcI1lCGfd+t4Q331G4tSfcXqckYR2XeoxH5+gHskgKuZwr+JB94R23iVzSnJgu4iR0hqiejvN9sEK/qNG7XDQ91l6QoDKJE+r3tf632QPAkiq9kFTn1zh0CaX7LVW68guZxE6uuyOIirw3lBQPYX3sM29kf0KDByi5KofLWmdvtlWWzFFF6cBtidaJeTfoFlwMT/iH/2E2/QAWud4L/tPnT9lEsV9q6FnlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U/ksOXLHJZTLLqgwkwXTzXGIFOHWDhY+bqVuQvqayg=;
 b=UF4hLOXK+ie6BXA+bUMvKI9TvR+7pZLq3eKP6x9ZVO0A5jvb838YcYfR/9jHOgYZi/ORSEOPDNA4fCPeA0eHwa1DXg8In954bRO/KVcTkW3hOw+UV69m9qD3q1kK5A4CgsWrQPq/oDFaQ/6oUQE+iM8ZjUZhKEaNCLegiR7/64m+NUoeFd1pJhEiPpToU4K9A9KoBzJ6KCLCnfRdjfyHZCtKR5YD7vdb2UuyovAv94v8DMU89Od+J304kIFooNgTtoy5t5fT7BiRHy1G4P7rcUc3wS7mMzh3lNkVkZs/Swra0I19Qbx4n9DhIEqkGmyh83C0KXEj0K9tC+O1AiWEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U/ksOXLHJZTLLqgwkwXTzXGIFOHWDhY+bqVuQvqayg=;
 b=edubf78MNYyon30oc9woHGRgxzUOf0BpMpfLSzLm2HduHHaCH696UyznJ06KxDnUUJZtuYGwEDgc9uAb/TS/72kVFi+gcDjoSB6u+q5Zt0nldb+B6hX/brVIuLTsw42FGJOET1dpuun0b5AAmfECDF1Mzk/du7+hMtW5uAMu03fYKlCQtdV4hT5CPqVZbon1R8OIb91yOQBWewsvHGqz3H7khn9TQ9EpzTA1ikZ2evVpRssJwdSF+OdkSNVpprUwIPAgMkhr99/NDsWpnN6QG7UdZ6omMqUEjtpPdcz9Iz0hWmI1K/0D/GJeMGqfuTAnIhAO5W0eKZQskes3UFPDsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 02:39:28 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 02:39:28 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [BUG] drm/tegra: DMA buffers are not always freed
Date: Fri, 15 May 2026 11:39:25 +0900
Message-ID: <QKr0fha2SnWy9Cj9I74wxw@nvidia.com>
In-Reply-To: <CALHNRZ_EjqA4aeqZhmicRwdpMxjKp1QpwLW98dyRa36HBX8aDA@mail.gmail.com>
References: <CALHNRZ9mmf_4OagcooO-s+SU1KrggT5_ZwM--ambxZKXN-oQDg@mail.gmail.com>
 <I47hlmySTbquW1VgZFOofQ@nvidia.com>
 <CALHNRZ_EjqA4aeqZhmicRwdpMxjKp1QpwLW98dyRa36HBX8aDA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a38e63-15b9-4fab-2443-08deb22b2fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|4143699003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: i4qqMEZoY7M7E0VeB/7Btfy2hZCqYKBWxFSMWXRRKzp5iO9OxK9Ah5xDsCfWpVROTbeif4b7hSClVvl7zSZhn07Y5d0ydBKnYiJEH8Z0SqoMg3T/ce9uc73caRMLtNFuZerbLlKQIk1pjKyVEP3/Z8s7T7SSJNjJacH3gdVMuzEtT/Dwm4zRPwoLXazyxQsBTgc8B1CQX4IJJkB3Gccyx8wFKm3BojOC3mWKEBJDmNNwkICdLJyXmz+yvKnOulxJWvsKXKfxVsFpgn3bwgXYIJKJfsOx/esVb7huTRWFCypFOxdCkbiYIlQcLNS5GU9QjWWXSie6YSUOiHhOb+Oakya9S2+SM0C6p9pbzZYv7zZBkZGAxsPqq9HD51pv5670mm6RL+Sq+JZyqDP/HCGB5KIE8kGEmktrzo68NEu1puDH8j2KAbWgrIBg4dN/aMYXB3exw3MCOtIeKYjPvFvZasj/GdpgNvboWCHP9R1dxz6PFFetSvdYRK5zxCSNRRInGwNRmjCf8g20s7PI1AdAfd5wEgPCVxXqBPpwrIL486quDx3Z78bHdbqylngj8QHEPyC+jn2Brt395YIHeM2mgw83Wj4m5pZyPtftCvr7CjQnfVPlNpyZ3QazMkFb8C2T4VLt6TlonyTuW+oZ4o0/5IjFO9TGwiOmW1fUfE7+LChsMgGz1nFcMcipvt+ryQij
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(4143699003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNTTFdXN2FVQ3IzYno0bXN3ZXJZQ0VSU2UzY2pGQ1RIUEpCWVVKUldFTU5v?=
 =?utf-8?B?L1REMEN4OHQ3VWF5cHpCbUVvbGlaZlNZSzZxdXAyblRTREpqU1lBS3NJaUxa?=
 =?utf-8?B?NU1Gb3FMRVQ0VDAvWHQwN1RNc3pYQ1lFekVCT0phM0pOaVFIUzJOeUVDd0hI?=
 =?utf-8?B?NUtIa0UrSmd5c3I5Q0NSSzlqTmp0RGhseEZ4VGd4dTMxaVc2QSsvSzdGc3Q5?=
 =?utf-8?B?T0ptYVMwSElTZFl4TGppUE9nN0lwTGlNQ3FxeFBNbVpSMVlZb0FuTktJVFpM?=
 =?utf-8?B?c3RhaGdLSC9RQjlvVkFXay9SUWpWcXVtMXNPWUZIbnZ0L2lVZnlUV1Y5Y095?=
 =?utf-8?B?QnNkQldvZzk2MlFQOThsVTFBUEtCVDh1UDdwK3Frd3NtMHV0Z3FJSGQvb3o1?=
 =?utf-8?B?RWpZSUdMYVRTUEJKcnYzMExkVUhUa20zaVNMUTR3NFIrbHN1TFBYcWt3R0dz?=
 =?utf-8?B?U0VtMGNFMEd6R2lOamZjWC9WaTFrcEJJV2tWaXdDK2FWYnA2UE9BbHRJQkpP?=
 =?utf-8?B?VUVnRENiTElDY0J2bGZkdlpYcnVkVEttbDlmWDFiRThJQnRXL25GV1k1bCtE?=
 =?utf-8?B?dzB0dDYxTzNQVjJmczY0VWdjOXl4YXJ2bGJXN1Y0bWU5TVZhSTFnVHJFREsv?=
 =?utf-8?B?ejRzeEJYYUcyZDZFeFdHcTFISlJBV1FOMXI2N0ZzSG55bWRlUVN0ZGl5NHgw?=
 =?utf-8?B?UllkZzRyREVFOEwzUTY5Q05VUlJpcEw5STBWNXRXTEFiWkFXeXBySWQrMnNQ?=
 =?utf-8?B?Sk13eWJQcXhkdVZ1NmRaaEMrbjl4L3loS1doVGFDejVKOEFMQ1NOWExPeXBa?=
 =?utf-8?B?dXRCN0FKZFlQNVVVTVE2ODUzdnN1R2dERmVveEVYUi9TVHByVmZYZkprMFZ1?=
 =?utf-8?B?dXpwTzNycGZGeDNHdWZ1TjBPbUR5Z1lFNngyWUFvcmZ0akEyK09IOWJua2Vo?=
 =?utf-8?B?SGVKaE5ld1N3YlYveStCRzJCTjlybUMveXFKdjI4b3B0d3czMFBQZS9wZU1L?=
 =?utf-8?B?c2NhRitsOFFkYVlIZlJDYkREblVTbW9DeEJ0YjZtWGZTTU5BdFlxVytQOWJa?=
 =?utf-8?B?SVo2YjZBcFl4amxnL2pPMUtsVHN0OGRDN1BDUVVnQkhvbnBSOXlmbWxPa0hH?=
 =?utf-8?B?MFRiT0IxMHRVOVMrc0pNU2NyNjFYMDdnNUlQN2hkaE9hSS9Ra3EybmtVZy9o?=
 =?utf-8?B?eDFXMXJ1NFRHQ1gwRzRkQkpId2hQUEN0L3hDTnUyQ2hHNVZ1c1VaS2hUOUox?=
 =?utf-8?B?VEp0TEIwOVBRWlplSDhNTVRRRnRIZjJRNnE3Mno1RklQLy9DTS9zNXA1S25D?=
 =?utf-8?B?eHBab1JvZGVnK01uNXhpdWtHNGZJMUNiSU1zcWc3MjB1YkN3WDJuUWloY0Fs?=
 =?utf-8?B?dDNvMUhBcjhld3RFRXUxNUZFZGtPTUt3ZHRSZTZkbC9ZdC9nNDVmWDU1ekdq?=
 =?utf-8?B?K2lOZmFYc29yLzViclA0eXBzWkVLM05Yd1VxNldxWXVSV3crZ3V2MC9IRWYy?=
 =?utf-8?B?SWJEaTBVTG9Yb0xrQTc5dnd4Qmk4L2QzbjI0a2JySW53eS9xdjdFdEJ0VUNy?=
 =?utf-8?B?U1MvbGpySHQ2cVdobWRDUG5JKzhhVXVWMUFwUzh2bThoc0pxVi9kYTU2T01q?=
 =?utf-8?B?T2tNekM1RmlsL0RJbkRlOGR1SVR3alJzYzY3TjMyRklXUHp3blQ1ZDc4TFAw?=
 =?utf-8?B?YndoOGJHaCs2Tm9weEhhYjVTLzRMS2FMdlNCbGdnVGdkN2g1a2ttY0MycWoz?=
 =?utf-8?B?OFYxTEgyTTJBV1V0Qkx6ZThsaDJjQUptclArM1dKbFg2WXd1TlM5NXIyNXNt?=
 =?utf-8?B?RmxtclZCTVN6d1JkVU1yUm1Xcnl2alBOR1J5SlQwM2hEUVFmcSs3SzY1ZE1q?=
 =?utf-8?B?a1dVaHE0VVQwcGRtbXRpcVZpSG96YmFudWw1cFRYZDFMNzgvRDVhcmRsdGgy?=
 =?utf-8?B?aHlXVVkwS1dFajZBYnVNNE1uYW9wK3R1UFVSK0VQZ21URzJkSHJjQlBzZjQ5?=
 =?utf-8?B?NWhBNEFrenVYMGhiVmR5RUtjS2VLZTBDbWxpd1VRakZUQ2pFSjc0NE1JNGJG?=
 =?utf-8?B?cHZVSGVkVSthTlFYd1N1bnNrWkVpZUZERXFZaXY4bkQ2ZGowSGRMaVJwdUNL?=
 =?utf-8?B?WE9rV1RBRHArUmNidDZ5VzdsMEFvbWNFR3FBcGtKZ3VrRmtkMk5hcE4rbzN6?=
 =?utf-8?B?VVlXQ3JPaHR3Q0R6eHliemNtSFVYRHpuQ3ZUMGNEU0g5NmJNVFkrbWdqSXBG?=
 =?utf-8?B?U2hOZitrRkZsNituUm1SY0xGRllnU2lYaDNiL3U2M0lrTzFDR2E4b05ia0FI?=
 =?utf-8?B?MHVCT3ltVTVTTmJuVDg1VEdrRHc5VzlKY0RiV0VjVkMwNEp2WmxHQjhUNWtR?=
 =?utf-8?Q?b1rKg79rcWtkR8gIt6CXj3z2nLM4lb7SpUYU/4OsTabh8?=
X-MS-Exchange-AntiSpam-MessageData-1: CGyf4qTmJOAkkQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a38e63-15b9-4fab-2443-08deb22b2fa3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 02:39:28.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5vN7RYQmuSHR7VZRbA+jzEel7XlQnpSu2Mv4IDLt+puidJzi1hIfQfROzbFvAkVhPW3C3szUtkAEEiIEVhxwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

On Wednesday, May 13, 2026 1:26=E2=80=AFPM Aaron Kling wrote:
> On Tue, May 12, 2026 at 10:26=E2=80=AFPM Mikko Perttunen <mperttunen@nvid=
ia.com> wrote:
> >
> > On Tuesday, May 12, 2026 2:29=E2=80=AFPM Aaron Kling wrote:
> > > There is an issue with tegra-drm where some buffers get created, then
> > > freed, but the dma buffer never gets freed. Causing display controlle=
r
> > > memory allocations to start failing after the leaks fill up cma.
> > >
> > > I created an issue on the freedesktop issue tracker [0] with a patch
> > > with some debug logs I added, then a log from Android that contains
> > > these logs. CMA is set to 512MB, and when allocations start to fail,
> > > the unfreed allocations add up to just shy of 500MB, where it's
> > > reasonable to expect that 8MB contiguous is no longer available. The
> > > log was generated on a Jetson TX2 NX, but I have seen this leak on
> > > other archs as well, this also does not appear to be limited to soc's
> > > with nvdisplay.
> > >
> > > This does not appear to be a userspace issue. The graphics allocator
> > > works as expected for other soc vendors. And as the logs show, the
> > > delete dumb buffer ioctl is called, but is not always followed by the
> > > dma buffer getting freed. I have also observed this issue with a
> > > gralloc that uses the tegra gem create and such, this is not unique t=
o
> > > dumb buffers, that's just the last log I had when deciding to post th=
e
> > > issue to lkml.
> > >
> > > What I primarily intend to ask here is how to further debug this
> > > issue. I'm not finding any direct path between the delete dumb ioctl
> > > handling and gem release or tegra bo free. Can someone point me to th=
e
> > > pieces in the middle I'm missing, where the logic is to decide is a
> > > buffer should be freed?
> > >
> > > Aaron
> > >
> > > [0] https://gitlab.freedesktop.org/drm/tegra/-/work_items/9
> > >
> >
> > If the issue is specific to buffers that get used with display, I have
> > an idea of what the issue is -- there is some circular reference
> > counting with the BO cache in the host1x driver, and that means that
> > BOs that end up in the cache never get released.
>=20
> As far as I know, this only affects display controller buffers. Though
> unfortunately, I have limited ways to test the media engines right
> now.

I've been working on some more userspace for the media engines.
Hopefully I can get that in shape soon.

>=20
> > Let me do some testing locally and I'll send out a patch once ready.
>=20
> Sounds good, thanks.

I posted a fix, please give it a try. Incidentally, on my side I don't
have that much testing set up for the display :)

Mikko

>=20
> Aaron




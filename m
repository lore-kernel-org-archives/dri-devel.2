Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7CCFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAE310E8C8;
	Mon, 27 Apr 2026 18:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I1yut299";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C5A10E8C8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap20uevCSqKGSvKJ69QsOL4KhivoT599kwU2qRQ8LSmqq0QNeyTqUgrrRwsT2/M9ZzJAyqdLr1MzTX8iudhhCR1TEDLKzCEZUI+4CsWw8pYtARwyWrsH8a7/yb+lrwULD1rPi9cB+LZBBz7kFK3DfIrMyUAuXcr1aQ5F9+Ty+ZXhwt4ld8Dhzb5HqdIu0DvpJC61ipFwZUOcxeCk/i8Edr84G7Moq4QBo6gxlZsPndYRr4fGwxmwyHSgyT0I1hMYqS4lgmamdoLQrLUDB+yltvWGaJjylFdzE2pVfJCQBZv0/FtXPYwtQFZV3JT/wg/ktsnKuS7X0wa9AA5OTu07ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLLqiW8xwkeoTXQQR31xkKJxG6JJl8BBBWXhg+9qTzA=;
 b=K8fRvXvidYmwgK7L8aMjm/uyC2+zOHjYi30Hm8+3+zZhXgqsmrX0r9GSJcSm8vUARL2xAiL+OgkRZugH6VpcwTyc/wqUdlRNrzfS6HgWnTuZdh7TsOoDcu4ADuI5056qe7G8FidygB8LQWCmnKqX1JXaD0lEZszhHsVMYuUAC4cRDTU7qEAfGXxbVrxUMsaKOYb8M6zld4hUQh2+Sd7rmCjFp3yeaqUfB1LPf245hHVKqZYVkR4wWtk6VRh2wVWiXadexE1DV0CQkA3enJnh2BIR3uJiZYTXCBCWgkx15LSoE1AzBopf/Diu9A2X/GRO7D47vgHzHwdBs69AIMk8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLLqiW8xwkeoTXQQR31xkKJxG6JJl8BBBWXhg+9qTzA=;
 b=I1yut299H7QPuYtLyao8MXf2HnNNCqtpMVd+22Iijqbg+Mn9sQP/Q7FqBdm9BaGiIQCrcEZ9ILOUvKVe2WBjcVjNlCbTDQmUwgBCgp+ZONk859/dhJr+3wU/MOja38ANvgxt2TZPIQYtof2yE1d65lQrk0IkXNTKYvtte7TyF9o=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:38:19 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:38:18 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, list DRI developers Maling
 <dri-devel@lists.freedesktop.org>
CC: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "lucas.demarchi@intel.com"
 <lucas.demarchi@intel.com>
Subject: Re: [RFC] DRM Equivalent for top
Thread-Topic: [RFC] DRM Equivalent for top
Thread-Index: AQHc0mW2LOOguaVTGE2Vl4MtARC+yLXrLjGAgAEfjwCAAD8SAIAAGN2AgAae3Ww=
Date: Mon, 27 Apr 2026 18:38:18 +0000
Message-ID: <SA1PR12MB814414F7DF978B9FFA3B626DEF362@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
 <c99d0439-767e-4a87-b47c-f9d6020c774d@amd.com>
 <f37d6f6c-49ac-4725-ba4f-b7ce0a3baa5a@ursulin.net>
 <759f311f-3551-4a3c-b889-8149de7081ef@amd.com>
In-Reply-To: <759f311f-3551-4a3c-b889-8149de7081ef@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T18:38:17.558Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|MN2PR12MB4408:EE_
x-ms-office365-filtering-correlation-id: 11e7c583-3e53-499f-21a8-08dea48c26bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info: rrND+/MkqBkW4PycZ//XV3EuSXFH8BwmWPM4+cZpZK6eE6kIB+choqG+ddewI86Pk65omXJBKU9bxa9UyIyVY5oBjetQj7TCHKh6kowiXQXlTsNUgrw5eqIAJFtDax4xkOh9MKMWYXPG45JyoOTC/SDFYfqzvJyyzVRS8jpvyS76doZPslvWepS6CgyMOpqDkbPXQKMsQgFh4giJasj3iT+Q5I8gR1DECs427n1rZqNbQpOD6CJZztVImLkD9KgmxF2OmgdUTTxgnwMOpH2B7vlGy6i2SRoVKgd+flh2Xq9fadtGfpxT8U/uLz8PgetA6BYpiSRIBMjVkppuzz+KoPE7K55L5eV8g8QfvbzyjLJPdJ15z/2iVDFFcMdx9sbpytgLbrea/U1iz+6dYEvw0v0u2ssffp4RXG+d1djsFr1yKslHzbOZOZ1420F2PzWwN68L6zNjHPJC3QBPww1zicuPdn5u0kolVePU22KImQgaYqoUtuGu4MPrxIdfy+xll1gKCM4mP0028QPF4wDD8uuUdKYJNkKo6lOysOKzEZbI4ES6nPWjO8vhbuWsZPDKPxQ/vfVCKMmUxWSr/wTnYgL5tUKDNRWsGsODVocVyMsf2OS6bmGslM9D5PfiAvVbxUcZqT/l9xin7d0Hj/GGEznUvVpi/cAfsbToXRXLeeGANEK7PGNTd0XaljvhgJ/1ijU/KfaZj986KzYXEYhPks7Xb4K+01MMY4aBQvKYAzp0warC+4cnKcPCUlImcolf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Bz+SVtnjHVMA8vgAk/9qO3kF3I52CtelI+mYhhruVizqN8cBGRRkAmYlT3G?=
 =?us-ascii?Q?nWqDiyUf7A3YU+nnYR9gsRS006FY0wTxD3mFJNTIVhGKbPO/1MhUtD9kwXGm?=
 =?us-ascii?Q?XWT/krc8OtcfCaTWf4lFXl3bbx+EvK5JKAlwT86NQ8TTquj98Q0KvjoI3fuL?=
 =?us-ascii?Q?GyLF64gJf6kea6evAXbhQMxvYzvun9FddN7NhkCFS6IOnYPGpb0CJaYTFXt0?=
 =?us-ascii?Q?TZ7yvlpsaAQFY0Jr62ld4RTgi6G/BSdd4JBOtoeAvlJhj4rUJJ21AM0WU+0r?=
 =?us-ascii?Q?3iLyGgRoANlPwQU5t3oW5HpC2lWv6DDomKOAEkRqspi/BOb7dqDFl9rugMJD?=
 =?us-ascii?Q?FzAfH0PEtCb4Xp4yDmYyPk22yFkuB9XZHRN4k4V605H2uQSmda2t97OWogb/?=
 =?us-ascii?Q?0gmGAxYmqRdBwMq41nwqkKS+PWJCItyGbQ1g0E/mLmnmN01t/5kRVt14vEsR?=
 =?us-ascii?Q?N6PtbZhE4g+FGpF2R1TeVBAxFKtLJtn4Cti6rbuK8Gk/wTgXkzwfD2Q0qfy7?=
 =?us-ascii?Q?z5I/QK9vLYy5sULstD8aYBmmazeq+12BsZjhSmARcc/C9p8HRO6nSUvBFsdp?=
 =?us-ascii?Q?3CHbdRD5bn4089evAON80WcOWjev5Q5tUS9sNsQXGcsRBt59OwECXDgWqiM0?=
 =?us-ascii?Q?HENTzB5rprxrGWdo80ZnPTXYrpktYiF4FCE36Y2xXAnjn7bU3QCZhwSO4ILv?=
 =?us-ascii?Q?6qoYvTQyTjySPo/+Hc78aSHd1/q4dvRkPXI9u/6LKucvODyXhxAxSC51ZAXk?=
 =?us-ascii?Q?QnXAgJPouRrEGUVFS6F2n0pnS7L88UchLd6PFFrgIkLbxBKPeTIX1cO7HJ/g?=
 =?us-ascii?Q?wENqIPX5KrYkAUKw3daNEiotvf4SY2nsuJhVKYr31AIB/5+YIUG4GMj8PNc3?=
 =?us-ascii?Q?oZcaOx5fAy0q5AhC1d74qeWoiJhTVZzYClVtSnKFX5A2hhzXEmQCMVW34FCB?=
 =?us-ascii?Q?rDTJjHMZ3LZ6pqG72o/W1UYdLrUTBeSWhhY4A+XVMwxxgfDr9lmcsFGmPqFB?=
 =?us-ascii?Q?yF2ovzgOooG1vkAaohe4T+SzFS2D+YZq673YPPsF0JWaj4Jj/KPxt2NcbnmN?=
 =?us-ascii?Q?rZepNHhGFoH0pNqRlwGGbgME+BXQdsCYn/Bk62tDCVxU0Qih0gPrn0ZlpfIi?=
 =?us-ascii?Q?BeH57/tsZoLsHvQRJ7bO98gb2/CBzdRZl0br9Zrs57uXfKi5W44e3ICos/Xs?=
 =?us-ascii?Q?ynM4IPplaiRtDF8lP1ckIW6c33yUF/sJlCKVqy1Uto0QB9drd2T5VfHKp1Of?=
 =?us-ascii?Q?qnD17lV+mgA5L0ExCnAtGr2UqPpDUu3KINajnajMQn3LI9lXGJut1ovx41AQ?=
 =?us-ascii?Q?tIzR8E3QB3yL00eqWwXR5tYhVW832eeYT9I4OLB9eCOTcSRe/ONTgmdLxNqX?=
 =?us-ascii?Q?EAgJPx6QRVAoFgFd1FpLDEC+Ijq6sQdfEsAf0mWr3lUkOT6pyV9+d5Ms+JZx?=
 =?us-ascii?Q?J501H+KNKOiMZi50YxP81+GETM/U+80lFcuYBAykaOxi2atMGYVGkPniuLFd?=
 =?us-ascii?Q?gaDCpq2STSIdOoHQHyCb/S/TNq40g0IKWwaGdqkDSrTT1sdbhSeR2NLSAsqC?=
 =?us-ascii?Q?ld+GmWLQDhrwzWY89Xof0H8UMDk7GunLbN+ylKY17vYn4di84PC99k9ROS4t?=
 =?us-ascii?Q?JbOEbnvtXUZNsCVgfjk6Z7OlYkaLZgLpFhiqD+JzivMHeKNAg5EW7ZmMnukB?=
 =?us-ascii?Q?Gtsxg3birlMgI3pLed4/0OJ8tfgaix7BYPNSv2qxlBTAw+bU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e7c583-3e53-499f-21a8-08dea48c26bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 18:38:18.3757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hV22DOBBRd86731QVGwXSYA7msHotLdKLjppnkBK3xNF3+bSTs6WneLHn56U2qtR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

> I sketched it out, on top of David's patch, here:
>
> https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=3Dcap_perfmon_fdi=
nfo

Thanks a ton. I also did not know about this.

>
> With that if one does "setcap cap_perfmon=3D+ep $IGT/tools/gputop" it can=
 enumerate and show GPU utilisation for all clients. Well all which have ma=
rked their fops with FOP_PERFMON_FDINFO to allow that..
>
> I am not saying this is great as it adds more code and more inefficiency =
to an already sloppy path of client enumeration so for discussion only. It =
is exposing things less so may have more chance as an interim solution, or =
it may not, I have no idea.

Yeah, finding the processes that use drm by going through every fdinfo for =
every process is still not great. But still, it might be the best we can do=
 from this position.

Is it okay if we build on this and send it to linux / fs mailing lists (wit=
h credit to you of course)? Or would you rather do that.

Thanks,
David Francis

________________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, April 23, 2026 9:29 AM
To: Tvrtko Ursulin; Francis, David; list DRI developers Maling
Cc: Simona Vetter; Dave Airlie; Deucher, Alexander; lucas.demarchi@intel.co=
m
Subject: Re: [RFC] DRM Equivalent for top

On 4/23/26 14:00, Tvrtko Ursulin wrote:
>>>> We would like to do this through fdinfo, which does track by pid, but =
that would require
>>>> making part of fdinfo public, and we received negative responses to th=
at.
>>>> https://lkml.org/lkml/2026/3/16/1816
>>>
>>> Would setcap CAP_PERFMON on the executable be good enough?
>>
>> I don't think so.
>>
>> The fdinfo access is currently protected by ptrace_may_access(task, PTRA=
CE_MODE_READ_FSCREDS).
>
> Right, sorry, I was very unclear. What I meant was, if the patch which wa=
s rejected by the fdinfo maintainer was changed not to propose making acces=
s public but gate behind CAP_PERFMON _and_ new FOP_PERFMON_FDINFO flag.
>
> I sketched it out, on top of David's patch, here:
>
> https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=3Dcap_perfmon_fdi=
nfo
>
> With that if one does "setcap cap_perfmon=3D+ep $IGT/tools/gputop" it can=
 enumerate and show GPU utilisation for all clients. Well all which have ma=
rked their fops with FOP_PERFMON_FDINFO to allow that..
>
> I am not saying this is great as it adds more code and more inefficiency =
to an already sloppy path of client enumeration so for discussion only. It =
is exposing things less so may have more chance as an interim solution, or =
it may not, I have no idea.

Wow that is impressive.

I knew about the capability system but had no idea it could do something li=
ke that.

When that works it looks quite reasonable to me.

Regards,
Christian.

>
> Regards,
>
> Tvrtko

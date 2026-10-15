Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BECECC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8478710E139;
	Thu, 15 Oct 2026 10:16:37 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED678112286;
 Thu, 15 Oct 2026 10:16:25 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kOXT3982850; Thu, 15 Oct 2026 11:16:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=8iZcbOGrlskbxXiHEPwKeccaPGGamD9H7LwNDDnqTtU=; b=Nst
 5Tmf3kSN3bBbM16UXHWbFBaeSygxq89PL379a9AfQ3VxSj9eVizwnInwGRgXtBxt
 aJ8UhipaIq+5zCno2VNJP/BmFqnhqQQjfHORMS6kl8MEeDxiiJ+4vw5BaLCe8/6B
 FPKBlAPgEIBYVEAS8mIFIAf2Z2Zh5G+phq0y8hHyGlN/Ed3pcElnIzCxOgGnmied
 jspUhsZ2PTIekiOf/NjUdR6Hzu4SubShXCe+S2yP2G5FuuGvEqB1oRv35N/Vvb66
 twhYfx1EbpkW/Btov93WfpVaMtAuKAgrq5+yzrE0twTE5VArB3KfGw2jFk6JhbgK
 VcobdXQvrTncvHoI1bQ==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h7det4e0n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 11:16:17 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brOjzxc55sbsWAE4E11/4KjS82JC3CwSgUii84Kt7X3LMF95F1c/h5KGqUejCO9ZOrzPFJf3bywFkirdam6zNUXYi6ykxwcIpn0/cSq4VQMDdkX3OWL/PEwRrsQsZ5gie+3OuPHXfNrMh6na1E14KPCTIAXba56PxjAI45kjTGjiWvGVCe9GEWsA94bsCtZleuIyvfNajNGQcS/Ld21AdTZDf+FgLjwULSqTxOo68qDdTYzxAPK7sPpxDI5+c5ATphg1JyROmvRvUwglS23mWyKLmPINxvqCth10P6vJ7P+AyX0FnZUccCfuSX8To2Lfc4nd3PpvBV60cZg/iF2ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iZcbOGrlskbxXiHEPwKeccaPGGamD9H7LwNDDnqTtU=;
 b=n3bJrQEqIvMY7A8QK4mzaI213T/nRgavzT5Gd1r/XN/DpsrMYInCBp/3eZ7JKCnSHGkVoJRlSNcTKmGaoGYjqE8qJFuOJYpL0PJX5DqvPfTCyQ7Y+zL0ZW4ZlBE3FRM3k7q95HlXqWPOT+KaloWTuXl51/H/L57qTtMdalL27cfjoEuBBmosmnvOcHTp6+td/lC39vgLCmoylmcGYCTNx9+kYMKhxgn3AcLbzH1ZLE4efLRw24wCrssXKFGie/IoZWtdhoDwSqmhc+w9G38lzdHteQMFyVCBw5A4glqlWEtjOjeZwaP7ilJiK9WkEwfbP+vRYoxNVeyEqR1+sggCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iZcbOGrlskbxXiHEPwKeccaPGGamD9H7LwNDDnqTtU=;
 b=Ji5Q/XK7yTc6dQ35IBK1TkRi+QujjtpARJdVZGdP/Dh29/E+wFbV+YUVTqlLHksJh7DZP42FQJaVYe7DtgoAuJ/SIsvAjD49yimG7HP4Y4V7yR4Ji7cQSIu3NuFtVv9XbzOBjvRd/sHjU5NXxzs4XtsSxYBI8q5eo6sJBrJMhBI=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO0P265MB2649.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:16:14 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:16:14 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "donald.robson@imgtec.com" <donald.robson@imgtec.com>, "airlied@gmail.com"
 <airlied@gmail.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "sarah.walker@imgtec.com" <sarah.walker@imgtec.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/imagination: Miscellaneous improvements and
 utility functions
Thread-Topic: [PATCH 0/2] drm/imagination: Miscellaneous improvements and
 utility functions
Thread-Index: AQHdXI41Yo9pnV2O00m3T16GlR7/sg==
Date: Thu, 15 Oct 2026 10:16:14 +0000
Message-ID: <16de79131a9686dae8c2e275fc6ca3ff98fb2f2a.camel@imgtec.com>
References: <20261006-b4-utility-function-to-rw-regs-v1-0-a9faca685c4c@imgtec.com>
In-Reply-To: <20261006-b4-utility-function-to-rw-regs-v1-0-a9faca685c4c@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO0P265MB2649:EE_
x-ms-office365-filtering-correlation-id: 183d3f9f-bd63-436f-4b8b-08df2aa55815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|23010399003|38070700021|56012099006|921020|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: CdJv7YRMxBJostdv6C9FoFVV6MHD86bI0CVWG8jWFvRODjpF7kq44o10NTz7+78wzVv0TeaiPQXbdLka7SEJ4TbWtoUk0umm9Xpb44nrH9QCfrfGGRhIYm0lt1fxZ82KY6hhcr1YQT5+EGojzNiQXoWc3x4EOL/6JRN4MTk7KzeOz4STlk6KnEMCxiZOcvaGD197ucw3v2Utnars1eZBO+1lQHqx3qtH3cKprp2NaPtH+aY3MUbUsfuYck1WYuSsgVrYPy2YR5sq25nIK176BJf06G9hVmxArRa1AmlYLU9YsYzt/a1jwIcU17EaeHA/o9KAYUl4FAfe/Sg7/fG0NGHR1o1ESoTmBHwWGXbQkWPe6N0+XOD+nT7vVk0SPD70N/BcmM55Tu6ja2O09llOdTxAHjRNPojS6tEzcesBNdXdiKZZIjl1vODVgT2V8Wh0HTv0U4Q/DvIO/QZuNuDK6nXSRm/qKSReHWmSy7O0/84CtBjkoPyB6ZPhjfBWnjOuObnXlsAhJkjAribcOJNjZgW7c5vHyDhuZSJuI/KMZKh+Q2g0aBqIBltvDELzQWLwwfclKZQ/xP7ULocneOe0kSeD2t6Ehwaok2t4MErpDFf1ckDTELNpHGgjOLdbxfK44tHmNkXQncJ6jd5yfZEehYkzRgwatTe8Nhq0tlTNeWWhqyGz9kYjwtuif0T+fTZI9wA25zin8oz6xvQt73lT+49ixg9XV2t9n5qDL7KSqAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(921020)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejIvR1M5dlVTS1VFVG1xM2ljc2VxRFNGNmtDekpNeGp0RzQ1eXYxSWJRai9F?=
 =?utf-8?B?MExIU0dSUldpek1yNDlydW1KU2JKKzE3VkFIbU8zbi9lLzlFV3Q5WUtTZUI2?=
 =?utf-8?B?ajM3SW9CY3JJd0VXTGJ4a3RhWlR5V3BpNXZJMkhUUUFtTUFrLzlSU3h3VUtK?=
 =?utf-8?B?WDF5WmNvaVJJR1AzUnhhR2ZSUTZ0WmFsS3RoZE13bzAzUm11VHhGSlBkR0JS?=
 =?utf-8?B?QVhhNzlUNFVQcDdwR1R6UHZoSjRjc3lkbTJzcWxWcFB4Zyt5NWhLQzVjc2dm?=
 =?utf-8?B?N1RyeThWNVZWNy9SQWlxWVFKc041OHdqVGlJK0lncjhhaXFuWDRIMEl1b3RO?=
 =?utf-8?B?RXpYd091eGdja1RDd0NicE02VjRjWVlkMlF1WW9xRnJFY3pxNHBtTnRJYVgy?=
 =?utf-8?B?dXhMN3VkbW1XRTF4Y0p5azBkWkcyalhvNmdKTElUOU84c2JXaG9EVEZ1djBQ?=
 =?utf-8?B?b0dWTjJpRFVzSy9kMVlRWlh2UG8xa2pYaERiL2pIQUZoNjU3d2R1a3JPRk1J?=
 =?utf-8?B?blEzeXQxVXV3NkZINGJEdG9pcm9PeXdTZlZ4VHBKVzdaaWFRTklIMXVCK01x?=
 =?utf-8?B?SHRLdWVSNGlWNU5LWm1IWC90M2JJUE04OE1mU0FReFhPK0RhUEpRNC9JOG02?=
 =?utf-8?B?S0REZjd2d3dWUGE4aVk4eHoxVDJRcVIxckhSKzIwQ1I5Mm5iQlVRdzVhWXg5?=
 =?utf-8?B?RExQMk50VEZZV0wvQnVOMlYyUkYzOGZiR0R0dTNYWEh0SjRzTFFyQTRKOTNH?=
 =?utf-8?B?MVljVGw0MDBERE5waWZyYVRlc2NINU1aYklNUnArUy9HSFh4Q1JPTUEzWWU1?=
 =?utf-8?B?anlCUzAwSDZIdTNzRnVydytIRXIyckhTMGlJYXgwMnEwN1FDM2tldFd6bXZP?=
 =?utf-8?B?T3Q1T3ZjNjVVMTlNNFdlWmdzR0FTcGtaQ3pGcTBNRGxQd2pKU2hlemw3T2Z2?=
 =?utf-8?B?RjY0c0QybzBtb2luN09YNi9ja3hDUU1BMWJLcXRJVHZscmJpRTZYd1NYalRG?=
 =?utf-8?B?SGVad0oyQnJwUHg1RmVGMEtFK3U3U0dlb2lQQ0dzU0poVFNUdWdGdzVtNHpH?=
 =?utf-8?B?TXJlK0VNSEFPdHNiODMySGp4M3FYeTgxTklaQ1BjbHBDZmhrYUxVc0x0OU9T?=
 =?utf-8?B?cTFoTnIrcTZSYzc5eDRBNzZ6b0tSMDZIc29takprdVEvZHFjUjd4b0VKTG1i?=
 =?utf-8?B?L3BhSE92MElpUXN1bVluR2x0ZkJld1F0ZGZKYkhUVzNXY3IwWWlrbHJsOSt2?=
 =?utf-8?B?aThKMzhZMmFIUHE5RDYycnRjcHZUaDVFbFdqYWFUbEkvaldaNjI5SXpZclpP?=
 =?utf-8?B?THZwdWc3cUM3QmprSnZZT0UxUVVTM1MwcUkxdGFzZDEzN0pqOVpMbncxUTM3?=
 =?utf-8?B?Q1N6SEM3L3FHb25Sb2t1R2dpRGhJdlUxNzY4M3pvOWpPQ2FjU1lsN1pzWk1C?=
 =?utf-8?B?bmJrdWJnOW5odEt3djFIcTFwOVNPWDNkRlFUTDlxNTZXMk1NeGxjU05KRFE4?=
 =?utf-8?B?WnZiTHE0OFdSR21uWmtMQnl1bVk0VkJWdzAwenROVFZrb3J6dERqUHhYeDBG?=
 =?utf-8?B?UkRIQ3p4eWNtengyOHFJSGdTUDlPUWpBQmZGWHA1Y3F3T2hoVDlNand2ZElI?=
 =?utf-8?B?RTR0WHB5UlRycGJYcVJmdXEwVldsZjMyWCtXV0ZzR1NEWmlSRlFDbnNyN0ZX?=
 =?utf-8?B?d1p2Y3hYZkRaemZ0VWtCRXczem0raElHYXZ3SEtyL2J4anVYZDBpdE9TR3d2?=
 =?utf-8?B?cjFYbjgxT0NkQ2NuZ3FHQTJNZ2c0R1hkbVhTSkFkNExkRzlwb01QcVVOWDEw?=
 =?utf-8?B?ZXZPa1VybFAyaWlMTklhcGl0OGR2ZWRRV2swUDZWWVhNVjBnV2NqcS9hN1pj?=
 =?utf-8?B?OWt2a2cyT0VVMFlDRk5KQVVZMy96N1lFOVJjaDVOeXNYOHJBdkJFZ1J3OEJ2?=
 =?utf-8?B?M25paFNkOE5HNDZmMC9TWHFXbzFxcS9MNXVOWk9XYnZGSXdVN0svNk5KSUdr?=
 =?utf-8?B?RWc0eHNOTzVHTk8wSzhFcEZ6Y0NJcnNxemY0RTZrWUh5bk9mcU5zWnN3aXlS?=
 =?utf-8?B?TmRyNWluWkdiSU5mM05ET3RTNWZZL1dXRUgyOE0wMkRhd3hYcGNQNDZLK2pD?=
 =?utf-8?B?NHVITEdYaXBnYlVlZXNqRGppY0ZFZ1EwVVltWFZJbjBHY1kxRHo3SnN5ZEc4?=
 =?utf-8?B?Y3B1S1NXNXc4N2pGY3dzTlFpZ1l5NUVLaER6Z3FqT0gwZi9wT0JRN1Nocjkv?=
 =?utf-8?B?Qld5TkU2Tlo5cEUzV0Y1YzVKazRGMGs1Ny9rUm5pNDViS1JzY2liZ0RGNVdo?=
 =?utf-8?B?NWZWMDFOem5Xa1VLRVlIcDYrUnVtUmxBbzB4U2ttYmNlNUFoaFNqM3dxYlNS?=
 =?utf-8?Q?JOLytcdvUsOhGriURWh9enaY+IksbtqQYDskUj4IR9Ti/?=
x-ms-exchange-antispam-messagedata-1: KOvOezVvdm7r5FMdn0D3U9GcT6M9djNnbmQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55983F0EEE7E774AB00B6B687DA610DF@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZxU1KBKQSR9skqy4XWF/A+3RyUmg7Hmh7HJYWwrK26jK9z/m0M5CHeFgOaEvtkQALbOgW0xBHUoiIB72bI3g6TTjoauNCNOqFgo2hA2KfWpmcfHGMxsm4I0tZDiL00mvoizncqDkdKl7hgXIJuyoFV8w4eqHGnkGeuvFmnIAycxosctAXRJCRZVWTAs9QG5E2qHc5NsEnmWC0UkKztInd43q6GSpjCGtNwYIsBvkNK2MGqP3xeApJY90AedyIYXI5T/Q7fLEU/YEOCBnzoFRCO/qOZzZdK2yXjfDAh+0kd70uwnNuJdhpGWWIT521nJ1WlMc2iKrcrXiy+oZzCy5eg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 183d3f9f-bd63-436f-4b8b-08df2aa55815
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 10:16:14.5543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2qicU8slx+Vw6vhYobvfWX4kg5HJfK/sH5N11mMxlC6ahHOIYN17lF8cl1fPQ3SFOzi9DXuSBT1y4dih5AFmnE+2J5ovgw2aMNYYJxTbZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2649
X-Proofpoint-ORIG-GUID: HU2pAZ53DwNHFxvlNgnqo10-lO6iTN9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX8zGaYbQzpFtC
 Z1rB8N+Qg5dhjmrbS1RCAVzStYuqbvDowAEHuGq8fVlCxCMeS5gyRlwynODnrDFKPVk1B6Auzdo
 /qOMQXxdmZ9iVM7OM+pH3P2icwYIUMMvTZnUjD/odcgp8DWWLJsiIr8Hv6iud15R5s5klBuDiuo
 utz7PKLZNzndzgsrjKjtzFraKBqVZJkWyp+H6OfczxxkfeBEnSUH3p3bIihipKm9mHqvfmR9bOn
 JTT7dneg10KLJecqL/08OAHtvqcYX37+z6QadfuqtG/HZT89oNQgQ1n6l1UaAVmEaWRGTxtH4Pg
 qc558WWRIBypdFdKjR7ydwMJ9H1+MTUNkauEy0zBC85j7FBxe7LLDJkfhDWsMAZxcycA98NT5gF
 6KqYvN0T0VuPcYZONrKX8AMal/HrtnqqRdn7iGJruSmVzaKcqFi6QO53zPvB5sMZ0Pk7dYAq4y/
 USzv28EEcCwcvYvbKLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX1ts0eNYQpl7k
 +/IRXKfpKoVLR46UOm9cfBu5qal7pQlkgeSMW44O+/0BwbWrfm45KZc8mNFvDlhAaay6jo7Ty8h
 MSIlGxK5HZLUJwSqPjJDUQGiUK9ANRw=
X-Authority-Analysis: v=2.4 cv=OO6yTiaB c=1 sm=1 tr=0 ts=6ad0a7f1 cx=c_pps
 a=N7A7ooe4fxySEW+8sGxlBQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=ciHCZzOySiPcHMHrV4kA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: HU2pAZ53DwNHFxvlNgnqo10-lO6iTN9s
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

T24gVHVlLCAyMDI2LTEwLTA2IGF0IDE0OjA2ICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IENvZGUgY2xlYW51cCAtIHdyb25nIHNvZnQgcmVzZXQgY29kZSByZW1vdmVk
IGZyb20gc3RhcnR1cC4NCj4gVXRpaXR5IGZ1bmN0aW9uIC0gYWRkZWQgZnVuY3Rpb24gdG8gd3Jp
dGUgYW5kIHJlYWQgYmFjayByZWdpc3RlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
cnUgRGFkdSA8YWxleGFuZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCj4gLS0tDQo+IEFsZXNzaW8gQmVs
bGUgKDIpOg0KPiAgICAgICBkcm0vaW1hZ2luYXRpb246IFJlbW92ZSB3cm9uZyBzb2Z0IHJlc2V0
IGNvZGUgZnJvbSBHUFUgc3RhcnQgc2VxdWVuY2UNCj4gICAgICAgZHJtL2ltYWdpbmF0aW9uOiBB
ZGQgdXRpbGl0eSBmdW5jdGlvbiB0byB3cml0ZSBhbmQgcmVhZCBiYWNrIHJlZ2lzdGVyDQo+IA0K
PiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9kZXZpY2UuaCAgICAgICB8IDI4ICsr
KysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndf
bWV0YS5jICAgICAgfCAgNSArKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZy
X2Z3X3N0YXJ0c3RvcC5jIHwgMzcgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+IC0tLQ0KRm9y
IHRoZSB3aG9sZSBzZXJpZXM6DQpSZXZpZXdlZC1ieTogQnJhamVzaCBHdXB0YSA8YnJhamVzaC5n
dXB0YUBpbWd0ZWMuY29tPg0KDQpUaGFua3MsDQpCcmFqZXNoDQo+IGJhc2UtY29tbWl0OiA2ZTM3
NWRlOTlkMGM0MjAxNjk0ODFmY2QzNjA2NDE3N2FiNTViMDlkDQo+IGNoYW5nZS1pZDogMjAyNjEw
MDYtYjQtdXRpbGl0eS1mdW5jdGlvbi10by1ydy1yZWdzLTA3NzdjMTczODBiOQ0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiAtLSAgDQo+IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0
ZWMuY29tPg0KPiANCg0K

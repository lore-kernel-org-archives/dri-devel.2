Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB11FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA1010E8DA;
	Mon, 27 Apr 2026 18:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=microsoft.com header.i=@microsoft.com header.b="KL6n4qy1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11023092.outbound.protection.outlook.com
 [40.93.196.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B748510E8DA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ame+TaJbAdZR5I5350+EhK1eo1JLac3ouhclbRCDyRZzJ+rwR/IqLQ3Z3qrQ3hfyRo+PzVMIFrHh+DxUWI51M5u/j+8xHfI4A2pEfAF1BlHWd6pdVhSPcA/qY0pFilv/oN6peeSMOWt3OATcBZ4re9f4WP9gDGi78wQ+5e8G8juiD4w0EqsfnmhnM8g3Cv9p3WMBYcdibEo015Kx2iKIqNDptc4gUtQmj57/dYk7dJAt/jo35RJbPZ5Nzur7lYrQi9JYphbPd5tP0G5yMLa0Z5sLC8tDTb3ttWmu4p2L3zBZFU4XrCxayT9KsnJwqdyL6LEfDeH1AL5JtBcsC0DUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dXeq/ybr4UedfFFZfLN5jCZv6mAaYwYlGldFWOmZC0=;
 b=Rg+ESjoNkgYYin+uKeD8oxBJ8sbfU3iFzHpIRwXenEFyIHzhS+cPXiOHWYDmoJ4oP4SAZjcPASJH9UrwKhwg/4wFzT7S0p8fntMagaV1m5r+RPc4e0KJT0R5XWrRDc7X21zaFNgcJBBmdZPtfTgDBZYj2t/1udFGbyWGIfZnKtgHAIs07IUZwCTa8nv+8V37PoGv8Dx3P3wbGpUJbwuJYrcS7nvjdXsNczsBDqMlsYXRTXhn0uNZTYEfyiLhTcTvoQNmlT8HCQa4nEFgSh7Z2Gyd8YDdxs12fE4HVI4TInw0mu8QTLrCpjxhZYvDkdNiGDJ7PZKLJavcKBLhb2f8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dXeq/ybr4UedfFFZfLN5jCZv6mAaYwYlGldFWOmZC0=;
 b=KL6n4qy1LjD1MNlyuPqH9j6gjs4+w5G6QxYqJwaTGXLJYsa9Ay0pcBdy7yMxSTBwU15SuKNe8IQlCxTc6vdsObg6MVovek3lD5MjrdLW4pLJC/m0f8bFL+282IzLMiW3qcSfZJq3Rb3vjczT3hyG8K5DvJyImdx5dtPeZRkd/bk=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6323.namprd21.prod.outlook.com (2603:10b6:806:4b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:53:21 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:53:21 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Himadri Pandya
 <himadrispandya@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "stable@kernel.vger.org" <stable@kernel.vger.org>
Subject: RE: [PATCH 1/2] hv_sock: fix ARM64 support
Thread-Topic: [PATCH 1/2] hv_sock: fix ARM64 support
Thread-Index: AQHc1N/Qb+eZIwhnXUuV873KWoUDGLXzQyKw
Date: Mon, 27 Apr 2026 18:53:21 +0000
Message-ID: <SA1PR21MB692194B2BB3816E8DE54A07BBF362@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4155f11-46ca-47b5-98a6-7acd57c7c012;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-27T18:48:30Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6323:EE_
x-ms-office365-filtering-correlation-id: a6517839-1d47-43be-e3f1-08dea48e40ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: RFjKah0svfQldXB//Gdy5xTHrhWT4mlgYNGiW/2PBhXt+09e0ILwR35+/Z1yZffiV7OzWbdBqZNte03ONOsmDnD3QB9fK9OppmNS6jUX3cEOgpcsV87blQB6buOfFD+h32Bl7ioF4yadWudget2UFHdOsS7LinTVaDQnxV5KZcxhGfG9dEe+Dw6/UjbeMhlbf0c9h0HCwUPySuHZfrSmY6/V5nGb6AlIeYPr6BVaIkVsx3ezHu2lVzk1VR/shkqaIGTLvSIU3+CWeFbSxcd2pmd2lua+O4HJd1bjuDnpAoczh7ZPB5nmXnJ/x9Z2MUS6IcZjnwQxYZ3DNCylsWFkFw+kqDVW+QJ6MDWwvNADerpXLt9cbZBweM9Y34RRYa0rbZnCLujXqTlyD5phZMRc8vAD68nUAkD8iuUkCGma8UMwpCN8o4jEndetyAq6dGgEj1kU1c9rHyv3wtZ5xwJcPkyXeCilIbA9WQz7TB+OuHkvCbgSjwOspqnMeCAza7//1m2ZB7bpF+nUI/1VoNiqJd++htU4nzyWxZ/SiUOrLx3cShdCVQ6aj3BiuPc6FI2xHEAVVsW5sgrstYfdeSgp9kadzJGi1Yjo+mLny4cFN5yN2KcVYLrHVS5MpvfafoZvsPk08UCCXAdgJRbCAFarWT1qLILggszrZuoTHXvSaJaGJ4dFB+bgU93DzW2OHlRAvX6n94TM0uZC8St8eo7sWHOTRJrHVDz9Il/OeT2yTgNHwE0MaN9wLtSV3E5IJiaZYc3g65T2Myd5dI2NXT+V8fJodcKh+1fjdk674uz14K4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6921.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VW/HzZb0gNAsCwYld+ZKJQpqftsSqmnIIQUuPyYy2azrADqWb2VvJOeGI6y4?=
 =?us-ascii?Q?h6/Ybh9EqDifzufgfHOU51bHIR3TEwXax4DmSwJoTDB80PLMA3x1tjenG+yK?=
 =?us-ascii?Q?gb1wXS34Oi09wmea29835LaG7JL5ywqdBoNa2BlzCDMZIGg8Dtvs7yOfZaAE?=
 =?us-ascii?Q?jiHY/NKXqcV9cxAeyimWNMjCDnJmh0+uvPrpWNTkjPlSl1s6khl0YZJRnOQP?=
 =?us-ascii?Q?/wQH0KyQILWdB6pnUlTvJzHPAd6N1BGRhdIk40LH6JbsVmU201ofi/fPS+MV?=
 =?us-ascii?Q?XYZInIzAYSrrrJQGHyANXba3S2pEFVg9Rd3Tk6R3a09nSQ/KwXwWbeX0yfZi?=
 =?us-ascii?Q?Z2UNR+BgRnfpGFLQu1+hx2G6yq9PuqtY4nrsvGK5DTB5jvM8suQePnrFwuM2?=
 =?us-ascii?Q?V+c7f5SWlYq01H8A9kl/cCeQYMfLlO8rNURIYtAdSxvkQQymuCGBVNY3Pwcf?=
 =?us-ascii?Q?P5zkuE9iT+kU7TamM9dIrkpFqkgZYesvJvu1gBFTBDb1yArd/ZrAuj1kl6W6?=
 =?us-ascii?Q?Eu1VUIyqF5wrZDoOxIerhMGrgCdPuByL+rjydRBFKpjwXmJYXo+FXJbZvZYk?=
 =?us-ascii?Q?GS/r3xWpVuvETrOfW/8O3PzjbV6YR2gUV36U7RNLlffmgJYH67J2IKmrU1/Y?=
 =?us-ascii?Q?YRoApsN3lMQrbbNMc69Tario/V9K7o5c2RR+H/zDHZsShzkxNScUyKGBViKp?=
 =?us-ascii?Q?QBLFa3S/oj4/gx0xy+TLRjZl7kABbSoeLam1TlTi64Y1a6ybMxLXymXoILrG?=
 =?us-ascii?Q?qcql108qDZEjOMrJ2g3Jh5W0z1X5ygX8zqWQUwjorfs8tt4K8D3/9RcyxeQu?=
 =?us-ascii?Q?wM7jbOEy4oqFyhmcH2L8lO+mZIUvU6gx95nzmu5bBl5X37vZ9Lxi+YjrHoem?=
 =?us-ascii?Q?B0Mrhgxqk9tmNrbP1KKm9XoIvsOHCnWks+VQn18Gqzku10asVAfthDlCP14Q?=
 =?us-ascii?Q?1RAZ6y1jEhJaSZFxg3ZjIs0azVi+cgrLCHLKfyn6I+/tq5D/QBC5VxifnTOJ?=
 =?us-ascii?Q?BpD4RlELfBH/8uUCnq8gTkLwk2rHwomgLUrKz9GMf+uI8TL6iWbEHx4A4NJ5?=
 =?us-ascii?Q?hTXOzZRYsFNHnzeX+z5GuGXkqaias3EGZZvI3WxTi/bc4Rwd3ywzHyxhr59e?=
 =?us-ascii?Q?ttb379jrNRr5sd0ZBVv4pX2MNuLS0zP+wrlpI8XcwPMk4qDIXCI7tsVtEf1N?=
 =?us-ascii?Q?P+wvIrOOPlYz53Hsuu9TpSg7fyR5cJkoZsfgwFev8p6iUoVD3DI+3aNk6Fxs?=
 =?us-ascii?Q?hxe2z+gd5F63UyLSr3pO0EEIwacD4p4E108YftdVpofNGEhqFrp6lLI1vM7D?=
 =?us-ascii?Q?XJQEF2VbrMnGaZ9SYUg+I0fdxsuKv6dNTvrDpwFA12oSKYeizkNFpGK8/jaS?=
 =?us-ascii?Q?4EySzgMq1nS3eizRsqqmsyxFwQsy1dje9cpTPMrHkgXV4qI+5yPqVu5MD5Do?=
 =?us-ascii?Q?DNL8CMdrKePI6Dr3k/nH0mYVLox1uzOfCCaNGTwNdCwVrl8qrBnMzoYBFuwC?=
 =?us-ascii?Q?c4qEb4U4Ki5kG7UnSGhj+uZM/NpyWx+LdZjiEMDubW574veYmk8QRKIolkyy?=
 =?us-ascii?Q?q2le0LMD17C0ChsGroEgpe1v7ACV6oT/PD0nslpjzpI//88pvp/eQYv+4gyQ?=
 =?us-ascii?Q?GIKqlllhowCjKB/zH5wXe0C7GTSg9AJBa7ChESV9MK0aD0xhpRYpDcPcx/nD?=
 =?us-ascii?Q?n8K0I9OAQGZTduRN8Ex2/xHr7UiRPI3+U3hd3kV8TcQ4fEno?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6517839-1d47-43be-e3f1-08dea48e40ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 18:53:21.4554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g6ufb/Ni/oFMa4auAVTMxaH/RfvxAe5hKLXXt2y81P5TNKeUBof/zXmJ8Z8ttknfJ6pFyg1NK0cfJ9JYOlQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6323
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

> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Sent: Saturday, April 25, 2026 11:17 AM
> ...
> Cc: stable@kernel.vger.org
> Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V
> communication")

It looks like 77ffe33363c0 was not tested with
CONFIG_ARM64_64K_PAGES=3Dy...

Thanks for the fix!

> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Tested-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>

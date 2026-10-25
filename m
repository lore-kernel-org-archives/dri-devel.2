Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B21606A325
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MykigJj9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72B310E08C;
	Sun, 25 Oct 2026 01:46:12 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1FF10E08C
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ButSrVlQgIl77A8wFc2EMSy+9DAiVizTvXshll5GveKWLhnY2gGsZk88daVHuW/5k3GekavEGq4PJ6Syf6rlhPCAK7WlMm5VyWiyQue9UoKTl4n4KsE2Oan4I1Okv0e+7ilphaJs5mA9eHOj4Jx6LjWfWD5k3746izBtl3xiGHIJznxxO9RL731b4ygzVpAP0eEDXSiH+E9zzrqEINuGnL9gkNKo72EvscdVtwC3e+cigW0fX16kZJg63j/mOthMH8KBWvK18RALhktaIam9Vk8meH+goy8F8WLtH97/20RpvkTiM2IpOlEDnedVRJIzTdjSJv4cWWwGgf9ig1PHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UygvgOehX/sCzArYr60KNEQLR+Azhud2DkPmHB4PROU=;
 b=aKiuLEsBmPnnz6Vn1wGQ2uozh6nrNmi5lGXFJVTsG46LZtdIvJN2BDrAPG12XuEvzj3faqD09LVHbMhZQlbC1fRCx7S57KvRNXATfT0+FTJwSNlBlhkJMyQwJnMS4i8ZTBQG8CbuSpGpb8pa7JNbhzIdqsCUq4YjHAiac0fRTPUD7zlWTBWlp4nxdCtqQ21L2vv2T89zb81r/E92tx1k7YnAUwGHCYFuQSMq7ElFD6cyv9jhh+ZW3ljxqdJV2VzQ8xRBqHo+GFyBRhjGoCHXk8ShjdSkJ8O+KjutbEYUCzi+cElpU+TXspbMsYm2uyJjZhtFxBllrnLYSXzR/dWmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UygvgOehX/sCzArYr60KNEQLR+Azhud2DkPmHB4PROU=;
 b=MykigJj9v+sITDLdla0pkD/K0x9xouLAzwhwKdXhUIlYdM8KnQoADObz4IuyJGdCGEvfxtgFmqnlCWQ62MjyIb5h5/ShL8lE7KAFcLTjrKJkGE1pDj4kL5HiMJkA6riD/VEYwQ0i+jVkQR9sr9a6yZZRfaYbuI6Zg2RuRuDHvkLal3b2IOATSjinDKwhGLe3majq28+wGFxluWUMkkdhmqjv0G6piXRU5WCTSip6UJZcXGTzLhMCcYWLAedmYLuifHOakQEr5ensG6x/qYxfCmmQ16P9bxKSQkuY88HMgV+TGTgHsEFxmSqAv1+8Rc4xdCr01w+9kg2/6FTpHEjdIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 01:46:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.019; Sun, 25 Oct 2026
 01:45:55 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
Date: Sun, 25 Oct 2026 10:42:07 +0900
Message-ID: <0g7damfVTZ2r6s4H0kv6Lg@nvidia.com>
In-Reply-To: <CAPVz0n3gzV+gAu_gzp3oTG9VOu-YiNSiQA0SdCFApKsi0dGjKQ@mail.gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <CAPVz0n3Vrzb96iR5ZW8zvmruZ4aK0hKGKpJ2T9Ys+bSPCtLWHw@mail.gmail.com>
 <CAPVz0n3gzV+gAu_gzp3oTG9VOu-YiNSiQA0SdCFApKsi0dGjKQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 743aff84-ed33-414c-4adf-08df3239b5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|10067099003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261021135927099003|261022075727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: ax8yMOlQM3J1vfHb8V0MeS39t7rSKd27mdiKdeFapuChwrgrag8koZ3ocS5WE2W8+1K6FTpRt4UpLPiYO8YyfOEpvWjxL5FQfc+O0xmSIwx0TJ6mS5FFgeDsH9S/3hYT4AygXxQLeKBte6KotvJmEmDz81gHCABXpC2oJm9qyQSDqFkb9UxAWZMym8SP59hj8BxUd4ZGf1EreViWdsAzXuMkmtDvBJVcqMBUd1PRBUMC345SeHwfbakN6VRwsxoT4MlPcfy2TMtQRhuJxpu9GlHUMT9b9pS+LaA0zNBNFSjm1oYorSV2fDqE4EKpOibSdC9S3FgOLhRTRTtsCki8lyVOzO1rhpKMrvb8ZmNBRkd03wt8HZtNtJAjcbCjCsh5YK9lT1PLqosi7+qJgbF8k7i3xb9adJmzUqpNAgx+qnOfDq9ID/ex/6rNqig/PeK+8/TLb1fVozvUvKQKH7jnA0PelLf8fMX+CksKMsoxqrS3vOtWkkzJD8xneb/1tedpjr9LkP92TfBxJ7Hb5R7zMb/cUDpOqX9kAhouCqsHfm43oNLXjS+y8h41bZh++kA7fDTWmgwlMJbECH0TIaAJaRogEPjM+YYjMyCBvaAigUAXV9EIt52hct1GiyQAdZHOr4TKAwxAbj/eak7LBQ3zktYvJITmPuNiX5VRtVE97Tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261021135927099003)(261022075727099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW4zZ1pEaVFvNFJUdTVBSnMzV0E0Ly9oOUhvU2lSTUpubnhtb056ekZvZTdu?=
 =?utf-8?B?SjlMS2F5ZFV0QUpaVVJBczdjUlZtc2tQS1JKazFYQUtNQzFndUZodzZtbWFa?=
 =?utf-8?B?TmxpRVBZcndVTmZ4RHVlSGY2alRnYlhwTERkaWo0UXo1TlZ1RjNON3VCK1Z3?=
 =?utf-8?B?ejlxYTNMcmpSaEEzTXhYOXpFSmcwOTAwSGV6NkVkUG84YWFkOE8xdStmWE9W?=
 =?utf-8?B?cllKRW1CT0czNTJ4dlI2cnFZS2RhaEdnbWdwYzExRnp6RnJtV09uZVNkdmll?=
 =?utf-8?B?ZzgxZnZ3NHZvQ1oxODZlbndPTWxseVVkY1VnQjYyODVHejZORGNkcDBwbEZj?=
 =?utf-8?B?RHB0QWFZYlcyTVIrZFpVRUlaYXZLZGZJQlNEQ0lNcCtwQ2NWbFZrcDVZbkRR?=
 =?utf-8?B?Q3Q4MXExVEVmMEd2TWNOV3N6b2ZGdGxheEpVRStlZkRwdUhYNUp0UW9hakJ0?=
 =?utf-8?B?Z3lxa3k0eHdwbThkRmIzWThJVGE3em9pKzA1R3BZSTduMEpBdFdzVlNVeE1p?=
 =?utf-8?B?ZFltTitWb2xRTkZUQU1kbHVaVGdJT3FRSVdoaEpyR3dxM1BTWW1xNnQ5NnJv?=
 =?utf-8?B?cXMzaytXKyt2dHBHWVRFaGcvV2d6OEhneGVVZ1ZGNXAvWDlPeEFEMEZ4eXhh?=
 =?utf-8?B?aGo0M0IrREViU0NnQ2FBVmRUV3NBYTJ5Sy9JSmYrUXZSTjdXbVhPblMyb2x6?=
 =?utf-8?B?Nm0zell2Ulk0WWNocEZ3T251U29jZTgyQ0l2S1pnOWJLOFpjK1dpOWgrNndr?=
 =?utf-8?B?d0lvVUZvZXVvekVQQlJCL2s3VTRKdDhoYWVHeDloV3dSM296c1YrOE4xUmlx?=
 =?utf-8?B?Q2cydkkxaWtHUmljNHd2Zk1uSkJZOUlBVlE1eDdKQ09RbGdLdU95ZFV1Y3U5?=
 =?utf-8?B?SU1zdUR2RUNVTXBSNWE2ZHY2OXVqQnpYNStUUnltYWwrNkNXRmdCRlNsdTV5?=
 =?utf-8?B?RGhUY2hUZGFUb2tNRi8yS2VXVjI3TzVEVW1VZkg1bVVDUUp0aFdQNGpsMGNG?=
 =?utf-8?B?VG5mQWlpUEorcTB6MVpSNlc2bGxsK2pRdWtGcEdtbDZESngxZ0J3aERWZkRn?=
 =?utf-8?B?aE1Rd1VNQUMzNnZaUFFwR0k2SmtveXBlOVYzUVBBYWxVOTVuc2prdnorTFhx?=
 =?utf-8?B?MktWaHBlQkVYandTWlFmOVBicWpRL1d3RUNZeS9ROFgzaVVESXQ4Zkw4dDRJ?=
 =?utf-8?B?dHByWE5ZTFFtQ2NEaHpMemhYa1FzZVcvdnk0Zm9Rc1hjbmRvQmI4aElzeFBK?=
 =?utf-8?B?KytmQ0gveGRqc3loWTVFR0FUK0RWTDNuT0VPajZuU1N4TStwVnJUTFF4VFY3?=
 =?utf-8?B?THF2OHhIWFY3K2c2bkd5REt2SGRoT3NaaCtTdDc3SjAyNTI2NDNRbEs2Zy9i?=
 =?utf-8?B?ZEQrZHY0QWxRbUpSQVlKLys4SmtMQ1A0czV3SXBlQll1bVNhcWRYWXY0bDdO?=
 =?utf-8?B?cXFrZG04cm9LbTl3VEk1cnhDMHRPa0ZSczcrT0phbG91WFYweUloLytmRUhk?=
 =?utf-8?B?K2xBNHZlUzFON0VKcmxJZXd5MzQ1elIzZi9FNTBJck9XekJMZGkyTmRzeThx?=
 =?utf-8?B?R0Q5V3E3cTE3alpkSTlBZ1lSU0ZRN2lEOERwb0tLZFZyZUFibm5TemdRRzRQ?=
 =?utf-8?B?QmhGa3VYclpjdnpSY0VsY0g0OUUyOFVUUWppR3Nuc3lNSHB6ZkRRUXVBaThC?=
 =?utf-8?B?aXZETkhkcGNYaGlZNlAzS1FLMUhNMGRGaFAvaWh5SS91NUxyWVJsQlpJaVVM?=
 =?utf-8?B?Y0VSUzRJQmtPNDU1UlNJOGVSOWVHTVdnY0J0enIxa3FmbDlnbEkzR1NJWVda?=
 =?utf-8?B?b2ZUemJhRUFpS1FHOEpoSkJudDgvR1R5K2FSb0pkOFpycEFSK2htN2RJVTgr?=
 =?utf-8?B?UUFZWTk0bVFBaFlVcjJVWUQyUVV4STl5c3prVG5QamVBSmltWXdXSjdMMnBO?=
 =?utf-8?B?NGdHa1Z5aFJ3dGZpdUF4K204SWxEWmd1M01JMWR1QlRsdVR0Z1YrMXM1bVV6?=
 =?utf-8?B?a0tvUHRVbUxIak43UDJISjdyN0t4enVzcHpZaTJrNUZxUU53NWsyU20xNFoy?=
 =?utf-8?B?U1VzVEM3VzM0SGtTbGhXRzFybmk2SzN5YnJqS2pNeFlXdHNGclR2WHdlUmxU?=
 =?utf-8?B?YXdIOHZ6ZTI2NFppOFBDQmhUVFZMK0xaL0k4eDhjcUlwbVV4ckpJTDBhMm9k?=
 =?utf-8?B?R25hS1pXd3dNZjhtS1QvT0hKamlVVDM0NjJDZmRIaUl3aTBHVGVVZEtRNXNx?=
 =?utf-8?B?TmNCMlhoRmRNSW1PVjF6bE04eUxCTFZDZHlrYlBITVptT1ppSzlSSTJxdUw5?=
 =?utf-8?B?QWZOaVNTSnRmdHByMHowSnUrOG9zeWZVa3dRVUFvK0ZvSzVLeHhsM1JGblBC?=
 =?utf-8?Q?6wozVCSmKPXszzp2yRzmXxviOIwgLUMUK9G8hKg/Jp0Xn?=
X-MS-Exchange-AntiSpam-MessageData-1: Q4bfPNqhi9aQYQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743aff84-ed33-414c-4adf-08df3239b5b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 01:45:55.4258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA14qi8QvzOR24PYy4Xn0PQ1VbHhdMvTfNF8MQwF+FKcQvZXpnEZdQuQxUIAfVz3nEvnK1O5HtCcWHfW6qZfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Friday, October 23, 2026 11:14=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11=
:26 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
10:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> ...
> > > > +MODULE_ALIAS("platform:tegra-dbi");
> > > > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > > > +MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver");
> > > > +MODULE_LICENSE("GPL");
> > >
> > > No separate platform driver or device. If a separate struct device is
> > > needed for some technical purpose, we need to create a minimal separa=
te
> > > virtual device, but unless there is a strong reason to have that we
> > > should be fine with just the dc device.
> > >
> > > Thank you
> > > Mikko
> > >
> >
> > ATM, I use bridge framework to describe interface and I am attaching
> > it to RGB since it basically uses RGB to transfer video data. It works
> > pretty nice so far.
> >
> > You propose to replicate how RGB works just for DBI?
> >
>=20
> One of the reasons I used separate pdev was to be able get mipi_dbi
> from it using dev_get_drvdata() from patent (dbi bridge in this case).
> DBI framework seems to not have a way to pass it in any other way,
> unless you know smth I don't.

Right, I think using a bridge is fine; passing the mipi_dbi interface is=20
properly done in other ways. The direct parent devdata link is a bit of=20
a "poor man's bus", and sometimes it breaks down, such as here.

MIPI DBI is comparable to MIPI DSI -- both have a hardware channel that=20
sends both pixel data and commands. I think we should follow DSI's=20
example and have a DBI bus and devices while keeping it as simple as=20
possible.

The DC driver would register a DBI host and the panel would bind as a=20
DBI device. The DC driver can then supply the mipi_dbi object in a field=20
of the mipi_dbi_device.

This is a bit more complicated than a parent devdata pointer but much=20
cleaner, and follows the existing DSI pattern.




Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD29C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE2D10E42C;
	Thu,  2 Jul 2026 04:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EHs7iCKZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A41910E438
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8vIfmqZufn8N2vyRzMOctPAvJOIeeVSwas8Ziv7oo/4bKQ5b9S3yE4e8SzEwryYnEOVQrRdyQMJoARC8jb+lMByJyxHraAbjLTNUZGPEIBcRcGltnNj17Xy4awF0qWBLPlUYMlAFD3rlfViLySYpyZ1m34/EJ9z3+IeR+hXMicbM44QxV9l2UbA+1pE8pRPO+bKV3vuNjbNjhFwgNpoxBXd4ePsCqKp/+qtHv0QDqSfYPRt9fhH39SJOY2N4DXVi/kFOvVbfi05N2zkRhyh+1KkoszMKqNhTPwqmLsliIWqIQUySe43eW7xA+LbYrc0ZTbG3ebxGQqGlCWlA1TpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMWTYmbSZwguh4nH1LzDLdyDwnfuormjqs3udgjOVvE=;
 b=l+lv3vlNntxm507F3F0KHuTHBkdfwb174RUlctiBXfUoeAUULAUkviw1Mv9B/uDe3rQYUNh6gkwTH433dF9SIzE+FbWRmykN9LwausRsMlecrw3rMzpiTdv0FLKeqUI72c2ALYaP8DMyi2a7xyLIu0YZIzrAs6ULYnh26hIr9LNibQx7Oe6EoPNFZSB5Izx4JTesff41lH0ZnWZCSX+dluE6GhWhFgQz6V8WbyYvBkxF7b9aYALU5XshsFHdl8giR5BIYxo0wI2PMCJvuKyxWLnp9BFlVuKbS+nDozQNoWmMvhDfa08opft6DM6MPdHo/5hfOO63IK5fGKM36FYWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMWTYmbSZwguh4nH1LzDLdyDwnfuormjqs3udgjOVvE=;
 b=EHs7iCKZ2Nk2vhG8plPmht3sPcwuWgLZSlWrYUNHCXRe6M2wc/i8PUwUcINtpc7PHmvcKhPjvyOSvGDGCU5fY1sJikdGxKX6NYh3oGOTkBPkSg+DHXlL22QDjCIloZeuUq2VLHUdtDOiUegOigiob7tRzGqICfBtLtlypX3uae/sAuP02X8ZUozdAF3BXrWsaE4T+vxnyZL0r53J9w6U8655Bx78QDVSlVoYdsBi0QIrU/QLCsP0KqKgg7/xcEoes+IqgszR7otCq5JtXHbZpvsiR/PG5apqsGaNfXn80EYenKTDjVhsLf+XHfcLY1YivMoZ8raflRGXuUHEQTwqaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 04:51:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:51:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 13:51:48 +0900
Message-Id: <DJNTDHHA241B.F02USZFN28XL@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 08/19] rust: drm/gem: remove DeviceContext from
 shmem::Object
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-9-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-9-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: e395a052-9a5c-4022-6126-08ded7f5a19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cfsOFO5lDjHnpF0QpQ6ihrGzoYi8tPmsSi26Q3x4Zil/zZqGTO7kC1HqiiOE4sPcugh287nQOx642XBRggeIxt8TemnM+cp7ltS4PzcnDoiR3ZsvBwyaUjyP8xVcNZc1h+Wi14to6g9lKrtiEgay1sdZ0D/VaCK9X0gSyxBeBSdWTEljSyJRrg6X25v1CTyfVv/93OQ0zTR/R280md5CuJ7PG8Q7SNB5fQQ7toknnYBzZLTcPnbrg1cf3rveuMLMBPBGgqWGnFPlVvXZeg57KYeRVEkvZQuoG7+3kiQLNgbWb1XpnHfMq89ITdsuhojJjOjIVzQtayHlfT0TpVI+kSPSZoofLzQ079aCswleumnLTA1UH2kHg1KVkNO+6HcGeETwhXb9AbVyhd7IqBBiFD4c0bj3AfHDdXh1nfUdSPCTMGoO8wriOlNsgDjf9rON5/sPQy60lWpasQj3YEhLS8U8cnCj+9YaftYjoRaFET1Z4T04lJnfqOmRhfAqrdsryw63i6DLu+4zWMRYcD1vKuKqdAlmzcj5iulrSpr6afZ+7eY/MnE9dmiUf4TFXdihyYFfuR5Nhettjs/+dDl0d/7nWtZLYRfQyYSG7vUfHDXyozg+b+P3tnhB+XJ0rTVmZjmXHTqLP73CZxYq+cJu5x7ciZ+Nji1MJtB1LUBznNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFhcDRlaVlhbUV6ODFva1g2Z0hoTlFVcmpDd0JrK0JzQTE0RUc4VUJURW5u?=
 =?utf-8?B?ZllZUTNwV0hXbWk4Q3BTQktQbWNEZXVkRWloWithS3N3emF5clp3ZHBGSjZa?=
 =?utf-8?B?VlZOSUM3Rm9DUVM0SHoybGtoNC9pQ2hjN2FFN29sVGJSQ2pvbDd3MStWNTZ3?=
 =?utf-8?B?MmlzM0ZSZlA1VzU5d2F0eGwwbFordmlVY2FhVVEzaW9Zc2xpOXpaRkNhNzk1?=
 =?utf-8?B?UEdaOVZpYXl6Y2k1YVBsaUV2Y0RFTElzei9oVnk0WnhZbU9oZGd1Q0pOYWw2?=
 =?utf-8?B?K25TUVUzVGw5UlFHdklxWXo3dFZ0bG83NTVUL0I0V2VtdTdITjRUY0VYTjhl?=
 =?utf-8?B?SEUwZlQ0TGVKQWg3eWlFOStFQUMrQkp3by9yS3dOcE5ZMTIyNnMvWGtkNHl5?=
 =?utf-8?B?QUZmMHlaVTFJTW1FNUJ6bGVjbDZrT3dVRzZBNWZ1RUhJTjhoMlhpd0MyNXZR?=
 =?utf-8?B?WTZVcURmM2NzYnROaUZyMmFyb0EzQXdWZDFDSnpBLzdvcURKSXA5R2hmYzIy?=
 =?utf-8?B?ay8vVmVIeFgrY1lCdngzbkRBOHN4R0p4d3p2TjNUQmd0ODhIODV3dEUvOHZZ?=
 =?utf-8?B?ZlBtdUhQNFRSakF2a1NlTGlhSDNiTzVjNTMwc3Yvci9kSGRpQkdvaXo0SVZB?=
 =?utf-8?B?M2d5TWdiamFZazcya3pNS1ZxVGZsQXl6TEJPUS90ZnR0UTFzWjd3dDVIeWRJ?=
 =?utf-8?B?T1o5Z2NodDhWS3BLK1JZckltUFBCSkc4eHBDSjZoNUwyM0V1bUxZTXhtdW1w?=
 =?utf-8?B?UmR5YWN4djVyeTBDSnVQT1R2RHk5aE8yUGJIK0xXV002Z010TWtBdTFDRnYx?=
 =?utf-8?B?Vm51OWYxVk5hQk5SVHRqVWVsNklPNFY2SVIyZmlUYW9vT01RZzBGdUVVMFNs?=
 =?utf-8?B?elMwUklmTlNsYjJxYWNqNmIvWFJ3enhTendpWGZGM1FCQU1oSWg3Y3FheHJH?=
 =?utf-8?B?OGc1dGJHbldDZlQ1c2RaN0pTSVE5blU2TU9sbEk3ODNFUXNmK3dJRWxCZVI4?=
 =?utf-8?B?U29lNFhqTFpQc0txQVZyM0ZxZ25uT0QxOW45Q25Sak43MFJxMllKeUZBOG5D?=
 =?utf-8?B?c0wvSjBCRVRLQTNYaGowMDhpRW1ad0dXZ0dLM3ZqOWwxZEc2My9NSUllWHJ1?=
 =?utf-8?B?SFhaUE5pbE0vUFV3azFHSHhHMEIrcHU0cjZnSmZ0US92VEhFaVNsNmJVb1Bx?=
 =?utf-8?B?ZnZCeTBrOXY0WVJuSXpaSmlQcmxsY0ZNWHhXS1BsS0pBOWFCMXZSS1hsQlc1?=
 =?utf-8?B?Zi9WTWx5VlFBOWNTRVlGdW0relJWdC83YTFYV3BFbTBIZ3kzNWp5SXREYVRQ?=
 =?utf-8?B?VUVoclBSTVp4MzFmWi9Nejc3ck40MFZyMUV2QnZxQnhmRnVIdmx6ZnY4eDYz?=
 =?utf-8?B?d3l6bDZ0U25Jd0o0N0UyaG1IVEhSVENPdVVQSWh1S3o1NTI0QytLd2dGOHAw?=
 =?utf-8?B?YzNlbi9ucWpQV2RCNWJZYTV4SzlPSHNXQ3FnY1NhbUkzeU8vNjNmdjBCMkJU?=
 =?utf-8?B?aXBndzYzV3dBMGdBQWorN01TdFFoM2RuUHRyRjdaRTFDNVYrNVZxQmdDMU1w?=
 =?utf-8?B?ZXl3Wlo0SkxCZVYxVHBEbUUyVFhablZqTThENGE4QTlNU0JnbmpUSWpjVm1J?=
 =?utf-8?B?Z3RMYnV0Q1VqZ01kTUpzZUN1SVJ5c0VGR3c2cE4vZEhkYzJqeEV4MW90OEZs?=
 =?utf-8?B?a01YeHlTSStUSloxNjBhZzNmb1V4NS80SWhOZlRCNHVURC9GUnBJRTBHYy92?=
 =?utf-8?B?QWVwNmtuMXZ0U21TYUg1eDE3ZlFiVU1tK0loL2UzM3BqSVFlMzQ3MStndjJy?=
 =?utf-8?B?b25hNXJLRi9zblI1THA1M3p4M1FoeTlnZzR0NWlWbzc4WFRoNkFremU3SzVB?=
 =?utf-8?B?emI1WU85dFJlaXExSnk3dGpxcG1ZNEhpTmMxVVYyQWZxM3RCUHA1eWlWS1k3?=
 =?utf-8?B?cVR5N1ZzaXg2dWc0ZWZ1L0VqKytFZDdaZngvcTluaDg4NTNNWTNRWXE2cXhh?=
 =?utf-8?B?cVQ1VDlwUjgxY2ViQkd0OFhtd2J3VnVueHl5b0hib09iWktLYVRGTUNidG85?=
 =?utf-8?B?NDVVWkJEem11QXV1ZHFkaG5la256WUVvL3lwRE51d1dJbHQyVS95UUhNYkVO?=
 =?utf-8?B?VSs3c2FoK1ZteWFDa0E4TW1aMkNGS3d0MGZHMTRuSXJjVTZvV1hRZUZoazJK?=
 =?utf-8?B?WTE1cHdLU0dBK0NRS0hZS3p4eHlWNFp1Z1FuL3lEQ1c1R2dDc2RwcWNFcVF3?=
 =?utf-8?B?emp6QUxIYXZtRUh4RlJyYURXMGRFRzVZbEVnSy96ZVVYSHFEdWJ1Z0ZyNjVM?=
 =?utf-8?B?bTh5eXExLzZxVTE1dE5mTlhnRXd2R0dtQjJ5NmREMGwxZXhNdkdWbDdGQ0Qv?=
 =?utf-8?Q?gvwkhQnSrUKS3Ho2HCUJvOtg3vXMoxbcYi1GkWNiL+Tc6?=
X-MS-Exchange-AntiSpam-MessageData-1: +u4p6D0CRk4drQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e395a052-9a5c-4022-6126-08ded7f5a19d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:51:51.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBaiOzfqvS5MVMQ49XOMhr8MMcIn2/SgA62hfJEjUsQTnUZeWfZ2TMf91HR2tSlhw5XW7E9hFhc08wh7Z19CTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Now that AlwaysRefCounted is restricted to the Normal GEM Object
> context, there is no use for instantiating Object<T, C> with a
> non-Normal context. Remove the DeviceContext generic parameter from
> shmem::Object and all associated types (VMap, VMapRef, VMapOwned,
> DmaResvGuard, SGTableMap), simplifying the API.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675D606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aKIs/za3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE7910E547;
	Tue, 20 Oct 2026 00:56:30 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0862410E547;
 Tue, 20 Oct 2026 00:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Njinc+Qe1pyzYzZwPzeOLRuBCau8T4Iq5ozNKPZiPp+zFcDmC5PQMr/hQj5ePEDUGkn8NIxe94wDFZQvHGSm6x4g7h3Nry1zVeag5d8Nd31Fbb0SEN/zkg0SDfigYUPkYdIzZw67qY/BMvmOflURk9RIE7B/q3zEe5uxPmLCTvSpbpuN31Ix6twk+D46zmHSp8KCmzr4kbIc13bWcm+kHhRYSvEDtFcrRKiQX1b8MEoLLIm1mQCSBtjtzkrPzXhLcRKZjIu9wfNfBSI/QOmABYJ7zpp2R/FhBfvkUYAMxZix8JLMiqx6hbH7tiBN9/CZdUWNnvY+iieZrFY+3vAhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks3H+BfqauUJgSMfx1dbWi1lY0a0zd4ETyLBecCRhOc=;
 b=MXDBBMSzBxS2z0KHtKQzaAPWzeBKMsVosGVE7KXIuaV/TxU8wBeH5RueG/lXxw2Ni4hGTRO/VzZbZWk7Lq7UmJU33Lv+sAKFc+Zfl0oA0P1HHAv4M0gS9O/ETSzJIz7rHAFN/vCtc7tVn+s2okW9scw/2hqMKwT8nfdHTtOFebg4OuvMGZGk3lBzwxP3BfFDmTzjfLa0vW6wTE3qVvxifxmyDU4km9pOps5nkYirthjgd5ZGuHgI59kTqws2z4KJRW8aQdXpW26DrSo1zjz9SVrZU6jLXR1Yp1OuG6aEI6tyvY5TH1LUwEdybIQYXTUWZNhhQ+KsO5tWw+C3pKoKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks3H+BfqauUJgSMfx1dbWi1lY0a0zd4ETyLBecCRhOc=;
 b=aKIs/za3fucguUZmUlE9VviNMH+jYUrFc3fhyvWk0+j3wK0qLkylYTavi7hzPrwBzTLZ8y6iDNJY0mD0Ux7Jsw5EtIaEyBDYB0EovxjrfmVgNxSYqoexN9rWRvOOAuUH0j3jO6lXewtenIINS/KquMC9/6E09GOj6QjIP3IXWMaPoYworZx9R0UqIPWzeqeX450G4zC3B8PTZCBFIijZisycUZPQFoALWfB5kQxDz7juFNWs+vmTP133Q9BflUXrUWqFWauW9LmKPcYm1QSFLrYYHB2roUw+eKD0npbzXs8XB/q6Xo0Uxwi3cYotJgUAvw2ydKTi3ujQX4KHKhIfDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BN7PPF862C85B20.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:56:18 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:56:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 09:56:14 +0900
Message-Id: <DM9991XFZM69.2G13TB49VYPJU@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: replace unsafe pointer cast with
 pin-init self-reference
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261019133647.1279779-1-gary@kernel.org>
In-Reply-To: <20261019133647.1279779-1-gary@kernel.org>
X-ClientProxiedBy: TY4PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cae5d6-7a5f-4b9c-6622-08df2e44f309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|7416014|23010399003|1800799024|11063799006|56012099006|10067099003|11062099010|22082099003|18002099003|7136999003;
X-Microsoft-Antispam-Message-Info: +wfclkAt6eWBsl1ukS30aqGRTTbXpDrqGeHI5kpaOtG0MBvMzuzkhXwFs/tALtnLrlmL0mYBR8uoW63LbKd3axHbmfflDwfop+nloLob0anj/3RFm0itkn9Jag8TnPhbhVRz1iJbYZ8ZJh+VCIy7G+IdDGO09aDrhnp6AwUcbgUAZyU3l4/2Akcnm47DsyFoZMGxVmjf87/vcwOiHFQct25qr9bRBWPmFG7ng8PyPaQw8GVMiISGYmvP3prjvDofgvUCwkXl3XrpdH5fPDKQPsXQG9U1xJbEndZuBTVtEHo00NxI8J5kP1iy8H/xnxWq9TaNUwXVnW06YcnNYNf3l650Uu5NUGQVAMR6w7FdP63xNll1DILcxKaPFw2NCQS7UB5Lhfnez7DJNYJNt6KHueN7Qi66vEl/iSbZZI1P4QRc17esCux1yrGMyJeT2+nLTdUr/zB3d2AEF6v5E3/pA2rt+62O7U85rvG2oomxLbLmDh6U5YbuOa1e4xW/7LBcb5+rz59y3ZaNPCCrZb6Te8f1571eARG+lbWjCNek8vTOnldFKDUteVdV4+6bCkQ5RQukAtFhJVQhiyomTHdhBKnGrlXA34U8MpVj2r4+eIIZ4FJ/3cxWETfXkFNH5nOu32z7m+lrqJMcI628R6AwHVB2M1gheYRyXPKhTvjUQ24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(11062099010)(22082099003)(18002099003)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVhUmdLck1wOEtYVGJPUEM4cFRWamhnSWpRZS9EdHRHZzlJZWY3SWJqYXFV?=
 =?utf-8?B?TGp0aFZEd2sranplWmhqd2ZqMklnWnRJNmxPMW1WNlhMSmRiUDIwMEJKVmkw?=
 =?utf-8?B?QW1HbU40TEdlSXpZVWpsdEFqaDBjbExKaG1FT0x1NytlQ2t1ZENHRVFablJa?=
 =?utf-8?B?WjlOaCtpMlkwOHVkaG5iSWUwNGQ1empOTjBaNUZxRU5SVGx0NWRqQUxnTW1x?=
 =?utf-8?B?UCtGTkRiQVY1NTRCTkhMS2Nrc0JzYWhHVzJua3dzWTNma090U3FBcDJQUlgw?=
 =?utf-8?B?enB1RUppNm9QeDBvWlJPVGZxNTlnNkoyZi8yVXZGQ1ZLSE5xN29VSzdlQ29F?=
 =?utf-8?B?aXZmRGlnUDJ2bGFoemxjTmE0UVFNSXZPejg3dEdVZDJrVGJTUG9rM09sOXBp?=
 =?utf-8?B?TkVtV2NRWGVGZ3JlMllUbFNjYXV3bkVQMEcybmEycTQweisxYVVIdmNFaSsr?=
 =?utf-8?B?TXliS1dsNitwcFlwOS9wOFhlR1lldmZrMXlNaGFPckpTdTNPa05kNFUrL1Vk?=
 =?utf-8?B?ZGsybG5OZE9HdWFmY291QnhSZGE2VkRSVm5kdFJyRnEvd2w5MjJ6T0hYQTlQ?=
 =?utf-8?B?aW5OZTNQYXNUYzJCT2Z2WmhrTXhsQkFKV2dmdVpWUXUyM3I3WWd6UnJNMEND?=
 =?utf-8?B?d2ZFbzQwYUJ2MjVzK2VLRzR0ZnRRTmhlcmZYK0RBK2JCRjlCT0Z0M0xMTG1l?=
 =?utf-8?B?T0c2cVB4M2QybnRlUHBKOU1xV2FjQ0ZKb0tjcUcweHh6Y2thTHdnc0lpY2pB?=
 =?utf-8?B?amtVMXk1QkFMaVVHeXdKalIxcHlUb1pIMEtLZTRCUGpUb2tBRFBvUFdCV05w?=
 =?utf-8?B?cEZBWDFGK2YxMVlHYnVScWRiZHhHOW1PYVBCbkNTeUVoVlRDMFVKbTl4c1ZN?=
 =?utf-8?B?N1B3QXVCWGhOTnZDcmtkcytqRFJLbGFFZWFCbW8wTW9PVXJuaEtDZE1lL1NT?=
 =?utf-8?B?a0Fja3haVHN2bjBqS0FZclFTYmZQeTV2VFBzTUVQc3NCYVVIaDNuUDVrdkxi?=
 =?utf-8?B?UWZPa0lGYm5LVnN4dEdXTXRrV2YxZUhoYlg0eU01MFRhLzE1cGtFbnlWQnZx?=
 =?utf-8?B?akhVVm92RzJoU3NOVlBFekhvN05DR3FCWDloWnZFeDJyclNqelhYQWFSSkdS?=
 =?utf-8?B?bEFnakhjamtoUzhTK0ZnUDRXblJpb0QvNmw2WU4vM1E2TGN3MXBFeGZHcDRs?=
 =?utf-8?B?WS9kV1NlSnExaXkvNnRYVTRhZHVJaTB1a0FEbnpCdHpoeDRRQi9LanNUZDB3?=
 =?utf-8?B?Mlk0UWRTVWI5NitxV0ZuVko1d0VSZVRYKy8wK05wM2Q4Vlloa2FlUEJEM0c0?=
 =?utf-8?B?dFZldzZPZ25yUEFEb2QrdCtUTUJzSUtWY1F4K3d0bC9Pam14RXh4bU5QQkNh?=
 =?utf-8?B?dnJpaVI5VWVwY0M4UWJCWmlTMmJyUTZSdDYvNlZPNTRjcm5mZnoxSmFkVUkw?=
 =?utf-8?B?YzNseXQ0YXB4amNDVkl4ZmFMSGRHU2ZVcGdMZ0dIVHJLbFRpRWFRclREbXVY?=
 =?utf-8?B?Rk9zWSs4UnNkdUhFRFhuaXVlcUJHeEpFbmU3ejZzRWZ0Uk5BV1pZNUFjVnMr?=
 =?utf-8?B?ME5EbTVNRGc5RlB2R2RzRE5LYmRwUDZTU2Nqb3E4VldsOGMwZVl3aGwyVHlH?=
 =?utf-8?B?S1JGZDBjM2hHWGtxakh0ZjZyckkxc2pYQTdPbzJCcnJzV0hGUHFINEZxUDhL?=
 =?utf-8?B?dWg4eDREMFBQbG9KK3kzOHpDNGtsMDFVelo1NDBqdVNrUUZUK3QyZkhsTi9X?=
 =?utf-8?B?RmNBRldTc3VmaE80SVZmN2lPQ3FTa2V5SXVmZ3A3cEpqRkxlb284d2FrYkRv?=
 =?utf-8?B?TEVuQ0xFN2dOS3F0SlhZbGMwUitmZlVzSEh2RlFJWWxDZ1dpVm40QTRxbEQr?=
 =?utf-8?B?N1lFejBobEhLTnJIbXdhR1JaaHlLaVpnWDIwdTVQdU0zZWIyTytOSDZ4MmJu?=
 =?utf-8?B?VU5CYkRSQVc2T2lsSkJ0eHZTcUU4Vk9pMllWSk9ZeThSRUNQa0EzM3hoekVH?=
 =?utf-8?B?UjZOMzV5dDR3SkxZZHZDTzlHQVBKemRjSHJXb0d6T1IzbCtqMVhqckdFbjA4?=
 =?utf-8?B?akdxVG5HaldNSkxCV2s4SGNLTXFpeG82aGpZdElYdmNJTGpYYm00akRDY3c3?=
 =?utf-8?B?bCt6bVl4L2hMZU9EdDhiVUVNYUYybm45L3RhWEM3bVpKMHZDSVhqZGMyaXlF?=
 =?utf-8?B?R0NkaGI0MmxiS1BObk8rRlJ2bmdsU2lqSFpseThBOHdNaS83QzZzM2NoVERL?=
 =?utf-8?B?ZlpuUjNYQ0NCS2VTQThWcFZxUEp2OEVnVGNXczEwMWN2eTdqWHRGbFpLR2sy?=
 =?utf-8?B?K1FrbG9jckZ3c3RJSTUwdXg4L3gvdlNjSG9UOUh3WWVGMGd0bnMyQmVkaHlK?=
 =?utf-8?Q?k0xRXdkr/YGYs7tLqgFWnSlqf+HjszDjiYOXCyLiB4k+F?=
X-MS-Exchange-AntiSpam-MessageData-1: cMbVweEGtezIRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cae5d6-7a5f-4b9c-6622-08df2e44f309
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 00:56:18.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfmoLfC9qv99eRzXArXKP7ilRdymjS8ftAfzsDygS3fKGZ/iMX3Bj5bdRHLtOcmeb6CJlTJPzKFM2soVK6tjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Oct 19, 2026 at 10:36 PM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Nova core's driver data makes use of a few unsafe self-references for
> device resources. Replace them with pin-init's self reference feature
> instead.
>
> `auxiliary::Registration` is only allowed to capture a single lifetime, b=
ut
> it needs to capture `&'gpu Gpu<'bar>`. However, we cannot use coercion he=
re
> as `Gpu` is invariant over `'bar`. As we know that `'bar` outlives `'gpu`=
,
> use pin-init's existential lifetime to erase the `'bar` lifetime in
> `NovaCoreApi`.
>
> Swap bar1 and bar0's drop order to make pin-init happy.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>


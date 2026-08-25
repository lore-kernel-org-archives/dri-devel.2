Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4CFC61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B17E10E156;
	Tue, 25 Aug 2026 11:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMJv0V/H";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598D710E156;
 Tue, 25 Aug 2026 11:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj/IUsAd85Cb6b9fuQ2iunDWmfKG8cmb7zYGtb+6q0mE+gIYjo9YTjYMGoAtdgONV33EpqXaUrV4gCBuLBYPwqJUn1/xJpbmpsCHyYsXdc5brPcyX0a6/o2o1RsSXkYUfx4jhz+8vcJnB2MtWp00+Y1KlKGx8Wfx7mmkLapWzy0ZfhZA6nK00xJJzFE8idFHvO0W4MvAHFkjgk/L/t8p7UY8nKTtNfxjkl7abUkArJpTgCPCx5LGIKQKJBhuX9Ng0bDSLb/ljaQIXg8qqiibLcOietcWzLiMXIEs1+uewy0RMjBYEqCQAOh7qbgp5ef+7nZicqQqBR2Z/FRBtGIBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0VJGh9MTtMMiSTkmXeCYxH/jaZYENX3KwUki0F+BJc=;
 b=STntJsQVmksQTQ8uYgo/HJInPNoDamKnaQUv2MUEDshdgW2ATPne2M3uOnQqZlwUSoKmjZlXmZGaYdzjzpcq8IrluRrMpK+I+asQrs5wlv+HfcwWmnBq912VngWgCEpsniFFdqsd3xXU/rKBTADP5cnAqW2UgWSnN8ccj0P3cImomViYAB4tSvF40iu6OLb3jPiEs+NGCUTHV84J6JDWInfWkkQ43Q7j35t8ZNAWGc1rPqjULgIr4NK35M5m8JfH24kELdVqigXcEoUFdl/WsYYCmK9gkgpDeFARbMsgjCDUS4fQ+Li4j0nDS2YiYQOSSv3zB23XBea//foEBxRhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0VJGh9MTtMMiSTkmXeCYxH/jaZYENX3KwUki0F+BJc=;
 b=pMJv0V/Hswc4RRO2qqvo1wCymt34j5FO4vjSiiGiY2om5kMb0Injgu+2R3gVKpH7SCxMXx/NaI5CfvX2kVJwABTN2rPhuh5kKfXyXqL8B7utPa+xPmo2muoJv9qL5WLAQmGhm2svbUw++gol5JzjrzPD/3S7QDCoU4HvobUjvNk/Y+R4EYRDIZlESW1hypMvhcUCUj26GNp03po65gtzwRiFY8mSD4ZHqv2dnZuCLvhtMgwqqliZgIXtGyl1y4YWP+DkS+30yUl7KvyopThswZ860Q08s+L7G41HaIp8aVlrQYZyhojLDE6MWzKOHoQKhTr6IbCeQcSTkI1j21K2Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Tue, 25 Aug
 2026 11:09:17 +0000
Received: from IA1PR12MB6411.namprd12.prod.outlook.com
 ([fe80::b29f:6f15:4ece:5b5e]) by IA1PR12MB6411.namprd12.prod.outlook.com
 ([fe80::b29f:6f15:4ece:5b5e%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 11:09:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 20:09:13 +0900
Message-Id: <DKXZ7VHUCLWL.C6IPHWPTEJW4@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
 <DKUHJF1YTTY6.1XXC1L2SYXEMF@nvidia.com>
In-Reply-To: <DKUHJF1YTTY6.1XXC1L2SYXEMF@nvidia.com>
X-ClientProxiedBy: TYCP286CA0350.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::16) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6411:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: b37c6321-8ac0-4c5c-9069-08df02994daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|7416014|376014|10067099003|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qH35Mnmsc70AIclDXt5sjfkOOQAm/ikSoJ+vAM+LV446KLeNIOWW9Y4ZZQWTGgfQvAYzAK3j2A4kn+MYqO3+cPFBt729A9U0e/qoIwtitlI3yiZRePGcvuwqbjsK/n18vRR/N9KXzfUTeFJaVI1x9RPHLNgQE1Ww5rwfOnhe+OTlAWXiFY8w5k1+5qZ2hPttVXBWrtopqUEQV6R2JQ5cKVmcUOgRSLUW+nLixRsRYO/2X1AoAQsLL9h/ehoVYGpI1oKdD9GdCQMMVXmjOsHdNMVtFFWAXFbmxl5+PBa2aFYSE879QDFs4lswpQL1TEfz8HsJzeNp7On142MV+DmehhxLRYMoPaBLq+/xzCOBkc309iplqWva5SwmKz3SuIl0xnuCncv0/kzwSnNj//r67hLw77tR7LUZha2MfngiKD6+W0Z30LrTRi00WmDOgW+Ta5D457uK9yhwmhRylQUNLNd9ZnTYcLCe4gVO2ZUvtpd4Qvg9SlR93vqZD9gb7afiwx05viMbucTjOux4hlEY8n7eDPGRF/aIKtQYgBiXG+w0GCl8oTSkq2WPKBrn78tZ2WRYqHStlqHOfpoy9vufAW7ovIqZsUEIROAOZYo+h+OaxlRD56IXDvpZpCP0fNXTpX+wEajXYNO7jkGXEbvT5NakaruPjPZ33cYfwfApJmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtUTlZYVnhDc2M5RlNITEgwY1dLOGl4cXFwcUlqZWdBTUxjQzJMVTQ0c09Z?=
 =?utf-8?B?V3Yyc0ZkRHFQOUdjRlI4a2syMWpCTUJhaUdRSDgwT2hTZldNQnlTbkVoYlMr?=
 =?utf-8?B?czVkbjZqamtUN3BsSnU4ZlAveHNXWGYyUkpldGM5TlBxbGR4MTJ6bFFvbm9t?=
 =?utf-8?B?VVV6MXRlV3QreFk2RFBPeTVFLzVLUEhERFp3Y2RNQk0wTTNvYTF3OTNEVzIv?=
 =?utf-8?B?Zit2MWVESUE5RzMxRWsxcDlKcXRFN0tQSmxUZkFRQWlGcDNzN1c3ekMvUkpS?=
 =?utf-8?B?bzBRdlZRUzhEak5nTmtFaHJ0T2g3OTZuRDAvUEpvWEhaWVNiRTBlbEM4RzQ1?=
 =?utf-8?B?MEhIRGl3ZjZNZTN3V0lWRmg5STc3MXAxYi90ZDhTWldaaDQ5WmdtN1FmRExQ?=
 =?utf-8?B?c2p1WitNRk9uSnlkeTFLeVQzRitNVGNLVlRLcG5yNjQ5RCtZUGlTRzdUOVhs?=
 =?utf-8?B?UG1iVnpPTCtBMmJWc0NEVkk0V3g3V2NUNkkreDdOY05ZNWlnNGZ1QVRsNGdG?=
 =?utf-8?B?alo4dXdUOHg4MS83bHNSbUhsSHBlZVpnVFhqWGNGMGhtNHJURzdXOU1LNnNh?=
 =?utf-8?B?Q0RUemhIOGtkWlBKVzBRcE9pOE41SUJieTFFRm1UNnFPbEE0S2pxeWEwZDlV?=
 =?utf-8?B?bHVMZDYxQUxFVmhNajFhUWxGNlBxQ1VTb08vTXpRQ25XNXN0czRmK2IyMWtz?=
 =?utf-8?B?N2pkUGhIL3FMVXpOdFo3Yi9WQTdaNDk0VXp2QVExeGpBS2lWMEtZaWtPVU4z?=
 =?utf-8?B?NWNNTlhkSmxjWmoybVBYUzhnTVdaM0pYRDFZc25IL0tQTjFSU1lXODliNDJm?=
 =?utf-8?B?N0ErZHY0amJPTkZlT25nSnpaU0ZaYWJNRTZlVW5UcXVIUk43K1NLdWMxU1Jk?=
 =?utf-8?B?bmdUTnowU3MwZWx0cVdIRDd2UytaVGhONzl5T0Y2N1NMalBiRzNQY08yeWdU?=
 =?utf-8?B?WnMwMytjYUdpNXlsZ3JRb0lpS25obTgxcy9vY1pUclkrZzBOQzMxQjJVWTkv?=
 =?utf-8?B?SGN1TjNYVzkyMnEwNEZ1RDA2WnYrdVMvYmlGWFFJQjdZRmlNbnF3cU56SENq?=
 =?utf-8?B?VHM0N2lTdHJTMzJaa251MkxzdnM3MkNuZ1JzVXQ3WVBEWVhXSDVKRVk3Mlhv?=
 =?utf-8?B?RGNkRUZ0SFZ6dVY5eE1nRXlodm8xR3BqRll0ZzJFY1RvbjJTK2FQdDMwWWNY?=
 =?utf-8?B?ZjlQcC92L2htdVlQci94T29BRkFkQ0k4Y0gzb09lMml6cm5PZEhJcW45YURT?=
 =?utf-8?B?QjNmOHRZbEgwZERqU2VNN0RwUFhRcTYxS0xPdFNjckp4blkrUDhFakExaUc4?=
 =?utf-8?B?NWt2V3doVjNqRjk5VXZMekVjMDJZU0krU3FDbWtzdnB2Qm1rVG5CcUk3dndU?=
 =?utf-8?B?SURNTWx2SnRJL1dzMHp0bzdvdWVWQ2J3Vjk3eDlGeGFwbzJPQ2NISXJ5UzlW?=
 =?utf-8?B?Q1Q1TmFxNTlmR1JiL1JaWjgxYk5aMnFUSXZ0LzNxZzVGTTFYRHpXdmNmY0V6?=
 =?utf-8?B?NHlnRlV3bXBzTzg1SkhEU2hYdkpNdTNRRGFoMW9UdjkzWDNjNXVLcUFLZjBY?=
 =?utf-8?B?ZGhpVVRoQzV5YmltRDR5MTdES3BrdGNSK3NNTi9yM0I5K3ArRXJ2UWJtTG9N?=
 =?utf-8?B?MFBhQXBwbDJGTjFtUVBsU3J3cVNHcitSQXpiNU13ZWVxQzI5NUVtWXdRVjU3?=
 =?utf-8?B?UXBKdDJ4YTlQanZSUHZQNUZJU2g5clN5T3p6WmxnZG1tQjlTdGJJdXBVZlBm?=
 =?utf-8?B?WGFobE0zU1dVNkUrNmRmZHhsNUZPaTByTTJJVTFMUENVdHRZbFhSNXpHU0ht?=
 =?utf-8?B?UGVTZjVubUQ2cUMyeDZMRzJQbk9CQ1lNUk1aVGpQengzNWc0dXIyTG5SUjQ1?=
 =?utf-8?B?RTllOFpZS3ZuZTd1ZDNzZ2sxUC9SOUg4eDQwVnRHeVNYSXdydjEwWjJabUJt?=
 =?utf-8?B?Y0RlTGVLOHBrQUFhaUw5ZU1zVWdJZ3lLcHQ1YWZKN3UzV3VRU2R6WFBEYkxa?=
 =?utf-8?B?WnhuQmE0R1IzYWRYN2dJSUswWFJNS212aTVjdzZkTnIyMDBWbHBYSEx5cnp6?=
 =?utf-8?B?WlZsN1VKdmtpVmZQMDl4YzR3bEZCVjVBSmZObG5LTnphbGZFd05xM1I4MTN3?=
 =?utf-8?B?VnY5aitPTXp0VUExa3BFN0NRYWg2L2lmRElZSzVaaHJHZFJ0UFFPNjdMMHkv?=
 =?utf-8?B?R05TNXNwLy9VL0FxUk5qT0VDTFZxWmNnTFJlMFE3VFo2UStRSnByTitJSGRi?=
 =?utf-8?B?UE43L0c4aWQxN0JQTEhGSWY4U2cvR2MrdU0vZmJoTkYxYlNFejJYc1lMTWZp?=
 =?utf-8?B?c014OWJoSjZFUHN4Y2h2RHd1MytNamZEditjSk82eDhvNGNCRFNDNTYrTkxC?=
 =?utf-8?Q?JvO0MP7Pzepc9EycqXetkx1TJZDfy/BH1LwR1xacwc7Y4?=
X-MS-Exchange-AntiSpam-MessageData-1: pzi64V2PFTxVZw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37c6321-8ac0-4c5c-9069-08df02994daf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:09:17.0145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNwqsDg1YLIMkG/dKa1EDKFDeQXI4DJnmZ5zsqfVW2GrLlHO/ORf+quhyAHb+ChOuA60jXatIuQ12gvRAd6Krw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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

On Fri Aug 21, 2026 at 5:39 PM JST, Alexandre Courbot wrote:
> On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
>> There is no good reason to allocate an IdPool with zero capacity.
>> Reflect this in IdPool::with_capacity.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> I am not sure this one is justifiable; `KVec::with_capacity(0)` is
> doable, so why not here? As long as it doesn't introduce soundness
> issues I'd say this is the caller's business; a driver with a legitimate
> empty IdPool use-case would now need to special-case it.
>
> Now we do have an actual soundness issue with zero-sized IdPools, which
> is that `find_unused_id` would panic with `CONFIG_RUST_BITMAP_HARDENED`,
> but as I said on patch 5 I don't think it should anyway. Another
> potential issue is that `grow_request` would not grow anything; but that
> should be fixed there by handling the `capacity =3D=3D 0` case. Actually
> that would give justification for empty IdPools to exist: just like a
> vector can start empty and grow, so can an IdPool.

I don't have a very strong opinion here but I can't really think of a
use case for a zero capacity IdPool. Unlike an empty vector, since
IdPool doesn't automatically grow (there is a notion of a fixed ID
space), the only thing you can do with a zero capacity IdPool is grow it
to non-zero. All the other operations don't do anything useful.

If such a use case exists, maybe it'd have to be something like you are
using the capacity to identify your ID space size (and the ID space size
is important otherwise you would just use IdPool::new() with the
MAX_INLINE_LEN capacity) but then the only way you can grow it is via
grow_request() which doesn't grow the ID space in caller controllable
way.

Anyway, let me know if you feel strongly about this one. FWIW, previous
to this patch series you couldn't construct a 0 capacity IdPool either.

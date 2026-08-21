Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C9CC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A2010E1EE;
	Fri, 21 Aug 2026 11:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vf6pD6+A";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDF910E1EE
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 11:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be8wAhlBEjTpDP5pL6gjGJXZoH1OeUWFpPrNHrNoLY9koF5UjH+rdqa/EvgGJBFWLACfsY5spX3a1TSUQi9igh+DeZdO3FF80NBB07C4umKFy7L6ud80WNoeAp1DAWOyf0BZgo/gL6q1Tu+kftADblNrobjF8rwi7ZJcBtkpQ+LbfhWyKlJg/xJ0h4RNS5Sn0bc/Vos/RW96YT9wWnOuCdcxugyHIXwoypDZc9iAJEMfr/V4Ybq+YiPKNpCu5f2SCdUlo2Zx1pT62cG2ddhmRNf0DhcVRTXSVgqHcK53cuos2LOnhapMGKkZNkSzq9r5Xq8JJs/2rbA9KQHSxZUJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyEsVoLfd11KooAnN5oYhfzDC+dz1BpkSLbBpFCLBb4=;
 b=ZLyVv7hglPx2GPyUdSkFPx1VYM/3Ucd+1QdGqP6H4JrzHWxMh+lhPo9ty8WoKtWlv5yeCqn2n5AHpCJQzDJfuSt8auMxMI5dY3u419JBP4Cj3OddT8xHGbEPMqogJHkcn8e5oE6jKl8ejuBEy14fKuNLySIcWKbqNqEQbzSc2nXOI7Y6s04E+gZSnd6dBUUrzAKnOXdcjlue6hPrL7nWN0g/47plwGupFnG5FFoaGpR/I6xdkXDNHpnlr5g0rCOwhH9pjYFl5VUQVULFzsPtgdnXs14AqJjv3NCpfC8Z/LGWb/qrU7HyPhq/ayO7HFdHE6SFeGpgSp/RHGxEIZMU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyEsVoLfd11KooAnN5oYhfzDC+dz1BpkSLbBpFCLBb4=;
 b=Vf6pD6+Ab8gwhx4Uj6Lb1SRvDMK6UQw5KAs/a17maFg/HTK7l3C77LnbzrLIKVMgnS0F5CKknlbJR7KqlE6JWZjh2rotHg1BsgsVVcO8LY4QhWa5RpU20yt0D2F+HY1DBStjWkJAvY1LjB/cvrq5KLxfl+Z/AdFAFonv/mGOTrUduCC15yJK2MhnFyW60PdRIw+F5y6rVajoII6CEbt+Uae6nfs9zac40Ov+QVxyxNqbxTsCrRFm2chKUGDABFfN1bkzlyGbMMUT4p+C/gfhGD3JDujKG2mjGxHFZp0RMSm3hyi+3yGhLP9v4otvr4h0sUg7WyhM2g5jrTM7b3K9wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:04:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 11:04:31 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 20:04:27 +0900
Message-Id: <DKUKM1RPFDA7.1MBU5EY40OJ4J@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
 <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
 <CANiq72=ot1SVQRxzX5NmyTspzf-eMKca7DQMdUMSHtThn+kfpg@mail.gmail.com>
In-Reply-To: <CANiq72=ot1SVQRxzX5NmyTspzf-eMKca7DQMdUMSHtThn+kfpg@mail.gmail.com>
X-ClientProxiedBy: TY4P301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 89054ff9-b0cd-4cc6-4189-08deff73f94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ijbiSSiR4QYxdbY3Xsjh2OvMLUduMWL2DAPNnYIPHIDZtj7DngghJsiC08ZfzA0KCB5Sa711CzrK/UUNEeNCan8xuPdrk/tJfSyww/7+jFc4jDDYLOR2mjPGnkmVfZpF8nEBd5lc8atcENPrCt4QjO3FsyUtU90lyOiQeo+1PxBId25p1qMgNEc2acPZOgJX178aBXAmn1OZ37gbxyJJoxpOyieMMxxwdlpx7N8KDOubxCeSkZGdWAUM4RzNsD8oZlDd/JuCV4jYF/FX87Ex3a2WeWFmkA36NI4ovFhoBxyOlz4HIXwVJ9TsLgCYDwdg+fnKYK/Itpo3XiCyr6Q0WZVS8LV44nbWQqVaVq+Vzx//7cQPzpM2zZ0reF0iuqZs5KO7SVpAYsH6+Sf09VSae54IXlnY2MI4anGGw1t3eghCrmn+/iaqVA7kABdKBOyDa84gniV8IxpJJKhFpMeFhNhDJed6MGjJ6+eOLku4Otrpzb/kAyMPMnKGwBeczgebFmA+4iw1HquyJldjxHAFIkLop4KKjqPIAUQ0c4wM5zzzfzGHzJQGyy377lZMHgPcHfsPa1sYvjKb4T0xH61er6/dynBCmEXQPzlxW0EB8dgUZg9k2hTetg2jRqz6gGq+hIBYCtxWUakEY5/UogUKAsxPJwckkeftNXVMqpZnBjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVpbGF2RmNtRUdtSlpqMEJrNVFqbFM0aUY0VXdYbkVHR1JLb1kxL0N0Rm5k?=
 =?utf-8?B?VUtqQTdOc2RvUkR4NEJiN3ZzT1QyNlNSQi9uY1JqVHdkVVpkN2NrbGVGeGVY?=
 =?utf-8?B?cTJseW9wNFFaTEduZXJ2dDNQQXRuV1JxL1VSVDFKclZrYk1RMTk1MUpxZHpI?=
 =?utf-8?B?SUJpRkZUQy81WUlZRjBMWnlvc3ZvRDZoZFFSWXVqdjRPMnpuUUFCNm13S2hL?=
 =?utf-8?B?bXAyWlJZMVJRVFN3dmhvU25FYkhoVGozRVF4MStIc0FoaUNMdDJVS3VTbWV2?=
 =?utf-8?B?aGMvN2x4TzFRM2lENEhNdExISG10elFMRHJlZ05SQTZ0YXNvSWZMTi9FOWsy?=
 =?utf-8?B?aXNXcjlCYy9XU3FGMXlrK2xRMFdsNHM0QVVBYVlVaTJNdGxQWk8rWHFjeVVm?=
 =?utf-8?B?WEJkVExSUzlIeGZVSXVtdVBmWTdTQW5MZzkyMXluZ2VpY0NSeVlUY1kwMERi?=
 =?utf-8?B?SVlzaDBBdTRnelI0TXFmQ0NrUmQ0czZ3dHNha21zNzNqbU5kUHZqSW5Bb1RF?=
 =?utf-8?B?ZEZGdFpOZ0c2RGNNczZ0T014UHI2OWszTHNhTGl2YkZrMi9udkY4VXp4Zjh5?=
 =?utf-8?B?cHcxNDU4UEFJNm5JQkNSeUQzM1d6MEFPL0ZJb2RtZ2hUMmk3RjFQREtQWUNi?=
 =?utf-8?B?ME84clhvZVRENmN5dmdpaWs3bDZ1ajZqcUM5ZU5Tcm80RkRMVmREc2M4SHBo?=
 =?utf-8?B?L3NRR2NveitRRUw0K2FTWnBhdkJvdTk5bC8xVnhkSFJ1Mnd1RTZIMjRYMmlX?=
 =?utf-8?B?djh6dnMwR0dHVmJ6SEl1OEI3aFhtdmNWWUhnMGE5TVVEK0lyU3BPT1pMM29t?=
 =?utf-8?B?dmE3TVFBemIwRWYxcDBEaDFaVEtTR292b0QxMlpqMW9sekdEclhKbkpNVEl5?=
 =?utf-8?B?Und1akFsZFhNbUw0WTcycG1weXh5Sy9yOEFDMWlSbytsakw2eWlzRWtMRnNX?=
 =?utf-8?B?bko5MmpRUTZxVFBRMGVISmFxZjVwM1dWK2thRWFSR0JhUk52ZWhrOXhGelRk?=
 =?utf-8?B?UTJva3pldHRGUlhVczE5bVUrRHF6RHRGMGxTZGc5L3d5eThZQzE0d3NRRXBU?=
 =?utf-8?B?UjR2Z2tzdGtRZkZuMHYyTXl4c1pwZXJaQm1LVnMxREIySXhDdGN5Vkl4L0pr?=
 =?utf-8?B?ZHlPVEkvMFl0Y1RhUEhKZTRpUGtSbkk0bnVhc0dZS1pCd0pUdmN1VjNMTjFW?=
 =?utf-8?B?UGNkMVlGUVRQYzdtOGJXSGhNeThucTc2K1FIZCtTNTBHdGhyb0lzMFl3Y2o0?=
 =?utf-8?B?TUhUZWRKU2V5Z3lhTWdQZUlKTDRMc1hsOXFtNmw2V0FETC92Q0FyWVlrWEJC?=
 =?utf-8?B?UlMvdGZVcXZzWHVoZDRqUHVxUmlTUkI3TEMrbnAxNmI5aHMzY1h5anVYY29z?=
 =?utf-8?B?eG1LdXFHYnRiSy8xeWpSU3ZqZGx2SWpseTR6UGpPa1FEcklTazJGRDF4eUR3?=
 =?utf-8?B?RS9KaFFHTkI5WGVZNU1JRDRDUlNLNG5FNFhQQi9nckFXb3N6MHozM1Z6bjBr?=
 =?utf-8?B?YWt0eFJqZ1U3cGhRZTBFSzFjTWZrVm8zN1g5ak5meC81L1RmMVFxUWdMOGtv?=
 =?utf-8?B?OStneFc4dTJnOHN1ek5GSUljSmUyUDhUV3VHeG1ha2R3UmhWbjk3THRPSjNz?=
 =?utf-8?B?OXBVYzVCRm1id1FYTWZhajk1b3IvTm9MUVh2KzZja1J1dmVmRmRQek5JMGk1?=
 =?utf-8?B?Y2ZCOWo0Y29DUVFkUUFWRVZTbDRyL0hsNmlSWDZ3OEFzY0NWb1BVVmwzMlJ2?=
 =?utf-8?B?enoyL1FERG5YTUxRbWlMbWcxeC9MMnJkbjBVdktGcDJIWGVLZlFYd1Bpd3Mz?=
 =?utf-8?B?Y3NzS1pSQmsvdE1NdkdRclZrQyt3YzdDUGltTkNTQW0wUC9FU01iZkk3c3dF?=
 =?utf-8?B?NHlZbkNSUHZYWTZNdC9OTkhrU3ZYVXZBdE50U0NjR2szTWNVbnBndXdnRDJa?=
 =?utf-8?B?YTJYYjYxbXB2U3FSUGVMN0s5bWpqMXc2K3JvWDJ0QWtERUZ2MFRoZlhJM1kv?=
 =?utf-8?B?MjVXeUIzL1dzdVVuUFdzTWVrMTB0dmRKdk0reENJMm43d3ltMVExaVZObHlU?=
 =?utf-8?B?Z1c1VGVFcFdxcDhUckcrZjVyc2xweFl3WWoydXhtMWtqQ2o1TzlSaVZGNFla?=
 =?utf-8?B?czN2NzFpSDZ2UzlFRWx3SGJoNWJ4UE5jRUovU1ltSElBWmp3dDgreUg1TjNL?=
 =?utf-8?B?S3UvRUlPdHZhb3pOYUFuQWtMZDBzdExuaTNNS2RsWm94MkpvSFREdUtXblox?=
 =?utf-8?B?a3owZ25pTTBZU29yV2FRYW13LzhXK0dmK2hNaktPeWdONHMwajR5T2hmVysx?=
 =?utf-8?B?c1VtaUpGVzZWNU5TKy82Sys4empyUlc5WWh5bXl2cXVzOXI0S0hCMVFnRSs5?=
 =?utf-8?Q?48DYPxegO8SUPU5frzosyZXa4jKfwDiM4n9go5gPeAsMT?=
X-MS-Exchange-AntiSpam-MessageData-1: jxhn/xS6mZIUxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89054ff9-b0cd-4cc6-4189-08deff73f94e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:04:30.8134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQ1xGCc7eA15AOln5C50MIaRCmA7RiT8kb/A+E+CIa0hLnbpmOtUIyj2u4RN2ewP+GvUUKo1WbAmaOwH+wn5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

On Fri Aug 21, 2026 at 5:31 PM JST, Miguel Ojeda wrote:
> On Fri, Aug 21, 2026 at 10:11=E2=80=AFAM Alexandre Courbot <acourbot@nvid=
ia.com> wrote:
>>
>> Mutating methods should definitely keep that check, but for querying
>> this looks like a legitimate way to use the API.
>
> If there is a need to use the API in a certain way (and there is no
> other intended/"better" way to do something), then yeah.
>
> Otherwise, having `debug_assert!`s or similar are more than welcome.

I think there are two kinds of operations to distinguish here:

- Setting/clearing a bit, which can be thought of as an array access
  operation. These are accepted to panic in Rust, so it makes sense that
  the bitmap methods do the same. There is a side-effect expected, if it
  cannot be performed then something has to report it.
- Look for a bit/group of bits that match a certain condition. These
  operations don't have any side-effect, so IMHO it is fine to say that
  there are no bits set after `start` if `start >=3D self.len()`.

I'm not super fond of the different behavior introduced by
CONFIG_RUST_BITMAP_HARDENED. We don't have a fallback in Rust to
silently not set an array element if its index is invalid - we only have
panicking and checked variants. Bitmaps should not be different. Fixing
this (if that's desired) is beyond this patchset, but maybe we can at
least make the `next*` operations avoid that.

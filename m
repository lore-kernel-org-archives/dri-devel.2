Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32A1C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0653710E2FD;
	Thu, 27 Aug 2026 14:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cl2ZpavB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F24210E2FD
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3Q6hFRVXoH9wlXR8xwKxuH3ieoFBpssJ9uGpZUAylj4K7lbbAX7COLKk8LQxnU8z9TbiTd5i8Jote5vpTSsF+Np1b11ZbvMTtzvOKprGLj9q7+drJNfuYSU9csZjMixoehZ5sawqdEPzq08yT9vBUhnZFrG3SW78parLh9jl/veehXTJs6d5PBh2atGca4jNGxYKNP5KJUXwG7VJYuamBOQc+tkwgqhlia8mh0VLBu7NsiBKOwwwrTIYZGCzLdyJg39dNcdOyIZTc4b9Db8agJjUfGh7kXsVgV/VxsBDTmTwyxNNZCsUVN9jZIsrJLwUz8xXUWTV+2IhMKGjREoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCoIC+eSfzhEO0deLCakBHwn1gUQWocOUStAOMLa5ck=;
 b=hrUMY1VwkgETTCZA5NBgaWHZZJgKDzCsIS7l40oKlccoPp9jkmeqvrb4peXaP4YGQA4ASJfm4qeybNaGx3GczacmqQ2Y09cSrrTfLeCd4MbheUxs3ES2oN5Hv1mU5nB2QrFhgG4fbPJhrx2dyb1W0X7XmhZsTdJLq6IguLbbQKdFHSp0b7mAn6LXNPvqAqAvwAcZ44zJZTS0Xvfp31b5Y7QYlRlcdZTQAWubFtltzAZMlwG6RbD9PI4SM/ywk+ElMq200L+c9O48olgBLcrEJ/pv8qEOnSAhAwztqTySXdNz2VcZ6EW3G0izhKis4dPTsTrwWFb3GhR2ZtxgemOsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCoIC+eSfzhEO0deLCakBHwn1gUQWocOUStAOMLa5ck=;
 b=cl2ZpavB7aenn7En237LtS/qXbwO3X6vevMVwLM+cecoZqqYgL/a/YZMGO+/irJqX3rameaE3pMW3JKOj+2kYlAPvm8oliMGincn6hiwQW+q/jmcLBA0s9fjJ//dqnDwAwDbDcATmk7ne/JE7lNr8Nsc2tVKIJruz/uHxpQmzdXseBEsihlimedWNkTMyYDPVm6Wckj1DwFp2UmRNxgGPW/2NAAth5Bq4IiCQ8MKT3OfbTF8Vz+IkOU03lpQQir06NYymfoZOuSWk5bqFE0EJkzqZo0HzMfmo80esoAjXn/GK2TWpm5zQDubtatKLXoJqDnWZnqfdSICqhPUSjtu7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:22:48 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:22:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 0/8] gpu: nova-core: add NVKV codec
Date: Thu, 27 Aug 2026 23:12:49 +0900
Message-Id: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/21Qy47CMBD7lSrnTZVJ0zThxH+sOOQxhcC2ZZMSg
 VD/fdOC9oTmZMn22H6ShDFgIrvqSSLmkMI0FsC/KuJOZjwiDb5gwhmXTAGnVtAxXzKFBkzfOi4
 lOFLY14h9uG9O34cXTjd7Rjev8jcj4u+tvJhfNGJNQuqmYQjzrhJOWyNYx0Ch8miZ9NZJ0QBwa
 5zqBSvX63a1GjAls2UrUddkkre8AQ26lpoLISjQ6Yze7C8YR/ypp3j8qOuY5lCqQA2Ct591a5t
 TSPMUH9tMGbbw70W6/0UyUEatEt62qISV3X7MwQdTl4bksCzLH6fZHoxtAQAA
X-Change-ID: 20260812-b4-nvkv-131af5c2661c
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: 962d5573-09a8-45b7-9cfb-08df0446ab6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|10067099003|3023799007|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: iOeO3MUsyXrUtbiy4sqfBt0imDgITJzkNEWsieHKvkxqXc9ztOx+6ebuy8DvQfUXp+VS1ETZSIi5a+mAUNPY0/qj7Ck3u5q1I0sti4tdX1BU9ZDkmUrX0GUVj3rrGl2LQ00R+yRBOdfL2DIFIzhg7lizxRkJu3NcwfVwZ7DanxBD0r9deJsSfk0ZK2afRt8RuCrEUFDydWEUd1QR5/S6v8DK3sG0nUxTCm7iqBxAbyEXyiHKas5Rr5bD2vu4CMTR4Apj0Rz94EcEzT6tZqlB0qojXawujm7pzG/CeQSY46KOg4So8t2V3VTWUDvTm+71gOUucTLdTvtOLELdcZ655a1orxwL7AiDul43lBizbVAMFC/z00JrhVjMn42o480hgPL6FACavBn/a08B14nJCHZ018uWstz0lv6sHYi9XXxPyP7D5P2kIIyRTHGbZTuqN4609fWknJDVarIHCquVJ6jz4BJdgW/C3PK6y6SsXdpq8eqlJzZri0WskaGMdUJA6rvX0VV+2bn3lUFx4v1OHwqaattLqeQl4IOs2GxkosTLR/Qw7lx46IgK0q0JNJh2a9k4zuxFBvLDO2pBbJOTMRohwacRXSqKW8q3Y77gW1YtlRfik386ROMPKuZlBnlbsOQcxNpVQdyJSI4iZvKk31FG4NoYLMzTFpqycRQgq4jwMiKtvles9hOds9gH9uZ6BVN2/89TGuzWenk6MV/qxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(10067099003)(3023799007)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R04yZjlZNS9za1JmRDRQQ0I1UzZwOWJTb01SN3JWcnNrMW9vTDlJOHUreDBI?=
 =?utf-8?B?aXowekkwcHdGL0czb3hvNjhBOTZaWUJLUEVmNEgwNmlFZjhlTkg1ZDZwNlNW?=
 =?utf-8?B?YU5DMmpmWjJ4R1B1bFAvdTk3MmpYYnprc0grOTdweEpVeGE2YlN6TXd4bjNk?=
 =?utf-8?B?N3U3K0R5WVAreUo5YTN5UFF6aDRncHU0SHo4SHdvdmRQVWVkVlVvNlpRWEpR?=
 =?utf-8?B?bWpYVE1FK3hhUFBaY1BzTHo0WVBYczlwTFhjR2FGVC9NTTUyMVY5UWFsS3V4?=
 =?utf-8?B?NXhCa09XVzlJQmQ5R3RaNVhoRzFQRUN5YmFBNGVZaFloSE4xaTlZeTd5cHpa?=
 =?utf-8?B?R0JmMjNEQlVkRnBsQ0l5UDdkN0YyWVRZczg4TThBaldvMTRNMngzT0Fhcnhh?=
 =?utf-8?B?UWZXV2gvdW83MzdweXVMbTBZUHl5cjJkdDFUZk9aeVRzUnFES1RTOXNkUHZP?=
 =?utf-8?B?N0UzUGNCS0owSnBXUEFNYVhpTlhxR2Q4N0FxbWNKUUR6bjVJV24vSDFOMlQw?=
 =?utf-8?B?VCsxRGtjRXVHMWNYYURobDZpdnhRdVovc2hvNVBLcStKL0NLVnkxNW1pYUJh?=
 =?utf-8?B?dytVaG8yN0VteU84N0lGdXNWcUlwZmdGN2c1SGkzU2QxUzZxbk1QRTFJMmV0?=
 =?utf-8?B?a3ZmbVRHeTB5NFk4UnhIWERjSWV6ckxYditXSEEwa04wZ2EzajlnRGQxRnZp?=
 =?utf-8?B?TmNxYXdGbWVDdm96Ti82SnpjWG9jakxqcUdnOVl6aFNhZVpXTkE1M1BxR1c1?=
 =?utf-8?B?RTRMVFVZZHh2VWV6N3M5ZnlyVk5BZEd3TUwwdWo0bmxFQWlja0VzTUppWHhR?=
 =?utf-8?B?bUhMM3JlT09GaEJVY0RFRUNiMHlvRHJ4SEdnZU9aL05vb0JZRWdXWVNwT2JK?=
 =?utf-8?B?dFowMG9mU3NQUHkvdWtTQVZKWjc2TTBtWkJHM05QZUhUTzRQc1ZIYVRQUVQx?=
 =?utf-8?B?dE50ZlN4SVF6OXdRWUlrcDA4cnUyK2xiaWxRMVE2SHZBY3cwSWJZMjdHVEsr?=
 =?utf-8?B?WW5vbzFZNlFUWEw0amFLejNwM3ZDQ1lKMTZsWGI4ZFVwa3pYd29nT1BaNkF1?=
 =?utf-8?B?c0ZzRTZvbytvM1B6OUNNdFNGTXMrZTIveXVSSUp1VDdzeDM2M2RoaEJ2M1FP?=
 =?utf-8?B?TEhCT0JydzlQL2wzcEE5NFpua1dJREpjUU1nbzJqb1ZORkVkL0U3bXhOcW1D?=
 =?utf-8?B?MXRvRDEwbmQxdG81Q01xNzNMdm15Y0duUW5lOFRVUlpGSDdIeU14V3pNMU5B?=
 =?utf-8?B?S21zMG16SFFyZkRwTnVNLzdKeWRkR0NQa1FEYWgvTkZrQ1lYaFNkamRaR2Nq?=
 =?utf-8?B?WTd1SHlPQmtYazk0MEN3U2dFZmlCZFJITjRoL1A2Y2ZUMi9yVVp5Mkw1SVNy?=
 =?utf-8?B?c0dZLzF0ZEUrQi9uVXVkbFpSaFNoMnkybnEwV0Mzd1dvMyswdlRwQmRVRWd4?=
 =?utf-8?B?S0FtWEtJcUVnYWVsZ2paVlBwNllYQmlkRTU3RFZ1azNNM0tneEdQbGFEbWxz?=
 =?utf-8?B?SThJeUFSR1QvazVjN0FtYjJSM0NjQlYxZWR6U1EyektWa3I1WWlWV0FDNjR2?=
 =?utf-8?B?aC9ub1NXdnRtaUNEK29CK3A4WUJvRHhxajNiWEpZRGhrY2xFQW9GTmVmRjFn?=
 =?utf-8?B?WGRJSUZRYUJXbVFQVHJqOXJlQ2hJQWZxWlJKeVlxOUtWRFJqcSswUnUxUnBI?=
 =?utf-8?B?cnZHWGNrNmppS045UXlLbXdHM1pHdE4zbnpSaFpxOGxiUGpaZ3E3UE1YVEhj?=
 =?utf-8?B?ZGtrVERkZjZFdE5FY1JZbWRobDRlelNlM1IwdHR5ZGVjNGFKakdpRjVabXJx?=
 =?utf-8?B?bkJ6Z0doYTc5dGxtM05VaHF0cHZoeHZxaXJ0RU5iTkJnS2FaMGF2cnNaRWxw?=
 =?utf-8?B?WlpkeVh5TjFhWTdWMlM5QjI4WEZhM3o0UEVkbU9kWXJwSXg2QU50aGY1Rlpn?=
 =?utf-8?B?bldINzRvL1EyQVhoRlhuT1NBSUFhMUZhUmJFNEZsb3lqZ2N5ZmwxZktDV2Nj?=
 =?utf-8?B?OW1oazFLTy81WGlKM29PemRIeWd4V0ZqZlVvdHV0WHREc1JvTFIzTkM1b1hx?=
 =?utf-8?B?UXNVRlJ5YVNMUXlEUTlUeWcydUFCWTJ6dVgzblVjajlkMHhRTzZ5aE5zcWs2?=
 =?utf-8?B?eHA3UEtlR2MvSWtvSVNOVUgwS2JSdmhSWVVlL0VtOEc4TVpRMEY5S3RvQUVm?=
 =?utf-8?B?QlF2Q1NlSFVLanR2VDZVdTA0QXkwTVE2azBERWFDbXNEejI0VEswS21hbndl?=
 =?utf-8?B?VVc4WkcxalVoQUM3bU1YMGFrbFJDYXlCbTI3VEd4R0w1V2N3em9yWkFyT202?=
 =?utf-8?B?VjdPNm5OdC9WQW9TS3RBMjg3WDZpcEhaeTN4Y01UMVdVWDB5b2JoWk9ERmcw?=
 =?utf-8?Q?EBbNYyArUt6HviBp359kjLCtDNUWnhaSfoP5/G5nOAU4V?=
X-MS-Exchange-AntiSpam-MessageData-1: VepkpoV/nhfr/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962d5573-09a8-45b7-9cfb-08df0446ab6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:22:48.3697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONFxLUEp0EcVMq9E5md+BsS3tXj1hU/lXNnXovTU402ma+nfzLMjNP57nEwMIF3ZGECZKjU+yZo7yIN6QVyxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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

This series adds support for the NVKV wire format for communicating
with GSP.

Essentially, the format encodes a sequence of calls to some function
f(key, index, value), where value is a [u8], u32, u64, [u32], or a
[u64]. The key is a u16 and the index is a 12 bit integer. The
interpretation of these function calls is per GMCAPI (RPC interface
used in firmwares later than r570). Generally speaking, the function
calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
b"some gpu") naturally maps to storing a &str with the GPU name.

This series adds a general encoder and decoder that works with the
base formats used ([u8], u32, u64, [u32], or a [u64]) for encode and a
general `Schema` trait for decode. This could be used directly, but
since most messages are struct-like, it's more ergonomic to use some
typed helpers for this declarative use case. So this series adds two
simple macros for encode and decode of structs, plus some general
types and implementations that help with using these.

Future patches will wire this up through the command queue.

This is based on drm-rust-next.

---
Changes in v2:
- Tweak Schema trait to avoid materializing copies on the stack
- Move ArrayVec to alloc module (+add potentially useful methods) (Danilo)
- Add Vec::try_push_init (Danilo)
- Add sum error type for try_push_init, PushInitError
- Use Danilo's EncodedStream abstraction
- Add some stack space asserts (Danilo) - needs to skip on clippy tho
- Using zerocopy e.g. ref_from_prefix_with_elems requires updated zerocopy to
  avoid linking error, so added those as prereqs.
- Link to v1: https://patch.msgid.link/20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com

---
Eliot Courtney (8):
      rust: alloc: add Vec::try_push_init
      rust: alloc: add Vec::push_init
      rust: alloc: add ArrayVec
      gpu: nova-core: add NVKV encoder
      gpu: nova-core: add NVKV decoder
      gpu: nova-core: add NVKV typed encoding
      gpu: nova-core: add NVKV typed decoding
      gpu: nova-core: add NVKV GSP_INIT schemas

 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs | 350 +++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv.rs        | 197 ++++++++
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 741 +++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 388 ++++++++++++++++
 rust/kernel/alloc.rs                     |   3 +
 rust/kernel/alloc/arrayvec.rs            | 347 +++++++++++++++
 rust/kernel/alloc/kvec.rs                |  73 ++-
 rust/kernel/alloc/kvec/errors.rs         |  30 ++
 9 files changed, 2128 insertions(+), 2 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260812-b4-nvkv-131af5c2661c
prerequisite-message-id: 20260625231919.692444-1-ojeda@kernel.org
prerequisite-patch-id: 1387aaf8fd9dbfaf04e6e8d52c3b39fbd9ff9432
prerequisite-message-id: 20260709211311.142544-1-ojeda@kernel.org
prerequisite-patch-id: 75036fb19a16a9c89bcba34e233a4b6de4ae421e

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>


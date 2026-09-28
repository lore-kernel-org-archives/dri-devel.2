Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4246FC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08A210E8CF;
	Mon, 28 Sep 2026 08:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aq5m7+Lf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4367C10E8AB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afc2UNqwvNOtOphkrjzW4goEJxbnmQ9Oh9wadx4hnecFEl3FYM/x7XJc8AxDSqGHBtisMEc4s8t9cNazs4HQZWzqe/MTpPwZ5aEoeybA65vVJLGMoOqceUz0KNJu3k3mC00Gfzv6o+j0UwwiHB1pD6iB6UDtOoVGgSCIyP+55LGHdhh9ae73yEsNMs6zFSvIsaSwivY71nvISckjlzr73Yey5nFI/z8OXVx9TOcemLJ0+EnCuQiTOWDioOQ39re8gOFdtjS1DoBOJ2U2op3WUWebNOoaBgAeutFgp0Kff/hIt6wkrUPWFK71yKuuOk20TSTQnT8USzt4hoNsCHQqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP5tU+AeMMvYBIgLD30+HaqaFmOpHoPyYKB0S8MkCQ8=;
 b=ag6US0LG75zIoga43k2wti9OR9XbN80KV9sc5T/jlTGDE02/f10WZEERJmRw8RLY49ORhb4XmS9Hx9HU/bPDcnTKJFAV+0Mf/226UhnsXjK0Jia5u2KmfOjNt5J+eGrvKjR4b6F7lGjOfNHb4G/D6v3yEdQ/HtomzsuktQFXXuNASziIzyry8eVQWkYEooeyWwhGAbWTE/hpP9pFrXcAbbiF7NrJWoK9pvE9Vpik7+qfSRDk+q+OyH3xKyX2ENmIWAe4aGiAN/XzrXUQeX5/b2o+dpE58C+fJQk80sJ9e/+a8U/GOsp2frgZ0ut60DU2IS361Wp1hNyc6A7XL3nqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP5tU+AeMMvYBIgLD30+HaqaFmOpHoPyYKB0S8MkCQ8=;
 b=Aq5m7+LfODS+CceoQLqy9yMJk8l2gbFSJCb04dCP8NpbDIoRi+ZZnl5hZrK4pJ0tvmDo7/3lE2P7dr8V21JKM+r/DDN73TdrpqV0Nw7eGspRo6RZV3NE5DQEdyZux0TUlWS2T3QcuffBfVa3gziuiPFOzyDb/j8xN4R3eA0k9QftAv8hkKrGz+0ML79/o9vCig5O6FgFpLmiRchN6zD1FbHu5aJDMLuATEUtBwNrZ7uGZiRdzeDK8mSXJfXEdTXlq5imS4KL3JifDcoY2jvBBTPNTyd3hJovLEJFkHcPqXpagxo4eW0hTdNaqaCiYTCR2rbysWFCu/PegNsj4iWxuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:42:58 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:42:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 0/8] gpu: nova-core: add NVKV codec
Date: Mon, 28 Sep 2026 17:42:39 +0900
Message-Id: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNTQ7CIBhEr9KwFgO0UHTlPYyLAl8tGqlCSzRN7
 y6tf3U5k3nzBhTAWwhomw3IQ7TBti6FfJUh3VTuCNialBEjTBBJGVYFdvEcMc1pVXPNhKAapfX
 VQ23v89P+8MqhVyfQ3YS/Fx5ufVJ0v1ljQ9f6x+yPdGo/qvKrihQTrGRhFAdZKFHuXLTGVmvdX
 tB0EtkCZAuQJZAY2BiupeBS/4HjOD4BDVKX//8AAAA=
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
X-ClientProxiedBy: PAZP264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: f17b1698-506d-4229-607e-08df1d3c7f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: GN8UjX0b2+bfUgCHB2YzGR780TWdDqAe4eDln+Nrkv472SJt7ytg0xTq9iL1ottLPKhwirGELzuOy/Wh6/Z9u53DUTLSHdbz3uDjLAVUWegINND3kbOK2zQiv/quCvdj50YVdKT9JYP/UxO3Yu2J0i/zdc+ohO8w0+BgnQG8M2tzjzoNadc/FOK4F8Y8cLMjyryifZtTSxicuVhUY56BljNHVew7cv2Z2VKwQ2B9lxYYL99wQbXbemaNTUqhnhTjxe4Q96m81blx+hup3/aEF+rowmV9LTx/IJCjyOJbvcKHjlMxM0EsuLSMscBE444OaX9Phzr5iHrIFhUDI0s2QE6d5czllsfqs76xT89CoYP4pAIZSjtaT/ttXygimJedG+Bkj8GlsSEarWfqiOWvab+MWv2F7859KuNBoq1MW0UB0PpKTucJKJcqzurN9X5qZXC0Mkg77tNyM6e6nNNCBA+LwKB+Qq5MKDduX3a6BL5Y41MSo5rZXNdelUwm39fBxNviLtUUI3v+dc2cnoqtlX0E7Q1HybRCRQgPN0n6R0ZPWVl7Km1bigl+mcxPKK32vwbkUbcm3HTmEzsUPS6vZyeqj6jdtXWWSMEJPaa2VhGpOF2ZSi1GsAzoTUiXm65gKr+uS2uLPkWB2Q7Ai4xjuCzXh3aB/w92r+9yliHi5DS8tceVFl04L66P8kSrNQK04xJUG6mqqyE95SIAucmiNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJURTJ4NmR5eGlzc1dBTytWS1pqL3lFUGpjQ3ViMGpZUTBmZ3NhMHlIeUxK?=
 =?utf-8?B?ZUhuRHdzK3FDVk1iY3cxV084bjU2OCtpVGJXQnc4STBzVHhxaUdSOXZYY3p2?=
 =?utf-8?B?L1liekgxMmlxQjhyN3BHQUtrdlNCSFB2SzE4MHovbExzZFBYRlBGa0xaZ05z?=
 =?utf-8?B?dTdXSktoWjk2NVAyU1IwTmNSaDNHOU94VzZGbU9WRlhUTnFROVRYbXZkenJa?=
 =?utf-8?B?cWU1U0dtc1AzQ0NHVjlTZStnRXg4cTAxejk2UlVMbnV4UW1QVk5nK1kydHNE?=
 =?utf-8?B?dzdpamU2cFQwY2ppc2U2bFh6dE9DRjVtZDhva0xJWll0ZXJaUXByTHpUVTBz?=
 =?utf-8?B?aHFTRFBqWVl4R3BGY0lCR3FWbWJJWHJ6V0NCZVRpNHJYZ05HK1NyemtRdWV1?=
 =?utf-8?B?QWgzaFhGZ2NoZ3J0UzhOK2I5R2prYXg0T09Rd3VVbnp5blhkVGxWU3dGM1Rs?=
 =?utf-8?B?ZGNTRVoxSi9jVkZJSTNPQVUwZ1h6bUdJZ0lLOWZKSTZVSGFnT3VMWW16eUlR?=
 =?utf-8?B?MFlZNFg2eTZuOGUySTVuSnBGUHFIcCsvZlRxZXRtdjFObjJHU2dFWi9PTzVQ?=
 =?utf-8?B?NTJRd1RPY2tKdG9taUplU01FdzBWdTJMcE52T3hzM05aV3ZvbjFVRk9qVjJi?=
 =?utf-8?B?bGkveTY4dEFPNGU5SW1aV3dsWFFxT3puYmJMZEtZWm1id2hpd2NaNXdlaDhq?=
 =?utf-8?B?ZEdkaDFCeUljeUY4WVE4OFdyZFhZN0RON3pPYUNtby9wenRlRnNZRmltNGJp?=
 =?utf-8?B?Yzg0Y28rdkhSQ1l6a2ZoYTlxQnU4NDdqM0h6WVBpckpKdENJVEtGQUkvczQ1?=
 =?utf-8?B?ZFVKMzR4MXFabyttQXRXSWRIa1hRcnhhY2ljbDBObWc3NlNoenZ4Y3ZUWG9F?=
 =?utf-8?B?amt4am9jWTFzVHNMcmRZV0J3RXY5djBiQ29kK1A5Y2kxTzFoM2JjaitFeGsr?=
 =?utf-8?B?ajZIVEVtUldkOWlOSzFYK2cxQ1UxZzBNc2JhbDRPK3grSk1BNG9rYlYxQ2c2?=
 =?utf-8?B?UEQraTQ4N0pLbkN0UFVSMHN3MFpCU1R0aEVkQXNXWTJreWtwWjVqdHJuVlMz?=
 =?utf-8?B?bEQ4bjRFSGNVWWQrb1lDaWZpT3psdmgvOWUzTU5lVkIxTjhuQ0I1YXZtMkFL?=
 =?utf-8?B?ODFHcmJ0eVdaalRmQTR0S2dCYUJzVmU5c29CTjZUeDJpVVpGVzZpRUlBQWtt?=
 =?utf-8?B?eStlMnNiTlBVbWxpU09ySUlBa2I4UGJBZTJycjBOWDNHUG9ONDgrcnZrMDZN?=
 =?utf-8?B?bGpjRThOMEdDVFNnaVNRYkUwS1dTUTFwcEVUcFVvUENaYW1EeHQ2YmhxQnlm?=
 =?utf-8?B?cjEvak5yNkxpVWU1V2h3VzgxQmVibndHTjRwRnNweUZyS3dVOGhTbngwcnRH?=
 =?utf-8?B?NDZqSXcxZmhaTlNJNUJka1VrcDBIVjIxRGxpQkdqV2xNRW9UMzhvYXFiQW1s?=
 =?utf-8?B?YTVMODFSdFU4YTlCQXRXcTJrUEphQkUyTW1TWFVGN2lFWWpWaGdvalNzMTFJ?=
 =?utf-8?B?MUc5YW1tQ3I5MnRPSWU3Y2lrM3hRb2dyYmRkZmVCZUorQXpRYkV5Vlo3eG5x?=
 =?utf-8?B?NlZQZEdrZXVYSmh3UXQrekZLWjJDcHBoRCtmK1hKNlV4YjlaMERGT0hQZjk3?=
 =?utf-8?B?bTAyTFVCS2UrTCtjeEd4Wm8rQ1lZaG50ei9EdjZmWmxkUUlES25COVloYmRt?=
 =?utf-8?B?UnhCbmgrcjkwWlVtMDg0RTFkSWlrTWlPZXF2RFpVVml0dis4b0IyM2lFRG1u?=
 =?utf-8?B?TStlbXQ0UTFRdVYyRHBWMUkrZHEvQ2tsQ05wWnM3MzAzNmdwMWhaRFlBSkNC?=
 =?utf-8?B?N2xFMzlzMXVhRE45NzVSbVRXUDZhdHl4cXRORWJPTXZLNUNtdkNRNk90b3RO?=
 =?utf-8?B?VzA3WkhRais1YkFwcXFOTzcvSWxiZDVNV2xrWU9abzFPR3JROUV0QVlRYzVS?=
 =?utf-8?B?MENEaVo3RDVTSVdDdUhFV2gwMlVUSGc2K0FoQmdxTzdCbkM4UzBpTHFuNDlO?=
 =?utf-8?B?UXJkSUg1T3lWRHpObmlRVjlXZlFLWlBKYU5hT0VpNk5pak5JR0ZXSG00cVFk?=
 =?utf-8?B?bXpGeGxSVk1HSElmZGtFTFl5dEk5aUZYbEc0eXc0Nkw5aFUrYXlXU3pPOGcz?=
 =?utf-8?B?R3Y4WVhzK1JXNEhSQXV5S2xoZk51bFJpdXpMamVGOVpJbXNkU0VaVFFvdUVQ?=
 =?utf-8?B?Um5BZ09GWkVmdHUrZVM5cGFEbXdoNUErelQvejRaTGtjMWdEaS9KSUVDN0hj?=
 =?utf-8?B?OXplcm45YTV3ekZGSVFuUXJPdWlEWDBieTc0dFFKbFlkNFYwVjdqVXB4S05C?=
 =?utf-8?B?Sk9jbEpjejhBSlhYTTlPeXZZODF0Q3JiNDRqUEovYVpaZFZjdHNlaTJOMHFC?=
 =?utf-8?Q?P5Qg+xbXUdGRqpzX4rPprMity7i5QSg/iZATQfQc4fEIv?=
X-MS-Exchange-AntiSpam-MessageData-1: 1OcB7l5RC+yweA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17b1698-506d-4229-607e-08df1d3c7f52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:42:58.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zMPKr8X2YklQTpW/9M0N994QunoJua4ZdrZTDZTd+Bd4CuXJh4oEr0bz0yTLI0zZix6DTbnNRJWeYonSnGwdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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
Changes in v3:
- Rebase + drop zerocopy prereqs which are in now.
- Define Opcode with bounded_enum! (Alex)
- Use #[inline] instead of #[inline(always)] (Alex)
- Add Co-developed-by for Danilo on the encoder patch (EncodedStream)
- Split Schema into Schema (init/finish) and Visit<'data> (visit) to let
  schemas borrow from the encoded stream
- Support schemas that borrow from the stream in nvkv_decode!, e.g.
  struct NameSchema<'d> => Name<'d>
- Construct schemas only in place with a required Schema::init() and
  drop the Default impls + stack size asserts (Alex)
- Doc improvements (Alex)
- Add a TODO for the O(#fields) visit dispatch in nvkv_decode! (Alex)
- Replace the Key<Option<T>> special case with TryFrom<DecoderValue>
  for Option<T>
- Make Key's field and IndexedKey::new private (Alex)
- Move the nvkv_*! re-exports to GSP_INIT patch (Alex)
- Add decoder tests (Alex)
- Add error path tests (Alex)
- Add IndexedKey tests (Alex)
- Add RegKey tests (Alex)
- Link to v2: https://patch.msgid.link/20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com

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

 drivers/gpu/nova-core/gsp.rs             |    1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs |  447 +++++++++++-
 drivers/gpu/nova-core/gsp/nvkv.rs        |  183 +++++
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 1104 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs |  452 ++++++++++++
 rust/kernel/alloc.rs                     |    3 +
 rust/kernel/alloc/arrayvec.rs            |  347 ++++++++++
 rust/kernel/alloc/kvec.rs                |   73 +-
 rust/kernel/alloc/kvec/errors.rs         |   30 +
 9 files changed, 2637 insertions(+), 3 deletions(-)
---
base-commit: 66a2c223b620d844fe26c6bd4844d2a6a8c9dffc
change-id: 20260812-b4-nvkv-131af5c2661c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>


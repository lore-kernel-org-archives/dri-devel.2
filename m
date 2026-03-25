Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D4103A9A0
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346E310E163;
	Wed, 25 Mar 2026 02:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RblwkSh0";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EE810E163
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5+jhSNcdJ3+9GuM2ITDjtaD5Fo0BhQ5DfVI69W8dr54tWIoHF6eI67qcZ32C/iSVjU00Vo+SX+RnKtCfnqyT/RmZqUUQYm3DASFuoDVsh1pSfB+d5m/jd+/S0Mxqsjjo8BPw8t/1VzWkEXvsht1YuU1/q7ylClMfVZhKhIn72WvAq28WEoOZyHwwO2nZ3+OMhZafARq+GPPu0IgP8dLKFt1dyqlHxzoi5/e9g8cMDxi1KrV7oA2BOc7V4Deka1SqAAJlSwdRKxGM87QCFboINjStZl6UqUbVaQ1f7uek4eQCfkCyubWi31jaj3AquzoYQJkg4HdJn+B0iYZJDOk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCyzMHTuglVxHCUkiMo1jjtGWa/5XmDyWTSgmJXnY+w=;
 b=DyMN6cm/lzCt/3eTAfq+sBOqd/LE/GWUJgeYZStLgRVD9WsQtb6eiG/N8hK9nCyyMWWWyBTMsHE7rc2Gk6bdm9g4u+v/Ka/OtrjeaSyLqqUnJpLO1n02nf8h776+gIcLiblcLzKQwQy+5EyxZDXdW7i6BmAQoFsZ4iWg9ro4ThAOt+w9d1UN+43j8pg1focM5ZXvpO+FZryRU8Bd3OZNrr7MEhQ8vuwYWvjPCA2x1DKJLkxjWpqDidRKL1nnYkQAeReGK9CC5voybulg5oeTFl8fvDSFGCodjb8dlysTnVEbKOZV4zrQ5LKWMtu+jua8MNJvtUcfwL4QLmaudWTt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCyzMHTuglVxHCUkiMo1jjtGWa/5XmDyWTSgmJXnY+w=;
 b=RblwkSh0lFxEmAANPT0DD9YDlovzOaIyEHI5WaZv6jLHFh4re+TDzM1BJARM1Zx4zCSlQXxhBAU+qrZdztWOCiJyrJFH///rTAlhtyRmZrpwqQ/KrceM1/ixturfCtwhxbQoh3nR4RQnEtL7uuMDjfqrhUfFU/UZeAFNpNnImik2yVNk+vbo9E37juSO0mykfIr5WH05HlRvoaqr2zj8FziJZlwfWZ+KDPXU9Dp7WRk3lR0bZ3HilOzuHGggOGKyKnzDfXt+ghswAWgclqPaekDIbE0Upt+HN6XcKzWeG7wjQSE6u9Fw/vAqxc6Y/3tY3FIcpvI9lC0rzM5n6Hjtjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 00/10] gpu: nova-core: convert registers to use the
 kernel register macro
Date: Wed, 25 Mar 2026 11:46:13 +0900
Message-Id: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ7CIAyA4VdZOIuBwgh68j2MB8bKxkEwYIhm2
 bvLdppx8fg37deJZEweMzk3E0lYfPYx1JCHhtjRhAGp72sTYKCY4Jp2koZYDE04+PzERNWJ6a7
 lXLctkHr2SOj8ayWvt9pjXYvpvX4ofJn+wQqnjAIY0WpjpFXiEorvvTnaeCeLVmAjANsRoApaO
 +s4E6h7+SOIrSB2BFEFgyC1QouOd1/CPM8f87jKPjUBAAA=
X-Change-ID: 20260318-b4-nova-register-6908b5118552
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 500ff0a9-b14f-4f16-7d81-08de8a18bb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2jkK8aEzi4O1us4+PDajwUF2t0E0N1Q4Gr9ZVQCZqPJRrLqtu4LEQciP7ZQEUA+zXvLjD9/SImVBcJ9k0/ulNFQefUfirP2LuVCY1LxVNw9Scr0LWo1SzJFsGnux8J2fWHnoexFQpy8t6DXl+nrJmNbzo6oDHjfwiFKENQlQv04L8EV292Ix5fch2eMReZw6sbsur/C/csxTXeguTMe+8tQAMY7ztM3xnjZo02QcpR3SuRRjnyPpWuFgeFPTMOJIM4EWJAZs6YbrV3BXYYHTaTFt4HlScn0wZvR/IFbTf/mE546v5kFZDR6Ph08M//coWKba3RUPVV0faOB1tsiEk3No25aHff/apquv0M8dHIrBFu5IXxJrEISNehmUL4lOCChBcJI9BBfIysbsuQH6ArW33ccib41WNazxFBGhBLiDVKReoZqyhfeFIiyyfY4OTblmmZf59f725Sw6m1Do7AhIPODXiVeT/xT4+P7GEUxODhRX9ZyDwmKViBK9Zqg7vM6nJ8hDaygnsXSjw2mSUFtiBFTQw7qWfbb5yasktzLPN15mR2RLdW4qe19WU+J/BHsfJPqf7EydsoeJ+hHnO68zmo00hw1aiGLSBgBDvJ3Y0u3VIz9cuX3oiE/RrpMRFkG30+wOQ3LEJob6+kU7VRCwF+Q1pNXvkhKUKIKtv3DEqyUMEVskYwi3L301Ukude6ITuHFnQ6b5PMTEFARjNyuZEQVlWXVceZeWmoO+q2ihOXqrhGm7EDP7QgTaQ8uW/fe0OS1M0OheS10bLxUxO4vp8Js4XlQxRpsZNCQiJH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxrQzNoSW5WM1BkZmdxazlFR0ZhUEFUUW1tRFd2Q1RDRXZxRkIwK2dWbGh0?=
 =?utf-8?B?Y3NRWmt4N1hNN2RIeGQ4eGNKZXNJbDVqZjYydXlCT2ZHdmpzWnV0M0diSitD?=
 =?utf-8?B?S1RrVWxEVG5QcFlqYWNGbnduMkh2YitXSG5JT29LbGR2OTdqMWhtaFdzQTEz?=
 =?utf-8?B?SWk3ZlBGZzhBWnlZQjhxNlVHcDNYV0w1WGpGcVdncUI5NUwyR3VidFdOL28r?=
 =?utf-8?B?cGtOc1BHTTlHV0l4YTlETlpYdkVsQ3htQ1lzQy9WU3FteldGT3NVc2lwRHQr?=
 =?utf-8?B?alEvamNOZEphMDdlazNKTlRKclJUMTJSc3JMNEdEL0lLaTN2SWc5T1RTd0pv?=
 =?utf-8?B?RWp1dWpxZjdlT0NyVnJvb3JEcHlzUVVvV2VnVHZlblB3U0FwNmpGWHZXMlIw?=
 =?utf-8?B?WUtldVo2L0RyM3lZS05MZG5ndktvQnQ4MXhpTU0vOFN0VEx0aDZTQnhrbXl5?=
 =?utf-8?B?dWZQZ2RZM0QvZWF2K2ZhMFJNTXkrRFlLdmpxdEFiNnU2YnhTYUx3U3VuNGd4?=
 =?utf-8?B?ZzdZL2J4am9iYzB1WlN4OWpsSldCT2xIZS9uU2pYTDNDck0xTHRRNHBMKzlE?=
 =?utf-8?B?eWxFeU9SUXZCQTFWanIrL2VjUldxdFVPU3E0Q3FiSENVc09MamxPY2h3bElI?=
 =?utf-8?B?emdRYnVPUlN6ME44WG9aTjhOMUtCUWZyTzZiYWQyWFlBY3h6U3BSVXZlK1RF?=
 =?utf-8?B?UjlvaDNZbHgyVjA3UzJ0VEtVc051TjdZMndZMmFCajJ6c0t1cVBRR25yY1FQ?=
 =?utf-8?B?cUZOYnhMUWF2TkFFMElSS1ZYck82aW96eElFMUl0dzFEbnNrRStoMTVJUEN0?=
 =?utf-8?B?aGd6eW9FVEhXUVNPZWZkdFluV3p0VHpBVXhUVTZpUjlzb2M4TW5kcWR3blhx?=
 =?utf-8?B?bk01R2NMYlNMbDdlRnV4TjljVXV4bFAwd0NuZWp6YURVNU5xUlh6MHF3NWZF?=
 =?utf-8?B?MEJoaDl3WFdjdW85Y1RBQjFuOTZoVjlndTZJUHJZMXhib3BuWDRHa3BQUG5G?=
 =?utf-8?B?Y0h5YzJxcEo3OXV3bVB0UDNsa0RxNU0vbGd5emY3UStvYUEvZUVlSmxQMHdL?=
 =?utf-8?B?cG5PQitHYzBoK1loOHJKa3VydnlteWpDb2w5c3cwdUh1cUdsZjNJTVBkTktl?=
 =?utf-8?B?TW5lL3NFbEF5ZDlYcFNkaEJ6YU1KTS9JOUZidlBsU3d4MlM2TWtTMmpLa2hY?=
 =?utf-8?B?VmNMejlpWU1FS2ZXZzgwK3psT1pZRmVVYmo2dzgzSGUvdk1aZ09RbkdSUUxP?=
 =?utf-8?B?eFYwWGkrQWVEU09wSkZKVjBucmhCMlVjSnp6UGRGblZ3T2h4QzErM0VxZzdk?=
 =?utf-8?B?bDFSYko0OStOeU5OMkd5Z2Vpd3puQXVDaFFjdXRpcjlscFpxam5wZWtoVjA1?=
 =?utf-8?B?RjBJN1ZHeFliRnl3WEpaUTBtNEwwZFpMaEhqaGhnRkY5RG5qMjd0LytCNmZ3?=
 =?utf-8?B?d0JyQkZGUWljcnhLZzU3WVRDTzJKU2E3N1dnZk1CNkx3SVRLalhGT0pVdTBv?=
 =?utf-8?B?KzZGUFc3cXAxZkVNb0J2cnpabHV3d20zWnBkNDcrTHdhcldMNlVJTFV4Y01t?=
 =?utf-8?B?eUs1T25DZDU0eDU3UmlVRzV6c3g5cmpucUZSYXBZNmJvUlJsc2FrWFZqbFRm?=
 =?utf-8?B?WWhBWUZSVlZoN2l1RDhiRmsvd2pqVG1TS1ZvSU4ySWx0UHR3bjBrbWdXQS9N?=
 =?utf-8?B?ZnVMemhsZUcrSDJOZ2ZSWVJkUWpZZzdYYlM2SWp1a2RSL3NIN2Zid0U4VURC?=
 =?utf-8?B?WitmdmQ0clVsS1BzZ04zbi8vU2MrL1ZKcVpUU2Z0dDRrZk9hZ1NvSFpCZHhN?=
 =?utf-8?B?YUFNVG9ZSld2YWlSSGtKNTFsTGF4eCs2M09mbklIZmRPZnlienF1QkhXSWxI?=
 =?utf-8?B?dzNvZTllK3ZUcTF3dkZ5Wm5tNkVXK1kwRGZueUxCWkZRcVF4WHVLY3NhVndS?=
 =?utf-8?B?Um93Y09sajUvcmVCNlZtZktjR1EzQkl5VTI1Z1g3L3N5TW40SUIxdTUzS3FC?=
 =?utf-8?B?ejI3anpNRml2ZG5CY3hwZTdCRTJqQ2RKRm9Eb0czbDBDMjlDUkpDS0xWL2tI?=
 =?utf-8?B?Q1ZNbHRtYmc0eHBTQ3JKdm13aTN2bEJxZHR2cmI2djBBenVzZ2dFc2FNeUJM?=
 =?utf-8?B?K3p6WWVnQ3Y3RWxaSy9GbzFLcFNmTndtdjBBNkYzUlRqdGtZSXcvUG1mbEdH?=
 =?utf-8?B?S3FyNTEwOUxzRWtWaFZvcUdyemNSQTBGbTQwekpMVFp6ZjAyWFNMeHQvQ3Qw?=
 =?utf-8?B?bUQwVGhPZG5xZ244bDJFNGdZNERnUThqT1RPaVJnYTBNU2RXa2kwSHg3dk91?=
 =?utf-8?B?eTBCOXM3a0ZucnpFZ1hscEF2bUU0WEZxa0VaSk14YU9vWERibnJkNkloOW5V?=
 =?utf-8?Q?EDTrkztY4hbb2L0cfbjOBjdroZyFgq2PcfwRE7wakSs2O?=
X-MS-Exchange-AntiSpam-MessageData-1: x5SlJ+liG6kL0Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500ff0a9-b14f-4f16-7d81-08de8a18bb4e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:36.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1YnQ3489fu6jqm8alGjnwu+yuGUyzd/Le08dDJ5BLvhGQrWI2FA23+29b83bct2cFgl0C0g/SZT9eEo6fFrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

nova-core carried its own helper macro to declare register types. Its
purpose was to be temporary since the beginning, and to serve as a
testbed to develop an equivalent that could be used kernel-wide.

That equivalent has now been merged, so it is time to retire the
nova-core local version.

The kernel register macro has evolved into something significantly
different from the one in nova-core, so it cannot be used as a drop-in
replacement. All declarations and sites using registers need to be
updated. No semantic change should happen as a result.

All the patches in this series could also be squashed into a single one
without altering their reviewability significantly.

I hope to be able to merge this quickly so we can rebase in-flight
series to use the updated register syntax.

This series is based on drm-rust-next as of 2026-03-25 and has been
tested on Turing.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Fix incorrect squash of `bounded_enum` code into the wrong patch.
- Move `bounded_enum` macro to `num` module and use it to generate
  `Architecture.`
- Link to v3: https://patch.msgid.link/20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com

Changes in v3:
- Remove obsolete part of PMC commit message.
- Add { } brackets around const expression used in `Bounded`
  constructor.
- Use `MAX..` arm to `bounded_enum` to catch missing values in the
  required range of the `From` implementation. (thanks Gary!)
- Remove unneeded const asserts that are already caught by `Bounded::new`.
- Link to v2: https://patch.msgid.link/20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com

Changes in v2:
- Reorder register fields in descending order.
- Drop `nv_reg` macro and use the kernel `register` macro directly.
- Make `FUSE_UCODE1_VERSION` registers return a u16 directly.
- Use `into_raw` instead of accessing the inner value of registers directly.
- Use safer macro to generate the `From` and `TryFrom` implementations
  of falcon enum types.
- Link to v1: https://patch.msgid.link/20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com

---
Alexandre Courbot (10):
      gpu: nova-core: introduce `bounded_enum` macro
      gpu: nova-core: convert PMC registers to kernel register macro
      gpu: nova-core: convert PBUS registers to kernel register macro
      gpu: nova-core: convert PFB registers to kernel register macro
      gpu: nova-core: convert GC6 registers to kernel register macro
      gpu: nova-core: convert FUSE registers to kernel register macro
      gpu: nova-core: convert PDISP registers to kernel register macro
      gpu: nova-core: convert falcon registers to kernel register macro
      gpu: nova-core: remove `io::` qualifier to register macro invocations
      Documentation: nova: remove register abstraction task

 Documentation/gpu/nova/core/todo.rst               |  76 ---
 drivers/gpu/nova-core/falcon.rs                    | 524 ++++++---------
 drivers/gpu/nova-core/falcon/gsp.rs                |  27 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  70 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
 drivers/gpu/nova-core/fb.rs                        |   6 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |  37 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |   7 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |  17 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
 drivers/gpu/nova-core/gfw.rs                       |  11 +-
 drivers/gpu/nova-core/gpu.rs                       |  53 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  11 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   9 +-
 drivers/gpu/nova-core/nova_core.rs                 |   1 +
 drivers/gpu/nova-core/num.rs                       |  80 +++
 drivers/gpu/nova-core/regs.rs                      | 601 +++++++++--------
 drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------------
 19 files changed, 779 insertions(+), 1538 deletions(-)
---
base-commit: dff8302ca1d0e773c90dbeeb05e759f995c95482
change-id: 20260318-b4-nova-register-6908b5118552

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>


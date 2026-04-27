Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45D2FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED84610E1E6;
	Mon, 27 Apr 2026 06:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/Q15RqE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC47310E1E6
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1PM0NbzqvzQ5KMJsmCv0IbUX59pldTHg4rALUZrThlkiLetcG1GtLYd4LOF6EjW7LVHWtH0h/OaIDCsRAidzlY8v35NFzkT5/skDmv9N4W07oFvQOwu5wnYybPoUGTXXYisy8s7ZabmbkQTto/n8SrNkMwavTlexhUMWD/UIxcoo8Ci9XFUEpjSBAePh5buAhGkCDV0gGK6bGjURTLacQLqhxm/fzNLFiWIny5DbwBoA4pWEm//Ve5dZaKD3wchETdkYnnDk/TqjSWAYZAqWK2k3Uum40VGRQhLR3G3M6PydDo5WVVVNHABFtbqeHlXesTYiYtZ4ve+UMnRhashvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFG1/2Ww94Pub4UfUYiW7xvhwEelb4evdLVpQHIjlcQ=;
 b=qz/2CAY6Ivxq3xqHZEuiaUYQxQY5bEscLKfdgZchYMVQujHgGNaJHrclpK+m0QaCt47UcQnuzN10RctuHt6+3/3EbgMLmJX6KK4NAfHgQnap2/Jyt+yngd6dUSTWBh6XnCRPKZYbX5EqJTJIHZWMPYgy53PwSuM9qX76qcmIfJeFybseJmbeU2rWuZl6tixjyB8aK0qr81/qT7dx1vdLC1tgM+MPNxeik/tdn+lUMuC9nWWDI9I+IHLdoHZnRvTeSw7x8q2zUWV6H+nDvkiHN5kVmZjz8hMoI8ZxWfXvkzs1F0HlmP8z7HkLk6fwDeGiXGXHTLAJ24pAV9W83hlvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFG1/2Ww94Pub4UfUYiW7xvhwEelb4evdLVpQHIjlcQ=;
 b=H/Q15RqEMIp2XNCDxlPcC+Lj4iYBCDvIakvrzVQ1Q4ULb5cssypshU6LacltvtmyWbwsfdDDB+sAUvCAzCqLtDwqaKVtUkHgxEU7iC+bjtjgIfu+IPtZihbbG9saELBdIqfYB0o4t9yAxc9zUSWAGMDNW6jbVzbIt5O0gKDeWDUeyPQeY5w5Wzwo/WAsRnPVpk7oabpoqq2hxK/DBaPgPUGXmht3BVPqkz2YQzgftVfNyBtVh6uqc/+2B4WuRipMzJeA9dhzIHIK+8IDGndIR435I00YmDqn/DRDYAAJp7wvBSV8nd/dbwo9+9eiNn2mxl4XrEp+cJO0rEc/krZ0Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 0/8] gpu: nova-core: run unload sequence upon unbinding
Date: Mon, 27 Apr 2026 15:56:57 +0900
Message-Id: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NSwrCMBSF4a2UjI0kNw9bR+5DHORVG9BEEg1K6
 d5NC4JFh+fC998RZZe8y2jfjCi54rOPoQ6+aZAZVDg77G3dCAgIClTiEIvCj3CJymJOoNNM72Q
 nCKrillzvn0vteKp78Pke02uJFzpf/3cKxQRLJWwLTDva2UMo3nq1NfGK5lCBD5aEA11jqBh6J
 3gnmepb/YPZN4Y1ZhVTC6al2jLj1p+naXoDFFBdHiEBAAA=
X-Change-ID: 20251216-nova-unload-4029b3b76950
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 742b413b-79f0-421e-1649-08dea42a3065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|18096099003;
X-Microsoft-Antispam-Message-Info: hxQS2HrTLKXuFkzIvoes24pUH7KfPfM62Gi/9iuN9X2nYucnjVH8h7FZo/4F4oPq34UI6ZC/Za7hg8AjpVIVQqWgiyPGKw3FFSO/8WQ4zqqAY1ATTlDipwE4T6xMpawA6GM6yKuhycc/OighL7JdGfkZyURkNhVSzsrcr/IQGTYP2q0EUd92v4WSyVt78WaM2ITOg0jkFv9qatQXy7owU3vR59GIpc1nFlK5QFW5ifSBrXIvwKie2s0SEZU/T6vfsfT9a11EIiAnOlTM9fD8GwzKQmhzGAZm76S4CjIGlXhlopYa01buJxJVCcxBXE/EZLvJXvNcu7IVkzp+G+acVvIJIreeWIwaCSzYhTqOhMxDo+bJLFEXfRtMWkKNgeW/xloko11RYu4+rniqsKSRm2mkBw0uo7WB7+AFd3ekkNy9PPs8kBiYW93YGjGdiUUeA+eZ6c7u7cqWnmwomgiril7bjZlds3QBi4qWxzdEqqGT4WpLb68iq40i7O05p4F9HWNd5AlvnvyrkaoVIhan5vQ0/iQi4fIufsVlHzdQQnmjfEs/26Dx3PeppzrHcWoT7ql54R4FkHn0UNMalJKVC0+jglfLE/qc/Q2AIwbhXBiWa4VBRG7xZHwkHBnqjXBpeaBofD37+dop1lvjZHCn+IHtz8GUm69sntlRVmwLitcanRaoLLleInfmuj72+MB5K6TZUOGen3I929f1HcU7n7CdjeXK2HBX6BCEqhp3lCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUgvaGUrdXVTNzZTRVJrS3BmR3Y0VEdCaDJMNHVjeTc3SHllWXZOVEFOdTBK?=
 =?utf-8?B?V3hKaEJFUlgzd3luRDNhVHJ3c3NMQ1hLYndNejVEWTVza0Y4THRkSzlzUWdF?=
 =?utf-8?B?UWUvaVJBejhhVEhYbTZ6eloydEt2WmhwcG5XV1YxaWtsc0N2VnZhS1VJeTEv?=
 =?utf-8?B?VDg3Mlg4WWNFL1QxKzdRY3pYWU1VcTRIcGNKSWE1bi84UTl2c1lDV0xBSDZn?=
 =?utf-8?B?YmdDQXdmdGRuWTZ2T1EwSTBRWnBDNjE3b2k5RW9PUkkyVUNEcXZtR3duVXJw?=
 =?utf-8?B?SytDNWd3aS83WEtyc3l2ZHlyQUVuMll1NDlVUlk1NVZDc0kxL1krSE9kditJ?=
 =?utf-8?B?ajB0OUdFR093U25HaVhRM3I5dDRpVHlpdlVaVkRsMm5FT09PRDJQakdIN0cr?=
 =?utf-8?B?ZHJJSnkwQUZKNFh0NktrK0wyYUJHVWlrekozSGZNQ3RodGpoQ09XSGNVUStD?=
 =?utf-8?B?azQwQUR4WVJkR3B6Y0ttZUhabXRIOHZKM3FLREtKeElJWGw1a2N3L25tQkRE?=
 =?utf-8?B?R3d2MDNMN1NzeFBRNWhvWGhMYm5zeGNvRmRLdGNYdlRGS3hDRTdlS2xOTlRT?=
 =?utf-8?B?VTdkSGFuR1V6d05qc3hBVnYwNlo1RVc5Q2twT0tpMGs4RXpTZTNjcmlQUkNT?=
 =?utf-8?B?djRBWFloL1JlVWVNVGNNRlBTeWlINkZzTWFFM3I3REVOaVlROHArZ1BXTWVv?=
 =?utf-8?B?WkxSMWRYUlZpZWpLcUg5Y1ZZN0EzTUhIaXREbU1DeHJ1NmZHK01ueFlvbUxD?=
 =?utf-8?B?eEQxcnJCVVI4czFUaHFnVFdzU21WdWlOMzVsK014b3NPNFpiejB4RVVBMW9J?=
 =?utf-8?B?SC9yRE82Qlp3T0tvOEYxUkhiaTAyQzB4YndRcWN2MVJKWVF4TjZZT093OGty?=
 =?utf-8?B?RUY1ZlFjaTQyZWkwSFVnVzNiLzdlM0IwZk96MENyZi82bTFqbXcvK1BjckRE?=
 =?utf-8?B?TGtOc1ZrakFSVXZ6NUJnZGlSRFBCbkZSOXBVY1JTQVlxWE1mTEZWNFZwVStl?=
 =?utf-8?B?UW01NlZPbnRVMFlqdWgzbWtONnhDTVVIVFBFVit3VTNPTlNVcUVDbjNSUHIx?=
 =?utf-8?B?S3dVZkxKbFc2WTVOY1V5bUlXQXcvbGJaVW1RZGFqa3lUYWorWmVVSDZaejB3?=
 =?utf-8?B?MENIL3YzUllYVWNERjk2cjdjZ3Rvd25raFVYZVRydWlRUWk1cms2M1plTWJn?=
 =?utf-8?B?U0lmaTBtRW1Dc2VxbGMxbFZhZ1BUMHRHY3B1RW1tWEwzMk9zdjYrbVEyUDVJ?=
 =?utf-8?B?OUt6M0J2TkNTOWV1eWxEMktHQ3hueTYvT1ZuM3Q0ODJGbnA4YUFoeWZlRHds?=
 =?utf-8?B?VmpVb1pMRVZJU1FxK2FpNE1yQlltYWYzSXNKZ2g3bDJEc1VKdDVqL3FhV0lT?=
 =?utf-8?B?MHdJWU96dThqMkpYZEtta1F4OVJrMlNrdlNlNndLZTBtNjgrTTEzOG5TNnl2?=
 =?utf-8?B?eWRJT2hnVVJtVE03YWRVeUd2WU5xeFdxc1o3UDNpRndXRmRMbHZhWEZTaHhU?=
 =?utf-8?B?ZjdjdmtCZDZEREhXRGpjRzNxYTBrVjRCVU5KRTNBd0wvZXlXUWQ0bENzU3VV?=
 =?utf-8?B?cGN5WHBYemt5OCsyWkxqdjd1SmtQWXFuOFJXTU9nQUlaVEM2SHNoZzhqQjFv?=
 =?utf-8?B?eE1pV0NvZEtQNGhYR1JEVjhvaHpBWlBpSHdHY2JQSEM1TklVSmRKRjREYzMw?=
 =?utf-8?B?NFo5cFBrV0pLeldFbVFxdS9qOWFzcXUvWktGTC96ejRaUDNHcnFaOGppbzRI?=
 =?utf-8?B?RGJha0M5WXFJTG51QmxvVHJpRGJZVk9ERU1DODVoTWx5WGtRbGluT2Vpalc1?=
 =?utf-8?B?QU9RRGFLNGdCM3c3R04rOXcvc0JtODhHcmp4RTVPUENzWlg2QXZJMzNITFh2?=
 =?utf-8?B?WGxSRHFzTUxRUytnSm1BMGN0U1U5aXlBRUFJRjlKcTVSZW9PcDhNZThKWDlm?=
 =?utf-8?B?TmVmL09ZTVNNc0ZrOU5JMkN3UkxMTDNhVXM5N2ZQS3VTSDV6NXdHMEQ3cGZ5?=
 =?utf-8?B?QmZPemJ4RnJ2clFBZ0dUOTh4V3NmZVVwVkpidDBBSVkxZDRxa2MvYnF3US9o?=
 =?utf-8?B?UmxCYVcwYVFid3VNR3l5Tm5VVEZOaUgyMWI0UDZiSVMvNTF0TXBmYXpOTEo2?=
 =?utf-8?B?U2llWm9tUXJnZy9uRkpHN2I4ZXlVU1Q4M1lYS285NW5pNzNBdWZ3ZjUvNHNZ?=
 =?utf-8?B?cHh1bk41a3Z4bE02c0JQUWpodm9PZitTWm9LZmNCZzMzT1pQeUVXdzFwQWxQ?=
 =?utf-8?B?UkJ4M3pQQ3Rhc01aelF3aDFsQThKMm1YZHc2aVBLVXExNDdNOFJMeXJnSmNv?=
 =?utf-8?B?dlIxWkdMSDlSNjRkOTZ4OG1ETmhmaHRBUzlFcExPang4dmlWdDZsamIwRWp2?=
 =?utf-8?Q?+JjATGX0AKrUqPXzAHzZC9ZwPjNj1aOHoI9xNbRXSBaF7?=
X-MS-Exchange-AntiSpam-MessageData-1: 4POJbyArmJF4uA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742b413b-79f0-421e-1649-08dea42a3065
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:04.2820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzUJ8Wkj/Y9cIJQHe3QHUFaakbBJ3kh0eShDjRDR/Zh8xbTLRvvMTbB6KOlixsCIvCoiVhndd3MDMbaJy3rUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

Currently the GSP is left running and the WPR2 memory region untouched
when the driver is unbound. This is obviously not ideal for at least two
reasons:

- Probing requires setting up the WPR2 region, which cannot be done if
  there is already one in place. Hence the current requirement to reset
  the GPU (using e.g. `echo 1 >/sys/bus/pci/devices/.../reset`) before
  the driver can be probed again after removal.
- The running GSP may still attempt to access shared memory regions
  which the kernel might recycle.

On top of that, there is a nasty bug in the Blackwell VBIOS that
sometimes borks the GPU upon PCI reset, requiring a reboot. So relying
on the PCI reset to unload/reload Nova is really not practical here.

This series does what is needed to leave the GPU in a clean state after
unbind, for all currently supported GPUs. Blackwell support is trivial
and will be added alongside the Blackwell series [1] if this can be
merged first.

On top of addressing the feedback received on v3, this revision is a
considerable rework. The `warn_on_err` convenience macro looks like it
will require a bit more work, so it has been dropped as it brought a
very small improvement anyway.

Since this series touches the GSP boot code, which will also be changed
further by the Blackwell series [1], I have decided to proactively split
said boot code into a HAL. This will be helpful to avoid having the two
boot methods in the same Rust module and discriminated only by
conditionals; but this is also useful for this series in order to
abstract the unload bundle.

Indeed, as Sachiko correctly pointed out we cannot guarantee filesystem
access when the driver detaches. So this revision now prepares all the
firmware needed for unloading at load time and saves it into an unload
bundle that is executed when the driver unbinds.

The GSP HAL work might look a bit premature, but it will be fully
exploited by the Blackwell series and doing it now spares us the need to
move things around in it by putting everything in the right place from
the get-go.

This series is based on `drm-rust-next` with the GA100 support series
[2] and first patches of the Blackwell series [1] applied. A branch with
the series and its required dependencies is available at [3].

[1] https://lore.kernel.org/all/20260411024953.473149-1-jhubbard@nvidia.com/
[2] https://lore.kernel.org/all/20260417191359.1307434-1-ttabi@nvidia.com/
[3] https://github.com/Gnurou/linux/tree/b4/nova-unload

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v4:
- Remove `warn_on_err` macro as it isn't performing as expected and
  distracts from the goal of the series.
- Add John's patch from the Blackwell series refactoring the Booter
  Loader runner code.
- Add a GSP HAL and move the existing TU102/SEC2 boot sequence into it
  in preparation for the Hopper/Blackwell FSP boot path.
- Prepare the firmware required for unloading at probe time and save it
  into an unload bundle, as we cannot guarantee filesystem access at
  unload time.
- Constrain `UNLOADING_GUEST_DRIVER`'s visibility to the parent module.
- Also write the sentinel value `0xff` into `mbox1` when running Booter
  Unloader to align with OpenRM.
- Link to v3: https://patch.msgid.link/20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com

Changes in v3:
- Disambiguate doccomment for `warn_on_err`.
- Test the correct bit instead of the whole register value to determine
  that the GSP has stopped.
- Use an enum instead of a boolean to encode the power level when
  shutting down the GSP.
- Add missing newline to `dev_err`.
- Add missing doccomments for new types.
- Use values from bindings instead of magic numbers.
- Remove the redundant `get_gsp_info` function.
- Better document Booter Unloader mailbox sentinel value, and check the
  value of mbox0 upon return.
- Link to v2: https://patch.msgid.link/20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com

Changes in v2:
- Rebase on top of `master` and remove unneeded/obsolete preparatory patches.
- Tidy up the imports of commands from the `fw` module in the `gsp` module.
- Link to v1: https://patch.msgid.link/20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com

---
Alexandre Courbot (7):
      gpu: nova-core: remove unneeded get_gsp_info proxy function
      gpu: nova-core: do not import firmware commands into GSP command module
      gpu: nova-core: split BAR acquisition in unbind()
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloading
      gpu: nova-core: gsp: shuffle boot code a bit to keep chipset-specific parts close
      gpu: nova-core: gsp: move chipset-specific parts of the boot process into a HAL
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding

John Hubbard (1):
      gpu: nova-core: refactor SEC2 booter loading into BooterFirmware::run()

 drivers/gpu/nova-core/firmware/booter.rs          |  31 +-
 drivers/gpu/nova-core/firmware/fwsec.rs           |   1 -
 drivers/gpu/nova-core/gpu.rs                      |  21 +-
 drivers/gpu/nova-core/gsp.rs                      |   4 +
 drivers/gpu/nova-core/gsp/boot.rs                 | 252 +++++-----------
 drivers/gpu/nova-core/gsp/commands.rs             |  71 +++--
 drivers/gpu/nova-core/gsp/fw.rs                   |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  44 +++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  11 +
 drivers/gpu/nova-core/gsp/hal.rs                  |  92 ++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs            |  52 ++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs            | 351 ++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs                     |   5 +
 13 files changed, 741 insertions(+), 198 deletions(-)
---
base-commit: 1affa624811b93a2df098c1d141a33c7c134d43f
change-id: 20251216-nova-unload-4029b3b76950

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>


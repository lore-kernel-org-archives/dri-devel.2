Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45345FCD0A7
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403D610E726;
	Wed, 18 Mar 2026 04:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggOT627i";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4243D10E726
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWWtUBoWl5t1Z2G5DGRDHTQSCwNiSP6Hcrv5qbCRVMJcEFRAn+W3/oPKt5Lq0bdS18Ubl6TzmHJKwtTgkCU6oaUfMvoWa9jvuYceml8Hy4nQs72b/Oxv8dI7OYVVpK/lJHj+Ude2Q49me2A7PGmRnZssnk+b/Zwm1UHylwBFDTSuWrhjCl4b4KmJhgDWJCpBKK51RQId/BvDfeLP/TwAZfGleDvjKpIPxECZYydscYp47nBJqGb+h8Jg0oODJs+uN40f1I2q1WOCC08VGk5H4c0E9I0useOfmTFG6UvCBLdY1vdL0jkwjEIpd4IusJcLH1nSI9M7UrfEtt9jscq/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdiOg+tZrZ4vFwx7taAMOzVAsiJ5h2mKGs2NmcsJgOQ=;
 b=anTvNwx9HQA6lSewXTxVykzS2bl46VbM2v6bRKM/ydjf9l675onfTObp6FOTrAke6txpWoY+xpSB0dIie3tP92bsMSec3nknYtJXpqMqRxudMm2M5WXAfye8jK7etBgDdT2BcWAdIAYMbKPlxP6VsRUA2Hy4S/MWnVtqJSKJL8Cn9k/OPqhIP/0QDPZ2WJHFlUQ/lj5YELm8tqkk9OOB2s8NA3gMUCn3jK9StmUJiRJTwPzoc+RMVKdx/q9bBYrmjwYnk8l2oXUnRW9JVAAO2fZ3Xqm1XnYpLZ06tGKBAlMY+CqRfKdNv8j2rJ57hrsbzokzBb1C7oDkB0Gr36Z+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdiOg+tZrZ4vFwx7taAMOzVAsiJ5h2mKGs2NmcsJgOQ=;
 b=ggOT627iazSG9BgJf1p6KHNfaoqbchFhCmGisQocXVFe6ZlHOCqjed2kPksr7UzqNgvcK3fyvPWG71FZJvv6yApNbzS2OU71ZRcz0eLH2bj/gXK2hvNIsgyzDnJPGm1Y3SnWVND6JfhtO6na0patbJ3J0DQhiC6BD+w8xvkfm90P36NOINonrjB36mK4+UGDNANMicHOaAWTboDKMlW+wBVmjYXsm52sb6BuUzQYjcZR7QgD2t0e+PwJYZTbvKZDM80RkTfvKkUzfSeSL/51TBfcyQQLqKY8BWe9Z3uIt0VxbUcHdukJlXUf58FN3tqLpcIIDLJefSjGjnusfUi8Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 04:07:34 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 04:07:34 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 0/5] gpu: nova-core: gsp: add locking to Cmdq
Date: Wed, 18 Mar 2026 13:07:08 +0900
Message-Id: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Ou27DMAwF0F8xNFeFRFEPZ+p/FBn0oBOhtZ3Yj
 tEi8L9XcYamTgcOl8C55JWNNGQa2a66soHmPOa+K0G/VCwefXcgnlPJDAQYAaB5bNOZf/bxI3c
 HnhTU4DxEiA0r5DRQk7/Wuvf9PQ90vpTW6b5kwY/EY9+2edpVSdY+IDhjPdloXCCHlGptbyMh2
 Fqhtapht65jHqd++F4/neVa9v9Ts+SCh9CYgFIbK8xbN+eU/Ws5uzbN8KjNRkPR0ZI03iTtnH7
 S6lcrgRutivZGSQxWFCyeND5oKTYai0bSEa1WEYX7o5dl+QHQkoHirwEAAA==
X-Change-ID: 20260225-cmdq-locking-d32928a2c2cf
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0097.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 560fb277-78a8-4719-9c1f-08de84a3e1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: qu4hkNC7KJ335qfR0AGwRlKZ56ocyNqwfrt4FhWw4mA2m/rAgVKxI9198dhmYH1Xdkwy+RkKQJqOn1sMMqHjbB/XCzrrHsjX63wRtJUmZA32Pap4LEob6/Icr4x0j8MvdcwR5CIE253vMZou6vvGbjPS6i4xmkLomnZayRi8NXrpl1cVtpEEUpLDJKJRosnN0lH2GzdrThrkH++4HrRi3kTHrYfhIpY/Zenp72tu/vsyybMpQnpiMnmyX6O/8XyOQipLGqT+fFWuqWuAJF1f+8cqLc3Zn8JVfBa8WQ6O1ubVZyuF3f1oxMuc3jPFoL8aX7fYGWx4tCQ00JVz2MurMHP7Fu9RrxN/tAGmuPKhJ/jEGFAh5hX+RoT+/vLE4acYEjhmL9PfSJxJwlQGab8vcexe3pJH0A7Wslz0gtYST9KXP35yUGtIt1M6P0sumBXzeW+L5ozE+e+cTtNle/fBjS4/xvMTj5WqlwjtTV11pxib8fJyKUIE9ruwiLow5vukBGNjlgyDNdxpiN7S8OduLb3beTP8nCei+VvkUdgbkoULjimKXDm5SW1lxvPTls62wlmGFszwpcG9FWUFDEc1RUv6wIiNRSruMgoqHuG70dc6uibI3lsduEjVdDP5w/DEqdXMGnbFXoY0Yaf8G++fZ1mW4i2pBhlNGAvkGU0Mxp9mpP9c0I802zvi79DQVM8kjsazZaB4Upmlu8HSU8jV69MJa30T6xEaRj4c31NNUQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFnM0pFbnEzejRVdFBWNmI3NUpDT1NuRmRyRkVEeTBPWmNoa2dwNy9yS2pZ?=
 =?utf-8?B?TjBVcWFWZVpldEk0eDVwVWVxaWNGY3lQV0ZhWXlUWVVHb0tKZmV5Vm9kajR0?=
 =?utf-8?B?cGNlOXUyYTlFK3RpcEx6eTcrS0tiNlM4Nmx6TVcvWXI4NmM5eGtxYjZVOXd3?=
 =?utf-8?B?b2hOWlllYTFxUWgzOXNCUS80ZUhScXAzNm5KdUhpTmNmUDVvc2dhOURkZnB5?=
 =?utf-8?B?NXc0bGNlY0EyZHFQUWJ6Q0EvRXppbkhzeGZ6N00xUUYrdjZ2OUlTb1lHRVIz?=
 =?utf-8?B?RlZoQ0dJNG1HMDBwVW5DbVI1STFrOVV2TmFWYTZXbkZjVzh6R01sank3d1J5?=
 =?utf-8?B?N1MvZnFweHo3MHdhNy9uL2hiMzdnbFJnemdlTy93c215MmNILzUrUEIxWDB3?=
 =?utf-8?B?dmdKZXhRd3hTR205dTg2SW9idHdMR203R2g3VTR5eGp5Wm5iY21HRWdxMzNR?=
 =?utf-8?B?TUpUaDBDclJsOVV2NHRDL0FUeTZDcUF6V1RNVG0vN1craGJkRTZOVGwvWStQ?=
 =?utf-8?B?QUFGTFJzNytraU1vVTRGblhTaUk1anRKWGpDempCTkIzYlM0dWZ6akNNeXpt?=
 =?utf-8?B?MGhSZ2Y5aGxVTkt3NXFjNTlzYjkwT1luMFhwY1VJQkxZNmFsaXF3d21HVUtu?=
 =?utf-8?B?R2M2bnpYYmRXV1JzRWFnbnJzbm96dHQxQ3Nmd0d6UUdOdUF1TTJxNFloMU1S?=
 =?utf-8?B?WmNjamE1ZUxDQXVvMU9jdDMvQ0RqSVhGcW9scjJYNW1zTEFoVFcyOVFHTG9p?=
 =?utf-8?B?ZE1USFlsK2t6aE9nOWFDdjYycWhnUjd2ald5Y09YU28zaGNSWlJFYlV4eTM2?=
 =?utf-8?B?OThNK1Myak45UGFIYVNyd3NhZkJvRkJVN2xkTFVFSWU4Slp5TExSWEFrTVlI?=
 =?utf-8?B?WFoyRWd2MG1DZzBCUWs3R0hJbk1xTG5wR0l4ZmhhUEUydW13bThxWVM2R0Fo?=
 =?utf-8?B?VmJkeWJBb1dVai8wYi9qM3pqbWovekVYTTBmckliMkFzcEk4OUg0OFR0QWsw?=
 =?utf-8?B?SGZZWnVZVnAycU1tR3ZOaG4wWHd4ckRFV0ZwSzVOS1BUeHVOaFRzcERRQzUx?=
 =?utf-8?B?UE4rOWkwMEg3ZDVUNnRFNC9yZlIwMUdvRU5tOHJYaVZyMHE0R1prTkx5UERs?=
 =?utf-8?B?UFpnb2ovelM2ZHhwNmdBTUtFdDk0N1NBWmlsOUJjRlYybm5xRkFRRXJNbTVM?=
 =?utf-8?B?VFpCa2huK08xUVloYTI0d3VlVnRldzV2SktiVTJ4V0ZkM1hSVXZhcFlpdzll?=
 =?utf-8?B?dXZTRkNhSzZMYVEzVlJtcFhXa1E1dFpSS3hmYkg3YjRyTUJCaTlINlhaVEVN?=
 =?utf-8?B?b1FWZDdjbDFKL1kwZTNQN1BXd2YzeDlBdUpXYTJwZDFLRnBYcm5DWVVwQWZw?=
 =?utf-8?B?cWdzcW04Y3lqQUZaZk1aVVJtdXVNREJvQ2l1TU1qYkp2ekFybkJMcnZ1aklh?=
 =?utf-8?B?ZEZ0VnFYNzJhQTRtY2h2cEhka0NMN21rOVA0SEsrVlRtNFRVUndZczNXcGhH?=
 =?utf-8?B?QUlnZ283dHNneG81cGRjZ25xQll0T1VITzV1SCtFc2M0UE00dStTajQwTGla?=
 =?utf-8?B?dmxFbUpyOGVzMHkxK2pZbXRHV1pHTmd4K2U4c2JWaWtFSmxyVGIrd1hoanpT?=
 =?utf-8?B?ZFNTWnBIbDFDVHo3YUlnd3JlTkNER1pCNlQ4SUhIMmtxL2laaTJ1Ky9Sd2Fn?=
 =?utf-8?B?KzVaVUYzQlIrTUZzU2w5MG12S2pmVTd5ZjVyRjdzakU2OFpCNk1wSGZ5aTR0?=
 =?utf-8?B?WkdLYTdicUV3UVJ0ekY4aTVueXpHVE9vU2E2ZWdTVk5VOFlRR1Q3YytCeDQy?=
 =?utf-8?B?dGlPWVNLZ1VwNTVRbFNXVTFEdGowSnI3SHQ2czRBNHY1Si9pTHNKdTJ6V2li?=
 =?utf-8?B?U2Q1ckRVTlRHQit3Sm93MndrZ2h3T1BRbzdSWGRrRGJ5Tk1Ca2lhS1dkWGsz?=
 =?utf-8?B?U2tUMzg5QTgzVFR5b1RUYmt5cDBmMkIxV1JETnpic05KZlQ5VU5NK29tMmpV?=
 =?utf-8?B?SXhDVmsrbWtBcjZpakRJVGNrV2ZmeTA2UzJpdTh4bDZSOXlHSGY2SC9VQWp0?=
 =?utf-8?B?eHRYSHl1QnFpZytUMkZoaUFDVVlidGRaMnc1ZTZCWmJaNG9qUUJXV1VxSkJr?=
 =?utf-8?B?UVdSZVA5YitNUjFkNmtsQlJCMzFsM0pnUHc1Q2VGaFFtUTZDNmRMb2UwRVhO?=
 =?utf-8?B?bC96VS9ycSs4SFR0TUYrRDVrbjlYT3RydUdDOWd5bjRINnMwVkN3QlVLSVNQ?=
 =?utf-8?B?YWNBRGQ1YnNSdUNiNHRuY0x4SldFM2VHTkZPUENwUFc4RVNpN2ZhSGFpbVg4?=
 =?utf-8?B?aXpDTUJVbHFzRUExUFVaWXhvY1lGTFVmMGs2Y3VERGRxSDFabzB6Tlk1WFNw?=
 =?utf-8?Q?XrFf3EavM1usaNvdv9So0e2HL2j5M9TOT2B5p5sJwbq3z?=
X-MS-Exchange-AntiSpam-MessageData-1: 1SODRW+SdEGLpw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fb277-78a8-4719-9c1f-08de84a3e1ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:07:33.9612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i21f8V1mQZJPH7cIExLHdbZaAQ/XZ/Z4Acyk/lJpqCo5LyY6SxD7DVwYIwWUggkt6ge9KmjQLqpFneXliI96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

Add locking to Cmdq. This is required e.g. for unloading the driver,
which needs to send the UnloadingGuestDriver via the command queue
on unbind which may be on a different thread.

We have commands that need a reply and commands that don't. For
commands with a reply we want to make sure that they don't get
the reply of a different command back. The approach this patch series
takes is by making those commands block until they get a response. For
now this should be ok, and we expect GSP to be fast anyway.

To do this, we need to know which commands expect a reply and which
don't. John's existing series[1] adds IS_ASYNC which solves part of the
problem, but we need to know a bit more. So instead, add an
associated type called Reply which tells us what the reply is.

An alternative would be to define traits inheriting CommandToGsp, e.g.
CommandWithReply and CommandWithoutReply, instead of using the
associated type. I implemented the associated type version because it
feels more compositional rather than inherity so seemed a bit better
to me. But both of these approaches work and are fine, IMO.

In summary, this patch series has three steps:
1. Add the type infrastructure to know what replies are expected for a
   command and update each caller to explicitly wait for the reply or
   not.
2. Make Cmdq pinned so we can use Mutex
3. Add a Mutex to protect Cmdq by moving the relevant state to an
   inner struct.

[1]: https://lore.kernel.org/all/20260211000451.192109-1-jhubbard@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v5:
- tweak documentation
- rebase on drm-rust-next
- Link to v4: https://lore.kernel.org/r/20260310-cmdq-locking-v4-0-4e5c4753c408@nvidia.com

Changes in v4:
- Change RECEIVE_TIMEOUT from 10s to 5s
- Update NoReply doc comment
- Move CommandToGsp doc comment update
- Fix import formatting in continuation.rs
- Move CmdqInner after Cmdq to reduce diff size
- Link to v3: https://lore.kernel.org/r/20260304-cmdq-locking-v3-0-a6314b708850@nvidia.com

Changes in v3:
- Rename send_sync_command/send_async_command to
  send_command/send_command_no_wait.
- Move `dev` field into `CmdqInner` to avoid passing it through method
  parameters.
- Add `RECEIVE_TIMEOUT` constant for the 10s receive timeout.
- Link to v2: https://lore.kernel.org/r/20260226-cmdq-locking-v2-0-c7e16a6d5885@nvidia.com

Changes in v2:
- Rebase on drm-rust-next
- Link to v1: https://lore.kernel.org/r/20260225-cmdq-locking-v1-0-bbf6b4156706@nvidia.com

---
Eliot Courtney (5):
      gpu: nova-core: gsp: fix stale doc comments on command queue methods
      gpu: nova-core: gsp: add `RECEIVE_TIMEOUT` constant for command queue
      gpu: nova-core: gsp: add reply/no-reply info to `CommandToGsp`
      gpu: nova-core: gsp: make `Cmdq` a pinned type
      gpu: nova-core: gsp: add mutex locking to Cmdq

 drivers/gpu/nova-core/gsp.rs                   |   5 +-
 drivers/gpu/nova-core/gsp/boot.rs              |  13 +-
 drivers/gpu/nova-core/gsp/cmdq.rs              | 159 +++++++++++++++++++------
 drivers/gpu/nova-core/gsp/cmdq/continuation.rs |   8 +-
 drivers/gpu/nova-core/gsp/commands.rs          |  23 ++--
 drivers/gpu/nova-core/gsp/sequencer.rs         |   4 +-
 6 files changed, 151 insertions(+), 61 deletions(-)
---
base-commit: d19ab42867ae7c68be84ed957d95712b7934773f
change-id: 20260225-cmdq-locking-d32928a2c2cf

Best regards,
-- 
Eliot Courtney <ecourtney@nvidia.com>

